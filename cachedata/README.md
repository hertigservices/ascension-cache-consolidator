# Ascension client cache — merged dataset

_Merged from 825 distinct submitted cache files, the newest captured 2026-09-09._

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
| creaturecache | 22,707 | 21,189 |
| gameobjectcache | 14,571 | 14,480 |
| itemcache | 587,021 | 551,803 |
| itemnamecache | 2,680 | 2,675 |
| npccache | 1,968 | 1,946 |
| pagetextcache | 220 | 220 |
| questcache | 20,760 | 18,552 |

## Game modes

| mode | family | creaturecache | gameobjectcache | itemcache | itemnamecache | npccache | pagetextcache | questcache |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| `coa-alpha` | conquest-of-azeroth | 1,359 | 1,400 | 0 | 0 | 54 | 1 | 119 |
| `coa-beta` | conquest-of-azeroth | 3,406 | 3,121 | 13,931 | 39 | 225 | 11 | 558 |
| `conquest-of-azeroth` | conquest-of-azeroth | 16,799 | 12,225 | 77,373 | 2,165 | 1,532 | 196 | 3,144 |
| `free-pick` | free-pick | 5,722 | 5,193 | 30,533 | 370 | 268 | 7 | 821 |
| `live-qa` | free-pick | 0 | 0 | 398 | 0 | 0 | 0 | 210 |
| `season-10-freepick` | free-pick | 11,896 | 8,533 | 548,845 | 631 | 393 | 27 | 18,552 |
| `season-10-wildcard` | wildcard | 4,993 | 3,424 | 24,002 | 243 | 248 | 8 | 567 |
| `season-9` | season-9 | 5,169 | 5,009 | 19,848 | 459 | 213 | 3 | 478 |
| `stress-test` | stress-test | 1,603 | 1,013 | 9,553 | 87 | 33 | 2 | 172 |
| `unknown` | unknown | 2,968 | 2,037 | 0 | 19 | 176 | 0 | 445 |
| `warcraft-reborn` | warcraft-reborn | 3,402 | 2,648 | 39,189 | 750 | 147 | 9 | 443 |

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

