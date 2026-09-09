# How do we know any of this actually works?

Fair question, and it deserves a real answer rather than "the tests pass".

There are two completely different claims here and they need completely
different evidence:

1. **The published files contain exactly what players' clients recorded** —
   nothing lost, nothing invented. This can be proved offline, automatically,
   and it is: `python tools/selftest.py`.
2. **The game will actually read those files and show the right thing.** No
   amount of offline checking can prove this. Only the game can, and it takes
   a person about ten minutes: `python tools/gametest.py`.

Everything below is about telling those two apart, because it is very easy to
do the first one thoroughly and quietly believe you have done the second.

---

## Part 1 — what is proved automatically

### The trap this avoids

The pipeline already re-reads everything it writes. `rebuild.py` re-parses each
`.wdb` it builds and compares every record; `luamerge.py` re-reads its own Lua
and checks it is byte-identical; `unpack.py` validates the header before it
lets you install anything.

Those are all worth having and they all share one blind spot: **they compare
our encoder against our decoder.** If both are wrong in the same way, every one
of them passes and the file is still broken. A test that can only agree with
itself is not evidence.

### What `selftest.py` does instead

It goes back to the submitted `.wdb` files — the ones the game itself wrote to
players' hard drives — and treats those as the truth, because no code of ours
had any say in what those bytes should be.

    python tools/selftest.py

Four checks:

| check | what would fail it |
|---|---|
| **Nothing invented** | a published record whose bytes no client ever wrote |
| **Nothing lost** | a record in a submitted file that is not published |
| **Real headers** | a 24-byte file header we made up instead of copying from a real cache |
| **Still intact** | a file that does not survive the gzip round trip, or does not end on a clean record boundary — the exact thing the client checks before accepting a cache |

Result as of the last run:

```
  899,417 published records are byte-identical to what a real client wrote
  5,280 records where submitted copies disagreed and the merge picked one
  0 lost, 0 invented entries, 0 invented payloads
  0 synthesised headers, 0 files without a clean terminator
```

**The 5,280 are not errors.** They are the records where two players' caches
genuinely disagreed about the same thing — the item was changed between their
captures, or the two modes really do differ — and the merge had to choose one.
They are counted separately precisely so they are not hidden inside the good
number.

### What this does NOT prove

That the game likes the files. A cache can be a perfect container for perfect
records and still be rejected — wrong build number in the header, wrong locale,
put in a folder for the wrong realm. Part 1 cannot see any of that.

---

## Part 2 — the in-game test

### Why "I installed it and it seemed fine" is not evidence

Two things go wrong with the obvious approach:

* **The server may be the one answering.** If you test an item the realm you
  are on already knows, it will send you the data itself and everything will
  look wonderful whether or not the cache was ever opened.
* **Your own old cache may be the one answering.** The client keeps whatever it
  learned last time.

So the test has to be built to rule both of those out.

### The design

`python tools/gametest.py` picks two sets of item ids for you:

* **probes** — items that *are* in the merged cache, preferring Ascension's own
  custom items, because nothing in stock World of Warcraft and no other realm
  could possibly know those names.
* **controls** — ids that are in **no** cache we publish at all.

You run the same one-line command in-game twice, before and after installing
the cache. The cache file is the only thing that changes between the two runs,
which is what makes the result mean something.

It also prints **the exact names you should see**, so the test proves the data
is *right* — not merely that something appeared.

### The procedure

Run `python tools/gametest.py` and it prints the whole thing with real ids
filled in. In outline:

1. **Before installing anything**, log in and paste the probe line. Every line
   should say `MISS`.
2. **Quit the game to desktop.** This matters — the client rewrites its cache
   files as it exits, so anything you copy in while it is running is thrown
   away on the way out, and you would be testing your own old cache.
3. With the game closed, install: `python tools/unpack.py --mode <mode> --into
   "<your WoW>/Cache/WDB/enUS/<Realm - Mode>"`. That last folder has to be the
   one the client made for the realm you are about to log into; caches are read
   per realm and per mode, and the wrong folder is simply never opened.
   `unpack.py` warns you if the name looks wrong.
4. Start the game again and paste the same line. You should now get the exact
   names the tool printed.
5. Paste the control line at both step 1 and step 4. It must say `MISS` every
   single time.

### Reading the result

| before | after | verdict |
|---|---|---|
| all `MISS` | the exact names | **PASS.** The client read our file. |
| all `MISS` | all `MISS` | The client ignored or rejected the cache. |
| names already | names | Inconclusive — the *server* knows these items. Test a mode whose content that realm does not have. |
| a name appears in the **control** set | anything | The test is not sound. Something is answering for ids nobody has; please tell us. |

The middle row is the one worth dwelling on: a test that cannot fail is not a
test, and "it showed the names" only means something if you know it would have
said `MISS` otherwise.

### If you want to retest

Once you quit after step 4, the client will have rewritten those cache files
with its own copy. Re-install them before running the test again.

---

## Current honest status

* **Part 1 — done, passing, and automated.** It runs against every published
  cache in about half a minute and its result is quoted above.
* **Part 2 — the tooling is built and the procedure is written, but it has not
  been executed against a live client yet.** Nobody should read this document
  as saying the in-game half has been confirmed. When someone runs it, the
  result belongs here.

If you run it, please report what you saw — including a failure, which is far
more useful to us than a pass.
