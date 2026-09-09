"""Decode raw questcache.wdb records (SMSG_QUEST_QUERY_RESPONSE payloads, build 12340)
into a quest_template-shaped TSV, unioned across every distinct cache in the archive.

Self-validating: each record's payload length is known from the WDB record walk, so a
correct field layout consumes EXACTLY that many bytes. We tally exact/leftover/overrun
per record; ~100% exact == the binary layout is proven.

PROVEN LAYOUT (empirically derived + oracle-verified — see wdb_decode_quest_report.md):
  Unlike itemcache, the quest payload REPEATS the quest id as its first u32 (== the
  record-header entry). 65 leading u32 = QuestId + 64 standard 3.3.5 fields. Then 5
  strings (Title, Objectives, Details, EndText, CompletedText), then 28 u32
  (four INTERLEAVED objectives of npcOrGo/count/srcItem/srcCount, then
  RequiredItem id[6]/count[6]), then 4 ObjectiveText strings. No trailing
  QuestGiver-text-window / sound fields exist in this build's response.

  A WARNING ABOUT THE ORACLE, because this file has already been bitten by it.
  consumed==size proves the layout's total WIDTH, not its ALIGNMENT. Any
  rearrangement that moves the same number of bytes -- a shifted field, a pair of
  arrays that are really one interleave -- scores 100% exact and is invisible here.
  The objective block was read as two separate arrays for its whole first life and
  the oracle never once complained. Check field ORDER against known-good rows
  (stock quests in a world DB, a wiki entry, the client's own tooltip), not against
  the byte count.

Native python can't see /c/... paths on this box -> C:/... paths only.
"""
import os, sys, math, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

# SCAN_ROOTS, not EXTRA_SCAN_ROOTS: the latter omits _inbox, so a bare .wdb dropped
# straight in there was ledgered by intake and then silently skipped at decode time.
SCAN = [config.EXTRACT] + config.SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/quest.tsv"
OUT_REP = config.WORK + "/decoded/quest_report.md"

# Every field the walk reads is kept. The walk had to touch all of them anyway to
# prove the byte count; storing only twenty of them threw the rest away at the door.
# Names follow this file's existing convention (the wire field names), not the
# AzerothCore quest_template spelling, because quest is not a DB merge job -- the
# published TSV is the product, and renaming the columns already in it would break
# anyone holding the old shape for no gain.
REW_ITEM   = [c for i in range(1,5) for c in (f"RewardItem{i}", f"RewardAmount{i}")]
REW_CHOICE = [c for i in range(1,7)
              for c in (f"RewardChoiceItemId{i}", f"RewardChoiceItemCount{i}")]
REW_FACTION = ([f"RewardFactionId{i}" for i in range(1,6)]
               + [f"RewardFactionValueId{i}" for i in range(1,6)]
               + [f"RewardFactionValueIdOverride{i}" for i in range(1,6)])
REQ_NPCGO  = [c for i in range(1,5)
              for c in (f"RequiredNpcOrGo{i}", f"RequiredNpcOrGoCount{i}")]
REQ_SRC    = [c for i in range(1,5)
              for c in (f"RequiredSourceItemId{i}", f"RequiredSourceItemCount{i}")]
REQ_ITEM   = [c for i in range(1,7)
              for c in (f"RequiredItemId{i}", f"RequiredItemCount{i}")]

OUT_COLS = (["entry","Method","QuestLevel","MinLevel","ZoneOrSort","Type",
             "SuggestedPlayers","RepObjectiveFaction","RepObjectiveValue",
             "RepObjectiveFaction2","RepObjectiveValue2","NextQuestInChain",
             "RewXPId","RewOrReqMoney","RewMoneyMaxLevel","RewSpell","RewSpellCast",
             "RewHonor","RewHonorMultiplier","SrcItemId","Flags","RewTitleId",
             "RequiredPlayerKills","RewTalents","RewArenaPoints","RewRepMask"]
            + REW_ITEM + REW_CHOICE + REW_FACTION
            # The quest POI. Community wisdom is that quest point-of-interest data
            # is never cached client-side and has to come from a packet sniff.
            # It is right here in the query response, on the quests that have one.
            + ["PointMapId","PointX","PointY","PointOpt"]
            + ["Title","Objectives","Details","EndText","CompletedText"]
            + REQ_NPCGO + REQ_SRC + REQ_ITEM
            + ["ObjectiveText1","ObjectiveText2","ObjectiveText3","ObjectiveText4"])

TEXTCOLS = {"Title","Objectives","Details","EndText","CompletedText",
            "ObjectiveText1","ObjectiveText2","ObjectiveText3","ObjectiveText4"}

def sanitize(s):
    return s.replace("\t"," ").replace("\r"," ").replace("\n"," ").replace("\\","/")

def fnum(v):
    """Format a float for the TSV: integral values stay integral, the rest get a
    fixed number of decimals. Deterministic, so an unchanged re-run diffs clean."""
    if not math.isfinite(v):
        return "0"
    if v == int(v):
        return str(int(v))
    return f"{v:.6f}".rstrip("0").rstrip(".")

class Cur:
    __slots__=("b","o","n")
    def __init__(self,b): self.b=b; self.o=0; self.n=len(b)
    def u32(self):
        v=struct.unpack_from("<I",self.b,self.o)[0]; self.o+=4; return v
    def i32(self):
        v=struct.unpack_from("<i",self.b,self.o)[0]; self.o+=4; return v
    def f32(self):
        v=struct.unpack_from("<f",self.b,self.o)[0]; self.o+=4; return v
    def cstr(self):
        e=self.b.find(b"\x00",self.o)
        if e<0: e=self.n
        s=self.b[self.o:e]; self.o=e+1
        return wdblib.decode_str(s)

def decode_quest(entry, payload):
    c=Cur(payload); d={k:0 for k in OUT_COLS}
    for k in TEXTCOLS:
        d[k]=""
    d["entry"]=entry
    quest_id      = c.u32()                       # [0] repeated quest id (== header entry)
    d["Method"]         = c.u32()                 # [1]
    d["QuestLevel"]     = c.i32()                 # [2]
    d["MinLevel"]       = c.u32()                 # [3]
    d["ZoneOrSort"]     = c.i32()                 # [4]
    d["Type"]           = c.u32()                 # [5]
    d["SuggestedPlayers"]= c.u32()                # [6]
    d["RepObjectiveFaction"] = c.u32()            # [7]
    d["RepObjectiveValue"]   = c.u32()            # [8]
    d["RepObjectiveFaction2"]= c.u32()            # [9]
    d["RepObjectiveValue2"]  = c.u32()            # [10]
    d["NextQuestInChain"]= c.u32()                # [11]
    d["RewXPId"]        = c.u32()                 # [12] RewardXP index
    d["RewOrReqMoney"]  = c.i32()                 # [13]
    d["RewMoneyMaxLevel"]= c.u32()                # [14]
    d["RewSpell"]       = c.u32()                 # [15]
    d["RewSpellCast"]   = c.i32()                 # [16]
    d["RewHonor"]       = c.u32()                 # [17]
    d["RewHonorMultiplier"]= fnum(c.f32())        # [18]
    d["SrcItemId"]      = c.u32()                 # [19]
    d["Flags"]          = c.u32()                 # [20]
    d["RewTitleId"]     = c.u32()                 # [21]
    d["RequiredPlayerKills"]= c.u32()             # [22]
    d["RewTalents"]     = c.u32()                 # [23]
    d["RewArenaPoints"] = c.u32()                 # [24]
    d["RewRepMask"]     = c.u32()                 # [25] review show mask
    for i in range(4):                            # [26..33]
        d[f"RewardItem{i+1}"]=c.u32(); d[f"RewardAmount{i+1}"]=c.u32()
    for i in range(6):                            # [34..45]
        d[f"RewardChoiceItemId{i+1}"]=c.u32()
        d[f"RewardChoiceItemCount{i+1}"]=c.u32()
    for i in range(5): d[f"RewardFactionId{i+1}"]=c.u32()             # [46..50]
    for i in range(5): d[f"RewardFactionValueId{i+1}"]=c.i32()        # [51..55]
    for i in range(5): d[f"RewardFactionValueIdOverride{i+1}"]=c.u32()# [56..60]
    d["PointMapId"]=c.u32()                       # [61..64]
    d["PointX"]=fnum(c.f32()); d["PointY"]=fnum(c.f32())
    d["PointOpt"]=c.u32()
    # ---- string block 1 (5) ----
    d["Title"]        = sanitize(c.cstr())
    d["Objectives"]   = sanitize(c.cstr())
    d["Details"]      = sanitize(c.cstr())
    d["EndText"]      = sanitize(c.cstr())
    d["CompletedText"]= sanitize(c.cstr())
    # ---- tail fixed (28 u32) ----
    # The four objectives are INTERLEAVED: each objective carries its npc/go and its
    # item drop together -- (npcOrGo, count, srcItem, srcCount) -- rather than the
    # packet sending all four npc/go pairs and then all four item pairs. Both
    # readings consume the same 64 bytes, so the consumed==size oracle cannot tell
    # them apart: it proves WIDTH, not ALIGNMENT, and the wrong one scored 100%
    # exact for as long as it shipped.
    #
    # Settled by vote against the stock quests in the live world DB (id < 30000,
    # which came from AzerothCore and are authoritative for 3.3.5 content):
    # interleaved reproduces the RequiredNpcOrGo block on 10,421 of 10,456 quests
    # (99.67%); two-separate-arrays managed 9,103 (87.06%). Quest 14 settles it on
    # its own -- creatures 122/121/449 killed 15/5/5 times, which only the
    # interleave produces. On the item-drop half every remaining disagreement is
    # "DB empty, client has data" (651 quests) and not one is a real conflict.
    for i in range(4):
        d[f"RequiredNpcOrGo{i+1}"]=c.i32(); d[f"RequiredNpcOrGoCount{i+1}"]=c.u32()
        d[f"RequiredSourceItemId{i+1}"]=c.u32()
        d[f"RequiredSourceItemCount{i+1}"]=c.u32()
    for i in range(6):
        d[f"RequiredItemId{i+1}"]=c.u32(); d[f"RequiredItemCount{i+1}"]=c.u32()
    # ---- string block 2 (4 ObjectiveText) ----
    d["ObjectiveText1"]=sanitize(c.cstr())
    d["ObjectiveText2"]=sanitize(c.cstr())
    d["ObjectiveText3"]=sanitize(c.cstr())
    d["ObjectiveText4"]=sanitize(c.cstr())
    return d, c.o, quest_id

def iter_questcaches():
    seen=set()
    for root in SCAN:
        if not os.path.isdir(root): continue
        for dp,_dn,fs in os.walk(root):
            for fn in fs:
                if fn.lower()!="questcache.wdb": continue
                p=os.path.join(dp,fn)
                h=hashlib.sha256(open(p,"rb").read()).hexdigest()
                if h in seen: continue
                seen.add(h)
                yield p.replace("\\","/"), h

def main():
    os.makedirs(os.path.dirname(OUT_TSV), exist_ok=True)
    union={}
    per_file=[]
    exact=leftover=overrun=idmismatch=0
    samples={}
    for path,h in iter_questcaches():
        b=open(path,"rb").read()
        info=wdblib.inspect(path)
        cnt=0; new=0; nonempty = info.records if info.standard else 0
        if not info.standard:
            per_file.append((path, 0, 0, "non-standard/empty header"))
            continue
        for entry,size,payload in wdblib.iter_records(b):
            try:
                row,consumed,qid = decode_quest(entry,payload)
            except Exception:
                overrun+=1; continue
            if   consumed==size: exact+=1
            elif consumed<size:  leftover+=1
            else:                overrun+=1
            if qid != entry: idmismatch+=1
            cnt+=1
            if entry not in union:
                union[entry]=row; new+=1
            if entry in (20,89,91) and entry not in samples:
                samples[entry]=row
        per_file.append((path, cnt, new, ""))

    with open(OUT_TSV,"w",encoding="utf-8",newline="") as w:
        w.write("\t".join(OUT_COLS)+"\n")
        for e in sorted(union):
            r=union[e]
            w.write("\t".join(str(r[c]) for c in OUT_COLS)+"\n")

    total=exact+leftover+overrun
    pct=100*exact/max(1,total)
    L=[]
    L.append("# WDB questcache decode — union across all Ascension client caches\n")
    L.append(f"Distinct non-empty questcaches decoded: {sum(1 for p in per_file if p[1]>0)}"
             f"  (of {len(per_file)} distinct-by-sha files enumerated)\n")
    L.append(f"**Union of unique quest entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append(f"- records parsed : {total:,}")
    L.append(f"- exact match    : {exact:,}  ({pct:.2f}%)")
    L.append(f"- leftover (short parse) : {leftover:,}")
    L.append(f"- overrun (BAD layout)   : {overrun:,}")
    L.append(f"- payload-quest-id != header-entry : {idmismatch:,}\n")
    L.append("## Confirmed field layout")
    L.append("65 leading u32 = **QuestId(repeated)** + 64 standard fields; then 5 strings "
             "(Title, Objectives, Details, EndText, CompletedText); then 28 u32 "
             "(RequiredNpcOrGo id/cnt x4, RequiredSourceItem id/cnt x4, RequiredItem id/cnt x6); "
             "then 4 ObjectiveText strings. No trailing QuestGiver-text/sound fields.\n")
    L.append("## Spot-check")
    for e in (20,89,91):
        if e in samples:
            r=samples[e]
            L.append(f"- entry {e}: Title={r['Title']!r} Lvl={r['QuestLevel']} Zone={r['ZoneOrSort']} "
                     f"Type={r['Type']} | Objectives[:60]={r['Objectives'][:60]!r}")
    L.append("")
    L.append("## Per-file contribution (records / new-to-union)")
    for path,cnt,new,note in sorted(per_file,key=lambda x:-x[1]):
        tag = f"  [{note}]" if note else ""
        L.append(f"- {cnt:6,} rec, {new:6,} new  {path}{tag}")
    open(OUT_REP,"w",encoding="utf-8").write("\n".join(L)+"\n")
    print(f"union={len(union)} exact={exact} leftover={leftover} overrun={overrun} "
          f"idmismatch={idmismatch} exact%={pct:.2f}")
    for e in (20,89,91):
        if e in samples: print(f"  {e}: {samples[e]['Title']!r} lvl={samples[e]['QuestLevel']}")
    print("->",OUT_TSV)

if __name__=="__main__":
    main()
