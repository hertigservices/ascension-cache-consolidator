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
| `coa-beta` | 5,977 | 5,467 | 20,616 | 90 | 344 | 23 | 849 |
| `conquest-of-azeroth` | 17,411 | 12,576 | 84,717 | 2,819 | 1,950 | 376 | 3,748 |
| `free-pick` | 7,040 | 6,140 | 38,034 | 813 | 320 | 18 | 1,066 |
| `live-qa` | — | — | 398 | — | — | — | 210 |
| `season-10-freepick` | 12,196 | 8,757 | 548,849 | 640 | 496 | 28 | 18,552 |
| `season-10-wildcard` | 8,343 | 6,806 | 32,096 | 389 | 487 | 21 | 1,064 |
| `season-9` | 8,484 | 7,448 | 36,327 | 818 | 283 | 3 | 962 |
| `stress-test` | 2,103 | 1,688 | 11,464 | 100 | 56 | 3 | 212 |
| `unknown` | 2,989 | 2,039 | 65 | 19 | 176 | — | 445 |
| `warcraft-reborn` | 6,724 | 5,677 | 55,912 | 1,222 | 285 | 15 | 1,012 |

Counts are entries, not file sizes; the files on disk are `.wdb.gz`.

`unknown` is not a game mode. It is what arrived with no realm folder and
could not be identified from its contents -- creature, gameobject and NPC
records look the same in every mode, which is precisely why they cannot
name one. Those are safe to use anywhere; its quest text may not be.

`itemtextcache` is deliberately never published: it holds the text of mail
and letters the player read, which is other people's writing, not game data.

