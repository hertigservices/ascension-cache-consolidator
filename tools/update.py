"""One command for the whole pipeline. Drop a submission in _inbox, run this.

    python tools/update.py

  1. intake   extract archives, hash-dedup whole files, update ledger + MANIFEST
  2. merge    fold every record into the union store, dedup identical payloads,
              keep genuine variants, identify unlabelled submissions by fingerprint
  3. catalogue  turn the submitted world dumps into a list of objects and
                creatures that exist -- a catalogue, never a spawn table
  4. export   write the decoded per-mode / union / raw views
  5. rebuild  write merged, client-loadable .wdb files per game mode
  6. audit    scan everything about to be published for player data

Every stage is idempotent, so re-running after a bad drop is safe and cheap.
The audit is the gate: a non-zero exit means DO NOT PUBLISH until it is explained.
"""
import os, sys, subprocess, time

HERE = os.path.dirname(os.path.abspath(__file__))
STAGES = [("intake",  "intake.py"),
          ("merge",   "merge.py"),
          # A .lua submission is a tree whose branches need opposite treatment,
          # not a flat record list, so it merges in its own stage.  It runs
          # before export because the file guide describes its output too, and
          # before the audit so that output is covered by the publish gate.
          ("lua",     "luamerge.py"),
          # The world dumps are observations, not cache files -- nobody's client
          # wrote them, players walked the world with a dump addon running. They
          # need no merge store, only a recompute from the files on disk, so they
          # sit here: after the caches, before the guide that describes them.
          ("catalogue", "ingest_gameobjects.py"),
          ("export",  "export.py"),
          ("rebuild", "rebuild.py"),
          ("audit",   "audit_publish.py")]


def main():
    t0 = time.time()
    failed = []
    for name, script in STAGES:
        # flush before handing the console to the child, or our banners land last
        print(f"\n{'='*70}\n== {name}\n{'='*70}", flush=True)
        r = subprocess.run([sys.executable, os.path.join(HERE, script)])
        if r.returncode != 0:
            failed.append(name)
            if name == "audit":
                print("\n!! AUDIT FAILED -- do not publish until every hit is explained.")
            else:
                print(f"\n!! {name} failed (exit {r.returncode}); stopping.")
                break
    print(f"\n{'='*70}")
    if failed:
        print("FAILED: " + ", ".join(failed))
    else:
        print(f"all stages OK in {time.time()-t0:.0f}s")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
