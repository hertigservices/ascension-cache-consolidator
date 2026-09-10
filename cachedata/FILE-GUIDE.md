# What each file is

A short guide to every kind of file here — what the game used it for, what it
contains, and what it deliberately does not. No tooling required to read this.

## Where this data comes from

The WoW client keeps a folder called `Cache\WDB`. Whenever the server tells it
about something — an item, a creature, a quest — the client writes that answer
to disk so it never has to ask again. Those files are what players submitted.

Two consequences shape everything here:

1. **A cache only holds what that player actually looked at.** Nobody's cache is
   complete. Merging many of them is the only way to approach full coverage.
2. **A cache holds what the server said _at the time_.** When Ascension retunes
   an item, older caches keep the older values. Both readings were true; they
   are kept as variants rather than one silently overwriting the other.

## The cache files

### `itemcache.wdb`  — 643,581 distinct records held

*Stored from:* `SMSG_ITEM_QUERY_SINGLE_RESPONSE`

Item definitions: name, icon, quality, item level, stats, damage, price, and on-use spells. The client writes one record each time it asks the server "what is item N?", so it never has to ask twice. This is what lets tooltips, bags and the auction house draw an item the moment you see it.

**Not in this file:** Not loot tables, not drop sources, not where an item comes from.

### `creaturecache.wdb`  — 26,585 distinct records held

*Stored from:* `SMSG_CREATURE_QUERY_RESPONSE`

NPC and mob identity: name, the title under the name, creature type, family, rank (normal/elite/boss) and up to four display models. Written when the client first sees a creature and needs to label it.

**Not in this file:** A thin slice only — no level, faction, health, loot or AI. Those never leave the server, so no cache can contain them.

### `gameobjectcache.wdb`  — 15,770 distinct records held

*Stored from:* `SMSG_GAMEOBJECT_QUERY_RESPONSE`

World objects: doors, chests, ore veins, herbs, mailboxes, campfires. Holds the object's type, display model, name, and 24 type-specific data fields (lock id, loot id, spell focus, and so on).

**Not in this file:** Not placements. No cache records where objects stand in the world.

### `questcache.wdb`  — 21,456 distinct records held

*Stored from:* `SMSG_QUEST_QUERY_RESPONSE`

Quest text and structure: title, objectives, description, completion text, required kills and items, and rewards. Written when the client opens a quest.

**Not in this file:** Not quest chains or availability conditions.

### `npccache.wdb`  — 2,075 distinct records held

*Stored from:* `SMSG_NPC_TEXT_UPDATE`

The gossip text an NPC greets you with. Eight alternative blocks per entry, each with a probability, male and female wording, language and emotes.

**Not in this file:** Not vendor stock, not trainer lists.

### `pagetextcache.wdb`  — 285 distinct records held

*Stored from:* `SMSG_PAGE_TEXT_QUERY_RESPONSE`

The body text of readable objects — books, signs, letters on the ground. Pages chain together through NextPageId.

**Not in this file:** Not the item that holds the book; that is in itemcache.

### `itemnamecache.wdb`  — 3,039 distinct records held

*Stored from:* `SMSG_ITEM_NAME_QUERY_RESPONSE`

A minimal item record: name and inventory slot only. The client uses it where it needs to label an item it has never fully queried, such as in search results.

**Not in this file:** Deliberately tiny — no stats. Use itemcache for anything real.

### `itemtextcache.wdb`

*Stored from:* `SMSG_ITEM_TEXT_QUERY_RESPONSE`

The written body of mail and letters the player has read.

**Not in this file:** NEVER PUBLISHED. This is other players' correspondence, not game data.

### `wowcache.wdb`

*Stored from:* `(undocumented)`

A small misc client cache whose format we have not verified.

**Not in this file:** NEVER PUBLISHED while its contents are unconfirmed.

## The addon files (`lua/`)

These did not come from `Cache\WDB`. They are addon **SavedVariables** — the
file an addon writes when you log out — and they are published in that same
format, so you can drop one into your account's own SavedVariables folder
and the addon will read it.

They are merged differently from the caches. A cache record is a fact the
server stated, so two copies either agree or are separate variants. An addon
entry is an *accumulator*: `amountMin` is the smallest hit that player ever
saw. So numeric ranges are widened to cover every submission, observed flags
are OR'd together, and only identity fields are expected to agree.

> **These cannot be split by game mode.** The client files its caches in a
> per-mode folder, which is what makes the per-mode `.wdb` sections possible.
> These addons store one table for the whole account with no record of which
> realm or mode an observation came from, so the merged file blends them.

### `lua/MobSpells.lua` — 3,161 creatures across 115 zones, 9,060 spell records

What mobs actually cast, and how hard it hit: spell id, damage school,
the observed damage range, swing speeds, and whether that ability was
ever seen to crit, miss, get dodged, parried, blocked or resisted.

This is the only data here that was never sent as a query response — it is
*observed server behaviour*, reconstructed from combat log events, which
is precisely the part that no cache file can contain.

**Not in this file:** the `profileKeys` and `profiles` branches, which key
settings by `<Character> - <Realm> - <Mode>`; and the per-record `lastGUID`
and `lastTime` fields, which name a specific mob instance in a specific
play session and mean nothing outside it.

### `lua/AIO_Client.lua` — 34 server-pushed addon files, 43 distinct builds seen

AIO is the framework Ascension uses to push addon code from the server to
the client at login; the client caches what it received here. So this is
the custom UI itself — the source of the panels that do not exist in a
stock 3.3.5a client.

Entries are keyed by filename and deduplicated on the code's own hash, so
one entry per distinct build. Where more than one build of a file was
submitted, `AIO_Client.variants.json` lists them all and the `.lua` carries
the most corroborated one.

**Not in this file:** the `AIO_sv` branch — action bar layouts and frame
positions, keyed by character name.

## The world catalogue (`catalogue/`)

Plain tab-separated lists of **things that exist in the world**: 7,651 objects and 548 creatures, each with one example
position, how many separate uploads saw it, and every zone it turned
up in.

These did not come from anybody's cache. Players walked the world with
a dump addon running and sent in what it wrote, which makes this the
one part of the dataset that is an *observation* rather than a
recording of what a server said.

> **It is a catalogue, not a spawn table.** Only the first sighting of
> each object was recorded, common props like trees and chairs were
> filtered out before it ever reached us, some of the dumps are
> partial, and it is a snapshot that predates the newer zones. Load it
> into a `gameobject` table and you will get a world that is mostly
> empty and confidently wrong. `catalogue/README.md` gives the full
> list of what it can and cannot tell you.

> Objects and creatures are **separate id spaces** and are kept in
> separate files. Creature 1622 and GameObject 1622 are unrelated
> things; 34 ids exist in both.

These two are not gzipped, for the same reason `sources.tsv` is not:
they are small enough to open, grep and read without unpacking
anything.

## Everything is gzipped

Every data file here ends in `.gz`. That is not a preference — uncompressed
this dataset is about 756 MB and its largest single file is a 254 MB
itemcache, and GitHub refuses to store any file over 100 MB. Compressed the
whole thing is about 104 MB.

Gzip is not an archive format like `.zip`; each `.gz` holds exactly one file,
so `itemcache.wdb.gz` unpacks to `itemcache.wdb` and nothing else. Open one
with 7-Zip, with `gunzip file.gz` on Mac or Linux, or straight from code
(`gzip.open` in Python, `zcat` in a shell pipeline) without unpacking at all.

To put a mode's caches into your own game, use the tool in this repository:

```
python tools/unpack.py                          list what is here
python tools/unpack.py --mode <mode>            unpack one mode
python tools/unpack.py --mode <mode> --into DIR ...into your cache folder
```

It refuses to overwrite an existing cache unless you pass `--force`, and keeps
a `.bak` when it does. Your own cache is the only record of what your realm
told your client, so it is not ours to discard.

## File formats in this repository

| file | format | read it with |
|---|---|---|
| `wdb/<mode>/*.wdb.gz` | the client's own binary cache format | `tools/unpack.py`, then the game client |
| `by-mode/<mode>/*.tsv.gz` | tab-separated text, one row per entry | Excel, `pandas` (reads `.gz` directly), `LOAD DATA INFILE` |
| `union/*.tsv.gz` | same, widest coverage across all modes | as above |
| `raw/*.pack.gz` | `[entry u32][size u32][payload]` records | any language; no header to skip |
| `raw/*.index.tsv.gz` | one row per stored record with its sha1 and provenance | text editor, after unpacking |
| `sources.tsv` | every submitted file: realm, mode, capture date, counts | text editor (this one is not compressed) |
| `catalogue/*.tsv` | objects and creatures observed in the world | text editor, Excel (not compressed either) |

The `.wdb` files are the ones to use if you just want a better cache. The TSVs
are for importing into a database. The `raw/` packs are for writing your own
decoder without having to re-collect anything.

| `lua/MobSpells.lua` | addon SavedVariables, plain Lua | a text editor, or the addon itself |
| `lua/AIO_Client.lua` | addon SavedVariables, plain Lua | a text editor |

