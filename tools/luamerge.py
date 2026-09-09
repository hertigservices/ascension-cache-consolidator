"""Merge addon SavedVariables (.lua) submissions, and write them back as .lua.

Why this is a separate stage from merge.py
------------------------------------------
A .wdb cache is a flat list of independent records, so merging is set union on a
record hash. A SavedVariables file is a *tree*, and different branches of the
same tree need opposite treatment:

    MobSpellsDB.global.mobs      server-observed combat data  -> merge and keep
    MobSpellsDB.profileKeys      "<Character> - <Realm> - <Mode>" -> pure PII
    AIO_sv_Addons                server-pushed addon code     -> merge and keep
    AIO_sv                       hotbars keyed by character   -> character state

So there is no generic "merge two lua files" operation. Each supported file gets
an explicit spec below saying which branch is the payload, how to combine two
readings of the same leaf, and what to drop. Anything not in the registry is not
published at all -- same allow-list rule as scrub.py, for the same reason.

Field-level merge, not newest-wins
----------------------------------
Unlike a .wdb record, a MobSpells entry is an *accumulator*: `amountMin` is the
smallest hit that submitter ever saw, not a fact about the item. Taking the
newest submission's value would throw away a wider range someone else observed.
So numeric bounds widen, booleans OR together, and only identity fields (name,
school) are treated as facts that should agree.

A caveat that must not be papered over: the addon stores its mob table
account-wide, with no record of which realm or game mode any observation came
from. The WDB caches can be split per mode because the client files them in a
per-mode folder; this data genuinely cannot. It is published unsplit and
documented as such.
"""
import os, sys, json, hashlib, time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import config, modes, luaser

STORE = os.path.join(config.STORE, "lua").replace("\\", "/")
STATE = os.path.join(STORE, "state.json").replace("\\", "/")
OUT = os.path.join(config.OUT, "lua").replace("\\", "/")

SCAN_ROOTS = config.SCAN_ROOTS + [config.EXTRACT]

# A leaf field is combined by one of these rules.
MIN, MAX, OR, FIRST, DROP = "min", "max", "or", "first", "drop"


def _rule_for(spec, field):
    return spec["fields"].get(field, spec.get("default", FIRST))


# --------------------------------------------------------------- the registry

SPECS = {
    # MobSpells: an addon that records what mobs cast and how hard they hit.
    # Nothing here comes from the client's own files -- it is observation of
    # server behaviour, which is exactly what is otherwise unrecoverable.
    "mobspells.lua": {
        "global": "MobSpellsDB",
        # path from the global down to the {zone: {entry: {...}}} payload
        "payload": ("global", "mobs"),
        # branches of the global that are the submitter's own data, never published
        "drop_branches": ("profileKeys", "profiles"),
        "fields": {
            # ephemeral per-session values with no preservation value; lastGUID
            # is also a live object GUID, which the publish audit rejects.
            "lastGUID": DROP,
            "lastTime": DROP,
            "amountMin": MIN, "minSpeed": MIN,
            "amountMax": MAX, "maxSpeed": MAX,
            "critical": OR, "resisted": OR, "missing": OR, "dodge": OR,
            "parry": OR, "glancing": OR, "blocked": OR, "resist": OR,
            "reflect": OR, "interruptable": OR, "immune": OR, "absorbed": OR,
            "school": FIRST, "schoolName": FIRST,
        },
        "default": FIRST,
    },
    # AIO pushes addon Lua from the server to the client and caches it here.
    # This is server-authored code -- the custom UI itself -- keyed by filename
    # with a CRC, so a differing CRC means a different server build.
    "aio_client.lua": {
        "global": "AIO_sv_Addons",
        "payload": (),
        "drop_branches": (),
        "fields": {},
        "default": FIRST,
        "variant_by": "crc",   # keep every distinct build, don't collapse them
    },
}

ALIASES = {"mobspells.lua.bak": "mobspells.lua",
           "aio_client.lua.bak": "aio_client.lua"}


def spec_for(filename):
    key = filename.lower()
    key = ALIASES.get(key, key)
    return key, SPECS.get(key)


# ------------------------------------------------------------------ discovery

def sha256(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def group_of(path):
    """Folder that gives this file its provenance, mirroring merge.py.

    SavedVariables live in WTF/Account/<acct>/SavedVariables/ (account-wide) or
    .../<Realm - Mode>/<Char>/SavedVariables/ (per character). The per-character
    one carries a mode; the account-wide one does not.
    """
    parts = path.replace("\\", "/").split("/")
    if "SavedVariables" in parts:
        i = parts.index("SavedVariables")
        if i >= 1:
            prev = parts[i - 1]
            # WTF/Account/<acct>/SavedVariables -> account-wide, no mode
            if i >= 2 and parts[i - 2].lower() == "account":
                return ""
            return prev
    # A file dropped loose into the inbox has no provenance folder at all. Its
    # containing directory is our own bookkeeping ("archive"), not a realm, and
    # returning it would invent a game mode that was never observed.
    if os.path.abspath(path).startswith(os.path.abspath(config.INBOX)):
        return ""
    return os.path.basename(os.path.dirname(path))


def discover():
    """Every .lua under the scan roots that we have a spec for."""
    found = []
    seen = set()
    for root in SCAN_ROOTS:
        if not os.path.isdir(root):
            continue
        for dp, _d, fs in os.walk(root):
            for fn in fs:
                if not fn.lower().endswith((".lua", ".lua.bak")):
                    continue
                key, spec = spec_for(fn)
                if not spec:
                    continue
                p = os.path.join(dp, fn).replace("\\", "/")
                rp = os.path.realpath(p)
                if rp in seen:
                    continue
                seen.add(rp)
                found.append((key, p))
    return sorted(found)


# --------------------------------------------------------------------- merge

def combine(rule, old, new):
    if rule == DROP:
        return None
    if old is None:
        return new
    if new is None:
        return old
    try:
        if rule == MIN:
            return min(old, new)
        if rule == MAX:
            return max(old, new)
    except TypeError:
        return old          # mixed types: keep what we had rather than guess
    if rule == OR:
        return bool(old) or bool(new)
    return old              # FIRST


def merge_leaf(spec, dst, src_table, conflicts, where):
    """Fold one leaf table (a spell's stats) into the accumulated dict."""
    for k, v in src_table.hash.items():
        rule = _rule_for(spec, k)
        if rule == DROP:
            continue
        if isinstance(v, luaser.Table):
            continue        # no nested tables at this level in any known spec
        if rule == FIRST and k in dst and dst[k] != v:
            conflicts.append((where + (k,), dst[k], v))
            continue
        merged = combine(rule, dst.get(k), v)
        if merged is not None:
            dst[k] = merged


def merge_mobspells(state, tree, sid, conflicts):
    spec = SPECS["mobspells.lua"]
    node = tree
    for step in spec["payload"]:
        if not isinstance(node, luaser.Table):
            return 0
        node = node.get(step)
    if not isinstance(node, luaser.Table):
        return 0
    store = state.setdefault("mobspells", {})
    n = 0
    for zone, zt in node.hash.items():
        if not isinstance(zt, luaser.Table):
            continue
        z = store.setdefault(str(zone), {})
        for entry, mt in zt.hash.items():
            if not isinstance(mt, luaser.Table):
                continue
            rec = z.setdefault(str(entry), {"name": None, "spells": {}, "srcs": []})
            name = mt.get("name")
            if isinstance(name, str):
                if rec["name"] is None:
                    rec["name"] = name
                elif rec["name"] != name:
                    conflicts.append((("mob", zone, entry, "name"), rec["name"], name))
            spells = mt.get("spells")
            if isinstance(spells, luaser.Table):
                for spell, st in spells.hash.items():
                    if not isinstance(st, luaser.Table):
                        continue
                    d = rec["spells"].setdefault(str(spell), {})
                    merge_leaf(spec, d, st, conflicts, ("mob", zone, entry, spell))
                    n += 1
            if sid not in rec["srcs"]:
                rec["srcs"].append(sid)
    return n


def merge_aio(state, tree, sid, conflicts):
    if not isinstance(tree, luaser.Table):
        return 0
    store = state.setdefault("aio", {})
    n = 0
    for fname, ft in tree.hash.items():
        if not isinstance(ft, luaser.Table):
            continue
        code, crc = ft.get("code"), ft.get("crc")
        if not isinstance(code, str):
            continue
        # Variant key is the code's own hash: two servers that pushed identical
        # code collapse to one entry even if the addon recorded a different crc.
        vid = hashlib.sha1(code.encode("utf-8")).hexdigest()[:16]
        v = store.setdefault(str(fname), {}).setdefault(vid, {
            "code": code, "crc": crc, "srcs": [], "bytes": len(code)})
        if sid not in v["srcs"]:
            v["srcs"].append(sid)
        n += 1
    return n


MERGERS = {"mobspells.lua": merge_mobspells, "aio_client.lua": merge_aio}


def load_state():
    if os.path.exists(STATE):
        with open(STATE, encoding="utf-8") as f:
            return json.load(f)
    return {"sources": {}}


def save_state(state):
    os.makedirs(STORE, exist_ok=True)
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8", newline="\n") as f:
        json.dump(state, f, indent=1, sort_keys=True, ensure_ascii=False)
    os.replace(tmp, STATE)


def run_merge():
    state = load_state()
    files = discover()
    conflicts, added, skipped = [], 0, 0
    print(f"{len(files)} SavedVariables files match a known spec")
    for key, path in files:
        sid = sha256(path)
        prev = state["sources"].get(sid)
        # A file that failed to parse is retried on every run: the usual reason
        # for the failure is a gap in our parser, so improving the parser has to
        # be enough to pick the file up without hand-clearing the store.
        if prev is not None and not prev.get("error"):
            skipped += 1
            continue
        try:
            g = luaser.load(path)
        except luaser.LuaError as e:
            # A hand-edited file (e.g. one a submitter redacted by hand) is no
            # longer valid Lua. Report it rather than dropping it silently.
            print(f"  UNPARSEABLE {os.path.basename(path)}: {e}")
            state["sources"][sid] = {"filename": os.path.basename(path),
                                     "spec": key, "error": str(e), "records": 0}
            continue
        spec = SPECS[key]
        tree = g.get(spec["global"])
        if tree is None:
            print(f"  no {spec['global']} in {os.path.basename(path)}, skipping")
            continue
        grp = group_of(path)
        cls = modes.classify(grp) if grp else {"realm": "", "mode": "unknown",
                                               "slug": "unknown", "source": "account-wide"}
        n = MERGERS[key](state, tree, sid, conflicts)
        state["sources"][sid] = {
            "filename": os.path.basename(path), "spec": key,
            "group": grp, "realm": cls["realm"], "mode": cls["mode"],
            "slug": cls["slug"], "records": n,
            "captured": time.strftime("%Y-%m-%d", time.gmtime(os.path.getmtime(path))),
        }
        added += 1
        print(f"  + {os.path.basename(path):<24} {n:>6,} leaves   "
              f"{cls['realm'] or '(account-wide)'} / {cls['mode']}")
    save_state(state)
    print(f"\n{added} new, {skipped} already merged, {len(conflicts)} field conflicts")
    for path, a, b in conflicts[:10]:
        print(f"  conflict {'.'.join(str(x) for x in path)}: {a!r} vs {b!r}")
    if len(conflicts) > 10:
        print(f"  ... and {len(conflicts) - 10} more")
    return state


# --------------------------------------------------------------------- export

def T(mapping=None, array=None):
    return luaser.table_from(mapping, array)


def _key(s):
    """Restore an integer key that JSON turned into a string."""
    try:
        return int(s)
    except ValueError:
        return s


def write_mobspells(state):
    store = state.get("mobspells") or {}
    if not store:
        return None
    mobs = T()
    n_mobs = n_spells = 0
    for zone, entries in store.items():
        zt = T()
        for entry, rec in entries.items():
            spells = T()
            for spell, d in rec["spells"].items():
                spells.hash[_key(spell)] = T({k: v for k, v in d.items()})
                n_spells += 1
            mt = T({"spells": spells})
            if rec.get("name"):
                mt.hash["name"] = rec["name"]
            zt.hash[_key(entry)] = mt
            n_mobs += 1
        mobs.hash[_key(zone)] = zt
    # profileKeys/profiles are omitted entirely; AceDB recreates them on load.
    db = T({"global": T({"mobs": mobs})})
    path = os.path.join(OUT, "MobSpells.lua").replace("\\", "/")
    luaser.dump({"MobSpellsDB": db}, path)
    return path, n_mobs, n_spells


def write_aio(state):
    store = state.get("aio") or {}
    if not store:
        return None
    addons = T()
    n_files = n_variants = 0
    extra = {}
    for fname, variants in store.items():
        # The client's own format holds one build per filename, so the merged
        # file carries the most-corroborated variant and the rest go beside it.
        best = max(variants.items(), key=lambda kv: (len(kv[1]["srcs"]), kv[0]))
        vid, v = best
        addons.hash[fname] = T({"name": fname, "crc": v["crc"], "code": v["code"]})
        n_files += 1
        n_variants += len(variants)
        if len(variants) > 1:
            extra[fname] = {k: {"crc": d["crc"], "bytes": d["bytes"],
                                "sources": len(d["srcs"])}
                            for k, d in variants.items()}
    path = os.path.join(OUT, "AIO_Client.lua").replace("\\", "/")
    # AIO_sv (hotbars, frame positions, character names) is deliberately absent.
    luaser.dump({"AIO_sv_Addons": addons}, path)
    if extra:
        with open(os.path.join(OUT, "AIO_Client.variants.json"), "w",
                  encoding="utf-8", newline="\n") as f:
            json.dump(extra, f, indent=1, sort_keys=True)
    return path, n_files, n_variants


def run_export(state):
    os.makedirs(OUT, exist_ok=True)
    print()
    r = write_mobspells(state)
    if r:
        path, n_mobs, n_spells = r
        print(f"MobSpells.lua   {n_mobs:,} creatures, {n_spells:,} spell records"
              f"  ({os.path.getsize(path):,} B)")
    r = write_aio(state)
    if r:
        path, n_files, n_variants = r
        print(f"AIO_Client.lua  {n_files:,} server-pushed addon files"
              f" ({n_variants:,} distinct builds seen)  ({os.path.getsize(path):,} B)")
    verify()


def verify():
    """Re-read what we just wrote. A file the client cannot parse is worthless,
    and the only cheap proof we have is parsing it back ourselves."""
    bad = 0
    for fn in sorted(os.listdir(OUT)):
        if not fn.endswith(".lua"):
            continue
        p = os.path.join(OUT, fn)
        try:
            g = luaser.load(p)
        except luaser.LuaError as e:
            print(f"  VERIFY FAILED {fn}: {e}")
            bad += 1
            continue
        if luaser.dumps(g) != open(p, encoding="utf-8").read():
            print(f"  VERIFY FAILED {fn}: not stable under re-serialisation")
            bad += 1
    print("re-parsed written .lua files: " + ("OK" if not bad else f"{bad} FAILED"))
    return bad == 0


if __name__ == "__main__":
    st = run_merge()
    run_export(st)
