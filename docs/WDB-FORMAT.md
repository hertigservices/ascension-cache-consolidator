# The WDB file format (moved)

This reference now lives with the tools that read and write the format:

**[docs/WDB-FORMAT.md in Ascension Preservation](https://github.com/hertigservices/Ascension_preservation/blob/main/tools/cache-consolidator/docs/WDB-FORMAT.md)**

There is one copy of it, and this is a signpost to that copy — not a second one.
The format notes exist because a decoder in that repository depends on them, so
they are kept beside it.

What is on the other side: the layout of a `.wdb` cache file — its header, how a
record is framed, and the parts of a record that are still unread. The files
themselves are under [cachedata/wdb/](../cachedata/wdb/) here.
