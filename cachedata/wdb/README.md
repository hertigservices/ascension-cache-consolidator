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
| `coa-alpha` | 1,359 | 1,400 | — | — | 54 | 1 | 119 |
| `coa-beta` | 5,122 | 4,653 | 16,239 | 67 | 308 | 22 | 720 |
| `conquest-of-azeroth` | 17,067 | 12,458 | 79,501 | 2,732 | 1,650 | 302 | 3,288 |
| `free-pick` | 6,642 | 5,516 | 36,598 | 759 | 310 | 17 | 958 |
| `live-qa` | — | — | 398 | — | — | — | 210 |
| `season-10-freepick` | 12,154 | 8,720 | 548,846 | 640 | 477 | 28 | 18,552 |
| `season-10-wildcard` | 8,140 | 6,709 | 30,399 | 345 | 476 | 17 | 1,039 |
| `season-9` | 8,484 | 7,448 | 36,327 | 818 | 283 | 3 | 962 |
| `stress-test` | 1,674 | 1,122 | 10,125 | 100 | 34 | 2 | 177 |
| `unknown` | 2,989 | 2,039 | 65 | 19 | 176 | — | 445 |
| `warcraft-reborn` | 5,126 | 3,851 | 47,032 | 824 | 223 | 15 | 688 |

Counts are entries, not file sizes; the files on disk are `.wdb.gz`.

`unknown` is not a game mode. It is what arrived with no realm folder and
could not be identified from its contents -- creature, gameobject and NPC
records look the same in every mode, which is precisely why they cannot
name one. Those are safe to use anywhere; its quest text may not be.

`itemtextcache` is deliberately never published: it holds the text of mail
and letters the player read, which is other people's writing, not game data.

