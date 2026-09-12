# The world catalogue (`catalogue/`)

Two lists of things that exist in the world: **objects** and
**creatures**. They came from players walking the world with a dump
addon running, not from the game's own cache files, so they are the
one part of this dataset that is an observation rather than a
recording.

## Read this before you use it

**This is a catalogue, not a spawn table.** The person who collected it
said so plainly, and there are four separate reasons, each enough on
its own:

1. **Only the first sighting of each object was written down.** A row
   means *this exists, and here is one place it was seen*. It never
   means *this is here, and only here*.
2. **Trees, chairs and other common props were filtered out** during
   the dump. An object being absent proves nothing whatsoever.
3. **Some of the dumps are partial**, and were included deliberately,
   so coverage is uneven between them by design.
4. **It is a snapshot from around the Bronzebeard launch**, about a
   year before it was submitted. The newer zones -- Pale Reach, the
   custom starting zones -- are not in it at all.

If you load this into a `gameobject` table you will get a world that
is mostly empty and confidently wrong. What it is genuinely good for
is the question it was collected to answer: **which objects exist, and
which of them are Ascension's own** rather than stock 3.3.5a.

## The two files

| file | rows | what it lists |
|---|---:|---|
| `gameobjects.tsv` | 7,651 | doors, chests, herb nodes, portals, props -- anything the client calls a GameObject |
| `creatures.tsv` | 548 | NPCs, from the `dump_npc_*` files |

**They are separate id spaces and must stay separate.** Creature 1622
and GameObject 1622 are unrelated things. The creature dumps were not
even mentioned in the submission -- they turned up inside it -- so
they are catalogued on their own rather than folded in.

## What the columns mean

| column | meaning |
|---|---|
| `id` | the entry id the server uses |
| `name` | the name most dumps agreed on |
| `type` | object type: what a dump read, else what the game's own cache says; **blank where neither knows** (see below) |
| `display_id` | the model id, from a dump, else from the cache; blank if neither has it |
| `sightings` | how many rows across all files mention this id |
| `submissions` | how many separate uploads saw it -- uploads, not people (see below) |
| `zones` | how many distinct zones it was seen in |
| `example_*` | **one** position it was seen at, not its only one |
| `lock_id`, `lock_type` | for locked objects, where recorded |
| `other_names` | every other name any dump gave this id |
| `seen_in` | which uploads it came from |
| `zone_list` | every zone it was seen in |
| `origin` | `stock` if stock 3.3.5a has this entry, `ascension` if it does not (see below) |

## Reading these files

They are tab-separated with no quoting at all, and some names begin
with a double quote: `"Evidence"`, `"Borrowed" Dark Iron Signet`.
A CSV reader left on its defaults takes that quote for field quoting
and strips it without a word. Turn quoting off -- in Python,
`csv.reader(f, delimiter="\t", quoting=csv.QUOTE_NONE)`.

## Which of these are Ascension's own?

The `origin` column. An entry is `stock` if stock 3.3.5a's template
table has it -- looked up in the ids AzerothCore's base world
database ships, `stock_entries.txt` beside the tool -- and
`ascension` if it does not. That is everything Ascension added,
whether they made it or brought it back from a later expansion.

| file | ascension | stock |
|---|---:|---:|
| `gameobjects.tsv` | 4,159 | 3,492 |
| `creatures.tsv` | 149 | 399 |

**This used to be answered by an id range, and the range was
wrong.** Earlier versions of this file said stock objects sit below
200000 and Ascension's above it. 2,112 of
Ascension's objects sit below it -- `4609 Timbermaw Totem of Nourishment`, `90421 Lost One Satchel`, `95706 Forgotten Dwarven Axe`, `96102 Logging Axe` --
and 14 stock objects sit above it -- `200294 Doodad_InstancePortal_Green_10Man01`, `200295 Doodad_InstancePortal_Green_25Man01`, `200296 Washing Tub`, `200297 Shandy's Clothesline`.
The range called 2,061 objects Ascension's; the stock
table says 4,159.

An id being stock says the entry exists in 3.3.5a, not that
Ascension left it alone: a few stock entries carry a different name
here. `origin` answers only the first question.

## Where `type` and `display_id` come from

First from the dumps, and there is a catch. The dumper wrote `Door`
when it could not read an object's type, and it could not read it
most of the time: of the 6,395 rows marked `Door`, 6,393 have no
model id either, while every row of every other type has one.
`Grave Moss` -- a herb -- is filed as a `Door`. So an untyped `Door`
counts as **unknown**, not as a door.

Where no dump read a value, it comes from the game itself: the
gameobjectcache records elsewhere in this dataset, which are the
server's own description of each entry. That supplied the type of
5,596 objects and the model of 5,596. A dump's value is never replaced. Where
both exist they were compared on this run: the types agree for
1,753 of 1,753 objects and the
models for 1,751 of 1,753.

**277 objects are still of unknown type**: no dump
read it and no cache record covers them. The types as published:

* `Generic` — 2,865
* `Chest` — 2,421
* `SpellFocus` — 903
* `Questgiver` — 254
* `Goober` — 188
* `Chair` — 134
* `Text` — 96
* `Mailbox` — 79
* `Difficulty` — 71
* `Trap` — 69
* `Door` — 67
* `Button` — 60
* `SpellCaster` — 39
* `Transport` — 30
* `MeetingStone` — 25
* `FishingHole` — 21
* `MOTransport` — 15
* `GuildBank` — 11
* `BarberChair` — 9
* `MapObject` — 6
* `Binder` — 6
* `FishingNode` — 1
* `AuraGen` — 1
* `DuelArbiter` — 1
* `Ritual` — 1
* `Camera` — 1

## Honest gaps

* **25 objects have no usable position.** Their
  coordinates were recorded as exactly 0,0,0. The object is real and
  stays listed; only its position is missing.
* **0 objects have no name** in any dump.
* **69 objects were given more than one name.**
  All of them are kept, in `other_names`, rather than one being
  quietly chosen and the rest dropped.
* **6,507 objects were seen in more than one
  upload.** Uploads are not people. One contributor can send several
  -- `docs/GAMEOBJECT-DUMPS.md` says who sent what -- so a second
  upload is a second sighting, not a second witness.
* Zone names are printed exactly as the dumps wrote them. `Aszhara`
  and `Azshara` are **two different zones** here, not a typo -- they
  have different internal map names and not one id in common.

Built from 159 dump files across 48 zones. Stock
reference: AzerothCore base world database, 9fb906bb72 2026-08-21.

