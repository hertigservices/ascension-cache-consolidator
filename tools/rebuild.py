"""Rebuild merged caches back into real, client-loadable .wdb files.

The decoded TSVs are for humans and databases; this is for the client.  For every
game mode we emit one .wdb per cache type containing the merged union of every
record that mode ever produced -- so a player drops in a cache that already knows
75,000 items instead of the ~40,000 any single submission held.

Header handling: the 24-byte header (magic, build, locale, recordSize, recordVersion,
cacheVersion) is copied VERBATIM from a real submitted file of that cache type, newest
first.  Those three trailing fields are client-version-sensitive and inventing them
risks the client rejecting or mis-reading the file, so we never synthesise them.

Records are written sorted by entry, then the 8-byte zero terminator the client
expects.  Sorted order is deterministic, so an unchanged store rebuilds byte-identical
and git sees no diff.

Every file written is re-parsed and compared payload-by-payload against what went in;
a mismatch is a hard failure, not a warning.
"""
import os, sys, struct, collections, time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, merge, export

OUT = export.OUT + "/wdb"

# itemtextcache carries the text of MAIL and letters the player read -- that is other
# people's writing, not game content. Never republish it.
NEVER_PUBLISH = {"itemtextcache"}


def header_for(cache, slug, srcs):
    """Verbatim 24-byte header from the newest real file of this cache type.
    Prefers a file from the same mode; falls back to any file of that type."""
    cands = [s for s in srcs if s["cache"] == cache and s["records"] != "0"
             and os.path.exists(s["path"])]
    same = [s for s in cands if s["slug"] == slug]
    for pool in (same, cands):
        for s in sorted(pool, key=lambda r: r["captured"], reverse=True):
            with open(s["path"], "rb") as f:
                h = f.read(wdblib.HEADER_LEN)
            if len(h) == wdblib.HEADER_LEN:
                return h, s
    return None, None


def write_wdb(path, header, winners):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    buf = bytearray(header)
    for entry in sorted(winners):
        _sha1, _r, payload = winners[entry]
        buf += struct.pack("<II", entry, len(payload)) + payload
    buf += b"\x00" * 8                      # terminator the client walks to
    with open(path, "wb") as f:
        f.write(bytes(buf))
    return len(buf)


def verify(path, winners):
    """Re-parse what we just wrote and compare every payload. Returns (ok, detail)."""
    info = wdblib.inspect(path)
    if not info.standard:
        return False, "header not recognised after write"
    if info.records != len(winners):
        return False, f"record count {info.records} != {len(winners)}"
    if not info.clean_end:
        return False, "no clean terminator"
    with open(path, "rb") as f:
        b = f.read()
    for entry, size, payload in wdblib.iter_records(b):
        want = winners.get(entry)
        if want is None:
            return False, f"entry {entry} not in source set"
        if want[2] != payload:
            return False, f"payload mismatch on entry {entry}"
    return True, f"{info.records} records, {info.cache}, build {info.build}"


def main():
    t0 = time.time()
    srcs = merge.read_tsv(merge.SOURCES, merge.SRC_COLS)
    caches = sorted(d for d in os.listdir(merge.STORE)
                    if os.path.isdir(f"{merge.STORE}/{d}") and d not in NEVER_PUBLISH)
    slugs = sorted({s["slug"] for s in srcs if s["slug"] and s["records"] != "0"})

    built = collections.defaultdict(dict)
    failures = []
    for cache in caches:
        recs = export.load_cache(cache)
        if not recs:
            continue
        for slug in slugs:
            w = export.pick_winners(recs, mode=slug)
            if not w:
                continue
            header, src = header_for(cache, slug, srcs)
            if header is None:
                failures.append(f"{slug}/{cache}: no header donor")
                continue
            p = f"{OUT}/{slug}/{cache}.wdb"
            size = write_wdb(p, header, w)
            ok, detail = verify(p, w)
            if not ok:
                failures.append(f"{slug}/{cache}: {detail}")
            built[slug][cache] = (len(w), size, ok)

    print(f"{'mode':<22}{'cache':<18}{'entries':>9}{'size':>12}  verified")
    for slug in sorted(built):
        for cache in sorted(built[slug]):
            n, size, ok = built[slug][cache]
            print(f"{slug:<22}{cache:<18}{n:>9}{size:>12,}  "
                  f"{'OK' if ok else 'FAILED'}")
    if failures:
        print("\nFAILURES:")
        for f in failures:
            print("  " + f)
    else:
        print("\nall rebuilt caches re-parsed and matched payload-for-payload")

    write_readme(built)
    print(f"\nwdb -> {OUT}  ({time.time()-t0:.0f}s)")


def write_readme(built):
    L = ["# Merged client caches (.wdb)\n",
         "One folder per game mode. Each `.wdb` is the union of every record that mode",
         "has produced across all submitted caches, in the client's own format.\n",
         "## Using them\n",
         "Copy the files into your own cache folder:\n",
         "```",
         "World of Warcraft\\Cache\\WDB\\enUS\\<Your Realm> - <Mode>\\",
         "```\n",
         "The folder is named after **your** realm, so pick the folder matching the mode",
         "and copy the `.wdb` files into your existing realm folder. Close the client",
         "first — it rewrites these files on exit and will overwrite your changes.\n",
         "A cache only ever helps the client skip a lookup it would otherwise ask the",
         "server for. If a record here is stale relative to your realm, the client",
         "corrects it the next time the server sends that entry.\n",
         "## Contents\n",
         "| mode | " + " | ".join(sorted({c for v in built.values() for c in v})) + " |",
         "|---|" + "---:|" * len({c for v in built.values() for c in v})]
    allc = sorted({c for v in built.values() for c in v})
    for slug in sorted(built):
        L.append(f"| `{slug}` | " +
                 " | ".join(f"{built[slug][c][0]:,}" if c in built[slug] else "—"
                            for c in allc) + " |")
    L += ["", "`itemtextcache` is deliberately never published: it holds the text of mail",
          "and letters the player read, which is other people's writing, not game data.\n"]
    with open(f"{OUT}/README.md", "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")


if __name__ == "__main__":
    main()
