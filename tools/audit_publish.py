"""Pre-publish audit: scan everything about to go public for player data.

Run before any upload. Checks the exported tree for emails, player GUIDs, WTF
account paths, and absolute local paths that leak the maintainer's own machine.
Binary .wdb payloads are scanned as raw bytes too -- a name string inside a record
is still a string.
"""
import os, re, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import scrub, export

PATTERNS = {
    "email":        re.compile(rb"[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}"),
    "player-guid":  re.compile(rb"0x[0-9A-Fa-f]{16}"),
    "wtf-account":  re.compile(rb"WTF[\\/]Account[\\/]", re.I),
    "local-path":   re.compile(rb"C:[\\/](?:Users|AscensionArchive)", re.I),
}
# our own docs legitimately describe the client's cache path
ALLOW_SUBSTR = [b"World of Warcraft\\Cache", b"<redacted"]


def main(root=export.OUT):
    hits = {}
    scanned = 0
    for dp, _d, fs in os.walk(root):
        for fn in fs:
            p = os.path.join(dp, fn)
            rel = os.path.relpath(p, root).replace("\\", "/")
            with open(p, "rb") as f:
                b = f.read()
            if fn.endswith(".gz"):
                # scan what is INSIDE the archive; compressed bytes match anything
                import gzip, io
                try:
                    b = gzip.decompress(b)
                except OSError:
                    pass
            scanned += 1
            for name, pat in PATTERNS.items():
                for m in pat.finditer(b):
                    frag = m.group(0)
                    if any(a in frag for a in ALLOW_SUBSTR):
                        continue
                    hits.setdefault(name, []).append((rel, frag[:80]))
    print(f"scanned {scanned} files under {root}")
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
