"""Unpack the published dataset — and install a mode's caches into your client.

Everything bulky here is stored gzipped. Uncompressed the dataset is about
756 MB and its biggest single file is a 254 MB itemcache; GitHub refuses any
file over 100 MB, so it could not be published any other way. Compressed it is
about 104 MB with nothing over 16 MB.

You do not need this script — every `.gz` here opens with `gunzip`, 7-Zip, or
two lines of any programming language. It exists because the common job is
fiddly by hand: put the merged caches for one game mode into the right folder
of your own WoW install, without destroying the cache you already have.

    python unpack.py                        what is in here
    python unpack.py --mode conquest-of-azeroth
                                            unpack that mode next to the .gz files
    python unpack.py --mode conquest-of-azeroth --into "C:/Games/Ascension/Cache/WDB/enUS/Rexxar - Conquest of Azeroth"
                                            ...into your client instead
    python unpack.py --all                  unpack the whole dataset (needs ~756 MB)

CLOSE THE GAME FIRST. The client rewrites these files when it exits, so
anything copied in while it is running is overwritten on the way out.

Nothing is ever overwritten without `--force`, and `--force` keeps a `.bak` of
whatever it replaced. Your own cache is real data: it is the only record of
what your realm told your client.
"""
import os, sys, gzip, glob, zlib, shutil, argparse

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
try:
    import wdblib
except ImportError:                       # running from a copy without the tools
    wdblib = None

# Where the data lives: cachedata/ beside tools/, which is how the repo ships.
DEFAULT_DATA = os.path.join(os.path.dirname(HERE), "cachedata")


def size(n):
    for unit in ("B", "KB", "MB", "GB"):
        if n < 1024:
            return f"{n:.0f} {unit}" if unit == "B" else f"{n:.1f} {unit}"
        n /= 1024
    return f"{n:.1f} TB"


def modes_available(data):
    d = os.path.join(data, "wdb")
    if not os.path.isdir(d):
        return []
    return sorted(x for x in os.listdir(d) if os.path.isdir(os.path.join(d, x)))


def check_wdb(path, is_wdb):
    """Is the file we just wrote a cache the client will actually accept?

    A truncated download or a half-written disk produces a file of plausible
    size that the client silently refuses, and the player has no way to tell
    that from 'the cache did not help'. Say so here instead.

    `is_wdb` comes from the DESTINATION name, not from `path`: what is checked
    is still the temporary file, which never carries the .wdb suffix.
    """
    if wdblib is None or not is_wdb:
        return True, ""
    info = wdblib.inspect(path)
    if not info.standard:
        return False, info.note or "not a recognised cache header"
    if not info.clean_end:
        return False, "does not end on a clean record boundary"
    return True, f"{info.cache}, {info.records:,} records, build {info.build}"


def discard(path):
    try:
        os.remove(path)
    except OSError:
        pass


def unpack_one(src, dst, force):
    """Returns (status, detail): "wrote", "skipped", or "FAILED".

    Everything is written to a temporary file and only moved into place once it
    has been checked, so a damaged archive can never leave a plausible-looking
    but broken cache in a player's game folder.
    """
    if os.path.exists(dst):
        if not force:
            return "skipped", "already exists (pass --force to replace it)"
        shutil.copy2(dst, dst + ".bak")
    os.makedirs(os.path.dirname(dst) or ".", exist_ok=True)
    tmp = dst + ".part"
    try:
        with gzip.open(src, "rb") as g, open(tmp, "wb") as f:
            shutil.copyfileobj(g, f, 1 << 20)
    except (OSError, EOFError, zlib.error) as e:
        # A truncated download raises EOFError, which is NOT an OSError: gzip
        # only discovers the stream ended early by running out of it. Catching
        # just OSError let that escape and strand a .part in the target folder.
        discard(tmp)
        return "FAILED", f"could not decompress: {type(e).__name__}: {e}"
    ok, detail = check_wdb(tmp, dst.endswith(".wdb"))
    if not ok:
        discard(tmp)
        return "FAILED", detail
    os.replace(tmp, dst)
    return "wrote", detail or size(os.path.getsize(dst))


def do_mode(data, slug, into, force):
    src_dir = os.path.join(data, "wdb", slug)
    if not os.path.isdir(src_dir):
        avail = modes_available(data)
        print(f"!! no such mode: {slug}")
        if avail:
            print("   available: " + ", ".join(avail))
        return 1
    files = sorted(glob.glob(os.path.join(src_dir, "*.wdb.gz")))
    if not files:
        print(f"!! {slug} holds no caches")
        return 1

    out_dir = into or src_dir
    if into and not os.path.isdir(into):
        # A folder that does not exist usually means a typo or a mode the client
        # has never connected to; creating it silently would hide both.
        print(f"!! that folder does not exist:\n   {into}")
        print("   The client creates it on first login to that realm and mode.")
        print("   Check the path, or pass --force to create it anyway.")
        if not force:
            return 1
        os.makedirs(into, exist_ok=True)

    if into:
        want = slug.replace("-", " ")
        got = os.path.basename(os.path.normpath(into)).lower()
        if want.split()[0] not in got.replace("-", " "):
            print(f"   note: that folder is named {os.path.basename(os.path.normpath(into))!r},")
            print(f"         which does not look like the '{slug}' mode. Caches from one")
            print( "         mode in another mode's folder give the client wrong values.")

    print(f"\n{slug} -> {out_dir}")
    rc = 0
    for src in files:
        dst = os.path.join(out_dir, os.path.basename(src)[:-3])   # drop .gz
        status, detail = unpack_one(src, dst, force)
        print(f"  {status:<8} {os.path.basename(dst):<20} {detail}")
        if status == "FAILED":
            rc = 1
    if into:
        print("\nClose the game before it next exits, or it will rewrite these files.")
    return rc


def do_all(data, force):
    files = []
    for dp, _d, fs in os.walk(data):
        for fn in fs:
            if fn.endswith(".gz"):
                files.append(os.path.join(dp, fn))
    total = sum(os.path.getsize(f) for f in files)
    print(f"unpacking {len(files)} file(s), {size(total)} compressed "
          f"(roughly {size(total * 7)} on disk when done)")
    rc = 0
    for src in sorted(files):
        dst = src[:-3]
        status, detail = unpack_one(src, dst, force)
        rel = os.path.relpath(dst, data).replace(os.sep, "/")
        print(f"  {status:<8} {rel:<50} {detail}")
        if status == "FAILED":
            rc = 1
    return rc


def do_list(data):
    print(f"dataset: {data}\n")
    modes = modes_available(data)
    if modes:
        print("game modes with rebuilt client caches (wdb/):")
        for m in modes:
            d = os.path.join(data, "wdb", m)
            n = len(glob.glob(os.path.join(d, "*.wdb.gz")))
            b = sum(os.path.getsize(p) for p in glob.glob(os.path.join(d, "*.gz")))
            print(f"  {m:<24} {n} cache(s), {size(b)}")
    packed = []
    for dp, _d, fs in os.walk(data):
        packed += [os.path.join(dp, f) for f in fs if f.endswith(".gz")]
    print(f"\n{len(packed)} compressed file(s), "
          f"{size(sum(os.path.getsize(p) for p in packed))} total")
    print("\n  python unpack.py --mode <mode>            unpack one mode here")
    print("  python unpack.py --mode <mode> --into DIR  ...into your client instead")
    print("  python unpack.py --all                     unpack everything")
    return 0


def main(argv=None):
    ap = argparse.ArgumentParser(
        description="Unpack the published Ascension cache dataset.")
    ap.add_argument("--data", default=DEFAULT_DATA,
                    help="the cachedata/ directory (default: beside this script)")
    ap.add_argument("--mode", help="game mode slug, e.g. conquest-of-azeroth")
    ap.add_argument("--into", help="write into this folder instead "
                                   '(your "<Realm> - <Mode>" cache folder)')
    ap.add_argument("--all", action="store_true", help="unpack the whole dataset")
    ap.add_argument("--force", action="store_true",
                    help="replace existing files, keeping a .bak of each")
    a = ap.parse_args(argv)

    data = os.path.abspath(a.data)
    if not os.path.isdir(data):
        print(f"!! no dataset at {data}\n   pass --data <path to cachedata>")
        return 1
    if a.all:
        return do_all(data, a.force)
    if a.mode:
        return do_mode(data, a.mode, a.into and os.path.abspath(a.into), a.force)
    return do_list(data)


if __name__ == "__main__":
    sys.exit(main())
