"""Decode raw pagetextcache.wdb records (SMSG_PAGE_TEXT_QUERY_RESPONSE payloads,
build 12340) into a page_text shape:  entry, NextPageId, Text.

Self-validating (the itemcache oracle): each record's payload length is known from
the WDB record walk, so a correct field layout consumes EXACTLY that many bytes. We
tally exact/leftover/overrun per record; ~100% exact == the binary layout is proven.

Payload layout (entry/pageID is in the record header, NOT repeated in the payload):
    cstr Text;
    u32  NextPageId;

Unions every distinct (by sha) non-empty pagetextcache across all realms/modes,
dedup by entry (keep first snapshot; conflicts are counted, not merged).
Native python can't see /c/... -> C:/... paths only.
"""
import os, sys, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

# SCAN_ROOTS, not EXTRA_SCAN_ROOTS: the latter omits _inbox, so a bare .wdb dropped
# straight in there was ledgered by intake and then silently skipped at decode time.
SCAN = [config.EXTRACT] + config.SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/pagetext.tsv"
OUT_REP = config.WORK + "/decoded/pagetext_report.md"
TARGET = "pagetextcache.wdb"
COLS = ["entry", "NextPageId", "Text"]   # Text last (can be long)

def sanitize(s):
    return s.replace("\t", " ").replace("\r", " ").replace("\n", " ").replace("\\", "/")

class Cur:
    __slots__ = ("b", "o", "n")
    def __init__(self, b): self.b = b; self.o = 0; self.n = len(b)
    def u32(self):
        v = struct.unpack_from("<I", self.b, self.o)[0]; self.o += 4; return v
    def cstr(self):
        e = self.b.find(b"\x00", self.o)
        if e < 0: e = self.n
        s = self.b[self.o:e]; self.o = e + 1
        return wdblib.decode_str(s)

def decode_pagetext(entry, payload):
    c = Cur(payload)
    text = c.cstr()
    nextpage = c.u32()
    return {"entry": entry, "NextPageId": nextpage, "Text": sanitize(text)}, c.o

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
    for path, b in iter_caches():
        cnt = 0; new = 0
        for entry, size, payload in wdblib.iter_records(b):
            try:
                row, consumed = decode_pagetext(entry, payload)
            except Exception:
                overrun += 1; continue
            if   consumed == size: exact += 1
            elif consumed <  size: leftover += 1
            else:                  overrun += 1
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
    L.append("# WDB pagetextcache decode -> page_text (union across all realms/modes)\n")
    L.append(f"Distinct non-empty pagetextcaches decoded: {len(per_file)}\n")
    L.append(f"**Union of unique page_text entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append("Payload layout: `cstr Text; u32 NextPageId;` (entry is in the record header)\n")
    L.append(f"- records parsed        : {total:,}")
    L.append(f"- exact match           : {exact:,}  ({pct:.2f}%)")
    L.append(f"- leftover (short parse): {leftover:,}")
    L.append(f"- overrun (BAD layout)  : {overrun:,}\n")
    spot = sorted(union)[:2]
    if spot:
        L.append("## Spot-check")
        for e in spot:
            r = union[e]
            L.append(f"- entry {e}: NextPageId={r['NextPageId']}  Text[:80]='{r['Text'][:80]}'")
        L.append("")
    L.append("## Per-file contribution (records / new-to-union)")
    for rel, cnt, new, path in sorted(per_file, key=lambda x: -x[1]):
        L.append(f"- {cnt:5,} recs, {new:5,} new  {rel}")
    open(OUT_REP, "w", encoding="utf-8").write("\n".join(L) + "\n")
    print(f"PAGETEXT union={len(union)} exact={exact} leftover={leftover} overrun={overrun} pct={pct:.2f}")
    for e in spot:
        print(f"  spot {e}: next={union[e]['NextPageId']} text='{union[e]['Text'][:80]}'")
    print("->", OUT_TSV)

if __name__ == "__main__":
    main()
