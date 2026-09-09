"""FULL decode of npccache.wdb records (SMSG_NPC_TEXT_UPDATE payloads, build 12340)
into a lossless, npc_text-shaped TSV that maps 1:1 to AzerothCore's npc_text table.

This WIDENS the output of wdb_decode_npctext.py: instead of block-0's prob/lang plus
each block's first string, it emits ALL 8 gossip blocks in full (both strings, language,
probability, and all 6 emote u32 per block). The binary layout is UNCHANGED and already
validates at 100% exact-consumption; we only widen what is written.

Payload layout (textID/entry is in the record header, NOT repeated in the payload):
    8 x block, each:
        f32  Probability
        cstr Text_0          # male/default
        cstr Text_1          # female
        u32  Language
        (u32 EmoteDelay, u32 EmoteId) x 3     # 6 u32 in wire order:
                                              # EmoteDelay0,EmoteId0,EmoteDelay1,EmoteId1,EmoteDelay2,EmoteId2

Self-validating (the itemcache oracle): each record's payload length is known from the
WDB record walk, so a correct field layout consumes EXACTLY that many bytes. We tally
exact/leftover/overrun per record; ~100% exact == the binary layout is proven.

Output columns (89 total = 1 + 8*11), in EXACTLY this order so it maps straight to npc_text:
    entry,
    then for b in 0..7:
        text{b}_0, text{b}_1, BroadcastTextID{b}, lang{b}, Probability{b},
        em{b}_0, em{b}_1, em{b}_2, em{b}_3, em{b}_4, em{b}_5
    BroadcastTextID{b} is NOT in the query response -> always 0 (a real npc_text column
    that stays 0).

Unions every distinct (by sha256) non-empty npccache across all realms/modes, dedup by
entry (keep first snapshot).  Native python can't see /c/... -> C:/... paths only.
"""
import os, sys, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

SCAN = [config.EXTRACT] + config.EXTRA_SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/npctext_full.tsv"
OUT_REP = config.WORK + "/decoded/npctext_full_report.md"
TARGET = "npccache.wdb"
NBLOCK = 8
NEMOTE = 3
NEMOTE_U32 = NEMOTE * 2  # 6 emote u32 per block

# Column order (must stay exactly this so it maps 1:1 to npc_text).
COLS = ["entry"]
for b in range(NBLOCK):
    COLS += [f"text{b}_0", f"text{b}_1", f"BroadcastTextID{b}", f"lang{b}", f"Probability{b}"]
    COLS += [f"em{b}_{k}" for k in range(NEMOTE_U32)]

def sanitize(s):
    return s.replace("\t", " ").replace("\r", " ").replace("\n", " ").replace("\\", "/")

class Cur:
    __slots__ = ("b", "o", "n")
    def __init__(self, b): self.b = b; self.o = 0; self.n = len(b)
    def u32(self):
        v = struct.unpack_from("<I", self.b, self.o)[0]; self.o += 4; return v
    def f32(self):
        v = struct.unpack_from("<f", self.b, self.o)[0]; self.o += 4; return v
    def cstr(self):
        e = self.b.find(b"\x00", self.o)
        if e < 0: e = self.n
        s = self.b[self.o:e]; self.o = e + 1
        return wdblib.decode_str(s)

def decode_npctext(entry, payload):
    """Return (row_dict, consumed_bytes). row_dict holds all 89 columns."""
    c = Cur(payload)
    row = {"entry": entry}
    for b in range(NBLOCK):
        prob = c.f32()
        t0 = sanitize(c.cstr())
        t1 = sanitize(c.cstr())
        lang = c.u32()
        emotes = [c.u32() for _ in range(NEMOTE_U32)]  # wire order, flat
        row[f"text{b}_0"] = t0
        row[f"text{b}_1"] = t1
        row[f"BroadcastTextID{b}"] = 0            # not in the response; real column, stays 0
        row[f"lang{b}"] = lang
        # keep as a clean float; round tames float32->double noise (0.3f -> 0.3, not 0.30000001)
        row[f"Probability{b}"] = round(prob, 6)
        for k in range(NEMOTE_U32):
            row[f"em{b}_{k}"] = emotes[k]
    return row, c.o

def iter_caches():
    seen = set()
    for root in SCAN:
        if not os.path.isdir(root): continue
        for dp, _dn, fs in os.walk(root):
            for fn in fs:
                if fn.lower() != TARGET: continue
                p = os.path.join(dp, fn)
                with open(p, "rb") as f:
                    data = f.read()
                if len(data) <= wdblib.HEADER_LEN:   # empty stub, no records
                    continue
                h = hashlib.sha256(data).hexdigest()
                if h in seen: continue
                seen.add(h)
                yield p.replace("\\", "/"), data

def is_multiblock(row):
    """True if any block index >= 1 carries a non-empty gossip string."""
    for b in range(1, NBLOCK):
        if row[f"text{b}_0"] or row[f"text{b}_1"]:
            return True
    return False

def main():
    os.makedirs(os.path.dirname(OUT_TSV), exist_ok=True)
    union = {}
    per_file = []
    exact = leftover = overrun = 0
    gaps = {}
    for path, b in iter_caches():
        cnt = 0; new = 0; recs = 0
        for entry, size, payload in wdblib.iter_records(b):
            recs += 1
            try:
                row, consumed = decode_npctext(entry, payload)
            except Exception:
                overrun += 1; continue
            delta = consumed - size
            if   delta == 0: exact += 1
            elif delta <  0: leftover += 1; gaps[delta] = gaps.get(delta, 0) + 1
            else:            overrun += 1;  gaps[delta] = gaps.get(delta, 0) + 1
            cnt += 1
            if entry not in union:
                union[entry] = row; new += 1
        rel = path.split("AscensionArchive/")[-1]
        if cnt > 0:
            per_file.append((rel, cnt, new, path))

    # write TSV
    with open(OUT_TSV, "w", encoding="utf-8", newline="") as w:
        w.write("\t".join(COLS) + "\n")
        for e in sorted(union):
            r = union[e]
            w.write("\t".join(str(r[c]) for c in COLS) + "\n")

    # stats
    total = exact + leftover + overrun
    pct = 100 * exact / max(1, total)
    multi = sum(1 for e in union if is_multiblock(union[e]))
    prob0_zero = sum(1 for e in union if union[e]["Probability0"] == 0.0)
    spot = sorted(union)[:2]

    L = []
    L.append("# WDB npccache FULL decode -> npc_text (lossless, all 8 gossip blocks)\n")
    L.append(f"Distinct non-empty npccaches decoded: {len(per_file)}\n")
    L.append(f"**Union of unique npc_text entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append("Payload per block (8 blocks): "
             "`f32 Probability; cstr Text_0; cstr Text_1; u32 Language; (u32 Delay, u32 Emote) x3`")
    L.append("(entry/textID is in the record header, not the payload)\n")
    L.append(f"- records parsed        : {total:,}")
    L.append(f"- exact match           : {exact:,}  ({pct:.2f}%)")
    L.append(f"- leftover (short parse): {leftover:,}  ({100*leftover/max(1,total):.2f}%)")
    L.append(f"- overrun (BAD layout)  : {overrun:,}  ({100*overrun/max(1,total):.2f}%)")
    if gaps:
        L.append(f"- consumed-minus-size deltas (should be empty if 100%): {dict(sorted(gaps.items()))}")
    L.append("")
    L.append("## Gossip shape")
    L.append(f"- entries with a non-empty block >= 1 (multi-block gossip): {multi:,}")
    L.append(f"- entries with Probability0 == 0.0 (a lone line needs nonzero prob to display): {prob0_zero:,}")
    L.append("")
    if spot:
        L.append("## Spot-check (entry, Probability0, first 60 chars of text0_0)")
        for e in spot:
            r = union[e]
            L.append(f"- entry {e}: Probability0={r['Probability0']}  "
                     f"text0_0[:60]='{r['text0_0'][:60]}'")
        L.append("")
    L.append("## Per-file contribution (records / new-to-union)")
    for rel, cnt, new, path in sorted(per_file, key=lambda x: -x[1]):
        L.append(f"- {cnt:5,} recs, {new:5,} new  {rel}")
    with open(OUT_REP, "w", encoding="utf-8") as f:
        f.write("\n".join(L) + "\n")

    print(f"NPCTEXT-FULL union={len(union)} exact={exact} leftover={leftover} "
          f"overrun={overrun} pct={pct:.2f}")
    print(f"  multi-block={multi}  prob0_zero={prob0_zero}  cols={len(COLS)}")
    if gaps:
        print("  deltas:", dict(sorted(gaps.items())))
    for e in spot:
        r = union[e]
        print(f"  spot {e}: Probability0={r['Probability0']} text0_0[:60]='{r['text0_0'][:60]}'")
    print("->", OUT_TSV)
    print("->", OUT_REP)

if __name__ == "__main__":
    main()
