"""Consolidate whatever is in the inbox and publish the result.

    python publish.py            # consolidate, show what changed, do not push
    python publish.py --push     # ...and push it
    python publish.py --watch    # keep watching the inbox and repeat

This is the whole loop in one place: drop a submission in `_inbox/`, and the
merged data ends up public without anyone deciding anything by hand.

WHAT GUARDS THE PUSH
--------------------
Everything here is reversible except the push.  A force-push does not un-publish
a leak -- once account data is on GitHub it has been fetched, cached and indexed,
and deleting the commit changes none of that.  So the audit is a hard gate: it
runs against the bytes in the repository working tree, not against the export
directory they were copied from, and a non-zero exit stops the run before
anything is committed.  There is deliberately no flag to skip it.

The same reasoning applies to the pipeline stages: if merging or rebuilding
failed, the data on disk is a half-written state and must not be published as
though it were a consolidation.

WHAT IT WILL NOT DO
-------------------
It never invents a remote, never force-pushes, and never commits anything under
`quarantine/`.  If the working tree has changes it did not make, it says so and
stops rather than sweeping someone else's edit into a commit.
"""
import os, re, sys, subprocess, shutil, time, filecmp

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import config

REPO = os.environ.get(
    "CONSOLIDATOR_REPO",
    os.path.join(os.path.dirname(config.WORK), "ascension-cache-consolidator"))
DATA = os.path.join(REPO, "cachedata")
POLL_SECONDS = 60


def run(cmd, cwd=None, check=True):
    r = subprocess.run(cmd, cwd=cwd, text=True, capture_output=True)
    if check and r.returncode != 0:
        print((r.stdout + r.stderr).strip())
        raise SystemExit(f"!! {' '.join(cmd)} failed ({r.returncode})")
    return r


def stream(cmd, cwd=None, every=10):
    """Run a command with its output arriving live, not at the end.

    The push is the one step here that can take minutes, and it was the one step
    with nothing to look at: git writes transfer progress to stderr, `run()`
    captures stderr, and git suppresses progress altogether when stderr is not a
    terminal -- which it is not when something is reading this output. So a large
    push printed "committed" and then nothing at all until it finished, which is
    indistinguishable from a hang.

    `--progress` makes git report anyway; not capturing lets it through. Progress
    lines are thinned to one every `every` percent, because git emits hundreds and
    a log is not a terminal that can overwrite its own last line.
    """
    p = subprocess.Popen(cmd, cwd=cwd, stdout=subprocess.PIPE,
                         stderr=subprocess.STDOUT, text=True,
                         encoding="utf-8", errors="replace", bufsize=1)
    tail, last = [], {}
    for line in p.stdout:
        line = line.rstrip("\r\n")
        if not line:
            continue
        tail.append(line)
        del tail[:-40]
        # The server echoes its own progress back prefixed "remote: ";
        # strip that before matching or those lines are never thinned,
        # and on a large push they are the noisiest of the lot.
        m = re.match(r"^(?:remote:\s*)?([A-Za-z][A-Za-z ]+):\s+(\d+)%", line)
        if m:
            phase, pct = m.group(1), int(m.group(2))
            if pct - last.get(phase, -every) < every and pct != 100:
                continue
            last[phase] = pct
        print("   " + line, flush=True)
    return p.wait(), tail


def git(*args, check=True):
    return run(["git", *args], cwd=REPO, check=check)


def inbox_fingerprint():
    """(name, size, mtime) for everything in the inbox, archive/ included.

    Content hashing would be more precise and much slower on a 200 MB drop; the
    pipeline dedups by hash anyway, so the only cost of a false "changed" is one
    wasted no-op run.
    """
    out = []
    for dp, _d, fs in os.walk(config.INBOX):
        for fn in sorted(fs):
            p = os.path.join(dp, fn)
            try:
                st = os.stat(p)
            except OSError:
                continue
            out.append((os.path.relpath(p, config.INBOX), st.st_size,
                        int(st.st_mtime)))
    return sorted(out)


def settled(prev):
    """True when the inbox stopped changing.

    A drop of several archives arrives over seconds, and a file still being
    copied is a truncated archive. Consolidating mid-copy would ledger a corrupt
    submission, so wait for two identical readings before touching anything.
    """
    time.sleep(3)
    return inbox_fingerprint() == prev


def consolidate():
    print(f"\n{'='*70}\n== consolidating\n{'='*70}", flush=True)
    r = subprocess.run([sys.executable, os.path.join(HERE, "update.py")])
    return r.returncode == 0


def sync_data():
    """Mirror the export into the repository, deletions included.

    A copy that only adds leaves a mode behind after it stops existing -- the
    same stale-output problem the exporter prunes internally -- so the mirror
    has to remove as well as write.
    """
    src = config.OUT
    os.makedirs(DATA, exist_ok=True)
    wrote = removed = 0
    keep = set()
    for dp, _d, fs in os.walk(src):
        rel = os.path.relpath(dp, src)
        dst_dir = os.path.join(DATA, rel) if rel != "." else DATA
        os.makedirs(dst_dir, exist_ok=True)
        for fn in fs:
            s, d = os.path.join(dp, fn), os.path.join(dst_dir, fn)
            keep.add(os.path.normcase(os.path.abspath(d)))
            # shallow=False: compare contents, not just size and mtime. A
            # regenerated-but-identical file must not show up as a change.
            if not (os.path.exists(d) and filecmp.cmp(s, d, shallow=False)):
                shutil.copy2(s, d)
                wrote += 1
    for dp, _d, fs in os.walk(DATA, topdown=False):
        for fn in fs:
            p = os.path.join(dp, fn)
            if os.path.normcase(os.path.abspath(p)) not in keep:
                os.remove(p)
                removed += 1
        if dp != DATA and not os.listdir(dp):
            os.rmdir(dp)
    print(f"data: {wrote} file(s) written, {removed} removed")
    return wrote or removed


def sync_tools():
    """Publish the pipeline itself, but only files the repo already tracks.

    The intake directory also holds this maintainer's private realm-database
    scripts. Adding "every .py here" would publish those the first time someone
    wrote a new one, so the shipped set stays an explicit allow-list -- the
    files already under version control.
    """
    tracked = git("ls-files", "tools").stdout.split()
    n = 0
    for rel in tracked:
        s = os.path.join(HERE, os.path.basename(rel))
        d = os.path.join(REPO, rel.replace("/", os.sep))
        if os.path.exists(s) and not filecmp.cmp(s, d, shallow=False):
            shutil.copy2(s, d)
            n += 1
    if n:
        print(f"tools: {n} file(s) updated from {HERE}")
    return n


def audit():
    """The gate. Runs on the repository tree -- the actual bytes to be pushed."""
    print(f"\n{'='*70}\n== publish audit\n{'='*70}", flush=True)
    ok = True
    targets = [DATA, os.path.join(REPO, "tools"), os.path.join(REPO, "docs")]
    # The README and LICENSE sit at the repository root, so walking the
    # subdirectories never touched them -- and they are published too. Ask git
    # which top-level files are tracked rather than naming them here, so a new
    # one is covered the day it appears.
    targets += [os.path.join(REPO, f) for f in git("ls-files").stdout.split()
                if "/" not in f]
    for target in targets:
        if not os.path.exists(target):
            continue
        r = subprocess.run([sys.executable,
                            os.path.join(HERE, "audit_publish.py"), target])
        ok = ok and r.returncode == 0
    # The gate itself is only worth as much as its own test.
    r = subprocess.run([sys.executable, os.path.join(HERE, "test_audit.py")],
                       capture_output=True, text=True)
    if r.returncode != 0:
        print(r.stdout + r.stderr)
        print("!! the publish gate failed its own test")
        ok = False
    return ok


def describe(status):
    counts = {}
    for line in status:
        counts[line[:2].strip() or "?"] = counts.get(line[:2].strip() or "?", 0) + 1
    return ", ".join(f"{v} {k}" for k, v in sorted(counts.items()))


def publish(push):
    if not consolidate():
        print("\n!! the pipeline did not finish; nothing published")
        return False

    foreign = [l for l in git("status", "--porcelain").stdout.splitlines()
               if not l[3:].startswith(("cachedata/", "tools/"))]
    if foreign:
        print("\n!! the working tree has changes this script did not make:")
        for l in foreign[:20]:
            print("   " + l)
        print("   commit or revert them first; refusing to sweep them into a push")
        return False

    changed = sync_data() + sync_tools()
    if not audit():
        print("\n!! AUDIT FAILED -- nothing committed, nothing pushed.")
        print("   Every hit must be explained before this can go public.")
        return False
    print("\naudit clean")

    status = git("status", "--porcelain").stdout.splitlines()
    if not status:
        # "Nothing to commit" is not "nothing to push". A run that committed and
        # then failed to push -- dropped network, timeout, an interrupted run --
        # leaves the work in a local commit, and returning success here would
        # mean every later run cheerfully reports "already published" while that
        # commit is never sent anywhere. Fall through instead; the push below
        # costs nothing when there is genuinely nothing to send.
        print("nothing new to commit")
    else:
        print(f"\n{len(status)} path(s) changed: {describe(status)}")
        git("add", "-A", "cachedata", "tools")
        msg = ("Consolidate submissions and republish\n\n"
               "Automated run: every file in the inbox merged, deduplicated and\n"
               "re-exported, then audited for player data before commit.\n\n"
               "Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>\n")
        git("commit", "-m", msg)
        print("committed " + git("rev-parse", "--short", "HEAD").stdout.strip())

    if not push:
        print("\nnot pushing (pass --push to publish)")
        return True
    if not git("remote", check=False).stdout.strip():
        print("!! no git remote configured; commit kept, nothing pushed")
        return False
    branch = git("rev-parse", "--abbrev-ref", "HEAD").stdout.strip()
    print(f"pushing {branch} to origin -- this is the slow part on a big "
          f"dataset, and it reports as it goes:", flush=True)
    t0 = time.time()
    rc, tail = stream(["git", "push", "--progress", "origin", branch], cwd=REPO)
    if rc != 0:
        print("\n".join(tail))
        print("!! push failed; the commit is still here, retry when resolved")
        return False
    print(f"pushed {branch} in {time.time() - t0:.0f}s")
    return True


def main(argv):
    push = "--push" in argv
    if "--watch" not in argv:
        return 0 if publish(push) else 1
    print(f"watching {config.INBOX}\n  repo: {REPO}\n"
          f"  push: {'yes' if push else 'no (dry run)'}")
    last = None
    while True:
        now = inbox_fingerprint()
        if now != last and settled(now):
            now = inbox_fingerprint()
            if last is not None:
                print(f"\n[{time.strftime('%H:%M:%S')}] inbox changed "
                      f"({len(now)} files)")
            publish(push)
            last = now
        time.sleep(POLL_SECONDS)


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
