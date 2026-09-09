"""Decode raw npccache.wdb records (SMSG_NPC_TEXT_UPDATE payloads, build 12340) into a
npc_text (gossip) shape, preserving the gossip strings.

Self-validating (the itemcache oracle): each record's payload length is known from the
WDB record walk, so a correct field layout consumes EXACTLY that many bytes. We tally
exact/leftover/overrun per record; ~100% exact == the binary layout is proven. Because
there are 8 repeated blocks, a wrong per-block trailing-field count makes the
shortfall/overrun scale in multiples of 8.

Payload layout (textID/entry is in the record header, NOT repeated in the payload):
    8 x block, each:
        f32  Probability
        cstr Text_0          # male/default
        cstr Text_1          # female
        u32  Language
        (u32 EmoteDelay, u32 EmoteId) x 3     # 6 u32
  => per block: 4 + str + str + 4 + 24  fixed = 32 bytes + two string lengths.

Unions every distinct (by sha) non-empty npccache across all realms/modes, dedup by
entry (keep first snapshot; conflicts counted, not merged).
Native python can't see /c/... -> C:/... paths only.
"""
import os, sys, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

# SCAN_ROOTS, not EXTRA_SCAN_ROOTS: the latter omits _inbox, so a bare .wdb dropped
# straight in there was ledgered by intake and then silently skipped at decode time.
SCAN = [config.EXTRACT] + config.SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/npctext.tsv"
OUT_REP = config.WORK + "/decoded/npctext_report.md"
TARGET = "npccache.wdb"
NBLOCK = 8
NEMOTE = 3

# Readable flattening: block0 gets full detail; blocks 1..7 contribute their Text_0
# (the common case is that only block 0 carries real gossip; extra blocks are surfaced
# so nothing is lost).
COLS = (["entry", "prob0", "lang0"]
        + [f"text{i}_0" for i in range(NBLOCK)]   # first string of every block
        + ["text0_1"])                            # block0 second (female) string

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
    c = Cur(payload)
    blocks = []
    for _ in range(NBLOCK):
        prob = c.f32()
        t0 = sanitize(c.cstr())
        t1 = sanitize(c.cstr())
        lang = c.u32()
        emotes = [(c.u32(), c.u32()) for _ in range(NEMOTE)]
        blocks.append({"prob": prob, "t0": t0, "t1": t1, "lang": lang, "emotes": emotes})
    row = {"entry": entry, "prob0": round(blocks[0]["prob"], 4), "lang0": blocks[0]["lang"]}
    for i in range(NBLOCK):
        row[f"text{i}_0"] = blocks[i]["t0"]
    row["text0_1"] = blocks[0]["t1"]
    return row, c.o, blocks

def iter_caches():
    seen = set()
    for root in SCAN:
        if not os.path.isdir(root): continue
        for dp, _dn, fs in os.walk(root):
            for fn in fs:
                if fn.lower() != TARGET: continue
                p = os.path.join(dp, fn)
                data = open(p, "rb").read()
                h = hashlib.sha256(data).hexdigest()
                if h in seen: continue
                seen.add(h)
                yield p.replace("\\", "/"), data

def main():
    os.makedirs(os.path.dirname(OUT_TSV), exist_ok=True)
    union = {}
    per_file = []
    exact = leftover = overrun = 0
    gaps = {}   # (consumed-size) delta -> count, to expose a constant per-block gap
    for path, b in iter_caches():
        cnt = 0; new = 0
        for entry, size, payload in wdblib.iter_records(b):
            try:
                row, consumed, _blocks = decode_npctext(entry, payload)
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

    with open(OUT_TSV, "w", encoding="utf-8", newline="") as w:
        w.write("\t".join(COLS) + "\n")
        for e in sorted(union):
            r = union[e]
            w.write("\t".join(str(r[c]) for c in COLS) + "\n")

    total = exact + leftover + overrun
    pct = 100 * exact / max(1, total)
    L = []
    L.append("# WDB npccache decode -> npc_text gossip (union across all realms/modes)\n")
    L.append(f"Distinct non-empty npccaches decoded: {len(per_file)}\n")
    L.append(f"**Union of unique npc_text entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append("Payload layout per block (8 blocks): "
             "`f32 Probability; cstr Text_0; cstr Text_1; u32 Language; (u32 Delay, u32 Emote) x3`")
    L.append("(entry/textID is in the record header, not the payload)\n")
    L.append(f"- records parsed        : {total:,}")
    L.append(f"- exact match           : {exact:,}  ({pct:.2f}%)")
    L.append(f"- leftover (short parse): {leftover:,}")
    L.append(f"- overrun (BAD layout)  : {overrun:,}")
    if gaps:
        L.append(f"- consumed-minus-size deltas (should be empty if 100%): {dict(sorted(gaps.items()))}")
    L.append("")
    spot = sorted(union)[:2]
    if spot:
        L.append("## Spot-check")
        for e in spot:
            r = union[e]
            L.append(f"- entry {e}: prob0={r['prob0']} lang0={r['lang0']}  "
                     f"text0_0[:80]='{r['text0_0'][:80]}'")
        L.append("")
    L.append("## Per-file contribution (records / new-to-union)")
    for rel, cnt, new, path in sorted(per_file, key=lambda x: -x[1]):
        L.append(f"- {cnt:5,} recs, {new:5,} new  {rel}")
    open(OUT_REP, "w", encoding="utf-8").write("\n".join(L) + "\n")
    print(f"NPCTEXT union={len(union)} exact={exact} leftover={leftover} overrun={overrun} pct={pct:.2f}")
    if gaps:
        print("  deltas:", dict(sorted(gaps.items())))
    for e in spot:
        print(f"  spot {e}: prob0={union[e]['prob0']} lang0={union[e]['lang0']} text0_0='{union[e]['text0_0'][:80]}'")
    print("->", OUT_TSV)

if __name__ == "__main__":
    main()
