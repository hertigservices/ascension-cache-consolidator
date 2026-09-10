# Exiles database icon assets

Images from the `db.exil.es` mirror that a stock 3.3.5a client cannot supply.
The parsed records that reference them are in the
[snapshot](../6bcecd0faa6c2e7084d8015e1d931431c30e3013a9122810d593868196a3578b/);
the full mirror, including the icons kept out of this directory, is in the
[`exiles-db-mirror-2026-08-29`](https://github.com/hertigservices/ascension-data/releases/tag/exiles-db-mirror-2026-08-29)
release.

| Directory | Files | Size | What |
| --- | ---: | ---: | --- |
| [`class-icons/`](class-icons/) | 21 | 0.4 MB | The CoA class icons — tinker, venomancer, witch doctor, sun cleric and the rest. |
| [`icons/`](icons/) | 16,733 | 126.1 MB | Spell and item icons the mirror served that a stock 3.3.5a client does not contain. |

Every file was copied only after its SHA-256 matched the entry in the snapshot's
`mirror.index.tsv.gz`, so each one is provably the byte-identical file the
crawler saved. Names are the site's own, lowercased by the mirror.

## How the selection was made

Stock icon names were read from the `(listfile)` of every MPQ in a stock 3.3.5a
client. **Icons live in the locale archives, not the base ones** — `common.MPQ`
and its siblings contain none at all. `locale-enUS.MPQ` holds 4,512,
`patch-enUS.MPQ` 1,498, `patch-enUS-2.MPQ` 260, `patch-enUS-3.MPQ` 65, and two
of the expansion locale archives a handful more: **6,308 distinct names**. The
enumeration was checked against six icons that must exist in any 3.3.5a client
before the result was used, because a listing that silently came back short
would have quietly classified custom art as stock and discarded it.

Of the 21,842 icons the mirror served, **5,109 (36.2 MB) matched a stock name
and are not republished here** — anyone with a client already has them. The
remaining **16,733 (126.1 MB) are in `icons/`**.

## What "not in a stock client" does and does not mean

It means exactly what it says: these files cannot be obtained from a 3.3.5a
installation. It does **not** mean they are original CoA artwork. The set mixes
at least three kinds of image, and nothing here distinguishes them:

- Art from later World of Warcraft expansions that Ascension imported —
  `2_inv_shield_1h_maldraxxus_b_01` is Shadowlands, `10ct_centaur_cookedmeat01`
  is Dragonflight.
- Ascension and CoA custom art, recognisable by leading tokens such as
  `custom_` (564), `asc_` (92), `nhi_` (600), `novart_` (155) and `uico_` (90).
- Recoloured or bordered variants of stock icons, such as the `_border` suffix
  used on talent cells.

Rights in these images are not asserted by this repository. Blizzard-derived art
remains Blizzard's; Ascension-derived art remains its authors'. They are kept
because the site that served them is gone and the records that reference them
are meaningless without the art they name.

## Completeness

The crawl recorded **39,858 failed asset fetches**, nearly all of them images.
The mirrored icon set is therefore incomplete, and an icon's absence from this
directory is not evidence that it does not exist — only that this crawl did not
capture it, or that a stock client already has it.

Creature portrait renders (2,780 files, 67.3 MB), dungeon floor maps (36 files,
69.7 MB) and the site's own chrome are in the mirror but not republished here;
take them from the release.
