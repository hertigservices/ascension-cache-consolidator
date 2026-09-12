# CoA-Databank (Byte) supplemental set

Byte's [CoA-Databank](https://github.com/f3rr311/CoA-Databank) is the reference data gathered for a Conquest of
Azeroth rebuild. It is republished here **with the author's permission** (relayed 2026-09-12); the upstream
repository carries no licence file.

Two things were taken out on the way in:
- the **identities of the coabuildhub community**, meaning build authors, commenters, Discord user ids and avatars;
- the author's **local disk paths**.

Every other file is byte-identical to the upstream commit.

## Preserved snapshot

[Open the snapshot](166001399306e4fb022116fe1e3cfbbd7bd4bf37/). The folder is named after the upstream commit. Every
file keeps its upstream path, with `.gz` added unless it already ends in `.gz`.

| Folder | What it is |
|---|---|
| [`coabuildhub/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/coabuildhub/) | coabuildhub.com, scraped 2026-07-31: 21 classes, 3,612 talent nodes with position, essence costs, icon and description, 2,909 skills with db.ascension.gg tooltips, a 5,172-spell master index, 8 site guides, the icon sprite sheet, and the site's raw pages and script chunks |
| [`coabuildhub/builds/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/coabuildhub/builds/) | The 128 published community builds, as JSON plus a Markdown twin: title, guide text, tags, votes and decoded talent picks. **Authors and comments removed** |
| [`provenance/original-coa/palette/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/provenance/original-coa/palette/) | Indexes derived from the client's MPQs, captured 2026-07-29: 238,888 spells and their asset dependencies, 621,960 Ascension and 241,850 client asset paths, 178,795 loose extracted assets, 119,084 client and 117,638 donor DBC rows (id, name, source archive), and 5,269 creatures. `palette-manifest.json` hashes them as upstream |
| [`provenance/original-coa/local/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/provenance/original-coa/local/) | Harvest records: 1,960 spell captures, 3,018 icons, per-class captures, a class roster, completeness reports and legacy QA data |
| [`provenance/original-coa/web/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/provenance/original-coa/web/) | Eight ascension.gg changelog and news pages, as captured |
| [`provenance/ascension/inventory/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/provenance/ascension/inventory/) | Table counts, attribution counts, an unknown register and a transcript inventory from the rebuild's source snapshot |
| [`databank/`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/databank/) | The rebuild's archived manifest, 21-class/70-spec roster, native class map and curated Necromancer data. Its palette and inventory copies are the same blobs as `provenance/` and point at the same artifacts |
| [`manifest.json`](166001399306e4fb022116fe1e3cfbbd7bd4bf37/manifest.json) | Every published file's upstream blob id, hashes and transforms; every omitted file with its reason |

The 781 MB bulk extraction of models, textures and sounds was never in the upstream repository.
`databank/manifest.json` records its hash.

## What was changed

**Build identities.** Each build JSON:
- loses its author, its author id, its comments, and the author of every similar build it links;
- has those people's usernames replaced with `[user]` in its strings.

Each Markdown twin loses its `Author:` line and `Comments` section. Build `102d9cf7…` is titled
`[user] Invention Tinker Build`. In total, 128 authors, 243 comments and 372 similar-build authors were removed, and
52 usernames were replaced.

Two usernames are also ordinary words in the game text ("Will" occurs 1,999 times in the skill, talent and spell
text). Those two are replaced only in titles, so the guides keep the word "will".

**Local paths.** 13 distinct files, most of them the palette indexes and the harvest's source manifest, recorded where
things lay on the author's disk. Their drives became `<local>`: `<local>\CoA\dl\Patch-N-Loose\…`, 362,905 times in
all. A user folder name became `<user>` (10 times).

Nothing else was edited. `manifest.json` records, per file, which transform ran and how many times.

## What was left out

Each file is named in `manifest.json` with its reason:
- **130 raw build pages** (`coabuildhub/raw/builds/` and two sample captures). Their markup embeds the same usernames,
  Discord ids and comments. The stripped builds carry the same builds.
- **15 scripts:** the author's scrapers and harvest code, which several of them embed local paths in. Read them
  upstream.
- **`.gitignore`.**

## Read this before using the data

- **Talent trees largely duplicate the Exiles mirror.** 3,598 of the 3,611 talent spell ids here are already in
  `supplemental/exiles-db`. The other 13 are new, e.g. 300607 "Titanfall" (Templar, Crusader). What coabuildhub adds
  per node is its essence costs and description text.
- **The palette is derived from client archives** that the public client package already carries. Its unique content
  is the dependency graph: which assets each spell reaches.
- **Tooltips here are the site's rendering** of db.ascension.gg data, not captured client records. Captured data stays
  authoritative.

The importer, tests and guide live in the
[Ascension preservation repository](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator):
`tools/import_coa_databank.py`, `tools/test_coa_databank.py` and
[`docs/COA-DATABANK.md`](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/COA-DATABANK.md).
To verify, run from that component:

```
python -B tools/import_coa_databank.py verify <this repository>/supplemental/coa-databank/166001399306e4fb022116fe1e3cfbbd7bd4bf37
python -B tools/import_coa_databank.py verify <that folder> --checkout <a clone of f3rr311/CoA-Databank>
```

The second form re-derives every published file from the upstream commit. It proves each change is exactly the
recorded transform. This set has not been applied to a live realm.
