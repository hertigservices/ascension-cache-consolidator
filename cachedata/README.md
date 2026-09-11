# Ascension client cache — merged dataset

_Merged from 1583 distinct submitted cache files, the newest captured 2026-09-10._

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
| creaturecache | 28,375 | 23,854 |
| gameobjectcache | 16,478 | 16,276 |
| itemcache | 657,702 | 553,716 |
| itemnamecache | 3,561 | 3,532 |
| npccache | 2,521 | 2,472 |
| pagetextcache | 415 | 415 |
| questcache | 22,796 | 18,553 |

## Game modes

| mode | family | creaturecache | gameobjectcache | itemcache | itemnamecache | npccache | pagetextcache | questcache |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| `coa-alpha` | conquest-of-azeroth | 1,359 | 1,400 | 0 | 0 | 54 | 1 | 119 |
| `coa-beta` | conquest-of-azeroth | 5,977 | 5,467 | 20,616 | 90 | 344 | 23 | 849 |
| `conquest-of-azeroth` | conquest-of-azeroth | 17,588 | 12,624 | 432,331 | 2,930 | 1,999 | 389 | 18,550 |
| `free-pick` | free-pick | 20,598 | 14,956 | 93,498 | 2,828 | 1,793 | 258 | 3,844 |
| `live-qa` | free-pick | 0 | 0 | 398 | 0 | 0 | 0 | 210 |
| `season-10-freepick` | free-pick | 12,196 | 8,757 | 548,849 | 640 | 496 | 28 | 18,552 |
| `season-10-wildcard` | wildcard | 9,116 | 7,279 | 37,006 | 659 | 507 | 21 | 1,160 |
| `season-9` | season-9 | 8,484 | 7,448 | 36,327 | 818 | 283 | 3 | 962 |
| `stress-test` | stress-test | 2,149 | 1,693 | 11,671 | 100 | 61 | 3 | 222 |
| `unknown` | unknown | 2,989 | 2,039 | 65 | 19 | 176 | 0 | 445 |
| `warcraft-reborn` | warcraft-reborn | 6,724 | 5,677 | 55,912 | 1,222 | 285 | 15 | 1,012 |

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

