# -*- coding: utf-8 -*-
"""Import the consolidated cache data into an AzerothCore world database.

    python -B tools/import_world.py --ask-password                 # preview only
    python -B tools/import_world.py --ask-password --apply         # write it
    python -B tools/import_world.py --source conquest-of-azeroth --ask-password

This is the server half of "using the data". The client half is install.py, which
puts the same records into the game client's Cache/WDB folder so tooltips and
names render. That is enough for the client to DISPLAY an item or creature, but
the server still has to KNOW about it before it can hand one out, spawn one, or
answer a query for one. This tool teaches it: the recovered item, creature,
gameobject, quest, page-text and npc-text records go into the matching
*_template tables of a (typically fresh, stock) AzerothCore world database.

WHAT IT MERGES, AND FROM WHERE
------------------------------
cachedata/union/*.tsv.gz by default: every record ever contributed, across every
Ascension game mode. Pass --source <mode> to use cachedata/by-mode/<mode>/
instead, which is what you want when the realm is meant to mirror ONE mode
(the same item id carries different stats on different modes; the union holds
the most recently seen one). --list-sources prints what is available.

THE TWO PASSES, AND WHY THE SECOND ONE EXISTS
---------------------------------------------
  1. ADD.  Rows the database does not have are inserted, guarded by WHERE NOT
     EXISTS, so re-running is a no-op.
  2. FILL. Rows the database already has keep every value they have, EXCEPT
     where a column still sits on its schema default; those get the cached
     value. Nothing a database actually holds is ever overwritten, so the merge
     is idempotent and safe to re-run. Cells where both sides hold a real and
     different value are counted in the preview for a human to judge.

On a fresh AzerothCore database pass 2 mostly touches columns that stock left
at 0 and Ascension set (a quest MinLevel, an item's third stat). If you would
rather stock content stayed byte-for-byte stock, pass --add-only and the merge
only inserts rows the database does not have. On a database populated by an
earlier, narrower importer pass 2 is the pass that matters.

THE SILENT-CLAMP HAZARD
-----------------------
AzerothCore's recommended MySQL setup runs non-strict (NO_ENGINE_SUBSTITUTION).
An out-of-range integer is silently clamped and an over-long string silently
truncated, with no error. Every value is range-checked here before it is
written: a u32 that overflows a signed column is retried as two's complement
(gameobject Data1 = 4294967295 is -1, not 4.29 billion), and anything still out
of range is dropped and listed in the report rather than written as a clamped
lie. The generated SQL also switches the session to STRICT_ALL_TABLES so that if
the check ever misses one, MySQL stops instead of lying.

WHAT THE CLIENT CACHE CANNOT TELL US
------------------------------------
A query response is a thin slice. A new creature arrives with name, subname,
models, type, family and rank -- no faction, no level range, no stats, no loot,
no AI, no spawn point. Those columns land on their schema defaults, so a newly
added creature is a level-1, faction-0 shell that looks right and does nothing.
Items are the exception: the item query carries almost the whole template, so
recovered items are fully usable (.additem works, tooltips are complete).
Quests carry their text and rewards but no quest-giver; gameobjects carry their
template but no placement. The gaps are visible rather than invented.

VerifiedBuild is set to 12340 on every inserted row. Recent AzerothCore builds
skip item_template rows whose VerifiedBuild is NULL, so a NULL would insert a
row the worldserver then ignores -- present in the database, absent from the
game, the worst of both.

NOTHING TAKES EFFECT UNTIL THE WORLDSERVER RESTARTS. Templates are cached at
world load. This tool does not restart anything.

CREDENTIALS
-----------
Never on the command line (they end up in shell history and process lists).
Either --ask-password (prompts, writes a private temp defaults-file for the
duration of the run) or --defaults-file PATH to a MySQL option file you keep
yourself:
    [client]
    user=acore
    password=acore
    host=127.0.0.1
    port=3306
"""
import argparse
import csv
import getpass
import glob
import gzip
import os
import re
import shutil
import stat
import subprocess
import sys
import tempfile
import time

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_DATA = os.path.normpath(os.path.join(HERE, "..", "cachedata"))
STAGE_PREFIX = "_cachemerge_"
BUILD = 12340
TABLES = ["gameobject_template", "gameobject_questitem", "creature_template",
          "creature_template_model", "page_text", "npc_text", "item_template",
          "quest_template"]

# ---------------------------------------------------------------- mysql client
def find_exe(name, explicit=None):
    if explicit:
        if os.path.exists(explicit):
            return explicit
        sys.exit("!! %s not found" % explicit)
    p = shutil.which(name)
    if p:
        return p
    pats = [r"C:\Program Files\MySQL\MySQL Server *\bin\%s.exe" % name,
            r"C:\Program Files\MariaDB *\bin\%s.exe" % name,
            r"C:\xampp\mysql\bin\%s.exe" % name,
            "/usr/bin/%s" % name, "/usr/local/bin/%s" % name,
            "/opt/homebrew/bin/%s" % name, "/usr/local/mysql/bin/%s" % name]
    for pat in pats:
        hits = sorted(glob.glob(pat))
        if hits:
            return hits[-1]
    sys.exit("!! %s is not on PATH and was not found in the usual places; pass --%s PATH"
             % (name, name))


class Db(object):
    """A thin wrapper over the mysql command-line client. No driver to install."""

    def __init__(self, mysql, dump, cnf, db):
        self.mysql, self.dump, self.cnf, self.db = mysql, dump, cnf, db

    def base(self, exe):
        return [exe, "--defaults-file=" + self.cnf]

    def q(self, sql, db=True):
        cmd = self.base(self.mysql) + ([self.db] if db else []) + ["-B", "-N", "-e", sql]
        r = subprocess.run(cmd, capture_output=True, encoding="utf-8", errors="replace")
        if r.returncode:
            sys.exit("!! mysql: " + (r.stderr or "").strip()[:600])
        return (r.stdout or "").splitlines()

    def run_file(self, path, label):
        t0 = time.time()
        print("\n== %s  (%s, %.1f MB)" % (label, os.path.basename(path),
                                          os.path.getsize(path) / 1048576.0), flush=True)
        with open(path, "rb") as f:
            r = subprocess.run(self.base(self.mysql) + [self.db, "--table", "--show-warnings"],
                               stdin=f, capture_output=True)
        out = r.stdout.decode("utf-8", "replace")
        err = r.stderr.decode("utf-8", "replace")
        print(out)
        if err.strip():
            print("stderr:\n" + err.strip()[:4000])
        print("-- %s in %.0fs (exit %d)" % (label, time.time() - t0, r.returncode))
        return r.returncode

    def backup(self, out_dir, tables):
        os.makedirs(out_dir, exist_ok=True)
        path = os.path.join(out_dir, "backup_%s_%s.sql"
                            % (self.db, time.strftime("%Y%m%d-%H%M%S")))
        print("== backing up %d tables of %s -> %s" % (len(tables), self.db, path), flush=True)
        t0 = time.time()
        with open(path, "wb") as f:
            r = subprocess.run(self.base(self.dump) + ["--single-transaction", "--no-tablespaces",
                                                       "--default-character-set=utf8mb4",
                                                       self.db] + tables,
                               stdout=f, stderr=subprocess.PIPE)
        if r.returncode:
            sys.exit("!! mysqldump failed: " + r.stderr.decode("utf-8", "replace")[:600])
        print("   %.0f MB in %.0fs" % (os.path.getsize(path) / 1048576.0, time.time() - t0))
        return path


def temp_cnf(host, port, user, password):
    """A defaults-file readable only by us, so the password never hits argv."""
    fd, path = tempfile.mkstemp(prefix="import_world_", suffix=".cnf")
    with os.fdopen(fd, "w", encoding="utf-8") as f:
        f.write("[client]\nuser=%s\npassword=%s\nhost=%s\nport=%d\n"
                "default-character-set=utf8mb4\n" % (user, password, host, port))
    try:
        os.chmod(path, stat.S_IRUSR | stat.S_IWUSR)
    except OSError:
        pass
    return path


# ---------------------------------------------------------------- column typing
INT_RANGE = {"tinyint": (-128, 127), "smallint": (-32768, 32767),
             "mediumint": (-8388608, 8388607), "int": (-2147483648, 2147483647),
             "bigint": (-2**63, 2**63 - 1)}
INT_URANGE = {"tinyint": (0, 255), "smallint": (0, 65535),
              "mediumint": (0, 16777215), "int": (0, 4294967295),
              "bigint": (0, 2**64 - 1)}


class Col(object):
    """One live column: enough about its type to write a value that survives."""

    def __init__(self, name, typ, default, nullable, collation=None):
        self.name = name
        self.raw = typ
        # The staging table must carry the live column's COLLATION, not the server
        # default: AzerothCore is utf8mb4_unicode_ci and MySQL 8 defaults new tables
        # to utf8mb4_0900_ai_ci, and the two cannot be compared ("Illegal mix of
        # collations" stops the merge dead).
        self.collation = collation if collation and collation != "NULL" else None
        self.default = default
        self.nullable = (nullable == "YES")
        base = re.sub(r"\(.*?\)", "", typ).strip().lower()
        self.unsigned = "unsigned" in base
        base = base.replace("unsigned", "").replace("zerofill", "").strip()
        self.base = base
        m = re.search(r"\((\d+)", typ)
        self.width = int(m.group(1)) if m else None
        self.is_int = base in INT_RANGE
        self.is_float = base in ("float", "double", "decimal", "numeric")
        self.is_text = base in ("char", "varchar", "text", "tinytext",
                                "mediumtext", "longtext", "enum")
        if self.is_int:
            self.lo, self.hi = (INT_URANGE if self.unsigned else INT_RANGE)[base]
        else:
            self.lo = self.hi = None

    def default_test(self, alias):
        """SQL that is true when this column is untouched -- still at its default."""
        t = "`%s`.`%s`" % (alias, self.name)
        d = self.default
        if d is None or d == "NULL":
            return "(%s IS NULL%s)" % (t, " OR %s = ''" % t if self.is_text else "")
        if self.is_text:
            return "(%s IS NULL OR %s = '' OR %s = %s)" % (t, t, t, sql_str(d))
        return "(%s IS NULL OR %s = %s)" % (t, t, d)


def coldef(col):
    return "`%s` %s%s" % (col.name, col.raw,
                          " COLLATE " + col.collation if col.collation else "")


# ---------------------------------------------------------------- value fitting
def sql_str(s):
    return "'" + s.replace("\\", "\\\\").replace("'", "''") + "'"


def fit(raw, col):
    """(sql_literal, None) if the value fits the column, or (None, reason) if not.
    Never returns a clamped or truncated value."""
    raw = "" if raw is None else raw.strip()
    if col.is_text:
        if col.base in ("char", "varchar") and col.width and len(raw) > col.width:
            return None, "would truncate %d chars into %s(%d)" % (len(raw), col.base, col.width)
        return sql_str(raw), None
    if raw == "":
        return ("NULL" if col.nullable else "0"), None
    if col.is_float:
        try:
            return repr(float(raw)), None
        except ValueError:
            return None, "not a number: %r" % raw[:32]
    try:
        v = int(raw)
    except ValueError:
        try:
            v = int(round(float(raw)))
        except ValueError:
            return None, "not a number: %r" % raw[:32]
    if col.is_int and not (col.lo <= v <= col.hi):
        # The decoders read most fields as u32 because that is how the wire carries
        # them. A signed column holding 4294967295 wants -1, not a clamp to 2^31-1.
        for bits in (32, 16, 8):
            if (1 << (bits - 1)) <= v < (1 << bits):
                w = v - (1 << bits)
                if col.lo <= w <= col.hi:
                    return str(w), None
        return None, "out of range for %s (%d not in %d..%d)" % (col.raw, v, col.lo, col.hi)
    return str(v), None


# ---------------------------------------------------------------- column maps
QUEST_MAP = {
    "entry": "ID", "Method": "QuestType", "QuestLevel": "QuestLevel",
    "MinLevel": "MinLevel", "ZoneOrSort": "QuestSortID", "Type": "QuestInfoID",
    "SuggestedPlayers": "SuggestedGroupNum",
    "RepObjectiveFaction": "RequiredFactionId1",
    "RepObjectiveValue": "RequiredFactionValue1",
    "RepObjectiveFaction2": "RequiredFactionId2",
    "RepObjectiveValue2": "RequiredFactionValue2",
    "NextQuestInChain": "RewardNextQuest", "RewXPId": "RewardXPDifficulty",
    "RewOrReqMoney": "RewardMoney", "RewMoneyMaxLevel": "RewardMoneyDifficulty",
    "RewSpell": "RewardDisplaySpell", "RewSpellCast": "RewardSpell",
    "RewHonor": "RewardHonor", "RewHonorMultiplier": "RewardKillHonor",
    "SrcItemId": "StartItem", "Flags": "Flags", "RewTitleId": "RewardTitle",
    "RequiredPlayerKills": "RequiredPlayerKills", "RewTalents": "RewardTalents",
    "RewArenaPoints": "RewardArenaPoints",
    "PointMapId": "POIContinent", "PointX": "POIx", "PointY": "POIy",
    "PointOpt": "POIPriority",
    "Title": "LogTitle", "Objectives": "LogDescription",
    "Details": "QuestDescription", "EndText": "AreaDescription",
    "CompletedText": "QuestCompletionLog",
}
for _i in range(1, 5):
    QUEST_MAP["RequiredSourceItemId%d" % _i] = "ItemDrop%d" % _i
    QUEST_MAP["RequiredSourceItemCount%d" % _i] = "ItemDropQuantity%d" % _i
for _i in range(1, 6):
    QUEST_MAP["RewardFactionValueId%d" % _i] = "RewardFactionValue%d" % _i
    QUEST_MAP["RewardFactionValueIdOverride%d" % _i] = "RewardFactionOverride%d" % _i
for _i in range(1, 7):
    QUEST_MAP["RewardChoiceItemCount%d" % _i] = "RewardChoiceItemQuantity%d" % _i
# Everything not named above maps onto the identically-named column (matched
# case-insensitively): RewardItem/RewardAmount, RequiredNpcOrGo, RequiredItem,
# ObjectiveText, RewardFactionId, RewardChoiceItemId. This map was scored against
# the 10,404 stock quests of a live database, not written from memory: the
# worst-agreeing pair reproduces the stock row on 97% of them.

# Columns that exist on both sides but must NOT be merged, and the reason.
EXCLUDE = {
    ("creature_template", "movementId"):
        "Ascension sends 999 on ~90% of creatures -- its own sentinel, not an "
        "AzerothCore movementId (which indexes creature_movement_override). "
        "Merging it would point thousands of creatures at a profile that does not exist.",
}

# Numbered columns the cache carries on the parent record but AzerothCore keeps
# in a side table. They are not "dropped": emit_side_table() writes them.
REROUTED = {("creature_template", "modelid"): "creature_template_model",
            ("gameobject_template", "questItem"): "gameobject_questitem"}

# (tsv file, table, column map, key column)
JOB_SPECS = [
    ("gameobjectcache.tsv.gz", "gameobject_template", None, "entry"),
    ("creaturecache.tsv.gz", "creature_template", None, "entry"),
    ("pagetextcache.tsv.gz", "page_text", {"entry": "ID", "NextPageId": "NextPageID"}, "ID"),
    ("npccache.tsv.gz", "npc_text", {"entry": "ID"}, "ID"),
    ("itemcache.tsv.gz", "item_template", None, "entry"),
    ("questcache.tsv.gz", "quest_template", QUEST_MAP, "ID"),
]


class Job(object):
    def __init__(self, db, src_dir, gz, table, colmap, key):
        self.gz, self.table, self.key = gz, table, key
        self.path = os.path.join(src_dir, gz)
        self.cols = describe(db, table)
        if not self.cols:
            sys.exit("!! table %s does not exist in %s -- is this an AzerothCore world DB?"
                     % (table, db.db))
        with gzip.open(self.path, "rt", encoding="utf-8", newline="") as f:
            head = f.readline().rstrip("\n").split("\t")
        self.all_cols = head
        self.src_cols = [c for c in head if not c.startswith("_")]
        raw = colmap or {}
        self.map = {}
        self.dropped = []
        for s in self.src_cols:
            d = raw.get(s, s)
            c = self.cols.get(d.lower())
            if c is None:
                side = REROUTED.get((table, re.sub(r"\d+$", "", s)))
                self.dropped.append((s, "goes to %s instead" % side if side
                                     else "no such column on %s" % table))
                continue
            if (table, c.name) in EXCLUDE:
                self.dropped.append((s, EXCLUDE[(table, c.name)]))
                continue
            self.map[s] = c
        self.livekey = self.cols[key.lower()].name
        self.srckey = self.src_cols[0]

    @property
    def stage(self):
        return STAGE_PREFIX + self.table

    def rows(self):
        with gzip.open(self.path, "rt", encoding="utf-8", newline="") as f:
            r = csv.reader(f, delimiter="\t")
            head = next(r)
            idx = {c: i for i, c in enumerate(head)}
            keep = [(s, idx[s]) for s in self.src_cols if s in self.map]
            ki = idx[self.srckey]
            for row in r:
                if len(row) < len(head):
                    row = row + [""] * (len(head) - len(row))
                yield row[ki], [(s, row[i]) for s, i in keep]

    def raw_rows(self, wanted):
        """(key, {col: value}) for a handful of columns, unmapped."""
        with gzip.open(self.path, "rt", encoding="utf-8", newline="") as f:
            r = csv.reader(f, delimiter="\t")
            head = next(r)
            idx = {c: i for i, c in enumerate(head)}
            ki = idx[self.srckey]
            take = [(c, idx[c]) for c in wanted if c in idx]
            for row in r:
                if len(row) < len(head):
                    row = row + [""] * (len(head) - len(row))
                yield row[ki], {c: row[i] for c, i in take}


def describe(db, table):
    out = {}
    for line in db.q("SHOW FULL COLUMNS FROM `%s`" % table):
        p = line.split("\t")
        if len(p) >= 7:
            out[p[0].lower()] = Col(p[0], p[1], p[5], p[3], p[2])
    return out


# ---------------------------------------------------------------- emit
def hr(f, title, *lines):
    f.write("\n-- ============================================================\n")
    f.write("-- %s\n" % title)
    for l in lines:
        f.write("-- %s\n" % l)
    f.write("-- ============================================================\n")


def emit_job(w, wa, job, notes, add_only=False):
    live = [job.map[s].name for s in job.src_cols if s in job.map]
    if job.livekey not in live:
        sys.exit("!! %s: key column %s is not in the map" % (job.table, job.livekey))
    defs = ",\n  ".join(coldef(job.map[s]) for s in job.src_cols if s in job.map)
    for f in (w, wa):
        hr(f, "%s  <-  %s   (%d of %d cached columns land here)"
           % (job.table, job.gz, len(live), len(job.src_cols)),
           *["  dropped %-28s %s" % (s, why[:90]) for s, why in job.dropped])
    w.write("DROP TABLE IF EXISTS `%s`;\n" % job.stage)
    w.write("CREATE TABLE `%s` (\n  %s,\n  PRIMARY KEY (`%s`)\n) ENGINE=InnoDB "
            "DEFAULT CHARSET=utf8mb4;\n\n" % (job.stage, defs, job.livekey))

    bt = "`" + "`,`".join(live) + "`"
    batch, n, skipped = [], 0, 0
    per = 200 if len(live) > 60 else 800
    for key, cells in job.rows():
        vals = []
        for s, raw in cells:
            col = job.map[s]
            lit, why = fit(raw, col)
            if lit is None:
                notes.append((job.table, key, col.name, raw[:40], why))
                skipped += 1
                if col.is_text:
                    lit = "''"
                elif col.default not in (None, "NULL"):
                    lit = col.default
                else:
                    lit = "NULL" if col.nullable else "0"
            vals.append(lit)
        batch.append("(" + ",".join(vals) + ")")
        n += 1
        if len(batch) >= per:
            w.write("INSERT INTO `%s` (%s) VALUES\n%s;\n" % (job.stage, bt, ",\n".join(batch)))
            batch = []
    if batch:
        w.write("INSERT INTO `%s` (%s) VALUES\n%s;\n" % (job.stage, bt, ",\n".join(batch)))
    w.write("\n-- staged %d rows (%d individual values could not be written safely "
            "and were left at the column default -- see report.md)\n" % (n, skipped))

    # ---- pass 1: add ----------------------------------------------------------
    has_vb = "verifiedbuild" in job.cols
    ins = live + (["VerifiedBuild"] if has_vb else [])
    sel = ",".join("s.`%s`" % c for c in live) + (",%d" % BUILD if has_vb else "")
    w.write("\nSELECT '%s' AS tbl, 'rows to ADD' AS step, COUNT(*) AS n FROM `%s` s\n"
            "  WHERE NOT EXISTS (SELECT 1 FROM `%s` t WHERE t.`%s` = s.`%s`);\n"
            % (job.table, job.stage, job.table, job.livekey, job.livekey))
    wa.write("-- pass 1: rows the database has never seen.\n")
    wa.write("INSERT INTO `%s` (`%s`)\n  SELECT %s FROM `%s` s\n"
             "  WHERE NOT EXISTS (SELECT 1 FROM `%s` t WHERE t.`%s` = s.`%s`);\n"
             % (job.table, "`,`".join(ins), sel, job.stage, job.table, job.livekey, job.livekey))

    # ---- pass 2: fill ---------------------------------------------------------
    fillable = [job.map[s] for s in job.src_cols if s in job.map and job.map[s].name != job.livekey]
    w.write("\n-- pass 2 preview. Two counts per column, computed in one pass over the join\n"
            "-- and then listed only where non-zero:\n"
            "--   fill      cells still on their schema default that would receive a\n"
            "--             different cached value (these ARE written by apply.sql%s)\n"
            "--   conflict  cells where BOTH sides hold a real value and disagree (the\n"
            "--             merge never writes these; they are for a human to judge)\n"
            % ("" if not add_only else " -- but --add-only was given, so NOT this run"))
    sums = []
    for c in fillable:
        sums.append("SUM(%s AND NOT (t.`%s` <=> s.`%s`)) AS `f_%s`"
                    % (c.default_test("t"), c.name, c.name, c.name))
        sums.append("SUM(NOT %s AND NOT (t.`%s` <=> s.`%s`)) AS `c_%s`"
                    % (c.default_test("t"), c.name, c.name, c.name))
    # A real (one-row) table, not TEMPORARY: MySQL cannot open a temporary table
    # twice in one statement, and the unpivot below reads it once per column.
    w.write("DROP TABLE IF EXISTS `%s_sums`;\n" % job.stage)
    w.write("CREATE TABLE `%s_sums` AS\nSELECT %s\n  FROM `%s` t JOIN `%s` s ON s.`%s` = t.`%s`;\n"
            % (job.stage, ",\n       ".join(sums), job.table, job.stage, job.livekey, job.livekey))
    branches = ["SELECT '%s' AS col, `f_%s` AS fill, `c_%s` AS conflict FROM `%s_sums`"
                % (c.name, c.name, c.name, job.stage) for c in fillable]
    w.write("SELECT '%s' AS tbl, col, fill, conflict FROM (\n  %s\n) u WHERE fill > 0 OR conflict > 0;\n"
            % (job.table, "\n  UNION ALL ".join(branches)))
    w.write("DROP TABLE `%s_sums`;\n" % job.stage)
    if add_only:
        wa.write("\n-- pass 2 (FILL) omitted: --add-only\n")
    else:
        wa.write("\n-- pass 2: columns still on their schema default get the cached value.\n"
                 "-- Anything the database has actually set is left alone.\n")
        wa.write("UPDATE `%s` t JOIN `%s` s ON s.`%s` = t.`%s`\n   SET %s;\n"
                 % (job.table, job.stage, job.livekey, job.livekey,
                    ",\n       ".join("t.`%s` = IF(%s, s.`%s`, t.`%s`)"
                                      % (c.name, c.default_test("t"), c.name, c.name) for c in fillable)))
    if has_vb:
        wa.write("UPDATE `%s` t JOIN `%s` s ON s.`%s` = t.`%s`\n"
                 "   SET t.`VerifiedBuild` = %d WHERE t.`VerifiedBuild` IS NULL;\n"
                 % (job.table, job.stage, job.livekey, job.livekey, BUILD))
    return n


def emit_side_table(w, wa, job, fields, stage, target, tcols, title, note):
    """Child rows that the cache carries as numbered columns on the parent record
    but AzerothCore keeps in a side table: creature models, gameobject quest items.
    `fields` are the cached column names in Idx order; `tcols` the target's
    (parent-key, idx, value) column names."""
    for f in (w, wa):
        hr(f, title, note, "Idx is 0-based.")
    pk, ik, vk = tcols
    w.write("DROP TABLE IF EXISTS `%s`;\n" % stage)
    w.write("CREATE TABLE `%s` (`entry` INT UNSIGNED NOT NULL, %s, PRIMARY KEY(`entry`)) ENGINE=InnoDB;\n"
            % (stage, ",".join("`v%d` INT UNSIGNED" % i for i in range(len(fields)))))
    batch = []
    for key, d in job.raw_rows(fields):
        vals = [key]
        for fld in fields:
            v = (d.get(fld) or "0").strip() or "0"
            try:
                vals.append(str(int(float(v))))
            except ValueError:
                vals.append("0")
        batch.append("(" + ",".join(vals) + ")")
    cols = "`entry`," + ",".join("`v%d`" % i for i in range(len(fields)))
    for i in range(0, len(batch), 800):
        w.write("INSERT INTO `%s` (%s) VALUES\n%s;\n" % (stage, cols, ",\n".join(batch[i:i + 800])))
    idxs = " UNION ALL ".join("SELECT %d AS idx" % i for i in range(len(fields)))
    case = " ".join("WHEN %d THEN s.v%d" % (i, i) for i in range(len(fields)))
    w.write("SELECT '%s' AS tbl, 'rows to ADD' AS step, COUNT(*) AS n\n"
            "  FROM `%s` s JOIN (%s) x\n"
            "  WHERE (CASE x.idx %s END) <> 0\n"
            "    AND NOT EXISTS (SELECT 1 FROM `%s` t WHERE t.`%s` = s.entry AND t.`%s` = x.idx);\n"
            % (target, stage, idxs, case, target, pk, ik))
    extra_cols, extra_vals = "", ""
    if target == "creature_template_model":
        extra_cols, extra_vals = ",`DisplayScale`,`Probability`", ",1,1"
    for i in range(len(fields)):
        wa.write("INSERT INTO `%s` (`%s`,`%s`,`%s`%s,`VerifiedBuild`)\n"
                 "  SELECT s.`entry`,%d,s.`v%d`%s,%d FROM `%s` s\n"
                 "  WHERE s.`v%d` <> 0 AND NOT EXISTS (SELECT 1 FROM `%s` t "
                 "WHERE t.`%s` = s.`entry` AND t.`%s` = %d);\n"
                 % (target, pk, ik, vk, extra_cols, i, i, extra_vals, BUILD, stage, i, target, pk, ik, i))
    return stage


HEAD_STAGE = """\
-- Stage the consolidated cache data next to the world database, and COUNT what
-- a merge would do. Generated by tools/import_world.py.
--
-- THIS FILE WRITES TO NO LIVE TABLE. It creates `_cachemerge_*` staging tables
-- and runs SELECTs against them. Re-running it is safe and rebuilds the
-- staging from scratch.
"""

HEAD_APPLY = """\
-- Merge the staged cache data into the world database. Generated by
-- tools/import_world.py -- run stage.sql FIRST; this file reads the
-- `_cachemerge_*` tables it leaves behind.
--
-- Two passes per table: ADD rows the database has never seen, then FILL columns
-- still on their schema default. Nothing the database has actually set is ever
-- overwritten, so this file is idempotent and safe to re-run.
--
-- Templates are cached at world load: nothing here takes effect until the
-- worldserver is restarted.
"""

PREAMBLE = """\
SET NAMES utf8mb4;
SET SESSION sql_notes = 0;  -- DROP TABLE IF EXISTS on a missing table is a Note, not news
SET SESSION sql_mode = 'STRICT_ALL_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- ^ AzerothCore's recommended MySQL setup is non-strict, which silently clamps
--   out-of-range integers and truncates over-long strings. Every value below was
--   range-checked in python, so strict mode should change nothing; it is here so
--   that if the check ever misses one, the merge stops instead of writing a lie.

"""


def generate(db, src_dir, out_dir, set_cache_version, add_only=False):
    os.makedirs(out_dir, exist_ok=True)
    p_stage = os.path.join(out_dir, "stage.sql")
    p_apply = os.path.join(out_dir, "apply.sql")
    p_report = os.path.join(out_dir, "report.md")
    notes, staged, stages = [], {}, []
    jobs = []
    for gz, table, colmap, key in JOB_SPECS:
        if not os.path.exists(os.path.join(src_dir, gz)):
            print("   (no %s in %s -- skipping %s)" % (gz, src_dir, table))
            continue
        jobs.append(Job(db, src_dir, gz, table, colmap, key))

    with open(p_stage, "w", encoding="utf-8", newline="\n") as w, \
            open(p_apply, "w", encoding="utf-8", newline="\n") as wa:
        w.write(HEAD_STAGE + "\n" + PREAMBLE)
        wa.write(HEAD_APPLY + "\n" + PREAMBLE)
        for job in jobs:
            staged[job.table] = emit_job(w, wa, job, notes, add_only)
            stages.append(job.stage)
            if job.table == "creature_template" and describe(db, "creature_template_model"):
                stages.append(emit_side_table(
                    w, wa, job, ["modelid%d" % i for i in range(1, 5)],
                    STAGE_PREFIX + "models", "creature_template_model",
                    ("CreatureID", "Idx", "CreatureDisplayID"),
                    "creature_template_model  <-  creaturecache modelid1..4",
                    "a creature row with no model is an invisible NPC, so the display "
                    "ids the cache carries go in alongside it (scale/probability 1)."))
            if job.table == "gameobject_template" and describe(db, "gameobject_questitem"):
                stages.append(emit_side_table(
                    w, wa, job, ["questItem%d" % i for i in range(1, 7)],
                    STAGE_PREFIX + "questitems", "gameobject_questitem",
                    ("GameObjectEntry", "Idx", "ItemId"),
                    "gameobject_questitem  <-  gameobjectcache questItem1..6",
                    "the quest items a gameobject sparkles for; AzerothCore keeps them "
                    "in a side table instead of six columns."))

        # ---- cache version ----------------------------------------------------
        if set_cache_version is not None:
            for f in (w, wa):
                hr(f, "client cache version",
                   "the client keeps its Cache\\WDB files only while this number matches",
                   "the one in their headers; install.py prints what the files carry.")
            w.write("SELECT 'version' AS tbl, 'cache_id now' AS step, cache_id AS n FROM `version`;\n")
            wa.write("UPDATE `version` SET `cache_id` = %d;\n" % set_cache_version)

        # ---- verification -----------------------------------------------------
        for f in (w, wa):
            hr(f, "verification")
            for t in TABLES:
                if describe(db, t):
                    f.write("SELECT '%s' AS tbl, 'rows now' AS step, COUNT(*) AS n FROM `%s`;\n" % (t, t))
            if "verifiedbuild" in describe(db, "item_template"):
                f.write("SELECT 'item_template' AS tbl, 'rows the worldserver will skip "
                        "(VerifiedBuild NULL)' AS step, COUNT(*) AS n FROM item_template "
                        "WHERE VerifiedBuild IS NULL;\n")
        hr(wa, "staging cleanup (import_world.py drops these unless --keep-staging)")
        for s in stages:
            wa.write("-- DROP TABLE IF EXISTS `%s`;\n" % s)

    with open(p_report, "w", encoding="utf-8", newline="\n") as r:
        r.write("# Cache import: what was staged, and what was refused\n\n")
        r.write("Generated by `tools/import_world.py` from `%s` for database `%s`,\n"
                "alongside `stage.sql` (builds staging tables and counts -- writes to no\n"
                "live table) and `apply.sql` (the part that writes).\n\n" % (src_dir, db.db))
        r.write("## Rows staged per table\n\n")
        for t, n in staged.items():
            r.write("- `%s` %s rows\n" % (t, "{:,}".format(n)))
        r.write("\n## Columns dropped from the merge\n\n")
        for job in jobs:
            if not job.dropped:
                continue
            r.write("### %s\n\n" % job.table)
            for s, why in job.dropped:
                r.write("- **%s** -- %s\n" % (s, why))
            r.write("\n")
        r.write("## Individual values that could not be written safely\n\n")
        if not notes:
            r.write("None. Every staged value fits its column.\n")
        else:
            r.write("A non-strict MySQL would have accepted each of these silently --\n"
                    "clamped to the column maximum or truncated to its width. They were\n"
                    "left at the column default instead.\n\n")
            kinds = {}
            for t, k, c, v, why in notes:
                kinds.setdefault((t, c, re.sub(r"\d+", "N", why).strip()), []).append(k)
            r.write("### Summary\n\n| table | column | reason | affected | example keys |\n|---|---|---|---|---|\n")
            for (t, c, kind), ks in sorted(kinds.items(), key=lambda x: -len(x[1])):
                r.write("| %s | %s | %s | %d | %s |\n" % (t, c, kind, len(ks), ", ".join(ks[:6])))
            r.write("\n### Every refused value\n\n| table | key | column | value | why |\n|---|---|---|---|---|\n")
            for t, k, c, v, why in notes[:400]:
                r.write("| %s | %s | %s | `%s` | %s |\n" % (t, k, c, v.replace("|", "\\|"), why))
            if len(notes) > 400:
                r.write("\n...and %d more.\n" % (len(notes) - 400))

    for p in (p_stage, p_apply, p_report):
        print("wrote %s  (%.1f MB)" % (p, os.path.getsize(p) / 1048576.0))
    for t, n in staged.items():
        print("   %-26s %9s rows staged" % (t, "{:,}".format(n)))
    if notes:
        print("   %d value(s) refused as unsafe to write -- see report.md" % len(notes))
    return p_stage, p_apply, stages


# ---------------------------------------------------------------- main
def list_sources(data):
    out = []
    if os.path.exists(os.path.join(data, "union", "itemcache.tsv.gz")):
        out.append("union")
    bm = os.path.join(data, "by-mode")
    if os.path.isdir(bm):
        out += sorted(d for d in os.listdir(bm) if os.path.isdir(os.path.join(bm, d)))
    return out


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter,
                                 epilog=__doc__[__doc__.index("WHAT IT MERGES"):])
    ap.add_argument("--data", default=DEFAULT_DATA, help="cachedata/ folder (default: next to tools/)")
    ap.add_argument("--source", default="union",
                    help="'union' (default) or a game-mode name from cachedata/by-mode/")
    ap.add_argument("--list-sources", action="store_true")
    ap.add_argument("--db", default="acore_world", help="world database name (default acore_world)")
    ap.add_argument("--host", default="127.0.0.1")
    ap.add_argument("--port", type=int, default=3306)
    ap.add_argument("--user", default="acore")
    ap.add_argument("--ask-password", action="store_true", help="prompt for the MySQL password")
    ap.add_argument("--defaults-file", help="MySQL option file with [client] user/password/host/port")
    ap.add_argument("--mysql", help="path to the mysql client (default: PATH, then the usual install dirs)")
    ap.add_argument("--mysqldump", help="path to mysqldump (for the backup)")
    ap.add_argument("--out", help="folder for stage.sql / apply.sql / report.md / backup (default: import-out/ next to cachedata)")
    ap.add_argument("--apply", action="store_true", help="actually write; default is a preview")
    ap.add_argument("--add-only", action="store_true",
                    help="only ADD rows the database lacks; never FILL default-valued "
                         "columns of rows it already has (keeps stock content untouched)")
    ap.add_argument("--no-backup", action="store_true", help="skip the mysqldump before --apply")
    ap.add_argument("--keep-staging", action="store_true", help="leave the _cachemerge_* tables behind")
    ap.add_argument("--set-cache-version", type=int, metavar="N",
                    help="also set version.cache_id (what the server tells clients) to N")
    a = ap.parse_args(argv)

    data = os.path.abspath(a.data)
    if a.list_sources:
        for s in list_sources(data):
            print(s)
        return 0
    src_dir = os.path.join(data, "union") if a.source == "union" else os.path.join(data, "by-mode", a.source)
    if not os.path.exists(os.path.join(src_dir, "itemcache.tsv.gz")):
        sys.exit("!! no data at %s (try --list-sources, or --data PATH)" % src_dir)
    out_dir = a.out or os.path.join(os.path.dirname(data), "import-out")

    mysql = find_exe("mysql", a.mysql)
    dump = find_exe("mysqldump", a.mysqldump) if a.apply and not a.no_backup else None
    tmp = None
    if a.defaults_file:
        cnf = os.path.abspath(a.defaults_file)
        if not os.path.exists(cnf):
            sys.exit("!! %s not found" % cnf)
    elif a.ask_password:
        pw = getpass.getpass("MySQL password for %s@%s:%d: " % (a.user, a.host, a.port))
        cnf = tmp = temp_cnf(a.host, a.port, a.user, pw)
    else:
        sys.exit("!! pass --ask-password or --defaults-file PATH (never a password on the command line)")

    try:
        db = Db(mysql, dump, cnf, a.db)
        ver = db.q("SELECT VERSION(), @@sql_mode", db=False)
        print("server   %s" % ver[0].replace("\t", "   sql_mode=") if ver else "?")
        dbs = db.q("SHOW DATABASES LIKE %s" % sql_str(a.db), db=False)
        if not dbs:
            sys.exit("!! database %s does not exist on %s:%d" % (a.db, a.host, a.port))
        cache_id = db.q("SELECT cache_id FROM `version`")
        print("database %s   version.cache_id = %s" % (a.db, cache_id[0] if cache_id else "?"))
        print("source   %s" % src_dir)
        print("output   %s" % out_dir)

        stage, apply_, stages = generate(db, src_dir, out_dir, a.set_cache_version, a.add_only)
        stages = stages + [s + "_sums" for s in stages]
        try:
            if db.run_file(stage, "stage + preview"):
                sys.exit("!! staging failed; nothing was written to a live table")
            if not a.apply:
                print("\nPreview only. Nothing has been written to %s." % a.db)
                print("Re-run with --apply once the counts above look right.")
                return 0
            if not a.no_backup:
                db.backup(out_dir, [t for t in TABLES if describe(db, t)] + ["version"])
            if db.run_file(apply_, "APPLY"):
                sys.exit("!! apply failed -- restore from the backup in %s if needed" % out_dir)
        finally:
            if not a.keep_staging:
                db.q(";".join("DROP TABLE IF EXISTS `%s`" % s for s in stages))
        cache_id = db.q("SELECT cache_id FROM `version`")
        print("\nMerged into %s. Nothing is visible in game until the worldserver restarts." % a.db)
        print("version.cache_id is %s: clients must carry the same number in their Cache\\WDB" % cache_id[0])
        print("headers (install.py --cache-version %s), or set ClientCacheVersion in worldserver.conf." % cache_id[0])
        return 0
    finally:
        if tmp and os.path.exists(tmp):
            os.remove(tmp)


if __name__ == "__main__":
    sys.exit(main())
