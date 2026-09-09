"""Pre-publish audit: scan everything about to go public for player data.

Run before any upload. Checks the exported tree for emails, player GUIDs, WTF
account paths, and absolute local paths that leak the maintainer's own machine.
Binary .wdb payloads are scanned as raw bytes too -- a name string inside a record
is still a string.
"""
import os, re, sys, gzip, zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import scrub, export

PATTERNS = {
    "email":        re.compile(rb"[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}"),
    "player-guid":  re.compile(rb"0x[0-9A-Fa-f]{16}"),
    # Capture the segment AFTER Account/ too.  Without it every hit looks the
    # same, and a description of the path cannot be told from a real login.
    "wtf-account":  re.compile(rb"WTF[\\/]Account[\\/][^\s\\/\"'`)\]]{0,40}", re.I),
    "local-path":   re.compile(rb"C:[\\/](?:Users|AscensionArchive)", re.I),
}
# our own docs legitimately describe the client's cache path
ALLOW_SUBSTR = [b"World of Warcraft\\Cache", b"<redacted",
                # The commit trailer publish.py writes. A documented no-reply
                # mailbox belonging to no one, allowed as this exact string and
                # nothing wider -- any other address still fails.
                b"noreply@anthropic.com"]

# A placeholder is not a leak.  The tool has to be able to name the path it
# refuses -- "WTF/Account/<login email>/" IS the documentation of the rule --
# and a submitter who redacted their own file by hand leaves the same shape.
# A real exposure has a real login after Account/, never an angle bracket.
PLACEHOLDER = re.compile(rb"[\\/]<[^>]*>?$")


def walk(root):
    """Yield (path, label) for everything to scan.

    A single file is a valid target, not just a directory: the repository's own
    README and LICENSE sit at the root rather than inside one of the folders
    that get walked, and they are published too.
    """
    if os.path.isfile(root):
        yield root, os.path.basename(root)
        return
    for dp, _d, fs in os.walk(root):
        for fn in fs:
            p = os.path.join(dp, fn)
            yield p, os.path.relpath(p, root).replace("\\", "/")


def main(root=export.OUT):
    hits = {}
    unreadable = []
    scanned = 0
    for p, rel in walk(root):
        with open(p, "rb") as f:
            b = f.read()
        if p.endswith(".gz"):
            # Scan what is INSIDE the archive.  Compressed bytes match none of
            # these patterns, so an archive we cannot open would sail through
            # looking clean -- and now that the whole dataset ships gzipped,
            # that is not a corner case, that is the dataset.  An unreadable
            # member is therefore a failure, never a skip.
            try:
                b = gzip.decompress(b)
            except (OSError, EOFError, zlib.error) as e:
                unreadable.append((rel, str(e)))
                continue
        scanned += 1
        for name, pat in PATTERNS.items():
            for m in pat.finditer(b):
                frag = m.group(0)
                if any(a in frag for a in ALLOW_SUBSTR):
                    continue
                if PLACEHOLDER.search(frag):
                    continue
                hits.setdefault(name, []).append((rel, frag[:80]))
    print(f"scanned {scanned} files under {root}")
    if unreadable:
        print(f"\n!! {len(unreadable)} compressed file(s) could not be opened, "
              f"so their contents were never scanned:")
        for rel, why in unreadable[:20]:
            print(f"  {rel}: {why}")
        return 1
    if not hits:
        print("CLEAN: no emails, player GUIDs, account paths or local paths found")
        return 0
    for name, v in hits.items():
        print(f"\n{name}: {len(v)} hit(s)")
        seen = set()
        for rel, frag in v[:20]:
            k = (rel, frag)
            if k in seen:
                continue
            seen.add(k)
            print(f"  {rel}: {frag!r}")
    return 1


if __name__ == "__main__":
    sys.exit(main(*sys.argv[1:]))
