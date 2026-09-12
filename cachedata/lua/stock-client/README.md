# `lua/stock-client/` — the caches as Lua tables for a stock 3.3.5a client

An addon on a stock client cannot read a `.wdb` cache, but it can load Lua files
named in its `.toc`. These files hold the same records the caches hold, as plain
Lua 5.1 tables under one global, `AscensionStockData`. Load `init.lua` first; every other
file only assigns into the tables it creates, so their order does not matter.

Source: hertigservices/ascension-data (cachedata). Mode `conquest-of-azeroth` first, `union/` for every entry that mode
never saw. Data captured through 2026-09-10. Regenerated on every publish by
`tools/export_stock_client.py` in the Ascension_preservation repository.

## Tables

| table | rows | from `conquest-of-azeroth` | from `union` | files | row layout |
|---|---:|---:|---:|---:|---|
| `AscensionStockData.items` | 553,742 | 432,822 | 120,920 | 132 | `{ name, quality, icon, displayId, class, subclass, inventoryType, itemLevel, requiredLevel }` |
| `AscensionStockData.creatures` | 23,983 | 17,697 | 6,286 | 3 | `{ name, subname, displayId }` |
| `AscensionStockData.quests` | 18,553 | 18,550 | 3 | 3 | `{ title }` |

Rows are positional to keep the files small; the order above is also in
`AscensionStockData.fields`. Numbers are integers, strings are UTF-8 as the server sent them,
and a field the record did not carry is `0` or `""`.

## Items: the icon and the display id

`icon` is the `InventoryIcon` name from **Ascension's** `ItemDisplayInfo.dbc` (that file
is renumbered, so a stock client resolves the same `displayId` to a different item's
icon). Use `"Interface\\Icons\\" .. icon` for the texture. The lookup itself is
published as `dbc/item_display_icons.tsv.gz` (`displayid`, `icon`, `stock_displayid`;
the last is the stock 3.3.5a display id with byte-identical art, blank when none).

| items | count |
|---|---:|
| with an icon | 523,583 |
| display id not in Ascension's DBC | 430 |
| display id 0 in the record | 29,729 |

## Names that are not names

Nothing is filtered: a name is what the Ascension server sent. Its own stand-ins
are therefore in here too, and they are easy to spot because one string covers
many entries. Names shared by 100+ item entries:

| name | item entries |
|---|---:|
| `Z:DBCtoDB Generated Item` | 28,961 |
| `[MISSING ITEM NAME]` | 11,387 |
| `***Name Not Available***` | 2,282 |
| `Signet Ring of the Bronze Dragonflight` | 645 |
| `Duplicate Appearance` | 516 |
| `Satchel of Trade Goods` | 476 |
| `Fireball` | 377 |
| `duplicate appearance` | 340 |
| `Rangetest` | 200 |
| `unused` | 175 |
| `Conqueror's Worldbreaker Spaulders` | 172 |
| `Duplicate Appearance ` | 140 |
| `Valorous Siegebreaker Legplates` | 130 |
| `Valorous Siegebreaker Gauntlets` | 129 |
| `Conqueror's Aegis Shoulderplates` | 129 |

## Caveats on a stock client

- The icon file must exist in the client's MPQs. Ascension-only icons need Ascension's art patches.
- `displayId` draws the right model only with Ascension's `ItemDisplayInfo.dbc` in the client;
  use `stock_displayid` from the lookup where it is set, otherwise expect the wrong model.
- Spells referenced by items are not in these tables and have no `Spell.dbc` row on a stock client.
