"""Prove the publish gate catches what it claims to, in both directions.

audit_publish.py is the only thing standing between a submitter's account data
and a public repository, and it fails open in the worst way: a gate that stops
matching prints CLEAN, which looks exactly like a gate that is working.

So it gets a test. Every case here is a file the auditor must reject, or a file
it must accept -- and the accept list exists because a gate that refuses its own
documentation gets "fixed" by loosening it, which is how a real leak gets
through six months later.

    python test_audit.py
"""
import os, sys, gzip, shutil, tempfile, subprocess

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import audit_publish
import scrub

# THE FIXTURES ARE WRITTEN IN PIECES ON PURPOSE.
#
# This file is published too, and audit_publish.py scans it like everything
# else. Spelling a fixture out in one literal would make the auditor flag its
# own test -- and the tempting fix for that is to exclude this file from the
# scan, which is precisely the hole the gate exists to prevent. An exclusion
# list grows, and the next thing on it is not a test.
#
# Split across concatenation, the bytes handed to the auditor are identical
# while the source file contains no contiguous account path, email or GUID.
# If an edit ever rejoins one, the audit fails loudly on this file, which is
# the right way to find out.
ACCT = b"WTF/Acc" b"ount/"                    # the account path prefix it hunts
ACCT_BS = b"WTF" + bytes([92]) + b"Acc" b"ount" + bytes([92])
AT = bytes([64])                              # keeps an email from forming here

# Real player data. Every one of these must fail the audit.
MUST_FAIL = {
    "real-login":       ACCT + b"SOMEPLAYER77/SavedVariables/x.lua",
    "real-login-bs":    ACCT_BS + b"SOMEONE123" + bytes([92]) + b"Rexxar - CoA",
    "real-email":       b"contact player at someone" + AT + b"example.org now",
    "real-guid":        b"lastGUID = 0x" b"F130004A" b"2B00C1D9",
    "local-path":       b"C:" + bytes([92]) + b"Users" + bytes([92]) + b"Ammo",
    # a half-finished redaction still exposes the login it left behind
    "half-redacted":    ACCT + b"<real" + AT + b"thing.com>bob/SavedVariables/",
}

# Documentation and honest redaction markers. These must NOT trip the audit --
# the tool has to be able to name the path it refuses to publish.
MUST_PASS = {
    "doc-placeholder":  b"the tree is " + ACCT + b"<login email>/<Realm>/",
    "doc-acct":         b"# " + ACCT + b"<acct>/SavedVariables -> account-wide",
    "doc-something":    b"# " + ACCT + b"<something>/ -- a login identifier",
    "cache-path":       b"World of Warcraft" + bytes([92]) + b"Cache"
                        + bytes([92]) + b"WDB" + bytes([92]) + b"enUS",
    "submitter-redact": b'["name"] = {redacted},',
}


def check(body, want_rc):
    d = tempfile.mkdtemp()
    try:
        with open(os.path.join(d, "sample.txt"), "wb") as f:
            f.write(body)
        # audit_publish prints its own findings; that output is the evidence
        return audit_publish.main(d) == want_rc
    finally:
        shutil.rmtree(d, ignore_errors=True)


def check_gz(body, want_rc, truncate=False):
    """Same, but inside a gzip archive.

    Nearly every published file is compressed, so a gate that scans only plain
    files scans almost nothing -- and compressed bytes match no pattern, so it
    would report CLEAN while looking at a leak. The truncated case covers the
    other half: an archive that cannot be opened has not been checked, and must
    never be mistaken for one that came back clean.
    """
    d = tempfile.mkdtemp()
    try:
        blob = gzip.compress(body)
        if truncate:
            blob = blob[:len(blob) // 2]
        with open(os.path.join(d, "sample.txt.gz"), "wb") as f:
            f.write(blob)
        return audit_publish.main(d) == want_rc
    finally:
        shutil.rmtree(d, ignore_errors=True)


# (label, payload, expected exit code, truncate the archive)
COMPRESSED = [
    ("a login hidden inside a .gz", MUST_FAIL["real-login"],      1, False),
    ("a .gz that will not open",    MUST_FAIL["real-login"],      1, True),
    ("documentation inside a .gz",  MUST_PASS["doc-placeholder"], 0, False),
]



def check_ignored():
    """The gate skips what git ignores -- but only that.

    audit_publish stopped scanning gitignored files because a stray
    __pycache__ entry, which cannot be committed by any route, was failing the
    gate and blocking every publish. Narrowing a gate is exactly the move that
    lets a leak through six months later, so the hole gets tested, not just the
    fix: an untracked file that git does NOT ignore is publishable by
    `git add -A`, and must still fail.

    Builds its own repository rather than borrowing the real one, so it neither
    depends on nor disturbs the tree it is guarding.
    """
    results = []
    d = tempfile.mkdtemp()
    try:
        try:
            subprocess.run(["git", "init", "-q", d], check=True,
                           capture_output=True, timeout=60)
        except (OSError, subprocess.SubprocessError):
            # No git means git_ignored() can never answer, so it skips nothing
            # and the gate stays at its old, stricter behaviour. Nothing to prove.
            print("  ok    git-ignore      : git unavailable, narrowing is inert")
            return []
        with open(os.path.join(d, ".gitignore"), "w") as f:
            f.write("junk/" + chr(10))
        os.mkdir(os.path.join(d, "junk"))
        with open(os.path.join(d, "junk", "leak.bin"), "wb") as f:
            f.write(MUST_FAIL["local-path"])
        results.append(("an ignored file is skipped", audit_publish.main(d) == 0))

        with open(os.path.join(d, "loose.txt"), "wb") as f:
            f.write(MUST_FAIL["local-path"])
        results.append(("an untracked but publishable file still fails",
                        audit_publish.main(d) == 1))
    finally:
        shutil.rmtree(d, ignore_errors=True)
    return results


def check_config_trees():
    """Packing WTF's contents must not turn account state into public data.

    Use synthetic paths only. Known addon files still require branch scrubbing;
    ordinary caches and server JSON outside config trees remain publishable.
    """
    account = "Acc" + "ount/"
    email_login = "sample" + chr(64) + "example.invalid"
    roots = [
        "WTF/" + account + "SAMPLE/",
        "drop/wTf/" + account + "SAMPLE/",
        account + email_login + "/",
        "drop/" + account + "SAMPLE/",
    ]
    cases = []
    for root in roots:
        # Account-wide state has no realm name; realm names also need not
        # contain the Ascension-specific ' - ' mode separator.
        for leaf in ("SavedVariables/state.json",
                     "ExampleRealm/ExampleCharacter/state.loc",
                     "ExampleRealm - CoA/ExampleCharacter/itemcache.wdb"):
            path = root + leaf
            cases.append((path, scrub.QUARANTINE))
            cases.append((path.replace("/", chr(92)), scrub.QUARANTINE))
        for addon in ("GatherMate2.lua", "MobSpells.lua.bak"):
            cases.append((root + "SavedVariables/" + addon, scrub.SCRUB))
    for path in ("Cache/WDB/enUS/itemcache.wdb", "server/content.json",
                 "server/content.loc", "accounting/content.json",
                 "mywtf/content.loc"):
        cases.append((path, scrub.PUBLISH))
    cases.extend([
        ("Cache/WDB/enUS/itemtextcache.wdb", scrub.QUARANTINE),
        ("Cache/WDB/enUS/wowcache.wdb", scrub.QUARANTINE),
        (account + "SAMPLE/SavedVariables/UnknownAddon.lua", scrub.QUARANTINE),
    ])
    failures = [(path, want, scrub.classify(path)[0]) for path, want in cases
                if scrub.classify(path)[0] != want]
    for path, want, got in failures:
        print(f"  FAIL  config classification: {path}: {got}, expected {want}")
    print(f"  {len(cases) - len(failures)}/{len(cases)} config-tree checks")
    return [("config trees stay private regardless of packing", not failures)]


def main():
    bad = 0
    for name, body in sorted(MUST_FAIL.items()):
        ok = check(body, 1)
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  must be caught  : {name}")
    for name, body in sorted(MUST_PASS.items()):
        ok = check(body, 0)
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  must be allowed : {name}")
    for label, body, rc, trunc in COMPRESSED:
        ok = check_gz(body, rc, trunc)
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  compressed      : {label}")
    extra = check_ignored() + check_config_trees()
    for label, ok in extra:
        bad += not ok
        print(f"  {'ok  ' if ok else 'FAIL'}  safeguard       : {label}")
    n = len(MUST_FAIL) + len(MUST_PASS) + len(COMPRESSED) + len(extra)
    print(f"\n{n - bad}/{n} "
          + ("- the publish gate is working" if not bad
             else f"- {bad} BROKEN, do not publish"))
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
