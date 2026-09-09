# Ascension Cache Consolidator

Merges World of Warcraft client cache files (`Cache\WDB`) submitted by many players
into one deduplicated dataset, and writes the result back out **in the client's own
format** so it can be used directly.

Built for [Project Ascension](https://ascension.gg)'s 3.3.5a client, where server-side
game data is not public and the client's own cache is the only record of it that
players hold.

## The problem it solves

The client writes a cache record every time the server tells it about something — an
item, a creature, a quest. So a player's cache is a record of *what that player
happened to look at*. Nobody's cache is complete:

| `itemcache.wdb` | distinct items |
|---|---:|
| best single submitted file | 42,616 |
| **union of all submissions** | **76,896** |

Collecting caches is easy. Merging them is not, for two reasons:

1. **The same file arrives many times.** The same `itemcache.wdb` shows up inside a
   zip, a rar and a tarball from three different people. 699,451 record instances
   across 334 distinct submitted files collapse to 134,320 distinct records — a 5.2×
   duplication rate.
2. **The same entry legitimately differs.** Ascension retunes items between patches
   and across game modes, so one item id can have several *correct* payloads. Taking
   "the newest" and discarding the rest silently destroys data; keeping them all
   without attribution makes the dataset unusable.

Those two numbers count different things, and the distinction runs through the whole
dataset: an **entry** is a game object (item 12345), a **record** is one server answer
about it. 76,896 distinct items are described by 94,965 distinct item records, because
some items were retuned and were captured on both sides of the change.

This tool treats the two problems above as different problems. Byte-identical records are collapsed to
one, carrying a count of how many independent submissions corroborate them. Records
that genuinely differ are **all** kept as variants, tagged with the game mode and
capture date that produced them, and the per-mode views pick a winner from within that
mode rather than across all of them.

## What it produces

```
cachedata/
  wdb/<mode>/*.wdb        merged caches in the client's own binary format
  by-mode/<mode>/*.tsv    decoded, per game mode -- use these for values
  union/*.tsv             decoded, widest coverage -- use for "does entry N exist"
  raw/*.pack.gz           every distinct payload, lossless, for writing your own decoder
  lua/*.lua               merged addon SavedVariables, in the addon's own format
  sources.tsv             every submitted file: realm, mode, capture date, counts
  FILE-GUIDE.md           what each file is, in plain language
```

Game modes are detected from the client's folder naming (`<Realm> - <Mode>`).
Submissions zipped from too high up lose that folder, so their mode is recovered by
**payload fingerprinting** against known-mode data and marked as inferred with its
agreement score.

## Usage

```bash
python tools/update.py
```

Drop submissions (zip / rar / 7z / tar.gz, or loose folders) into `_inbox/` and run it.
Every stage is idempotent, so re-running after a bad drop is safe and cheap.

The five stages, each runnable on its own:

| stage | what it does |
|---|---|
| `intake.py` | unpack archives, hash-dedup whole files, update the ledger |
| `merge.py` | fold every record into the union store, dedup, identify unlabelled modes |
| `luamerge.py` | merge addon SavedVariables field-by-field, dropping character branches |
| `export.py` | write the decoded per-mode / union / raw views |
| `rebuild.py` | write merged, client-loadable `.wdb` files per mode |
| `audit_publish.py` | scan everything about to be published for player data |

Paths are resolved by `tools/config.py` and need no configuration for a fresh clone.
To scan collections that live elsewhere, add a `config.json` next to `tools/`:

```json
{ "extra_scan_roots": ["D:/my/other/caches"] }
```

Requires Python 3.8+ and 7-Zip (only to unpack submitted archives).

## Addon SavedVariables

Caches are not the only thing players hold. Two addons record things the client never
files in `Cache\WDB` at all, and both are merged and republished in their own `.lua`
format:

- **MobSpells** — what mobs actually cast and how hard it hit, reconstructed from
  combat log events. This is *observed server behaviour*, so no cache file can contain
  it: 3,161 creatures across 115 zones, including Ascension's custom ones.
- **AIO** — the framework Ascension uses to push addon code to the client at login.
  The client caches what it received, which makes this the custom UI's own source.

These merge differently from caches, because they are accumulators rather than
statements: a cache record is a fact the server stated, but `amountMin` is the smallest
hit *that player* happened to see. So numeric ranges widen to cover every submission,
observed flags are OR'd, and only identity fields are expected to agree.

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

`audit_publish.py` is the gate. It scans the whole output tree — decompressing the
packs, so record strings are checked too — for emails, player GUIDs, account paths and
local filesystem paths, and exits non-zero on any hit.

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
- **Deterministic output.** Records are written sorted by entry, and gzip streams are
  written with `mtime=0`, so regenerating an unchanged store produces byte-identical
  files and git sees no diff.

See [docs/WDB-FORMAT.md](docs/WDB-FORMAT.md) for the binary format, including the parts
that are not documented elsewhere and cost real time to work out.

## License

MIT — see [LICENSE](LICENSE).

The *tool* is MIT. The cache data it processes is Project Ascension's game content,
submitted by players for preservation; it is not covered by this license.
