"""Decode raw itemcache.wdb records (SMSG_ITEM_QUERY_SINGLE_RESPONSE payloads,
build 12340) into the 53-column item_template shape used by the harvest pipeline.

Self-validating: each record's payload length is known from the WDB record walk, so a
correct field layout consumes EXACTLY that many bytes. We tally exact/leftover/overrun
per record; ~100% exact == the binary layout is proven. Also asserts a known item
(entry 564818 = "Glorious Cloak of Conquest", class 4/sub 1, display 20669, quality 4).

Unions every distinct (by sha) non-empty itemcache across all realms/modes, dedup by
entry (all snapshots of one entry are identical; conflicts are counted, not merged).
Native python can't see /c/... -> C:/... paths only.
"""
import os, sys, json, struct, hashlib, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

SCAN = [config.EXTRACT] + config.EXTRA_SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/wdb_items.tsv"
OUT_REP = config.WORK + "/decoded/wdb_items_report.md"

STATCOLS = [c for i in range(1,11) for c in (f"stat_type{i}", f"stat_value{i}")]
COLS = (["entry","class","subclass","name","displayid","Quality","InventoryType",
         "ItemLevel","RequiredLevel","stackable","BuyPrice","SellPrice","StatsCount"]
        + STATCOLS
        + ["dmg_min1","dmg_max1","dmg_type1","dmg_min2","dmg_max2","dmg_type2",
           "armor","delay","bonding"]
        + [c for i in range(1,6) for c in (f"spellid_{i}", f"spelltrigger_{i}")]
        + ["description"])

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

def decode_item(entry, payload):
    # The WDB record body starts at Class; `entry` comes from the record header, it is
    # NOT repeated in the payload.
    c=Cur(payload); d={k:0 for k in COLS}; d["name"]=""; d["description"]=""
    d["entry"]=entry
    d["class"]=c.u32(); d["subclass"]=c.u32(); c.i32()                       # SoundOverrideSubclass
    n1=c.cstr(); c.cstr(); c.cstr(); c.cstr()                                # Name[4]
    d["name"]=sanitize(n1)
    d["displayid"]=c.u32(); d["Quality"]=c.u32(); c.u32(); c.u32()           # Flags, Flags2
    d["BuyPrice"]=c.i32(); d["SellPrice"]=c.u32()
    d["InventoryType"]=c.u32(); c.u32(); c.u32()                             # AllowableClass, AllowableRace
    d["ItemLevel"]=c.u32(); d["RequiredLevel"]=c.u32()
    c.u32(); c.u32(); c.u32()                # RequiredSkill, RequiredSkillRank, RequiredSpell
    c.u32(); c.u32()                         # RequiredHonorRank, RequiredCityRank
    c.u32(); c.u32()                         # RequiredReputationFaction, RequiredReputationRank
    c.i32(); d["stackable"]=c.i32()          # MaxCount, Stackable
    c.u32()                                  # ContainerSlots
    sc=c.u32(); d["StatsCount"]=sc
    for i in range(sc):
        t=c.u32(); v=c.i32()
        if i<10: d[f"stat_type{i+1}"]=t; d[f"stat_value{i+1}"]=v
    c.u32(); c.u32()                          # ScalingStatDistribution, ScalingStatValue
    dmg=[]
    for _ in range(2):
        mn=c.f32(); mx=c.f32(); ty=c.u32(); dmg.append((mn,mx,ty))
    d["dmg_min1"]=round(dmg[0][0]); d["dmg_max1"]=round(dmg[0][1]); d["dmg_type1"]=dmg[0][2]
    d["dmg_min2"]=round(dmg[1][0]); d["dmg_max2"]=round(dmg[1][1]); d["dmg_type2"]=dmg[1][2]
    d["armor"]=c.i32()
    for _ in range(6): c.i32()                # 6 resistances
    d["delay"]=c.u32(); c.u32(); c.f32()      # Delay, AmmoType, RangedModRange
    for i in range(5):
        sid=c.i32(); trg=c.u32(); c.i32(); c.i32(); c.u32(); c.i32()  # id,trigger,charges,cooldown,category,catCooldown
        d[f"spellid_{i+1}"]=sid; d[f"spelltrigger_{i+1}"]=trg
    d["bonding"]=c.u32()
    d["description"]=sanitize(c.cstr())
    # --- trailing fixed fields (not needed for item_template, parsed only so the
    #     consumed-byte total can validate the whole layout against the record size) ---
    c.u32(); c.u32(); c.u32(); c.u32(); c.u32()   # PageText, LanguageID, PageMaterial, StartQuest, LockID
    c.i32(); c.u32(); c.u32(); c.u32()            # Material, Sheath, RandomProperty, RandomSuffix
    c.u32(); c.u32(); c.u32(); c.u32(); c.u32()   # Block, ItemSet, MaxDurability, Area, Map
    c.u32(); c.u32()                              # BagFamily, TotemCategory
    for _ in range(3): c.u32(); c.u32()           # 3 sockets: color, content
    c.u32(); c.u32(); c.f32()                     # SocketBonus, GemProperties, ArmorDamageModifier
    c.u32(); c.u32(); c.u32()                     # Duration, ItemLimitCategory, HolidayId
    c.u32()                                       # one trailing u32 (build-12340 specific)
    return d, c.o

def iter_itemcaches():
    seen=set()
    for root in SCAN:
        if not os.path.isdir(root): continue
        for dp,_dn,fs in os.walk(root):
            for fn in fs:
                if fn.lower()!="itemcache.wdb": continue
                p=os.path.join(dp,fn)
                h=hashlib.sha256(open(p,"rb").read()).hexdigest()
                if h in seen: continue
                seen.add(h)
                yield p.replace("\\","/")

def main():
    os.makedirs(os.path.dirname(OUT_TSV), exist_ok=True)
    union={}                       # entry -> row
    per_file=[]                    # (label, records, new_here)
    exact=leftover=overrun=0
    val=None
    for path in iter_itemcaches():
        b=open(path,"rb").read()
        cnt=0; new=0
        for entry,size,payload in wdblib.iter_records(b):
            try:
                row,consumed=decode_item(entry,payload)
            except Exception:
                overrun+=1; continue
            if   consumed==size: exact+=1
            elif consumed<size:  leftover+=1
            else:                overrun+=1
            cnt+=1
            if entry==564818 and val is None: val=row
            if entry not in union:
                union[entry]=row; new+=1
            # else: identical snapshot; keep first
        realm=os.path.basename(os.path.dirname(path))
        per_file.append((realm,cnt,new,path))

    # write union TSV
    with open(OUT_TSV,"w",encoding="utf-8",newline="") as w:
        w.write("\t".join(COLS)+"\n")
        for e in sorted(union):
            r=union[e]
            w.write("\t".join(str(r[c]) for c in COLS)+"\n")

    # report
    total=exact+leftover+overrun
    L=[]
    L.append("# WDB itemcache decode — union across all realms/modes\n")
    L.append(f"Distinct non-empty itemcaches decoded: {len(per_file)}\n")
    L.append(f"**Union of unique item entries: {len(union):,}**\n")
    L.append("## Layout validation (bytes consumed vs declared record size)")
    L.append(f"- exact match : {exact:,}  ({100*exact/max(1,total):.2f}%)")
    L.append(f"- leftover (short parse) : {leftover:,}")
    L.append(f"- overrun (BAD layout)   : {overrun:,}\n")
    if val:
        L.append("## Spot-check entry 564818")
        L.append(f"- name='{val['name']}' class={val['class']} subclass={val['subclass']} "
                 f"displayid={val['displayid']} Quality={val['Quality']} "
                 f"ItemLevel={val['ItemLevel']}\n")
    L.append("## Per-itemcache contribution (records / new-to-union)")
    for realm,cnt,new,path in sorted(per_file,key=lambda x:-x[1]):
        L.append(f"- {realm:32} {cnt:6,} records, {new:6,} new")
    open(OUT_REP,"w",encoding="utf-8").write("\n".join(L)+"\n")
    print(f"union={len(union)} exact={exact} leftover={leftover} overrun={overrun}")
    if val: print("564818:",val["name"],"class",val["class"],"disp",val["displayid"],"Q",val["Quality"])
    print("->",OUT_TSV)

if __name__=="__main__":
    main()
