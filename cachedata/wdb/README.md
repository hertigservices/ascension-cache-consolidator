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
| `coa-beta` | 3,406 | 3,121 | 13,931 | 39 | 225 | 11 | 558 |
| `conquest-of-azeroth` | 16,799 | 12,225 | 77,373 | 2,165 | 1,532 | 196 | 3,144 |
| `free-pick` | 5,722 | 5,193 | 30,533 | 370 | 268 | 7 | 821 |
| `live-qa` | — | — | 398 | — | — | — | 210 |
| `season-10-freepick` | 11,896 | 8,533 | 548,845 | 631 | 393 | 27 | 18,552 |
| `season-10-wildcard` | 4,993 | 3,424 | 24,002 | 243 | 248 | 8 | 567 |
| `season-9` | 5,169 | 5,009 | 19,848 | 459 | 213 | 3 | 478 |
| `stress-test` | 1,603 | 1,013 | 9,553 | 87 | 33 | 2 | 172 |
| `unknown` | 2,989 | 2,039 | 65 | 19 | 176 | — | 445 |
| `warcraft-reborn` | 3,402 | 2,648 | 39,189 | 750 | 147 | 9 | 443 |

Counts are entries, not file sizes; the files on disk are `.wdb.gz`.

`unknown` is not a game mode. It is what arrived with no realm folder and
could not be identified from its contents -- creature, gameobject and NPC
records look the same in every mode, which is precisely why they cannot
name one. Those are safe to use anywhere; its quest text may not be.

`itemtextcache` is deliberately never published: it holds the text of mail
and letters the player read, which is other people's writing, not game data.

