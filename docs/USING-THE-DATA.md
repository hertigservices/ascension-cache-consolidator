# Using the data: getting it into a client and onto a server

This is the "so what" document. The dataset under `cachedata/` is a record of
what Ascension's servers told players' clients. This page is about putting that
record back in front of a player: in the game client, so names and tooltips
render, and in a server's world database, so the server can hand the things out.

Two tools do the work, and they are deliberately separate because the two
halves are separate:

| half | tool | what it changes | needs |
|---|---|---|---|
| client | `install.py` | `Cache\WDB\...\*.wdb` and addon SavedVariables in your game folder | Python 3, the game closed |
| server | `import_world.py` | `*_template` tables in an AzerothCore world database | Python 3, the `mysql` command-line client, a world DB you own |

**Both tools live in a different repository from this data.** Getting them is
the next section, and it is the one step people skip.

Neither needs the other. A client with the caches installed shows names and
tooltips for everything in the dataset on *any* realm, including one that has
never heard of the item. A server with the tables imported can `.additem` an
Ascension item and the client will ask it for the tooltip and get one. Doing
both is what makes the two agree.

## Before anything else: get the tools

This repository holds the **data**. The two tools that install it live in
the preservation repository, under `tools/cache-consolidator/`. Nothing in
this repository will run on its own, so start here:

```
git clone https://github.com/hertigservices/Ascension_preservation
cd Ascension_preservation/tools/cache-consolidator
```

No git? Use the green **Code → Download ZIP** button on that page, unzip
it, and open the `tools/cache-consolidator` folder inside.

**Every command in this guide is run from that folder** — that is why they
all start with `python -B tools/...`. If you get `can't open file` or
`No such file or directory`, you are in the wrong folder; nothing is
broken.

You do **not** need to download this data repository by hand. `install.py --fetch`
pulls it for you (about 120 MB). If you would rather have a checkout of it — and you need one for the server half, which cannot
download — clone it too and remember the path to its `cachedata` folder:

```
git clone https://github.com/hertigservices/ascension-data
```

The tools no longer look for `cachedata` beside themselves. With no
`--data`, they look in `%LOCALAPPDATA%\AscensionPreservation\cache\cachedata`
(on Linux and macOS, `~/AscensionPreservation/cache/cachedata`), which is
where the maintainer's own copy lives and is empty on a fresh machine. So
on the commands below, either use `--fetch` or pass `--data`.

## What the data can and cannot show

Be clear about this before installing anything. A client cache is the client's
copy of the server's answers to **query** packets: "what is item 9200841?", "who
is creature 11001001?", "what does quest 8200519 say?". That is enough for:

- item names, tooltips, stats, icons (via display id), quality, sell price
- creature names, subnames, models, type, family, rank, kill credits
- gameobject names, types, display ids, template data
- quest titles, objectives, description text, rewards, requirements
- book / plaque page text, and the gossip text NPCs greet you with
- item names for the auction house and mail (`itemnamecache`)

It is **not** a copy of the world. Nothing here says *where* a creature stands,
*what it drops*, *which vendor sells* an item, *who gives* a quest, *what an NPC's
gossip menu offers* or *what a spell does*. Those never crossed the wire as
cacheable records. So:

- a creature imported to a server is a template with no spawn, no loot, no
  faction, level 1, and default stats; you can `.npc add` it and it stands there
- a quest imported to a server has its text and rewards but no quest-giver; it
  can be `.quest add`-ed to a character and will show in the log correctly
- an item imported to a server is the one thing that *is* complete: the item
  query carries almost the whole template, so `.additem` produces a usable item
  with a correct tooltip, stats and (stock) procs
- an Ascension spell an item references is not in a stock `Spell.dbc`, so the
  tooltip line for it is blank on a stock client and the proc does nothing on a
  stock server; the *Ascension* client has the spell in its DBCs and shows it

The addon SavedVariables (`cachedata/lua/`) are a different kind of record —
things players observed rather than things the server stated — and they show up
only if the matching addon is installed: MobSpells, GatherMate2, Auctionator.

## Two setups

**A. Ascension client + your own AzerothCore realm.** The client is the one
Ascension ships (with its custom DBCs, models and UI); the server is a stock
AzerothCore worldserver reached through the shim and bridge in
[hertigservices/Ascension_preservation](https://github.com/hertigservices/Ascension_preservation)
(auth shim on 3799, bridge on 8088 in front of the core on 8086; see that repo's
`docs/HOW-THE-REDIRECT-WORKS.md`). Everything in this dataset renders correctly
because the client has the display ids, spells and zones it refers to. This is
the setup the data was captured from, minus the server logic.

**B. Stock 3.3.5a client + AzerothCore.** No Ascension binary anywhere. The
caches still install (the file format is identical) and names, text and stats
all show. Three things do not:

- **Item models and icons are wrong.** Ascension renumbered `ItemDisplayInfo.dbc`
  wholesale, so a display id from the dataset points at a different (or no) row
  in a stock client. Creature display ids are *not* renumbered and show fine.
- **Custom spell lines are blank.** Anything referencing a spell id above the
  stock range has no `Spell.dbc` row to render from.
- **Custom zones are not walkable.** Ascension's new areas have no stock map
  data; a quest set there reads fine and cannot be done.

Both setups start from the same two commands below. The difference is only what
the client is able to draw.

## Step 1 — client: `install.py`

From `Ascension_preservation/tools/cache-consolidator`:

```
python -B tools/install.py --fetch               # download the data, find the client, show the plan
python -B tools/install.py --fetch --write       # do it (game must be closed)
python -B tools/install.py --undo                # put the replaced files back
```

`--fetch` downloads all 120 MB every time it is passed, and puts the result
in `<your client folder>/cachedata-download`. So pass it once, then point
later runs at what it left behind — or at your own checkout:

```
python -B tools/install.py --data "C:/Games/Ascension/cachedata-download" --write
python -B tools/install.py --data path/to/ascension-data/cachedata --write
```

Or double-click `tools/Install Caches.cmd`, which runs the plan and then asks.

What it does, in order:

1. **Finds the client** — the usual install folders, or `--client PATH`. It knows
   an Ascension client from a stock one by the executable, and reads the
   `Cache\WDB\<locale>\` tree it finds there.
2. **Works out which mode each cache folder is.** An Ascension client keeps one
   folder per realm, named `<Realm> - <Mode>` (`Area 52 - Free-Pick`,
   `Vol'jin - Conquest of Azeroth`), and the mode is read off the name. A folder
   it cannot name (`[Ascension-Local]`, a private realm) needs `--map
   "FOLDER=mode"` or `--mode` once for all. A stock client keeps its caches flat
   in `Cache\WDB\enUS\` and there is no realm name to read, so `--mode` is
   required there. `--list-modes` prints the choices.
3. **Merges, record by record.** For every cache file it reads yours, reads the
   published one for that mode, and writes the union. Where both hold the same
   entry, **yours wins** — your cache is what *your* realm told *your* client,
   and the published copy may be from a different patch. `--prefer archive`
   flips that. The plan prints, per file, how many records you have, how many
   the archive has, how many would be added and how many conflict, before
   anything is written.
4. **Keeps your header.** See the cache-version section below for why this
   matters more than it sounds.
5. **Backs up and writes atomically.** Every replaced file goes to
   `Cache\WDB-backup-<timestamp>\` first, new files are recorded there too, and
   `--undo` restores the most recent backup. The rebuilt bytes are re-parsed and
   checked record-by-record against the merge decision before they land.
6. **Optionally merges addon data** (`--addons`) into
   your account's `SavedVariables` folder under `WTF`. MobSpells ranges widen and flags OR
   (it is an accumulator); GatherMate2 nodes union; Auctionator keeps your newer
   observation. With several account folders, `--account NAME` picks one.

It **refuses to write while the game is running**, because the client rewrites
every cache file on exit and would overwrite the install. `--ignore-running` is
for people who know their client is not the one in the process list.

Fetching the dataset without git: `--fetch` downloads the repository zip from
GitHub and uses the `cachedata/` inside it (`--from-zip FILE` for a zip you
already have). The repository's history is large; a shallow clone
(`git clone --depth 1`) or the zip is the sane way to get it.

### The cache version, and why the client might throw your caches away

Bytes 20–23 of every `.wdb` header hold a **cache version**. At login the server
sends its own number (`SMSG_CLIENTCACHE_VERSION`), and if the two differ the
client deletes every cache file for that realm and starts over. This is the
mechanism servers use to force a reset after a data patch — and it will
silently erase an install of these caches if the numbers do not line up.

- AzerothCore sends `ClientCacheVersion` from `worldserver.conf`; at its default
  of `0` it sends `version.cache_id` from the world database instead. A fresh
  database from the base SQL has **16** there.
- The published `.wdb.gz` files carry whatever header the contributing client
  had, so the number **varies by mode** (the live Ascension realms use large
  values such as `1787155823`). `install.py` prints the number it is writing for
  every file.
- `install.py` keeps **your** header when you already have the file, so a
  cache the server has accepted before stays accepted. For a folder with no
  existing file it uses the archive's header, which is probably not your
  server's number.

So make them agree, one way or the other:

```
python -B tools/install.py --data DATA --cache-version 16 --write      # rewrite the headers to match the server
python -B tools/import_world.py --data DATA --set-cache-version 16 ... # or tell the server what the files say
```

or set `ClientCacheVersion = N` in `worldserver.conf`. `install.py` prints the
`ClientCacheVersion` line it wants at the end of every plan. And **never** use
an addon or launcher "clear cache" button after installing; that is the same
deletion done by hand.

## Step 2 — server: `import_world.py`

Also from `Ascension_preservation/tools/cache-consolidator`. This half needs
a real copy of this repository, and it has no `--fetch` of its own. What
`install.py --fetch` downloads will **not** do: it keeps only `wdb/` and
`lua/`, and the server half reads `union/` and `by-mode/`. Clone or unzip
this repository, and let `DATA` below stand for its `cachedata` folder:

```
python -B tools/import_world.py --data DATA --list-sources            # which game modes are published
python -B tools/import_world.py --data DATA --ask-password            # preview only
python -B tools/import_world.py --data DATA --ask-password --apply    # write
python -B tools/import_world.py --data DATA --source conquest-of-azeroth --ask-password --apply
```

Defaults are AzerothCore's: database `acore_world`, user `acore`, host
`127.0.0.1`, port `3306`. Change any with `--db/--user/--host/--port`. The
password is asked for interactively or read from a MySQL option file
(`--defaults-file PATH`); it is never accepted on the command line. `mysql` and
`mysqldump` are found on `PATH` or in the usual install folders, or given with
`--mysql/--mysqldump`.

**Pick a source.** `union` (the default) is every record ever seen across every
mode; a `by-mode/<mode>` source is one game mode's view. The same item id
carries different stats on different modes, so a realm meant to mirror one mode
should import that mode.

**Read the preview.** It writes `stage.sql`, `apply.sql` and `report.md` to
`import-out/` (`--out DIR`), loads the data into `_cachemerge_*` staging tables
next to your world database, and prints, per table:

- `rows to ADD` — rows your database does not have at all
- per column, `fill` — cells on rows you *do* have that still sit on their
  schema default and would receive the cached value
- per column, `conflict` — cells where both sides hold a real value and they
  disagree. The merge **never writes these**; they are listed for a human.

`report.md` lists every value that was refused because it would not fit its
column (a `tinyint` creature family of 601, a 300-character description into a
`varchar(255)`). AzerothCore's recommended MySQL runs non-strict, which would
have clamped or truncated those silently; they are left at the column default
instead and the generated SQL runs in strict mode so nothing else can slip.

**Apply.** `--apply` first dumps the touched tables with `mysqldump` into the
output folder (skip with `--no-backup`), runs `apply.sql`, and drops the staging
tables. Two passes per table: ADD, then FILL. Both are guarded so **re-running is
a no-op**; the preview after an apply shows `rows to ADD 0` and `fill 0`
everywhere, which is the check that it worked. `--add-only` skips FILL, for
people who want stock rows left byte-for-byte stock.

Tables touched, and where the cache's numbered columns go on a modern schema:

| cache | table | notes |
|---|---|---|
| itemcache | `item_template` | `StatsCount` has no column and is dropped |
| creaturecache | `creature_template` + `creature_template_model` | `modelid1..4` become one row per model, Idx 0–3; `movementId` is excluded (Ascension's sentinel 999) |
| gameobjectcache | `gameobject_template` + `gameobject_questitem` | `questItem1..6` become one row per item |
| questcache | `quest_template` | wire names mapped to AzerothCore's (`Title`→`LogTitle`, `Method`→`QuestType`, …) |
| pagetextcache | `page_text` | |
| npccache | `npc_text` | |

Every inserted row gets `VerifiedBuild = 12340`. Recent cores skip
`item_template` rows whose `VerifiedBuild` is NULL, so a NULL would put the row
in the database and keep it out of the game.

**Then restart the worldserver.** Templates are loaded once at startup; nothing
imported is visible until then, and the tool does not restart anything.

Measured on a fresh AzerothCore world database (base SQL of 2026-09):

| source | items added | creatures | models | gameobjects | quests | npc texts | page texts |
|---|---:|---:|---:|---:|---:|---:|---:|
| `conquest-of-azeroth` | 59,959 | 8,443 | 9,773 | 5,007 | 1,194 | 834 | 57 |
| then `union` on top | 446,160 | 2,185 | 2,435 | 953 | 7,905 | 123 | 16 |

Expect log lines from the worldserver about creatures with faction 0, items
with unknown classes and spells it cannot find. They are the gaps described
above, reported rather than hidden; the core loads the rows anyway.

## Checking it in game

Client side, on any realm:

- Hover a link or `/run print(GetItemInfo(9200841))` for an item the dataset
  has and your realm does not. A name back means the client read the cache.
- `tools/gametest.py` builds a controlled version of that check: a set of
  Ascension-only **probe** ids that must resolve after the install and
  **control** ids that must stay unresolved, printed with expected names, to be
  run before and after. It has been built and reviewed but, honestly, **not yet
  run against a live client by the maintainers**; if you run it, the result is
  worth reporting either way.

Server side, as a GM:

```
.lookup item Mystic Scroll         # names from the imported templates
.additem 9200841                   # a CoA-only item; tooltip should be complete
.lookup quest Conquerors Needed    # imported quests
.quest add 8200519                 # shows in the log with its text
.npc info                          # on a spawned imported creature: template values
```

## Troubleshooting

- **Everything vanished after first login.** Cache version mismatch; see above.
  Restore with `install.py --undo`, align the number, install again.
- **Names show, icons are question marks / wrong model (stock client).**
  Expected: renumbered `ItemDisplayInfo.dbc`. Only the Ascension client draws
  these correctly.
- **`install.py` says "several account folders".** Pass `--account NAME` for the
  account folder (under `WTF`) that plays on this realm.
- **`install.py` says a folder needs `--mode`.** The folder name does not carry
  a mode. `--map "That Folder=conquest-of-azeroth"`.
- **`import_world.py`: "Illegal mix of collations".** Should not happen (the
  staging tables copy the live collation), but if your world DB is not
  `utf8mb4_unicode_ci` check that every table has the same collation.
- **`import_world.py`: "mysql is not on PATH".** Pass `--mysql` with the path to
  the client binary that came with your MySQL/MariaDB install.
- **Item works, its proc does nothing (stock server).** The spell is
  Ascension's and is not in the stock `Spell.dbc` or spell scripts. That is a
  server-logic gap this dataset cannot fill.
