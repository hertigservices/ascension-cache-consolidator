# Publication review

Source SHA-256: `7733de9bf573b62f451375ea09415f8de86b13c9c131cd6108a0e9a2e716d666`.
Archive SHA-256: `6be94039cc3c53a34dbdb3b1dd6e8b58e93d2ddf986c90d83f07ce1af5c6c61a`.

The importer parsed the entire export without executing it. All 75 phase/category
tables and 70,838 original records are present in the JSON Lines and SQLite views.
Every original item field is retained. Decompressing the preserved source recovers
the exact original hash. The database passes SQLite integrity and exact schema
checks. The missing-ID/name-conflict report is verified against normalized rows
and identifies its captured comparison baseline by file hash and Git revision.

The source contains only the reviewed item catalog schema. No email, player-GUID,
account-path or local-path indicators were found in the original export or logical
published records. Source attribution, original archive hash and database metadata
are preserved without publishing local paths or contributor account identities.

The existing publication scanner scans all decompressed bytes. It reports one
GUID-shaped sequence at SQLite byte offset 35372135. Review established that this
crosses a binary integer/text boundary: SQLite row-index bytes precede adjacent
numeric item IDs. It is absent from the original source, JSON Lines and complete
logical SQL dump. The importer verifies the exact database schema and all stored
values, then scans the logical SQL representation. The binary is unchanged and
no broad scanner exception has been introduced. This reviewed finding applies
only to this exact snapshot and artifact hash in its manifest.

The 17-test importer suite covers lossless preservation, large variant IDs,
duplicate identity handling, deterministic rebuilds, repeat imports, changed
baselines, malformed input, unexpected fields/types, personal-data indicators,
corrupt artifacts, altered row values, added SQLite tables and falsified counts.

This is a supplemental preservation catalog. Item/source accuracy, source phase
semantics and candidate IDs are not independently established. No WDB payloads,
loot probabilities or live realm changes are produced. The source's licensing
status is not asserted by this preservation record.