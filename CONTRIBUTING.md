# Contributing recovered data

Use the [cache contribution tool](https://github.com/hertigservices/Ascension_preservation/tree/main/tools/cache-consolidator)
from the preservation source or your installed intake tools. It previews the
submission and keeps account/configuration data outside published datasets.

This repository accepts reviewed, attributed data outputs. Tool fixes belong in
Ascension_preservation, under tools/cache-consolidator. Keep game-mode variants
and source provenance. A supplemental export must retain its original bytes,
source hash and interpretation limits and pass its format-specific verifier.

Never commit raw inbox contents, private configuration, credentials, player
character archives, intake ledgers or live database dumps. Ordinary cache
publication uses the existing audit-gated publisher from the canonical code.
