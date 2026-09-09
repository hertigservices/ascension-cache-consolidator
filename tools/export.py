"""Turn the merged record store into a publishable dataset tree.

Three views over the same merged records, because they answer different questions:

  by-mode/<mode>/<cache>.tsv   what a client running THAT mode was actually sent.
                               Authoritative for values: Ascension tunes the same
                               item differently per mode, so this is the table to
                               import if you care about numbers.
  union/<cache>.tsv            widest coverage -- every entry we have ever seen,
                               newest capture wins, with the mode and date it came
                               from in _modes/_captured.  Use it to answer "does
                               entry N exist", not "what are its stats on my realm".
  raw/<cache>.pack.gz          lossless.  Every distinct payload, byte for byte, so
                               a better decoder can be run over it later without
                               re-collecting anything.  Deterministic ordering, so
                               regenerating an unchanged store produces an identical
                               file and git sees no diff.

Winner rule within a view: newest last_captured, ties broken on sha1 so output is
stable.  Losing variants are never deleted -- they stay in raw/ and in the index.
"""
import os, sys, gzip, json, struct, time, collections

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, modes, merge, scrub, config
import wdb_decode_items, wdb_decode_creature, wdb_decode_gameobject
import wdb_decode_quest, wdb_decode_pagetext, wdb_decode_npctext_full

STORE = merge.STORE
OUT   = config.OUT


def decode_itemname(entry, payload):
    """[cstr Name][u32 InventoryType] -- verified exact-consumption on all 2,413.
    Returns (row, consumed) like every other decoder."""
    z = payload.find(b"\x00")
    if z < 0:
        return {"entry": entry, "name": "", "InventoryType": 0}, 0
    name = wdblib.decode_str(payload[:z])
    inv = struct.unpack_from("<I", payload, z + 1)[0] if z + 5 <= len(payload) else 0
    return {"entry": entry, "name": name.replace("\t", " "), "InventoryType": inv}, z + 5


DECODERS = {
    "itemcache":       (wdb_decode_items.decode_item,          wdb_decode_items.COLS),
    "creaturecache":   (wdb_decode_creature.decode_creature,   wdb_decode_creature.COLS),
    "gameobjectcache": (wdb_decode_gameobject.decode_go,       wdb_decode_gameobject.COLS),
    "questcache":      (wdb_decode_quest.decode_quest,         wdb_decode_quest.OUT_COLS),
    "pagetextcache":   (wdb_decode_pagetext.decode_pagetext,   wdb_decode_pagetext.COLS),
    "npccache":        (wdb_decode_npctext_full.decode_npctext, wdb_decode_npctext_full.COLS),
    "itemnamecache":   (decode_itemname,       ["entry", "name", "InventoryType"]),
}

PROV = ["_modes", "_captured", "_sources"]

# Plain-language purpose of every cache file, for someone arriving with no context.
# (opcode the client stored, what the file is for, what it does NOT contain)
CACHE_PURPOSE = {
    "itemcache": (
        "SMSG_ITEM_QUERY_SINGLE_RESPONSE",
        "Item definitions: name, icon, quality, item level, stats, damage, price, "
        "and on-use spells. The client writes one record each time it asks the server "
        "\"what is item N?\", so it never has to ask twice. This is what lets tooltips, "
        "bags and the auction house draw an item the moment you see it.",
        "Not loot tables, not drop sources, not where an item comes from."),
    "creaturecache": (
        "SMSG_CREATURE_QUERY_RESPONSE",
        "NPC and mob identity: name, the title under the name, creature type, family, "
        "rank (normal/elite/boss) and up to four display models. Written when the "
        "client first sees a creature and needs to label it.",
        "A thin slice only — no level, faction, health, loot or AI. Those never leave "
        "the server, so no cache can contain them."),
    "gameobjectcache": (
        "SMSG_GAMEOBJECT_QUERY_RESPONSE",
        "World objects: doors, chests, ore veins, herbs, mailboxes, campfires. Holds "
        "the object's type, display model, name, and 24 type-specific data fields "
        "(lock id, loot id, spell focus, and so on).",
        "Not placements. No cache records where objects stand in the world."),
    "questcache": (
        "SMSG_QUEST_QUERY_RESPONSE",
        "Quest text and structure: title, objectives, description, completion text, "
        "required kills and items, and rewards. Written when the client opens a quest.",
        "Not quest chains or availability conditions."),
    "npccache": (
        "SMSG_NPC_TEXT_UPDATE",
        "The gossip text an NPC greets you with. Eight alternative blocks per entry, "
        "each with a probability, male and female wording, language and emotes.",
        "Not vendor stock, not trainer lists."),
    "pagetextcache": (
        "SMSG_PAGE_TEXT_QUERY_RESPONSE",
        "The body text of readable objects — books, signs, letters on the ground. Pages "
        "chain together through NextPageId.",
        "Not the item that holds the book; that is in itemcache."),
    "itemnamecache": (
        "SMSG_ITEM_NAME_QUERY_RESPONSE",
        "A minimal item record: name and inventory slot only. The client uses it where "
        "it needs to label an item it has never fully queried, such as in search results.",
        "Deliberately tiny — no stats. Use itemcache for anything real."),
    "itemtextcache": (
        "SMSG_ITEM_TEXT_QUERY_RESPONSE",
        "The written body of mail and letters the player has read.",
        "NEVER PUBLISHED. This is other players' correspondence, not game data."),
    "wowcache": (
        "(undocumented)",
        "A small misc client cache whose format we have not verified.",
        "NEVER PUBLISHED while its contents are unconfirmed."),
}


def load_cache(cache):
    """[(entry, sha1, row, payload)] for one cache type, sorted."""
    idx = merge.read_tsv(f"{STORE}/{cache}/index.tsv", merge.IDX_COLS)
    if not idx:
        return []
    with open(f"{STORE}/{cache}/pack.bin", "rb") as f:
        blob = f.read()
    out = []
    for r in idx:
        off, size = int(r["offset"]), int(r["size"])
        payload = blob[off + 8: off + 8 + size]
        out.append((int(r["entry"]), r["sha1"], r, payload))
    out.sort(key=lambda t: (t[0], t[1]))
    return out


def pick_winners(recs, mode=None):
    """entry -> (sha1, row, payload); newest capture wins, sha1 breaks ties."""
    by_entry = collections.defaultdict(list)
    for entry, sha1, r, payload in recs:
        if mode is not None and mode not in r["modes"].split(","):
            continue
        by_entry[entry].append((sha1, r, payload))
    return {e: max(v, key=lambda t: (t[1]["last_captured"], t[0]))
            for e, v in by_entry.items()}


def write_view(path, cache, winners, note_cols=True):
    """Write one decoded view. Every decoder returns (row, consumed_bytes); a correct
    field layout consumes EXACTLY the payload, so anything else is a decode failure
    and is counted, not silently written."""
    fn, cols = DECODERS[cache]
    allcols = list(cols) + (PROV if note_cols else [])
    os.makedirs(os.path.dirname(path), exist_ok=True)
    bad = inexact = 0
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\t".join(allcols) + "\n")
        for entry in sorted(winners):
            sha1, r, payload = winners[entry]
            try:
                res = fn(entry, payload)
                d, consumed = res[0], res[1]
            except Exception:
                bad += 1
                continue
            if consumed != len(payload):
                inexact += 1
            if note_cols:
                d = dict(d)
                d["_modes"] = r["modes"]
                d["_captured"] = r["last_captured"]
                d["_sources"] = len(r["srcs"].split(","))
            f.write("\t".join(str(d.get(c, "")).replace("\t", " ").replace("\n", " ")
                              for c in allcols) + "\n")
    return len(winners), bad, inexact


def main():
    t0 = time.time()
    os.makedirs(OUT, exist_ok=True)
    srcs = merge.read_tsv(merge.SOURCES, merge.SRC_COLS)
    caches = sorted(d for d in os.listdir(STORE)
                    if os.path.isdir(f"{STORE}/{d}") and d in DECODERS)

    # every mode slug that actually carries records
    slugs = sorted({s["slug"] for s in srcs if s["slug"] and s["records"] != "0"})
    stats = collections.defaultdict(dict)      # cache -> view -> (rows, bad)
    mode_rows = collections.defaultdict(dict)  # slug -> cache -> rows

    for cache in caches:
        recs = load_cache(cache)
        if not recs:
            continue
        # ---- union -----------------------------------------------------------
        w = pick_winners(recs)
        stats[cache]["union"] = write_view(f"{OUT}/union/{cache}.tsv", cache, w)
        # ---- per mode --------------------------------------------------------
        for slug in slugs:
            wm = pick_winners(recs, mode=slug)
            if not wm:
                continue
            write_view(f"{OUT}/by-mode/{slug}/{cache}.tsv", cache, wm)
            mode_rows[slug][cache] = len(wm)
        # ---- raw, deterministic ---------------------------------------------
        os.makedirs(f"{OUT}/raw", exist_ok=True)
        buf = bytearray()
        for entry, sha1, r, payload in recs:      # already sorted (entry, sha1)
            buf += struct.pack("<II", entry, len(payload)) + payload
        # mtime=0 so an unchanged store gzips to an identical file (no git churn)
        with gzip.GzipFile(f"{OUT}/raw/{cache}.pack.gz", "wb", 9, mtime=0) as g:
            g.write(bytes(buf))
        merge.write_tsv(f"{OUT}/raw/{cache}.index.tsv",
                        ["entry", "sha1", "size", "modes", "first_captured",
                         "last_captured", "n_sources"],
                        [{"entry": e, "sha1": s, "size": r["size"],
                          "modes": r["modes"], "first_captured": r["first_captured"],
                          "last_captured": r["last_captured"],
                          "n_sources": len(r["srcs"].split(","))}
                         for e, s, r, _p in recs])
        stats[cache]["records"] = len(recs)
        rows, bad, inexact = stats[cache]["union"]
        flag = "" if not (bad or inexact) else f"  !! {bad} failed, {inexact} inexact"
        print(f"  {cache:<18} union {rows:>6}  distinct {len(recs):>6}{flag}")

    # Provenance must not carry this machine's layout. Keep the path RELATIVE to the
    # archive root -- still says which submission a record came from, names no one.
    pub_srcs = []
    for s in srcs:
        s = dict(s)
        p = s["path"].replace("\\", "/")
        for prefix in (config.WORK + "/", os.path.dirname(config.WORK) + "/"):
            if p.startswith(prefix):
                p = p[len(prefix):]
                break
        s["path"] = scrub.scrub_path(p)
        pub_srcs.append(s)
    merge.write_tsv(f"{OUT}/sources.tsv", merge.SRC_COLS, pub_srcs)
    write_docs(OUT, caches, slugs, stats, mode_rows, srcs)
    write_file_guide(OUT, stats)
    print(f"\nexported -> {OUT}  ({time.time()-t0:.0f}s)")


def write_file_guide(out, stats):
    """What every file in this dataset is, in plain language, for a reader who has
    never opened a WDB and is not running any of our tooling."""
    L = ["# What each file is\n",
         "A short guide to every kind of file here — what the game used it for, what it",
         "contains, and what it deliberately does not. No tooling required to read this.\n",
         "## Where this data comes from\n",
         "The WoW client keeps a folder called `Cache\\WDB`. Whenever the server tells it",
         "about something — an item, a creature, a quest — the client writes that answer",
         "to disk so it never has to ask again. Those files are what players submitted.\n",
         "Two consequences shape everything here:\n",
         "1. **A cache only holds what that player actually looked at.** Nobody's cache is",
         "   complete. Merging many of them is the only way to approach full coverage.",
         "2. **A cache holds what the server said _at the time_.** When Ascension retunes",
         "   an item, older caches keep the older values. Both readings were true; they",
         "   are kept as variants rather than one silently overwriting the other.\n",
         "## The cache files\n"]
    for cache, (opcode, what, notnot) in CACHE_PURPOSE.items():
        n = stats.get(cache, {}).get("records")
        head = f"### `{cache}.wdb`"
        if n:
            head += f"  — {n:,} distinct records held"
        L += [head, "", f"*Stored from:* `{opcode}`", "", what, "",
              f"**Not in this file:** {notnot}", ""]
    L += ["## File formats in this repository\n",
          "| file | format | read it with |",
          "|---|---|---|",
          "| `wdb/<mode>/*.wdb` | the client's own binary cache format | the game client, "
          "or any WDB reader |",
          "| `by-mode/<mode>/*.tsv` | tab-separated text, one row per entry | Excel, "
          "`pandas`, `LOAD DATA INFILE` |",
          "| `union/*.tsv` | same, widest coverage across all modes | as above |",
          "| `raw/*.pack.gz` | gzipped `[entry u32][size u32][payload]` records | any "
          "language; no header to skip |",
          "| `raw/*.index.tsv` | one row per stored record with its sha1 and provenance | "
          "text editor |",
          "| `sources.tsv` | every submitted file: realm, mode, capture date, counts | "
          "text editor |\n",
          "The `.wdb` files are the ones to use if you just want a better cache. The TSVs",
          "are for importing into a database. The `raw/` packs are for writing your own",
          "decoder without having to re-collect anything.\n"]
    with open(f"{out}/FILE-GUIDE.md", "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")


def write_docs(out, caches, slugs, stats, mode_rows, srcs):
    fam = {}
    for s in srcs:
        if s["slug"]:
            fam[s["slug"]] = modes.MODE_TABLE.get(s["mode"], (s["slug"], s["slug"], ""))[1]
    L = ["# Ascension client cache — merged dataset\n",
         f"_Regenerated {time.strftime('%Y-%m-%d %H:%M')} from "
         f"{len({s['sha256'] for s in srcs})} distinct submitted cache files._\n",
         "Community-submitted `Cache\\WDB` folders from the Ascension WoW client, merged",
         "at the **record** level. Identical records collapse to one row no matter how",
         "many people submitted them; genuinely different records for the same entry are",
         "kept as variants rather than overwritten, because Ascension tunes the same",
         "entry differently per game mode and between patches.\n",
         "## Layout\n",
         "| path | what it is |",
         "|---|---|",
         "| `by-mode/<mode>/<cache>.tsv` | what a client on that mode was sent. **Use this for values.** |",
         "| `union/<cache>.tsv` | widest coverage, newest capture wins. Use for existence, not stats. |",
         "| `raw/<cache>.pack.gz` | lossless payloads, `[entry u32][size u32][payload]`. |",
         "| `raw/<cache>.index.tsv` | per record: sha1, size, modes, capture dates, corroboration count. |",
         "| `sources.tsv` | every submitted file: realm, mode, capture date, record count. |\n",
         "`_modes` / `_captured` / `_sources` columns on each row carry provenance:",
         "which modes produced that exact record, its newest capture date, and how many",
         "independent submissions corroborate it.\n",
         "## Coverage per cache type\n",
         "| cache | distinct records | union entries |", "|---|---:|---:|"]
    for c in caches:
        if "union" in stats[c]:
            L.append(f"| {c} | {stats[c]['records']:,} | {stats[c]['union'][0]:,} |")
    L += ["", "## Game modes\n",
          "| mode | family | " + " | ".join(caches) + " |",
          "|---|---|" + "---:|" * len(caches)]
    for slug in slugs:
        row = " | ".join(f"{mode_rows[slug].get(c, 0):,}" for c in caches)
        L.append(f"| `{slug}` | {fam.get(slug, slug)} | {row} |")
    L += ["", "`free-pick`, `season-10-freepick` and `live-qa` are the same ruleset in",
          "different seasons — compare them, don't assume they agree; the item tuning",
          "genuinely changed between seasons.\n",
          "## Caveats\n",
          "- Capture date is the cache file's mtime: when that player's client last wrote",
          "  it, an upper bound on record age. There is no per-record timestamp in a WDB.",
          "- A cache only holds what that player actually looked at, so every submission",
          "  is a partial view. Coverage grows as more are merged.",
          "- Submissions zipped from above the realm folder lose their mode. Those are",
          "  re-identified by payload fingerprint against known-mode data and marked",
          "  `inferred:<agreement>/<entries compared>` in `sources.tsv`.",
          "- Strings are decoded UTF-8 first (the client writes UTF-8); a latin1 read",
          "  mangles every apostrophe and accent.\n"]
    with open(f"{out}/README.md", "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")


if __name__ == "__main__":
    main()
