# -*- coding: utf-8 -*-
"""Find -- and optionally fix -- submissions the pipeline silently skips.

    python tools/sweep_inbox.py          # report only, touches nothing
    python tools/sweep_inbox.py --fix    # rename the archives that are being skipped

WHY THIS EXISTS

    Two parts of the pipeline are allow-lists that drop what they do not
    recognise without saying so. That is the right design -- an unknown file
    shape must never reach a public dataset -- but it means a submission can be
    lost with no error anywhere:

    1. intake extracts each archive into extracted/<stem>/, where <stem> comes
       from the FILENAME. If that directory already exists it prints "cached" and
       moves on. Two people both sending WDB.zip therefore collide, and whichever
       is walked second is never read. Renaming them by hand (WDB(1).zip) is what
       has been preventing this.

    2. luamerge matches .lua files by EXACT filename against a five-name list.
       "AIO_Client (1).lua" is not a slightly wrong name to it; it is an
       unrecognised file, dropped without comment.

    This walks every scan root -- the inbox, its archive/ folder and any extra
    roots -- and names the files each rule is currently discarding.

WHAT --fix DOES, AND WHAT IT REFUSES TO DO

    It renames a colliding archive to <stem>__<content hash><ext>, which is
    unique by construction, so intake gives it its own extract directory and
    reads it. It renames ONLY the copies that were not extracted, and only once
    it has positively identified which copy WAS extracted by comparing member
    hashes against the bytes on disk. If it cannot tell them apart it renames
    nothing and says so -- renaming the copy that was already read would extract
    the same bytes a second time and inflate the corroboration counts that say
    how many people independently sent a record.

    It never renames a .lua file. luamerge's match is exact, so a renamed addon
    file is not a slightly wrong name -- it is an invisible one.
"""
import argparse
import hashlib
import os
import re
import sys
import zipfile

# Only when there is actually a console to reconfigure. Under pythonw
# (which is how the tray app runs) sys.stdout is None, and reaching for
# .reconfigure on it raised at import time -- so importing this module
# to check for name collisions failed, silently, in the one program
# that calls it on every run.
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import config
import intake
import luamerge

# Windows and browsers add these when a name is taken. A file wearing one is
# almost always a second copy of something we do have a rule for.
COPY_SUFFIX = re.compile(r"(?:[ _-]*\((\d+)\)|[ _-]+copy(?:\s*\(\d+\))?|"
                         r"[ _-]+\d+)$", re.I)


def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def human(n):
    return "%.1f MB" % (n / 1048576.0) if n >= 1048576 else "%.0f KB" % (n / 1024.0)


def rel(p):
    for root in intake.SCAN_ROOTS:
        a = os.path.abspath(root)
        if os.path.abspath(p).startswith(a):
            return os.path.relpath(p, a).replace("\\", "/")
    return p.replace("\\", "/")


def walk_roots():
    """Every file under the scan roots, skipping intake's own output."""
    ex = os.path.abspath(intake.EXTRACT)
    for root in intake.SCAN_ROOTS:
        if not os.path.isdir(root):
            continue
        for dp, _dirs, files in os.walk(root):
            if os.path.abspath(dp).startswith(ex):
                continue
            for fn in files:
                yield os.path.join(dp, fn)


def classify():
    archives, luas, others = [], [], []
    for p in walk_roots():
        fn = os.path.basename(p)
        _base, ext = intake.split_archive(fn)
        if ext in intake.ARCHIVE_EXT:
            archives.append(p)
        elif fn.lower().endswith((".lua", ".lua.bak")):
            luas.append(p)
        else:
            others.append(p)
    return archives, luas, others


def claimed_dirs(archives):
    """{stem: [paths]} using intake's own stem rules, contest included."""
    claims = {}
    for p in archives:
        fn = os.path.basename(p)
        if fn in intake.SKIP_ARCHIVES:
            continue
        base, _ext = intake.split_archive(fn)
        claims.setdefault(re.sub(r"[^A-Za-z0-9._()+-]", "_", base), set()).add(fn)
    contested = {s for s, v in claims.items() if len(v) > 1}

    by_dir = {}
    for p in archives:
        fn = os.path.basename(p)
        if fn in intake.SKIP_ARCHIVES:
            continue
        base, ext = intake.split_archive(fn)
        stem = re.sub(r"[^A-Za-z0-9._()+-]", "_", base)
        if stem in contested:
            stem = stem + "__" + ext.replace(".", "")
        by_dir.setdefault(stem, []).append(p)
    return by_dir


def tree_hashes(root):
    """Every content hash under root, minus intake's own marker."""
    out = set()
    for dp, _d, fs in os.walk(root):
        for fn in fs:
            if fn == intake.SRCMARK:
                continue
            try:
                out.add(sha256(os.path.join(dp, fn)))
            except OSError:
                pass
    return out


def member_hashes(path):
    """Content hashes of an archive's members, or None if we cannot read it.

    Only zip is opened here on purpose. rar and 7z would mean shelling out to
    7-Zip for every candidate, and the answer is only needed to tell two
    same-named files apart -- a case that has only ever arisen with zips.
    """
    if not path.lower().endswith(".zip"):
        return None
    try:
        out = set()
        with zipfile.ZipFile(path) as zf:
            for info in zf.infolist():
                if info.is_dir():
                    continue
                h = hashlib.sha256()
                with zf.open(info) as f:
                    for c in iter(lambda: f.read(1 << 20), b""):
                        h.update(c)
                out.add(h.hexdigest())
        return out
    except (zipfile.BadZipFile, OSError, RuntimeError):
        return None


def extracted_source(stem, group):
    """Which file in `group` produced extracted/<stem>/, or None if unclear."""
    out = os.path.join(intake.EXTRACT, stem)
    if not (os.path.isdir(out) and os.listdir(out)):
        return None
    disk = tree_hashes(out)
    for p in group:
        mh = member_hashes(p)
        if mh and mh <= disk:
            return p
    # Fall back to intake's own marker, but only when it names exactly one of them.
    try:
        with open(os.path.join(out, intake.SRCMARK), encoding="utf-8",
                  errors="replace") as f:
            mark = f.read().strip()
    except OSError:
        return None
    named = [p for p in group if os.path.basename(p) == mark]
    return named[0] if len(named) == 1 else None


def unique_name(path):
    """<stem>__<content hash><ext>, which no other content can claim."""
    d, fn = os.path.split(path)
    base, ext = intake.split_archive(fn)
    tag = sha256(path)[:8]
    cand = os.path.join(d, "%s__%s%s" % (base, tag, ext))
    if os.path.exists(cand):
        cand = os.path.join(d, "%s__%s%s" % (base, sha256(path)[:16], ext))
    return cand


def collisions(archives=None):
    """[(stem, [paths], extracted_path_or_None)] for genuinely contested dirs."""
    by_dir = claimed_dirs(archives if archives is not None else classify()[0])
    out = []
    for stem, paths in sorted(by_dir.items()):
        if len(paths) < 2:
            continue
        if len({sha256(p) for p in paths}) < 2:
            continue                      # identical bytes; nothing is lost
        out.append((stem, paths, extracted_source(stem, paths)))
    return out


def fix_collisions(log=print, apply=True):
    """Rename the copies that intake is skipping. Returns [(old, new)]."""
    done = []
    for stem, paths, source in collisions():
        if source is None:
            log("!! %d files claim extracted/%s/ and I cannot tell which one was "
                "read; renaming none of them." % (len(paths), stem))
            for p in paths:
                log("      %s" % rel(p))
            continue
        for p in paths:
            if p == source:
                continue
            new = unique_name(p)
            if not apply:
                log("   would rename %s -> %s" % (rel(p), os.path.basename(new)))
                done.append((p, new))
                continue
            try:
                os.replace(p, new)
                log("   renamed %s -> %s  (it had never been read)"
                    % (rel(p), os.path.basename(new)))
                done.append((p, new))
            except OSError as e:
                log("!! could not rename %s: %s" % (rel(p), e))
    return done


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fix", action="store_true",
                    help="rename the archives that are being silently skipped")
    a = ap.parse_args()

    print("scan roots:")
    for r in intake.SCAN_ROOTS:
        print("   %s %s" % ("  " if os.path.isdir(r) else "!!", r))
    print("extract dir: %s" % intake.EXTRACT)

    archives, luas, _others = classify()
    print("\n%d archive(s), %d lua file(s)" % (len(archives), len(luas)))

    # ---------------------------------------------------------------- part 1
    print("\n" + "=" * 74)
    print("1. ARCHIVES -- which extract directory each one claims")
    print("=" * 74)
    by_dir = claimed_dirs(archives)
    unextracted = []
    for stem, paths in sorted(by_dir.items()):
        out = os.path.join(intake.EXTRACT, stem)
        if not (os.path.isdir(out) and os.listdir(out)):
            unextracted.extend((p, stem) for p in paths)

    clash = collisions(archives)
    if clash:
        for stem, paths, source in clash:
            print("\n!! %d files claim extracted/%s/, with different contents:"
                  % (len(paths), stem))
            for p in paths:
                tag = "  <- this is the one that was read" if p == source else ""
                print("      %-56s %9s%s"
                      % (rel(p), human(os.path.getsize(p)), tag))
            if source is None:
                print("      cannot tell which was read from the bytes on disk.")
    else:
        print("   no two archives with different contents claim the same "
              "extract directory.")

    print("\n-- archives with no extraction on disk --")
    if unextracted:
        for p, stem in unextracted:
            print("   %-56s -> extracted/%s/" % (rel(p), stem))
        print("   (a fresh drop that has not been through the pipeline yet is "
              "expected here)")
    else:
        print("   none.")

    # ---------------------------------------------------------------- part 2
    print("\n" + "=" * 74)
    print("2. LUA -- files the five-name allow-list is discarding")
    print("=" * 74)
    known = set(luamerge.SPECS) | set(luamerge.ALIASES)
    accepted, near_miss = [], []
    for p in sorted(luas):
        fn = os.path.basename(p)
        _key, spec = luamerge.spec_for(fn)
        if spec:
            accepted.append(p)
            continue
        stem, ext = os.path.splitext(fn)
        cleaned = (COPY_SUFFIX.sub("", stem) + ext).lower()
        if cleaned in known:
            near_miss.append((p, cleaned))
    print("   %d lua file(s) accepted by name" % len(accepted))
    if near_miss:
        print("\n   !! %d file(s) are an allow-listed addon wearing a copy "
              "suffix, so nothing reads them:" % len(near_miss))
        for p, c in near_miss:
            print("      %-60s (would match %s)" % (rel(p), c))
    else:
        print("   no lua file is being dropped for wearing a (1)/copy suffix.")

    # ---------------------------------------------------------------- part 3
    print("\n" + "=" * 74)
    print("3. " + ("FIX" if a.fix else "VERDICT"))
    print("=" * 74)
    if a.fix:
        done = fix_collisions(print, apply=True)
        if done:
            print("\n%d file(s) renamed. Run the pipeline and they will be read "
                  "for the first time." % len(done))
        else:
            print("nothing needed renaming.")
        return 0
    if clash:
        skipped = sum(len(p) - 1 for _s, p, src in clash if src is not None)
        print("!! %d submission(s) have never been read: another file claimed "
              "their\n   extract directory first. Re-run with --fix to give them "
              "unique names." % skipped)
    if near_miss:
        print("!! %d lua file(s) are invisible to luamerge; rename them back to "
              "the exact addon filename." % len(near_miss))
    if not (clash or near_miss):
        print("Clean. Every archive has its own extract directory and no "
              "allow-listed\nlua file is being dropped for its name.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
