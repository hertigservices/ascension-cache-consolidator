# Client DBC snapshots

Each folder here is one DBC dump that someone sent in: the `DBFilesClient` tables pulled out of an Ascension client.
It is kept as its **difference from the public client package**, because that package already carries most of the
same bytes. The folder is named after the SHA-256 of the archive as received.

In each folder:
- `manifest.json` names **every** member of the archive with its size, SHA-256, file time and verdict, so anyone who
  holds the archive can prove they hold the same bytes;
- `dbc/` holds, gzipped, only the tables whose bytes differ from the client package's own copy;
- `diff.json.gz` reports, for each of those tables, the rows found only in the dump, the rows found only in the
  package, and the changed rows with their changed fields.

## `fd1d867b…`: dbc2.zip, received 2026-09-11

[Open the snapshot](fd1d867bc90a9e2283c71c3755be145ccf42f4724d862019848d83877e21a473/).

**It is older than the client package.** It holds 337 DBCs, with file times from 2026-02-08 to 2026-08-28, plus three
CSVs. The package's patch archives are dated 2026-09-01, and in 11 of the 13 differing tables the package has more
rows.

| Verdict | Members | |
|---|---:|---|
| Identical to the package | 324 | Named with their hash, not republished. This includes every Ascension-only table, such as `CharacterAdvancement*`, `Challenge*`, `SkillCard` and `Appearances` |
| Different from the package | 13 | Republished, 20 MB gzipped, each with a record-level report |
| Not a DBC | 3 | `Achievement.csv`, `Achievement_Criteria.csv` and `WorldMapArea.csv`. Checked cell by cell, each is a faithful export of the DBC beside it, written with comma decimals (`4846,11`). Derived, so not republished |

What the 13 differing tables hold that the package does not:

| Table | Rows (dump / package) | The difference |
|---|---:|---|
| `Quest.dbc` | 18,561 / 18,561 | 2,321 rows changed, each in exactly one field. On all 2,184 rows where field 10 changed (ids 1227–8200504), the dump's value is **exactly one third** of the package's: quest 1227 has 3500 against 10500. Field 11 changed on 115 rows (ids 11354–1700101), and field 12 on 22 (ids 13100–24590) |
| `Spell.dbc` | 209,509 / 209,510 | 325 rows changed, and spell 818068 exists only in the package. 296 of the changed rows (ids 2122045–2124214) change only fields 74–82: the effect die-sides, per-level and base-points slots in the stock 3.3.5a layout. 21 change the description in field 170, one of them together with field 7. Spell 289020 reads "from next 5 of your attacks", where the package reads "from the next 5 direct damage spells dealt by you, your pets, or your guardians". 6 change field 211 (293180, 293181 and 293183–293186); 91916 changes field 187, and 289375 changes field 41 |
| `MapDifficulty.dbc` | 688 / 688 | Ids 418, 419 and 420 have 5 in field 21, where the package has 15 |
| `DungeonMapChunk.dbc` | 2,727 / 2,726 | Row 2329 exists only in the dump |
| `ItemAddon.dbc` | 563,765 / 563,770 | By content: 2 rows only in the dump, 7 only in the package (5 inserted rows, 2 changed). The table is keyed by row index, so its first-field view reports 188,016 shifted rows; ignore that view here |
| `Item.dbc` | 563,765 / 563,770 | Items 998103, 2400051–2400053 and 3818046 exist only in the package |
| `LightIntBand.dbc` · `LightFloatBand.dbc` · `Light.dbc` · `LightParams.dbc` | | 18, 6, 1 and 1 rows exist only in the package; nothing changed |
| `SpellAffect.dbc` · `SpellCategory.dbc` · `WorldMapArea.dbc` | | One row each exists only in the package (230959, 6025 and 2067); nothing changed |

Field numbers are positions in the record, counted from 0. Ascension extended several of these tables, so no schema
here is authoritative. The submitter was not recorded.

## How the reference was taken, and how to check it

The reference is the copy of each table in the highest-precedence archive of the public client package that holds
it: `patch-M.MPQ` for 288 tables, `patch-S.MPQ` for 48, and `patch-T.MPQ` for `Spell.dbc`. Each was read with
`mpqfind --from`, which takes one named archive and bypasses precedence.

The importer, its tests and the guide live in the
[Ascension preservation repository](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator):
`tools/import_dbc_snapshot.py`, `tools/test_dbc_snapshot.py` and
[`docs/CLIENT-DBC-SNAPSHOTS.md`](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/CLIENT-DBC-SNAPSHOTS.md).
The guide explains how to build the reference folder, and how to read the two diff views. Run from that component:

```
python -B tools/import_dbc_snapshot.py verify <this repository>/supplemental/client-dbc-snapshots/fd1d867bc90a9e2283c71c3755be145ccf42f4724d862019848d83877e21a473
python -B tools/import_dbc_snapshot.py verify <that folder> --reference <loose DBCs from the client package>
```

The first form checks every hash and verdict. The second also recomputes every diff, which takes about two minutes.

**None of these tables has been loaded into a realm.** A realm's own `dbc` folder is not a copy of either client: this
project's `server-ascension` zeroes 10,928 custom effect and aura values in `Spell.dbc` so that stock AzerothCore can
load it.
