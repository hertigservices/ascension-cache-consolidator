# Ascension client cache — merged dataset

_Merged from 2032 distinct submitted cache files, the newest captured 2026-09-10._

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
| creaturecache | 28,824 | 24,040 |
| gameobjectcache | 16,553 | 16,326 |
| itemcache | 659,976 | 553,764 |
| itemnamecache | 3,617 | 3,588 |
| npccache | 2,679 | 2,620 |
| pagetextcache | 513 | 513 |
| questcache | 23,094 | 18,553 |

## Game modes

| mode | family | creaturecache | gameobjectcache | itemcache | itemnamecache | npccache | pagetextcache | questcache |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| `coa-alpha` | conquest-of-azeroth | 1,720 | 1,412 | 13,605 | 0 | 60 | 1 | 121 |
| `coa-beta` | conquest-of-azeroth | 5,989 | 5,472 | 20,638 | 90 | 345 | 23 | 855 |
| `conquest-of-azeroth` | conquest-of-azeroth | 17,782 | 12,670 | 433,125 | 2,970 | 2,170 | 500 | 18,550 |
| `free-pick` | free-pick | 20,630 | 14,959 | 94,031 | 2,828 | 1,798 | 259 | 3,895 |
| `live-qa` | free-pick | 0 | 0 | 398 | 0 | 0 | 0 | 210 |
| `season-10-freepick` | free-pick | 12,716 | 9,120 | 548,931 | 648 | 572 | 28 | 18,552 |
| `season-10-wildcard` | wildcard | 12,245 | 9,176 | 41,135 | 751 | 518 | 26 | 1,194 |
| `season-9` | season-9 | 8,515 | 7,463 | 36,332 | 818 | 283 | 3 | 965 |
| `stress-test` | stress-test | 2,249 | 1,750 | 12,197 | 109 | 68 | 4 | 253 |
| `unknown` | unknown | 2,989 | 2,039 | 65 | 19 | 176 | 0 | 445 |
| `warcraft-reborn` | warcraft-reborn | 7,080 | 5,926 | 56,696 | 1,293 | 290 | 15 | 1,094 |

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

