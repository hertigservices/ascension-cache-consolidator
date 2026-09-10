# BisBeard CoA supplemental catalog

This dataset preserves the complete contributor-supplied BisBeard item export as
original bytes, normalized records and a searchable SQLite database. Website
values are source-attributed claims and remain separate from captured WDB data.

## Preserved snapshot

[Open the snapshot](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/).

- 70,838 records across all 75 declared phase/category tables.
- 37,557 explicit planner variants retained with base-item associations.
- 21,337 planner IDs exceed unsigned 32-bit range and remain strings.
- 32,039 direct name matches and 22 name conflicts against the captured baseline.
- 1,220 direct missing-ID candidates and 3 variant rows with missing bases.
- No known drop rates; no loot probabilities or server item payloads are invented.

| Download | Purpose |
| --- | --- |
| [Original export](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/source.dexie.gz) | Decompress to recover the exact original `.dexie` file. |
| [All records](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/rows.jsonl.gz) | Gzipped JSON Lines, including every original field and provenance. |
| [SQLite database](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/catalog.sqlite.gz) | Decompress and open read-only to query items, variants and conflicts. |
| [Comparison report](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/comparison.json.gz) | Complete direct missing-ID and conflicting-name lists. |
| [Manifest](7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666/manifest.json) | Source/archive/baseline hashes, record counts and artifact checksums. |

The source is `ClassicGearPlannerDB_coa-260907-132512.dexie`, attributed by its
contributor to [BisBeard](https://coa.bisbeard.com/). Original SHA-256:
`7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666`.
The source filename is not proof of capture date, and the contributor's accuracy
estimate has not been independently validated. No source license grant is asserted.

The importer, tests and full schema/query guide live in the canonical
[Ascension preservation repository](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator):
`tools/import_bisbeard.py`, `tools/test_bisbeard.py` and `docs/BISBEARD.md` beneath
that component. It uses only Python's standard library.

Verification compares all source rows with the normalized export and SQLite
records, recovers the exact source hash, checks table counts and database integrity,
and verifies the conflict report and artifact hashes. The publication audit also
scans the decompressed data. This catalog has not been applied to a live realm.
Captured values remain authoritative; missing IDs are research candidates.