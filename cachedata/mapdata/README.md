# Map data inventory

What terrain exists, not the terrain itself.

`maps.tsv` has one row per map id found in a submitted server
data tree -- the output of a core's `mapextractor` /
`vmap4extractor` / `mmaps_generator`. `dbc.tsv` lists the DBC set
that travelled with it, by record count, which is what
distinguishes an Ascension DBC from a stock one without needing a
reference copy of either.

**The payload is not published here.** Terrain is derived data: a
server operator regenerates it from their own client with their
own core's extractors. What is worth preserving is the list of
what was found, so a map id can be cited, matched and asked after.

## What is in this one

| | |
|---|---:|
| map ids with terrain | 289 |
| named by a `Map.dbc` we can see | 288 |
| unnamed | 1 |
| above the stock 3.3.5a range (> 724) | 177 |
| terrain tiles | 11063 |
| DBC files inventoried | 245 |

An unnamed id means terrain exists for a map no `Map.dbc` in the
archive defines. That is a real finding rather than an error: the
tiles are evidence the map existed.

Names were resolved from 2 `Map.dbc` copies.

## Files that call themselves a DBC and are not

Listed rather than dropped: a truncated upload and a deliberately
empty placeholder look the same from here, and both are worth knowing.

- `CharVariations.dbc` — 0 bytes, no `WDBC` header
