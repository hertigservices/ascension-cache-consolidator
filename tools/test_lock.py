# -*- coding: utf-8 -*-
"""Prove publish.Lock actually excludes, and that it fails in the safe direction.

Writing a lock is easy; writing one that works is not, and the failure mode is
silent -- a lock that never blocks looks exactly like a lock that was never
contended.  So this contends it.

NOT PART OF THE PUBLISH GATE, deliberately.  `publish.audit()` runs its
self-tests from inside the lock, so a lock test run from there would find the
lock already held by its own parent and could only ever report a false failure.
Run it by hand, on a quiet tree:

    python test_lock.py

It exits 2 without testing anything if a publish is genuinely in progress.  That
is on purpose: a test that reports success when it did not run is worse than one
that admits it could not.
"""
import os, io, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import publish

ok, bad = [], []


def check(name, cond, detail=""):
    (ok if cond else bad).append(name)
    print("  %-4s %s%s" % ("ok" if cond else "FAIL", name,
                           "" if cond else "   <- " + detail))


if os.path.exists(publish.LOCK):
    print("a real publish appears to hold %s -- not running" % publish.LOCK)
    sys.exit(2)

print("\n1. a second entry is refused while the first is held")
with publish.Lock() as a:
    check("first caller holds it", a.held)
    check("the lockfile exists", os.path.exists(publish.LOCK))
    with publish.Lock() as b:
        check("second caller is REFUSED", not b.held,
              "two publishes would have run together")
    check("the refused caller did not delete the lock",
          os.path.exists(publish.LOCK))
check("released on exit", not os.path.exists(publish.LOCK))

print("\n2. a lock left behind by a dead process is taken over")
# A crashed run must not wedge publishing until someone deletes a file by hand.
with io.open(publish.LOCK, "w", encoding="utf-8") as f:
    f.write("999999\n2026-01-01 00:00:00\npublish.py --push\n")
with publish.Lock() as c:
    check("stale lock taken over", c.held,
          "a crashed run would wedge publishing until someone deleted a file")
check("released again", not os.path.exists(publish.LOCK))

print("\n3. an unreadable/garbage lock is treated as HELD, not stolen")
with io.open(publish.LOCK, "w", encoding="utf-8") as f:
    f.write("not-a-pid\n")
with publish.Lock() as d:
    check("garbage lock is respected", not d.held,
          "unparseable must fail toward exclusion, never toward collision")
os.unlink(publish.LOCK)

print("\n4. _pid_alive is right about a process that really is alive")
check("this process reads as alive", publish._pid_alive(os.getpid()))
check("a bogus pid reads as dead", not publish._pid_alive(999999))

print("\n" + "=" * 62)
if bad:
    print("%d FAILED: %s" % (len(bad), ", ".join(bad)))
    sys.exit(1)
print("all %d checks passed -- the lock excludes, and fails safe" % len(ok))
