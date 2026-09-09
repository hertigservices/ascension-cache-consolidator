"""Generate a controlled in-game test that the merged caches actually work.

`selftest.py` proves the published files hold exactly the bytes real clients
wrote. It cannot prove the game will read them -- only the game can say that,
and "I loaded it and the game didn't crash" is not evidence of anything.

So this builds a proper controlled experiment. It picks two sets of item ids:

  * **probes** -- items that ARE in the merged cache for the mode you chose,
    preferring Ascension's own custom items, because no stock 3.3.5a data and
    no other realm could possibly supply those names.
  * **controls** -- ids that are in NO cache we publish and no stock item
    range.  These must stay unresolved the whole way through.

You then run the same macro twice: once before installing the cache, once
after. The cache is the only thing that changed between the two runs.

    before          after           what it means
    ----------------------------------------------------------------------
    all MISS        real names      the client read our cache.  This is the
                                    result you want.
    all MISS        all MISS        the client ignored or rejected the file
    real names      real names      the SERVER is answering, not the cache --
                                    the test proved nothing, use a realm that
                                    does not have these items
    controls named  anything        something is answering for ids nobody has;
                                    the test is not sound, tell us

Expected names are printed with the test, so this checks the data is *right*
and not merely that something appeared.

    python tools/gametest.py                    use the biggest mode
    python tools/gametest.py --mode free-pick   pick one
    python tools/gametest.py --count 8
"""
import os, sys, io, gzip, random, argparse

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import config

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BYMODE = os.path.join(config.OUT, "by-mode").replace("\\", "/")

# Stock 3.3.5a items stop well below this. An id above it can only have come
# from Ascension's own content, which is what makes it a good probe: nothing
# except our cache could tell the client that name.
CUSTOM_FROM = 60000


def modes():
    if not os.path.isdir(BYMODE):
        return []
    return sorted(d for d in os.listdir(BYMODE)
                  if os.path.exists(f"{BYMODE}/{d}/itemcache.tsv.gz"))


def items(slug):
    """(entry, name) for every item in one mode's published cache."""
    out = []
    with gzip.open(f"{BYMODE}/{slug}/itemcache.tsv.gz", "rt",
                   encoding="utf-8", errors="replace") as f:
        cols = f.readline().rstrip("\n").split("\t")
        ie, iname = cols.index("entry"), cols.index("name")
        for line in f:
            r = line.rstrip("\n").split("\t")
            if len(r) <= iname:
                continue
            name = r[iname].strip()
            # An item with no name is useless as a probe: "did a name appear?"
            # is the whole question, so a blank answer cannot be scored.
            if name and r[ie].isdigit():
                out.append((int(r[ie]), name))
    return out


def every_published_id():
    """Every item id in any mode -- so a control id is absent from all of them."""
    ids = set()
    for slug in modes():
        ids.update(e for e, _n in items(slug))
    return ids


def pick(slug, count, seed):
    rng = random.Random(seed)
    have = items(slug)
    if not have:
        return [], []
    # Prefer custom ids; fall back to whatever the mode has if it holds none.
    custom = [x for x in have if x[0] >= CUSTOM_FROM]
    pool = custom if len(custom) >= count else have
    # A name with a quote or a brace in it breaks the macro it gets pasted into.
    pool = [x for x in pool if not set(x[1]) & set('"\'\\{}')]
    probes = rng.sample(pool, min(count, len(pool)))

    taken = every_published_id()
    controls, guard = [], 0
    while len(controls) < count and guard < 100000:
        guard += 1
        c = rng.randint(400000, 900000)
        if c not in taken:
            controls.append(c)
            taken.add(c)
    return probes, sorted(controls)


def macro(ids):
    """One line to paste into the chat box. 3.3.5a caps that at 255 characters."""
    return ("/run for _,i in ipairs({%s}) do local n=GetItemInfo(i) print(i,n or \"MISS\") end"
            % ",".join(str(i) for i in ids))


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--mode", help="which published game mode to test")
    ap.add_argument("--count", type=int, default=5, help="ids per set (default 5)")
    ap.add_argument("--seed", type=int, default=0,
                    help="same seed gives the same ids, so a second person can "
                         "repeat your exact test")
    a = ap.parse_args(argv)

    avail = modes()
    if not avail:
        print("no published per-mode item data found; run tools/update.py first")
        return 1
    slug = a.mode or max(avail, key=lambda s: os.path.getsize(
        f"{BYMODE}/{s}/itemcache.tsv.gz"))
    if slug not in avail:
        print(f"unknown mode {slug!r}. Available: {', '.join(avail)}")
        return 1

    probes, controls = pick(slug, a.count, a.seed)
    if not probes:
        print(f"mode {slug!r} has no usable items to probe with")
        return 1

    W = 70
    print("=" * W)
    print(f"IN-GAME TEST for mode: {slug}")
    print("=" * W)
    print()
    print("STEP 1  With NO merged cache installed, log in and paste this into")
    print("        the chat box. Write down what it prints.")
    print()
    print("  " + macro([p[0] for p in probes]))
    print()
    print("        Expected now: every line says MISS.")
    print("        If any of them already prints a name, the realm you are on")
    print("        knows these items and the test cannot prove anything --")
    print("        pick a different mode, or a realm without this content.")
    print()
    print("        WATCH OUT for the case that looks fine and is not: if the")
    print("        realm's own item_template was built FROM this dataset (or")
    print("        from the same harvest), its server can answer for every id")
    print("        we publish, so no mode and no id will ever be a valid probe")
    print("        there. Such a realm cannot test this data at all -- the")
    print("        server answers first and the cache is never opened. Use a")
    print("        realm whose database has a different provenance.")
    print()
    print("STEP 2  QUIT THE GAME TO DESKTOP FIRST. This matters: the client")
    print("        rewrites its cache files when it exits, so anything copied")
    print("        in while it is running gets overwritten on the way out and")
    print("        you would be testing your own old cache.")
    print()
    print("        With the game closed, install the merged cache:")
    print()
    print(f"  python tools/unpack.py --mode {slug} --into \"<your WoW>/Cache/WDB/enUS/<Realm - Mode>\"")
    print()
    print("        That last folder must be the one the client made for the")
    print("        realm you are about to log into -- the caches are read per")
    print("        realm and mode, and the wrong folder is simply not read.")
    print("        unpack.py will say so if the name looks wrong.")
    print()
    print("STEP 3  Log in and paste the SAME line again.")
    print()
    print("        Expected now, exactly:")
    for e, n in probes:
        print(f"          {e}  {n}")
    print()
    print("STEP 4  The control. Paste this one at both steps 1 and 3.")
    print()
    print("  " + macro(controls))
    print()
    print("        Expected: MISS every time, before and after. These ids are")
    print("        in no cache we publish. If they resolve, something else is")
    print("        answering and steps 1-3 proved nothing.")
    print()
    print("-" * W)
    print("PASS means: step 1 all MISS, step 3 the exact names above, step 4")
    print("MISS throughout. That is the client reading our file and nothing")
    print("else -- the cache is the only thing that changed between the runs.")
    print("-" * W)
    print()
    print("Note for a second run: once you quit after step 3 the client will")
    print("have rewritten those cache files with its own copy, so re-install")
    print("them before testing again.")
    print()
    print(f"(seed {a.seed} -- anyone running this with the same seed and mode")
    print(" gets the same ids, so results can be compared.)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
