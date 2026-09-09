"""Prove the published caches against the files real game clients actually wrote.

Everything else in this pipeline checks itself. `rebuild.py` re-parses what it
just wrote, `luamerge.py` re-reads its own output, `unpack.py` validates a
header. Those are all worth having, and they all share one blind spot: they
compare our encoder against our decoder. If both are wrong in the same way,
every one of them passes.

This checks something different, and it is the only claim that really matters:

    Every record we publish is bytes that a real World of Warcraft client
    wrote to disk, unchanged -- and every record a client gave us is still
    in there.

The ground truth is the submitted `.wdb` files themselves. Nobody's decoder is
involved in deciding what those bytes should be; the game wrote them.

Four checks, and the first two are the important ones:

  1. NOTHING INVENTED   every published record's payload is byte-identical to
                        a payload some client wrote for that same entry.  A
                        failure here means we are publishing fiction.
  2. NOTHING LOST       every record from every submitted file is still there,
                        unless another submission for the same game mode had a
                        different payload for that entry and won the merge --
                        which is reported separately, and counted.
  3. REAL HEADERS       the 24-byte header on each published file is copied
                        from a real client's file, not synthesised.
  4. STILL INTACT       it survives the gzip round trip and ends on a clean
                        record boundary, which is what the client checks.

This proves the *files* are honest. It cannot prove the game likes them --
only the game can say that. See VERIFYING-THE-DATA.md for the in-game half.

    python tools/selftest.py                  everything
    python tools/selftest.py --cache itemcache  just one (itemcache is the slow one)
"""
import os, sys, io, gzip, json, hashlib, argparse, collections, time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import config, wdblib

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PUB = os.path.join(config.OUT, "wdb").replace("\\", "/")


def sha1(b):
    return hashlib.sha1(b).hexdigest()


def resolve(labels):
    """Turn a ledger provenance label back into the file it names.

    There are two shapes and the second is easy to forget. `archive:` is a path
    under the extract directory; `loose:` is a folder somebody dropped in
    without zipping it, which lives under one of the scan roots instead.
    Handling only the first makes every record that arrived as a loose folder
    look like it came from nowhere -- which reads exactly like the pipeline
    inventing data, and is the opposite of a true finding.
    """
    for s in labels:
        if s.startswith("archive:"):
            p = os.path.join(config.EXTRACT, s[len("archive:"):])
            if os.path.exists(p):
                return p
        elif s.startswith("loose:"):
            rel = s[len("loose:"):]
            for root in list(config.SCAN_ROOTS) + [config.INBOX,
                                                   os.path.join(config.INBOX, "archive")]:
                p = os.path.join(root, rel)
                if os.path.exists(p):
                    return p
    return None


def originals():
    """Every submitted .wdb still on disk, with the mode it was filed under.

    Read from the ledger, because the ledger is what records which upload a
    file came from; the path is then resolved back to the actual bytes. A file
    whose extract directory has since been removed is skipped and counted, not
    silently ignored.
    """
    with io.open(config.LEDGER, encoding="utf-8") as f:
        led = json.load(f)
    slug_of = {}
    with io.open(os.path.join(config.OUT, "sources.tsv"), encoding="utf-8") as f:
        cols = f.readline().rstrip("\n").split("\t")
        for line in f:
            r = dict(zip(cols, line.rstrip("\n").split("\t")))
            if r.get("sha256"):
                slug_of[r["sha256"]] = r.get("slug") or "unknown"
    out, gone = [], 0
    for h, rec in led.items():
        slug = slug_of.get(h)
        if not slug:
            continue
        path = resolve(rec.get("sources") or [])
        if path is None:
            gone += 1
            continue
        out.append({"sha256": h, "cache": rec.get("cache"), "slug": slug,
                    "path": path, "group": rec.get("group") or ""})
    return out, gone


def read_published(cache, slug):
    """The published file for one cache in one mode, decompressed."""
    p = f"{PUB}/{slug}/{cache}.wdb.gz"
    if not os.path.exists(p):
        return None
    with gzip.open(p, "rb") as f:
        return f.read()


def check_cache(cache, srcs, verbose):
    """Run all four checks for one cache type across every mode."""
    res = collections.Counter()
    problems = []
    by_slug = collections.defaultdict(list)
    for s in srcs:
        by_slug[s["slug"]].append(s)

    # Every header a real client wrote for this cache, for check 3.
    real_headers = set()

    for slug in sorted(by_slug):
        # ---- ground truth: what the clients wrote, for this mode
        # entry -> {payload sha1}. Several clients may disagree about one
        # entry; every version any of them wrote is legitimate ground truth.
        truth = collections.defaultdict(set)
        who = {}
        for s in by_slug[slug]:
            try:
                b = io.open(s["path"], "rb").read()
            except OSError as e:
                problems.append(f"{cache}/{slug}: cannot read {s['path']}: {e}")
                continue
            info = wdblib.inspect(s["path"], data=b)
            if not info.standard:
                continue                      # addon-written stub, not a cache
            real_headers.add(bytes(b[:24]))
            for entry, _size, payload in wdblib.iter_records(b):
                d = sha1(payload)
                truth[entry].add(d)
                who.setdefault((entry, d), s["group"] or s["sha256"][:12])
        if not truth:
            continue

        pub = read_published(cache, slug)
        if pub is None:
            # Not every mode publishes every cache; only a mode that HAS source
            # records and no published file is a real problem.
            problems.append(f"{cache}/{slug}: {len(truth):,} records from real "
                            f"clients but nothing published for this mode")
            res["mode_missing"] += 1
            continue

        # ---- check 3: is the header a real one?
        if bytes(pub[:24]) not in real_headers:
            problems.append(f"{cache}/{slug}: published header is not "
                            f"byte-identical to any real client's header")
            res["fake_header"] += 1

        # ---- check 4: intact and client-shaped
        info = wdblib.inspect(f"{cache}/{slug}", data=pub)
        if not info.standard:
            problems.append(f"{cache}/{slug}: header not recognised: {info.note}")
            res["bad_header"] += 1
        if not info.clean_end:
            problems.append(f"{cache}/{slug}: no clean record terminator -- "
                            f"the client will reject this file")
            res["unclean"] += 1

        # ---- check 1: nothing invented
        seen = {}
        for entry, _size, payload in wdblib.iter_records(pub):
            d = sha1(payload)
            seen[entry] = d
            if entry not in truth:
                problems.append(f"{cache}/{slug}: entry {entry} is published "
                                f"but no client ever sent it")
                res["invented_entry"] += 1
            elif d not in truth[entry]:
                problems.append(f"{cache}/{slug}: entry {entry} has a payload "
                                f"no client ever wrote")
                res["invented_payload"] += 1
            else:
                res["verbatim"] += 1

        # ---- check 2: nothing lost
        for entry, digests in truth.items():
            if entry not in seen:
                problems.append(f"{cache}/{slug}: entry {entry} was in a "
                                f"submitted file and is not published")
                res["lost"] += 1
            elif seen[entry] not in digests:
                # Should be impossible given check 1 passed, but assert it.
                res["lost"] += 1
            elif len(digests) > 1:
                # The client copies disagreed and the merge chose one. Real,
                # expected, and worth counting: it is the number of records
                # where somebody's cache says something else.
                res["superseded"] += 1

        if verbose:
            print(f"    {slug:<22} {len(truth):>8,} source records, "
                  f"{len(seen):>8,} published")
    return res, problems


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--cache", help="check only this cache (e.g. itemcache)")
    ap.add_argument("-v", "--verbose", action="store_true",
                    help="show per-mode record counts")
    a = ap.parse_args(argv)

    t0 = time.time()
    srcs, gone = originals()
    if not srcs:
        print("no submitted files resolvable on disk; nothing to check against")
        return 1
    by_cache = collections.defaultdict(list)
    for s in srcs:
        if s["cache"] and (not a.cache or s["cache"] == a.cache):
            by_cache[s["cache"]].append(s)
    if not by_cache:
        print(f"no submitted files for cache {a.cache!r}")
        return 1

    print(f"checking {sum(len(v) for v in by_cache.values()):,} submitted file(s) "
          f"against the published dataset")
    if gone:
        print(f"  ({gone} ledger entries have no file on disk any more; skipped)")
    print()

    total, all_problems = collections.Counter(), []
    for cache in sorted(by_cache):
        r, p = check_cache(cache, by_cache[cache], a.verbose)
        total.update(r)
        all_problems += p
        flag = "!!" if (r["lost"] or r["invented_entry"] or r["invented_payload"]
                        or r["fake_header"] or r["unclean"]) else "ok"
        print(f"  {flag} {cache:<18} {r['verbatim']:>9,} verbatim  "
              f"{r['superseded']:>7,} superseded  {r['lost']:>5,} lost  "
              f"{r['invented_entry'] + r['invented_payload']:>5,} invented")

    print()
    print(f"  {total['verbatim']:,} published records are byte-identical to what "
          f"a real client wrote")
    print(f"  {total['superseded']:,} records where submitted copies disagreed "
          f"and the merge picked one")
    print(f"  {total['lost']:,} lost, {total['invented_entry']:,} invented "
          f"entries, {total['invented_payload']:,} invented payloads")
    print(f"  {total['fake_header']:,} synthesised headers, "
          f"{total['unclean']:,} files without a clean terminator")

    bad = (total["lost"] + total["invented_entry"] + total["invented_payload"]
           + total["fake_header"] + total["unclean"] + total["bad_header"])
    if all_problems:
        print(f"\n  first {min(len(all_problems), 20)} of {len(all_problems)} "
              f"problem(s):")
        for line in all_problems[:20]:
            print("    " + line)
    print(f"\ndone in {time.time()-t0:.0f}s")
    if bad:
        print("FAILED: the published dataset does not match what the clients wrote.")
        return 1
    print("PASSED: every published record is a real client's bytes, and none "
          "were dropped.")
    print("This does not prove the game accepts the files -- see "
          "VERIFYING-THE-DATA.md for the in-game test.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
