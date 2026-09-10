# Ascension Data

Recovered Ascension datasets, provenance, manifests and immutable supplemental
catalogs. This repository was previously named **ascension-cache-consolidator**;
its history and existing cachedata paths are retained.

**Tool source now lives in [Ascension Preservation](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator).**
See the [unified setup guide](https://github.com/hertigservices/Ascension_preservation/blob/main/docs/SETUP.md).

| Data | Purpose |
|---|---|
| [cachedata/](cachedata/) | Captured WDB records, valid variants, per-mode views and provenance |
| [manifests/](manifests/) | SHA-256 and size of every file in a named cache snapshot |
| [supplemental/bisbeard/](supplemental/bisbeard/) | Separately attributed planner export, all original rows, queryable catalog and comparison report |

Captured cache variants remain separate by source and game mode. The supplemental
planner catalog does not replace captured values or claim that a candidate ID,
loot source, or probability is authoritative. Each supplemental snapshot records
its exact source hash and interpretation limits.

The cache publisher operates from the preservation source or a recorded deployment
in an intake installation. This repository's `.ascension-data.json` marker prevents
it from copying source code here. Private submissions, intake ledgers, credentials,
character backups and live database dumps stay outside this repository.

The pre-migration code is retained in history and the `pre-consolidation-2026-09-10`
tag. Existing old GitHub URLs redirect to this repository after the rename.
