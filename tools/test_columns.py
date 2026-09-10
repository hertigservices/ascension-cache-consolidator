"""Prove audit_columns.py actually catches the thing it was written for.

test_audit.py exists because a publish gate that has never been shown to fail
is indistinguishable from one that always passes.  Same argument here, and with
a sharper edge: this gate was written in response to a bug that every other
check in the pipeline sailed past, so "it printed CLEAN" is exactly the output
the broken dataset produced for weeks.

Each case builds a small tree on disk, runs the real checker over it, and
asserts on what comes back.  No mocking of the thing under test.

    python tools/test_columns.py
"""
import os, sys, io, csv, gzip, json, shutil, tempfile

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import audit_columns

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PASS, FAIL = [], []


def check(name, cond, detail=""):
    (PASS if cond else FAIL).append(name)
    print("  %-4s %s%s" % ("ok" if cond else "FAIL", name,
                           "" if cond else "   <- " + detail))


def write_tsv(path, header, rows, gz=False):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    buf = io.StringIO()
    w = csv.writer(buf, delimiter="\t", lineterminator="\n")
    w.writerow(header)
    w.writerows(rows)
    data = buf.getvalue().encode("utf-8")
    if gz:
        with gzip.open(path, "wb") as f:
            f.write(data)
    else:
        with open(path, "wb") as f:
            f.write(data)


def run(root, expect):
    """Run the real checker and return (fails, notes, counts) as dicts."""
    fails, notes, counts = [], [], {}
    exp = {"constant": expect.get("constant", {}),
           "counts": expect.get("counts", {})}
    for p, rel in audit_columns.walk(root):
        low = rel.lower()
        base = low[:-3] if low.endswith(".gz") else low
        if base.endswith(".tsv"):
            audit_columns.check_tsv(p, rel, exp, fails, notes, counts)
        else:
            audit_columns.check_json(p, rel, exp, fails, notes, counts)
    audit_columns.compare_counts(exp, counts, fails, [])
    return fails, notes, counts


def kinds(fails):
    return sorted(set(k for k, _a, _b in fails))


def keyed(fails, kind):
    return sorted(k for t, k, _m in fails if t == kind)


def main():
    tmp = tempfile.mkdtemp(prefix="colgate-")
    try:
        # ---- 1. the original bug, in miniature ------------------------------
        # A vendor table where every price column fell through to its default.
        print("\n1. a column of zeros where prices should be")
        write_tsv(os.path.join(tmp, "a", "vendors.tsv"),
                  ["npc", "item", "money_cost", "honor_cost"],
                  [[101, 5001, 0, 0], [101, 5002, 0, 0], [102, 5003, 0, 0]])
        fails, _n, counts = run(os.path.join(tmp, "a"), {})
        check("dead columns are reported",
              keyed(fails, "DEAD COLUMN") == ["vendors.tsv:honor_cost",
                                              "vendors.tsv:money_cost"],
              repr(keyed(fails, "DEAD COLUMN")))
        check("live columns are not",
              "vendors.tsv:npc" not in keyed(fails, "DEAD COLUMN"))
        check("live-row counts are recorded per column",
              counts.get("vendors.tsv:npc") == 3
              and counts.get("vendors.tsv:money_cost") == 0,
              repr({k: v for k, v in counts.items() if "vendors" in k}))

        # ---- 2. an explanation clears it, and only it -----------------------
        print("\n2. an explained column is a note, an unexplained one is not")
        exp = {"constant": {"vendors.tsv:money_cost": "vendors here are free"}}
        fails, notes, _c = run(os.path.join(tmp, "a"), exp)
        check("the explained one is cleared",
              "vendors.tsv:money_cost" not in keyed(fails, "DEAD COLUMN"))
        check("the unexplained one still fails",
              "vendors.tsv:honor_cost" in keyed(fails, "DEAD COLUMN"))
        check("the explanation is echoed back for review",
              any(k == "vendors.tsv:money_cost" and "free" in why
                  for _t, k, _what, why in notes))

        # ---- 3. THE important one: losing data is fatal even when explained --
        # This is the case the whole design turns on. A glob or a reason may
        # say "empty is normal here"; it must not be able to say "going empty
        # is normal here", or the gate can be argued away by the same file it
        # is supposed to police.
        print("\n3. a column that WAS alive and is now dead cannot be explained away")
        exp = {"constant": {"*": "blanket excuse for absolutely everything"},
               "counts": {"vendors.tsv:money_cost": 3, "vendors.tsv:rows": 3}}
        fails, _n, _c = run(os.path.join(tmp, "a"), exp)
        check("the loss is still a failure",
              "vendors.tsv:money_cost" in keyed(fails, "SHRANK"),
              repr(fails))

        # ---- 4. constant at a real value is a note, not a failure -----------
        print("\n4. a column that is legitimately one value is only a note")
        write_tsv(os.path.join(tmp, "b", "t.tsv"),
                  ["id", "quantity", "available"],
                  [[1, 1, -1], [2, 1, -1], [3, 1, -1]])
        fails, notes, _c = run(os.path.join(tmp, "b"), {})
        check("no failure for a real constant", not keyed(fails, "DEAD COLUMN"),
              repr(fails))
        check("-1 counts as a reading, not an absence",
              any(k == "t.tsv:available" for _t, k, _what, _why in notes),
              repr(notes))

        # ---- 5. dead JSON branches ------------------------------------------
        # The realm names here are deliberately SHORT.  norm() collapses a key
        # over 24 characters, so the two real realms group by accident of being
        # 29 characters long; a short name used to keep its own key, leaving
        # every branch under it with a single reading and below the floor, and
        # this case caught that.  Keep them short so it stays caught.
        print("\n5. a branch that is empty everywhere it appears")
        os.makedirs(os.path.join(tmp, "c"), exist_ok=True)
        with io.open(os.path.join(tmp, "c", "byRealm.json"), "w",
                     encoding="utf-8") as f:
            json.dump({"Area 52": {"wildcard": {"events": [], "rolls": [1, 2]}},
                       "Dawnrise": {"wildcard": {"events": [], "rolls": [3]}}}, f)
        fails, _n, _c = run(os.path.join(tmp, "c"), {})
        dead = keyed(fails, "DEAD BRANCH")
        check("the empty branch is reported",
              any(k.endswith("wildcard.events") for k in dead), repr(dead))
        check("realm buckets group regardless of name length",
              any(k == "byRealm.json:*.wildcard.events" for k in dead),
              repr(dead))
        check("the populated one is not",
              not any(k.endswith("wildcard.rolls") for k in dead), repr(dead))

        # ---- 6. an unreadable archive fails, it does not crash --------------
        # A gate that raises is a gate that did not run, and a traceback reads
        # like a broken tool rather than a broken dataset.
        print("\n6. a truncated .gz is a finding, not a traceback")
        os.makedirs(os.path.join(tmp, "d"), exist_ok=True)
        good = os.path.join(tmp, "d", "whole.tsv.gz")
        write_tsv(good, ["a", "b"], [[1, 2], [3, 4]], gz=True)
        raw = open(good, "rb").read()
        with open(os.path.join(tmp, "d", "cut.tsv.gz"), "wb") as f:
            f.write(raw[:len(raw) // 2])
        try:
            fails, _n, _c = run(os.path.join(tmp, "d"), {})
            crashed = False
        except Exception as e:                                   # noqa: BLE001
            fails, crashed = [], repr(e)
        check("it did not crash", crashed is False, str(crashed))
        check("it was reported as unreadable",
              "cut.tsv.gz" in keyed(fails, "UNREADABLE"), repr(fails))

        # ---- 7. an empty table --------------------------------------------
        print("\n7. a table with a header and no rows")
        write_tsv(os.path.join(tmp, "e", "empty.tsv"), ["a", "b"], [])
        fails, _n, _c = run(os.path.join(tmp, "e"), {})
        check("reported", "empty.tsv" in keyed(fails, "EMPTY TABLE"), repr(fails))

        # ---- 8. growth is not a failure ------------------------------------
        print("\n8. growth is reported, not punished")
        exp = {"counts": {"t.tsv:rows": 1, "t.tsv:id": 1}}
        fails, _n, _c = run(os.path.join(tmp, "b"), exp)
        check("more rows than the baseline is fine",
              not keyed(fails, "SHRANK"), repr(fails))
    finally:
        shutil.rmtree(tmp, ignore_errors=True)

    print("\n%s" % ("=" * 70))
    if FAIL:
        print("%d of %d checks FAILED: %s"
              % (len(FAIL), len(PASS) + len(FAIL), ", ".join(FAIL)))
        return 1
    print("all %d checks passed -- the gate fails when it should" % len(PASS))
    return 0


if __name__ == "__main__":
    sys.exit(main())
