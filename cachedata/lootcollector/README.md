# LootCollector: where Worldforged items and Mystic Scrolls are picked up

Written by `tools/ingest_lootcollector.py` from the LootCollector addon's
SavedVariables found in community submissions. Nothing here is edited by hand.

## What a row is

A **pin** is one place an item was looted. The position is where the looter stood when the
loot window opened, not where the object is. It is usually within a few yards of the spawn,
with a long tail. **There is no height (Z).** Records are crowd-synced between players by
the addon, so `files` counts files that carry a pin, not people who saw it.

`norm_x`/`norm_y` are the position on the zone map (0..1). `server_x`/`server_y` convert it
with the client's own WorldMapArea bounds (Ascension's table, not stock's). `lc_zone` is the
addon's zone id, which is the WorldMapArea id + 1. One pin is kept per (type, item, zone)
within 0.005 map units, and its position is the mean of the copies it merges.

## Counts from this run

| | |
|---|---:|
| distinct LootCollector files read | 22 |
| distinct discoveries (realm, addon key) | 23,001 |
| mystic_scroll pins / items | 1,890 / 560 |
| type 4 pins / items | 2 / 2 |
| worldforged pins / items | 5,264 / 1,978 |
| pins with server coordinates | 7,156 of 7,156 |

Files by status: empty (no content) 2, ok 20.

Pins by realm: Vol'jin - Conquest of Azeroth 4,319, Rexxar - Conquest of Azeroth 3,422, Bronzebeard - Warcraft Reborn 3,117, Dawnrise - Season 10 Freepick 2,078, Area 52 - Free-Pick 2,055, Darkmoon - Season 10 Wildcard 2,005.

Example: item 100369 in Ragefire Chasm at map (0.3545, 0.8340) = server (-371.2, 191.0) on map 389.

## Files

| file | one row per |
|---|---|
| `pins.tsv` | pin: type, item, zone, map position, server X/Y, realms, first and last seen |
| `items.tsv` | item and type: how many pins, in which zones and maps |
| `sources.tsv` | distinct LootCollector file, by SHA-256: whether it could be read and what it held |

## What was left out, on purpose

Every LootCollector record also names the player who found it, the player who shared it and
everyone who voted on it. None of that is read. Only the numeric fields, the addon's status
word and the realm are taken, and the stage refuses to write anything shaped like an address
or a path. The raw SavedVariables are never published.

Upgrade tiers, drop rates and which object an item comes from are **not** in LootCollector's
logs. See `docs/WORLDFORGED.md` in the tools repository.
