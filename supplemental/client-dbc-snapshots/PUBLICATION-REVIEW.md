# Publication review

**Source:** `dbc2.zip`, 74,311,386 bytes, SHA-256
`fd1d867bc90a9e2283c71c3755be145ccf42f4724d862019848d83877e21a473`. Received 2026-09-11; the submitter was not
recorded. It holds 340 files: 337 WDBC tables and 3 CSV exports.

**Reference:** the public Ascension client redistribution package, whose patch archives are dated 2026-09-01. Each
table was taken from the highest-precedence archive that holds it (288 from `patch-M.MPQ`, 48 from `patch-S.MPQ`,
`Spell.dbc` from `patch-T.MPQ`), and the importer checked every file against its recorded hash.

## What was published

- **13 tables**, gzipped, byte-identical to the archive's members. Their bytes differ from the reference's copy.
- **`diff.json`:** for each of those 13, the rows only in the dump, the rows only in the reference, and the changed
  rows, by first field and by content.
- **`manifest.json`:** all 340 members, each with size, SHA-256, file time and verdict.

## What was left out, and why

- **324 tables** are byte-identical to the reference, which is already public. They are named in the manifest with
  their hash, so the archive stays provable without republishing them.
- **3 CSVs:** `Achievement.csv`, `Achievement_Criteria.csv` and `WorldMapArea.csv`. Each was compared cell by cell
  with the DBC beside it:
  - they have the same ids, and every numeric cell agrees once comma decimals (`4846,11`) are read as decimals;
  - four text cells differ: the export deleted the paragraph breaks. Achievement 123005, 123006 and 123007, and
    criterion 123005, each equal the DBC's string once its two or four CRLF pairs are removed.

  They are derived, slightly lossy exports and add nothing.

## Screens

- **The importer** refuses anything shaped like an address, a player GUID, an account path or a local path in the
  string block of a republished table. Across the 13, the only address-shaped string is `techbot@gnome.mail`, once, in
  `Spell.dbc`: the GM ban spell's appeal text, at a TLD that does not exist. It is allowed as that exact string.
- **The reference label** in the manifest carries no local path, and the manifest is screened as well.
- **The repository's own publication audit** (`audit_publish.py`) scanned all 16 files of the snapshot, decompressed,
  and reported CLEAN.

## Checks

- `verify --reference` re-checked every "identical" verdict against the reference files, and recomputed all 13 diffs
  from the published bytes. It passed in 58 seconds.
- The diff was cross-checked by an independent pairwise comparison, written before the importer. Both find 325
  changed `Spell.dbc` rows and 2,321 changed `Quest.dbc` rows. Both agree on every row-count difference in the other
  11 tables.
- The first version of the importer ignored empty strings when deciding which columns hold strings. It reported
  127,176 changed `Spell.dbc` rows, because Ascension points all eight locale slots at one empty string. That was
  fixed before this snapshot was built, and a test now covers it.

## Status

A preservation record of an older client state, not applied to any realm.
