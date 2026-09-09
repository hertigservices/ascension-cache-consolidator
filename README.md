# Ascension Cache Consolidator

Merges World of Warcraft client cache files (`Cache\WDB`) submitted by many players
into one deduplicated dataset, and writes the result back out **in the client's own
format** so it can be used directly.

Built for [Project Ascension](https://ascension.gg)'s 3.3.5a client, where server-side
game data is not public and the client's own cache is the only record of it that
players hold.

**Have cache files of your own?** See [CONTRIBUTING.md](CONTRIBUTING.md) — `tools/contribute.py` packages a submission from your install, keeps only the
parts that are game data, and shows you the list before it writes anything.

## The problem it solves

The client writes a cache record every time the server tells it about something — an
item, a creature, a quest. So a player's cache is a record of *what that player
happened to look at*. Nobody's cache is complete:

| `itemcache.wdb` | distinct items |
|---|---:|
| median submitted file | 4,592 |
| best file collected by ordinary play | 42,616 |
| largest single systematic harvest | 548,497 |
| **union of all submissions** | **551,644** |

That harvest is one contributor sweeping the item id space deliberately instead of
playing, and it gets most of the way there on its own. Merging still finds 3,147 items
it never saw, and loses none of what it did.

Collecting caches is easy. Merging them is not, for two reasons:

1. **The same file arrives many times.** The same `itemcache.wdb` shows up inside a
   zip, a rar and a tarball from three different people. 4,152,299 record instances
   across 525 distinct submitted files collapse to 639,740 distinct records — a 6.5×
   duplication rate.
2. **The same entry legitimately differs.** Ascension retunes items between patches
   and across game modes, so one item id can have several *correct* payloads. Taking
   "the newest" and discarding the rest silently destroys data; keeping them all
   without attribution makes the dataset unusable. 26,684 items here carry more than
   one distinct record, and one carries seven.

Those two numbers count different things, and the distinction runs through the whole
dataset: an **entry** is a game object (item 12345), a **record** is one server answer
about it. 551,644 distinct items are described by 581,614 distinct item records,
because some items were retuned and were captured on both sides of the change.

This tool treats the two problems above as different problems. Byte-identical records are collapsed to
one, carrying a count of how many independent submissions corroborate them. Records
that genuinely differ are **all** kept as variants, tagged with the game mode and
capture date that produced them, and the per-mode views pick a winner from within that
mode rather than across all of them.

## What it produces

**The dataset itself is in this repository**, under [`cachedata/`](cachedata/). You do
not have to run anything to use it.

```
cachedata/
  wdb/<mode>/*.wdb.gz      merged caches in the client's own binary format
  by-mode/<mode>/*.tsv.gz  decoded, per game mode -- use these for values
  union/*.tsv.gz           decoded, widest coverage -- use for "does entry N exist"
  raw/*.pack.gz            every distinct payload, lossless, for your own decoder
  raw/*.index.tsv.gz       per record: sha1, size, modes, dates, corroboration count
  lua/*.lua                merged addon SavedVariables, in the addon's own format
  sources.tsv              every submitted file: realm, mode, capture date, counts
  FILE-GUIDE.md            what each file is, in plain language
```

Eleven game modes carry records: `conquest-of-azeroth`, `coa-alpha`, `coa-beta`,
`free-pick`, `season-10-freepick`, `season-10-wildcard`, `season-9`, `warcraft-reborn`,
`live-qa`, `stress-test` and `unknown`. Modes are detected from the client's folder
naming (`<Realm> - <Mode>`); submissions zipped from too high up lose that folder, so
their mode is recovered by **payload fingerprinting** against known-mode data and
marked as inferred with its agreement score. `unknown` is not a game mode — it is what
could not be identified either way, kept apart rather than guessed into a real one.

### Using the merged caches

The data files are gzipped because they have to be. Uncompressed the dataset is 756 MB
and the merged `season-10-freepick` itemcache alone is 254 MB, past GitHub's 100 MB
per-file hard limit. Compressed it is 105 MB with nothing over 16 MB. Each `.gz` holds
exactly one file, so anything that reads gzip reads these: 7-Zip, `gunzip`,
`pandas.read_csv`, `gzip.open`.

To put a mode's caches into your own game:

```bash
python tools/unpack.py                       # what is in here
python tools/unpack.py --mode conquest-of-azeroth --into "<your WoW>/Cache/WDB/enUS/<Realm> - Conquest of Azeroth"
```

It parses each cache's header before letting it land, refuses to overwrite a cache you
already have unless you pass `--force`, and keeps a `.bak` when it does. Your own cache
is the only record of what your realm told your client; it is not this tool's to throw
away. **Close the game first** — the client rewrites these files when it exits.

## Usage

```bash
python tools/update.py
```

Drop submissions (zip / rar / 7z / tar.gz, or loose folders) into `_inbox/` and run it.
Every stage is idempotent, so re-running after a bad drop is safe and cheap.

The six stages, each runnable on its own:

| stage | what it does |
|---|---|
| `intake.py` | unpack archives, hash-dedup whole files, update the ledger |
| `merge.py` | fold every record into the union store, dedup, identify unlabelled modes |
| `luamerge.py` | merge addon SavedVariables field-by-field, dropping character branches |
| `export.py` | write the decoded per-mode / union / raw views |
| `rebuild.py` | write merged, client-loadable `.wdb` files per mode |
| `audit_publish.py` | scan everything about to be published for player data |

Three tools sit outside the pipeline:

| tool | what it does |
|---|---|
| `unpack.py` | decompress the published dataset, or install one mode into your client |
| `publish.py` | run the pipeline, mirror the result into this repository, audit it, commit and push. `--watch` repeats that whenever the inbox changes, so a dropped submission becomes public without anyone deciding anything by hand |
| `test_audit.py` | prove the publish gate still catches what it claims to, in both directions |

Paths are resolved by `tools/config.py` and need no configuration for a fresh clone.
To scan collections that live elsewhere, add a `config.json` next to `tools/`:

```json
{ "extra_scan_roots": ["D:/my/other/caches"] }
```

Requires Python 3.8+ and 7-Zip (only to unpack submitted archives).

## Addon SavedVariables

Caches are not the only thing players hold. Five addons record things the client never
files in `Cache\WDB` at all, and each is merged and republished in its own `.lua`
format:

- **MobSpells** — what mobs actually cast and how hard it hit, reconstructed from
  combat log events. This is *observed server behaviour*, so no cache file can contain
  it: 3,161 creatures across 115 zones and 9,060 spell records, including Ascension's
  custom ones.
- **AIO** — the framework Ascension uses to push addon code to the client at login.
  The client caches what it received, which makes this the custom UI's own source:
  34 files, the largest a 212 KB Character Advancement panel. Each one is also
  extracted to `cachedata/lua/addons/` as plain readable Lua.
- **Auctionator** — auction prices, per realm and per mode.
- **GatherMate2** — herb, ore, fishing, gas, tree and treasure node positions by zone.
- **CoASniff** — the names and argument shapes of Ascension's custom client events.

These merge differently from caches, and differently from each other, because a cache
record is a fact the server stated while an addon entry is something a player watched.
MobSpells is an **accumulator** — `amountMin` is the smallest hit *that player* saw, so
ranges widen to cover every submission and observed flags are OR'd. Auctionator is an
**observation** — widening a price range would assert a spread nobody ever saw, so the
newest capture wins outright. GatherMate2 is **existence** — nodes are unioned, and two
submissions disagreeing about one is a conflict to report, not a number to average.

They also cannot be split per game mode, and the tool does not pretend otherwise. The
per-mode `.wdb` sections are possible because the client files caches in a per-mode
folder; these addons keep one account-wide table with no record of which realm an
observation came from.

Adding another addon is a spec in `luamerge.py` — which branch is the payload, how to
combine each field, which branches are character state — not new code.

## Privacy

Players submit whole folders, and those folders contain much more than game data. A
`WTF` tree is organised as `WTF/Account/<login email>/<Realm - Mode>/<CharacterName>/`
and carries chat logs, macros and combat logs.

`scrub.py` therefore works from an **allow-list, not a block-list**: a file is
published only if its kind is known to be server-sent game content. Anything
unrecognised is quarantined for a human to look at, because the cost of guessing wrong
is permanent — a force-push does not un-publish a leak.

Two cache types are never published even though they are `.wdb` files:
`itemtextcache` holds the text of mail and letters the player read, and `wowcache`'s
format is unverified.

For addon files the allow-list is applied *per branch*, because one file holds both
kinds of data: `MobSpells.lua` keeps its observed mob table but drops `profileKeys`
(literally `<Character> - <Realm> - <Mode>`) and the per-record `lastGUID`/`lastTime`,
which name one mob instance in one play session. `AIO_Client.lua` keeps the pushed
addon code and drops `AIO_sv`, which is action bars keyed by character name.

`audit_publish.py` is the gate. It scans the whole output tree for emails, player
GUIDs, account paths and local filesystem paths, and exits non-zero on any hit. It
decompresses as it goes, because almost every published file is now gzipped and
compressed bytes match no pattern — an archive it cannot open is a **failure**, never a
skip, since "scanned nothing" and "found nothing" would otherwise print the same word.

That gate fails open in the worst way: one that has stopped matching still prints
CLEAN. So it has its own test, `test_audit.py`, with cases it must catch and cases it
must let through — the second list exists because a gate that refuses its own
documentation gets "fixed" by loosening it, which is how a real leak escapes six months
later.

The same allow-list runs on the contributor's own machine: `tools/contribute.py` reads
an install and packages only recognised game content, so a submission never has to
travel through anyone else's hands carrying a `WTF` tree. [CONTRIBUTING.md](CONTRIBUTING.md)
explains it without assuming the reader writes code, and gives a by-hand route for
people who would rather not run a script.

## Correctness

Guessing a binary layout produces plausible-looking garbage, so nothing here relies on
output "looking right":

- **Exact byte consumption.** Each record's payload length is known from the file
  itself, so a correct field layout consumes *exactly* that many bytes. Every decoder
  returns its consumed count and the exporter counts any mismatch as a failure. All
  seven cache types currently decode with 100% exact consumption.
- **Round-trip verification.** Every rebuilt `.wdb` is re-parsed and compared
  payload-by-payload against what went into it. A mismatch is a hard failure.
- **Round-trip verification, again, for `.lua`.** SavedVariables output is re-parsed
  after writing, and must also be stable under re-serialisation — a file the addon
  cannot load would be worthless, and parsing it back is the cheap proof we have.
- **Round-trip verification, once more, for the compression.** Every published `.wdb.gz`
  is read back and must decompress to the exact bytes that passed the cache check, so
  the two proofs meet: what a reader unpacks is what was parsed and verified here.
- **Deterministic output.** Records are written sorted by entry, and gzip streams are
  written with `mtime=0`, so regenerating an unchanged store produces byte-identical
  files and git sees no diff. Measured: of 201 published files, a full re-run changed
  none of them.

See [docs/WDB-FORMAT.md](docs/WDB-FORMAT.md) for the binary format, including the parts
that are not documented elsewhere and cost real time to work out.

## License

MIT — see [LICENSE](LICENSE).

The *tool* is MIT. The cache data it processes is Project Ascension's game content,
submitted by players for preservation; it is not covered by this license.
