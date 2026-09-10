# -*- coding: utf-8 -*-
"""Does sync_tools carry the right files, and refuse the wrong ones?

Two failures live here and neither one raises anything.

The first is a name with a space in it. `git ls-files tools` quotes such a path
and every caller split the result on whitespace, so one file arrived as two
broken names and was skipped -- forever, silently. The repo already ships
`tools/Cache Consolidator.cmd`, so this was not waiting for someone to be
careless; it was already true.

The second is an overwrite. sync_tools copies intake over the repo, tools/ is
exempt from the foreign-change check because this script owns it, and so a
maintainer editing a script in the checkout could have it erased mid-edit by an
automated run with no diff and no message. Losing work that way looks exactly
like forgetting to save.

Run directly. Not wired into publish.audit(): these build throwaway git repos,
and the gate should not depend on git being able to init one.
"""
import os, io, sys, shutil, tempfile, subprocess

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import publish

NL = chr(10)

ok, bad = [], []


def check(name, cond, detail=""):
    (ok if cond else bad).append(name)
    print("  %-4s %s%s" % ("ok" if cond else "FAIL", name,
                           "" if cond else "   <- " + detail))


def g(root, *a):
    return subprocess.run(["git", "-C", root] + list(a),
                          capture_output=True, text=True)


def write(path, text):
    d = os.path.dirname(path)
    if d and not os.path.isdir(d):
        os.makedirs(d)
    with io.open(path, "w", encoding="utf-8", newline="") as f:
        f.write(text)


if shutil.which("git") is None:
    print("git unavailable, nothing to test")
    sys.exit(0)

tmp = tempfile.mkdtemp(prefix="synctest_")
repo = os.path.join(tmp, "repo")
here = os.path.join(tmp, "intake")
os.makedirs(os.path.join(repo, "tools"))
os.makedirs(here)

# Two tracked tools: one ordinary, one whose name has a space in it -- the
# case that has been silently skipped in the real repo all along.
PLAIN, SPACED = "tools/plain.py", "tools/Two Words.cmd"
write(os.path.join(repo, "tools", "plain.py"), "print(1)" + NL)
write(os.path.join(repo, "tools", "Two Words.cmd"), "echo one" + NL)
g(repo, "init", "-q")
g(repo, "config", "user.email", "t@t")
g(repo, "config", "user.name", "t")
g(repo, "add", "-A")
g(repo, "commit", "-qm", "base")

# The intake copies differ, so a working sync must carry both.
write(os.path.join(here, "plain.py"), "print(2)" + NL)
write(os.path.join(here, "Two Words.cmd"), "echo two" + NL)

publish.REPO, publish.HERE = repo, here

print(NL + "1. a tracked name containing a space is carried, not dropped")
wrote = publish.sync_tools()
check("both files were copied", sorted(wrote) == sorted([PLAIN, SPACED]),
      repr(wrote))
check("the spaced file really changed on disk",
      io.open(os.path.join(repo, "tools", "Two Words.cmd")).read().strip()
      == "echo two")
check("the returned name is the real path, not a quoted fragment",
      SPACED in wrote, repr(wrote))

print(NL + "2. nothing to do is not reported as work")
check("a second run copies nothing", publish.sync_tools() == [])

print(NL + "3. a repo file someone is editing is NOT overwritten")
g(repo, "add", "-A")
g(repo, "commit", "-qm", "synced")
write(os.path.join(repo, "tools", "plain.py"), "print('MINE, unsaved')" + NL)
write(os.path.join(here, "plain.py"), "print(3)" + NL)
write(os.path.join(here, "Two Words.cmd"), "echo three" + NL)
wrote = publish.sync_tools()
kept = io.open(os.path.join(repo, "tools", "plain.py")).read()
check("the edited file survived", "MINE, unsaved" in kept, kept)
check("and was not reported as published", PLAIN not in wrote, repr(wrote))
check("the untouched file still synced", SPACED in wrote, repr(wrote))

print(NL + "4. an untracked file in tools/ is never published")
write(os.path.join(repo, "tools", "secret.py"), "PASSWORD = 1" + NL)
write(os.path.join(here, "secret.py"), "PASSWORD = 2" + NL)
wrote = publish.sync_tools()
check("an untracked name is not carried",
      not any("secret" in w for w in wrote), repr(wrote))

print(NL + "5. status_paths reads a spaced path whole")
seen = dict((p, xy) for xy, p in publish.status_paths())
# The spaced file was rewritten by case 3, so it must be modified here.
# An `or no quotes anywhere` fallback would pass this on an empty status,
# which is the shape of a check that is really testing nothing.
check("the spaced path appears, whole and unquoted",
      seen.get("tools/Two Words.cmd") == " M", repr(sorted(seen.items())))
check("nothing came back quoted",
      all(chr(34) not in p for p in seen), repr(sorted(seen)))
check("an untracked file reads as ??", seen.get("tools/secret.py") == "??",
      repr(seen))
check("the old whitespace split would have miscounted",
      len(publish.git("ls-files", "tools").stdout.split())
      != len(publish.nul("ls-files", "-z", "tools")))

print(NL + "6. a rename does not smear one entry into the next")
g(repo, "mv", "tools/plain.py", "tools/renamed.py")
paths = [p for _xy, p in publish.status_paths()]
check("both sides of the rename are not treated as entries",
      "tools/renamed.py" in paths and paths.count("tools/renamed.py") == 1,
      repr(paths))
check("no entry has status bytes sliced off a path",
      all(not p.startswith("ools/") for p in paths), repr(paths))

shutil.rmtree(tmp, ignore_errors=True)

print(NL + "=" * 62)
if bad:
    print("%d FAILED: %s" % (len(bad), ", ".join(bad)))
    sys.exit(1)
print("all %d checks passed" % len(ok))
