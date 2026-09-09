# How well corroborated is each published addon?

These files are **executable code** that Ascension's server
pushed to game clients, recovered from players' saved
variables. If you rebuild the interface from this dataset you
will be running them, so here is exactly how much confirmation
each one has.

**submissions** is the number of separate uploads a build
arrived in -- the closest thing we have to *different people
independently saw the same code*. **files** counts the
individual saved-variable files instead, which is always the
same or larger, because one person with several characters
sends several files.

* **corroborated** -- two or more separate submissions carried
  this exact build.
* **single submission** -- one upload is the only evidence this
  is what the server sent. Almost certainly genuine, but it
  rests on one person's word, so treat it as unverified code.
* **UNRESOLVED** -- two or more different builds are equally
  corroborated and equally old, and nothing but the code's own
  bytes could separate them. We refuse to pick on that basis,
  so the file is **left out** of the merged `AIO_Client.lua`
  and every build is written to `addons/unresolved/` for a
  person to compare.

*Oldest capture* is the earliest modification time of a
file carrying this build. For a file that arrived inside an
archive that may be when it was unpacked here rather than when
the player recorded it, so read it as a rough ordering and not
a precise date. It breaks ties between equally corroborated
builds, in preference to anything derived from the code's own
bytes.

| addon file | builds seen | submissions | files | oldest capture | status |
|---|---:|---:|---:|---|---|
| `BC_Client.lua` | 2 | 1 | 1 | 2021-09-26 | single submission |
| `Blizz_interface_improvements.lua` | 2 | 1 | 2 | 2021-09-26 | single submission |
| `ButtonTemplates.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `CAO_Client.lua` | 2 | 1 | 1 | 2021-09-26 | single submission |
| `CAO_Client_Tutorial.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `CharFrameEdit.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `ChatChannelsC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `CheckpointDeathClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `Client_LocalizationStuff.lua` | 2 | 1 | 2 | 2021-09-26 | single submission |
| `ClientCharacterAdvancement.lua` | 2 | 1 | 2 | 2021-09-26 | single submission |
| `ClientEBB.lua` | 3 | 1 | 1 | 2021-09-26 | single submission |
| `ClientResets.lua` | 2 | 1 | 2 | 2021-09-26 | single submission |
| `ClientStatAllocation.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `CollectionController.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `DraftMode_Client.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `EnchantReRollC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `HotBarSaverClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `HybridScrollFrame.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `IconSelector.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `InspectClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `LevelUpDisplay_Ascension_Client.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `Misc_DeathResFrame.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `PatchVersionCompareC.lua` | 2 | 1 | 2 | 2021-09-26 | single submission |
| `PersonalBankClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `PlayerFramePrestigeC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `RandomMode_Client.lua` | 1 | 1 | 2 | 2021-09-26 | single submission |
| `SeasonalCollectionC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `StoreCollectionC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `SwitchSpecClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `TomeCollectionsC.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `TooltipCorrector.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `UnlearnSkillClient.lua` | 1 | 1 | 1 | 2026-09-09 | single submission |
| `LeaveGroup.lua` | 1 | 2 | 3 | 2021-09-26 | corroborated |
| `NewbieHelp_Client.lua` | 1 | 2 | 3 | 2021-09-26 | corroborated |
