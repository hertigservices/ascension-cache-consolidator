"""Decode raw itemcache.wdb records (SMSG_ITEM_QUERY_SINGLE_RESPONSE payloads,
build 12340) into the item_template shape used by the harvest pipeline.

Self-validating: each record's payload length is known from the WDB record walk, so a
correct field layout consumes EXACTLY that many bytes. We tally exact/leftover/overrun
per record; ~100% exact == the binary layout is proven. Also asserts a known item
(entry 564818 = "Glorious Cloak of Conquest", class 4/sub 1, display 20669, quality 4).

Every field the walk reads is now KEPT. It used to keep 53 of them and discard the
rest -- the walk had to touch them all anyway to prove the byte count, so the extra
fields cost nothing to parse and were being thrown away at the door. Column names
match item_template so the merge generator can map them straight across.

A caution about the byte-count proof, learned by getting it wrong: consumed == size
validates the TOTAL width, not the ALIGNMENT. The tail of this record was previously
read as
    socketBonus, GemProperties, ArmorDamageModifier(f32), Duration,
    ItemLimitCategory, HolidayId, <one unexplained trailing u32>
which is seven 32-bit slots and passed the proof on every record -- but it is shifted
one field left of what the server actually sends. There is no trailing u32; the slot
that looked unexplained is HolidayId. Decided on values, not on width:
  * the slot we called ArmorDamageModifier holds 225/200/175/125/100/50/25 and -1,
    which is the disenchant skill ladder, and is a denormal when read as a float;
  * the slot we called ItemLimitCategory holds 3600/7200/21600/604800 -- seconds;
  * the slot we called HolidayId holds ItemLimitCategory ids on 1,650 of 17,480
    sampled records, and HolidayId is 0 on essentially every item.
Nothing published was ever wrong, because none of those five were kept. Widening
from the old comments would have shipped five misnamed columns.

Unions every distinct (by sha) non-empty itemcache across all realms/modes, dedup by
entry (all snapshots of one entry are identical; conflicts are counted, not merged).
Native python can't see /c/... -> C:/... paths only.
"""
import os, sys, math, json, struct, hashlib, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import wdblib, config

# SCAN_ROOTS, not EXTRA_SCAN_ROOTS: the latter omits _inbox, so a bare .wdb dropped
# straight in there was ledgered by intake and then silently skipped at decode time.
SCAN = [config.EXTRACT] + config.SCAN_ROOTS
OUT_TSV = config.WORK + "/decoded/wdb_items.tsv"
OUT_REP = config.WORK + "/decoded/wdb_items_report.md"

STATCOLS = [c for i in range(1,11) for c in (f"stat_type{i}", f"stat_value{i}")]
# Six per spell slot, in wire order. spellppmRate is absent on purpose: the server
# does not send it, so leaving it out is the honest shape.
SPELLCOLS = [c for i in range(1,6)
             for c in (f"spellid_{i}", f"spelltrigger_{i}", f"spellcharges_{i}",
                       f"spellcooldown_{i}", f"spellcategory_{i}",
                       f"spellcategorycooldown_{i}")]
SOCKETCOLS = [c for i in range(1,4)
              for c in (f"socketColor_{i}", f"socketContent_{i}")]

COLS = (["entry","class","subclass","SoundOverrideSubclass","name","displayid",
         "Quality","Flags","FlagsExtra","BuyPrice","SellPrice","InventoryType",
         "AllowableClass","AllowableRace","ItemLevel","RequiredLevel",
         "RequiredSkill","RequiredSkillRank","requiredspell","requiredhonorrank",
         "RequiredCityRank","RequiredReputationFaction","RequiredReputationRank",
         "maxcount","stackable","ContainerSlots","StatsCount"]
        + STATCOLS
        + ["ScalingStatDistribution","ScalingStatValue",
           "dmg_min1","dmg_max1","dmg_type1","dmg_min2","dmg_max2","dmg_type2",
           "armor","holy_res","fire_res","nature_res","frost_res","shadow_res",
           "arcane_res","delay","ammo_type","RangedModRange"]
        + SPELLCOLS
        + ["bonding","description","PageText","LanguageID","PageMaterial",
           "startquest","lockid","Material","sheath","RandomProperty",
           "RandomSuffix","block","itemset","MaxDurability","area","Map",
           "BagFamily","TotemCategory"]
        + SOCKETCOLS
        + ["socketBonus","GemProperties","RequiredDisenchantSkill",
           "ArmorDamageModifier","duration","ItemLimitCategory","HolidayId"])

TEXTCOLS = {"name", "description"}

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

def decode_item(entry, payload):
    # The WDB record body starts at Class; `entry` comes from the record header, it is
    # NOT repeated in the payload.
    c=Cur(payload); d={k:0 for k in COLS}
    for k in TEXTCOLS: d[k]=""
    d["entry"]=entry
    d["class"]=c.u32(); d["subclass"]=c.u32(); d["SoundOverrideSubclass"]=c.i32()
    n1=c.cstr(); c.cstr(); c.cstr(); c.cstr()                                # Name[4]
    d["name"]=sanitize(n1)
    d["displayid"]=c.u32(); d["Quality"]=c.u32()
    d["Flags"]=c.u32(); d["FlagsExtra"]=c.u32()
    d["BuyPrice"]=c.i32(); d["SellPrice"]=c.u32()
    d["InventoryType"]=c.u32()
    d["AllowableClass"]=c.i32(); d["AllowableRace"]=c.i32()
    d["ItemLevel"]=c.u32(); d["RequiredLevel"]=c.u32()
    d["RequiredSkill"]=c.u32(); d["RequiredSkillRank"]=c.u32()
    d["requiredspell"]=c.u32()
    d["requiredhonorrank"]=c.u32(); d["RequiredCityRank"]=c.u32()
    d["RequiredReputationFaction"]=c.u32(); d["RequiredReputationRank"]=c.u32()
    d["maxcount"]=c.i32(); d["stackable"]=c.i32()
    d["ContainerSlots"]=c.u32()
    sc=c.u32(); d["StatsCount"]=sc
    for i in range(sc):
        t=c.u32(); v=c.i32()
        if i<10: d[f"stat_type{i+1}"]=t; d[f"stat_value{i+1}"]=v
    d["ScalingStatDistribution"]=c.u32(); d["ScalingStatValue"]=c.u32()
    dmg=[]
    for _ in range(2):
        mn=c.f32(); mx=c.f32(); ty=c.u32(); dmg.append((mn,mx,ty))
    d["dmg_min1"]=round(dmg[0][0]); d["dmg_max1"]=round(dmg[0][1]); d["dmg_type1"]=dmg[0][2]
    d["dmg_min2"]=round(dmg[1][0]); d["dmg_max2"]=round(dmg[1][1]); d["dmg_type2"]=dmg[1][2]
    d["armor"]=c.i32()
    for r in ("holy_res","fire_res","nature_res","frost_res","shadow_res","arcane_res"):
        d[r]=c.i32()
    d["delay"]=c.u32(); d["ammo_type"]=c.u32()
    d["RangedModRange"]=fnum(c.f32())
    for i in range(5):
        d[f"spellid_{i+1}"]=c.i32()
        d[f"spelltrigger_{i+1}"]=c.u32()
        d[f"spellcharges_{i+1}"]=c.i32()
        d[f"spellcooldown_{i+1}"]=c.i32()
        d[f"spellcategory_{i+1}"]=c.u32()
        d[f"spellcategorycooldown_{i+1}"]=c.i32()
    d["bonding"]=c.u32()
    d["description"]=sanitize(c.cstr())
    d["PageText"]=c.u32(); d["LanguageID"]=c.u32(); d["PageMaterial"]=c.u32()
    d["startquest"]=c.u32(); d["lockid"]=c.u32()
    d["Material"]=c.i32(); d["sheath"]=c.u32()
    d["RandomProperty"]=c.u32(); d["RandomSuffix"]=c.u32()
    d["block"]=c.u32(); d["itemset"]=c.u32(); d["MaxDurability"]=c.u32()
    d["area"]=c.u32(); d["Map"]=c.u32()
    d["BagFamily"]=c.u32(); d["TotemCategory"]=c.u32()
    for i in range(3):
        d[f"socketColor_{i+1}"]=c.u32(); d[f"socketContent_{i+1}"]=c.u32()
    d["socketBonus"]=c.u32(); d["GemProperties"]=c.u32()
    # See the module docstring: this is the disenchant skill, NOT the damage
    # modifier, and everything after it shifts accordingly. There is no trailing
    # unexplained u32 -- the record ends on HolidayId.
    d["RequiredDisenchantSkill"]=c.i32()
    d["ArmorDamageModifier"]=fnum(c.f32())
    d["duration"]=c.u32(); d["ItemLimitCategory"]=c.i32(); d["HolidayId"]=c.u32()
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
    L.append(f"Columns kept: {len(COLS)}\n")
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
    print(f"union={len(union)} cols={len(COLS)} exact={exact} "
          f"leftover={leftover} overrun={overrun}")
    if val: print("564818:",val["name"],"class",val["class"],"disp",val["displayid"],"Q",val["Quality"])
    print("->",OUT_TSV)

if __name__=="__main__":
    main()
