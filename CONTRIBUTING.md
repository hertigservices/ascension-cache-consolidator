# Sending in your cache data

Your WoW client writes down every answer the server gives it. What an item is,
what a quest asks for, what an NPC says when you talk to them — all of it lands
in files on your own disk so the client never has to ask twice.

Ascension is a live custom server. Those answers exist nowhere else. When a realm
changes or closes, the only surviving copy is the one sitting in players' cache
folders. That is what this project collects.

**You do not need to know anything technical to help.** Two ways to do it.

---

## The easy way: let the tool package it

`tools/contribute.py` reads your install, keeps the parts that are game data,
throws away the parts that are about you, and writes one zip you can send.

You need [Python](https://www.python.org/downloads/) — nothing else.

```
python tools/contribute.py --install "C:/Games/Ascension"
```

**It writes nothing on the first run.** It prints a list of what it found, what
it would send, and what it is leaving behind and why. Read that list. If it looks
right:

```
python tools/contribute.py --install "C:/Games/Ascension" --write
```

That produces something like `ascension-conquest-of-azeroth-20260909.zip`.

It is a plain zip. Open it before you send it — that is the point. Inside:

| | |
|---|---|
| `manifest.json` | what this is, which realm and mode, and a list of everything skipped with the reason |
| `new/<cache>.pack` | only the records this archive has never seen |
| `lua/<name>.lua` | the handful of addon files that hold game data, already scrubbed |

### Making the file much smaller (optional)

Almost everything in your cache is already here. If you download this repo's
`cachedata/raw/` folder and point the tool at it, it will only pack the records
that are genuinely new, and the bundle usually drops to a few megabytes:

```
python tools/contribute.py --install "C:/Games/Ascension" --index cachedata/raw --write
```

Without `--index` it packs everything, which still works — the file is just big.

---

## The manual way: zip it yourself

If you would rather not run a script, this is all we need.

**Send this folder, whole:**

```
<your Ascension folder>/Cache/WDB/
```

**First, delete these two files from every folder inside it:**

- `itemtextcache.wdb` — this is the text of **mail and letters people wrote to
  you**. It is not game data and it is never published.
- `wowcache.wdb` — we have not verified what is in this one, so it stays out
  until we have.

### The five addon files (optional, but the most valuable thing here)

There are **two** folders called `SavedVariables` and the difference is the whole
rule:

| folder | |
|---|---|
| `WTF/Account/<your login>/SavedVariables/` | **this one** — settings shared by all your characters |
| `WTF/Account/<your login>/<Realm - Mode>/<Character>/SavedVariables/` | not this one — one per character |

From the **first** folder only, send these five files and only these five:

`MobSpells.lua`, `AIO_Client.lua`, `Auctionator_Price_Database.lua`,
`GatherMate2.lua`, `CoASniff.lua`

You will not have all of them — nobody does. Send whichever exist. They hold
things no cache file can: what mobs actually cast and how hard they hit, the
addon code the server pushes to your client, auction prices, and where herb and
mine nodes are. `.bak` copies are fine too, sometimes better.

**Nothing else from `WTF/`, including the per-character folders.** That tree is
named after your login and your characters and holds your chat log, your macros,
your keybinds and your UI layout. The per-character `SavedVariables` is where
`Details.lua`, `DBM-Core.lua`, `PowerAuras.lua` and `AscensionUI.lua` live — that
is UI state, not game data, and it is not wanted.

---

## What happens to it

1. Your files are hashed. If someone already sent a byte-identical copy, yours is
   recorded as a second sighting rather than stored twice.
2. Records are merged into the public set. Where two people's clients disagree
   about the same entry, both readings are kept — nothing is silently overwritten.
3. Everything about to go public is scanned for email addresses, player GUIDs and
   account paths. **If that scan finds anything, nothing is published** until it
   is explained.
4. The result is republished here, in the original file formats, merged and
   deconflicted.

### Why we still want yours even if someone already sent theirs

The archive's only real defence against bad data is counting how many
**independent** people saw the same bytes. An item nine players' clients agree on
is a fact. An item one submission asserts alone is a claim.

That is also why `contribute.py` will not merge anything for you. If contributors
sent merged results, one sender would look exactly like a consensus, and the
distinction that makes this hard to poison would be gone. Your bundle only ever
describes what **your** client saw. Merging happens once, in one place, where the
count can be kept honest.

---

## What is never accepted

The rule here is an **allow-list**, not a block-list: a file travels only if its
kind is known to be game content. Anything unrecognised is left behind and listed
as skipped. That is deliberate — with a block-list, forgetting one entry leaks it.

Never accepted, never published, no exceptions:

- `itemtextcache.wdb` — other people's mail and letters
- `wowcache.wdb` — contents unverified
- anything else under `WTF/` — chat, macros, keybinds, combat logs, screenshots,
  the per-character `SavedVariables` folders, and a folder tree literally named
  after your login and your characters
- combat logs of any kind — they carry the names, GUIDs, classes, specs and
  talent builds of everyone you were grouped with, not just you
- any file whose kind the tool does not recognise

If you have already redacted something by hand, that is fine — send it as is.
A file with `{redacted}` where a name used to be is accepted, not rejected.

---

## Sending it

Post it in **`#cache-dump`** on the **Conquest of AzerothCore** Discord, with a
line saying what it is — which realm, which game mode, roughly when you captured
it. That is where these submissions are collected and where you will get an
answer fastest.

Not in that server, or the file is too big for Discord's upload limit? Open an
issue on this repository instead and attach the bundle. GitHub caps issue
attachments at 25 MB — if yours is over that, say so rather than splitting it up,
and you will be pointed somewhere to put it. Running the tool with `--index`
(above) is usually enough to get well under both limits.

Useful things to mention, if you know them:

- the realm and game mode the client was on (Conquest of Azeroth, Free-Pick,
  Wildcard, a season, a PTR or beta realm — the folder name under `Cache/WDB/enUS/`
  usually says)
- roughly when it was captured
- anything unusual about the install

None of that is required. An unlabelled submission still gets identified by
fingerprint against what is already here.
