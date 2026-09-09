"""Decode raw questcache.wdb records (SMSG_QUEST_QUERY_RESPONSE payloads, build 12340)
into a quest_template-shaped TSV, unioned across every distinct cache in the archive.

Self-validating: each record's payload length is known from the WDB record walk, so a
correct field layout consumes EXACTLY that many bytes. We tally exact/leftover/overrun
per record; ~100% exact == the binary layout is proven.

PROVEN LAYOUT (empirically derived + oracle-verified — see wdb_decode_quest_report.md):
  Unlike itemcache, the quest payload REPEATS the quest id as its first u32 (== the
  record-header entry). 65 leading u32 = QuestId + 64 standard 3.3.5 fields. Then 5
  strings (Title, Objectives, Details, EndText, CompletedText), then 28 u32
  (RequiredNpcOrGo id[4]/count[4], RequiredSourceItem id[4]/count[4],
  RequiredItem id[6]/count[6]), then 4 ObjectiveText strings. No trailing
  QuestGiver-text-window / sound fields exist in this build's response.

Native python can't see /c/... paths on this box -> C:/... paths only.
"""
import os, sys, struct, hashlib
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

SCAN = [config.EXTRACT] + config.EXTRA_SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/quest.tsv"
OUT_REP = config.WORK + "/decoded/quest_report.md"

OUT_COLS = ["entry","Method","QuestLevel","MinLevel","ZoneOrSort","Type","SuggestedPlayers",
            "RewOrReqMoney","RewSpell","SrcItemId","Flags",
            "Title","Objectives","Details","EndText","CompletedText",
            "ObjectiveText1","ObjectiveText2","ObjectiveText3","ObjectiveText4"]

def sanitize(s):
    return s.replace("\t"," ").replace("\r"," ").replace("\n"," ").replace("\\","/")

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
    for k in ("Title","Objectives","Details","EndText","CompletedText",
              "ObjectiveText1","ObjectiveText2","ObjectiveText3","ObjectiveText4"):
        d[k]=""
    d["entry"]=entry
    quest_id      = c.u32()                       # [0] repeated quest id (== header entry)
    d["Method"]         = c.u32()                 # [1]
    d["QuestLevel"]     = c.i32()                 # [2]
    d["MinLevel"]       = c.u32()                 # [3]
    d["ZoneOrSort"]     = c.i32()                 # [4]
    d["Type"]           = c.u32()                 # [5]
    d["SuggestedPlayers"]= c.u32()                # [6]
    c.u32(); c.u32()                              # [7,8]  RepObjectiveFaction, Value
    c.u32(); c.u32()                              # [9,10] RepObjectiveFaction2, Value2
    c.u32()                                       # [11] NextQuestInChain
    c.u32()                                       # [12] XPId (RewardXP index)
    d["RewOrReqMoney"]  = c.i32()                 # [13]
    c.u32()                                       # [14] RewMoneyMaxLevel
    d["RewSpell"]       = c.u32()                 # [15]
    c.i32()                                       # [16] RewSpellCast
    c.u32()                                       # [17] RewHonor
    c.f32()                                       # [18] RewHonorMultiplier
    d["SrcItemId"]      = c.u32()                 # [19]
    d["Flags"]          = c.u32()                 # [20]
    c.u32()                                       # [21] RewTitleId
    c.u32()                                       # [22] RequiredPlayerKills
    c.u32()                                       # [23] RewTalents
    c.u32()                                       # [24] RewArenaPoints
    c.u32()                                       # [25] RewRepMask (review show mask)
    for _ in range(4): c.u32(); c.u32()           # [26..33] RewardItem id/count x4
    for _ in range(6): c.u32(); c.u32()           # [34..45] RewardChoiceItem id/count x6
    for _ in range(5): c.u32()                    # [46..50] RewardFactionId x5
    for _ in range(5): c.i32()                    # [51..55] RewardFactionValueId x5
    for _ in range(5): c.u32()                    # [56..60] RewardFactionValueIdOverride x5
    c.u32(); c.f32(); c.f32(); c.u32()            # [61..64] PointMapId, PointX, PointY, PointOpt
    # ---- string block 1 (5) ----
    d["Title"]        = sanitize(c.cstr())
    d["Objectives"]   = sanitize(c.cstr())
    d["Details"]      = sanitize(c.cstr())
    d["EndText"]      = sanitize(c.cstr())
    d["CompletedText"]= sanitize(c.cstr())
    # ---- tail fixed (28 u32) ----
    for _ in range(4): c.u32(); c.u32()           # RequiredNpcOrGo id/count x4
    for _ in range(4): c.u32(); c.u32()           # RequiredSourceItem id/count x4
    for _ in range(6): c.u32(); c.u32()           # RequiredItem id/count x6
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
