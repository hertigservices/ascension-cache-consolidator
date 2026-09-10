> Tool commands in this guide now run from the [canonical cache component](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator). Dataset paths remain in this data repository.

# The WDB cache format (client build 12340)

Everything here was verified empirically against real client caches, by requiring that
a candidate field layout consume **exactly** the payload length the file itself
declares. A layout that is wrong by one field consumes the wrong number of bytes, so
this is a proof rather than an impression. All figures below hold at 100% across the
corpus this tool was built on.

## File structure

```
+---------------------------+
| header, 24 bytes          |
+---------------------------+
| [entry u32][size u32]     |  record 1
| [payload ... size bytes]  |
+---------------------------+
| [entry u32][size u32]     |  record 2
| ...                       |
+---------------------------+
| 00 00 00 00 00 00 00 00   |  terminator (or exact EOF)
+---------------------------+
```

### Header (24 bytes)

| offset | size | field | note |
|---:|---:|---|---|
| 0 | 4 | magic | a **reversed** FourCC. `BDIW` on disk means `WIDB`. |
| 4 | 4 | build | `12340` for 3.3.5a |
| 8 | 4 | locale | also byte-reversed: `SUne` means `enUS` |
| 12 | 4 | recordSize | |
| 16 | 4 | recordVersion | |
| 20 | 4 | cacheVersion | |

The header length is not guessable from the fields alone; 24 was confirmed by checking
that the first record header lands at offset 24 and that walking record sizes reaches
the terminator exactly at EOF.

Magic values:

| on disk | means | file |
|---|---|---|
| `BDIW` | `WIDB` | itemcache.wdb |
| `BOGW` | `WGOB` | gameobjectcache.wdb |
| `BOMW` | `WMOB` | creaturecache.wdb |
| `CPNW` | `WNPC` | npccache.wdb |
| `TSQW` | `WQST` | questcache.wdb |
| `XTPW` | `WPTX` | pagetextcache.wdb |
| `XTIW` | `WITX` | itemtextcache.wdb |
| `BDNW` | `WNDB` | itemnamecache.wdb |
| `NDRW` | `WRDN` | wowcache.wdb |

### Records

`entry` lives in the **record header** and — for most cache types — is *not* repeated
in the payload. The payload begins at the first real field.

The exception is `questcache`, which repeats the quest id as `payload[0]`. Assuming
consistency here costs you four bytes of misalignment on every quest record.

A file ends either at an 8-byte zero record or exactly at EOF on a record boundary.
Both occur in the wild; treat either as clean and anything else as truncation.

### Files that are not this format

`itemstatcache.wdb` and `questcacheaddon.wdb` are written by **addons**, not the
client, despite the extension. They have no FourCC at all: their first four bytes are
a small little-endian integer that differs from file to file (`0x04`, `0x0b`, `0x1d07`,
…), and reading bytes 4–8 as `build` yields a large nonsense value.

Detect them by the absence of a known magic and skip them; a standard record walk over
one produces convincing nonsense rather than an error.

## Payload layouts

Each is the body of the corresponding `SMSG_*` server response.

### itemcache — `SMSG_ITEM_QUERY_SINGLE_RESPONSE`

Starts at `Class`. Notable gotcha: build 12340 has **one extra trailing `u32` after
`HolidayId`**. Without it every record is short by exactly 4 bytes — which looks like
a subtle field error and is not.

`StatsCount` is stored and governs how many `(stat_type, stat_value)` pairs follow.
Note that AzerothCore's `item_template` has **no `StatsCount` column** (it is derived),
so it must be dropped from any INSERT into that table.

### creaturecache — `SMSG_CREATURE_QUERY_RESPONSE`

```
4 x cstr Name, cstr SubName, cstr IconName,
u32 type_flags, type, family, rank,
u32 KillCredit1, KillCredit2,
u32 modelid1..4,
f32 HealthModifier, ManaModifier,
u8  RacialLeader,          <- one byte, not four
u32 questItems[6],
u32 movementId
```

No trailing padding. `modelid1..4` have no home in AzerothCore's `creature_template`;
they belong in `creature_template_model`.

This response is a thin slice: no faction, level, stats, loot or AI. Those never leave
the server, so no cache can contain them.

### gameobjectcache — `SMSG_GAMEOBJECT_QUERY_RESPONSE`

```
u32 type, displayId, 4 x cstr Name, cstr IconName, cstr castBarCaption, cstr unk1,
u32 Data[24], f32 size, u32 questItems[6]
```

Maps 1:1 onto `gameobject_template` including `Data0`–`Data23`.

### questcache — `SMSG_QUEST_QUERY_RESPONSE`

Repeats `QuestId` as `payload[0]`. 65 leading `u32` before `Title`. An 8-`u32`
`RequiredSourceItem` block sits between `RequiredNpcOrGo` and `RequiredItem`. Build
12340 has **no** Cata-era trailing fields.

### npccache — `SMSG_NPC_TEXT_UPDATE`

**Eight** blocks, each:

```
f32 Probability, cstr Text_0, cstr Text_1, u32 Language, u32 emote[6]
```

Reading only block 0 loses most of the content. `Probability0 == 0` occurs legitimately
and the client renders it by falling back to block 0 — do not "fix" it.

### pagetextcache — `SMSG_PAGE_TEXT_QUERY_RESPONSE`

```
cstr Text, u32 NextPageId
```

### itemnamecache — `SMSG_ITEM_NAME_QUERY_RESPONSE`

```
cstr Name, u32 InventoryType
```

## Strings are UTF-8

The client writes UTF-8. Decoding cache strings as latin1 is the single easiest way to
silently corrupt this data: every curly apostrophe and accent becomes mojibake, so
`Frostwalker’s Boots` is stored as `Frostwalkerâ€™s Boots`. Try UTF-8 first and fall
back to latin1 only for genuinely invalid bytes.

If you need to find such damage after the fact in MySQL, note that a `utf8mb4_unicode_ci`
column folds accents, so `LIKE '%â%'` matches a plain `a` and returns a flood of false
positives. Hex matching (`HEX(col) REGEXP 'C3A2'`) is also wrong, because it matches
across byte boundaries. Use a binary collation:

```sql
SELECT id FROM item_template WHERE name COLLATE utf8mb4_bin REGEXP '[âÃÂ]';
```

## Merging caches: what to watch for

- **Dedup on the inner file, never the archive.** The same cache arrives zipped, rar'd
  and tarred. Hash what is inside.
- **The best single snapshot is not the coverage ceiling.** Every cache is a partial
  view of what one player looked at. The real ceiling is the union: 42,616 items in the
  best submitted `itemcache` versus 76,017 across all of them.
- **A differing payload for the same entry is not corruption.** Values are retuned
  between patches and differ across game modes. Both readings were true when captured.
  Keep them with their mode and date, and resolve per mode rather than globally.
- **There is no per-record timestamp.** The file's mtime is the only capture signal,
  and it is an upper bound on the age of every record inside.
