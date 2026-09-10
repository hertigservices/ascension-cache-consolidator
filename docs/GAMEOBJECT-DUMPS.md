> Tool commands in this guide now run from the [canonical cache component](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator). Dataset paths remain in this data repository.

# The GameObject dumps — what they are, and what they are not

Submitted by **Coin** as `dumps-part1.zip`, `dumps_part2.zip`, `dumps_part3.zip`
and `dumps_part4.zip`, plus a later, tidier `GameObjects-Bronzebeard.zip`.

## The submitter's own description

Quoting the post they came with, because every limit below comes from it:

> This is GameObject dumps from EK and Kalimdor from 1 year ago when
> Bronzebeard launched. So a lot of zones are the same - but none of the new
> zones like Pale Reach or custom starting zones.
>
> This is not every object dumped, only the first one discovered. Also no trees
> or common objects like chairs etc as i filtered those away in the dumping
> process. The purpose of the dump was to find and log worldforged GameObjects,
> which is why only the first seen is logged.
>
> It's not all of the spawnpoints, but atleast all unique objects should be here.
>
> I included all attempts at dumps, so some of them are partial dumps.

## What that means in practice

**This is a catalogue, not a spawn table.** Four separate reasons, all from the
description above, and each one on its own is enough:

1. **Only the first sighting of each object was recorded.** A row is "this
   object exists, and here is one place it was seen" — never "this object is
   here, and only here".
2. **Trees and common props were filtered out at dump time.** So an object
   being absent proves nothing whatsoever about the world.
3. **Some files are partial dumps**, included deliberately. Coverage is uneven
   between them by design.
4. **It is a snapshot from around the Bronzebeard launch**, roughly a year
   before it was submitted, and it predates the newer zones — Pale Reach and
   the custom starting zones are simply not in it.

So: do not build a `gameobject` spawn table out of this, do not count rows and
call them spawns, and do not treat a missing entry as evidence of anything.
What it *is* good for is the question it was collected to answer — **which
GameObjects exist, and which of them are Ascension's own rather than stock
3.3.5a** — with one worked example position for each.

## What is actually in the files

Measured, not assumed:

| submission | files | object rows | object ids | creature rows | creature ids |
|---|---:|---:|---:|---:|---:|
| `dumps-part1` | 10 | 755 | 446 | 3,655 | 548 |
| `dumps_part2` | 51 | 13,957 | 6,446 | — | — |
| `dumps_part3` | 10 | 840 | 701 | — | — |
| `dumps_part4` | 45 | 8,555 | 6,007 | — | — |
| `GameObjects-Bronzebeard` | 43 | 7,729 | 5,886 | — | — |
| **all of it, deduplicated by id** | **159** | **31,836** | **7,651** | **3,655** | **548** |

Across **48 zones**. Splitting at entry 200000 (stock 3.3.5a GameObjects live
below it): **5,590 stock-shaped ids and 2,061 that are Ascension's own** — the
worldforged objects the dump was made to find. Named examples of the custom
ones: `200002 Portal to Auberdine`, `200032 Tark Podium`,
`200576 Nether Portal`, `200297 Shandy's Clothesline`, `202080 Dart's Nest`.

> **An earlier draft of this file got those numbers wrong**, and it is worth
> saying how. It reported 8,165 unique ids across 53 zones with 2,131 custom —
> those are the figures you get when the creature dumps below are counted in
> the *same id space* as the objects, which is exactly the mistake the next
> paragraph warns against. It also offered `10157359 Challenger Grogmar`,
> `11000090 Glrgky, the Pursuer` and `11000190 Prismatic Slimesaber` as example
> custom GameObjects. Those are creatures. The ingester separates the two id
> spaces, which is how the error surfaced.

**Five of the files are not GameObjects at all.** `dumps-part1` contains
`dump_npc_Alterac`, `dump_npc_Barrens`, `dump_npc_Durotar`,
`dump_npc_SearingGorge` and `dump_npc_Stormwind` — creature dumps, in the same
format. The description does not mention them. They are a bonus, and they must
not be merged into the GameObject id space. This is not a theoretical concern:
**34 ids appear in both spaces**, meaning the same number would silently
describe two unrelated things.

## Traps in the file formats

Five, every one of which silently corrupts data rather than raising an error:

* **The `.csv` files are semicolon-separated with a comma as the DECIMAL
  point** — `"-9430,91015625"` is one number, not two fields. Read them as
  ordinary comma CSV and every coordinate in the set is destroyed, quietly.
  They also carry a UTF-8 BOM.
* **The `.txt` files are not JSON.** They are one single line of Lua-ish
  records with unquoted keys (`{id:95696,Name:"Riding Cloak",...}`), no
  trailing newline — so `wc -l` reports 0 lines for a full file.
* **Object names contain commas**, e.g. `Standing, Exterior, Medium - Brewfest`.
  Nothing in either format can be split on commas.
* **`Aszhara` and `Azshara` are NOT a typo pair.** They are two different
  zones: 35 rows and 106 rows, different `Map internal name` values, and
  **zero ids in common**. Normalising the "misspelling" away would silently
  merge two distinct places. `Darnassis` is likewise the client's own internal
  spelling.
* **`UnGoroCrater` and `UngoroCrater` differ only in case**, which on NTFS is
  the same filename. They survive here only because they landed in different
  extract directories. Anything that flattens these into one folder will
  destroy one of them without saying so.

Also: **28 records have coordinates of exactly 0,0,0** and no usable position
(`174797 Xavian Waterfall`, `2066 Bonfire Damage`, `515473 RPG PROP TURLE
SHELL` among them). After folding by id, **25 objects have no usable position
from any sighting**; the rest were seen properly somewhere else. The one id
with an empty name, `11000215`, is a creature, not an object. Filter on the
coordinates, not on the presence of a row.

## Only the CSVs carry types — and most of those types are not real

Type and DisplayId exist only in the `.csv` files, so the `.txt`-only zones
have neither. But the bigger problem is inside the CSVs themselves.

**`Door` is what the dumper wrote when it could not read the type.** Of the
6,395 rows marked `Door`, **6,393 have no DisplayId either** — while every
single row of every other type has one. `1628 Grave Moss`, a herb node, is
filed as a `Door`. An earlier draft of this file repeated that breakdown as
though it were real and said the set was "dominated by doors"; it is not, it is
dominated by rows whose type could not be read.

So the ingester publishes an untyped `Door` as **blank, meaning unknown**, and
keeps the two that do carry a DisplayId. That leaves **1,778 of the 7,651
objects with a type anybody should trust**:

`Generic=779, Chest=653, SpellFocus=164, Questgiver=37, Goober=33, Text=24,
Mailbox=15, Transport=13, FishingHole=11, Door=11, SpellCaster=10, Chair=6,
Button=6, MOTransport=5, Trap=4, MeetingStone=2, Difficulty=2, AuraGen=1,
DuelArbiter=1` — see `catalogue/README.md`, which is generated from the data
and therefore cannot drift from it the way this paragraph can.

(The 11 surviving `Door` entries are the ones that came with a DisplayId, so
they look like real doors. The CSVs are not all in `GameObjects-Bronzebeard`:
`dumps_part2` holds 8 of them alongside its 43 `.txt` files, which is where
several of the rarer types come from.)

## The ingester

`tools/ingest_gameobjects.py`, which runs as the `catalogue` stage of
`tools/update.py`. It writes `catalogue/gameobjects.tsv`,
`catalogue/creatures.tsv` and a plain-language `catalogue/README.md` into the
published dataset. It keeps no state — the catalogue is a pure function of the
dump files on disk, so re-running is a recompute and there is nothing to go
stale.
