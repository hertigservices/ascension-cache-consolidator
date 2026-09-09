"""Shared WDB (3.3.5a client cache) parsing helpers.

Standard client query-caches (itemcache, creaturecache, gameobjectcache, npccache,
questcache, pagetextcache, itemtextcache, itemnamecache, wowcache) share a 24-byte
header (magic, build, locale, recordSize, recordVersion, cacheVersion) followed by
variable records:  [entry u32][payloadSize u32][payload...], terminated by an 8-byte
zero record or EOF.  (Header length verified empirically: entry 564818 lands at off 24
and its payload decodes to a real item; walking size-as-payload reaches the zero
terminator exactly at EOF.)

Two files in the wild use a DIFFERENT, addon-written header (itemstatcache,
questcacheaddon) — we detect and flag them rather than mis-parse.

Native python can't open /c/... paths on this box -> always pass C:/... style paths.
"""
import struct

# in-file first-4-bytes  ->  (cache name, human label)
MAGIC = {
    b"WIDB": ("itemcache",       "item definitions"),
    b"WGOB": ("gameobjectcache", "gameobject definitions"),
    b"WMOB": ("creaturecache",   "creature/mob definitions"),
    b"WNPC": ("npccache",        "npc gossip/vendor"),
    b"WQST": ("questcache",      "quest definitions"),
    b"WPTX": ("pagetextcache",   "page/book text"),
    b"WITX": ("itemtextcache",   "item text (letters)"),
    b"WNDB": ("itemnamecache",   "item names (search)"),
    b"WRDN": ("wowcache",        "misc client cache"),
}

HEADER_LEN = 24

def decode_str(s):
    """Decode a client cstr. The client writes UTF-8; decoding it as latin1 mangles
    every curly apostrophe and accent into mojibake ("Frostwalkerâ€™s Boots"), so
    utf-8 MUST be tried first, with latin1 only as a fallback for genuinely bad bytes."""
    try:
        return s.decode("utf-8")
    except UnicodeDecodeError:
        return s.decode("latin1", "replace")

class WdbInfo:
    __slots__ = ("path","magic","cache","label","build","locale","records",
                 "payload_bytes","standard","note","clean_end")
    def __init__(self, **kw):
        for k in self.__slots__: setattr(self, k, kw.get(k))

def read_header(b):
    """Return (raw_magic_bytes, build, locale) from the first 12 bytes.
    Magic is stored as a reversed FourCC; locale ('enUS') is also byte-reversed."""
    raw = b[0:4]
    magic = raw[::-1]                       # 'BDIW' on disk -> b'WIDB'
    build = struct.unpack_from("<I", b, 4)[0]
    locale = b[8:12][::-1].decode("latin1", "replace")
    return magic, build, locale

def iter_records(b, header_len=HEADER_LEN):
    """Yield (entry, size, payload) for a standard query-cache. `size` is the payload
    length. Stops cleanly at the zero terminator, at EOF, or on the first malformed
    length (returns what it read)."""
    n = len(b); off = header_len
    while off + 8 <= n:
        entry, size = struct.unpack_from("<II", b, off)
        if entry == 0 and size == 0:
            break
        if size > 5_000_000 or off + 8 + size > n:
            break
        yield entry, size, b[off+8:off+8+size]
        off += 8 + size

def inspect(path):
    """Header-parse a .wdb and count records without loading meaning. Never raises."""
    with open(path, "rb") as f:
        b = f.read()
    if len(b) < 12:
        return WdbInfo(path=path, standard=False, note="too small", records=0,
                       payload_bytes=0, magic="", cache="?", label="?", build=0,
                       locale="", clean_end=False)
    magic, build, locale = read_header(b)
    known = MAGIC.get(magic)
    # standard header only when build looks like a real client revision and magic is known
    if known and 1000 <= build <= 60000:
        cache, label = known
        n = len(b); off = HEADER_LEN; recs = 0; pay = 0; clean = False
        while off + 8 <= n:
            entry, size = struct.unpack_from("<II", b, off)
            if entry == 0 and size == 0:
                clean = True; break
            if size > 5_000_000 or off + 8 + size > n:
                break                     # malformed; stop where we are
            recs += 1; pay += size; off += 8 + size
        else:
            clean = (off == n)            # reached EOF exactly on a record boundary
        return WdbInfo(path=path, magic=magic.decode("latin1","replace"), cache=cache,
                       label=label, build=build, locale=locale, records=recs,
                       payload_bytes=pay, standard=True, clean_end=clean,
                       note="" if clean else "did not reach a clean terminator/EOF")
    # non-standard (addon-written itemstatcache / questcacheaddon, or empty stub)
    return WdbInfo(path=path, magic=b[0:4].decode("latin1","replace").rstrip("\x00"),
                   cache="(non-standard)", label="addon/other header", build=build,
                   locale=locale, records=0, payload_bytes=max(0,len(b)-24),
                   standard=False, clean_end=False,
                   note="non-standard header; needs a specialized parser")
