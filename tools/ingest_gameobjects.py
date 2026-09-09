"""Turn the submitted world dumps into a catalogue of objects that exist.

A *catalogue*, deliberately, and not a spawn table. The person who collected
these said what they are, and every limit below is theirs, not a guess:

  * only the FIRST sighting of each object was written down;
  * trees, chairs and other common props were filtered out while dumping;
  * some of the files are partial dumps, included on purpose;
  * it is a snapshot from around the Bronzebeard launch, so the newer zones
    (Pale Reach, the custom starting zones) are simply not in it.

So a row here means "this object exists, and here is one place it was seen".
It never means "this object is here, and only here", and a missing object is
no evidence of anything at all. Building a `gameobject` spawn table out of
this would produce a world that is mostly empty and confidently wrong.

What it is genuinely good for is the question it was collected to answer:
**which objects exist, and which of them are Ascension's own** rather than
stock 3.3.5a -- with one worked example position for each.

Two id spaces, kept apart
-------------------------
`dump_npc_*` files are creatures, not GameObjects. They arrived in the same
format and were not mentioned in the description at all. Creature entry 1622
and GameObject entry 1622 are unrelated things, so they are catalogued
separately and never merged.

This stage keeps no state. The dumps are files on disk and the catalogue is a
pure function of them, so re-running is a recompute, not a re-merge, and there
is no cache to go stale.
"""
import os, sys, io, csv, glob, gzip, json, collections

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import config

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

OUT_DIR = os.path.join(config.OUT, "catalogue").replace("\\", "/")

# Stock 3.3.5a GameObject entries live below this; Ascension's worldforged ones
# were given a fresh range above it. It is a rule of thumb for reporting, not a
# guarantee, so it is never used to include or exclude a row.
CUSTOM_FROM = 200000

# Field names as the dump files write them, mapped to ours.
FIELDS = {
    "id": "id",
    "name": "name",
    "type": "type",
    "displayid": "display_id",
    "map internal name": "zone",
    "mapx": "map_x",
    "mapy": "map_y",
    "internal map id": "map_id",
    "internal x": "x",
    "internal y": "y",
    "internal z": "z",
    "lockid": "lock_id",
    "locktype": "lock_type",
}


# --------------------------------------------------------------- finding them
def discover():
    """Every dump file we can see, with the submission it arrived in.

    A submission is the extract directory an archive was unpacked into, which
    is the closest thing to "one person sent this". Loose files dropped
    straight into the inbox are labelled by their own name instead.
    """
    seen, found = set(), []
    roots = [config.EXTRACT] + list(config.SCAN_ROOTS)
    for root in roots:
        if not os.path.isdir(root):
            continue
        for dp, dirs, files in os.walk(root):
            dirs[:] = [d for d in dirs if not d.startswith(".")]
            for fn in files:
                low = fn.lower()
                if not low.startswith("dump_"):
                    continue
                if not (low.endswith(".txt") or low.endswith(".csv")):
                    continue
                p = os.path.abspath(os.path.join(dp, fn))
                key = os.path.normcase(p)
                if key in seen:
                    continue
                seen.add(key)
                found.append((p, submission_of(p, root)))
    return sorted(found)


def submission_of(path, root):
    """Which upload a dump file arrived in."""
    rel = os.path.relpath(path, root).replace("\\", "/")
    head = rel.split("/")[0]
    return head if "/" in rel else "loose:" + head


def kind_of(path):
    """`gameobject` or `creature`, from the filename.

    The npc dumps are the same format and the same tooling, and nothing inside
    a record says which id space it belongs to. The filename is the only
    signal there is, so it is taken literally.
    """
    return ("creature" if os.path.basename(path).lower().startswith("dump_npc_")
            else "gameobject")


def zone_of(path):
    """The zone name from the filename, left exactly as written.

    Deliberately not spell-corrected. `Aszhara` and `Azshara` are two different
    zones in these dumps -- different internal map names, and not one id in
    common -- so "fixing" the apparent typo would silently merge two places.
    `UnGoroCrater` and `UngoroCrater` differ only in case, which NTFS treats as
    the same name; they survive only because they landed in separate extract
    directories, so nothing here may lowercase a zone either.
    """
    stem = os.path.splitext(os.path.basename(path))[0]
    for pre in ("dump_npc_", "dump_"):
        if stem.lower().startswith(pre):
            return stem[len(pre):]
    return stem


# ------------------------------------------------------------------ parsing
def parse_csv(text):
    """The `.csv` files: semicolon-separated, with a COMMA decimal point.

    `"-9430,91015625"` is one number. Read as ordinary comma CSV every
    coordinate in the set is destroyed silently, which is why the delimiter is
    stated rather than sniffed. Four rows also carry doubled quotes inside a
    quoted field, so this uses a real CSV reader and not a split.
    """
    rows = list(csv.reader(io.StringIO(text), delimiter=";", quotechar='"'))
    if not rows:
        return []
    head = [FIELDS.get(h, FIELDS.get(h.replace(" ", ""), h))
            for h in (c.strip().lower() for c in rows[0])]
    out = []
    for r in rows[1:]:
        if not any(c.strip() for c in r):
            continue
        out.append({k: v.strip() for k, v in zip(head, r)})
    return out


def parse_lua_ish(text):
    """The `.txt` files, which are not JSON however much they look like it.

    One single line of `{id:95696,Name:"Riding Cloak",...}` records: unquoted
    keys, no trailing newline, and no enclosing array. Object names contain
    commas (`Standing, Exterior, Medium - Brewfest`), colons (`Wanted Poster:
    ...`) and in nine files a backslash-escaped quote, so this scans the string
    with the quoting rules in hand instead of splitting on any character.
    """
    out = []
    for body in _records(text):
        rec = {}
        for part in _split_top(body, ","):
            k, sep, v = _split_once(part, ":")
            if not sep:
                continue
            key = _unquote(k.strip()).strip().lower()
            rec[FIELDS.get(key, FIELDS.get(key.replace(" ", ""), key))] = \
                _unquote(v.strip())
        if rec:
            out.append(rec)
    return out


def _records(s):
    """Yield the body of each top-level `{...}`, quotes and escapes respected."""
    depth, start, in_str, esc = 0, None, False, False
    for i, c in enumerate(s):
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c == "{":
            if depth == 0:
                start = i + 1
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0 and start is not None:
                yield s[start:i]
                start = None
            elif depth < 0:            # a truncated partial dump; resynchronise
                depth = 0


def _split_top(s, sep):
    """Split on `sep`, ignoring any that sit inside a string or braces."""
    out, buf, depth, in_str, esc = [], [], 0, False, False
    for c in s:
        if in_str:
            buf.append(c)
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c in "{[":
            depth += 1
        elif c in "}]":
            depth -= 1
        elif c == sep and depth == 0:
            out.append("".join(buf)); buf = []
            continue
        buf.append(c)
    if buf:
        out.append("".join(buf))
    return out


def _split_once(s, sep):
    """Split at the first `sep` outside a string. Names contain colons."""
    in_str, esc = False, False
    for i, c in enumerate(s):
        if in_str:
            if esc:
                esc = False
            elif c == "\\":
                esc = True
            elif c == '"':
                in_str = False
            continue
        if c == '"':
            in_str = True
        elif c == sep:
            return s[:i], sep, s[i + 1:]
    return s, "", ""


def _unquote(v):
    """Strip one layer of quotes and undo the two escapes these files use."""
    v = v.strip()
    if len(v) >= 2 and v[0] == '"' and v[-1] == '"':
        v = v[1:-1]
        v = v.replace('\\"', '"').replace("\\\\", "\\")
    return v


def _num(v):
    """A coordinate, accepting either decimal separator. None if unreadable."""
    if v is None:
        return None
    v = str(v).strip().strip('"')
    if not v:
        return None
    try:
        return float(v.replace(",", "."))
    except ValueError:
        return None


def _int(v):
    n = _num(v)
    return int(n) if n is not None else None


# ------------------------------------------------------------------ judgement
def trusted_type(t, display_id):
    """The `Type` column, but only where it can be believed.

    `Door` is what the dumper wrote when it could not read an object's type:
    6,393 of the 6,395 `Door` rows have no `DisplayId` at all, while every row
    of every other type has one. `Grave Moss`, a herb node, is filed as a
    `Door`. Publishing that breakdown as though it were real would tell readers
    the world is four-fifths doors.

    So an untyped `Door` becomes blank -- unknown, stated as unknown. The two
    that do carry a DisplayId are kept, because those look like real doors.
    """
    t = (t or "").strip()
    if not t or (t == "Door" and not (display_id or "").strip()):
        return ""
    return t


def has_position(r):
    """Whether a sighting carries a usable position.

    28 records sit at exactly 0,0,0 with no real location -- `Bonfire Damage`,
    `RPG PROP TURLE SHELL`, `Xavian Waterfall`. The rows are still evidence the
    object exists, so they are catalogued; it is the coordinates that are
    dropped, not the object. Filter on the position, never on the row.
    """
    x, y, z = r.get("x"), r.get("y"), r.get("z")
    return None not in (x, y, z) and (x, y, z) != (0.0, 0.0, 0.0)


# ------------------------------------------------------------------ gathering
def sightings():
    """Read every dump file into a flat list of sightings, per id space."""
    per = {"gameobject": [], "creature": []}
    files, bad = 0, []
    for path, sub in discover():
        try:
            text = io.open(path, encoding="utf-8-sig", errors="replace").read()
        except OSError as e:
            bad.append((path, str(e)))
            continue
        rows = (parse_csv(text) if path.lower().endswith(".csv")
                else parse_lua_ish(text))
        zone_from_name, kind = zone_of(path), kind_of(path)
        n = 0
        for r in rows:
            gid = _int(r.get("id"))
            if gid is None:
                continue
            per[kind].append({
                "id": gid,
                "name": (r.get("name") or "").strip(),
                "type": trusted_type(r.get("type"), r.get("display_id")),
                "display_id": (r.get("display_id") or "").strip(),
                # The zone inside the record is the client's own internal map
                # name and is the one to trust; the filename is the fallback
                # for records that do not carry it.
                "zone": (r.get("zone") or "").strip() or zone_from_name,
                "map_id": _int(r.get("map_id")),
                "x": _num(r.get("x")), "y": _num(r.get("y")),
                "z": _num(r.get("z")),
                "map_x": _num(r.get("map_x")), "map_y": _num(r.get("map_y")),
                "lock_id": _int(r.get("lock_id")),
                "lock_type": (r.get("lock_type") or "").strip(),
                "submission": sub,
                "file": os.path.basename(path),
            })
            n += 1
        files += 1
        if not n:
            bad.append((path, "no records parsed"))
    return per, files, bad


def fold(rows):
    """One entry per id, keeping the best example rather than the first seen.

    "Best" is a sighting with real coordinates, chosen in a fixed order so the
    catalogue is identical whichever order the files were read in. Disagreeing
    names are all kept: where two dumps call an id different things that is
    worth seeing, not worth silently resolving.
    """
    by = collections.OrderedDict()
    for r in rows:
        e = by.get(r["id"])
        if e is None:
            e = by[r["id"]] = {
                "id": r["id"], "names": collections.Counter(),
                "types": collections.Counter(), "displays": collections.Counter(),
                "zones": set(), "submissions": set(), "files": set(),
                "sightings": 0, "best": None,
                "lock_id": None, "lock_type": "",
            }
        e["sightings"] += 1
        if r["name"]:
            e["names"][r["name"]] += 1
        if r["type"]:
            e["types"][r["type"]] += 1
        if r["display_id"]:
            e["displays"][r["display_id"]] += 1
        if r["zone"]:
            e["zones"].add(r["zone"])
        e["submissions"].add(r["submission"])
        e["files"].add(r["file"])
        if e["lock_id"] is None and r["lock_id"] is not None:
            e["lock_id"], e["lock_type"] = r["lock_id"], r["lock_type"]
        if has_position(r):
            key = (r["zone"], r["x"], r["y"], r["z"])
            if e["best"] is None or key < e["best"][0]:
                e["best"] = (key, r)
    return by


# ------------------------------------------------------------------- writing
COLS = ["id", "name", "type", "display_id", "sightings", "submissions",
        "zones", "example_zone", "example_map_id",
        "example_x", "example_y", "example_z", "example_map_x", "example_map_y",
        "lock_id", "lock_type", "other_names", "seen_in", "zone_list"]


def _cell(v):
    """A TSV cell that cannot break the row it is in."""
    if v is None:
        return ""
    s = str(v)
    return s.replace("\t", " ").replace("\r", " ").replace("\n", " ").strip()


def _coord(v):
    """Coordinates to 3 decimals: the dumps carry 11, which is false precision
    for a position that was only ever one sighting out of many."""
    return "" if v is None else f"{v:.3f}"


def write_tsv(path, folded):
    n = 0
    with io.open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\t".join(COLS) + "\n")
        for gid in sorted(folded):
            e = folded[gid]
            best = e["best"][1] if e["best"] else {}
            names = [nm for nm, _c in e["names"].most_common()]
            f.write("\t".join(_cell(v) for v in [
                gid,
                names[0] if names else "",
                e["types"].most_common(1)[0][0] if e["types"] else "",
                e["displays"].most_common(1)[0][0] if e["displays"] else "",
                e["sightings"], len(e["submissions"]), len(e["zones"]),
                best.get("zone", ""), best.get("map_id"),
                _coord(best.get("x")), _coord(best.get("y")),
                _coord(best.get("z")),
                _coord(best.get("map_x")), _coord(best.get("map_y")),
                e["lock_id"], e["lock_type"],
                " | ".join(names[1:]),
                " | ".join(sorted(e["submissions"])),
                " | ".join(sorted(e["zones"])),
            ]) + "\n")
            n += 1
    return n


def summarise(folded):
    s = {"ids": len(folded)}
    s["custom"] = sum(1 for g in folded if g >= CUSTOM_FROM)
    s["stock"] = s["ids"] - s["custom"]
    s["typed"] = sum(1 for e in folded.values() if e["types"])
    s["no_position"] = sum(1 for e in folded.values() if not e["best"])
    s["unnamed"] = sum(1 for e in folded.values() if not e["names"])
    s["name_conflicts"] = sum(1 for e in folded.values() if len(e["names"]) > 1)
    s["corroborated"] = sum(1 for e in folded.values() if len(e["submissions"]) > 1)
    s["zones"] = len({z for e in folded.values() for z in e["zones"]})
    s["types"] = collections.Counter()
    for e in folded.values():
        if e["types"]:
            s["types"][e["types"].most_common(1)[0][0]] += 1
    return s


def readme(go, cr, files):
    """Say what this is, and what it is not, before anybody builds on it."""
    L = ["# The world catalogue (`catalogue/`)\n",
         "Two lists of things that exist in the world: **objects** and",
         "**creatures**. They came from players walking the world with a dump",
         "addon running, not from the game's own cache files, so they are the",
         "one part of this dataset that is an observation rather than a",
         "recording.\n",
         "## Read this before you use it\n",
         "**This is a catalogue, not a spawn table.** The person who collected it",
         "said so plainly, and there are four separate reasons, each enough on",
         "its own:\n",
         "1. **Only the first sighting of each object was written down.** A row",
         "   means *this exists, and here is one place it was seen*. It never",
         "   means *this is here, and only here*.",
         "2. **Trees, chairs and other common props were filtered out** during",
         "   the dump. An object being absent proves nothing whatsoever.",
         "3. **Some of the dumps are partial**, and were included deliberately,",
         "   so coverage is uneven between them by design.",
         "4. **It is a snapshot from around the Bronzebeard launch**, about a",
         "   year before it was submitted. The newer zones -- Pale Reach, the",
         "   custom starting zones -- are not in it at all.\n",
         "If you load this into a `gameobject` table you will get a world that",
         "is mostly empty and confidently wrong. What it is genuinely good for",
         "is the question it was collected to answer: **which objects exist, and",
         "which of them are Ascension's own** rather than stock 3.3.5a.\n",
         "## The two files\n",
         f"| file | rows | what it lists |",
         "|---|---:|---|",
         f"| `gameobjects.tsv` | {go['ids']:,} | doors, chests, herb nodes, "
         "portals, props -- anything the client calls a GameObject |",
         f"| `creatures.tsv` | {cr['ids']:,} | NPCs, from the `dump_npc_*` "
         "files |\n",
         "**They are separate id spaces and must stay separate.** Creature 1622",
         "and GameObject 1622 are unrelated things. The creature dumps were not",
         "even mentioned in the submission -- they turned up inside it -- so",
         "they are catalogued on their own rather than folded in.\n",
         "## What the columns mean\n",
         "| column | meaning |",
         "|---|---|",
         "| `id` | the entry id the server uses |",
         "| `name` | the name most dumps agreed on |",
         "| `type` | object type, **blank where it could not be read** (see below) |",
         "| `display_id` | the model the client drew; blank if not recorded |",
         "| `sightings` | how many rows across all files mention this id |",
         "| `submissions` | how many separate uploads saw it -- 2 or more means "
         "two people independently found the same thing |",
         "| `zones` | how many distinct zones it was seen in |",
         "| `example_*` | **one** position it was seen at, not its only one |",
         "| `lock_id`, `lock_type` | for locked objects, where recorded |",
         "| `other_names` | every other name any dump gave this id |",
         "| `seen_in` | which uploads it came from |",
         "| `zone_list` | every zone it was seen in |\n",
         "## `type` is blank more often than you would expect\n",
         "That is on purpose. The dumper wrote `Door` when it could not read an",
         "object's type, and it could not read it most of the time: of the",
         "6,395 rows marked `Door`, 6,393 have no model id either, while every",
         "row of every other type has one. `Grave Moss` -- a herb -- is filed as",
         "a `Door`. Reporting that as a real breakdown would tell you the world",
         "is four-fifths doors.\n",
         "So an untyped `Door` is published as **blank, meaning unknown**. The",
         "types that remain are the ones the dump actually read:\n"]
    for t, n in go["types"].most_common():
        L.append(f"* `{t}` — {n:,}")
    L += ["",
          "Types and model ids exist only in the `.csv` dumps, so zones that",
          "were only ever dumped to `.txt` have neither.\n",
          "## Which of these are Ascension's own?\n",
          "Stock 3.3.5a GameObjects have ids below 200000 and Ascension's",
          f"worldforged ones were given a range above it, so **{go['custom']:,}",
          f"of the {go['ids']:,} objects look custom** and",
          f"{go['stock']:,} look like stock 3.3.5a. That is a rule of thumb for",
          "reading the list, not a guarantee, and nothing was included or left",
          "out on the strength of it.\n",
          "## Honest gaps\n",
          f"* **{go['no_position']:,} objects have no usable position.** Their",
          "  coordinates were recorded as exactly 0,0,0. The object is real and",
          "  stays listed; only its position is missing.",
          f"* **{go['unnamed']:,} objects have no name** in any dump.",
          f"* **{go['name_conflicts']:,} objects were given more than one name.**",
          "  All of them are kept, in `other_names`, rather than one being",
          "  quietly chosen and the rest dropped.",
          f"* **Only {go['corroborated']:,} objects were seen by more than one",
          "  upload.** The rest rest on a single contributor's dump.",
          f"* Zone names are printed exactly as the dumps wrote them. `Aszhara`",
          "  and `Azshara` are **two different zones** here, not a typo -- they",
          "  have different internal map names and not one id in common.\n",
          f"Built from {files} dump files across {go['zones']} zones.\n"]
    return "\n".join(L) + "\n"


def main():
    per, files, bad = sightings()
    if not files:
        print("no dump_*.txt / dump_*.csv files found; nothing to catalogue")
        return 0
    os.makedirs(OUT_DIR, exist_ok=True)
    go = fold(per["gameobject"])
    cr = fold(per["creature"])
    n_go = write_tsv(os.path.join(OUT_DIR, "gameobjects.tsv"), go)
    n_cr = write_tsv(os.path.join(OUT_DIR, "creatures.tsv"), cr)
    sgo, scr = summarise(go), summarise(cr)

    with io.open(os.path.join(OUT_DIR, "README.md"), "w",
                 encoding="utf-8", newline="\n") as f:
        f.write(readme(sgo, scr, files))

    print(f"  read {files} dump file(s): "
          f"{len(per['gameobject']):,} object sightings, "
          f"{len(per['creature']):,} creature sightings")
    print(f"  gameobjects.tsv  {n_go:,} objects   "
          f"({sgo['custom']:,} custom-range, {sgo['typed']:,} with a readable "
          f"type, {sgo['no_position']:,} with no position)")
    print(f"  creatures.tsv    {n_cr:,} creatures ({scr['no_position']:,} with "
          f"no position)")
    print(f"  across {sgo['zones']} zones; {sgo['corroborated']:,} objects "
          f"seen by more than one upload -> catalogue/README.md")
    for p, why in bad:
        print(f"  !! {os.path.basename(p)}: {why}")
    # A file we could not read is worth saying out loud, but it is not a reason
    # to stop the pipeline: the rest of the catalogue is still correct.
    return 0


if __name__ == "__main__":
    sys.exit(main())
