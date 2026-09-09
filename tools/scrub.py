"""Publish policy and PII scrubbing for submitted cache material.

Submitters send whole folders, and those folders contain far more than game data.
A `WTF` tree is literally organised as  WTF/Account/<login email>/<Realm - Mode>/
<CharacterName>/  and carries chat logs, macros and combat logs.  None of that
belongs in a public dataset, and a rename or a force-push does not un-publish it.

So the policy here is an ALLOW-LIST, not a block-list: a file is published only if
its kind is known to be game content.  Anything unrecognised is quarantined for a
human to look at, because the failure mode of guessing wrong is permanent.

    PUBLISH    server-sent game content; no player data by construction
    SCRUB      game content that carries incidental player data; redact, then publish
    QUARANTINE player-specific by nature, or unknown -- never auto-published
"""
import os, re

PUBLISH, SCRUB, QUARANTINE = "publish", "scrub", "quarantine"

# Client query caches: the server's answer to "what is entry N", identical for every
# player on that realm. itemtextcache is the exception -- it holds the text of MAIL
# and letters, which is other people's writing.
WDB_PUBLISH = {"itemcache", "creaturecache", "gameobjectcache", "questcache",
               "npccache", "pagetextcache", "itemnamecache"}
WDB_QUARANTINE = {"itemtextcache", "wowcache"}

# Addon saved-variables that are game knowledge rather than player state.
LUA_SCRUB = {
    "mobspells.lua":   "mob ability observations",
    "aio_client.lua":  "server-pushed addon code",
}

EMAIL     = re.compile(r"[\w.+-]+@[\w-]+\.[\w.-]+")
GUID      = re.compile(r"0x[0-9A-Fa-f]{16}")
# WTF/Account/<something>/  -- the <something> is a login identifier
WTF_ACCT  = re.compile(r"(WTF[\\/]Account[\\/])([^\\/]+)", re.I)


def classify(path):
    """(policy, reason) for one submitted file, from its path and name."""
    p = path.replace("\\", "/")
    low = os.path.basename(p).lower()

    if "/wtf/" in p.lower() or p.lower().startswith("wtf/"):
        return QUARANTINE, ("WTF config tree: keyed by account login and character "
                            "name, and carries chat, macros and combat logs")
    if low.endswith(".wdb"):
        stem = low[:-4]
        if stem in WDB_PUBLISH:
            return PUBLISH, "client query cache: server-sent game content"
        if stem in WDB_QUARANTINE:
            if stem == "itemtextcache":
                return QUARANTINE, "holds the text of mail and letters the player read"
            return QUARANTINE, "undocumented client cache; contents unverified"
        return QUARANTINE, f"unrecognised .wdb ({stem})"
    if low.endswith(".lua"):
        if low in LUA_SCRUB:
            return SCRUB, LUA_SCRUB[low]
        return QUARANTINE, "addon saved variables: may hold character state"
    if low.endswith(".json") or low.endswith(".loc"):
        return PUBLISH, "client content data shipped by the server"
    if low.endswith((".txt", ".wtf", ".md5")):
        return QUARANTINE, "client-local config or log"
    return QUARANTINE, "unrecognised file type"


def scrub_text(text):
    """Redact incidental player data. Returns (text, findings) where findings counts
    each kind removed, so a run can be reported rather than silently trusted."""
    findings = {}

    def sub(pattern, repl, name, s):
        s2, n = pattern.subn(repl, s)
        if n:
            findings[name] = findings.get(name, 0) + n
        return s2

    text = sub(EMAIL, "<redacted-email>", "email", text)
    text = sub(GUID, "<redacted-guid>", "guid", text)
    text = sub(WTF_ACCT, r"\1<redacted-account>", "account-path", text)
    return text, findings


def scrub_path(path):
    """Redact a path used as provenance (account folder -> placeholder)."""
    p = WTF_ACCT.sub(r"\1<redacted-account>", path)
    return EMAIL.sub("<redacted-email>", p)


if __name__ == "__main__":
    import sys
    for a in sys.argv[1:]:
        pol, why = classify(a)
        print(f"{pol:<11} {a}\n            {why}")
