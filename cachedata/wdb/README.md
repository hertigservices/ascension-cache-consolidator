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
| `coa-beta` | 3,392 | 3,120 | 13,385 | 39 | 221 | 11 | 556 |
| `conquest-of-azeroth` | 16,361 | 11,983 | 72,924 | 2,055 | 1,362 | 148 | 3,001 |
| `free-pick` | 2,876 | 2,982 | 22,949 | 256 | 144 | 7 | 413 |
| `live-qa` | — | — | 398 | — | — | — | 210 |
| `season-10-freepick` | 11,820 | 8,506 | 548,843 | 631 | 375 | 27 | 18,552 |
| `season-10-wildcard` | 4,166 | 3,041 | 19,344 | 158 | 200 | 7 | 456 |
| `season-9` | 5,098 | 4,981 | 19,638 | 449 | 212 | 3 | 406 |
| `stress-test` | 1,003 | 381 | 8,736 | 15 | 19 | 1 | 101 |
| `unknown` | 2,968 | 2,037 | — | 19 | 176 | — | 445 |
| `warcraft-reborn` | 2,755 | 2,297 | 37,211 | 663 | 119 | 9 | 279 |

Counts are entries, not file sizes; the files on disk are `.wdb.gz`.

`unknown` is not a game mode. It is what arrived with no realm folder and
could not be identified from its contents -- creature, gameobject and NPC
records look the same in every mode, which is precisely why they cannot
name one. Those are safe to use anywhere; its quest text may not be.

`itemtextcache` is deliberately never published: it holds the text of mail
and letters the player read, which is other people's writing, not game data.

