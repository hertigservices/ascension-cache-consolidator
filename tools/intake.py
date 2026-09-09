"""Ascension cache intake: extract -> hash-dedup (on INNER files) -> inventory -> manifest.

Idempotent. Drop any submission (zip/rar/loose folder) into a scanned root and re-run.
Dedup key = sha256 of the extracted file, so a zip and a rar of the same itemcache
collapse to ONE record with a corroboration count. No DB writes, no deletes.
"""
import os, sys, json, hashlib, shutil, subprocess, time, re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

SEVENZIP = config.sevenzip()
INTAKE   = config.WORK
EXTRACT  = config.EXTRACT
LEDGER   = config.LEDGER
MANIFEST = config.MANIFEST
SCAN_ROOTS = config.SCAN_ROOTS
# handled in its own dedicated workspace; too big to re-extract every run
SKIP_ARCHIVES = {"ascension-harvest-export.zip"}
# Compressed tars need the suffix CHAIN, not splitext: splitext("WDB.tar.gz")
# returns ".gz". A .tar.gz was silently skipped here for exactly that reason --
# no error, just quietly not ingested -- so match on the chain.
ARCHIVE_EXT = {".zip", ".rar", ".7z", ".tar",
               ".tar.gz", ".tgz", ".tar.bz2", ".tbz2", ".tar.xz", ".txz",
               ".gz", ".bz2", ".xz"}
TAR_CHAINS  = {".tar.gz", ".tgz", ".tar.bz2", ".tbz2", ".tar.xz", ".txz"}
# Written into each extract dir so a second archive with the same stem
# (WDB.zip vs WDB.rar) gets its own dir instead of being reported "cached".
# Dirs predating this marker are grandfathered on first sight.
SRCMARK = ".intake-source"

def split_archive(fn):
    """(base, ext) where ext is the full suffix chain for compressed tars."""
    low = fn.lower()
    for ext in sorted(TAR_CHAINS, key=len, reverse=True):
        if low.endswith(ext):
            return fn[:-len(ext)], ext
    base, e = os.path.splitext(fn)
    return base, e.lower()

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()

# Beside EXTRACT, never inside it: anything under EXTRACT is scanned.
QUARANTINE = os.path.join(os.path.dirname(EXTRACT), "quarantine")


def extract_all():
    """Extract every archive under the scan roots into EXTRACT/<stem>/ (skip if already done)."""
    os.makedirs(EXTRACT, exist_ok=True)
    done = []
    # Pre-scan for stem collisions (WDB.zip vs WDB.tar.gz vs WDB.rar). Only
    # colliding stems get an ext-qualified dir; everything else keeps the
    # historical bare-stem dir so existing extractions are not re-done.
    claims = {}
    for root in SCAN_ROOTS:
        if not os.path.isdir(root): continue
        for dirpath, _dirs, files in os.walk(root):
            if os.path.abspath(dirpath).startswith(os.path.abspath(EXTRACT)):
                continue
            for fn in files:
                base, ext = split_archive(fn)
                if ext not in ARCHIVE_EXT or fn in SKIP_ARCHIVES: continue
                claims.setdefault(re.sub(r"[^A-Za-z0-9._()+-]", "_", base), set()).add(fn)
    contested = {s for s, v in claims.items() if len(v) > 1}
    for s in sorted(contested):
        print("  note: stem %r claimed by %s -- each gets its own dir"
              % (s, ", ".join(sorted(claims[s]))))
    for root in SCAN_ROOTS:
        if not os.path.isdir(root): continue
        for dirpath, _dirs, files in os.walk(root):
            if os.path.abspath(dirpath).startswith(os.path.abspath(EXTRACT)):
                continue  # never recurse into our own extract output
            for fn in files:
                base, ext = split_archive(fn)
                if ext not in ARCHIVE_EXT: continue
                if fn in SKIP_ARCHIVES: continue
                src = os.path.join(dirpath, fn)
                stem = re.sub(r"[^A-Za-z0-9._()+-]", "_", base)
                if stem in contested:
                    stem = stem + "__" + ext.replace(".", "")
                out = os.path.join(EXTRACT, stem)
                if os.path.isdir(out) and os.listdir(out):
                    done.append((fn, "cached")); continue
                os.makedirs(out, exist_ok=True)
                r = subprocess.run([SEVENZIP, "x", src, "-o"+out, "-y", "-bd", "-bb0"],
                                   capture_output=True, text=True)
                ok = r.returncode == 0
                # .tar.gz unwraps to a .tar; 7z needs a second pass to open it
                if ok and ext in TAR_CHAINS:
                    inner = [x for x in os.listdir(out) if x.lower().endswith(".tar")]
                    for t in inner:
                        tp = os.path.join(out, t)
                        r2 = subprocess.run([SEVENZIP, "x", tp, "-o"+out, "-y", "-bd", "-bb0"],
                                            capture_output=True, text=True)
                        ok = ok and r2.returncode == 0
                        if r2.returncode == 0:
                            os.remove(tp)
                if ok:
                    with open(os.path.join(out, SRCMARK), "w") as f: f.write(fn)
                    done.append((fn, "ok"))
                else:
                    where = quarantine(out, fn, (r.stderr or r.stdout or "").strip())
                    done.append((fn, f"FAILED -> quarantine/{os.path.basename(where)}"
                                     if where else f"ERR {r.returncode}"))
    return done


def quarantine(out, fn, why):
    """Move a failed extraction out of the way, and say where it went.

    It must not stay under EXTRACT. The "have we already done this one?" test is
    `isdir(out) and listdir(out)`, so a half-written directory left in place
    reports `cached` on every future run: the archive is never retried, and the
    fragments 7-Zip did write are scanned into the ledger as if they were a real
    submission. A truncated upload would fail once, silently, and be treated as
    finished forever.

    It is moved rather than deleted. A failed extraction is the most interesting
    kind -- a corrupt upload worth asking the sender to redo, or an archive doing
    something it should not -- and deleting the evidence to keep the folder tidy
    would be exactly the wrong instinct.
    """
    os.makedirs(QUARANTINE, exist_ok=True)
    stamp = time.strftime("%Y%m%d-%H%M%S")
    dest = os.path.join(QUARANTINE, f"{os.path.basename(out)}__{stamp}")
    try:
        shutil.move(out, dest)
    except OSError as e:
        print(f"  !! {fn} failed to extract AND could not be quarantined: {e}")
        print(f"     remove {out} by hand or it will report 'cached' forever")
        return None
    try:
        with open(os.path.join(dest, "WHY-THIS-IS-HERE.txt"), "w",
                  encoding="utf-8") as f:
            f.write("Extraction of this archive failed, so its partial output was\n"
                    "moved here. Nothing in this folder has been scanned or\n"
                    "published, and the archive will be retried on the next run.\n\n"
                    f"archive : {fn}\n"
                    f"when    : {stamp}\n"
                    f"7-Zip said:\n{why or '(nothing)'}\n")
    except OSError:
        pass
    print(f"  !! {fn} failed to extract; partial output quarantined at {dest}")
    return dest

def label_for(path):
    """Return (provenance_label, group). Group = the realm/character folder that
    directly contains the wdb (the meaningful unit), collapsing the generic 'enUS'
    container and '(root)' loose drops."""
    ap = os.path.abspath(path)
    parent = os.path.basename(os.path.dirname(ap))
    grp = parent if parent not in ("enUS",) else "enUS (realm root)"
    ex = os.path.abspath(EXTRACT)
    if ap.startswith(ex):
        rel = os.path.relpath(ap, ex).replace("\\", "/")
        return "archive:" + rel, grp
    for root in SCAN_ROOTS:
        ra = os.path.abspath(root)
        if ap.startswith(ra):
            rel = os.path.relpath(ap, ra).replace("\\", "/")
            if "/" not in rel: grp = "(root)"
            return "loose:" + rel, grp
    return ap.replace("\\", "/"), grp

def scan():
    ledger = {}
    if os.path.exists(LEDGER):
        with open(LEDGER, encoding="utf-8") as f:
            ledger = json.load(f)
    seen_before = set(ledger)
    walk_roots = SCAN_ROOTS + [EXTRACT]
    for root in walk_roots:
        if not os.path.isdir(root): continue
        for dirpath, _dirs, files in os.walk(root):
            for fn in files:
                if not fn.lower().endswith(".wdb"): continue
                p = os.path.join(dirpath, fn)
                h = sha256(p)
                lbl, grp = label_for(p)
                if h in ledger:
                    srcs = ledger[h]["sources"]
                    if lbl not in srcs: srcs.append(lbl)
                    continue
                info = wdblib.inspect(p.replace("\\", "/"))
                ledger[h] = {
                    "sha256": h, "filename": fn, "size": os.path.getsize(p),
                    "cache": info.cache, "label": info.label, "build": info.build,
                    "locale": info.locale, "records": info.records,
                    "standard": info.standard, "clean_end": info.clean_end,
                    "note": info.note or "", "group": grp, "sources": [lbl],
                    "first_seen": time.strftime("%Y-%m-%d %H:%M:%S"),
                }
    with open(LEDGER, "w", encoding="utf-8") as f:
        json.dump(ledger, f, indent=1)
    return ledger, seen_before

def manifest(ledger, seen_before):
    entries = list(ledger.values())
    new = [e for e in entries if e["sha256"] not in seen_before]
    # best (max-record) standard snapshot per cache type = union-coverage ceiling
    best = {}
    for e in entries:
        if not e["standard"]: continue
        b = best.get(e["cache"])
        if b is None or e["records"] > b["records"]:
            best[e["cache"]] = e
    L = []
    L.append("# Ascension cache intake — manifest\n")
    L.append(f"_Generated {time.strftime('%Y-%m-%d %H:%M:%S')}. "
             f"{len(entries)} distinct files, {len(new)} new this run._\n")
    L.append("Dedup is on the **inner file hash**, so identical zip/rar re-submissions "
             "collapse to one row; `submitters` counts how many distinct sources carried it.\n")

    L.append("## Best snapshot per cache type (max records seen = coverage ceiling)\n")
    L.append("| cache | best records | build | from |")
    L.append("|---|---:|---:|---|")
    order = ["itemcache","questcache","creaturecache","gameobjectcache","npccache",
             "pagetextcache","itemnamecache","itemtextcache","wowcache"]
    for c in order:
        if c in best:
            e = best[c]
            L.append(f"| {c} | {e['records']:,} | {e['build']} | {e['group']} |")
    L.append("")

    L.append("## Every distinct cache file\n")
    L.append("| cache | records | size | build | group | submitters | note |")
    L.append("|---|---:|---:|---:|---|---:|---|")
    for e in sorted(entries, key=lambda x: (x["cache"], -x["records"], -x["size"])):
        tag = " **NEW**" if e["sha256"] in {n['sha256'] for n in new} else ""
        L.append(f"| {e['cache']}{tag} | {e['records']:,} | {e['size']:,} | {e['build']} "
                 f"| {e['group']} | {len(e['sources'])} | {e['note']} |")
    L.append("")

    L.append("## Provenance (which source carried each distinct file)\n")
    for e in sorted(entries, key=lambda x: x["group"]):
        L.append(f"- `{e['cache']}` {e['records']:,} rec, sha `{e['sha256'][:12]}` — "
                 + "; ".join(e["sources"]))
    with open(MANIFEST, "w", encoding="utf-8") as f:
        f.write("\n".join(L) + "\n")

def main():
    os.makedirs(INTAKE + "/_inbox", exist_ok=True)
    ex = extract_all()
    print("extract:", ", ".join(f"{n}:{s}" for n, s in ex) or "(none)")
    ledger, seen = scan()
    manifest(ledger, seen)
    tot = len(ledger); new = sum(1 for e in ledger.values() if e["sha256"] not in seen)
    print(f"ledger: {tot} distinct wdb files ({new} new). manifest -> {MANIFEST}")

if __name__ == "__main__":
    main()
