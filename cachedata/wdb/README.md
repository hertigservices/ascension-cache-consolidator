# Merged client caches (.wdb)

One folder per game mode. Each file is the union of every record that mode
has produced across all submitted caches, in the client's own format.

## Using them

They are stored gzipped, because the largest is 254 MB uncompressed and
GitHub refuses any file over 100 MB. Unpack a mode straight into your own
cache folder with the tool in this repository:

```
python tools/unpack.py --mode <mode> --into "C:/.../WDB/enUS/<Your Realm> - <Mode>"
```

Or do it by hand — `gunzip` each file, then copy it into:

```
World of Warcraft\Cache\WDB\enUS\<Your Realm> - <Mode>\
```

The folder is named after **your** realm, so pick the folder matching the mode
and copy the `.wdb` files into your existing realm folder. Close the client
first — it rewrites these files on exit and will overwrite your changes.

A cache only ever helps the client skip a lookup it would otherwise ask the
server for. If a record here is stale relative to your realm, the client
corrects it the next time the server sends that entry.

## Contents

| mode | creaturecache | gameobjectcache | itemcache | itemnamecache | npccache | pagetextcache | questcache |
|---|---:|---:|---:|---:|---:|---:|---:|
| `coa-alpha` | 1,720 | 1,412 | 13,605 | — | 60 | 1 | 121 |
| `coa-beta` | 5,989 | 5,472 | 20,638 | 90 | 345 | 23 | 855 |
| `conquest-of-azeroth` | 17,745 | 12,667 | 433,106 | 2,970 | 2,164 | 500 | 18,550 |
| `free-pick` | 20,618 | 14,957 | 94,005 | 2,828 | 1,798 | 259 | 3,891 |
| `live-qa` | — | — | 398 | — | — | — | 210 |
| `season-10-freepick` | 12,716 | 9,120 | 548,931 | 648 | 572 | 28 | 18,552 |
| `season-10-wildcard` | 12,245 | 9,176 | 41,135 | 751 | 518 | 26 | 1,194 |
| `season-9` | 8,515 | 7,463 | 36,332 | 818 | 283 | 3 | 965 |
| `stress-test` | 2,214 | 1,750 | 12,101 | 109 | 68 | 4 | 253 |
| `unknown` | 2,989 | 2,039 | 65 | 19 | 176 | — | 445 |
| `warcraft-reborn` | 7,049 | 5,911 | 56,645 | 1,293 | 289 | 15 | 1,070 |

Counts are entries, not file sizes; the files on disk are `.wdb.gz`.

`unknown` is not a game mode. It is what arrived with no realm folder and
could not be identified from its contents -- creature, gameobject and NPC
records look the same in every mode, which is precisely why they cannot
name one. Those are safe to use anywhere; its quest text may not be.

`itemtextcache` is deliberately never published: it holds the text of mail
and letters the player read, which is other people's writing, not game data.

