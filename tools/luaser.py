"""Parser and writer for WoW SavedVariables (.lua) files.

These files are not hand-written Lua -- they are emitted by the client's own
serializer, so the grammar is tiny and completely regular:

    NAME = {
        ["key"] = value,
        [123] = value,
        value, -- [1]
    }

and `value` is a string, a number, true/false/nil, or another table. That means a
real parser is only ~100 lines and is far safer than regex-scraping: we have to
*understand* the tree to know which branches are server data and which are the
submitter's character config, and a regex cannot tell those apart.

Nothing here executes Lua. The input is untrusted (it arrives from strangers),
so it is only ever tokenised.

Writing is deliberately not a faithful echo of the input: keys are emitted in
sorted order so that merging the same data twice produces byte-identical output
and git sees no diff. The client does not care about key order.
"""
import re


class LuaError(ValueError):
    pass


class Table:
    """A Lua table: an ordered array part plus keyed entries.

    Kept separate because the client's serializer writes array items as bare
    values (`value, -- [1]`) and turning those into keys 1..n would change the
    file's shape on the way back out.
    """

    __slots__ = ("array", "hash")

    def __init__(self):
        self.array = []   # list of values
        self.hash = {}    # key (int|float|str) -> value

    def __repr__(self):
        return f"<Table array={len(self.array)} hash={len(self.hash)}>"

    def get(self, k, default=None):
        return self.hash.get(k, default)

    def __contains__(self, k):
        return k in self.hash

    def __len__(self):
        return len(self.array) + len(self.hash)


# ---------------------------------------------------------------- tokenising

# Order matters: longer literals first, and the comment rule must beat `-`.
_TOKEN = re.compile(r"""
      (?P<ws>\s+)
    | (?P<comment>--\[\[.*?\]\]|--[^\n]*)
    | (?P<str>"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')
    | (?P<num>-?(?:0[xX][0-9a-fA-F]+|(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?))
    | (?P<name>[A-Za-z_][A-Za-z0-9_]*)
    | (?P<punct>[\[\]{}=,;])
""", re.VERBOSE | re.DOTALL)

# WoW writes \ddd decimal escapes for bytes outside ASCII, plus the usual set.
_ESCAPES = {"a": "\a", "b": "\b", "f": "\f", "n": "\n", "r": "\r",
            "t": "\t", "v": "\v", "\\": "\\", '"': '"', "'": "'", "\n": "\n"}


def _unescape(raw):
    """Decode a quoted Lua string literal body (quotes already stripped)."""
    out, i, n = [], 0, len(raw)
    while i < n:
        c = raw[i]
        if c != "\\":
            out.append(c)
            i += 1
            continue
        i += 1
        if i >= n:
            break
        e = raw[i]
        if e.isdigit():                       # \ddd, up to three digits
            j = i
            while j < n and j - i < 3 and raw[j].isdigit():
                j += 1
            out.append(chr(int(raw[i:j])))
            i = j
        elif e == "x" and i + 2 < n:          # \xHH
            out.append(chr(int(raw[i + 1:i + 3], 16)))
            i += 3
        else:
            out.append(_ESCAPES.get(e, e))
            i += 1
    return "".join(out)


def _tokens(src):
    pos, n = 0, len(src)
    while pos < n:
        m = _TOKEN.match(src, pos)
        if not m:
            ctx = src[pos:pos + 40].replace("\n", "\\n")
            raise LuaError(f"unexpected input at offset {pos}: {ctx!r}")
        pos = m.end()
        kind = m.lastgroup
        if kind in ("ws", "comment"):
            continue
        yield kind, m.group()
    yield "eof", ""


class _Parser:
    def __init__(self, src):
        self._it = _tokens(src)
        self._tok = next(self._it)

    def _next(self):
        t = self._tok
        self._tok = next(self._it)
        return t

    def _expect(self, kind, text=None):
        k, v = self._next()
        if k != kind or (text is not None and v != text):
            raise LuaError(f"expected {text or kind}, got {v!r}")
        return v

    def value(self):
        kind, text = self._tok
        if kind == "punct" and text == "{":
            return self.table()
        self._next()
        if kind == "str":
            return _unescape(text[1:-1])
        if kind == "num":
            if text.lower().startswith(("0x", "-0x")):
                return int(text, 16)
            if any(c in text for c in ".eE"):
                return float(text)
            return int(text)
        if kind == "name":
            if text == "true":
                return True
            if text == "false":
                return False
            if text == "nil":
                return None
            raise LuaError(f"bare identifier {text!r} is not a value")
        raise LuaError(f"not a value: {text!r}")

    def table(self):
        self._expect("punct", "{")
        t = Table()
        while True:
            kind, text = self._tok
            if kind == "punct" and text == "}":
                self._next()
                return t
            if kind == "punct" and text == "[":
                self._next()
                key = self.value()
                self._expect("punct", "]")
                self._expect("punct", "=")
                t.hash[key] = self.value()
            elif kind == "name" and self._peek_is_assign():
                key = self._next()[1]
                self._expect("punct", "=")
                t.hash[key] = self.value()
            else:
                t.array.append(self.value())
            k, v = self._tok
            if k == "punct" and v in (",", ";"):
                self._next()

    def _peek_is_assign(self):
        # `name = v` is a key; a bare `name` would be an identifier, which the
        # client never emits as an array value.
        return True


def loads(src):
    """Parse a whole SavedVariables file -> {global_name: value}."""
    p = _Parser(src)
    out = {}
    while p._tok[0] != "eof":
        kind, text = p._tok
        if kind == "punct" and text == ";":
            p._next()
            continue
        name = p._expect("name")
        p._expect("punct", "=")
        out[name] = p.value()
    return out


def load(path):
    with open(path, encoding="utf-8", errors="replace") as f:
        return loads(f.read())


# ------------------------------------------------------------------- writing

_SAFE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")


def _q(s):
    out = ['"']
    for ch in s:
        if ch == '"':
            out.append('\\"')
        elif ch == "\\":
            out.append("\\\\")
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\r":
            out.append("\\r")
        elif ord(ch) < 32:
            out.append("\\%d" % ord(ch))
        else:
            out.append(ch)
    out.append('"')
    return "".join(out)


def _num(v):
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, int):
        return str(v)
    # repr keeps full float precision, which matters: these are measured values
    # and rounding them would silently change the data.
    return repr(v)


def _key_order(k):
    """Numbers before strings, each sorted within itself -- a total order, so
    output is deterministic no matter what order the merge produced."""
    return (0, k, "") if isinstance(k, (int, float)) and not isinstance(k, bool) \
        else (1, 0, str(k))


def _write(v, out, depth):
    pad = "\t" * depth
    if isinstance(v, Table):
        if not len(v):
            out.append("{\n" + pad + "}")
            return
        out.append("{\n")
        inner = "\t" * (depth + 1)
        for i, item in enumerate(v.array, 1):
            out.append(inner)
            _write(item, out, depth + 1)
            out.append(f", -- [{i}]\n")
        for k in sorted(v.hash, key=_key_order):
            out.append(inner + "[")
            out.append(_q(k) if isinstance(k, str) else _num(k))
            out.append("] = ")
            _write(v.hash[k], out, depth + 1)
            out.append(",\n")
        out.append(pad + "}")
    elif isinstance(v, str):
        out.append(_q(v))
    elif v is None:
        out.append("nil")
    else:
        out.append(_num(v))


def dumps(globals_dict):
    """Render {global_name: value} back into SavedVariables text.

    Globals and keys come out sorted, so re-merging unchanged data yields a
    byte-identical file.
    """
    out = []
    for name in sorted(globals_dict):
        out.append(name + " = ")
        _write(globals_dict[name], out, 0)
        out.append("\n")
    return "".join(out)


def dump(globals_dict, path):
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(dumps(globals_dict))


# -------------------------------------------------------------------- helpers

def walk(v, path=()):
    """Yield (path, value) for every leaf, for auditing what a tree contains."""
    if isinstance(v, Table):
        for i, item in enumerate(v.array, 1):
            yield from walk(item, path + (i,))
        for k in sorted(v.hash, key=_key_order):
            yield from walk(v.hash[k], path + (k,))
    else:
        yield path, v


def table_from(mapping=None, array=None):
    t = Table()
    if mapping:
        t.hash.update(mapping)
    if array:
        t.array.extend(array)
    return t
