"""Decode raw gameobjectcache.wdb records (SMSG_GAMEOBJECT_QUERY_RESPONSE payloads,
build 12340) into a gameobject_template-shaped TSV for the LOCAL preservation archive.

Self-validating (same oracle as wdb_decode_items.py): each record's payload length is
known from the WDB record walk, so a correct field layout consumes EXACTLY that many
bytes. We tally exact/leftover/overrun per record; ~100% exact == the layout is proven.

Payload layout (build 12340, verified via the consumed==size oracle below):
    u32 type
    u32 displayId
    cstr Name[0], Name[1], Name[2], Name[3]
    cstr IconName
    cstr castBarCaption
    cstr unk1
    u32 data[24]
    f32 size
    u32 questItems[TAIL_QUESTITEMS]   <- trailing region tuned by the oracle

Unions every distinct (by sha256) non-empty gameobjectcache across all realms/modes,
dedup by entry (all snapshots of one entry are identical; keep first).
Native python can't see /c/... -> C:/... paths only. NON-DESTRUCTIVE, filesystem-only.
"""
import os, sys, math, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

# SCAN_ROOTS, not EXTRA_SCAN_ROOTS: the latter omits _inbox, so a bare .wdb dropped
# straight in there was ledgered by intake and then silently skipped at decode time.
SCAN = [config.EXTRACT] + config.SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/gameobject.tsv"
OUT_REP = config.WORK + "/decoded/gameobject_report.md"

# number of trailing quest-item u32s after `size`; 6 is the TrinityCore/AzerothCore
# MAX_GAMEOBJECT_QUEST_ITEMS for 3.3.5a. Tuned against the oracle below.
TAIL_QUESTITEMS = 6

DATA_N = 24
# The quest items were already being read to prove the byte count, then dropped.
# They are the loot a gameobject hands out for a quest, which is exactly the kind
# of link a rebuilt world DB needs, so they are kept now.
COLS = (["entry", "type", "displayId", "name", "IconName", "castBarCaption", "unk1",
         "size"] + [f"Data{i}" for i in range(DATA_N)]
        + [f"questItem{i + 1}" for i in range(TAIL_QUESTITEMS)])


def sanitize(s):
    return s.replace("\t", " ").replace("\r", " ").replace("\n", " ").replace("\\", "/")


def fnum(v):
    """Format a float for the TSV: integral values stay integral, the rest get a
    fixed number of decimals. Deterministic, so an unchanged re-run diffs clean."""
    if not math.isfinite(v):
        return "0"
    if v == int(v):
        return str(int(v))
    return f"{v:.6f}".rstrip("0").rstrip(".")


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


def decode_go(entry, payload, tail=TAIL_QUESTITEMS):
    # WDB record body starts at `type`; `entry` is the record header, not in payload.
    c = Cur(payload)
    d = {k: 0 for k in COLS}
    d["entry"] = entry
    d["type"] = c.u32()
    d["displayId"] = c.u32()
    name0 = c.cstr(); c.cstr(); c.cstr(); c.cstr()   # Name[4]
    d["name"] = sanitize(name0)
    d["IconName"] = sanitize(c.cstr())
    d["castBarCaption"] = sanitize(c.cstr())
    d["unk1"] = sanitize(c.cstr())
    for i in range(DATA_N):
        d[f"Data{i}"] = c.u32()
    # `size` is the object's render scale and it is genuinely fractional -- 0.63 for
    # a Deeprun Rat Trap, 1.5 for a large chest. It was being round()ed to an int,
    # which flattened 12,114 of 13,828 objects to exactly 1 and 721 more to 0 (a
    # zero-scale object is invisible). gameobject_template.size is a float column;
    # give it the float.
    d["size"] = fnum(c.f32())
    for i in range(tail):
        v = c.u32()                                  # questItems
        # `tail` is a tuning knob the oracle sweeps, so it can exceed the number of
        # columns; read every slot to keep the byte count honest, store what fits.
        if i < TAIL_QUESTITEMS:
            d[f"questItem{i + 1}"] = v
    return d, c.o


def iter_gocaches():
    seen = set()
    for root in SCAN:
        if not os.path.isdir(root):
            continue
        for dp, _dn, fs in os.walk(root):
            for fn in fs:
                if fn.lower() != "gameobjectcache.wdb":
                    continue
                p = os.path.join(dp, fn)
                b = open(p, "rb").read()
                h = hashlib.sha256(b).hexdigest()
                if h in seen:
                    continue
                seen.add(h)
                yield p.replace("\\", "/"), b


def main():
    os.makedirs(os.path.dirname(OUT_TSV), exist_ok=True)
    union = {}
    per_file = []          # (label, records, new, path, nonempty)
    exact = leftover = overrun = 0
    gap_hist = {}          # (size-consumed) -> count for leftover records

    for path, b in iter_gocaches():
        info = wdblib.inspect(path)
        cnt = 0; new = 0
        if info.standard and info.records:
            for entry, size, payload in wdblib.iter_records(b):
                try:
                    row, consumed = decode_go(entry, payload)
                except Exception:
                    overrun += 1
                    cnt += 1
                    continue
                if consumed == size:
                    exact += 1
                elif consumed < size:
                    leftover += 1
                    gap_hist[size - consumed] = gap_hist.get(size - consumed, 0) + 1
                else:
                    overrun += 1
                    gap_hist[size - consumed] = gap_hist.get(size - consumed, 0) + 1
                cnt += 1
                if entry not in union:
                    union[entry] = row; new += 1
        per_file.append((os.path.basename(os.path.dirname(path)) or "(root)",
                         cnt, new, path, info.records > 0))

    # write union TSV
    with open(OUT_TSV, "w", encoding="utf-8", newline="") as w:
        w.write("\t".join(COLS) + "\n")
        for e in sorted(union):
            r = union[e]
            w.write("\t".join(str(r[c]) for c in COLS) + "\n")

    total = exact + leftover + overrun
    lowest3 = sorted(union)[:3]

    L = []
    L.append("# WDB gameobjectcache decode — union across all realms/modes\n")
    nonempty = [pf for pf in per_file if pf[4]]
    L.append(f"Distinct non-empty gameobjectcaches decoded: {len(nonempty)} "
             f"(of {len(per_file)} distinct files by sha256)\n")
    L.append(f"**Union of unique gameobject entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append(f"- exact match            : {exact:,}  ({100*exact/max(1,total):.2f}%)")
    L.append(f"- leftover (short parse) : {leftover:,}  ({100*leftover/max(1,total):.2f}%)")
    L.append(f"- overrun (BAD layout)   : {overrun:,}  ({100*overrun/max(1,total):.2f}%)")
    L.append(f"- total records          : {total:,}")
    L.append(f"- TAIL_QUESTITEMS used   : {TAIL_QUESTITEMS}\n")
    if gap_hist:
        L.append("### gap histogram (size-consumed bytes -> #records)  [empty when 100% exact]")
        for g in sorted(gap_hist):
            L.append(f"- gap {g:+d} bytes : {gap_hist[g]:,}")
        L.append("")
    L.append("## Spot-check (lowest 3 entries)")
    for e in lowest3:
        r = union[e]
        L.append(f"- entry {e}: name='{r['name']}' type={r['type']} displayId={r['displayId']}")
    L.append("")
    L.append("## Per-file contribution (records / new-to-union)")
    for label, cnt, new, path, ne in sorted(per_file, key=lambda x: -x[1]):
        tag = "" if ne else "  [empty stub]"
        L.append(f"- {label:36} {cnt:6,} records, {new:6,} new{tag}")
        L.append(f"    {path}")
    open(OUT_REP, "w", encoding="utf-8").write("\n".join(L) + "\n")

    print(f"union={len(union)} exact={exact} leftover={leftover} overrun={overrun} "
          f"total={total} exact%={100*exact/max(1,total):.2f}")
    if gap_hist:
        print("gaps:", {g: gap_hist[g] for g in sorted(gap_hist)})
    for e in lowest3:
        r = union[e]
        print(f"  {e}: '{r['name']}' type={r['type']} disp={r['displayId']}")
    print("->", OUT_TSV)


if __name__ == "__main__":
    main()
