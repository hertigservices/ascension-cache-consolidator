# Publication review

**Upstream:** `https://github.com/Tareksoh/Worldforged-data`, commit
`2cfe069f1988f03f337b3b6ac93581d49d9dd50e`. It is the only commit, authored 2026-09-11 by Tareksoh.

**Permission:** the author gave permission to republish, relayed by James Hertig on 2026-09-11. The upstream
repository has no licence file, and none is asserted here.

## What was published

The 11 datasets under `data/`, byte-identical to the commit:
- Each file is read from git's own object store at that commit, never from a working tree.
- Each is stored gzipped (mtime 0, deterministic).
- Each is checked on verification against its SHA-256 and its recomputed git blob id.

Rows per file are recorded in `manifest.json`, and the verifier recounts them.

## What was left out, and why

26 files are left out, each named in `manifest.json`:
- the author's tools (generators and a LootCollector decoder);
- the measurement report;
- the README and the privacy-gate record;
- `.gitignore`.

The prose files embed the author's local drive paths. They stay available upstream.

## Screens

- **Every published file**, decompressed, was scanned for e-mail addresses, player GUIDs (`0x` + 16 hex),
  account paths (`WTF/Account/`) and local drive paths. The result is 0 hits, and the importer refuses on any
  hit.
- **The author's own gate** ran a 2,723-value person-name list from the LootCollector SavedVariables across all
  35 upstream text files, before the upstream commit. It found 0 account or character hits. Its 15 remaining hits
  were a game item name ("Signet of …'kes") and the word "atlas" in a URL.
- **The LootCollector-derived files** carry only item, zone, coordinate and source-flag columns. They hold no
  finder, sharer or voter field.
- **The bisbeard atlas** carries 1,504 free-text location notes, written for a public website. A scan for
  credits, handles, URLs and addresses found 5 hits, all of them game names containing "Whisper" (e.g. "Whispering
  Book"). No note names a person.

## Comparison with captured data

`comparison.json` checks every item id in the published files against the captured union itemcache (data
repository commit `151cae50fd4df34eeb2576b953e7ea61bace1beb`):
- The 1,973 pin items, the 13,953 ladder ids and the 1,882 LootCollector-flagged items are all present.
- 166 of the 13,211 LootCollector chain ids are absent.
- 145 ladder names and 2 LootCollector names differ from the captured names. They are encoding damage upstream
  (`U+FFFD` for an apostrophe, a literal `\"`) plus trailing-space differences. Captured names stay authoritative.

## Status

This is a supplemental preservation set. It was not applied to any realm. Its pins are looter positions, not
spawn points. Its two upgrade ladders label their rungs differently (see README). Neither is a server-side
upgrade table.
