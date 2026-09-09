"""Where everything lives. Import this instead of hardcoding paths.

Defaults are derived from the location of this file, so a fresh clone works with no
configuration at all:

    <workspace>/            <- WORK, the parent of tools/
      _inbox/               drop submitted archives and folders here
      extracted/            archives unpacked (regenerable)
      merged/               the union record store (regenerable)
      ledger.json           per-file dedup ledger
    <workspace>/../cachedata/   <- OUT, the publishable dataset

Override any of it with environment variables, or with a config.json in WORK:

    { "extra_scan_roots": ["D:/somewhere/else"], "sevenzip": "C:/.../7z.exe" }

`extra_scan_roots` is how you add collections that live outside _inbox without
moving them.
"""
import os, json, shutil

HERE = os.path.dirname(os.path.abspath(__file__))


def _env(name, default):
    v = os.environ.get(name)
    return v if v else default


WORK = os.path.normpath(_env("ASCENSION_CACHE_WORK", os.path.dirname(HERE)))
OUT = os.path.normpath(_env("ASCENSION_CACHE_OUT",
                            os.path.join(os.path.dirname(WORK), "cachedata")))

_cfg = {}
_cfg_path = os.path.join(WORK, "config.json")
if os.path.exists(_cfg_path):
    with open(_cfg_path, encoding="utf-8") as f:
        _cfg = json.load(f)

INBOX    = os.path.join(WORK, "_inbox").replace("\\", "/")
EXTRACT  = os.path.join(WORK, "extracted").replace("\\", "/")
STORE    = os.path.join(WORK, "merged").replace("\\", "/")
LEDGER   = os.path.join(WORK, "ledger.json").replace("\\", "/")
MANIFEST = os.path.join(WORK, "MANIFEST.md").replace("\\", "/")
SOURCES  = STORE + "/sources.tsv"
WORK     = WORK.replace("\\", "/")
OUT      = OUT.replace("\\", "/")

# Collections kept outside _inbox. Scanned read-only; nothing is ever written there.
EXTRA_SCAN_ROOTS = [p.replace("\\", "/") for p in _cfg.get("extra_scan_roots", [])]
if os.environ.get("ASCENSION_CACHE_EXTRA_ROOTS"):
    EXTRA_SCAN_ROOTS += [p.strip().replace("\\", "/")
                         for p in os.environ["ASCENSION_CACHE_EXTRA_ROOTS"].split(";")
                         if p.strip()]

# Read roots, in the order they are scanned.
SCAN_ROOTS = EXTRA_SCAN_ROOTS + [INBOX]


def sevenzip():
    """7-Zip, needed only to unpack submitted archives."""
    p = _cfg.get("sevenzip") or os.environ.get("SEVENZIP")
    if p and os.path.exists(p):
        return p
    for c in (r"C:\Program Files\7-Zip\7z.exe",
              r"C:\Program Files (x86)\7-Zip\7z.exe"):
        if os.path.exists(c):
            return c
    return shutil.which("7z") or shutil.which("7za") or r"C:\Program Files\7-Zip\7z.exe"


if __name__ == "__main__":
    for k in ("WORK", "OUT", "INBOX", "EXTRACT", "STORE", "LEDGER"):
        print(f"{k:<10} {globals()[k]}")
    print(f"{'7-Zip':<10} {sevenzip()}")
    print(f"{'scan':<10} {SCAN_ROOTS}")
