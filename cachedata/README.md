# Ascension client cache — merged dataset

_Merged from 1850 distinct submitted cache files, the newest captured 2026-09-10._

Community-submitted `Cache\WDB` folders from the Ascension WoW client, merged
at the **record** level. Identical records collapse to one row no matter how
many people submitted them; genuinely different records for the same entry are
kept as variants rather than overwritten, because Ascension tunes the same
entry differently per game mode and between patches.

## Layout

| path | what it is |
|---|---|
| `wdb/<mode>/<cache>.wdb.gz` | merged caches in the client's own format. Drop them into your game. |
| `by-mode/<mode>/<cache>.tsv.gz` | what a client on that mode was sent. **Use this for values.** |
| `union/<cache>.tsv.gz` | widest coverage, newest capture wins. Use for existence, not stats. |
| `raw/<cache>.pack.gz` | lossless payloads, `[entry u32][size u32][payload]`. |
| `raw/<cache>.index.tsv.gz` | per record: sha1, size, modes, capture dates, corroboration count. |
| `sources.tsv` | every submitted file: realm, mode, capture date, record count. |
| `lua/` | merged addon SavedVariables, and the server-pushed UI code. |
| `lua/stock-client/` | the item, creature and quest records as Lua 5.1 tables an addon on a **stock** client can load; `dbc/item_display_icons.tsv.gz` is the icon lookup they use. |
| `mapdata/` | which **server** map ids exist as extracted terrain, and the DBC set submitted with them. An inventory, never the terrain itself — that is derived data a server operator regenerates from their own client. |
| `lootcollector/` | where Worldforged items and Mystic Scrolls were picked up, read from players' LootCollector addon logs: item, zone, map position and server X/Y. A pin is where the looter stood, not the spawn, and has no height; `lootcollector/README.md` says the rest. |

**The data files are gzipped.** Uncompressed this dataset is ~756 MB and its
largest file is a 254 MB itemcache; GitHub rejects anything over 100 MB. Each
`.gz` holds one file — open it with 7-Zip, `gunzip`, or directly from code.
`python tools/unpack.py --mode <mode> --into <your cache folder>` does the
whole job for a game mode, without overwriting the cache you already have.

`_modes` / `_captured` / `_sources` columns on each row carry provenance:
which modes produced that exact record, its newest capture date, and how many
independent submissions corroborate it.

## Coverage per cache type

| cache | distinct records | union entries |
|---|---:|---:|
| creaturecache | 28,733 | 23,978 |
| gameobjectcache | 16,525 | 16,298 |
| itemcache | 659,462 | 553,740 |
| itemnamecache | 3,594 | 3,565 |
| npccache | 2,640 | 2,584 |
| pagetextcache | 471 | 471 |
| questcache | 23,017 | 18,553 |

## Game modes

| mode | family | creaturecache | gameobjectcache | itemcache | itemnamecache | npccache | pagetextcache | questcache |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| `coa-alpha` | conquest-of-azeroth | 1,720 | 1,412 | 13,605 | 0 | 60 | 1 | 121 |
| `coa-beta` | conquest-of-azeroth | 5,977 | 5,467 | 20,616 | 90 | 344 | 23 | 849 |
| `conquest-of-azeroth` | conquest-of-azeroth | 17,696 | 12,641 | 432,820 | 2,970 | 2,134 | 458 | 18,550 |
| `free-pick` | free-pick | 20,607 | 14,956 | 93,676 | 2,828 | 1,794 | 258 | 3,879 |
| `live-qa` | free-pick | 0 | 0 | 398 | 0 | 0 | 0 | 210 |
| `season-10-freepick` | free-pick | 12,274 | 8,780 | 548,854 | 640 | 515 | 28 | 18,552 |
| `season-10-wildcard` | wildcard | 10,776 | 7,964 | 40,427 | 731 | 513 | 25 | 1,185 |
| `season-9` | season-9 | 8,484 | 7,448 | 36,327 | 818 | 283 | 3 | 962 |
| `stress-test` | stress-test | 2,229 | 1,747 | 11,953 | 109 | 66 | 3 | 253 |
| `unknown` | unknown | 2,989 | 2,039 | 65 | 19 | 176 | 0 | 445 |
| `warcraft-reborn` | warcraft-reborn | 6,855 | 5,750 | 56,267 | 1,254 | 288 | 15 | 1,059 |

### `unknown` is not a game mode

It is the records we could not attribute: submissions that arrived without a
realm folder, and whose contents do not identify one. Creature, gameobject
and NPC records score identically against every mode we have measured --
which is exactly why they cannot identify one -- so those are safe to use
anywhere. Quest text can and does differ between modes, so treat
`unknown/questcache` as a starting point rather than an authority.


`free-pick`, `season-10-freepick` and `live-qa` are the same ruleset in
different seasons — compare them, don't assume they agree; the item tuning
genuinely changed between seasons.

## Caveats

- Capture date is the cache file's mtime: when that player's client last wrote
  it, an upper bound on record age. There is no per-record timestamp in a WDB.
- A cache only holds what that player actually looked at, so every submission
  is a partial view. Coverage grows as more are merged.
- Submissions zipped from above the realm folder lose their mode. Those are
  re-identified by payload fingerprint against known-mode data and marked
  `inferred:<agreement>/<entries compared>` in `sources.tsv`.
- Strings are decoded UTF-8 first (the client writes UTF-8); a latin1 read
  mangles every apostrophe and accent.

