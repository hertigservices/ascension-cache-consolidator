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
| `type` | object type, **blank where it could not be read** (see below) |
| `display_id` | the model the client drew; blank if not recorded |
| `sightings` | how many rows across all files mention this id |
| `submissions` | how many separate uploads saw it -- 2 or more means two people independently found the same thing |
| `zones` | how many distinct zones it was seen in |
| `example_*` | **one** position it was seen at, not its only one |
| `lock_id`, `lock_type` | for locked objects, where recorded |
| `other_names` | every other name any dump gave this id |
| `seen_in` | which uploads it came from |
| `zone_list` | every zone it was seen in |

## `type` is blank more often than you would expect

That is on purpose. The dumper wrote `Door` when it could not read an
object's type, and it could not read it most of the time: of the
6,395 rows marked `Door`, 6,393 have no model id either, while every
row of every other type has one. `Grave Moss` -- a herb -- is filed as
a `Door`. Reporting that as a real breakdown would tell you the world
is four-fifths doors.

So an untyped `Door` is published as **blank, meaning unknown**. The
types that remain are the ones the dump actually read:

* `Generic` — 779
* `Chest` — 653
* `SpellFocus` — 164
* `Questgiver` — 37
* `Goober` — 33
* `Text` — 24
* `Mailbox` — 15
* `Transport` — 13
* `FishingHole` — 11
* `Door` — 11
* `SpellCaster` — 10
* `Chair` — 6
* `Button` — 6
* `MOTransport` — 5
* `Trap` — 4
* `MeetingStone` — 2
* `Difficulty` — 2
* `AuraGen` — 1
* `DuelArbiter` — 1
* `GuildBank` — 1

Types and model ids exist only in the `.csv` dumps, so zones that
were only ever dumped to `.txt` have neither.

## Which of these are Ascension's own?

Stock 3.3.5a GameObjects have ids below 200000 and Ascension's
worldforged ones were given a range above it, so **2,061
of the 7,651 objects look custom** and
5,590 look like stock 3.3.5a. That is a rule of thumb for
reading the list, not a guarantee, and nothing was included or left
out on the strength of it.

## Honest gaps

* **25 objects have no usable position.** Their
  coordinates were recorded as exactly 0,0,0. The object is real and
  stays listed; only its position is missing.
* **0 objects have no name** in any dump.
* **69 objects were given more than one name.**
  All of them are kept, in `other_names`, rather than one being
  quietly chosen and the rest dropped.
* **Only 6,507 objects were seen by more than one
  upload.** The rest rest on a single contributor's dump.
* Zone names are printed exactly as the dumps wrote them. `Aszhara`
  and `Azshara` are **two different zones** here, not a typo -- they
  have different internal map names and not one id in common.

Built from 159 dump files across 48 zones.

