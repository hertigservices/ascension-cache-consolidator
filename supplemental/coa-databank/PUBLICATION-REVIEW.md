# Publication review

**Upstream:** `https://github.com/f3rr311/CoA-Databank`, commit `166001399306e4fb022116fe1e3cfbbd7bd4bf37`. It is the
only commit, authored 2026-09-12 by Byte.

**Permission:** the author gave permission to republish, relayed by James Hertig on 2026-09-12. The upstream repository
has no licence file, and none is asserted here.

## What was published

The commit holds 5,719 files. Of them:
- **5,304 are published byte-identical** to the upstream blob. The verifier recomputes each one's git blob id. Where
  the upstream file is already gzipped, the artifact is that blob itself.
- **269 are published transformed.** Each keeps its upstream blob id beside the transform counts, and
  `verify --checkout` re-derives it from the commit.
- **146 are omitted**, each with its reason.

21 published paths share an artifact with another path that holds the same blob (the `databank/` copies of the
palette and inventory). That leaves 5,552 artifacts, 53.9 MB.

## The transforms

**community-identities**, on all 256 build files (128 JSON plus their Markdown twins), removed:
- 128 author records: username, Discord avatar URL and site id;
- 243 comments, each with author and text;
- 372 similar-build author records;
- 128 `Author:` lines and 61 `Comments` sections.

52 username occurrences were then replaced with `[user]` in build strings. Afterwards, none of the 248 usernames
remains in a build file, except "Will" and "Crimson", which also occur 1,999 and 157 times in the skill, talent and
spell text. Those two are replaced in titles, and no title still holds either. Each build JSON is re-serialised with
the settings that reproduce its upstream bytes exactly: 1-space indent, raw UTF-8 and the upstream line endings.

**local-paths**, on 13 files:
- 362,905 drives became `<local>`, e.g. `<local>\CoA\dl\Patch-N-Loose\New folder\character\draenei\male\draeneimaleskin.blp`;
- 10 user folder names became `<user>`.

The rule requires a separator and a path character after the drive. The first build used a looser rule, which also
rewrote the FAQ label `A:` in eight ascension.gg pages; that was caught by inspection and fixed. Those pages are now
published byte-identical.

## What was left out, and why

- **130 raw build pages** (`coabuildhub/raw/builds/*.html`, `raw/sample-build.html`, `raw/sample-build-flight.txt`).
  Their markup embeds the build authors' and commenters' usernames, Discord user ids and comments. The stripped build
  files carry the same builds.
- **15 scripts:** the author's scrapers and harvest code. Several embed the author's local paths; read them upstream.
- **`.gitignore`.**

## Screens

- **The importer's screen** runs on every published text, after the transforms. It found no address other than the
  two allowed exactly: `support@ascension.gg`, the public support mailbox in the schema.org block of the eight
  ascension.gg pages, and `techbot@gnome.mail`, game text on a GM ban spell in the palette's spell index. It found
  nothing shaped like a player GUID, account path or drive path, no Discord avatar or user URL, no `"username":`
  field, and no person-record key (`author_id`, `avatar_url`, escaped or not). Binary files (3,018 JPEG icons and one
  WebP sprite sheet) are published unchanged and unscreened.
- **A separate scan of all 2,298 published text files outside the builds** looked for traces of the builds' people.
  - All 248 usernames, as written: 7 occur, every time as game text, e.g. a talent "… of the Serpent", a creature
    "…'s Self Replicating Abomination", or "the Plains of …". None names a person.
  - No `author=` query string, and no "build by" prose.
  - 17 escaped `username` fields, all UI labels in the ascension.gg pages ("Username", "Nome de Usuário").
  - 20 `author` objects, all site authorship: schema.org "CoA Build Hub" and "Ascension", and the label
    "Article Author".
- **The repository's own publication audit** (`audit_publish.py`) scanned all 5,554 files of the snapshot, decompressed,
  and reported CLEAN. It gained one allowance for this set: `support@ascension.gg`, as that exact string.

## Comparison with captured data

- **Talent spells:** 3,598 of the 3,611 in coabuildhub's trees are already in `supplemental/exiles-db`'s talent
  trees. The 13 others are new, e.g. 300607 "Titanfall" (Templar, Crusader).
- **Palette indexes:** derived from client archives that the public client package already carries. Captured data
  and the package stay authoritative.

## Status

This is a supplemental preservation set. It was not applied to any realm. Tooltips and skill text are coabuildhub's
rendering of db.ascension.gg data, not captured client records.
