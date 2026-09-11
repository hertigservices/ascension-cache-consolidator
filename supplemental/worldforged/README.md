# Worldforged data (Tareksoh) supplemental set

Tareksoh's [Worldforged-data](https://github.com/Tareksoh/Worldforged-data) gathers what one research project
("SUNDERBORN") learned about Ascension's **Worldforged** items. It covers where they are picked up in the world,
and the upgrade ladder each one climbs. Its sources are:
- LootCollector addon captures;
- the LootCollector addon's own upgrade module;
- the Exiles database mirror;
- the bisbeard community atlas;
- this repository's own item cache.

It is republished here **with the author's permission** (relayed 2026-09-11). The upstream repository carries no
licence file.

## Preserved snapshot

[Open the snapshot](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/). The folder is named after the upstream commit,
and every file in it is byte-identical to that commit. The verifier recomputes each file's git blob id.

| File (gzipped) | Rows | What it is |
|---|---:|---|
| [`data/wf_pins_union.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/wf_pins_union.csv.gz) | 5,703 | One row per pickup pin: item, zone, map position, server X/Y, and which of the author's sources held it |
| [`data/wf_items_union.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/wf_items_union.csv.gz) | 1,973 | One row per Worldforged item: pin counts, maps and zones |
| [`data/exiles_wf_ladder.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/exiles_wf_ladder.csv.gz) | 13,953 | The upgrade ladder by name, parsed from the Exiles mirror: name × rung → item id, item level and "Found at" |
| [`data/lootsmith/wf_upgrade_chains.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/lootsmith/wf_upgrade_chains.json.gz) | 1,978 chains | The upgrade ladder by id, from LootCollector's `Modules/WorldforgedUpgrades.lua` |
| [`data/lootsmith/lootcollector_wf.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/lootsmith/lootcollector_wf.json.gz) | 1,882 | LootCollector's own "is Worldforged" flag and required level per item |
| [`data/lootsmith/bisbeard_atlas_wf_locations.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/lootsmith/bisbeard_atlas_wf_locations.json.gz) | 1,481 names | The bisbeard community atlas's Worldforged pins, by item name and zone |
| [`data/lootsmith/bisbeard_atlas_data.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/lootsmith/bisbeard_atlas_data.json.gz) | 5,582 markers | The same atlas with Mystic Scrolls, including its free-text location notes |
| [`data/provenance/dump_zips_wf_items.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/provenance/dump_zips_wf_items.csv.gz) | 1,755 | The author's first extraction, items |
| [`data/provenance/dump_zips_wf_locations.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/provenance/dump_zips_wf_locations.csv.gz) | 4,284 | The same extraction's pins, with the nearest dumped gameobject |
| [`data/worldmaparea_bounds_captured.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/worldmaparea_bounds_captured.csv.gz) | 310 | Ascension's WorldMapArea bounds, used for every map → server conversion |
| [`data/worldmaparea_bounds_stock.csv`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/data/worldmaparea_bounds_stock.csv.gz) | 108 | Stock 3.3.5a bounds, for comparison |
| [`comparison.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/comparison.json.gz) | | Every item id checked against this repository's captured itemcache: missing ids and conflicting names |
| [`manifest.json`](2cfe069f1988f03f337b3b6ac93581d49d9dd50e/manifest.json) | | Upstream commit, permission, file and artifact hashes, git blob ids, and the omitted files with reasons |

The author's tools, measurement report, README and privacy-gate record are **not** republished. They embed the
author's local paths; read them upstream. `manifest.json` names each omitted file.

## Read this before using the data

These notes were measured on 2026-09-11 against this repository's captured data.

- **A pin is where the looter stood, not the spawn.** It is typically a few yards away, with a long tail. No
  pin has a height (Z). There are none in Northrend or the Pale Reach.
- **The two ladders agree on ids but not on rung names.** For `415065 A Guide to a Succubus' Darkest Secrets`:

  | ilvl | id | LootCollector | Exiles |
  |---:|---:|---|---|
  | 45 | 415065 | base | Base |
  | 60 | 1388385 | Dungeon | Base (second) |
  | 64 | 1378657 | ZG | Lvl 60 |
  | 70 | 1380657 | Tier 1 | ZG |
  | 73 | 1392657 | — | MC |
  | 77–88 | 1382657 / 1384657 / 1386657 | Tier 2 / AQ / Tier 3 | BWL / AQ40 / Naxx |

  Exiles' "MC" rung holds 1,823 ids, and only 91 of them appear in any LootCollector chain. The "names with
  more than one Base id" in the Exiles ladder are LootCollector's ilvl-60 "Dungeon" rung, not a scraping error.
  **Key an upgrade table on ids and item level, never on rung labels.**
- 984 of the LootCollector chain ids are stock raid gear, not Worldforged, e.g. `10904 Faceguard of Wrath`.
  166 chain ids exist nowhere in the captured data, e.g. 1379871–1379874.
- Every pin item and every ladder id is present in the captured itemcache. 145 Exiles ladder names carry a
  `U+FFFD` where an apostrophe belongs (`Scourgestalker�s Girdle`). Two LootCollector names carry a literal
  `\"`. `comparison.json` lists all of them. The captured names are authoritative.
- `worldmaparea_bounds_captured.csv` matches the Ascension client's own `WorldMapArea.dbc` from `patch-M.MPQ`
  (md5 `385136e35c9b279ff195a3414d59b9f8`, 310 rows). That was independently verified; the stock-client and
  server-folder copies differ.

## Our own view of the same pickups

[`cachedata/lootcollector/`](../../cachedata/lootcollector/) is derived by this repository's pipeline from the
raw LootCollector files submitted to it. It holds 5,264 Worldforged pins over 1,978 items, plus Mystic Scrolls,
with realms, modes and dates.
- 5,136 of those pins match a pin here, and the server coordinates agree to a median of 0.00 yd.
- Where they differ, the pipeline keeps one position per discovery (its most recently confirmed copy), where
  this set keeps every copy.

The importer, tests and guide live in the
[Ascension preservation repository](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator):
`tools/import_worldforged.py`, `tools/test_worldforged.py` and `docs/WORLDFORGED.md`. The importer needs only
Python's standard library and git. To verify the snapshot, run this from that component:

```
python -B tools/import_worldforged.py verify <this repository>/supplemental/worldforged/2cfe069f1988f03f337b3b6ac93581d49d9dd50e
```

This set has not been applied to a live realm.
