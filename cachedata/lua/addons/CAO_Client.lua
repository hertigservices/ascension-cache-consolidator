Ulocal t=AIO or require("AIO")if t.AddAddon()then
require("HybridScrollFrame")return
end
local e=1.27
local O=t.AddHandlers("CAO",{})local me=t.AddHandlers("SwitchSpec",{})local u=70
local S=UnitLevel("player")local Pe={["DRUID"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-druid-cover",["HUNTER"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-hunter-cover",["MAGE"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-mage-cover",["PALADIN"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-paladin-cover",["PRIEST"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-priest-cover",["ROGUE"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-rogue-cover",["SHAMAN"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-shaman-cover",["WARLOCK"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-warlock-cover",["WARRIOR"]="Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-warrior-cover",}local Z={["DRUID"]={["BALANCE"]={"DRU","CUSTOM"},["FERAL"]={"DRU","CUSTOM"},["RESTORATION"]={"DRU","CUSTOM"},},["HUNTER"]={["BEASTMASTERY"]={"Shol","LK"},["MARKSMANSHIP"]={"Shol","LK"},["SURVIVAL"]={"Shol","LK"},},["MAGE"]={["ARCANE"]={"DalaranTGA","LK"},["FIRE"]={"DalaranTGA","LK"},["FROST"]={"DalaranTGA","LK"},},["PALADIN"]={["HOLY"]={"PAL","CUSTOM"},["RETRIBUTION"]={"PAL","CUSTOM"},["PROTECTION"]={"PAL","CUSTOM"},},["PRIEST"]={["DISCIPLINE"]={"PRI","CUSTOM"},["HOLY"]={"PRI","CUSTOM"},["SHADOW"]={"PRI","CUSTOM"},},["ROGUE"]={["ASSASSINATION"]={"ROG","CUSTOM"},["COMBAT"]={"ROG","CUSTOM"},["SUBTLETY"]={"ROG","CUSTOM"},},["SHAMAN"]={["ELEMENTAL"]={"ItaiMysticFacade","LN"},["ENHANCEMENT"]={"ItaiMysticFacade","LN"},["RESTORATION"]={"ItaiMysticFacade","LN"},},["WARLOCK"]={["AFFLICTION"]={"Fel","LN"},["DEMONOLOGY"]={"Fel","LN"},["DESTRUCTION"]={"Fel","LN"},},["WARRIOR"]={["ARMS"]={"ID_TownTGA","LK"},["FURY"]={"ID_TownTGA","LK"},["PROTECTION"]={"ID_TownTGA","LK"},},["GENERAL"]={{{"Interface\\TalentFrame\\WarriorArms-TopLeft","Interface\\TalentFrame\\WarriorArms-TopRight","Interface\\TalentFrame\\WarriorArms-BottomLeft","Interface\\TalentFrame\\WarriorArms-BottomRight"},},{{"Interface\\TalentFrame\\WarriorFury-TopLeft","Interface\\TalentFrame\\WarriorFury-TopRight","Interface\\TalentFrame\\WarriorFury-BottomLeft","Interface\\TalentFrame\\WarriorFury-BottomRight"},},{{"Interface\\TalentFrame\\WarriorProtection-TopLeft","Interface\\TalentFrame\\WarriorProtection-TopRight","Interface\\TalentFrame\\WarriorProtection-BottomLeft","Interface\\TalentFrame\\WarriorProtection-BottomRight"},},},}local j={["WARRIOR"]={0,.25,0,.25},["MAGE"]={.25,.49609375,0,.25},["ROGUE"]={.49609375,.7421875,0,.25},["DRUID"]={.7421875,.98828125,0,.25},["HUNTER"]={0,.25,.25,.5},["SHAMAN"]={.25,.49609375,.25,.5},["PRIEST"]={.49609375,.7421875,.25,.5},["WARLOCK"]={.7421875,.98828125,.25,.5},["PALADIN"]={0,.25,.5,.75},["DEATHKNIGHT"]={.25,.49609375,.5,.75},};local e={["DRUID"]={1,.49,.04,1},["HUNTER"]={.67,.83,.45,1},["MAGE"]={.41,.8,.94,1},["PALADIN"]={.96,.55,.73,1},["PRIEST"]={1,1,1,1},["ROGUE"]={1,.96,.41,1},["SHAMAN"]={0,.44,.87,1},["WARLOCK"]={.58,.51,.79,1},["WARRIOR"]={.78,.61,.43,1},}local E={["WARRIOR"]={"ARMS","FURY","PROTECTION"},["DRUID"]={"BALANCE","FERAL","RESTORATION"},["PRIEST"]={"DISCIPLINE","HOLY","SHADOW"},["MAGE"]={"ARCANE","FIRE","FROST"},["HUNTER"]={"BEASTMASTERY","MARKSMANSHIP","SURVIVAL"},["PALADIN"]={"HOLY","PROTECTION","RETRIBUTION"},["ROGUE"]={"ASSASSINATION","COMBAT","SUBTLETY"},["WARLOCK"]={"AFFLICTION","DEMONOLOGY","DESTRUCTION"},["SHAMAN"]={"ELEMENTAL","ENHANCEMENT","RESTORATION"},}local e={["WARRIOR"]={["ARMS"]=12320,["FURY"]=1834,["PROTECTION"]=12298},["DRUID"]={["BALANCE"]=16821,["FERAL"]=5487,["RESTORATION"]=5185},["PRIEST"]={["DISCIPLINE"]=1243,["HOLY"]=635,["SHADOW"]=589},["MAGE"]={["ARCANE"]=1459,["FIRE"]=133,["FROST"]=116},["HUNTER"]={["BEASTMASTERY"]=965200,["MARKSMANSHIP"]=1510,["SURVIVAL"]=1495},["PALADIN"]={["HOLY"]=635,["PROTECTION"]=465,["RETRIBUTION"]=7294},["ROGUE"]={["ASSASSINATION"]=12320,["COMBAT"]=53,["SUBTLETY"]=1784},["WARLOCK"]={["AFFLICTION"]=6789,["DEMONOLOGY"]=5500,["DESTRUCTION"]=5740},["SHAMAN"]={["ELEMENTAL"]=403,["ENHANCEMENT"]=324,["RESTORATION"]=331},}local Q={}local H={}local ce=70;local ue=75;local de=35;local Be=75;local L={228,437}local X={-31,-89}local re=795
local U=30
local z=44
for n,t in pairs(e)do
for a,t in pairs(t)do
local o,o,t=GetSpellInfo(t)e[n][a]=t
end
end
local k=383080
local J=383081
local Ae=1101243
local Ge=1101245
local b={}local D={}local te=1101244
local ne={1101244,1111244,1121244,1131244,1141244,1151244,1161244,1171244,}local A=nil
local C=nil
local r=nil
local F=nil
local xe=1
local ge="Ability Essence: |cffFFFFFF%d|r"local we="Talent Essence: |cffFFFFFF%d|r"local g="Are you sure you want to learn \n|cff71d5ff|Hspell:%d|h[%s]|h|r?"local ke="Are you sure you want to |cffFF0000unlearn|r\n|cff71d5ff|Hspell:%d|h[%s]|h|r?\n\nUnlearn cost is:\n"local e="You have no spells or talents yet. You can choose a class at the top of the menu and then learn spells and abilities.\n\nYou can double click to learn"local e="Your stat points had been automatically allocated."local De="Your spells and talents have been automatically upgraded."local ae="Search Name or Description"IN_RM_MODE=false
IN_DRAFT_MODE=false
local _e=false
local y={[1]={"Interface\\AddOns\\AwAddons\\Textures\\misc\\spell_Paladin_divinecircle","You're free to choose any\nspells and talents you'd like.","|cffFFFFFFClassless|r"},[2]={"Interface\\Icons\\pvp_rune_random","You get random spells while leveling.\nYou can choose talents.","|cffFFFFFFWildcard Mode|r"},[3]={"Interface\\Icons\\inv_misc_dmc_destructiondeck","You get a list of 3 spells\nyou can choose from each 2 levels.\nYou can choose talents.","|cffFFFFFFDraft Mode|r"}}local ye={[1]="Craft your hero",[2]="Gain random abilities while leveling",[3]="Choose from 3 random abilities while leveling",}local M={[1]={"Specialization I",false,false},[2]={"Specialization II",false,false},[3]={"Specialization III",false,false},[4]={"Specialization IV",false,false},[5]={"Specialization V",false,false},[6]={"Specialization VI",false,false},[7]={"Specialization VII",false,false},[8]={"Specialization VIII",false,false},}local oe=false
GLOBAL_BC_MODE=1
GLOBAL_BC_CHOOSE_SPELL=false
GLOBAL_BC_CHOOSE_ENCHANT=false
local l={SpellButtons={},ArmorButtons={},EnchantButtons={},StatButtons={},}local V=68
local Ne="\n|cffFFFFFFAuthor's |cff00FF00tip|r|cffFFFFFF:|r"local Fe={1180,15590,196,198,201,200,227,197,199,202,264,5011,266,2567,5009,750,8737,9077,9078,9116,27763,27762,}local fe=#Fe
local he=19
local Y={{"Strength","Interface\\AddOns\\AwAddons\\Textures\\Allocation\\strength",1},{"Agility","Interface\\AddOns\\AwAddons\\Textures\\Allocation\\agility",3},{"Intellect","Interface\\AddOns\\AwAddons\\Textures\\Allocation\\intellect",4},{"Spirit","Interface\\AddOns\\AwAddons\\Textures\\Allocation\\spirit",5},}local Ue=1
local N=1
local le={[1]="Interface\\Icons\\achievement_bg_tophealer_soa",[100]="Interface\\Icons\\achievement_bg_tophealer_av",[1e3]="Interface\\Icons\\achievement_bg_tophealer_eos",}local I={}local P={}local B={}local ze=1e4
local v={[1]={9,0},}for e=1,9 do
v[e]={9,0}end
for e=10,u do
local t,n=unpack(v[e-1])v[e]={t+1,n+1}end
local a={}local R=nil
local Ce={}local ie={}local Xe=nil
local T=""local je=false
local x=false
local e=false
local e=false
local w=nil
local pe=nil
local e={}local se={}local d={}local n={}local h={}local c={}local i={}StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"]={button1="Learn",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_SPELL_UNLEARN_CONFIRM"]={button1="Unlearn",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_BC_ACTIVATE_CONFIRM"]={text="Are you sure you want to activate this build?\nIf you already have active build\nit will be deactivated.",button1="Activate",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_BC_DEACTIVATE_CONFIRM"]={text="Are you sure you want to deactivate this build?\nYou won't be able to automatically learn\nspells and talents from this build.",button1="Deactive",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_BC_EXISTINGBUILD"]={text="Do you wish to load your current build or you have a build link?",button1="Current Build",button2="Cancel",button3="Build Link",whileDead=true,timeout=0,hideOnEscape=true,OnAccept=function(e)BC_Editor_NewBuild()t.Handle("sideBar","GetMyBuildData")end,OnAlt=function(e)BC_Editor_NewBuild()StaticPopup_Show("ASC_LOADBUILDFROMLINK")end,}StaticPopupDialogs["ASC_BC_NEWBUILD"]={text="How would you like to make your build?",button1="Create Build",button2="Cancel",button3="Load Build",whileDead=true,timeout=0,hideOnEscape=true,OnAccept=function(e)BC_Editor_NewBuild()end,OnAlt=function(e)StaticPopup_Show("ASC_BC_EXISTINGBUILD")end,}StaticPopupDialogs["ASC_BC_SPECIAL"]={text="Edit this build or create new?",button1="Edit this build",button2="Create new",whileDead=true,timeout=0,hideOnEscape=true,OnAccept=function(e)x=true
BC_Editor_NewBuild()end,OnCancel=function(e)x=false
StaticPopup_Show("ASC_BC_NEWBUILD")end,}StaticPopupDialogs["ASC_ERROR"]={text="ERROR!",button1="Continue",button2="Cancel",whileDead=true,timeout=5,hideOnEscape=true,}StaticPopupDialogs["ASC_BC_ERROR"]={text="ERROR!",button1="Back to Editor",button2="Continue",whileDead=true,timeout=5,hideOnEscape=true,OnAccept=function(e)_G["CA2.HedaerTabsTab2"]:GetScript("OnClick")(_G["CA2.HedaerTabsTab2"])end,}StaticPopupDialogs["ASC_BC_LEAVE"]={text="Are you sure you want to quit build creator?",button1="Accept",button2="Cancel",whileDead=true,timeout=5,hideOnEscape=true,}StaticPopupDialogs["ASC_LINK_EDITBOX"]={text="Copy this link for further use",button1=ACCEPT,button2=CANCEL,whileDead=1,hasEditBox=1,hasWideEditBox=1,timeout=0,EditBoxOnEnterPressed=function(e,e)parent:Hide();end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,OnHide=function(e)e.wideEditBox:SetText("");end,hideOnEscape=1};StaticPopupDialogs["ASC_LINK_DIALOGUE"]={text="Do you wish to genereate your known build's link or link for a build you're working on?",button1="Known",button2="Cancel",button3="One I'm working on",whileDead=true,timeout=0,hideOnEscape=true,OnAccept=function()local e=":"for t,n in pairs(CAO_Known)do
local n=CAO_Talent_References[t]local a=CAO_Spells[t]if(n)then
local t=CAO_Talent_Ranks[t]e=e..n.."t"..t..":"else
e=e..t..":"end
end
if(e~=":")then
StaticPopupDialogs["ASC_LINK_EDITBOX"].OnShow=function(t)t.wideEditBox:SetText(e);end
StaticPopup_Show("ASC_LINK_EDITBOX")else
StaticPopupDialogs["ASC_ERROR"].text="No build data found"StaticPopup_Show("ASC_ERROR")end
end,OnAlt=function(e)local e=":"local a={}for t=1,u do
for n,t in pairs(n[t])do
if(t~=0)then
local n=CAO_Talent_References[t]local o=CAO_Spells[t]if(n)then
local e=CAO_Talent_Ranks[t]if not(a[n])then
a[n]=e
elseif(a[n]<e)then
a[n]=e
end
else
e=e..t..":"end
end
end
end
for n,t in pairs(a)do
e=e..n.."t"..t..":"end
if(e~=":")then
StaticPopupDialogs["ASC_LINK_EDITBOX"].OnShow=function(t)t.wideEditBox:SetText(e);end
StaticPopup_Show("ASC_LINK_EDITBOX")else
StaticPopupDialogs["ASC_ERROR"].text="No build data found"StaticPopup_Show("ASC_ERROR")end
end,}StaticPopupDialogs["ASC_RESET"]={text="ERROR!",button1=OKAY,button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_BC_SELECT"]={text="Choose spell or talent to add it to your build",button1=OKAY,whileDead=true,timeout=2,hideOnEscape=true,exclusive=1,}StaticPopupDialogs["ASC_BC_SELECT_ENCH"]={text="Choose Mystic Enchant to add it to your build",button1=OKAY,whileDead=true,timeout=2,hideOnEscape=true,exclusive=1,}StaticPopupDialogs["ASC_BUILDNAME_EDIT"]={text="Enter build name",button1=ACCEPT,button2=CANCEL,whileDead=1,hasEditBox=1,maxLetters=32,OnAccept=function(e)local e=e.editBox:GetText()if(e=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter build name"StaticPopup_Show("ASC_ERROR")return
end
CA2.BC.BuildNameText:SetText(e)end,timeout=0,EditBoxOnEnterPressed=function(e,t)local t=e:GetText()if(t=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter build name"StaticPopup_Show("ASC_ERROR")return
end
local e=e:GetParent();CA2.BC.BuildNameText:SetText(t)e:Hide();end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,OnHide=function(e)e.editBox:SetText("");end,OnShow=function(e)e.editBox:SetText(CA2.BC.BuildNameText:GetText());end,hideOnEscape=1};StaticPopupDialogs["ASC_BUILDSUBTEXT_EDIT"]={text="Enter build subtext",button1=ACCEPT,button2=CANCEL,whileDead=1,hasEditBox=1,hasWideEditBox=1,maxLetters=92,OnAccept=function(e)local e=e.wideEditBox:GetText()if(e=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter build subtext"StaticPopup_Show("ASC_ERROR")return
end
CA2.BC.BuildSubText:SetText(e)end,timeout=0,EditBoxOnEnterPressed=function(e,t)local t=e:GetText()if(t=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter build subtext"StaticPopup_Show("ASC_ERROR")return
end
local e=e:GetParent();CA2.BC.BuildSubText:SetText(t)e:Hide();end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,OnHide=function(e)e.wideEditBox:SetText("");end,OnShow=function(e)e.wideEditBox:SetText(CA2.BC.BuildSubText:GetText());end,hideOnEscape=1};StaticPopupDialogs["ASC_LOADBUILDFROMLINK"]={text="Enter build link",button1=ACCEPT,button2=CANCEL,whileDead=1,hasEditBox=1,hasWideEditBox=1,OnAccept=function(e)local e=e.wideEditBox:GetText()local e,t=LoadBuildFromLink(e)LoadBuildFromLink_BC(e,t)end,timeout=0,EditBoxOnEnterPressed=function(e,t)local t=e:GetText()local n,t=LoadBuildFromLink(t)LoadBuildFromLink_BC(n,t)local e=e:GetParent();e:Hide();end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,OnHide=function(e)e.wideEditBox:SetText("");end,hideOnEscape=1};StaticPopupDialogs["ASC_ADDTIP"]={text="Enter tip",button1=ACCEPT,button2=CANCEL,whileDead=1,hasEditBox=1,maxLetters=92,OnAccept=function(e)local e=e.editBox:GetText()if(e=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter tip"StaticPopup_Show("ASC_ERROR")return
end
CA2.BC.BuildNameText:SetText(e)end,timeout=0,EditBoxOnEnterPressed=function(e,t)local t=e:GetText()if(t=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter tip"StaticPopup_Show("ASC_ERROR")return
end
local e=e:GetParent();CA2.BC.BuildNameText:SetText(t)e:Hide();end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,OnHide=function(e)e.editBox:SetText("");end,hideOnEscape=1};CAO_Spells={}CAO_Talents={}CAO_Known={}if not(CAO_RankUpList)then
CAO_RankUpList={}end
local be={}local He={}local G={}CAO_Talent_References={}CAO_Talent_Ranks={}local m={}local o={}local s={}local p={}local f={}local K=false
local function W(e,n,o)if n>o then
return
end
local t=n
for a=n+1,o do
local o=GetSpellInfo(e[a][1])or""local n=GetSpellInfo(e[n][1])or""if(o<n)then
t=t+1
e[t],e[a]=e[a],e[t]end
end
e[t],e[n]=e[n],e[t]W(e,n,t-1)W(e,t+1,o)end
local function q(e,n,a)if n>a then
return
end
local t=n
for a=n+1,a do
if(e[a][2]<e[n][2])then
t=t+1
e[t],e[a]=e[a],e[t]end
end
e[t],e[n]=e[n],e[t]q(e,n,t-1)q(e,t+1,a)end
local function q(e,n,a)if n>a then
return
end
local t=n
for a=n+1,a do
if(e[a][4]>e[n][4])then
t=t+1
e[t],e[a]=e[a],e[t]end
end
e[t],e[n]=e[n],e[t]q(e,n,t-1)q(e,t+1,a)end
local function ee(e,n,o)if n>o then
return
end
local t=n
for a=n+1,o do
local o=CAO_Talent_Ranks[e[a]]or 1
local n=CAO_Talent_Ranks[e[n]]or 1
if(o<n)then
t=t+1
e[t],e[a]=e[a],e[t]end
end
e[t],e[n]=e[n],e[t]ee(e,n,t-1)ee(e,t+1,o)end
function GetProperScrollOfFortune(t)local e=nil
e=ne[t]if not(e)then
e=te
end
return e
end
local function ne()local e=Ae
local t=0
if(IN_RM_MODE)then
e=GetProperScrollOfFortune(xe)end
name,_,_,_,_,_,_,_,_,texture=GetItemInfo(e)t=GetItemCount(e)if not(name)then
if(IN_RM_MODE)then
name="Scroll of Fortune"texture="Interface\\Icons\\inv_custom_scrollofunlearning_seasonal"else
name="Scroll of Unlearning"texture="Interface\\Icons\\inv_custom_scrollofunlearning"end
end
CA2.Currency.ScrollButton.Item=e
CA2.Currency.ScrollButton.Icon:SetTexture(texture)CA2.Currency.ScrollButton.Text:SetText(name..": |cffFFFFFF"..t.."|r")end
local function Ke(a)local n={CA2.BC.BlockR.TextFirst,CA2.BC.BlockR.TextMain}local o=CA2.BC.BlockR.TextFirst_Hack
local t={}local e={"",""}for e in string.gmatch(a,"%S+")do
t[#t+1]=e
end
for r,a in next,t do
n[1]:SetText(e[1].." "..a)o:SetText(e[1].." "..a)local l=n[1]:GetHeight()local n=o:GetStringHeight()if(l<n)then
break
end
e[1]=e[1].." "..a
t[r]=nil
end
n[1]:SetText(e[1])for a,o in next,t do
e[2]=e[2].." "..o
t[a]=nil
end
n[2]:SetText(e[2])end
function CA_GetSpellInfo(e)local o=CAO_Talent_References[e]local e=CAO_Spells[e]local t=0
local n=0
local a=0
if(e)then
t=e[2]n=e[3]a=e[4]elseif(o)then
e=CAO_Talents[o]t=e[3]n=e[4]a=e[5]else
return false
end
return t,n,a
end
local function Oe(n)local a=D[n]local e=""local t=""if(a)then
e=a[1]t=a[2]else
e=GetSpellInfo(n)t=GetSpellDescription(n)e=e or""t=t or""e=e:lower()t=t:lower()D[n]={e,t}end
return e,t
end
function LoadBuildFromLink(e)if not(e)then
e=""end
local l={}local o={}TrainingFrame_model:Hide()TrainingFrame_model2:Hide()local t,n,r,a
t,n,r=string.find(e,":(%d+):")while t do
t,n,r=string.find(e,":(%d+):")if(t)then
table.insert(l,tonumber(r))e=string.sub(e,1,t-1)..string.sub(e,n)end
end
t,n,a=string.find(e,":(%d+t%d+):")while t do
t,n,a=string.find(e,":(%d+t%d+):")if(t)then
local r,i,l=string.find(a,"(t%d+)")local r=tonumber(string.sub(a,1,r-1))local a=tonumber(string.sub(l,2,-1))table.insert(o,{r,a})e=string.sub(e,1,t-1)..string.sub(e,n)end
end
if(#l>0)or(#o>0)then
return l,o
else
StaticPopupDialogs["ASC_ERROR"].text="No proper build data found."StaticPopup_Show("ASC_ERROR")end
return false
end
local function ee(e)return math.floor((e-2)/2)*3
end
local function D(t)for n,e in pairs(t)do
e:Hide()e=nil
t[n]=nil
end
end
local function Ie(e)CA2.BC.DescriptionFrame:Hide()for t,e in pairs(e)do
D(e)end
end
local function Ae(e,t,n)if not(s[e])then
s[e]={}end
s[e][n]=t
end
local function Se(n,e,t)t=((t-1)*145)+de;e=-((e-1)*52)-Be;n:SetPoint("TOPLEFT",n:GetParent(),"TOPLEFT",t,e);end
local function Be(n,e,t)t=((t-1)*71)+(ce);e=-((e-1)*47)-ue;n:SetPoint("TOPLEFT",n:GetParent(),"TOPLEFT",t,e);end
function SpellButtonOnDrag(e)if(IsModifiedClick("PICKUPACTION"))and(CAO_Known[e.Spell]==1)then
local e=GetSpellInfo(e.Spell)if(e)then
DropDownList1:Hide()PickupSpell(e)end
return
end
end
local function de(e,t)if(IsModifiedClick("CHATLINK"))then
if(e.Spell)then
local t=GetSpellInfo(e.Spell)local e="|cff71d5ff|Hspell:"..e.Spell.."|h["..t.."]|h|r"if(e)then
ChatEdit_InsertLink(e);return true
end
end
return;end
if(IsModifiedClick("PICKUPACTION"))and(CAO_Known[e.Spell]==1)then
SpellButtonOnDrag(e)return;end
end
local function Ve(e,t)CA2.Art.Art1:Show()CA2.Art.Art2:Show()CA2.Art.Art3:Show()CA2.Art.Art4:Show()CA2.Art.Art5:Show()CA2.Art.Art6:Show()CA2.Art.Art7:Show()CA2.Art.Art8:Show()CA2.Art.Art_Sec1:Show()CA2.Art.Art_Sec2:Show()CA2.Art.Art_Sec3:Show()CA2.Art.Art_Sec4:Show()CA2.Art.Art_Sec5:Show()CA2.Art.Art_Sec6:Show()CA2.Art.Art_Sec7:Show()CA2.Art.Art_Sec8:Show()if(t=="LN")then
CA2.Art.Art1:SetBlendMode("MOD")CA2.Art.Art2:SetBlendMode("MOD")CA2.Art.Art3:SetBlendMode("MOD")CA2.Art.Art4:SetBlendMode("MOD")CA2.Art.Art5:SetBlendMode("MOD")CA2.Art.Art6:SetBlendMode("MOD")CA2.Art.Art7:SetBlendMode("MOD")CA2.Art.Art8:SetBlendMode("MOD")CA2.Art.Art1:SetAlpha(1)CA2.Art.Art2:SetAlpha(1)CA2.Art.Art4:SetAlpha(1)CA2.Art.Art5:SetAlpha(1)CA2.Art.Art6:SetAlpha(1)CA2.Art.Art8:SetAlpha(1)CA2.Art.Art3:SetAlpha(.3)CA2.Art.Art7:SetAlpha(.3)CA2.Art.Art_Sec3:SetAlpha(.3)CA2.Art.Art_Sec7:SetAlpha(.3)CA2.Art.Art1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."3")CA2.Art.Art2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."2")CA2.Art.Art3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."1")CA2.Art.Art4:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."4")CA2.Art.Art5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."7")CA2.Art.Art6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."6")CA2.Art.Art7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."5")CA2.Art.Art8:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."8")CA2.Art.Art_Sec1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."3")CA2.Art.Art_Sec2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."2")CA2.Art.Art_Sec3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."1")CA2.Art.Art_Sec4:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."4")CA2.Art.Art_Sec5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."7")CA2.Art.Art_Sec6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."6")CA2.Art.Art_Sec7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."5")CA2.Art.Art_Sec8:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."8")elseif(t=="CUSTOM")then
CA2.Art.Art1:SetBlendMode("BLEND")CA2.Art.Art2:SetBlendMode("BLEND")CA2.Art.Art3:SetBlendMode("BLEND")CA2.Art.Art4:SetBlendMode("BLEND")CA2.Art.Art5:SetBlendMode("BLEND")CA2.Art.Art6:SetBlendMode("BLEND")CA2.Art.Art7:SetBlendMode("BLEND")CA2.Art.Art8:SetBlendMode("BLEND")CA2.Art.Art1:SetAlpha(.9)CA2.Art.Art2:SetAlpha(.9)CA2.Art.Art4:SetAlpha(.9)CA2.Art.Art5:SetAlpha(.9)CA2.Art.Art6:SetAlpha(.9)CA2.Art.Art8:SetAlpha(.9)CA2.Art.Art3:SetAlpha(.1)CA2.Art.Art7:SetAlpha(.1)CA2.Art.Art1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."3")CA2.Art.Art2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."2")CA2.Art.Art3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."1")CA2.Art.Art4:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."4")CA2.Art.Art5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."7")CA2.Art.Art6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."6")CA2.Art.Art7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."5")CA2.Art.Art8:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."8")CA2.Art.Art_Sec1:Hide()CA2.Art.Art_Sec2:Hide()CA2.Art.Art_Sec5:Hide()CA2.Art.Art_Sec6:Hide()CA2.Art.Art_Sec3:Hide()CA2.Art.Art_Sec4:Hide()CA2.Art.Art_Sec7:Hide()CA2.Art.Art_Sec8:Hide()elseif(t=="LK")then
CA2.Art.Art1:SetBlendMode("BLEND")CA2.Art.Art2:SetBlendMode("BLEND")CA2.Art.Art3:SetBlendMode("BLEND")CA2.Art.Art4:SetBlendMode("BLEND")CA2.Art.Art5:SetBlendMode("BLEND")CA2.Art.Art6:SetBlendMode("BLEND")CA2.Art.Art7:SetBlendMode("BLEND")CA2.Art.Art8:SetBlendMode("BLEND")CA2.Art.Art1:SetAlpha(.7)CA2.Art.Art2:SetAlpha(.7)CA2.Art.Art4:SetAlpha(.7)CA2.Art.Art5:SetAlpha(.7)CA2.Art.Art6:SetAlpha(.7)CA2.Art.Art8:SetAlpha(.7)CA2.Art.Art3:SetAlpha(.1)CA2.Art.Art7:SetAlpha(.1)CA2.Art.Art1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."4")CA2.Art.Art2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."3")CA2.Art.Art5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."8")CA2.Art.Art6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."7")CA2.Art.Art3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."2")CA2.Art.Art7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\"..e.."6")CA2.Art.Art4:Hide()CA2.Art.Art8:Hide()CA2.Art.Art_Sec1:Hide()CA2.Art.Art_Sec2:Hide()CA2.Art.Art_Sec5:Hide()CA2.Art.Art_Sec6:Hide()CA2.Art.Art_Sec3:Hide()CA2.Art.Art_Sec4:Hide()CA2.Art.Art_Sec7:Hide()CA2.Art.Art_Sec8:Hide()end
end
function DisableAutoCastAll()local n=nil
for o,e in pairs(H)do
local t=nil
if not(e.SpellIcon)then
t=e.ActionButton:GetName()else
t=e.SpellIcon.ActionButton:GetName()end
local a=_G[t.."Shine"]local t=_G[t.."AutoCastable"];t:Hide()AutoCastShine_AutoCastStop(a);H[o]=nil
if not(e.SpellIcon)then
n=e
end
end
return n
end
function EnableAutoCast(e)DisableAutoCastAll()local e=e.Spell
if(s[e])then
for e,t in pairs(s[e])do
local e=nil
if not(t.SpellIcon)then
e=t.ActionButton:GetName()else
e=t.SpellIcon.ActionButton:GetName()end
local r=_G[e.."Shine"]local e=_G[e.."AutoCastable"];e:SetDrawLayer("ARTWORK")local a=.95;local o=.95;local n=.32;e:Show()AutoCastShine_AutoCastStart(r,a,o,n);table.insert(H,t)end
end
end
local function ue(e,t)if(CAO_RankUpList[t])then
e.ActionButton.RankUpFrame:Show()else
e.ActionButton.RankUpFrame:Hide()end
end
local function Me(e,n)if(A)then
if(n)then
t.Handle("CAO","LearnThisSpell",A)else
local e=GetSpellInfo(A)StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].text=string.format(g,A,e)StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].OnAccept=function()t.Handle("CAO","LearnThisSpell",A)end
StaticPopup_Show("ASC_SPELL_LEARN_CONFIRM")end
elseif(C)then
local e=CAO_Talents[C][2][1]local a=CAO_Talents[C][3]if(a>0)then
if(n)then
t.Handle("CAO","LearnThisTalent",C)else
local n=GetSpellInfo(e)StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].text=string.format(g,e,n)StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].OnAccept=function()t.Handle("CAO","LearnThisTalent",C)end
StaticPopup_Show("ASC_SPELL_LEARN_CONFIRM")end
else
t.Handle("CAO","LearnThisTalent",C)end
end
end
local function Ye(e)if(A)then
t.Handle("CAO","RequestUnlearnCostSpell",A)elseif(C)then
t.Handle("CAO","RequestUnlearnCostTalent",C)end
end
local function Te(e)local t=CAO_Talent_References[e]local n=CAO_Spells[e]if(((A==e)and(A~=nil))or((C==t)and(C~=nil)))and(DropDownList1:IsVisible())and SelectedSpellDropDown.CanLearn then
Me(nil)return
end
end
function ReturnClassDataBySpellID(t)local e=m[t][1]local n=m[t][2]local t=1
for a=1,#E[e]do
if(E[e][a]==n)then
break
end
t=t+1
end
return{e,n,t}end
local function H(a)local e=1
local l=0
local n=0
if(o[r])then
if(o[r][F])then
for n,t in pairs(o[r][F])do
local n=t[5]/5
if(n>=e)and(t[1]~=a)then
HighestTierTalent=t[1]e=n
end
end
end
end
if(o[r])then
if(o[r][F])then
for o,t in pairs(o[r][F])do
local o=t[5]/5
if(o<e)and(t[1]~=a)then
n=n+t[3]*t[4]end
end
end
end
l=ee(e)if(n<l)then
return false
end
return true
end
local function _(n,l)local a=1
local t=0
local e=0
local n,r=unpack(ReturnClassDataBySpellID(n))if(o[n])then
if(o[n][r])then
for n,t in pairs(o[n][r])do
e=e+t[3]*t[4]end
end
end
a=l/5
t=ee(a)if(e<t)then
return t
end
return
end
local function We(e)if not(e)or not(e.Spell)then
return
end
local r=e.Spell
local C=S
local c=GetItemCount(k)local A=GetItemCount(J)local t=0
local o=0
local n=0
local e=GetLocalization(CLIENTEXTRABUTTONS_COST)local a=GetLocalization(CLIENTEXTRABUTTONS_REQUIRESLEVEL)local i="Requires |cffFF0000%d|r "..CLIENTEXTRABUTTONS_TETIP["enUS"].." in tree"local l=CAO_Talent_References[r]t,o,n=CA_GetSpellInfo(r)if not(t)then
return false
end
if(n>C)then
a=a.."|cffFF0000"..n
else
a=a.."|cff00FF00"..n
end
if(t~=0)then
if(t<=c)then
e=e.." |cff00FF00"..t.."|r"..CLIENTEXTRABUTTONS_AETIP["enUS"]else
e=e.." |cffFF0000"..t.."|r"..CLIENTEXTRABUTTONS_AETIP["enUS"]end
end
if(o~=0)then
if(o<=A)then
e=e.." |cff00FF00"..o.."|r"..CLIENTEXTRABUTTONS_TETIP["enUS"]else
e=e.." |cffFF0000"..o.."|r"..CLIENTEXTRABUTTONS_TETIP["enUS"]end
end
if(n>15)and(l)and(K)then
local e=_(r,n)if(e)then
GameTooltip:AddLine(string.format(i,e))end
end
GameTooltip:AddLine(e)GameTooltip:AddLine(a)if(CAO_Known[r]==2)then
GameTooltip:AddLine("|cff00FF00This is your skill card spell.|r")end
GameTooltip:Show()end
local function g(t,i)PlaySound("igMainMenuOptionCheckBoxOn");local S=S
local d=GetItemCount(k)local u=GetItemCount(J)local r=0
local c=0
local a=0
local B=false
local n=true
local l=false
local o=CAO_Talent_References[t]local e=CAO_Spells[t]if(e)then
r=e[2]c=e[3]a=e[4]A=t
C=nil
elseif(o)then
e=CAO_Talents[o]r=e[3]c=e[4]a=e[5]A=nil
C=o
end
if(o)then
local r=e[1]local o=e[2]local e=0
if(CAO_Known[t])then
for n,a in pairs(o)do
if(a==t)then
e=n
end
end
end
if(e>=r)then
n=false
end
if(e>=1)then
l=true
end
if(K)then
if(a>15)then
if(_(t,a))then
n=false
end
end
if not(H(t))then
l=false
end
end
else
if(CAO_Known[t])then
B=true
n=false
l=true
end
end
SelectedSpellDropDown.SpellId=t
if(a>S)then
n=false
end
if(r>d)then
n=false
end
if(c>u)then
n=false
end
if(GetItemCount(Ge)>0)and IN_RM_MODE and(r==3)and _e then
n=true
end
SelectedSpellDropDown.CanLearn=n
SelectedSpellDropDown.CanUnlearn=l
if(i)then
EnableAutoCast(i)end
if(CA2.CharacterAdvancementMain:IsVisible())then
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,SelectedSpellDropDown,i:GetName(),0,-5);end
end
local function ce(e,t)local t=SPELL_QUALITY_TABLE[t]local t,n,a=GetItemQualityColor(t)_G[e:GetName().."Slot"]:Hide()if e.KnownBorder then
e.KnownBorder:SetVertexColor(t,n,a)e.KnownBorderAdd:SetVertexColor(t,n,a)end
e.QualityBorder:SetVertexColor(t,n,a)e.QualityBorderAdd:SetVertexColor(t,n,a)e.QualityBorder:Show()e.QualityBorderAdd:Show()end
local function Le(e)local t=e:GetName()SetItemButtonDesaturated(e,0,1,1,1)_G[t.."RankBorder"]:SetDesaturated(false)e.AbilityBorder:SetVertexColor(1,1,1)e.AbilityBorder:SetDesaturated(false)e.AbilityBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\TalentAbility")_G[t.."Slot"]:Show()_G[t.."Rank"]:Show()_G[t.."RankBorder"]:Show()e.KnownBorder:SetVertexColor(1,1,1)e.KnownBorder:Hide()e.KnownBorderAdd:Hide()e.AbilityBorder:Hide()e.QualityBorder:Hide()e.QualityBorderAdd:Hide()end
local function Ee(t)local e=t:GetName()SetItemButtonDesaturated(t,1,.65,.65,.65)t.AbilityBorder:SetDesaturated(true)_G[e.."RankBorder"]:SetDesaturated(true)_G[e.."Slot"]:SetVertexColor(.5,.5,.5)_G[e.."Rank"]:SetVertexColor(.5,.5,.5)end
local function Ge(e)local t=e:GetName()SetItemButtonDesaturated(e,0,1,0,0);e.AbilityBorder:SetDesaturated(false)e.AbilityBorder:SetVertexColor(1,0,0)_G[t.."RankBorder"]:SetDesaturated(false)_G[t.."RankBorder"]:SetVertexColor(1,0,0)_G[t.."Rank"]:SetVertexColor(1,0,0)_G[t.."Slot"]:SetVertexColor(1,0,0)end
local function ee(e)local e=e:GetName()_G[e.."Slot"]:SetVertexColor(0,1,0)_G[e.."RankBorder"]:SetVertexColor(0,1,0)_G[e.."Rank"]:SetVertexColor(0,1,0)end
local function H(t)local e=t:GetName()t.KnownBorder:Show()t.AbilityBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Tree_MainIcon")_G[e.."Slot"]:SetVertexColor(1,.82,0)_G[e.."RankBorder"]:SetVertexColor(1,.82,0)_G[e.."Rank"]:SetVertexColor(1,.82,0)end
local function te(t)local e=t:GetName()_G[e.."Slot"]:Hide()_G[e.."Rank"]:Hide()_G[e.."RankBorder"]:Hide()t.AbilityBorder:Show()end
local function Re(n,e,t)local i=S
local a=0
for e=1,z do
_G["CA2.CharacterAdvancementMain.Main.Tree"..t..".Content.Talents.Button"..e]:Hide()end
for n,e in pairs(f[n][e])do
local e=CAO_Talents[e]local n=e[1]local n=e[2]local c=e[3]local o=e[4]local o=e[5]local l=e[6]local r=e[7]local e,e,A=GetSpellInfo(n[1])local e=(((o-10)/5)*4)+l
local e=_G["CA2.CharacterAdvancementMain.Main.Tree"..t..".Content.Talents.Button"..e]local l=e:GetName()local t=0
for n,e in pairs(n)do
if(CAO_Known[e])then
t=n
end
end
if(t>0)then
a=a+1
end
e.Talent=r
e.Spell=n[t]Le(e)_G[l.."IconTexture"]:SetTexture(A)_G[l.."Rank"]:SetText(t.."/"..(#n))if(t==0)then
e.Spell=n[1]Ee(e)end
if(i<o)or(K and _(e.Spell,o))then
Ge(e)end
if(t>0)and(t<#n)then
ee(e)elseif(t==#n)then
H(e)end
if(c>0)then
te(e)end
ue(e,e.Spell)if(SPELL_QUALITY_TABLE[e.Spell])and IN_DRAFT_MODE then
ce(e,e.Spell)e.AbilityBorder:Hide()if(t==#n)then
e.KnownBorderAdd:Show()end
end
Ae(e.Spell,e,2)e:Show()if(C==r)then
g(e.Spell,e)end
end
return a
end
local function H(e)local t=e:GetName()_G[t..".SpellName"]:SetFontObject(GameFontDisable)_G[t..".SpellName"]:SetAlpha(1)SetItemButtonDesaturated(e,0,1,0,0)end
local function ee(e,n,o,a)local t=e:GetName()e.Spell=n
Ae(n,e,2)_G[t.."IconTexture"]:SetTexture(o)_G[t..".SpellName"]:SetText(a)_G[t..".SpellName"]:SetAlpha(1)_G[t..".SpellName"]:SetFontObject(GameFontNormal)_G[e:GetName().."Slot"]:Show()SetItemButtonDesaturated(e,1,.65,.65,.65);e.KnownBorder:SetVertexColor(1,1,1)e.KnownBorder:Hide()e.KnownBorderAdd:Hide()e:Show()e.QualityBorder:Hide()e.QualityBorderAdd:Hide()end
local function _(t)local e=t:GetName()_G[e..".SpellName"]:SetFontObject(GameFontHighlight)SetItemButtonDesaturated(t,0,1,1,1)_G[e].KnownBorder:Show()end
local function ve(t,o,a)local r=S
local n=0
for e=1,U do
_G["CA2.CharacterAdvancementMain.Main.Tree"..a..".Content.Spells.Button"..e]:Hide()end
local e=0
for o,t in pairs(p[t][o])do
e=o
local t=CAO_Spells[t]local e=t[1]local l=t[2]local l=t[3]local l=t[4]local t=_G["CA2.CharacterAdvancementMain.Main.Tree"..a..".Content.Spells.Button"..o]local i,a,o=GetSpellInfo(e)local a=false
if(CAO_Known[e])then
a=true
n=n+1
end
ee(t,e,o,i)if(a)then
_(t)end
if(r<l)then
H(t)end
if(A==e)then
g(e,t)end
if(SPELL_QUALITY_TABLE[e])and IN_DRAFT_MODE then
ce(t,e)if(a)then
t.KnownBorderAdd:Show()end
end
ue(t,e)end
return n
end
local function Le()t.Handle("CAO","GetAll")end
local function Ge()t.Handle("CAO","GetKnown")end
local function Ee()local e=1
if(r)then
for t=1,#E[r]do
local n=E[r][t]local t=0
if(o[r])then
if(o[r][n])then
t=o[r][n]end
end
if(t==0)then
_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Tab.TotalSpellsFrame"]:Hide()else
_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Tab.TotalSpellsFrame.Total"]:SetText(#t)_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Tab.TotalSpellsFrame"]:Show()end
e=e+1
end
end
end
local function te()C=nil
A=nil
DisableAutoCastAll()CloseDropDownMenus()end
local function H(e)local t=e.SpecNum
local e=e.Spec
if not(t)or not(e)then
return false
end
_G["CA2CharacterAdvancementMainMainTree1Content"]:Hide()_G["CA2CharacterAdvancementMainMainTree2Content"]:Hide()_G["CA2CharacterAdvancementMainMainTree3Content"]:Hide()_G["CA2.CharacterAdvancementMain.Main.Tree1.Tab"]:SetChecked(false)_G["CA2.CharacterAdvancementMain.Main.Tree2.Tab"]:SetChecked(false)_G["CA2.CharacterAdvancementMain.Main.Tree3.Tab"]:SetChecked(false)_G["CA2CharacterAdvancementMainMainTree"..t.."Content"]:Show()_G["CA2.CharacterAdvancementMain.Main.Tree"..t..".Tab"]:SetChecked(true)Ve(Z[r][e][1],Z[r][e][2])te()F=e
end
local function _(t,...)local l=false
local e=t
if(t.Class)then
e=t.Class
end
for t,e in pairs(b)do
if e:GetChecked()then
e:SetChecked(false)end
end
b[e]:SetChecked(true)CA2.Art.ClassTexture:SetTexture(Pe[e])if(e~=r)then
r=e
l=true
end
if not(next(p))then
return
end
local a=1
local t=nil
local o=CA2.CharacterAdvancementMain.Main.Tree1.Tab
for n=1,#E[e]do
t=E[e][n]_G["CA2.CharacterAdvancementMain.Main.Tree"..n..".Tab"].SpecNum=n
_G["CA2.CharacterAdvancementMain.Main.Tree"..n..".Tab"].Spec=t
if(F==t)and not(l)then
o=_G["CA2.CharacterAdvancementMain.Main.Tree"..n..".Tab"]end
_G["CA2.CharacterAdvancementMain.Main.Tree"..n..".Tab"]:SetText(string.match(Q[e][t],"^..........(%S+) "))ve(e,t,a)Re(e,t,a)Ee()a=a+1
end
H(o)end
local function Qe(e)local t,n,a=unpack(ReturnClassDataBySpellID(e.Spell))if(r~=t)then
_(t)end
if(F~=n)then
H(_G["CA2.CharacterAdvancementMain.Main.Tree"..a..".Tab"])end
g(e.Spell,e)end
local function e()CA2.SpecList:Hide()CA2.Scroll_SpecList:Hide()end
local function ee()CA2.SpecList:Show()CA2.Scroll_SpecList:Show()t.Handle("SwitchSpec","RequestSpecs")end
local function Z()if(CA2.HSKnown.Content:IsVisible())then
CA2.HSKnown:Hide()ee()end
if CA2.HSBuilds.Content and(CA2.HSBuilds.Content:IsVisible())then
CA2.HSBuilds:Hide()ee()end
end
local function E()CA2.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\CAO_BC_BG")CA2.CharacterAdvancementMain:Hide()CA2.Art:Hide()e()CA2.HSKnown:Hide()CA2.HSBuilds:Show()CA2.SearchBox_Builds:Show()CA2.SearchBox:Hide()CA2.BC:Show()if(GLOBAL_BC_MODE~=3)then
BC_RequestBuildInfo()end
end
local function Pe()CA2.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\CAO_Rework_2_BG")CA2.CharacterAdvancementMain:Show()CA2.Art:Show()CA2.HSBuilds:Hide()e()CA2.HSKnown:Show()CA2.SearchBox_Builds:Hide()CA2.SearchBox:Show()CA2.BC:Hide()end
local function F()if(CA2.HedaerTabs.activeTab==1)then
Pe()elseif(CA2.HedaerTabs.activeTab==2)then
E()elseif(CA2.HedaerTabs.activeTab==3)then
Z()end
end
local function Ve(e)if not(next(CAO_Spells))then
Le()end
if not(e.Init)then
_(CA2CharacterAdvancementMainClassButton1)e.Init=true
end
HideCards()end
local function Z(t)local e=b[t]local e=e:GetName()local n=_G[e.."TotalSpellsFrame"]local a=_G[e.."TotalSpellsFrameTotal"]local e=0
if(o[t])then
for n,t in pairs(o[t])do
e=e+#t
end
end
if(e>0)then
n:Show()a:SetText(e)else
n:Hide()end
end
local function Pe(n)local t={}local e={}for a=1,#n do
if(n[a][3]==0)then
table.insert(t,n[a])else
table.insert(e,n[a])end
end
if next(t)then
W(t,1,#t)end
if next(e)then
W(e,1,#e)end
local t={unpack(t)}if next(e)then
for n=1,#e do
table.insert(t,e[n])end
end
return t
end
local function E()local a=0
G=Pe(G)o={}DisableAutoCastAll()for e,t in pairs(s)do
s[e][1]=nil
end
for t,e in pairs(G)do
local t=e[1]local C=e[2]local i=e[3]local l=e[4]local r=e[5]if(m[t])then
local e=m[t][1]local n=m[t][2]if not(o[e])then
o[e]={}end
if not(o[e][n])then
o[e][n]={}end
table.insert(o[e][n],{t,C,i,r,l})end
a=a+1
end
for e,t in pairs(b)do
Z(e)end
if(C)then
local e=CAO_Talents[C][2][1]Re(unpack(ReturnClassDataBySpellID(e)))elseif(A)then
ve(unpack(ReturnClassDataBySpellID(A)))elseif(r)then
_(b[r])else
_(CA2CharacterAdvancementMainClassButton1)end
if not(CA2.HSKnown.Content)then
CA2.HSKnown.Init()else
CA2.HSKnown.LoadData()CA2.HSKnown.RefreshLayout()end
CA2.LoadingFrame:Hide()if(GLOBAL_BC_MODE==2)then
RefreshPassData()end
Ee()end
function CAO_LoadQuality()E()end
local function A(e)if(e.Spell)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:SetHyperlink("|Hspell:"..e.Spell.."|h[test]|h")We(e)GameTooltip:Show()end
end
local function W(e,t)_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Spells.Button"..t]=CreateFrame("Button","CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Spells.Button"..t,_G["CA2CharacterAdvancementMainMainTree"..e.."ContentSpells"],"TalentButtonTemplate")local e=_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Spells.Button"..t]local t=e:GetName()local n=_G[t.."Slot"]:GetTexture()e:SetScale(1)_G[t.."IconTexture"]:SetTexture("Interface\\Icons\\inv_misc_book_09")_G[t.."RankBorder"]:Hide()_G[t.."Slot"]:SetTexture("Interface\\Spellbook\\UI-Spellbook-SpellBackground")_G[t.."Slot"]:SetPoint("CENTER",10,-11)e:SetScript("OnClick",function(t)de(t)if(GLOBAL_BC_CHOOSE_SPELL)then
HandleSpellAddToBuildCreator(t.Spell)return
end
Te(t.Spell)g(t.Spell,e)end)e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",SpellButtonOnDrag)e:SetScript("OnEnter",A)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:SetScale(.9)e.SpellName=e:CreateFontString(t..".SpellName")e.SpellName:SetFontObject(GameFontNormal)e.SpellName:SetFont("Fonts\\FRIZQT__.TTF",12)e.SpellName:SetPoint("LEFT",42,0)e.SpellName:SetText("Spell Name Goes Test Lol Example Here")e.SpellName:SetJustifyH("LEFT")e.SpellName:SetSize(90,70)e.BG=e:CreateTexture(t..".BG","BACKGROUND")e.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\SpellBG")e.BG:SetSize(256,64)e.BG:SetPoint("RIGHT",206,0)e.KnownBorder=e:CreateTexture(t..".KnownBorder","ARTWORK")e.KnownBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Known_Highlight")e.KnownBorder:SetSize(85,85)e.KnownBorder:SetPoint("CENTER",0,0)e.KnownBorder:SetBlendMode("ADD")e.KnownBorderAdd=e:CreateTexture(t..".KnownBorderAdd","ARTWORK")e.KnownBorderAdd:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Known_Highlight")e.KnownBorderAdd:SetSize(85,85)e.KnownBorderAdd:SetPoint("CENTER",0,0)e.KnownBorderAdd:SetBlendMode("ADD")e.KnownBorderAdd:Hide()e.QualityBorder=e:CreateTexture(t..".QualityBorder","BACKGROUND")e.QualityBorder:SetTexture(n)e.QualityBorder:SetSize(_G[t.."Slot"]:GetSize())e.QualityBorder:SetPoint("CENTER",0,-1)e.QualityBorder:Hide()e.QualityBorderAdd=e:CreateTexture(t..".QualityBorderAdd","ARTWORK")e.QualityBorderAdd:SetTexture(n)e.QualityBorderAdd:SetSize(_G[t.."Slot"]:GetSize())e.QualityBorderAdd:SetPoint("CENTER",0,-1)e.QualityBorderAdd:SetBlendMode("ADD")e.QualityBorderAdd:Hide()e.ActionButton=CreateFrame("Button",t..".ActionButton",e,"ActionButtonTemplate")e.ActionButton:SetPoint("CENTER")e.ActionButton:SetSize(64,64)e.ActionButton:EnableMouse(false)e.ActionButton:Disable()_G[t..".ActionButtonAutoCastable"]=e.ActionButton:CreateTexture(t..".ActionButtonAutoCastable","OVERLAY")_G[t..".ActionButtonAutoCastable"]:SetTexture("Interface\\Buttons\\UI-AutoCastableOverlay")_G[t..".ActionButtonAutoCastable"]:Hide()_G[t..".ActionButtonAutoCastable"]:SetSize(58,58)_G[t..".ActionButtonAutoCastable"]:SetPoint("CENTER",0,0)_G[t..".ActionButtonNormalTexture"]:Hide()_G[t..".ActionButtonShine"]=CreateFrame("FRAME",t..".ActionButtonShine",e.ActionButton,"AutoCastShineTemplate")_G[t..".ActionButtonShine"]:SetPoint("CENTER",0,0)_G[t..".ActionButtonShine"]:SetSize(28,28)e.ActionButton.RankUpFrame=CreateFrame("BUTTON",t..".ActionButton.RankUpFrame",e,nil)e.ActionButton.RankUpFrame:SetPoint("BOTTOMRIGHT",12,-6)e.ActionButton.RankUpFrame:SetSize(24,24)e.ActionButton.RankUpFrame:EnableMouse(true)e.ActionButton.RankUpFrame:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")e.ActionButton.RankUpFrame:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")e.ActionButton.RankUpFrame:SetScript("OnLeave",function()GameTooltip:Hide()end)e.ActionButton.RankUpFrame:SetScript("OnEnter",function(t)GameTooltip:SetOwner(t,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFF"..e.SpellName:GetText().."|r is ready to rank up!")GameTooltip:Show()end)e.ActionButton.RankUpFrame.AnimG=e.ActionButton.RankUpFrame:CreateAnimationGroup()e.ActionButton.RankUpFrame.AnimG.Translation0=e.ActionButton.RankUpFrame.AnimG:CreateAnimation("Translation")e.ActionButton.RankUpFrame.AnimG.Translation0:SetDuration(2)e.ActionButton.RankUpFrame.AnimG.Translation0:SetOrder(1)e.ActionButton.RankUpFrame.AnimG.Translation0:SetSmoothing("IN_OUT")e.ActionButton.RankUpFrame.AnimG.Translation0:SetOffset(0,-5)e.ActionButton.RankUpFrame.AnimG.Translation1=e.ActionButton.RankUpFrame.AnimG:CreateAnimation("Translation")e.ActionButton.RankUpFrame.AnimG.Translation1:SetDuration(2)e.ActionButton.RankUpFrame.AnimG.Translation1:SetOrder(2)e.ActionButton.RankUpFrame.AnimG.Translation1:SetSmoothing("IN_OUT")e.ActionButton.RankUpFrame.AnimG.Translation1:SetOffset(0,5)e.ActionButton.RankUpFrame.AnimG:SetScript("OnFinished",function(e)e:Play()end)e.ActionButton.RankUpFrame.AnimG:Play()e.ActionButton.RankUpFrame:Hide()end
local function Z(e,t)_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Talents.Button"..t]=CreateFrame("Button","CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Talents.Button"..t,_G["CA2CharacterAdvancementMainMainTree"..e.."ContentTalents"],"TalentButtonTemplate")local e=_G["CA2.CharacterAdvancementMain.Main.Tree"..e..".Content.Talents.Button"..t]local t=e:GetName()e:SetScale(1)_G[t.."IconTexture"]:SetTexture("Interface\\Icons\\ability_marksmanship")_G[t.."RankBorder"]:SetSize(62,42)_G[t.."RankBorder"]:SetPoint("CENTER",t,"BOTTOMRIGHT",-5,5)_G[t.."Slot"]:SetVertexColor(1,.82,0)e:SetScript("OnClick",function(t)if(de(t))then
return
end
if(GLOBAL_BC_CHOOSE_SPELL)then
HandleSpellAddToBuildCreator(t.Spell)return
end
Te(t.Spell)g(t.Spell,e)end)e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",SpellButtonOnDrag)e:SetScript("OnEnter",A)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:SetScale(.9)e.AbilityBorder=e:CreateTexture(t..".AbilityBorder","OVERLAY")e.AbilityBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\TalentAbility")e.AbilityBorder:SetSize(68,68)e.AbilityBorder:SetPoint("CENTER",0,0)e.QualityBorder=e:CreateTexture(t..".QualityBorder","BACKGROUND")e.QualityBorder:SetTexture(_G[t.."Slot"]:GetTexture())e.QualityBorder:SetSize(_G[t.."Slot"]:GetSize())e.QualityBorder:SetPoint("CENTER",0,-1)e.QualityBorder:Hide()e.QualityBorderAdd=e:CreateTexture(t..".QualityBorderAdd","ARTWORK")e.QualityBorderAdd:SetTexture(_G[t.."Slot"]:GetTexture())e.QualityBorderAdd:SetSize(_G[t.."Slot"]:GetSize())e.QualityBorderAdd:SetPoint("CENTER",0,-1)e.QualityBorderAdd:SetBlendMode("ADD")e.QualityBorderAdd:Hide()e.KnownBorder=e:CreateTexture(t..".KnownBorder","ARTWORK")e.KnownBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Known_Highlight")e.KnownBorder:SetSize(85,85)e.KnownBorder:SetPoint("CENTER",0,0)e.KnownBorder:SetBlendMode("ADD")e.KnownBorderAdd=e:CreateTexture(t..".KnownBorderAdd","ARTWORK")e.KnownBorderAdd:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Known_Highlight")e.KnownBorderAdd:SetSize(85,85)e.KnownBorderAdd:SetPoint("CENTER",0,0)e.KnownBorderAdd:SetBlendMode("ADD")e.KnownBorderAdd:Hide()e.ActionButton=CreateFrame("Button",t..".ActionButton",e,"ActionButtonTemplate")e.ActionButton:SetPoint("CENTER")e.ActionButton:SetSize(64,64)e.ActionButton:EnableMouse(false)e.ActionButton:Disable()_G[t..".ActionButtonAutoCastable"]=e.ActionButton:CreateTexture(t..".ActionButtonAutoCastable","OVERLAY")_G[t..".ActionButtonAutoCastable"]:SetTexture("Interface\\Buttons\\UI-AutoCastableOverlay")_G[t..".ActionButtonAutoCastable"]:Hide()_G[t..".ActionButtonAutoCastable"]:SetSize(58,58)_G[t..".ActionButtonAutoCastable"]:SetPoint("CENTER",0,0)_G[t..".ActionButtonShine"]=CreateFrame("FRAME",t..".ActionButtonShine",e.ActionButton,"AutoCastShineTemplate")_G[t..".ActionButtonShine"]:SetPoint("CENTER",0,0)_G[t..".ActionButtonShine"]:SetSize(28,28)_G[t..".ActionButtonNormalTexture"]:Hide()_G[t.."Rank"]:SetParent(e.ActionButton)_G[t.."RankBorder"]:SetParent(e.ActionButton)e.ActionButton.RankUpFrame=CreateFrame("BUTTON",t..".ActionButton.RankUpFrame",e,nil)e.ActionButton.RankUpFrame:SetPoint("BOTTOMRIGHT",12,-6)e.ActionButton.RankUpFrame:SetSize(24,24)e.ActionButton.RankUpFrame:EnableMouse(true)e.ActionButton.RankUpFrame:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")e.ActionButton.RankUpFrame:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")e.ActionButton.RankUpFrame:SetScript("OnLeave",function()GameTooltip:Hide()end)e.ActionButton.RankUpFrame:SetScript("OnEnter",function(t)local e=GetSpellInfo(e.Spell)if(e)then
GameTooltip:SetOwner(t,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFF"..e.."|r is ready to rank up!")GameTooltip:Show()end
end)e.ActionButton.RankUpFrame.AnimG=e.ActionButton.RankUpFrame:CreateAnimationGroup()e.ActionButton.RankUpFrame.AnimG.Translation0=e.ActionButton.RankUpFrame.AnimG:CreateAnimation("Translation")e.ActionButton.RankUpFrame.AnimG.Translation0:SetDuration(2)e.ActionButton.RankUpFrame.AnimG.Translation0:SetOrder(1)e.ActionButton.RankUpFrame.AnimG.Translation0:SetSmoothing("IN_OUT")e.ActionButton.RankUpFrame.AnimG.Translation0:SetOffset(0,-5)e.ActionButton.RankUpFrame.AnimG.Translation1=e.ActionButton.RankUpFrame.AnimG:CreateAnimation("Translation")e.ActionButton.RankUpFrame.AnimG.Translation1:SetDuration(2)e.ActionButton.RankUpFrame.AnimG.Translation1:SetOrder(2)e.ActionButton.RankUpFrame.AnimG.Translation1:SetSmoothing("IN_OUT")e.ActionButton.RankUpFrame.AnimG.Translation1:SetOffset(0,5)e.ActionButton.RankUpFrame.AnimG:SetScript("OnFinished",function(e)e:Play()end)e.ActionButton.RankUpFrame.AnimG:Play()e.ActionButton.RankUpFrame:Hide()end
local function Re(e)_G["CA2.SpecList.SpecButton"..e]:Enable()_G["CA2.SpecList.SpecButton"..e].Text:SetFontObject(GameFontNormal)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetText("|cff00FF00Known|r")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:Enable()_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:GetNormalTexture():SetVertexColor(1,1,1,1)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetDesaturated(false)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetVertexColor(1,1,1,1)_G["CA2.SpecList.SpecButton"..e].KnownBorder:Hide()end
local function Ee(e)_G["CA2.SpecList.SpecButton"..e]:Disable()_G["CA2.SpecList.SpecButton"..e].Text:SetFontObject(GameFontHighlight)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetText("|cffFFFFFFActive|r")_G["CA2.SpecList.SpecButton"..e].KnownBorder:Show()end
local function Te(e)_G["CA2.SpecList.SpecButton"..e]:Disable()_G["CA2.SpecList.SpecButton"..e].Text:SetVertexColor(.6,.6,.6,1)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetText("|cffFF0000Unknown|r")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:Disable()_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:GetNormalTexture():SetVertexColor(1,0,0,1)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetVertexColor(1,0,0,1)_G["CA2.SpecList.SpecButton"..e].KnownBorder:Hide()end
local function o(e,t)_G["CA2.SpecList.SpecButton"..e].Text:SetText(t)end
local function r(t,e)_G["CA2.SpecList.SpecButton"..t].SpecIcon.Icon:SetTexture(e)end
local function g()for t,a in pairs(M)do
local e=t+1
if(a[2])then
Re(e)local n=nil
if(M)then
n=M[t][1]end
if SpecNamesCustom and SpecNamesCustom[t]then
n=SpecNamesCustom[t]end
if SpecIconsCustom and SpecIconsCustom[t]then
r(e,SpecIconsCustom[t])end
o(e,n)if(a[3])then
Ee(e)xe=e-1
ne()end
else
Te(e)end
end
end
StaticPopupDialogs["ASC_SPEC_PET_CONFIRM"]={text="Please, stable your pet\nbefore specialization change if you have one.\nOtherwise you may lose it without any\nchance to revive or summon it.",button1="Accept",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}local function Te(e)if(IsSpellLearned(1515)and oe==false)then
StaticPopupDialogs["ASC_SPEC_PET_CONFIRM"].OnAccept=function()t.Handle("SwitchSpec","ChangeSpecPrep",e.Spec)HideUIPanel(CA2)end
StaticPopup_Show("ASC_SPEC_PET_CONFIRM")else
oe=false
HideUIPanel(CA2)t.Handle("SwitchSpec","ChangeSpecPrep",e.Spec)end
end
function me.GetListItems(t,e)if not(e)then
return false
end
M=e
g()end
function me.ReChooseActiveSpec(e)oe=true
if(CA2:IsVisible())then
CA2.HSKnown:Hide()ee()end
end
function O.HandleRankUp(e,a)local e=0
local t=0
local n=false
for a,o in pairs(a)do
e=e+1
t=a
n=o
end
if(e==1)then
if(n)then
CAO_RankUpList[t]=true
else
CAO_RankUpList[t]=nil
end
else
CAO_RankUpList=a
end
E()end
function O.PlaySoUTutorial(e)HandleTutorial("ScrollOfUnlearning")end
function O.UpdatePlayerState(e,a,n,o,e)local e=1
local t=nil
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:Enable()if(a)then
IN_RM_MODE=true
e=2
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:Disable()t=be
else
IN_RM_MODE=false
end
if(n)then
IN_DRAFT_MODE=true
e=3
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:Disable()t=He
else
IN_DRAFT_MODE=false
end
if(S==1)and(e==2)then
RMAccessFrame:Show()else
RMAccessFrame:Hide()end
CA2.TitleText:SetText("Character Advancement - |cffFFFFFF"..y[e][3])SetPortraitToTexture(CA2.Icon,y[e][1])CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton.tooltipText=y[e][3].."\n"..y[e][2]CA2.CharacterAdvancementMain.Main.SpellsSubText:SetText(ye[e])CA2.CharacterAdvancementMain.Main.TalentsSubText:SetText("Improve your power")if(n or a)then
for n,e in pairs(CAO_Spells)do
if(t[n])then
CAO_Spells[n]={e[1],t[n],e[3],e[4]}end
end
for a,e in pairs(CAO_Talents)do
local n=e[2][1]if(t[n])then
CAO_Talents[a]={e[1],e[2],t[n],e[4],e[5],e[6],e[7]}end
end
Ge()end
K=o
ne()end
function O.Update3AETalentStatus(e)_e=e
end
function O.RecieveUnlearnCost(n,o,l,e)local r=nil
local a=nil
local n=""if(l=="spell")then
a=o
StaticPopupDialogs["ASC_SPELL_UNLEARN_CONFIRM"].OnAccept=function()t.Handle("CAO","UnLearnThisSpell",o)te()end
elseif(l=="talent")then
a=CAO_Talents[C][2][1]StaticPopupDialogs["ASC_SPELL_UNLEARN_CONFIRM"].OnAccept=function()t.Handle("CAO","UnLearnThisTalent",o)te()end
end
r=GetSpellInfo(a)if e and next(e)then
if e[1]=="gold"then
local t,a,e=GetGoldForMoney(e[2])n=t.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..a.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..e.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"elseif e[1]=="item"then
n=e[2].." x1"end
else
n="FREE"end
StaticPopupDialogs["ASC_SPELL_UNLEARN_CONFIRM"].text=string.format(ke,a,r)..n
StaticPopup_Show("ASC_SPELL_UNLEARN_CONFIRM")end
function O.RecieveKnownList(t,e)CAO_Known=e
G={}for e,t in pairs(e)do
local n=CAO_Talent_References[e]local t=0
local a=0
local o=0
local l=0
local r=nil
t,a,o=CA_GetSpellInfo(e)if not(t)then
return false
end
if(n)then
local t=CAO_Talents[n][2]r=#t
for n,t in pairs(t)do
if(t==e)then
l=n
break
end
end
end
table.insert(G,{e,t,a,o,l,r})end
E()end
function O.RecieveDataAll(l,e,r,n,o,t,a)CAO_Spells={}CAO_Talents={}p={}f={}CAO_Talent_References={}CAO_Talent_Ranks={}m={}be=t
He=a
for a,r in pairs(e)do
if(n[a])then
local e=n[a][1]local t=n[a][2]if not(p[e])then
p[e]={}end
if not(p[e][t])then
p[e][t]={}end
if not(Q[e])then
Q[e]={}end
Q[e][t]=o[a]for a,n in pairs(r)do
local a=n[1]local r=n[2]local o=n[3]local n=n[4]CAO_Spells[a]={a,r,o,n}m[a]={e,t}table.insert(p[e][t],a)end
end
end
for e,a in pairs(r)do
if(n[e])then
local t=n[e][1]local n=n[e][2]if not(f[t])then
f[t]={}end
if not(f[t][n])then
f[t][n]={}end
for a,e in pairs(a)do
local r=e[1]local a=e[2]local i=e[3]local l=e[4]local C=e[5]local c=e[6]local e=e[7]if next(a)then
for o=1,#a do
local a=a[o]CAO_Talent_References[a]=e
CAO_Talent_Ranks[a]=o
m[a]={t,n}end
end
CAO_Talents[e]={r,a,i,l,C,c,e}table.insert(f[t][n],e)end
end
end
Ge()if(SPELL_QUALITY_TABLE)and next(SPELL_QUALITY_TABLE)and IN_DRAFT_MODE then
E()end
end
CA2=CreateFrame("FRAME","CA2",UIParent)CA2:SetSize(1060,698)CA2:SetPoint("CENTER",0,0)CA2:SetClampedToScreen(true)CA2:SetScript("OnShow",Ve)CA2:Hide()CA2:RegisterEvent("BAG_UPDATE")CA2:RegisterEvent("PLAYER_LEVEL_UP")CA2:SetFrameStrata("DIALOG")CA2:SetMovable(true)CA2:EnableMouse(true)CA2:RegisterForDrag("LeftButton")CA2:SetScript("OnDragStart",CA2.StartMoving)CA2:SetScript("OnDragStop",CA2.StopMovingOrSizing)CA2:SetScript("OnMouseDown",function()CloseDropDownMenus()end)CA2.TitleText=CA2:CreateFontString("CA2TitleText")CA2.TitleText:SetFont("Fonts\\FRIZQT__.TTF",12)CA2.TitleText:SetFontObject(GameFontNormal)CA2.TitleText:SetPoint("TOP",0,-10)CA2.TitleText:SetShadowOffset(1,-1)CA2.TitleText:SetText("Character Advancement")CA2.CloseButton=CreateFrame("BUTTON","CA2CloseButton",CA2,"UIPanelCloseButton")CA2.CloseButton:SetPoint("TOPRIGHT",5,0)CA2.CloseButton:EnableMouse(true)CA2.CloseButton:SetScript("OnClick",function(e)HideUIPanel(CA2)end)CA2.Icon=CA2:CreateTexture(nil,"BACKGROUND")CA2.Icon:SetSize(60,60)CA2.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\spell_Paladin_divinecircle")CA2.Icon:SetPoint("TOPLEFT",-1,3)SetPortraitToTexture(CA2.Icon,"Interface\\AddOns\\AwAddons\\Textures\\misc\\spell_Paladin_divinecircle")CA2.Border=CA2:CreateTexture(nil,"ARTWORK")CA2.Border:SetSize(2048,1024)CA2.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\CAO_BC")CA2.Border:SetPoint("CENTER",7,-46)CA2.BG=CA2:CreateTexture(nil,"BACKGROUND")CA2.BG:SetSize(2048,1024)CA2.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\CAO_Rework_2_BG")CA2.BG:SetPoint("CENTER",7,-46)CA2.LoadingFrame=CreateFrame("FRAME","CA2.LoadingFrame",CA2)CA2.LoadingFrame:SetPoint("CENTER",0,0)CA2.LoadingFrame:SetSize(2048,1024)CA2.LoadingFrame:SetFrameLevel(10)CA2.LoadingFrame.TitleText=CA2.LoadingFrame:CreateFontString("CA2.LoadingFrame.TitleText")CA2.LoadingFrame.TitleText:SetFont("Fonts\\FRIZQT__.TTF",12)CA2.LoadingFrame.TitleText:SetFontObject(GameFontDisable)CA2.LoadingFrame.TitleText:SetPoint("CENTER",0,0)CA2.LoadingFrame.TitleText:SetShadowOffset(1,-1)CA2.LoadingFrame.TitleText:SetText("Loading...")CA2.LoadingFrame.TitleText.AG=CA2.LoadingFrame.TitleText:CreateAnimationGroup()CA2.LoadingFrame.TitleText.AG.Alpha0=CA2.LoadingFrame.TitleText.AG:CreateAnimation("Alpha")CA2.LoadingFrame.TitleText.AG.Alpha0:SetDuration(1)CA2.LoadingFrame.TitleText.AG.Alpha0:SetOrder(1)CA2.LoadingFrame.TitleText.AG.Alpha0:SetSmoothing("IN_OUT")CA2.LoadingFrame.TitleText.AG.Alpha0:SetChange(-1)CA2.LoadingFrame.TitleText.AG.Alpha1=CA2.LoadingFrame.TitleText.AG:CreateAnimation("Alpha")CA2.LoadingFrame.TitleText.AG.Alpha1:SetDuration(1)CA2.LoadingFrame.TitleText.AG.Alpha1:SetOrder(2)CA2.LoadingFrame.TitleText.AG.Alpha1:SetSmoothing("IN_OUT")CA2.LoadingFrame.TitleText.AG.Alpha1:SetChange(1)CA2.LoadingFrame.TitleText.AG:SetScript("OnFinished",function()CA2.LoadingFrame.TitleText.AG:Play()end)CA2.LoadingFrame.TitleText.AG:Play()CA2.LoadingFrame.BG=CA2.LoadingFrame:CreateTexture(nil,"BACKGROUND")CA2.LoadingFrame.BG:SetSize(2048,1024)CA2.LoadingFrame.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BG_CAO")CA2.LoadingFrame.BG:SetPoint("CENTER",7,-46)CA2.SpecList=CreateFrame("FRAME","CA2.SpecList",CA2)CA2.SpecList:SetSize(unpack(L))CA2.SpecList:SetPoint("RIGHT",unpack(X))CA2.SpecList.SelectedBuild=1
CA2.Scroll_SpecList=CreateFrame("ScrollFrame","CA2.Scroll_SpecList",CA2)CA2.Scroll_SpecList:SetSize(unpack(L))CA2.Scroll_SpecList:SetPoint("RIGHT",unpack(X))CA2.Scroll_SpecList:EnableMouseWheel(true)CA2.Scroll_SpecList.PopupController=IconSelectCreateFrame("CA2.Scroll_SpecList.PopupController",CA2.Scroll_SpecList,{"TOPRIGHT",CA2.Scroll_SpecList,"TOPLEFT",-8,0})CA2.Scroll_SpecList.PopupController.frame:SetFrameLevel(10)function CA2.Scroll_SpecList.PopupController:UpdateValues(e,t)if not(SpecNamesCustom)then
SpecNamesCustom={}end
if not(SpecIconsCustom)then
SpecIconsCustom={}end
SpecNamesCustom[CA2.SpecList.SelectedBuild]=e
SpecIconsCustom[CA2.SpecList.SelectedBuild]=t
g()end
CA2.SpecList:Hide()CA2.Scroll_SpecList:Hide()CA2.Scroll_SpecList:SetScript("OnMouseWheel",function(e,t)if(CA2.Scroll_SpecList.ScrollBar:IsVisible())and(CA2.Scroll_SpecList.ScrollBar:IsEnabled()==1)then
local e=CA2.Scroll_SpecList.ScrollBar:GetValue()CA2.Scroll_SpecList.ScrollBar:SetValue(e-t*32)end
end)CA2.Scroll_SpecList.ScrollBar=CreateFrame("Slider",nil,CA2.Scroll_SpecList,"UIPanelScrollBarTemplate")CA2.Scroll_SpecList.ScrollBar:SetPoint("TOPLEFT",CA2.Scroll_SpecList,"TOPRIGHT",5,-15)CA2.Scroll_SpecList.ScrollBar:SetPoint("BOTTOMLEFT",CA2.Scroll_SpecList,"BOTTOMRIGHT",0,15)CA2.Scroll_SpecList.ScrollBar:SetMinMaxValues(1,50)CA2.Scroll_SpecList.ScrollBar:SetValueStep(1)CA2.Scroll_SpecList.ScrollBar.scrollStep=1
CA2.Scroll_SpecList.ScrollBar:SetValue(0)CA2.Scroll_SpecList.ScrollBar:SetWidth(16)CA2.Scroll_SpecList.ScrollBar:SetScript("OnValueChanged",function(t,e)CA2.Scroll_SpecList:SetVerticalScroll(e)end)CA2.Scroll_SpecList:SetScrollChild(CA2.SpecList)CA2.SpecList.SpecButton1=CreateFrame("Button","CA2.SpecList.SpecButton1",CA2.SpecList)CA2.SpecList.SpecButton1:SetPoint("TOP",0,-3)CA2.SpecList.SpecButton1:SetSize(190,54)CA2.SpecList.SpecButton1:EnableMouse(false)CA2.SpecList.SpecButton1:SetScript("OnClick",function()PanelTemplates_Tab_OnClick(CA2.HedaerTabs.Tab2,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,CA2.HedaerTabs.Tab2.id);CA2.HedaerTabs.activeTab=CA2.HedaerTabs.Tab2.id
F()end)CA2.SpecList.SpecButton1.Border=CA2.SpecList.SpecButton1:CreateTexture("CA2.SpecList.SpecButton1.Border","BORDER")CA2.SpecList.SpecButton1.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\SpecButton_BG")CA2.SpecList.SpecButton1.Border:SetSize(256,64)CA2.SpecList.SpecButton1.Border:SetPoint("CENTER",0,0)CA2.SpecList.SpecButton1.H=CA2.SpecList.SpecButton1:CreateTexture("CA2.SpecList.SpecButton1.H","OVERLAY")CA2.SpecList.SpecButton1.H:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Gradient_Highlight")CA2.SpecList.SpecButton1.H:SetSize(256,86)CA2.SpecList.SpecButton1.H:SetPoint("CENTER",3,3)CA2.SpecList.SpecButton1:SetHighlightTexture(CA2.SpecList.SpecButton1.H)CA2.SpecList.SpecButton1.Text=CA2.SpecList.SpecButton1:CreateFontString("CA2.SpecList.SpecButton1.Text")CA2.SpecList.SpecButton1.Text:SetFont("Fonts\\FRIZQT__.TTF",14)CA2.SpecList.SpecButton1.Text:SetFontObject(GameFontNormal)CA2.SpecList.SpecButton1.Text:SetPoint("CENTER",0,2)CA2.SpecList.SpecButton1.Text:SetShadowOffset(1,-1)CA2.SpecList.SpecButton1.Text:SetText("CHECK OUT TOP BUILDS!")CA2.SpecList.SpecButton1.H_Animated=CA2.SpecList.SpecButton1:CreateTexture("CA2.SpecList.SpecButton1.H","OVERLAY")CA2.SpecList.SpecButton1.H_Animated:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Gradient_Highlight")CA2.SpecList.SpecButton1.H_Animated:SetSize(256,86)CA2.SpecList.SpecButton1.H_Animated:SetPoint("CENTER",3,3)CA2.SpecList.SpecButton1.H_Animated:SetAlpha(0)CA2.SpecList.SpecButton1.H_Animated:SetBlendMode("ADD")CA2.SpecList.SpecButton1.H_Animated.AG=CA2.SpecList.SpecButton1.H_Animated:CreateAnimationGroup()CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0=CA2.SpecList.SpecButton1.H_Animated.AG:CreateAnimation("Alpha")CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0:SetDuration(2)CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0:SetOrder(1)CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0:SetSmoothing("IN_OUT")CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0:SetChange((math.random(30,70)/100))CA2.SpecList.SpecButton1.H_Animated.AG.Alpha1=CA2.SpecList.SpecButton1.H_Animated.AG:CreateAnimation("Alpha")CA2.SpecList.SpecButton1.H_Animated.AG.Alpha1:SetDuration(4)CA2.SpecList.SpecButton1.H_Animated.AG.Alpha1:SetOrder(2)CA2.SpecList.SpecButton1.H_Animated.AG.Alpha1:SetSmoothing("IN_OUT")CA2.SpecList.SpecButton1.H_Animated.AG.Alpha1:SetChange(-1)CA2.SpecList.SpecButton1.H_Animated.AG:SetScript("OnFinished",function()math.random(30,70)CA2.SpecList.SpecButton1.H_Animated.AG.Alpha0:SetChange((math.random(30,70)/100))CA2.SpecList.SpecButton1.H_Animated.AG:Play()end)CA2.SpecList.SpecButton1.H_Animated.AG:Play()for e=2,9 do
_G["CA2.SpecList.SpecButton"..e]=CreateFrame("Button","CA2.SpecList.SpecButton"..e,CA2.SpecList)_G["CA2.SpecList.SpecButton"..e]:SetPoint("BOTTOM",_G["CA2.SpecList.SpecButton"..(e-1)],0,-50)_G["CA2.SpecList.SpecButton"..e]:SetSize(210,54)_G["CA2.SpecList.SpecButton"..e].Spec=(e-1)_G["CA2.SpecList.SpecButton"..e].Hint="Click to change specialization"_G["CA2.SpecList.SpecButton"..e]:SetScript("OnClick",Te)_G["CA2.SpecList.SpecButton"..e]:SetScript("OnEnter",function(t)GameTooltip:SetOwner(t,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFFSpecialization "..M[e-1][1])GameTooltip:AddLine(t.Hint)GameTooltip:Show()end)_G["CA2.SpecList.SpecButton"..e]:SetScript("OnLeave",function(e)GameTooltip:Hide()end)_G["CA2.SpecList.SpecButton"..e].Border=_G["CA2.SpecList.SpecButton"..e]:CreateTexture("CA2.SpecList.SpecButton"..e..".Border","BORDER")_G["CA2.SpecList.SpecButton"..e].Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\SpecButton")_G["CA2.SpecList.SpecButton"..e].Border:SetSize(256,64)_G["CA2.SpecList.SpecButton"..e].Border:SetPoint("CENTER",0,0)_G["CA2.SpecList.SpecButton"..e].H=_G["CA2.SpecList.SpecButton"..e]:CreateTexture("CA2.SpecList.SpecButton"..e..".H","OVERLAY")_G["CA2.SpecList.SpecButton"..e].H:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Gradient_Highlight")_G["CA2.SpecList.SpecButton"..e].H:SetSize(256,86)_G["CA2.SpecList.SpecButton"..e].H:SetPoint("CENTER",3,3)_G["CA2.SpecList.SpecButton"..e]:SetHighlightTexture(_G["CA2.SpecList.SpecButton"..e].H)_G["CA2.SpecList.SpecButton"..e].Text=_G["CA2.SpecList.SpecButton"..e]:CreateFontString("CA2.SpecList.SpecButton"..e..".Text")_G["CA2.SpecList.SpecButton"..e].Text:SetFont("Fonts\\FRIZQT__.TTF",12)_G["CA2.SpecList.SpecButton"..e].Text:SetFontObject(GameFontNormal)_G["CA2.SpecList.SpecButton"..e].Text:SetPoint("CENTER",20,10)_G["CA2.SpecList.SpecButton"..e].Text:SetShadowOffset(1,-1)_G["CA2.SpecList.SpecButton"..e].Text:SetText(string.upper(M[_G["CA2.SpecList.SpecButton"..e].Spec][1]))_G["CA2.SpecList.SpecButton"..e].Text:SetSize(160,16)_G["CA2.SpecList.SpecButton"..e].Text:SetJustifyH("LEFT")_G["CA2.SpecList.SpecButton"..e].Text_Add=_G["CA2.SpecList.SpecButton"..e]:CreateFontString("CA2.SpecList.SpecButton"..e..".Text_Add")_G["CA2.SpecList.SpecButton"..e].Text_Add:SetFont("Fonts\\FRIZQT__.TTF",10)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetFontObject(GameFontNormal)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetPoint("CENTER",20,-6)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetShadowOffset(1,-1)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetText("|cff00FF00Active")_G["CA2.SpecList.SpecButton"..e].Text_Add:SetSize(160,16)_G["CA2.SpecList.SpecButton"..e].Text_Add:SetJustifyH("LEFT")_G["CA2.SpecList.SpecButton"..e].SpecIcon=CreateFrame("FRAME","CA2.SpecList.SpecButton"..e..".SpecIcon",_G["CA2.SpecList.SpecButton"..e],"PopupButtonTemplate")_G["CA2.SpecList.SpecButton"..e].SpecIcon:SetSize(32,32)_G["CA2.SpecList.SpecButton"..e].SpecIcon:SetPoint("LEFT",0,2)_G["CA2.SpecList.SpecButton"..e].KnownBorder=_G["CA2.SpecList.SpecButton"..e].SpecIcon:CreateTexture("CA2.SpecList.SpecButton"..e..".KnownBorder","ARTWORK")_G["CA2.SpecList.SpecButton"..e].KnownBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Known_Highlight")_G["CA2.SpecList.SpecButton"..e].KnownBorder:SetSize(80,80)_G["CA2.SpecList.SpecButton"..e].KnownBorder:SetPoint("CENTER",_G["CA2.SpecList.SpecButton"..e].SpecIcon,0,0)_G["CA2.SpecList.SpecButton"..e].KnownBorder:SetBlendMode("ADD")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings=CreateFrame("Button","CA2.SpecList.SpecButton"..e..".SpecIcon.Settings",_G["CA2.SpecList.SpecButton"..e].SpecIcon)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetPoint("BOTTOMRIGHT",12,-8)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetSize(26,26)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetScript("OnClick",function(t)CA2.SpecList.SelectedBuild=e-1
CA2.Scroll_SpecList.PopupController.frame:Hide()if SpecNamesCustom and SpecNamesCustom[e-1]then
CA2.Scroll_SpecList.PopupController:EditExisting(SpecNamesCustom[e-1],SpecIconsCustom[e-1])else
CA2.Scroll_SpecList.PopupController:CreateNew()end
end)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetScript("OnEnter",function(e)if(e:IsEnabled()==1)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFFCustomize specialization|r")GameTooltip:AddLine("Click here to change icon or name of your specialization.")GameTooltip:Show()end
end)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Settings:SetScript("OnLeave",function(e)GameTooltip:Hide()end)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon=_G["CA2.SpecList.SpecButton"..e].SpecIcon:CreateTexture("CA2.SpecList.SpecButton"..e..".SpecIcon.Icon","ARTWORK")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetTexture("Interface\\Icons\\inv_misc_book_16")_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetSize(36,36)_G["CA2.SpecList.SpecButton"..e].SpecIcon.Icon:SetPoint("CENTER",0,-1)end
CA2.HSKnown=HybridScroll()CA2.HSKnown.Parent=CA2
CA2.HSKnown.ParentName=CA2:GetName()CA2.HSKnown.Name="CA2.HSKnown"CA2.HSKnown.Width=L[1]CA2.HSKnown.Height=L[2]CA2.HSKnown.doNotHide=true
CA2.HSKnown.point={"RIGHT",unpack(X)}CA2.HSKnown.scrollup_point={5,-15}CA2.HSKnown.scrolldown_point={0,15}function CA2.HSKnown.LoadData()CA2.HSKnown.items=G;end
function CA2.HSKnown.SetUpButton(t,e)local i=e[1]local r=e[2]local o=e[3]local c=e[4]local n=e[5]local a=e[6]local l=e[7]local A,e,C=GetSpellInfo(i)local e=t:GetName()if(n>0)then
r=r*n
o=o*n
_G[e..".SpellIconRank"]:Show()_G[e..".SpellIconRank"]:SetText(n.."/"..a)_G[e..".SpellIconRankBorder"]:Show()else
_G[e..".SpellIconRank"]:Hide()_G[e..".SpellIconRankBorder"]:Hide()end
t.SpellName:SetText(A)t.Spell=i
_G[e..".SpellIconRank"]:SetFontObject(GameFontNormalSmall)_G[e..".SpellIconIconTexture"]:SetDesaturated(false)_G[e..".SpellIconIconTexture"]:SetVertexColor(1,1,1)_G[e..".SpellIconIconTexture"]:SetTexture(C)_G[e..".SpellIconSlot"]:SetDesaturated(false)_G[e..".SpellIconSlot"]:SetVertexColor(1,.82,0)_G[e..".SpellIconRank"]:SetVertexColor(1,.82,0)_G[e..".SpellIconRankBorder"]:SetDesaturated(false)_G[e..".SpellIconRankBorder"]:SetVertexColor(1,.82,0)_G[e..".SpellIconSlot"]:Show()_G[e..".SpellIcon"].QualityBorder:Hide()_G[e..".SpellIcon"].QualityBorderAdd:Hide()if(r==0)then
t.AECost:Hide()t.AEIcon:SetDesaturated(true)else
t.AECost:Show()t.AECost:SetText(r)t.AEIcon:SetDesaturated(false)end
if(o==0)then
t.TECost:Hide()t.TEIcon:SetDesaturated(true)else
t.TECost:Show()t.TECost:SetText(o)t.TEIcon:SetDesaturated(false)end
if(a and n)and(n<a)then
_G[e..".SpellIconSlot"]:SetVertexColor(0,1,0)_G[e..".SpellIconRank"]:SetVertexColor(0,1,0)_G[e..".SpellIconRankBorder"]:SetVertexColor(0,1,0)end
if(l~=nil)and(l==false)then
_G[e..".SpellIconRank"]:SetFontObject(GameFontDisableSmall)_G[e..".SpellIconIconTexture"]:SetDesaturated(true)_G[e..".SpellIconSlot"]:SetDesaturated(true)_G[e..".SpellIconRankBorder"]:SetDesaturated(true)_G[e..".SpellIconRank"]:SetVertexColor(.5,.5,.5,1)if(a)then
_G[e..".SpellIconRank"]:SetText("0/"..a)end
end
if(c>S)then
_G[e..".SpellIconIconTexture"]:SetDesaturated(false)_G[e..".SpellIconSlot"]:SetDesaturated(false)_G[e..".SpellIconRankBorder"]:SetDesaturated(false)_G[e..".SpellIconRank"]:SetVertexColor(1,0,0)_G[e..".SpellIconIconTexture"]:SetVertexColor(1,0,0)_G[e..".SpellIconSlot"]:SetVertexColor(1,0,0)_G[e..".SpellIconRankBorder"]:SetVertexColor(1,0,0)end
ue(t.SpellIcon,t.Spell)if(SPELL_QUALITY_TABLE[t.Spell])and IN_DRAFT_MODE then
ce(_G[e..".SpellIcon"],t.Spell)end
Ae(t.Spell,t,1)if t:IsMouseOver()then
t:GetScript("OnEnter")(t)end
end
CA2.HSKnown.RefreshLayout_Old=CA2.HSKnown.RefreshLayout
CA2.HSKnown.RefreshLayout=function()local e=DisableAutoCastAll()for e,t in pairs(s)do
s[e][1]=nil
end
CA2.HSKnown.RefreshLayout_Old()if(e)then
EnableAutoCast(e)end
end
function CA2.HSKnown.CreateButton(t,e)local n=t
local t=n:GetName()SpellButton=CreateFrame("Button",t..".SpellButton"..e,n)if(e==1)then
SpellButton:SetPoint("TOP",19,2)else
SpellButton:SetPoint("BOTTOM",_G[t..".SpellButton"..(e-1)],0,-40)end
SpellButton:SetSize(195,48)SpellButton:SetScript("OnClick",function(e)de(e)Qe(e)end)SpellButton:SetScript("OnEnter",A)SpellButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)SpellButton:RegisterForDrag("LeftButton")SpellButton:SetScript("OnDragStart",SpellButtonOnDrag)SpellButton.BG=SpellButton:CreateTexture(t..".SpellButton"..e..".BG","BACKGROUND")SpellButton.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\SpellSlot")SpellButton.BG:SetSize(310,76)SpellButton.BG:SetPoint("CENTER",0,0)SpellButton.H=SpellButton:CreateTexture(t..".SpellButton"..e..".H","OVERLAY")SpellButton.H:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\SpellSlot_Highlight")SpellButton.H:SetSize(310,68)SpellButton.H:SetPoint("CENTER",0,0)SpellButton.H:SetBlendMode("ADD")SpellButton.H:Hide()SpellButton.AEIcon=SpellButton:CreateTexture(t..".SpellButton"..e..".AEIcon","ARTWORK")SpellButton.AEIcon:SetTexture("Interface\\Icons\\inv_custom_abilityessence")SpellButton.AEIcon:SetSize(18,18)SpellButton.AEIcon:SetPoint("RIGHT",-42,0)SpellButton.TEIcon=SpellButton:CreateTexture(t..".SpellButton"..e..".TEIcon","ARTWORK")SpellButton.TEIcon:SetTexture("Interface\\Icons\\inv_custom_talentessence")SpellButton.TEIcon:SetSize(18,18)SpellButton.TEIcon:SetPoint("RIGHT",-12,0)SpellButton.SpellName=SpellButton:CreateFontString(t..".SpellButton"..e..".SpellName")SpellButton.SpellName:SetFontObject(GameFontNormal)SpellButton.SpellName:SetFont("Fonts\\FRIZQT__.TTF",11)SpellButton.SpellName:SetPoint("LEFT",12,0)SpellButton.SpellName:SetText("Spell Name Goes Test Lol Example Here")SpellButton.SpellName:SetJustifyH("LEFT")SpellButton.SpellName:SetSize(105,60)SpellButton.AECost=SpellButton:CreateFontString(t..".SpellButton"..e..".AECost","OVERLAY")SpellButton.AECost:SetFont("Fonts\\FRIZQT__.TTF",12,"THICKOUTLINE")SpellButton.AECost:SetPoint("RIGHT",-42,0)SpellButton.AECost:SetText("2")SpellButton.AECost:SetJustifyH("CENTER")SpellButton.AECost:SetSize(18,18)SpellButton.TECost=SpellButton:CreateFontString(t..".SpellButton"..e..".TECost","OVERLAY")SpellButton.TECost:SetFont("Fonts\\FRIZQT__.TTF",12,"THICKOUTLINE")SpellButton.TECost:SetPoint("RIGHT",-12,0)SpellButton.TECost:SetText("2")SpellButton.TECost:SetJustifyH("CENTER")SpellButton.TECost:SetSize(18,18)SpellButton:SetHighlightTexture(SpellButton.H)SpellButton:EnableMouse()SpellButton.SpellIcon=CreateFrame("Button",t..".SpellButton"..e..".SpellIcon",SpellButton,"TalentButtonTemplate")SpellButton.SpellIcon:SetPoint("CENTER",SpellButton,"RIGHT",0,-10)SpellButton.SpellIcon:SetScale(.88)_G[t..".SpellButton"..e..".SpellIconRank"]:Hide()_G[t..".SpellButton"..e..".SpellIconRankBorder"]:Hide()SpellButton.SpellIcon:SetPoint("TOPLEFT",SpellButton.SpellIcon:GetParent(),"TOPLEFT",-35,-8);SpellButton.SpellIcon:EnableMouse(false)_G[t..".SpellButton"..e..".SpellIconRankBorder"]:SetSize(62,42)_G[t..".SpellButton"..e..".SpellIconRankBorder"]:SetPoint("CENTER",t..".SpellButton"..e..".SpellIcon","BOTTOMRIGHT",-5,5)SpellButton.SpellIcon.ActionButton=CreateFrame("Button",t..".SpellButton"..e..".SpellIcon.ActionButton",SpellButton.SpellIcon,"ActionButtonTemplate")SpellButton.SpellIcon.ActionButton:SetPoint("CENTER")SpellButton.SpellIcon.ActionButton:SetSize(64,64)SpellButton.SpellIcon.ActionButton:EnableMouse(false)SpellButton.SpellIcon.ActionButton:Disable()local n=SpellButton.SpellIcon.ActionButton:GetName()_G[n.."AutoCastable"]=SpellButton.SpellIcon.ActionButton:CreateTexture(n.."AutoCastable","OVERLAY")_G[n.."AutoCastable"]:SetTexture("Interface\\Buttons\\UI-AutoCastableOverlay")_G[n.."AutoCastable"]:Hide()_G[n.."AutoCastable"]:SetSize(58,58)_G[n.."AutoCastable"]:SetPoint("CENTER",0,0)_G[n.."Shine"]=CreateFrame("FRAME",n.."Shine",SpellButton.SpellIcon.ActionButton,"AutoCastShineTemplate")_G[n.."Shine"]:SetPoint("CENTER",0,0)_G[n.."Shine"]:SetSize(28,28)_G[n.."NormalTexture"]:Hide()_G[t..".SpellButton"..e..".SpellIconRank"]:SetParent(SpellButton.SpellIcon.ActionButton)_G[t..".SpellButton"..e..".SpellIconRankBorder"]:SetParent(SpellButton.SpellIcon.ActionButton)SpellButton.SpellIcon.ActionButton.RankUpFrame=CreateFrame("BUTTON",n..".RankUpFrame",SpellButton.SpellIcon,nil)SpellButton.SpellIcon.ActionButton.RankUpFrame:SetPoint("LEFT",SpellButton.SpellName,"RIGHT",0,0)SpellButton.SpellIcon.ActionButton.RankUpFrame:SetSize(24,24)SpellButton.SpellIcon.ActionButton.RankUpFrame:EnableMouse(true)SpellButton.SpellIcon.ActionButton.RankUpFrame:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")SpellButton.SpellIcon.ActionButton.RankUpFrame:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\RankUp")SpellButton.SpellIcon.ActionButton.RankUpFrame:SetScript("OnLeave",function()GameTooltip:Hide()end)SpellButton.SpellIcon.ActionButton.RankUpFrame:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFF"..e:GetParent():GetParent().SpellName:GetText().."|r is ready to rank up!")GameTooltip:Show()end)SpellButton.SpellIcon.ActionButton.RankUpFrame:Hide()SpellButton.SpellIcon.QualityBorder=SpellButton.SpellIcon:CreateTexture(nil,"BACKGROUND")SpellButton.SpellIcon.QualityBorder:SetTexture(_G[t..".SpellButton"..e..".SpellIconSlot"]:GetTexture())SpellButton.SpellIcon.QualityBorder:SetSize(_G[t..".SpellButton"..e..".SpellIconSlot"]:GetSize())SpellButton.SpellIcon.QualityBorder:SetPoint("CENTER",0,-1)SpellButton.SpellIcon.QualityBorder:Hide()SpellButton.SpellIcon.QualityBorderAdd=SpellButton.SpellIcon:CreateTexture(nil,"ARTWORK")SpellButton.SpellIcon.QualityBorderAdd:SetTexture(_G[t..".SpellButton"..e..".SpellIconSlot"]:GetTexture())SpellButton.SpellIcon.QualityBorderAdd:SetSize(_G[t..".SpellButton"..e..".SpellIconSlot"]:GetSize())SpellButton.SpellIcon.QualityBorderAdd:SetPoint("CENTER",0,-1)SpellButton.SpellIcon.QualityBorderAdd:SetBlendMode("ADD")SpellButton.SpellIcon.QualityBorderAdd:Hide()return SpellButton
end
CA2.Currency=CreateFrame("FRAME","CA2.Currency",CA2)CA2.Currency:SetSize(253,24)CA2.Currency:SetPoint("CENTER",CA2.Scroll_SpecList,"BOTTOM",10,-19)CA2.Currency.ScrollButton=CreateFrame("BUTTON","CA2.Currency.ScrollButton",CA2.Currency)CA2.Currency.ScrollButton:SetSize(16,16)CA2.Currency.ScrollButton:SetPoint("BOTTOMRIGHT",-5,6)CA2.Currency.ScrollButton.Item=k
CA2.Currency.ScrollButton:SetScript("OnEnter",ItemButtonOnEnter)CA2.Currency.ScrollButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.Currency.ScrollButton:SetScript("OnClick",ItemButtonOnClick)CA2.Currency.ScrollButton.Icon=CA2.Currency.ScrollButton:CreateTexture("CA2.Currency.ScrollButtonAEIcon","ARTWORK")CA2.Currency.ScrollButton.Icon:SetSize(14,14)CA2.Currency.ScrollButton.Icon:SetPoint("CENTER",0,0)CA2.Currency.ScrollButton.Icon:SetTexture("Interface\\Icons\\inv_custom_abilityessence")CA2.Currency.ScrollButton.Text=CA2.Currency.ScrollButton:CreateFontString("CA2.Currency.ScrollButtonAEText")CA2.Currency.ScrollButton.Text:SetFontObject(GameFontNormal)CA2.Currency.ScrollButton.Text:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.Currency.ScrollButton.Text:SetPoint("RIGHT",CA2.Currency.ScrollButton,"LEFT",-2,1)CA2.Currency.ScrollButton.Text:SetText("Ability Essence: |cffFFFFFF10|r")CA2.Currency.ScrollButton.Text:SetHeight(16)CA2.Currency.ScrollButton.Text:SetJustifyH("RIGHT")CA2.CharacterAdvancementMain=CreateFrame("FRAME","CA2CharacterAdvancementMain",CA2)CA2.CharacterAdvancementMain:SetSize(re,665)CA2.CharacterAdvancementMain:SetPoint("CENTER",-131,-8)CA2.CharacterAdvancementMain:SetScript("OnHide",function()GLOBAL_BC_CHOOSE_SPELL=false
CloseDropDownMenus()end)CA2.CharacterAdvancementMain.Navi=CreateFrame("FRAME","CA2CharacterAdvancementMainNavi",CA2)CA2.CharacterAdvancementMain.Navi:SetSize(690,64)CA2.CharacterAdvancementMain.Navi:SetPoint("TOP",0,-35)for e=1,9 do
_G["CA2.CharacterAdvancementMain.ClassButton"..e]=CreateFrame("CheckButton","CA2CharacterAdvancementMainClassButton"..e,CA2.CharacterAdvancementMain.Navi,"StaticPopupButtonTemplate")_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetSize(90,90)_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetPoint("CENTER",(80*(e-5)),2)_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetScript("OnClick",function(e)PanelTemplates_Tab_OnClick(CA2.HedaerTabs.Tab1,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,CA2.HedaerTabs.Tab1.id);CA2.HedaerTabs.activeTab=CA2.HedaerTabs.Tab1.id
F()_(e)end)_G["CA2.CharacterAdvancementMain.ClassButton"..e].BGIcon=_G["CA2.CharacterAdvancementMain.ClassButton"..e]:CreateTexture("CA2CharacterAdvancementMainClassButton"..e.."BGIcon","BACKGROUND")_G["CA2.CharacterAdvancementMain.ClassButton"..e].BGIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\UI-CharacterCreate-Classes")_G["CA2.CharacterAdvancementMain.ClassButton"..e].BGIcon:SetSize(44.1,44.1)_G["CA2.CharacterAdvancementMain.ClassButton"..e].BGIcon:SetPoint("CENTER",0,2)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Border=_G["CA2.CharacterAdvancementMain.ClassButton"..e]:CreateTexture("CA2CharacterAdvancementMainClassButton"..e.."Border","BORDER")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CardFrame\\cardring")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Border:SetSize(_G["CA2.CharacterAdvancementMain.ClassButton"..e]:GetSize())_G["CA2.CharacterAdvancementMain.ClassButton"..e].Border:SetPoint("CENTER",0,0)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight=_G["CA2.CharacterAdvancementMain.ClassButton"..e]:CreateTexture("CA2CharacterAdvancementMainClassButton"..e.."Highlight","ARTWORK")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\roundbuttonhighlight")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight:SetSize(76.5,76.5)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight:SetPoint("CENTER",0,2)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add=_G["CA2.CharacterAdvancementMain.ClassButton"..e]:CreateTexture("CA2CharacterAdvancementMainClassButton"..e.."Highlight","ARTWORK")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\roundbuttonhighlight")_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add:SetSize(76.5,76.5)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add:SetPoint("CENTER",0,2)_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add:SetBlendMode("ADD")_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetCheckedTexture(_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight_Add)_G["CA2.CharacterAdvancementMain.ClassButton"..e]:GetNormalTexture():SetTexture(nil)_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetHighlightTexture(_G["CA2.CharacterAdvancementMain.ClassButton"..e].Highlight)_G["CA2.CharacterAdvancementMain.ClassButton"..e]:GetPushedTexture():SetTexture(nil)_G["CA2CharacterAdvancementMainClassButton"..e.."Text"]:SetFont("Fonts\\FRIZQT__.TTF",12,"OUTLINE")_G["CA2CharacterAdvancementMainClassButton"..e.."Text"]:SetPoint("CENTER",0,-20)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame=CreateFrame("FRAME","CA2CharacterAdvancementMainClassButton"..e.."TotalSpellsFrame",_G["CA2.CharacterAdvancementMain.ClassButton"..e],nil)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame:SetSize(32,32)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame:SetPoint("RIGHT",-8,-6)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.BGIcon=_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame:CreateTexture("CA2.CharacterAdvancementMain.ClassButton"..e.."TotalSpellsFrameBGIcon","BACKGROUND")_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.BGIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Tree_AmountOfSpellsDisabled")_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.BGIcon:SetSize(32,32)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.BGIcon:SetPoint("CENTER",0,0)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.Total=_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame:CreateFontString("CA2CharacterAdvancementMainClassButton"..e.."TotalSpellsFrameTotal")_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.Total:SetFont("Fonts\\FRIZQT__.TTF",10)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.Total:SetPoint("CENTER",0,0)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.Total:SetText("32")_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame.Total:SetSize(32,32)_G["CA2.CharacterAdvancementMain.ClassButton"..e].TotalSpellsFrame:Hide()end
CA2CharacterAdvancementMainClassButton1.Class="DRUID"CA2CharacterAdvancementMainClassButton2.Class="HUNTER"CA2CharacterAdvancementMainClassButton3.Class="MAGE"CA2CharacterAdvancementMainClassButton4.Class="PALADIN"CA2CharacterAdvancementMainClassButton5.Class="PRIEST"CA2CharacterAdvancementMainClassButton6.Class="ROGUE"CA2CharacterAdvancementMainClassButton7.Class="SHAMAN"CA2CharacterAdvancementMainClassButton8.Class="WARLOCK"CA2CharacterAdvancementMainClassButton9.Class="WARRIOR"for e=1,9 do
b[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class]=_G["CA2.CharacterAdvancementMain.ClassButton"..e]end
for e=1,9 do
if(LOCALIZED_CLASS_NAMES_MALE[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class]=="Hero")then
_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetText("Druid")else
_G["CA2.CharacterAdvancementMain.ClassButton"..e]:SetText(LOCALIZED_CLASS_NAMES_MALE[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class])end
_G["CA2.CharacterAdvancementMain.ClassButton"..e].BGIcon:SetTexCoord(j[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class][1],j[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class][2],j[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class][3],j[_G["CA2.CharacterAdvancementMain.ClassButton"..e].Class][4])end
CA2.SpecializationLabel=CreateFrame("Button","CA2.SpecializationLabel",CA2)CA2.SpecializationLabel:SetSize(255,55)CA2.SpecializationLabel:SetPoint("TOPRIGHT",-5,-126)CA2.SpecializationLabel.Text=CA2.SpecializationLabel:CreateFontString("CA2.SpecializationLabel.Text")CA2.SpecializationLabel.Text:SetFontObject(GameFontDisableSmall)CA2.SpecializationLabel.Text:SetPoint("LEFT",6,0)CA2.SpecializationLabel.Text:SetText("Choose\nprimary stat")CA2.SpecializationLabel.Text:SetJustifyH("LEFT")CA2.SpecializationLabel.H_Animated=CA2.SpecializationLabel:CreateTexture("CA2.SpecializationLabel.H_Animated","OVERLAY")CA2.SpecializationLabel.H_Animated:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Gradient_Highlight")CA2.SpecializationLabel.H_Animated:SetSize(256,87)CA2.SpecializationLabel.H_Animated:SetPoint("CENTER",3,-1)CA2.SpecializationLabel.H_Animated:SetAlpha(0)CA2.SpecializationLabel.H_Animated:SetBlendMode("ADD")CA2.SpecializationLabel.H_Animated.AG=CA2.SpecializationLabel.H_Animated:CreateAnimationGroup()CA2.SpecializationLabel.H_Animated.AG.Alpha0=CA2.SpecializationLabel.H_Animated.AG:CreateAnimation("Alpha")CA2.SpecializationLabel.H_Animated.AG.Alpha0:SetDuration(1)CA2.SpecializationLabel.H_Animated.AG.Alpha0:SetOrder(1)CA2.SpecializationLabel.H_Animated.AG.Alpha0:SetSmoothing("IN_OUT")CA2.SpecializationLabel.H_Animated.AG.Alpha0:SetChange(1)CA2.SpecializationLabel.H_Animated.AG.Alpha1=CA2.SpecializationLabel.H_Animated.AG:CreateAnimation("Alpha")CA2.SpecializationLabel.H_Animated.AG.Alpha1:SetDuration(2)CA2.SpecializationLabel.H_Animated.AG.Alpha1:SetOrder(2)CA2.SpecializationLabel.H_Animated.AG.Alpha1:SetSmoothing("IN_OUT")CA2.SpecializationLabel.H_Animated.AG.Alpha1:SetChange(-1)CA2.SpecializationLabel.H_Animated.AG:SetScript("OnFinished",function()math.random(30,70)CA2.SpecializationLabel.H_Animated.AG.Alpha0:SetChange(1)CA2.SpecializationLabel.H_Animated.AG:Play()end)CA2.SpecializationLabel.H_Animated.AG:Play()CA2.SpecializationLabel.H_Animated:Hide()CA2.SpecializationLabel.Stat2=CreateFrame("CheckButton","CA2.SpecializationLabel.Stat2",CA2.SpecializationLabel,"StaticPopupButtonTemplate")CA2.SpecializationLabel.Stat2:SetSize(32,32)CA2.SpecializationLabel.Stat2:SetPoint("CENTER",8,0)CA2.SpecializationLabel.Stat2:SetNormalTexture(nil)CA2.SpecializationLabel.Stat2:SetDisabledTexture(nil)CA2.SpecializationLabel.Stat2:SetPushedTexture(nil)CA2.SpecializationLabel.Stat2:SetText("Agility")CA2.SpecializationLabel.Stat2:SetScript("OnEnter",function(e)if(e.tooltipTitle)then
GameTooltip_SetDefaultAnchor(GameTooltip,e)GameTooltip:AddLine(e.tooltipTitle)GameTooltip:AddLine(e.tooltipText)GameTooltip:Show()end
end)CA2.SpecializationLabel.Stat2:SetScript("OnLeave",function(e)GameTooltip:Hide()end)CA2.SpecializationLabel.Stat2.HighlightTexture=CA2.SpecializationLabel.Stat2:CreateTexture("CA2CharacterAdvancementMainMainAEButtonHighlightTexture","ARTWORK")CA2.SpecializationLabel.Stat2.HighlightTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_h")CA2.SpecializationLabel.Stat2.HighlightTexture:SetSize(48,48)CA2.SpecializationLabel.Stat2.HighlightTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat2.HighlightTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat2.HighlightTexture:Hide()CA2.SpecializationLabel.Stat2:SetHighlightTexture(CA2.SpecializationLabel.Stat2.HighlightTexture)CA2.SpecializationLabel.Stat2.CheckedTexture=CA2.SpecializationLabel.Stat2:CreateTexture("CA2CharacterAdvancementMainMainAEButtonCheckedTexture","BORDER")CA2.SpecializationLabel.Stat2.CheckedTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_c")CA2.SpecializationLabel.Stat2.CheckedTexture:SetSize(48,48)CA2.SpecializationLabel.Stat2.CheckedTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat2.CheckedTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat2.CheckedTexture:Hide()CA2.SpecializationLabel.Stat2:SetCheckedTexture(CA2.SpecializationLabel.Stat2.CheckedTexture)CA2.SpecializationLabel.Stat2.Icon=CA2.SpecializationLabel.Stat2:CreateTexture("CA2.SpecializationLabel.Stat2.Icon","BORDER")CA2.SpecializationLabel.Stat2.Icon:SetTexture("Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat2.Icon:SetSize(32,32)CA2.SpecializationLabel.Stat2.Icon:SetPoint("CENTER",0,0)SetPortraitToTexture(CA2.SpecializationLabel.Stat2.Icon,"Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat2.Border=CA2.SpecializationLabel.Stat2:CreateTexture("CA2.SpecializationLabel.Stat2.Border","BACKGROUND")CA2.SpecializationLabel.Stat2.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle")CA2.SpecializationLabel.Stat2.Border:SetSize(50,50)CA2.SpecializationLabel.Stat2.Border:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat2.Id=3
_G["CA2.SpecializationLabel.Stat2Text"]:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")_G["CA2.SpecializationLabel.Stat2Text"]:SetPoint("BOTTOMRIGHT",0,3)CA2.SpecializationLabel.Stat1=CreateFrame("CheckButton","CA2.SpecializationLabel.Stat1",CA2.SpecializationLabel,"StaticPopupButtonTemplate")CA2.SpecializationLabel.Stat1:SetSize(32,32)CA2.SpecializationLabel.Stat1:SetPoint("RIGHT",CA2.SpecializationLabel.Stat2,"LEFT",-12,0)CA2.SpecializationLabel.Stat1:SetNormalTexture(nil)CA2.SpecializationLabel.Stat1:SetDisabledTexture(nil)CA2.SpecializationLabel.Stat1:SetPushedTexture(nil)CA2.SpecializationLabel.Stat1:SetText("Strength")CA2.SpecializationLabel.Stat1.Id=2
CA2.SpecializationLabel.Stat1:SetScript("OnEnter",function(e)if(e.tooltipTitle)then
GameTooltip_SetDefaultAnchor(GameTooltip,e)GameTooltip:AddLine(e.tooltipTitle)GameTooltip:AddLine(e.tooltipText)GameTooltip:Show()end
end)CA2.SpecializationLabel.Stat1:SetScript("OnLeave",function(e)GameTooltip:Hide()end)CA2.SpecializationLabel.Stat1.HighlightTexture=CA2.SpecializationLabel.Stat1:CreateTexture("CA2CharacterAdvancementMainMainAEButtonHighlightTexture","ARTWORK")CA2.SpecializationLabel.Stat1.HighlightTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_h")CA2.SpecializationLabel.Stat1.HighlightTexture:SetSize(48,48)CA2.SpecializationLabel.Stat1.HighlightTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat1.HighlightTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat1.HighlightTexture:Hide()CA2.SpecializationLabel.Stat1:SetHighlightTexture(CA2.SpecializationLabel.Stat1.HighlightTexture)CA2.SpecializationLabel.Stat1.CheckedTexture=CA2.SpecializationLabel.Stat1:CreateTexture("CA2CharacterAdvancementMainMainAEButtonCheckedTexture","BORDER")CA2.SpecializationLabel.Stat1.CheckedTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_c")CA2.SpecializationLabel.Stat1.CheckedTexture:SetSize(48,48)CA2.SpecializationLabel.Stat1.CheckedTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat1.CheckedTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat1.CheckedTexture:Hide()CA2.SpecializationLabel.Stat1:SetCheckedTexture(CA2.SpecializationLabel.Stat1.CheckedTexture)CA2.SpecializationLabel.Stat1.Icon=CA2.SpecializationLabel.Stat1:CreateTexture("CA2.SpecializationLabel.Stat1.Icon","BORDER")CA2.SpecializationLabel.Stat1.Icon:SetTexture("Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat1.Icon:SetSize(32,32)CA2.SpecializationLabel.Stat1.Icon:SetPoint("CENTER",0,-1)SetPortraitToTexture(CA2.SpecializationLabel.Stat1.Icon,"Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat1.Border=CA2.SpecializationLabel.Stat1:CreateTexture("CA2.SpecializationLabel.Stat1.Border","BACKGROUND")CA2.SpecializationLabel.Stat1.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle")CA2.SpecializationLabel.Stat1.Border:SetSize(50,50)CA2.SpecializationLabel.Stat1.Border:SetPoint("CENTER",0,-1)_G["CA2.SpecializationLabel.Stat1Text"]:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")_G["CA2.SpecializationLabel.Stat1Text"]:SetPoint("BOTTOMRIGHT",0,3)CA2.SpecializationLabel.Stat3=CreateFrame("CheckButton","CA2.SpecializationLabel.Stat3",CA2.SpecializationLabel,"StaticPopupButtonTemplate")CA2.SpecializationLabel.Stat3:SetSize(32,32)CA2.SpecializationLabel.Stat3:SetPoint("LEFT",CA2.SpecializationLabel.Stat2,"RIGHT",12,0)CA2.SpecializationLabel.Stat3:SetNormalTexture(nil)CA2.SpecializationLabel.Stat3:SetDisabledTexture(nil)CA2.SpecializationLabel.Stat3:SetPushedTexture(nil)CA2.SpecializationLabel.Stat3:SetText("Intellect")CA2.SpecializationLabel.Stat3.Id=4
CA2.SpecializationLabel.Stat3:SetScript("OnEnter",function(e)if(e.tooltipTitle)then
GameTooltip_SetDefaultAnchor(GameTooltip,e)GameTooltip:AddLine(e.tooltipTitle)GameTooltip:AddLine(e.tooltipText)GameTooltip:Show()end
end)CA2.SpecializationLabel.Stat3:SetScript("OnLeave",function(e)GameTooltip:Hide()end)CA2.SpecializationLabel.Stat3.HighlightTexture=CA2.SpecializationLabel.Stat3:CreateTexture("CA2CharacterAdvancementMainMainAEButtonHighlightTexture","ARTWORK")CA2.SpecializationLabel.Stat3.HighlightTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_h")CA2.SpecializationLabel.Stat3.HighlightTexture:SetSize(48,48)CA2.SpecializationLabel.Stat3.HighlightTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat3.HighlightTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat3.HighlightTexture:Hide()CA2.SpecializationLabel.Stat3:SetHighlightTexture(CA2.SpecializationLabel.Stat3.HighlightTexture)CA2.SpecializationLabel.Stat3.CheckedTexture=CA2.SpecializationLabel.Stat3:CreateTexture("CA2CharacterAdvancementMainMainAEButtonCheckedTexture","BORDER")CA2.SpecializationLabel.Stat3.CheckedTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_c")CA2.SpecializationLabel.Stat3.CheckedTexture:SetSize(48,48)CA2.SpecializationLabel.Stat3.CheckedTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat3.CheckedTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat3.CheckedTexture:Hide()CA2.SpecializationLabel.Stat3:SetCheckedTexture(CA2.SpecializationLabel.Stat3.CheckedTexture)CA2.SpecializationLabel.Stat3.Icon=CA2.SpecializationLabel.Stat3:CreateTexture("CA2.SpecializationLabel.Stat3.Icon","BORDER")CA2.SpecializationLabel.Stat3.Icon:SetTexture("Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat3.Icon:SetSize(32,32)CA2.SpecializationLabel.Stat3.Icon:SetPoint("CENTER",0,-1)SetPortraitToTexture(CA2.SpecializationLabel.Stat3.Icon,"Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat3.Border=CA2.SpecializationLabel.Stat3:CreateTexture("CA2.SpecializationLabel.Stat3.Border","BACKGROUND")CA2.SpecializationLabel.Stat3.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle")CA2.SpecializationLabel.Stat3.Border:SetSize(50,50)CA2.SpecializationLabel.Stat3.Border:SetPoint("CENTER",0,-1)_G["CA2.SpecializationLabel.Stat3Text"]:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")_G["CA2.SpecializationLabel.Stat3Text"]:SetPoint("BOTTOMRIGHT",0,3)CA2.SpecializationLabel.Stat4=CreateFrame("CheckButton","CA2.SpecializationLabel.Stat4",CA2.SpecializationLabel,"StaticPopupButtonTemplate")CA2.SpecializationLabel.Stat4:SetSize(32,32)CA2.SpecializationLabel.Stat4:SetPoint("LEFT",CA2.SpecializationLabel.Stat3,"RIGHT",12,0)CA2.SpecializationLabel.Stat4:SetNormalTexture(nil)CA2.SpecializationLabel.Stat4:SetDisabledTexture(nil)CA2.SpecializationLabel.Stat4:SetPushedTexture(nil)CA2.SpecializationLabel.Stat4:SetText("Spirit")CA2.SpecializationLabel.Stat4.Id=5
CA2.SpecializationLabel.Stat4:SetScript("OnEnter",function(e)if(e.tooltipTitle)then
GameTooltip_SetDefaultAnchor(GameTooltip,e)GameTooltip:AddLine(e.tooltipTitle)GameTooltip:AddLine(e.tooltipText)GameTooltip:Show()end
end)CA2.SpecializationLabel.Stat4:SetScript("OnLeave",function(e)GameTooltip:Hide()end)CA2.SpecializationLabel.Stat4.HighlightTexture=CA2.SpecializationLabel.Stat4:CreateTexture("CA2CharacterAdvancementMainMainAEButtonHighlightTexture","ARTWORK")CA2.SpecializationLabel.Stat4.HighlightTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_h")CA2.SpecializationLabel.Stat4.HighlightTexture:SetSize(48,48)CA2.SpecializationLabel.Stat4.HighlightTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat4.HighlightTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat4.HighlightTexture:Hide()CA2.SpecializationLabel.Stat4:SetHighlightTexture(CA2.SpecializationLabel.Stat4.HighlightTexture)CA2.SpecializationLabel.Stat4.CheckedTexture=CA2.SpecializationLabel.Stat4:CreateTexture("CA2CharacterAdvancementMainMainAEButtonCheckedTexture","BORDER")CA2.SpecializationLabel.Stat4.CheckedTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle_c")CA2.SpecializationLabel.Stat4.CheckedTexture:SetSize(48,48)CA2.SpecializationLabel.Stat4.CheckedTexture:SetPoint("CENTER",0,-1)CA2.SpecializationLabel.Stat4.CheckedTexture:SetBlendMode("ADD")CA2.SpecializationLabel.Stat4.CheckedTexture:Hide()CA2.SpecializationLabel.Stat4:SetCheckedTexture(CA2.SpecializationLabel.Stat4.CheckedTexture)CA2.SpecializationLabel.Stat4.Icon=CA2.SpecializationLabel.Stat4:CreateTexture("CA2.SpecializationLabel.Stat4.Icon","BORDER")CA2.SpecializationLabel.Stat4.Icon:SetTexture("Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat4.Icon:SetSize(32,32)CA2.SpecializationLabel.Stat4.Icon:SetPoint("CENTER",0,-1)SetPortraitToTexture(CA2.SpecializationLabel.Stat4.Icon,"Interface\\Icons\\inv_misc_book_16")CA2.SpecializationLabel.Stat4.Border=CA2.SpecializationLabel.Stat4:CreateTexture("CA2.SpecializationLabel.Stat4.Border","BACKGROUND")CA2.SpecializationLabel.Stat4.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\StatCircle")CA2.SpecializationLabel.Stat4.Border:SetSize(50,50)CA2.SpecializationLabel.Stat4.Border:SetPoint("CENTER",0,-1)_G["CA2.SpecializationLabel.Stat4Text"]:SetFont("Fonts\\FRIZQT__.TTF",10,"OUTLINE")_G["CA2.SpecializationLabel.Stat4Text"]:SetPoint("BOTTOMRIGHT",0,3)GLOBAL_STAT_CABUTTONS={[1]=CA2.SpecializationLabel.Stat1,[3]=CA2.SpecializationLabel.Stat2,[4]=CA2.SpecializationLabel.Stat3,[5]=CA2.SpecializationLabel.Stat4,}GLOBAL_STATS_INIT=false
CA2.HedaerTabs=CreateFrame("FRAME","CA2.HedaerTabs",CA2)CA2.HedaerTabs:SetSize(CA2.SpecializationLabel:GetWidth(),32)CA2.HedaerTabs:SetPoint("CENTER",CA2.SpecializationLabel,"TOP",0,16)CA2.HedaerTabs.Tab1=CreateFrame("BUTTON","CA2.HedaerTabsTab1",CA2.HedaerTabs,"TabButtonTemplate")CA2.HedaerTabs.Tab1.id=1
CA2.HedaerTabs.Tab1:SetPoint("LEFT",0,0)CA2.HedaerTabs.Tab1:SetText("My Build")CA2.HedaerTabs.Tab1:SetScript("OnShow",function(e)PanelTemplates_TabResize(e,0);_G[e:GetName().."HighlightTexture"]:SetWidth(e:GetTextWidth()+31);end)CA2.HedaerTabs.Tab1:SetScript("OnClick",function(e)PanelTemplates_Tab_OnClick(e,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,e.id);CA2.HedaerTabs.activeTab=e.id
F()end)CA2.HedaerTabs.Tab3=CreateFrame("BUTTON","CA2.HedaerTabsTab3",CA2.HedaerTabs,"TabButtonTemplate")CA2.HedaerTabs.Tab3.id=3
CA2.HedaerTabs.Tab3:SetPoint("LEFT",CA2.HedaerTabs.Tab1,"RIGHT",0,0)CA2.HedaerTabs.Tab3:SetText("My Specs")CA2.HedaerTabs.Tab3:SetScript("OnShow",function(e)PanelTemplates_TabResize(e,0);_G[e:GetName().."HighlightTexture"]:SetWidth(e:GetTextWidth()+31);end)CA2.HedaerTabs.Tab3:SetScript("OnClick",function(e)PanelTemplates_Tab_OnClick(e,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,e.id);CA2.HedaerTabs.activeTab=e.id
F()end)CA2.HedaerTabs.Tab2=CreateFrame("BUTTON","CA2.HedaerTabsTab2",CA2.HedaerTabs,"TabButtonTemplate")CA2.HedaerTabs.Tab2.id=2
CA2.HedaerTabs.Tab2:SetPoint("LEFT",CA2.HedaerTabs.Tab3,"RIGHT",0,0)CA2.HedaerTabs.Tab2:SetText("Load Build")CA2.HedaerTabs.Tab2:Hide()CA2.HedaerTabs.Tab2:SetScript("OnShow",function(e)PanelTemplates_TabResize(e,0);_G[e:GetName().."HighlightTexture"]:SetWidth(e:GetTextWidth()+31);end)CA2.HedaerTabs.Tab2:SetScript("OnClick",function(e)PanelTemplates_Tab_OnClick(e,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,e.id);CA2.HedaerTabs.activeTab=e.id
F()end)CA2.HedaerTabs.activeTab=1
PanelTemplates_SetNumTabs(CA2.HedaerTabs,3);PanelTemplates_SetTab(CA2.HedaerTabs,1);local function A(t)local n={}local e=t:GetText()if not(e)or(e=="")or(e:lower()=="search")then
t:ClearFocus(t)t:SetText("Search")CA2.HSBuilds.LoadData()CA2.HSBuilds.RefreshLayout()return
end
e=e:lower()for a,t in pairs(se)do
local o=t[2]:lower()local a=t[3]:lower()if(string.find(o,e,1,true)or string.find(a,e,1,true))then
table.insert(n,{t[1],t[2],t[3],t[4]})end
end
q(n,1,#n)CA2.HSBuilds.DisplaySearchResults(n)t:ClearFocus(t)end
local function s(n)local o={}local e=n:GetText()if not(e)or(e=="")or(e:lower()==ae:lower())then
n:ClearFocus(n)n:SetText(ae)CA2.HSKnown.LoadData()CA2.HSKnown.RefreshLayout()return
end
e=e:lower()for a,n in pairs(CAO_Spells)do
local t,i=Oe(a)if t and(t~="")then
local r=n[2]local l=n[3]local C=n[4]local n=false
if(CAO_Known[a])then
n=true
end
if(string.find(t,e,1,true)or string.find(i,e,1,true))then
table.insert(o,{a,r,l,C,0,nil,n})end
end
end
for t,a in pairs(CAO_Talents)do
local t,A=Oe(a[2][1])if t and(t~="")then
t=t:lower()local r=a[3]local l=a[4]local c=a[5]local i=false
local n=1
local C=nil
if(string.find(t,e,1,true)or string.find(A,e,1,true))then
local e=a[2]for t,e in pairs(e)do
if(CAO_Known[e])then
n=t
i=true
end
end
C=#e
if not(i)then
r=r*n
l=l*n
end
table.insert(o,{e[n],r,l,c,n,C,i})end
end
end
o=Pe(o)CA2.HSKnown.DisplaySearchResults(o)n:ClearFocus(n)t.Handle("CAO","SearchForSpells",e)end
CA2.SearchBox=CreateFrame("EditBox","CA2.SearchBox",CA2,"InputBoxTemplate")CA2.SearchBox:SetWidth(205)CA2.SearchBox:SetHeight(25.5)CA2.SearchBox:SetFontObject(GameFontNormal)CA2.SearchBox:SetPoint("BOTTOM",CA2.SpecializationLabel,"RIGHT",-115,-59)CA2.SearchBox:ClearFocus(self)CA2.SearchBox:SetAutoFocus(false)CA2.SearchBox:SetFontObject(GameFontDisable)CA2.SearchBox:SetText(ae)CA2.SearchBox:SetScript("OnEnterPressed",s)CA2.SearchBox:SetScript("OnEscapePressed",ClearSearchEscape)CA2.SearchBox.Icon=CA2.SearchBox:CreateTexture(nil,"OVERLAY")CA2.SearchBox.Icon:SetSize(38,38)CA2.SearchBox.Icon:SetPoint("LEFT",-38,-1)CA2.SearchBox.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton")CA2.SearchBox_Builds=CreateFrame("EditBox","CA2.SearchBox_Builds",CA2,"InputBoxTemplate")CA2.SearchBox_Builds:SetWidth(205)CA2.SearchBox_Builds:SetHeight(25.5)CA2.SearchBox_Builds:SetFontObject(GameFontNormal)CA2.SearchBox_Builds:SetPoint("BOTTOM",CA2.SpecializationLabel,"RIGHT",-115,-59)CA2.SearchBox_Builds:ClearFocus(self)CA2.SearchBox_Builds:SetAutoFocus(false)CA2.SearchBox_Builds:SetFontObject(GameFontDisable)CA2.SearchBox_Builds:SetText("Browse Builds")CA2.SearchBox_Builds:SetScript("OnEnterPressed",A)CA2.SearchBox_Builds:SetScript("OnEscapePressed",ClearSearchEscape)CA2.SearchBox_Builds.Icon=CA2.SearchBox_Builds:CreateTexture(nil,"OVERLAY")CA2.SearchBox_Builds.Icon:SetSize(38,38)CA2.SearchBox_Builds.Icon:SetPoint("LEFT",-38,-1)CA2.SearchBox_Builds.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton")CA2.SearchBox_Builds:Hide()CA2.CharacterAdvancementMain.Main=CreateFrame("FRAME","CA2CharacterAdvancementMainMain",CA2.CharacterAdvancementMain)CA2.CharacterAdvancementMain.Main:SetSize(re,560)CA2.CharacterAdvancementMain.Main:SetPoint("LEFT",CA2,0,-56)CA2.CharacterAdvancementMain.Main.SpellsText=CA2.CharacterAdvancementMain.Main:CreateFontString("CA2.CharacterAdvancementMain.Main.SpellsText")CA2.CharacterAdvancementMain.Main.SpellsText:SetFont("Fonts\\MORPHEUS.TTF",24)CA2.CharacterAdvancementMain.Main.SpellsText:SetFontObject(GameFontHighlight)CA2.CharacterAdvancementMain.Main.SpellsText:SetPoint("TOPLEFT",0,-15)CA2.CharacterAdvancementMain.Main.SpellsText:SetSize(417,22)CA2.CharacterAdvancementMain.Main.SpellsText:SetText("Abilities")CA2.CharacterAdvancementMain.Main.SpellsText:SetJustifyH("CENTER")CA2.CharacterAdvancementMain.Main.SpellsSubText=CA2.CharacterAdvancementMain.Main:CreateFontString("CA2.CharacterAdvancementMain.Main.SpellsSubText")CA2.CharacterAdvancementMain.Main.SpellsSubText:SetFont("Fonts\\FRIZQT__.TTF",12)CA2.CharacterAdvancementMain.Main.SpellsSubText:SetFontObject(GameFontNormal)CA2.CharacterAdvancementMain.Main.SpellsSubText:SetPoint("CENTER",CA2.CharacterAdvancementMain.Main.SpellsText,"BOTTOM",0,-8)CA2.CharacterAdvancementMain.Main.SpellsSubText:SetHeight(22)CA2.CharacterAdvancementMain.Main.SpellsSubText:SetText("Craft your hero")CA2.CharacterAdvancementMain.Main.SpellsSubText:SetJustifyH("CENTER")CA2.CharacterAdvancementMain.Main.TalentsText=CA2.CharacterAdvancementMain.Main:CreateFontString("CA2.CharacterAdvancementMain.Main.TalentsText")CA2.CharacterAdvancementMain.Main.TalentsText:SetFont("Fonts\\MORPHEUS.TTF",24)CA2.CharacterAdvancementMain.Main.TalentsText:SetFontObject(GameFontHighlight)CA2.CharacterAdvancementMain.Main.TalentsText:SetPoint("TOPRIGHT",-8,-15)CA2.CharacterAdvancementMain.Main.TalentsText:SetSize(355,22)CA2.CharacterAdvancementMain.Main.TalentsText:SetText("Talents")CA2.CharacterAdvancementMain.Main.TalentsText:SetJustifyH("CENTER")CA2.CharacterAdvancementMain.Main.TalentsSubText=CA2.CharacterAdvancementMain.Main:CreateFontString("CA2.CharacterAdvancementMain.Main.TalentsSubText")CA2.CharacterAdvancementMain.Main.TalentsSubText:SetFont("Fonts\\FRIZQT__.TTF",12)CA2.CharacterAdvancementMain.Main.TalentsSubText:SetFontObject(GameFontNormal)CA2.CharacterAdvancementMain.Main.TalentsSubText:SetPoint("CENTER",CA2.CharacterAdvancementMain.Main.TalentsText,"BOTTOM",0,-8)CA2.CharacterAdvancementMain.Main.TalentsSubText:SetHeight(22)CA2.CharacterAdvancementMain.Main.TalentsSubText:SetText("Improve your power")CA2.CharacterAdvancementMain.Main.TalentsSubText:SetJustifyH("CENTER")CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.SpellsSubText,"RIGHT",4,0)CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetSize(16,16)CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton.tooltipText=""CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetScript("OnEnter",function(e)if(e.tooltipText)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT");GameTooltip:SetText(e.tooltipText,nil,nil,nil,nil,1);end
GameTooltip:Show()end)CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.TalentsSubText,"RIGHT",4,0)CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetSize(16,16)CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton.tooltipText="Talents are available after level 10."CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetScript("OnEnter",function(e)if(e.tooltipText)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT");GameTooltip:SetText(e.tooltipText,nil,nil,nil,nil,1);end
GameTooltip:Show()end)CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.CharacterAdvancementMain.Main.BottomFrame=CreateFrame("FRAME","CA2.CharacterAdvancementMain.Main.BottomFrame",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.BottomFrame:SetSize(CA2.CharacterAdvancementMain.Main:GetWidth(),32)CA2.CharacterAdvancementMain.Main.BottomFrame:SetPoint("BOTTOM",0,-4)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton=CreateFrame("Button","CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton",CA2.CharacterAdvancementMain.Main.BottomFrame,"StaticPopupButtonTemplate")CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetSize(131,22)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame,"CENTER",33,0)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetText("Reset All Talents")CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetScript("OnClick",function()local n,e=ResetFrame_GetPurgeCost("talent")StaticPopupDialogs["ASC_RESET"].text="Reset cost:\n"..n..".\n\nNext reset will cost you:\n"..e.."."StaticPopupDialogs["ASC_RESET"].OnAccept=function()t.Handle("sideBar","ResetTalents")end
StaticPopup_Show("ASC_RESET")end)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset known talents|r")GameTooltip:AddLine("You can reset for gold or currenty.")GameTooltip:AddLine("You have |cffFFFFFFx"..GetItemCount(383083).." |TInterface\\Icons\\inv_custom_talentpurge.blp:13:13|t Talent Purge|r.")GameTooltip:Show()end)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)MagicButton_OnLoad(CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton)if(S<10)then
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:Disable()end
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton=CreateFrame("Button","CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton",CA2.CharacterAdvancementMain.Main.BottomFrame,"StaticPopupButtonTemplate")CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetSize(131,22)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetPoint("RIGHT",CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton,"LEFT",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetText("Reset All Abilities")CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetScript("OnClick",function()local e,n=ResetFrame_GetPurgeCost("ability")if(IN_RM_MODE or IN_DRAFT_MODE)then
StaticPopupDialogs["ASC_RESET"].text="|cffFF0000Not available in your game mode.|r"StaticPopupDialogs["ASC_RESET"].OnAccept=nil
else
StaticPopupDialogs["ASC_RESET"].text="Reset cost:\n"..e..".\n\nNext reset will cost you:\n"..n.."."StaticPopupDialogs["ASC_RESET"].OnAccept=function()t.Handle("sideBar","ResetSpells")end
end
StaticPopup_Show("ASC_RESET")end)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset known abilities|r")GameTooltip:AddLine("You can reset for gold or currenty.")GameTooltip:AddLine("You have |cffFFFFFFx"..GetItemCount(383082).." |TInterface\\Icons\\inv_custom_abilitypurge.blp:13:13|t Ability Purge|r.")GameTooltip:Show()end)CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)MagicButton_OnLoad(CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE",CA2.CharacterAdvancementMain.Main.BottomFrame)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:SetSize(287,22)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:SetPoint("RIGHT",CA2.CharacterAdvancementMain.Main.BottomFrame.ResetSpellsButton,"LEFT",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left:SetSize(6,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left:SetPoint("LEFT",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left:SetTexCoord(0,.01171875,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left:SetTexture("Interface\\Buttons\\UI-Button-Borders2")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle:SetSize(273,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Left,"RIGHT")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle:SetTexCoord(.01171875,.3046875,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle:SetTexture("Interface\\Buttons\\UI-Button-Borders2")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Right=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Right:SetSize(6,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Right:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Middle,"RIGHT")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Right:SetTexCoord(.3046875,.31640625,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.BG_Right:SetTexture("Interface\\Buttons\\UI-Button-Borders2")MagicButton_OnLoad(CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE",CA2.CharacterAdvancementMain.Main.BottomFrame)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:SetSize(233,22)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton,"RIGHT",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left:SetSize(6,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left:SetPoint("LEFT",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left:SetTexCoord(0,.01171875,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left:SetTexture("Interface\\Buttons\\UI-Button-Borders2")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle:SetSize(217,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Left,"RIGHT")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle:SetTexCoord(.01171875,.3046875,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle:SetTexture("Interface\\Buttons\\UI-Button-Borders2")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Right=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE:CreateTexture(nil,"ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Right:SetSize(6,19)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Right:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Middle,"RIGHT")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Right:SetTexCoord(.3046875,.31640625,.421875,.5625)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.BG_Right:SetTexture("Interface\\Buttons\\UI-Button-Borders2")MagicButton_OnLoad(CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:SetSize(16,16)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:SetPoint("BOTTOMRIGHT",-8,2)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Item=k
CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:SetScript("OnEnter",ItemButtonOnEnter)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:SetScript("OnClick",ItemButtonOnClick)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Icon=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:CreateTexture("CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButtonAEIcon","ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Icon:SetSize(14,14)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Icon:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Icon:SetTexture("Interface\\Icons\\inv_custom_abilityessence")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton:CreateFontString("CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButtonAEText")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetFontObject(GameFontNormal)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetPoint("LEFT",-112,1)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetText("Ability Essence: |cffFFFFFF10|r")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetSize(112,16)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetJustifyH("RIGHT")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton",CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:SetSize(16,16)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:SetPoint("BOTTOMRIGHT",-8,2)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Item=J
CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:SetScript("OnEnter",ItemButtonOnEnter)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:SetScript("OnClick",ItemButtonOnClick)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Icon=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:CreateTexture("CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButtonAEIcon","ARTWORK")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Icon:SetSize(14,14)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Icon:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Icon:SetTexture("Interface\\Icons\\inv_custom_talentessence")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text=CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton:CreateFontString("CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButtonAEText")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetFontObject(GameFontNormal)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetPoint("LEFT",-112,1)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetText("Talent Essence: |cffFFFFFF10|r")CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetSize(112,16)CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetJustifyH("RIGHT")CA2.CharacterAdvancementMain.Main.ShareButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.ShareButton",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.ShareButton:SetSize(32,32)CA2.CharacterAdvancementMain.Main.ShareButton:SetPoint("TOPRIGHT",-108,28)CA2.CharacterAdvancementMain.Main.ShareButton:SetNormalTexture("Interface\\Buttons\\UI-SquareButton-Up")CA2.CharacterAdvancementMain.Main.ShareButton:SetPushedTexture("Interface\\Buttons\\UI-SquareButton-Down")CA2.CharacterAdvancementMain.Main.ShareButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")CA2.CharacterAdvancementMain.Main.ShareButton.Icon=CA2.CharacterAdvancementMain.Main.ShareButton:CreateTexture("CA2.CharacterAdvancementMain.Main.ShareButtonAEIcon","OVERLAY")CA2.CharacterAdvancementMain.Main.ShareButton.Icon:SetSize(16,16)CA2.CharacterAdvancementMain.Main.ShareButton.Icon:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.ShareButton.Icon:SetTexture("Interface\\Buttons\\UI-ChatIcon-Share")CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed=CA2.CharacterAdvancementMain.Main.ShareButton:CreateTexture("CA2.CharacterAdvancementMain.Main.ShareButtonAEIcon","OVERLAY")CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed:SetSize(16,16)CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed:SetPoint("CENTER",-1,-1)CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed:SetTexture("Interface\\Buttons\\UI-ChatIcon-Share")CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed:SetVertexColor(.6,.6,.6,1)CA2.CharacterAdvancementMain.Main.ShareButton.IconPushed:Hide()CA2.CharacterAdvancementMain.Main.ShareButton.Text=CA2.CharacterAdvancementMain.Main.ShareButton:CreateFontString("CA2.CharacterAdvancementMain.Main.ShareButtonAEText")CA2.CharacterAdvancementMain.Main.ShareButton.Text:SetFontObject(GameFontHighlightSmall)CA2.CharacterAdvancementMain.Main.ShareButton.Text:SetPoint("RIGHT",CA2.CharacterAdvancementMain.Main.ShareButton,"LEFT",-4,0)CA2.CharacterAdvancementMain.Main.ShareButton.Text:SetText("Share build")CA2.CharacterAdvancementMain.Main.ShareButton.Text:SetJustifyH("RIGHT")CA2.CharacterAdvancementMain.Main.ShareButton:SetScript("OnMouseDown",function(e)e.Icon:Hide()e.IconPushed:Show()end)CA2.CharacterAdvancementMain.Main.ShareButton:SetScript("OnMouseUp",function(e)e.Icon:Show()e.IconPushed:Hide()end)CA2.CharacterAdvancementMain.Main.ShareButton:SetScript("OnClick",function()StaticPopupDialogs["ASC_LINK_DIALOGUE"].OnAccept()end)CA2.CharacterAdvancementMain.Main.LoadBuildButton=CreateFrame("BUTTON","CA2.CharacterAdvancementMain.Main.LoadBuildButton",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetSize(32,32)CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetNormalTexture("Interface\\Buttons\\UI-SquareButton-Up")CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetPushedTexture("Interface\\Buttons\\UI-SquareButton-Down")CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")CA2.CharacterAdvancementMain.Main.LoadBuildButton.Icon=CA2.CharacterAdvancementMain.Main.LoadBuildButton:CreateTexture("CA2.CharacterAdvancementMain.Main.LoadBuildButtonAEIcon","OVERLAY")CA2.CharacterAdvancementMain.Main.LoadBuildButton.Icon:SetSize(20,20)CA2.CharacterAdvancementMain.Main.LoadBuildButton.Icon:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.LoadBuildButton.Icon:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed=CA2.CharacterAdvancementMain.Main.LoadBuildButton:CreateTexture("CA2.CharacterAdvancementMain.Main.LoadBuildButtonAEIcon","OVERLAY")CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed:SetSize(20,20)CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed:SetPoint("CENTER",-1,-1)CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed:SetVertexColor(.6,.6,.6,1)CA2.CharacterAdvancementMain.Main.LoadBuildButton.IconPushed:Hide()CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text=CA2.CharacterAdvancementMain.Main.LoadBuildButton:CreateFontString("CA2.CharacterAdvancementMain.Main.LoadBuildButtonAEText")CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text:SetFontObject(GameFontHighlightSmall)CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.ShareButton,"RIGHT",8,0)CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text:SetText("Load build")CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text:SetJustifyH("RIGHT")CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.LoadBuildButton.Text,"RIGHT",4,0)CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetScript("OnMouseDown",function(e)e.Icon:Hide()e.IconPushed:Show()end)CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetScript("OnMouseUp",function(e)e.Icon:Show()e.IconPushed:Hide()end)CA2.CharacterAdvancementMain.Main.LoadBuildButton:SetScript("OnClick",function()PanelTemplates_Tab_OnClick(CA2.HedaerTabs.Tab2,CA2.HedaerTabs)PanelTemplates_SetTab(CA2.HedaerTabs,CA2.HedaerTabs.Tab2.id);CA2.HedaerTabs.activeTab=CA2.HedaerTabs.Tab2.id
BC_Editor_NewBuild()F()StaticPopup_Show("ASC_LOADBUILDFROMLINK")end)CA2.CharacterAdvancementMain.Main.Tree1=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree1",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.Tree1:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree1:SetPoint("LEFT",5,35)CA2.CharacterAdvancementMain.Main.Tree1.Tab=CreateFrame("CheckButton","CA2.CharacterAdvancementMain.Main.Tree1.Tab",CA2.CharacterAdvancementMain.Main.Tree1,"StaticPopupButtonTemplate")CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetNormalTexture("Interface\\SpellBook\\UI-SpellBook-Tab-Unselected")CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetHighlightTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetCheckedTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetPushedTexture(nil)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetSize(128,64)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetPoint("TOPLEFT",0,9)CA2.CharacterAdvancementMain.Main.Tree1.Tab:GetNormalTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree1.Tab:GetHighlightTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree1.Tab:GetCheckedTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetNormalFontObject(GameFontNormalSmall)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetDisabledFontObject(GameFontDisableSmall)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetHighlightFontObject(GameFontHighlightSmall)_G["CA2.CharacterAdvancementMain.Main.Tree1.TabText"]:SetPoint("CENTER",0,-2)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetScript("OnEnter",function(e)end)CA2.CharacterAdvancementMain.Main.Tree1.Tab:SetScript("OnClick",H)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame=CreateFrame("FRAME","CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame",CA2.CharacterAdvancementMain.Main.Tree1.Tab,nil)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree1.Tab,"RIGHT",-32,-1)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon=CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:CreateTexture(nil,"BACKGROUND")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon:SetSize(42,42)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon2=CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:CreateTexture(nil,"BORDER")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon2:SetSize(28,28)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon2:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.BGIcon2:SetVertexColor(.2,.2,.2,1)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total=CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:CreateFontString("CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total","OVERLAY")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total:SetText("2")CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame.Total:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree1.Tab.TotalSpellsFrame:Hide()CA2.CharacterAdvancementMain.Main.Tree1.Tab:Show()CA2.CharacterAdvancementMain.Main.Tree2=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree2",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.Tree2:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree2:SetPoint("LEFT",5,35)CA2.CharacterAdvancementMain.Main.Tree2.Tab=CreateFrame("CheckButton","CA2.CharacterAdvancementMain.Main.Tree2.Tab",CA2.CharacterAdvancementMain.Main.Tree2,"StaticPopupButtonTemplate")CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetNormalTexture("Interface\\SpellBook\\UI-SpellBook-Tab-Unselected")CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetHighlightTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetCheckedTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetPushedTexture(nil)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetSize(128,64)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree1.Tab,"RIGHT",-16,0)CA2.CharacterAdvancementMain.Main.Tree2.Tab:GetNormalTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree2.Tab:GetHighlightTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree2.Tab:GetCheckedTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetNormalFontObject(GameFontNormalSmall)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetDisabledFontObject(GameFontDisableSmall)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetHighlightFontObject(GameFontHighlightSmall)_G["CA2.CharacterAdvancementMain.Main.Tree2.TabText"]:SetPoint("CENTER",0,-2)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetScript("OnEnter",function(e)end)CA2.CharacterAdvancementMain.Main.Tree2.Tab:SetScript("OnClick",H)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame=CreateFrame("FRAME","CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame",CA2.CharacterAdvancementMain.Main.Tree2.Tab,nil)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree2.Tab,"RIGHT",-32,-1)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon=CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:CreateTexture(nil,"BACKGROUND")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon:SetSize(42,42)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon2=CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:CreateTexture(nil,"BORDER")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon2:SetSize(28,28)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon2:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.BGIcon2:SetVertexColor(.2,.2,.2,1)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total=CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:CreateFontString("CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total","OVERLAY")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total:SetText("2")CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame.Total:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree2.Tab.TotalSpellsFrame:Hide()CA2.CharacterAdvancementMain.Main.Tree2.Tab:Show()CA2.CharacterAdvancementMain.Main.Tree3=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree3",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.Tree3:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree3:SetPoint("LEFT",5,35)CA2.CharacterAdvancementMain.Main.Tree3=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree3",CA2.CharacterAdvancementMain.Main)CA2.CharacterAdvancementMain.Main.Tree3:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree3:SetPoint("LEFT",5,35)CA2.CharacterAdvancementMain.Main.Tree3.Tab=CreateFrame("CheckButton","CA2.CharacterAdvancementMain.Main.Tree3.Tab",CA2.CharacterAdvancementMain.Main.Tree3,"StaticPopupButtonTemplate")CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetNormalTexture("Interface\\SpellBook\\UI-SpellBook-Tab-Unselected")CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetHighlightTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetCheckedTexture("Interface\\SpellBook\\UI-SpellbookPanel-Tab-Highlight")CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetPushedTexture(nil)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetSize(128,64)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree2.Tab,"RIGHT",-16,0)CA2.CharacterAdvancementMain.Main.Tree3.Tab:GetNormalTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree3.Tab:GetHighlightTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree3.Tab:GetCheckedTexture():SetTexCoord(0,1,1,0)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetNormalFontObject(GameFontNormalSmall)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetDisabledFontObject(GameFontDisableSmall)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetHighlightFontObject(GameFontHighlightSmall)_G["CA2.CharacterAdvancementMain.Main.Tree3.TabText"]:SetPoint("CENTER",0,-2)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetScript("OnEnter",function(e)end)CA2.CharacterAdvancementMain.Main.Tree3.Tab:SetScript("OnClick",H)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame=CreateFrame("FRAME","CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame",CA2.CharacterAdvancementMain.Main.Tree3.Tab,nil)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:SetPoint("LEFT",CA2.CharacterAdvancementMain.Main.Tree3.Tab,"RIGHT",-32,-1)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon=CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:CreateTexture(nil,"BACKGROUND")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon:SetSize(42,42)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon2=CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:CreateTexture(nil,"BORDER")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-placeholder")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon2:SetSize(28,28)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon2:SetPoint("CENTER",1,-1)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.BGIcon2:SetVertexColor(.2,.2,.2,1)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total=CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:CreateFontString("CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total","OVERLAY")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total:SetFont("Fonts\\FRIZQT__.TTF",10)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total:SetPoint("CENTER",0,0)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total:SetText("2")CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame.Total:SetSize(32,32)CA2.CharacterAdvancementMain.Main.Tree3.Tab.TotalSpellsFrame:Hide()CA2.CharacterAdvancementMain.Main.Tree3.Tab:Show()CA2.CharacterAdvancementMain.Main.Tree1.Content=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree1Content",CA2.CharacterAdvancementMain.Main.Tree1)CA2.CharacterAdvancementMain.Main.Tree1.Content:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree1.Content:SetPoint("CENTER")CA2.CharacterAdvancementMain.Main.Tree1.Content.Spells=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree1ContentSpells",CA2.CharacterAdvancementMain.Main.Tree1.Content)CA2.CharacterAdvancementMain.Main.Tree1.Content.Spells:SetSize(417,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree1.Content.Spells:SetPoint("LEFT",0,-32)CA2.CharacterAdvancementMain.Main.Tree1.Content.Talents=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree1ContentTalents",CA2.CharacterAdvancementMain.Main.Tree1.Content)CA2.CharacterAdvancementMain.Main.Tree1.Content.Talents:SetSize(355,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree1.Content.Talents:SetPoint("RIGHT",-8,-32)for e=1,U do
W(1,e)end
for e=1,z do
Z(1,e)end
local e=1
for t=1,10 do
for n=1,3 do
if(e<=30)then
Se(_G["CA2.CharacterAdvancementMain.Main.Tree1.Content.Spells.Button"..e],t,n)e=e+1
end
end
end
e=1
for t=1,11 do
for n=1,4 do
Be(_G["CA2.CharacterAdvancementMain.Main.Tree1.Content.Talents.Button"..e],t,n)e=e+1
end
end
CA2.CharacterAdvancementMain.Main.Tree2.Content=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree2Content",CA2.CharacterAdvancementMain.Main.Tree2)CA2.CharacterAdvancementMain.Main.Tree2.Content:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree2.Content:SetPoint("CENTER")CA2.CharacterAdvancementMain.Main.Tree2.Content.Spells=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree2ContentSpells",CA2.CharacterAdvancementMain.Main.Tree2.Content)CA2.CharacterAdvancementMain.Main.Tree2.Content.Spells:SetSize(417,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree2.Content.Spells:SetPoint("LEFT",0,-32)CA2.CharacterAdvancementMain.Main.Tree2.Content.Talents=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree2ContentTalents",CA2.CharacterAdvancementMain.Main.Tree2.Content)CA2.CharacterAdvancementMain.Main.Tree2.Content.Talents:SetSize(355,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree2.Content.Talents:SetPoint("RIGHT",-8,-32)for e=1,U do
W(2,e)end
for e=1,z do
Z(2,e)end
local e=1
for n=1,10 do
for t=1,3 do
if(e<=30)then
Se(_G["CA2.CharacterAdvancementMain.Main.Tree2.Content.Spells.Button"..e],n,t)e=e+1
end
end
end
e=1
for n=1,11 do
for t=1,4 do
Be(_G["CA2.CharacterAdvancementMain.Main.Tree2.Content.Talents.Button"..e],n,t)e=e+1
end
end
CA2.CharacterAdvancementMain.Main.Tree3.Content=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree3Content",CA2.CharacterAdvancementMain.Main.Tree3)CA2.CharacterAdvancementMain.Main.Tree3.Content:SetSize(CA2.CharacterAdvancementMain.Main:GetSize())CA2.CharacterAdvancementMain.Main.Tree3.Content:SetPoint("CENTER")CA2.CharacterAdvancementMain.Main.Tree3.Content.Spells=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree3ContentSpells",CA2.CharacterAdvancementMain.Main.Tree3.Content)CA2.CharacterAdvancementMain.Main.Tree3.Content.Spells:SetSize(417,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree3.Content.Spells:SetPoint("LEFT",0,-32)CA2.CharacterAdvancementMain.Main.Tree3.Content.Talents=CreateFrame("FRAME","CA2CharacterAdvancementMainMainTree3ContentTalents",CA2.CharacterAdvancementMain.Main.Tree3.Content)CA2.CharacterAdvancementMain.Main.Tree3.Content.Talents:SetSize(355,CA2.CharacterAdvancementMain.Main:GetHeight())CA2.CharacterAdvancementMain.Main.Tree3.Content.Talents:SetPoint("RIGHT",-8,-32)for e=1,U do
W(3,e)end
for e=1,z do
Z(3,e)end
local e=1
for t=1,10 do
for n=1,3 do
if(e<=30)then
Se(_G["CA2.CharacterAdvancementMain.Main.Tree3.Content.Spells.Button"..e],t,n)e=e+1
end
end
end
e=1
for n=1,11 do
for t=1,4 do
Be(_G["CA2.CharacterAdvancementMain.Main.Tree3.Content.Talents.Button"..e],n,t)e=e+1
end
end
function SelectedDropDown_Initialize()local e;if(SelectedSpellDropDown.SpellId)then
local n,a,t=GetSpellInfo(SelectedSpellDropDown.SpellId)e=UIDropDownMenu_CreateInfo()e.text=n
e.func=nil
e.icon=t
e.isTitle=true
UIDropDownMenu_AddButton(e)end
e=UIDropDownMenu_CreateInfo()e.text="Learn"e.func=nil
e.disabled=true
e.tooltipTitle="Click to learn"e.tooltipText="You can also double-click the icon to learn"if(SelectedSpellDropDown.CanLearn)then
e.func=function()Me(nil,true)end
e.disabled=false
end
UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Unlearn"e.func=nil
e.disabled=true
if(SelectedSpellDropDown.CanUnlearn)then
e.func=Ye
e.disabled=false
end
UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Close"e.func=nil
UIDropDownMenu_AddButton(e)end
SelectedSpellDropDown=CreateFrame("FRAME","SelectedSpellDropDown",CA2.CharacterAdvancementMain,"UIDropDownMenuTemplate")SelectedSpellDropDown.SpellId=25
SelectedSpellDropDown.CanLearn=false
SelectedSpellDropDown.CanUnlearn=false
SelectedSpellDropDown:SetClampedToScreen(true)SelectedSpellDropDown:Hide()UIDropDownMenu_Initialize(SelectedSpellDropDown,SelectedDropDown_Initialize,"MENU");function BC_CreateSpellDropDown_Initialize()local e;if(BC_CreateSpellDropDown.Level)then
e=UIDropDownMenu_CreateInfo()e.text="Level |cffFFFFFF"..BC_CreateSpellDropDown.Level.."|r data"e.func=nil
e.isTitle=true
UIDropDownMenu_AddButton(e)if(a[BC_CreateSpellDropDown.Level])then
e=UIDropDownMenu_CreateInfo()e.text="Available "..a[BC_CreateSpellDropDown.Level][1]e.func=nil
e.disabled=true
e.icon="Interface\\Icons\\inv_custom_abilityessence"UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Available "..a[BC_CreateSpellDropDown.Level][2]e.func=nil
e.disabled=true
e.icon="Interface\\Icons\\inv_custom_talentessence"UIDropDownMenu_AddButton(e)end
end
e=UIDropDownMenu_CreateInfo()e.text="Add Spell/Talent"e.func=BuildCreator_ChooseSpellProcess
e.tooltipTitle="Click to add spell"e.tooltipText="Simply choose a spell or talent in Character Advancement and it will be added to your build on a proper level."UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Close"e.func=nil
UIDropDownMenu_AddButton(e)end
BC_CreateSpellDropDown=CreateFrame("FRAME","BC_CreateSpellDropDown",CA2.CharacterAdvancementMain,"UIDropDownMenuTemplate")BC_CreateSpellDropDown.Level=1
BC_CreateSpellDropDown:SetClampedToScreen(true)BC_CreateSpellDropDown:Hide()UIDropDownMenu_Initialize(BC_CreateSpellDropDown,BC_CreateSpellDropDown_Initialize,"MENU");function BC_AddArmorSpellDropDown_Initialize(e,t)local e;local a=t or 1
if(a==2)then
for n,t in pairs(Fe)do
local n,o,a=GetSpellInfo(t)e=UIDropDownMenu_CreateInfo()e.icon=a
e.text=n
e.func=HandleArmorAddToBuildCreator
e.value=t
e.tooltipTitle=n
e.tooltipText="Click to add to the list of weapon/armor recommendations"for a,n in pairs(i)do
if(n==t)then
e.disabled=true
end
end
UIDropDownMenu_AddButton(e,2)end
end
if(a==1)then
e=UIDropDownMenu_CreateInfo()e.text="Add weapon/armor recommendation"e.func=nil
e.isTitle=true
UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Add"e.func=nil
e.tooltipTitle="Choose armor/weapon recommendation"e.tooltipText="Simply click on an armor or weapon recommendation in a list to add it."e.hasArrow=1
UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Close"e.func=nil
UIDropDownMenu_AddButton(e)end
end
BC_AddArmorSpellDropDown=CreateFrame("FRAME","BC_AddArmorSpellDropDown",CA2.CharacterAdvancementMain,"UIDropDownMenuTemplate")BC_AddArmorSpellDropDown:SetClampedToScreen(true)BC_AddArmorSpellDropDown:Hide()UIDropDownMenu_Initialize(BC_AddArmorSpellDropDown,BC_AddArmorSpellDropDown_Initialize,"MENU");function BC_SettingsDropDown_Initialize()local e;local t=BC_SettingsSpellDropDown.SpellId
if(t)then
local t,a,n=GetSpellInfo(t)e=UIDropDownMenu_CreateInfo()e.text=t
e.func=nil
e.icon=n
e.isTitle=true
UIDropDownMenu_AddButton(e)end
e=UIDropDownMenu_CreateInfo()e.text="Remove"e.func=BC_HandleItemRemove
e.tooltipTitle="Remove"e.tooltipText="Click to remove from build"UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Add tip"e.func=BC_HandleAddTip
e.tooltipTitle="Add author's tip"e.tooltipText="Click to enter special description"UIDropDownMenu_AddButton(e)e=UIDropDownMenu_CreateInfo()e.text="Close"e.func=nil
UIDropDownMenu_AddButton(e)end
BC_SettingsSpellDropDown=CreateFrame("FRAME","BC_SettingsSpellDropDown",CA2.CharacterAdvancementMain,"UIDropDownMenuTemplate")BC_SettingsSpellDropDown.SpellId=25
BC_SettingsSpellDropDown.type="SPELL"BC_SettingsSpellDropDown.Level=1
BC_SettingsSpellDropDown:SetClampedToScreen(true)BC_SettingsSpellDropDown:Hide()UIDropDownMenu_Initialize(BC_SettingsSpellDropDown,BC_SettingsDropDown_Initialize,"MENU");CA2.Art=CreateFrame("FRAME","CA2.Art",CA2)CA2.Art:SetPoint("CENTER",-525,-182)CA2.Art:SetSize(1024,1024)CA2.Art:SetScale(1.09)CA2.Art:SetFrameLevel(1)CA2.Art.ClassTexture=CA2.Art:CreateTexture("CA2.Art.ClassTexture","BORDER")CA2.Art.ClassTexture:SetSize(256,256)CA2.Art.ClassTexture:SetPoint("LEFT",615,180)CA2.Art.ClassTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\artifactbook-mage-cover")CA2.Art.ClassTexture:SetAlpha(.4)CA2.Art.Art1=CA2.Art:CreateTexture("CA2.Art.Art1","BORDER")CA2.Art.Art1:SetSize(256,256)CA2.Art.Art1:SetPoint("TOPRIGHT",0,-128)CA2.Art.Art1:SetTexCoord(1,0,0,1)CA2.Art.Art2=CA2.Art:CreateTexture("CA2.Art.Art2","BORDER")CA2.Art.Art2:SetSize(256,256)CA2.Art.Art2:SetPoint("LEFT",CA2.Art.Art1,"RIGHT")CA2.Art.Art2:SetTexCoord(1,0,0,1)CA2.Art.Art3=CA2.Art:CreateTexture("CA2.Art.Art3","BORDER")CA2.Art.Art3:SetSize(240,256)CA2.Art.Art3:SetPoint("LEFT",CA2.Art.Art2,"RIGHT")CA2.Art.Art3:SetTexCoord(1,0,0,1)CA2.Art.Art3:SetAlpha(.3)CA2.Art.Art4=CA2.Art:CreateTexture("CA2.Art.Art4","BORDER")CA2.Art.Art4:SetSize(256,256)CA2.Art.Art4:SetPoint("LEFT",CA2.Art.Art3,"RIGHT")CA2.Art.Art4:SetTexCoord(1,0,0,1)CA2.Art.Art5=CA2.Art:CreateTexture("CA2.Art.Art5","BORDER")CA2.Art.Art5:SetSize(256,256)CA2.Art.Art5:SetPoint("TOP",CA2.Art.Art1,"BOTTOM")CA2.Art.Art5:SetTexCoord(1,0,0,1)CA2.Art.Art6=CA2.Art:CreateTexture("CA2.Art.Art6","BORDER")CA2.Art.Art6:SetSize(256,256)CA2.Art.Art6:SetPoint("LEFT",CA2.Art.Art5,"RIGHT")CA2.Art.Art6:SetTexCoord(1,0,0,1)CA2.Art.Art7=CA2.Art:CreateTexture("CA2.Art.Art7","BORDER")CA2.Art.Art7:SetSize(240,256)CA2.Art.Art7:SetPoint("LEFT",CA2.Art.Art6,"RIGHT")CA2.Art.Art7:SetTexCoord(1,0,0,1)CA2.Art.Art7:SetAlpha(.3)CA2.Art.Art8=CA2.Art:CreateTexture("CA2.Art.Art8","BORDER")CA2.Art.Art8:SetSize(256,256)CA2.Art.Art8:SetPoint("LEFT",CA2.Art.Art7,"RIGHT")CA2.Art.Art8:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec1=CA2.Art:CreateTexture("CA2.Art.Art_Sec1","BORDER")CA2.Art.Art_Sec1:SetSize(256,256)CA2.Art.Art_Sec1:SetPoint("TOPRIGHT",0,-128)CA2.Art.Art_Sec1:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec2=CA2.Art:CreateTexture("CA2.Art.Art_Sec2","BORDER")CA2.Art.Art_Sec2:SetSize(256,256)CA2.Art.Art_Sec2:SetPoint("LEFT",CA2.Art.Art_Sec1,"RIGHT")CA2.Art.Art_Sec2:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec3=CA2.Art:CreateTexture("CA2.Art.Art_Sec3","BORDER")CA2.Art.Art_Sec3:SetSize(240,256)CA2.Art.Art_Sec3:SetPoint("LEFT",CA2.Art.Art_Sec2,"RIGHT")CA2.Art.Art_Sec3:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec3:SetAlpha(.3)CA2.Art.Art_Sec4=CA2.Art:CreateTexture("CA2.Art.Art_Sec4","BORDER")CA2.Art.Art_Sec4:SetSize(256,256)CA2.Art.Art_Sec4:SetPoint("LEFT",CA2.Art.Art_Sec3,"RIGHT")CA2.Art.Art_Sec4:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec5=CA2.Art:CreateTexture("CA2.Art.Art_Sec5","BORDER")CA2.Art.Art_Sec5:SetSize(256,256)CA2.Art.Art_Sec5:SetPoint("TOP",CA2.Art.Art_Sec1,"BOTTOM")CA2.Art.Art_Sec5:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec6=CA2.Art:CreateTexture("CA2.Art.Art_Sec6","BORDER")CA2.Art.Art_Sec6:SetSize(256,256)CA2.Art.Art_Sec6:SetPoint("LEFT",CA2.Art.Art_Sec5,"RIGHT")CA2.Art.Art_Sec6:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec7=CA2.Art:CreateTexture("CA2.Art.Art_Sec7","BORDER")CA2.Art.Art_Sec7:SetSize(240,256)CA2.Art.Art_Sec7:SetPoint("LEFT",CA2.Art.Art_Sec6,"RIGHT")CA2.Art.Art_Sec7:SetTexCoord(1,0,0,1)CA2.Art.Art_Sec7:SetAlpha(.3)CA2.Art.Art_Sec8=CA2.Art:CreateTexture("CA2.Art.Art_Sec8","BORDER")CA2.Art.Art_Sec8:SetSize(256,256)CA2.Art.Art_Sec8:SetPoint("LEFT",CA2.Art.Art_Sec7,"RIGHT")CA2.Art.Art_Sec8:SetTexCoord(1,0,0,1)CA2.Art.Art1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel3")CA2.Art.Art2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel2")CA2.Art.Art3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel1")CA2.Art.Art4:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel4")CA2.Art.Art5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel7")CA2.Art.Art6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel6")CA2.Art.Art7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel5")CA2.Art.Art8:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel8")CA2.Art.Art_Sec1:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel3")CA2.Art.Art_Sec2:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel2")CA2.Art.Art_Sec3:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel1")CA2.Art.Art_Sec4:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel4")CA2.Art.Art_Sec5:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel7")CA2.Art.Art_Sec6:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel6")CA2.Art.Art_Sec7:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel5")CA2.Art.Art_Sec8:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\BG\\Fel8")CA2.Art.Art1:SetBlendMode("MOD")CA2.Art.Art2:SetBlendMode("MOD")CA2.Art.Art3:SetBlendMode("MOD")CA2.Art.Art4:SetBlendMode("MOD")CA2.Art.Art5:SetBlendMode("MOD")CA2.Art.Art6:SetBlendMode("MOD")CA2.Art.Art7:SetBlendMode("MOD")CA2.Art.Art8:SetBlendMode("MOD")CA2.Art.Art_Sec1:SetBlendMode("ADD")CA2.Art.Art_Sec2:SetBlendMode("ADD")CA2.Art.Art_Sec3:SetBlendMode("ADD")CA2.Art.Art_Sec4:SetBlendMode("ADD")CA2.Art.Art_Sec5:SetBlendMode("ADD")CA2.Art.Art_Sec6:SetBlendMode("ADD")CA2.Art.Art_Sec7:SetBlendMode("ADD")CA2.Art.Art_Sec8:SetBlendMode("ADD")local function A(n,t,e)local a=n-e:GetWidth()t:SetSize(n,t:GetHeight())if(a>1)then
e.ScrollBar:SetMinMaxValues(1,t:GetWidth()-e:GetWidth())e.ArrowR:Show()e.ArrowL:Show()else
e.ScrollBar:SetMinMaxValues(1,1)e.ArrowR:Hide()e.ArrowL:Hide()end
end
local function s(e,t)e.Min,e.Max=e:GetMinMaxValues()if(t<=e.Min)then
_G[e:GetParent():GetName()..".ArrowL"]:Disable()if(_G[e:GetParent():GetName()..".ArrowL.FastButton"])then
_G[e:GetParent():GetName()..".ArrowL.FastButton"]:Disable()end
else
_G[e:GetParent():GetName()..".ArrowL"]:Enable()if(_G[e:GetParent():GetName()..".ArrowL.FastButton"])then
_G[e:GetParent():GetName()..".ArrowL.FastButton"]:Enable()end
end
if(t>=e.Max)then
_G[e:GetParent():GetName()..".ArrowR"]:Disable()if(_G[e:GetParent():GetName()..".ArrowR.FastButton"])then
_G[e:GetParent():GetName()..".ArrowR.FastButton"]:Disable()end
else
_G[e:GetParent():GetName()..".ArrowR"]:Enable()if(_G[e:GetParent():GetName()..".ArrowR.FastButton"])then
_G[e:GetParent():GetName()..".ArrowR.FastButton"]:Enable()end
end
end
local function O(e)e.Text:SetFontObject(GameFontDisable)e.Text_Add:SetFontObject(GameFontDisable)e.Text_Add:SetText("|cff00FF00Active|r")Xe=e
return e
end
local function _(e)e.Text:SetFontObject(GameFontHighlight)e.Text_Add:SetFontObject(GameFontNormal)e.Text_Add:SetText(e.SubText)end
local function C(e)if(e.SpellId)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:SetHyperlink("|Hspell:"..e.SpellId.."|h[test]|h")local e=h[e.SpellId]if(e)then
GameTooltip:AddLine(Ne)GameTooltip:AddLine(e)end
GameTooltip:Show()end
end
local function p(e)local n,n,t=GetSpellInfo(e.SpellId)e.Icon:SetTexture(t)local t=CAO_Spells[e.SpellId]local t=t[4]if(CAO_Known[e.SpellId])then
BaseFrameFadeOut(e.BlueHighlight)else
BaseFrameFadeIn(e.BlueHighlight)end
if(t>S)or(e.Level>S)and(GLOBAL_BC_MODE~=3)then
e.Icon:SetVertexColor(1,0,0)e.Border:SetVertexColor(1,0,0)BaseFrameFadeOut(e.BlueHighlight)else
e.Icon:SetVertexColor(1,1,1)e.Border:SetVertexColor(1,.82,0)end
end
local function F(e)local t,t,l=GetSpellInfo(e.SpellId)local t=CAO_Talent_References[e.SpellId]local t=CAO_Talents[t]local a=t[1]local o=t[2]local r=t[5]local t=1
local n=nil
for o,a in pairs(o)do
if(a==e.SpellId)then
t=o
end
if(CAO_Known[a])then
n=o
end
end
e.Icon:SetTexture(l)e.Border:SetVertexColor(1,.82,0)e.RankBorder:SetVertexColor(1,.82,0)e.Rank:SetText(t)e.Rank:SetVertexColor(1,.82,0)e.Icon:SetVertexColor(1,1,1)e.AbilityBorder:SetVertexColor(1,1,1)if(t<a)then
e.Border:SetVertexColor(0,1,0)e.RankBorder:SetVertexColor(0,1,0)e.Rank:SetVertexColor(0,1,0)end
if(a==1)then
e.RankBorder:Hide()e.Rank:Hide()e.AbilityBorder:Show()else
e.RankBorder:Show()e.Rank:Show()end
if n and(n>=t)then
BaseFrameFadeOut(e.BlueHighlight)else
BaseFrameFadeIn(e.BlueHighlight)end
if(r>S)or(e.Level>S)and(GLOBAL_BC_MODE~=3)then
e.Icon:SetVertexColor(1,0,0)e.Border:SetVertexColor(1,0,0)e.RankBorder:SetVertexColor(1,0,0)e.Rank:SetVertexColor(1,0,0)e.AbilityBorder:SetVertexColor(1,0,0)BaseFrameFadeOut(e.BlueHighlight)end
end
local function m(t)local e=0
for n=1,t do
FrameSize=_G["CA2.BC.PassFrame.Level"..n.."Frame"]:GetWidth()if(n==t)then
FrameSize=FrameSize/2
end
e=e+FrameSize
end
return e-(CA2.BC.PassScroll:GetWidth()/2)end
local function f(S)CA2.BC.PassScroll.ScrollBar:SetValue(0)local a=0
local c=0
local i=0
for t=1,u do
local e=_G["CA2.BC.PassFrame.Level"..t.."Frame"]local A=e.SpellTable
local S=e.TalentTable
local n=1
local r=#A
local o=#S
e:Show()if(r>o)then
n=r
else
n=o
end
if(n==1)then
e:SetSize(V,CA2.BC.PassFrame:GetHeight())a=a+V
elseif(n>0)then
e:SetSize(16+(54*n),CA2.BC.PassFrame:GetHeight())a=a+(16+(54*n))end
_G[e:GetName()..".BarTex"]:SetSize(e:GetWidth(),12)if(r==0)and(o==0)then
e:SetSize(.01,CA2.BC.PassFrame:GetHeight())e:Hide()else
if(c==0)then
c=t
end
if(i<t)then
i=t
end
end
for n=1,r do
local e=CreateFrame("BUTTON","CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..n,e)l.SpellButtons[(#l.SpellButtons)+1]=e
e.SpellId=A[n]e.Level=t
e:SetSize(36,36)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",function(e)CA2.BC.PassScroll.Start_X=GetCursorPosition()end)e:SetScript("OnHide",function(e)CA2.BC.PassScroll.Start_X=nil end)e:SetScript("OnDragStop",function(e)CA2.BC.PassScroll.Start_X=nil end)if(n>1)then
e:SetPoint("LEFT",_G["CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..(n-1)],"RIGHT",18,0)else
e:SetPoint("LEFT",18,-50)end
if(e.SpellId==0)then
e:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\PlusButton")e:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\PlusButton")e:SetScript("OnClick",function(e)if(CA2.BC:IsVisible())then
BC_CreateSpellDropDown.Level=t
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_CreateSpellDropDown,e:GetName(),0,-5);end
end)else
e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e.Icon=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..n..".Icon","BORDER")e.Icon:SetSize(e:GetWidth(),e:GetHeight())e.Icon:SetPoint("CENTER",0,-1)e.Border=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..n..".Border","BACKGROUND")e.Border:SetTexture("Interface\\Buttons\\UI-EmptySlot-White")e.Border:SetSize(60,60)e.Border:SetPoint("CENTER",.5,-1)e.Border:SetVertexColor(1,.82,0)e.BlueHighlight=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..n..".BlueHighlight","OVERLAY")e.BlueHighlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\BlueHighlight")e.BlueHighlight:SetSize(128,128)e.BlueHighlight:SetPoint("BOTTOM",0,-60)e.BlueHighlight:SetBlendMode("ADD")e:SetScript("OnEnter",C)p(e)if(GLOBAL_BC_MODE==3)then
e.Settings=CreateFrame("Button","CA2.BC.PassFrame.Level"..t.."Frame.SpellButton"..n..".Settings",e)e.Settings:SetPoint("TOPRIGHT",12,8)e.Settings:SetSize(26,26)e.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")e.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")e.Settings:SetScript("OnClick",function(e)BC_SettingsSpellDropDown.SpellId=e:GetParent().SpellId
BC_SettingsSpellDropDown.type="SPELL"BC_SettingsSpellDropDown.Level=t
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_SettingsSpellDropDown,e:GetName(),0,-5);end)end
end
end
for n=1,o do
local e=CreateFrame("BUTTON","CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n,_G["CA2.BC.PassFrame.Level"..t.."Frame"])e.SpellId=S[n]e.Level=t
l.SpellButtons[(#l.SpellButtons)+1]=e
e:SetSize(36,36)e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")if(n>1)then
e:SetPoint("LEFT",_G["CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..(n-1)],"RIGHT",18,0)else
e:SetPoint("LEFT",18,65)end
e.Icon=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".Icon","BORDER")e.Icon:SetSize(e:GetWidth(),e:GetHeight())e.Icon:SetPoint("CENTER",0,-1)e.Border=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".Border","BACKGROUND")e.Border:SetTexture("Interface\\Buttons\\UI-EmptySlot-White")e.Border:SetSize(60,60)e.Border:SetPoint("CENTER",.5,-1)e.RankBorder=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".RankBorder","ARTWORK")e.RankBorder:SetTexture("Interface\\TalentFrame\\TalentFrame-RankBorder")e.RankBorder:SetSize(32,32)e.RankBorder:SetPoint("CENTER",e,"BOTTOMRIGHT",0,0)e.Rank=e:CreateFontString("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".Rank","OVERLAY")e.Rank:SetFontObject(GameFontNormalSmall)e.Rank:SetPoint("CENTER",e.RankBorder)e.BlueHighlight=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".BlueHighlight","OVERLAY")e.BlueHighlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\BlueHighlight")e.BlueHighlight:SetSize(128,128)e.BlueHighlight:SetPoint("BOTTOM",0,-60)e.BlueHighlight:SetBlendMode("ADD")e.AbilityBorder=e:CreateTexture("CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".AbilityBorder","ARTWORK")e.AbilityBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Tree_MainIcon")e.AbilityBorder:SetSize(68,68)e.AbilityBorder:SetPoint("CENTER",0,0)e.AbilityBorder:Hide()e:SetScript("OnEnter",C)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",function(e)CA2.BC.PassScroll.Start_X=GetCursorPosition()end)e:SetScript("OnHide",function(e)CA2.BC.PassScroll.Start_X=nil end)e:SetScript("OnDragStop",function(e)CA2.BC.PassScroll.Start_X=nil end)F(e)if(GLOBAL_BC_MODE==3)then
e.Settings=CreateFrame("Button","CA2.BC.PassFrame.Level"..t.."Frame.TalentButton"..n..".Settings",e)e.Settings:SetPoint("TOPRIGHT",12,8)e.Settings:SetSize(26,26)e.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")e.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")e.Settings:SetScript("OnClick",function(e)BC_SettingsSpellDropDown.SpellId=e:GetParent().SpellId
BC_SettingsSpellDropDown.type="SPELL"BC_SettingsSpellDropDown.Level=t
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_SettingsSpellDropDown,e:GetName(),0,-5);end)end
end
end
A(a,CA2.BC.PassFrame,CA2.BC.PassScroll)CA2.BC.PassScroll.ArrowR.FastButton:SetText("To level "..i)CA2.BC.PassScroll.ArrowL.FastButton:SetText("To level "..c)if(S)then
CA2.BC.PassScroll.ScrollBar:SetValue(m(S))end
end
local function m(o)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetValue(0)local n=0
for t=1,#i do
local a=i[t]local e,e,o=GetSpellInfo(a)local e=CreateFrame("BUTTON","CA2.BC.BlockL.ArmorTypes.Button"..t,CA2.BC.BlockL.ArmorTypes)l.ArmorButtons[(#l.ArmorButtons)+1]=e
e.SpellId=a
e:SetSize(52,52)if(t>1)then
e:SetPoint("LEFT",_G["CA2.BC.BlockL.ArmorTypes.Button"..(t-1)],"RIGHT",12,0)n=n+64
else
e:SetPoint("LEFT",12,-12)n=n+64+12
end
e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",function(e)CA2.BC.BlockL.ArmorScroll.Start_X=GetCursorPosition()end)e:SetScript("OnHide",function(e)CA2.BC.BlockL.ArmorScroll.Start_X=nil end)e:SetScript("OnDragStop",function(e)CA2.BC.BlockL.ArmorScroll.Start_X=nil end)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",tile=true,tileSize=32,edgeSize=32,insets={left=11,right=12,top=12,bottom=11}})e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e:GetHighlightTexture():ClearAllPoints()e:GetHighlightTexture():SetPoint("CENTER",0,0)e:GetHighlightTexture():SetSize(36,36)e.Icon=e:CreateTexture("CA2.BC.BlockL.ArmorTypes.Button"..t..".Icon","OVERLAY")e.Icon:SetSize(36,36)e.Icon:SetPoint("CENTER",0,-1)if(a==0)then
e.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\PlusButton")e:SetScript("OnClick",function(e)CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_AddArmorSpellDropDown,e:GetName(),0,-5);end)else
e:SetScript("OnEnter",C)e.Icon:SetTexture(o)if(GLOBAL_BC_MODE==3)then
e.Settings=CreateFrame("Button","CA2.BC.BlockL.ArmorTypes.Button"..t..".Settings",e)e.Settings:SetPoint("TOPRIGHT",8,4)e.Settings:SetSize(26,26)e.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")e.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")e.Settings:SetScript("OnClick",function(e)BC_SettingsSpellDropDown.SpellId=e:GetParent().SpellId
BC_SettingsSpellDropDown.type="ARMOR"BC_SettingsSpellDropDown.Level=nil
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_SettingsSpellDropDown,e:GetName(),0,-5);end)end
end
end
A(n,CA2.BC.BlockL.ArmorTypes,CA2.BC.BlockL.ArmorScroll)if(o)then
local t,e=CA2.BC.BlockL.ArmorScroll.ScrollBar:GetMinMaxValues()CA2.BC.BlockL.ArmorScroll.ScrollBar:SetValue(e)end
end
local function F(o)CA2.BC.BlockL.EnchScroll.ScrollBar:SetValue(0)FrameSize=0
for t=1,#c do
local n=c[t]local e,e,a=GetSpellInfo(n)local e=CreateFrame("BUTTON","CA2.BC.BlockL.Enchants.Button"..t,CA2.BC.BlockL.Enchants)e.SpellId=n
l.EnchantButtons[(#l.EnchantButtons)+1]=e
e:SetSize(36,36)if(t>1)then
e:SetPoint("LEFT",_G["CA2.BC.BlockL.Enchants.Button"..(t-1)],"RIGHT",18,0)FrameSize=FrameSize+54
else
e:SetPoint("LEFT",18,-12)FrameSize=FrameSize+54+18
end
e:RegisterForDrag("LeftButton")e:SetScript("OnDragStart",function(e)CA2.BC.BlockL.EnchScroll.Start_X=GetCursorPosition()end)e:SetScript("OnHide",function(e)CA2.BC.BlockL.EnchScroll.Start_X=nil end)e:SetScript("OnDragStop",function(e)CA2.BC.BlockL.EnchScroll.Start_X=nil end)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")e:GetHighlightTexture():ClearAllPoints()e:GetHighlightTexture():SetPoint("CENTER",0,-2)e:GetHighlightTexture():SetSize(46,46)e.Icon=e:CreateTexture("CA2.BC.BlockL.Enchants.Button"..t..".Icon","BACKGROUND")e.Icon:SetSize(e:GetWidth(),e:GetHeight())e.Icon:SetPoint("CENTER",0,-1)e.Border=e:CreateTexture("CA2.BC.BlockL.Enchants.Button"..t..".Border","BORDER")e.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Gold_Ring")e.Border:SetSize(60,60)e.Border:SetPoint("CENTER",.5,-1)if(n==0)then
e.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\PlusButton")e:SetScript("OnClick",ChooseEnchantProcess)else
SetPortraitToTexture(e.Icon,a)e:SetScript("OnEnter",C)if(GLOBAL_BC_MODE==3)then
e.Settings=CreateFrame("Button","CA2.BC.BlockL.Enchants.Button"..t..".Settings",e)e.Settings:SetPoint("TOPRIGHT",12,8)e.Settings:SetSize(26,26)e.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")e.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")e.Settings:SetScript("OnClick",function(e)BC_SettingsSpellDropDown.SpellId=e:GetParent().SpellId
BC_SettingsSpellDropDown.type="ENCH"BC_SettingsSpellDropDown.Level=nil
CloseDropDownMenus()UIDropDownMenu_StartCounting(DropDownList1)ToggleDropDownMenu(1,nil,BC_SettingsSpellDropDown,e:GetName(),0,-5);end)end
end
end
A(FrameSize,CA2.BC.BlockL.Enchants,CA2.BC.BlockL.EnchScroll)if(o)then
local t,e=CA2.BC.BlockL.EnchScroll.ScrollBar:GetMinMaxValues()CA2.BC.BlockL.EnchScroll.ScrollBar:SetValue(e)end
end
local function C(n,t,a)local e=CreateFrame("BUTTON","CA2.BC.BlockR.Button"..t,CA2.BC.BlockR)local o=Y[n][1]l.StatButtons[(#l.StatButtons)+1]=e
e:SetSize(e:GetParent():GetWidth()*.9,16)e.StatName=e:CreateFontString("CA2.BC.BlockR.Button"..t..".StatName","OVERLAY")e.StatName:SetFontObject(GameFontNormal)e.StatName:SetPoint("LEFT",0,0)e.StatName:SetJustifyH("LEFT")e.StatName:SetText(o)e.Count=e:CreateFontString("CA2.BC.BlockR.Button"..t..".Count","OVERLAY")e.Count:SetFontObject(GameFontHighlight)e.Count:SetPoint("RIGHT",0,0)e.Count:SetJustifyH("RIGHT")if not(a)or(a==0)then
e.Count:SetText("0")else
e.Count:SetText("+"..a)end
if(t>1)then
e:SetPoint("TOP",_G["CA2.BC.BlockR.Button"..(t-1)],"BOTTOM",0,-8)else
e:SetPoint("TOP",CA2.BC.BlockR.Header,"BOTTOM",0,-8)end
if(t%2==0)then
e.Border=e:CreateTexture("CA2.BC.BlockR.Button"..t..".Border","BORDER")e.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CharFrameEdit\\LabelBig")e.Border:SetSize(350,55)e.Border:SetPoint("CENTER",-1,-2)e.Border:SetAlpha(.4)end
if(GLOBAL_BC_MODE==3)then
e.Count:SetPoint("RIGHT",-32,0)e.AddButton=CreateFrame("Button","CA2.BC.BlockR.Button"..t..".AddButton",e)e.AddButton:SetSize(16,16)e.AddButton:SetPoint("LEFT",e.Count,"RIGHT",16,0)e.AddButton:SetNormalTexture("Interface\\BUTTONS\\UI-PlusButton-Up")e.AddButton:SetPushedTexture("Interface\\BUTTONS\\UI-PlusButton-Down")e.AddButton:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight")e.AddButton:SetScript("OnClick",function(e)d[n]=d[n]or 0
d[n]=d[n]+1
RefreshStats()end)e.RemoveButton=CreateFrame("Button","CA2.BC.BlockR.Button"..t..".RemoveButton",e)e.RemoveButton:SetSize(16,16)e.RemoveButton:SetPoint("RIGHT",e.Count,"LEFT",-16,0)e.RemoveButton:SetNormalTexture("Interface\\BUTTONS\\UI-MinusButton-Up")e.RemoveButton:SetPushedTexture("Interface\\BUTTONS\\UI-MinusButton-Down")e.RemoveButton:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight")e.RemoveButton:SetScript("OnClick",function(e)if not(d[n])or(d[n]==0)then
return false
end
d[n]=d[n]-1
RefreshStats()end)if not(a)or(a==0)then
e.RemoveButton:Hide()else
e.RemoveButton:Show()end
end
end
local function r()local n=1
N=Ue
for t=1,#Y do
local e=d[t]if(GLOBAL_BC_MODE==3)then
C(t,n,e)n=n+1
end
if(e)then
N=N-e
if(GLOBAL_BC_MODE~=3)then
local e=nil
for a,n in next,STAT_INFO_LIST do
if(n[4]==Y[t][3])then
e=n
break
end
end
if(e)then
local n="|cffFFFFFF"..e[1]local t=e[2]local e=e[3]CA2.BC.BlockR.Icon.Icon:SetTexture(t)CA2.BC.BlockR.Header.Text:SetText("Primary stat - "..n)Ke(e)end
break
end
end
end
if(GLOBAL_BC_MODE==3)then
for t,e in pairs(l.StatButtons)do
if(N<=0)and(e.AddButton)then
e.AddButton:Hide()else
e.AddButton:Show()end
end
end
CA2.BC.BlockR.EditorText:SetText("Available stat points: |cffFFFFFF"..N)end
local function C(a)for e=1,u do
_G["CA2.BC.PassFrame.Level"..e.."Frame"].SpellTable={}_G["CA2.BC.PassFrame.Level"..e.."Frame"].TalentTable={}if(n[e])then
for n,t in pairs(n[e])do
local n=CAO_Talent_References[t]local a=CAO_Spells[t]if(a)then
table.insert(_G["CA2.BC.PassFrame.Level"..e.."Frame"].SpellTable,t)elseif(n)then
table.insert(_G["CA2.BC.PassFrame.Level"..e.."Frame"].TalentTable,t)elseif(t==0)then
table.insert(_G["CA2.BC.PassFrame.Level"..e.."Frame"].SpellTable,t)end
end
end
end
f(a)end
local function e(e)d={}for t,e in pairs(e)do
if(tonumber(e)>0)then
d[t]=e
end
end
end
local function f(e)Ce={}for t,e in pairs(e)do
if(tonumber(e)>0)then
Ce[t]=e
end
end
end
local function e(e)local a=e[1]local n=e[3]local t=e[4]local e=e[5]w=a
CA2.BC.BuildNameText:SetText(t)CA2.BC.BuildSubText:SetText(e)CA2.BC.AuthorFrame.Text:SetText(string.format("|cffFFFFFFAuthor:|r %s",n))end
local function e(e)local e=math.floor(e/86400)if(e==1)then
CA2.BC.AuthorFrame.UpdateTime:SetText(string.format("|cffFFFFFFLast updated: |r%d day ago",e))else
CA2.BC.AuthorFrame.UpdateTime:SetText(string.format("|cffFFFFFFLast updated: |r%d days ago",e))end
CA2.BC.AuthorFrame.UpdateTime:Show()end
local function e()CA2.BC.AuthorFrame.UpdateTime:Hide()end
local function e(e)h=e
end
local function e(e)i=e
end
local function e(e)c=e
end
local function p(e)n=e
end
local function e(e)ie=e
end
local function A()for t,e in pairs(P)do
e:Hide()end
for t,e in pairs(I)do
e:Hide()end
for t,e in pairs(B)do
e:Hide()end
CA2.BC.BottomFrame.EditButton:Show()if(GLOBAL_BC_MODE==1)then
for t,e in pairs(P)do
e:Show()end
CA2.BC.BottomFrame.LearnAllButton:Disable()elseif(GLOBAL_BC_MODE==2)then
for t,e in pairs(I)do
e:Show()end
CA2.BC.BottomFrame.LearnAllButton:Enable()elseif(GLOBAL_BC_MODE==3)then
for t,e in pairs(B)do
e:Show()end
CA2.BC.BottomFrame.EditButton:Hide()CA2.BC.BottomFrame.LearnAllButton:Enable()end
end
function BC_Editor_NewBuild()Ie(l)local o={0,0,UnitName("player"),"Build Name","by "..UnitName("player")}local e={}local t={0,0,0,0,0}local o={o,e,t}GLOBAL_BC_MODE=3
if not(x)then
a={}for t,e in pairs(v)do
a[t]={unpack(e)}end
h={}BuildCreatorHandler.GetBuildData(nil,o)else
table.insert(i,0)table.insert(c,0)for e=1,u do
if not(n[e])then
n[e]={}end
table.insert(n[e],0)end
RefreshPassData()RefreshArmorData()RefreshEnchData()RefreshStats()A()end
end
function RefreshPassData(e)D(l.SpellButtons)C(e)end
function RefreshArmorData()D(l.ArmorButtons)m(true)end
function RefreshEnchData()D(l.EnchantButtons)F(true)end
function RefreshStats()D(l.StatButtons)r()end
local function o(e,t)h[e]=t
end
function BC_HandleAddTip()local e=BC_SettingsSpellDropDown.SpellId
StaticPopupDialogs["ASC_ADDTIP"].OnAccept=function(t)local t=t.editBox:GetText()if(t=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter tip"StaticPopup_Show("ASC_ERROR")return
end
o(e,t)end
StaticPopupDialogs["ASC_ADDTIP"].EditBoxOnEnterPressed=function(t,n)local n=t:GetText()if(n=="")then
StaticPopupDialogs["ASC_ERROR"].text="You have to enter tip"StaticPopup_Show("ASC_ERROR")return
end
local t=t:GetParent();o(e,n)t:Hide();end
if(h[e])then
StaticPopupDialogs["ASC_ADDTIP"].OnShow=function(t)t.editBox:SetText(h[e])end
else
StaticPopupDialogs["ASC_ADDTIP"].OnShow=function(e)end
end
StaticPopup_Show("ASC_ADDTIP")end
function BC_HandleItemRemove()local t=BC_SettingsSpellDropDown.SpellId
local o=BC_SettingsSpellDropDown.type
local e=BC_SettingsSpellDropDown.Level
if(o=="ENCH")then
local e=false
if(#c==he)then
e=true
end
for e,n in pairs(c)do
if(n==t)then
table.remove(c,e)end
end
if(e)then
table.insert(c,(#c+1),0)end
RefreshEnchData()return
end
if(o=="ARMOR")then
local e=false
if(#i==fe)then
e=true
end
for e,n in pairs(i)do
if(n==t)then
table.remove(i,e)end
end
if(e)then
table.insert(i,(#i+1),0)end
RefreshArmorData()return
end
if(o=="SPELL")then
if not(e)then
return
end
if not(n[e])then
return
end
local o,r=CA_GetSpellInfo(t)if not(o)then
return false
end
for l,i in pairs(n[e])do
if(i==t)then
table.remove(n[e],l)for e=e,u do
a[e][1]=a[e][1]+o
a[e][2]=a[e][2]+r
end
end
end
RefreshPassData(e)return
end
end
function BC_RequestBuildInfo(e)Ie(l)GLOBAL_BC_MODE=1
if not(e)then
if(R)then
else
end
return
end
return
end
function HandleSpellAddToBuildCreator(t)local e=BC_CreateSpellDropDown.Level
local i=0
local o=0
local C=0
local A,c=unpack(a[e])local r=CAO_Talent_References[t]local l=1
i,o,C=CA_GetSpellInfo(t)if(r)then
SpellInfo=CAO_Talents[r]t=SpellInfo[2][l]end
if(C>e)then
StaticPopupDialogs["ASC_BC_ERROR"].text="This ability or talent requires a higher level than the level you selected. Try choosing a lower level!"StaticPopup_Show("ASC_BC_ERROR")return
end
if(A<i)or(c<o)then
StaticPopupDialogs["ASC_BC_ERROR"].text="There is not enough Ability Essence or Talent Essence to add this spell/talent."StaticPopup_Show("ASC_BC_ERROR")return
end
for o,a in pairs(n)do
for o,a in pairs(a)do
if(a==t)then
if not(r)then
StaticPopupDialogs["ASC_BC_ERROR"].text="This spell is already in build."StaticPopup_Show("ASC_BC_ERROR")return
else
for n,a in pairs(n)do
for o,a in pairs(a)do
local a=CAO_Talent_References[a]if(a)and(a==r)then
if(e<n)then
StaticPopupDialogs["ASC_BC_ERROR"].text="You have added this talent to level "..n..". Please remove the talent from this level or add it on level "..n.." or above."StaticPopup_Show("ASC_BC_ERROR")return
end
l=l+1
t=SpellInfo[2][l]end
end
end
if not(t)then
StaticPopupDialogs["ASC_BC_ERROR"].text="This talent is already in your build."StaticPopup_Show("ASC_BC_ERROR")return
end
end
end
end
end
for t=e,u do
if((a[t][1]-i)<0)then
StaticPopupDialogs["ASC_BC_ERROR"].text="You can't add this spell or talent to level "..e.." since you used Ability Essence required for it at level "..t.."."StaticPopup_Show("ASC_BC_ERROR")return
end
if((a[t][2]-o)<0)then
StaticPopupDialogs["ASC_BC_ERROR"].text="You can't add this spell or talent to level "..e.." since you used Talent Essence required for it at level "..t.."."StaticPopup_Show("ASC_BC_ERROR")return
end
end
for e=e,u do
a[e][1]=a[e][1]-i
a[e][2]=a[e][2]-o
end
if not(n[e])then
n[e]={}end
for t,a in pairs(n[e])do
if(a==0)then
table.remove(n[e],t)end
end
table.insert(n[e],(#n[e]+1),t)table.insert(n[e],(#n[e]+1),0)GLOBAL_BC_CHOOSE_SPELL=false
_G["CA2.HedaerTabsTab2"]:GetScript("OnClick")(_G["CA2.HedaerTabsTab2"])RefreshPassData(e)end
function HandleArmorAddToBuildCreator(t)for n,e in pairs(i)do
if(e==t.value)then
return
end
if(e==0)then
table.remove(i,n)end
end
table.insert(i,t.value)if(#i<fe)then
table.insert(i,0)end
CloseDropDownMenus()RefreshArmorData()end
function HandleEnchantAddToBuildCreator(e)local e=tonumber(string.match(e,"Hspell:(%d+)"))HideUIPanel(CollectionController)ShowUIPanel(CA2)GLOBAL_BC_CHOOSE_ENCHANT=false
for n,t in pairs(c)do
if(t==e)then
return
end
if(t==0)then
table.remove(c,n)end
end
table.insert(c,e)if(#c<he)then
table.insert(c,0)end
RefreshEnchData()end
function ChooseEnchantProcess()StaticPopup_Show("ASC_BC_SELECT_ENCH")GLOBAL_BC_CHOOSE_ENCHANT=true
HideUIPanel(CA2)ShowUIPanel(CollectionController)CollectionController.CollectionControllerTab1:GetScript("OnClick")(CollectionController.CollectionControllerTab1)end
function BuildCreator_ChooseSpellProcess()GLOBAL_BC_CHOOSE_SPELL=true
StaticPopup_Show("ASC_BC_SELECT")CA2.HedaerTabs.Tab1:GetScript("OnClick")(CA2.HedaerTabs.Tab1)end
local function C()if not(R)then
return false
end
for e,t in pairs(Ce)do
if(tonumber(t)>0)then
HandleStatChange(Y[e][3])end
end
end
function LoadBuildFromLink_BC(l,i)a={}for t,e in pairs(v)do
a[t]={unpack(e)}end
local n={}local e=1
local o=0
local t=0
local r={}for a,n in next,l do
local l,i,a=CA_GetSpellInfo(n)if not(a)then
StaticPopupDialogs["ASC_ERROR"].text="No spell with entry "..n.." found."StaticPopup_Show("ASC_ERROR")return false
end
if(a>e)then
e=a
end
o=o+l
t=t+i
table.insert(r,n)end
for l,a in next,i do
local l=a[1]local a=a[2]local n=CAO_Talents[l]local i={}if not(n)then
StaticPopupDialogs["ASC_ERROR"].text="No talent with entry "..l.." found."StaticPopup_Show("ASC_ERROR")return false
end
local C,i,l=CA_GetSpellInfo(n[2][1])if(l>e)then
e=l
end
o=o+C*a
t=t+i*a
for e=1,a do
table.insert(r,n[2][e])end
end
n[e]=r
for e=e,u do
a[e][1]=a[e][1]-o
a[e][2]=a[e][2]-t
end
for e=1,u do
if not(n[e])then
n[e]={}end
table.insert(n[e],0)end
p(n)RefreshPassData(e)end
local function r(a)local e=0
local o=ie
if(GLOBAL_BC_MODE==3)then
o=n
end
if(o[a])then
for o,n in pairs(o[a])do
if not(CAO_Known[n])and(S>=a)and(n~=0)then
local a=CAO_Talent_References[n]if(a)then
t.Handle("CAO","LearnThisTalent",a)e=e+1
else
t.Handle("CAO","LearnThisSpell",n)e=e+1
end
end
end
end
return e
end
local function l()if not(R)then
return false
end
local e=S
r(e)SendSystemMessage(De)end
local function a()if(S>=60)then
CA2.CharacterAdvancementMain.Main.SpellsSubText.HelpButton:Hide()CA2.CharacterAdvancementMain.Main.TalentsSubText.HelpButton:Hide()end
end
local function o(n,t,e)if(t=="PLAYER_LEVEL_UP")then
l()if(e>=10)then
CA2.CharacterAdvancementMain.Main.BottomFrame.ResetTalentsButton:Enable()end
S=e
a()E()return
end
CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyAE.AEButton.Text:SetText(string.format(ge,GetItemCount(k)))CA2.CharacterAdvancementMain.Main.BottomFrame.CurrencyTE.TEButton.Text:SetText(string.format(we,GetItemCount(J)))ne()end
CA2:SetScript("OnEvent",o)o()a()Le()t.Handle("SwitchSpec","RequestSpecs")t.Handle("sideBar","GetMults")CA2.BC=CreateFrame("FRAME","CA2.BC",CA2)CA2.BC:SetSize(re,560)CA2.BC:SetPoint("CENTER",-131,-58)CA2.BC:Hide()CA2.BC.BuildNameText=CA2.BC:CreateFontString("CA2.BC.BuildNameText")CA2.BC.BuildNameText:SetFont("Fonts\\MORPHEUS.TTF",24)CA2.BC.BuildNameText:SetFontObject(GameFontHighlight)CA2.BC.BuildNameText:SetPoint("TOP",0,-13)CA2.BC.BuildNameText:SetText("Build Name")CA2.BC.BuildNameText:SetJustifyH("CENTER")CA2.BC.BuildSubText=CA2.BC:CreateFontString("CA2.BC.BuildSubText")CA2.BC.BuildSubText:SetFont("Fonts\\FRIZQT__.TTF",12)CA2.BC.BuildSubText:SetFontObject(GameFontNormal)CA2.BC.BuildSubText:SetPoint("CENTER",CA2.BC.BuildNameText,"BOTTOM",0,-8)CA2.BC.BuildSubText:SetText("Build Subtext")CA2.BC.BuildSubText:SetJustifyH("CENTER")CA2.BC.BuildNameText.Settings=CreateFrame("Button","CA2.BC.BuildNameText.Settings",CA2.BC)CA2.BC.BuildNameText.Settings:SetPoint("LEFT",CA2.BC.BuildNameText,"RIGHT",4,0)CA2.BC.BuildNameText.Settings:SetSize(26,26)CA2.BC.BuildNameText.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")CA2.BC.BuildNameText.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")CA2.BC.BuildNameText.Settings:SetScript("OnClick",function()StaticPopup_Show("ASC_BUILDNAME_EDIT")end)CA2.BC.BuildNameText.Settings:Hide()table.insert(B,CA2.BC.BuildNameText.Settings)CA2.BC.BuildSubText.Settings=CreateFrame("Button","CA2.BC.BuildSubText.Settings",CA2.BC)CA2.BC.BuildSubText.Settings:SetPoint("LEFT",CA2.BC.BuildSubText,"RIGHT",4,0)CA2.BC.BuildSubText.Settings:SetSize(20,20)CA2.BC.BuildSubText.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")CA2.BC.BuildSubText.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")CA2.BC.BuildSubText.Settings:SetScript("OnClick",function()StaticPopup_Show("ASC_BUILDSUBTEXT_EDIT")end)CA2.BC.BuildSubText.Settings:Hide()table.insert(B,CA2.BC.BuildSubText.Settings)local function o(e,a,n,o,t)e.Text:SetText(a)e.Text_Add:SetText(n)e.Id=o
e.SubText=n
e.SpecIcon.Text:SetVertexColor(.5,.5,.5)e.SpecIcon.Icon:SetDesaturated(true)if(t)then
e.Rating=t
else
e.Rating=0
end
end
local function l(e,t)local a=0
for n,o in pairs(le)do
if(t>=n)and(a<n)then
e.SpecIcon.Icon:SetTexture(le[n])e.SpecIcon.Icon:SetDesaturated(false)a=n
end
end
if(t>=ze)then
e.Star:Show()end
if(t>0)then
e.SpecIcon.Text:SetVertexColor(0,1,0,1)end
e.SpecIcon.Text:SetText(t)end
local function a(e)local e=e:GetParent().Id
if not(e)then
return false
end
end
function SetUpBuild(e,t)if(IsModifiedClick("CHATLINK"))then
ChatEdit_InsertLink("|cff00ff96|Hcabuild:"..e.Id.."|h["..e.Text:GetText().."]|h|r")return
end
if not(e)then
buildEntry=tonumber(t)else
buildEntry=e.Id
end
if not(CA2:IsVisible())then
ShowUIPanel(CA2)end
if not(CA2.HSBuilds.Content:IsVisible())then
CA2.HedaerTabs.Tab2:GetScript("OnClick")(CA2.HedaerTabs.Tab2)end
if(GLOBAL_BC_MODE==3)then
StaticPopupDialogs["ASC_BC_LEAVE"].OnAccept=function()BC_RequestBuildInfo(buildEntry)pe=e x=false end
StaticPopup_Show("ASC_BC_LEAVE")return
end
BC_RequestBuildInfo(buildEntry)pe=e
end
CA2.HSBuilds=HybridScroll()CA2.HSBuilds.Parent=CA2
CA2.HSBuilds.ParentName=CA2:GetName()CA2.HSBuilds.Name="CA2.HSBuilds"CA2.HSBuilds.Width=L[1]CA2.HSBuilds.Height=L[2]CA2.HSBuilds.doNotHide=true
CA2.HSBuilds.point={"RIGHT",unpack(X)}CA2.HSBuilds.scrollup_point={5,-15}CA2.HSBuilds.scrolldown_point={0,15}function CA2.HSBuilds.LoadData()CA2.HSBuilds.items=se;end
function CA2.HSBuilds.SetUpButton(e,t)local n=t[1]local r=t[2]local a=t[3]local t=t[4]o(e,r,a,n,t)if(R==n)then
O(e)else
_(e)end
l(e,t)if e:IsMouseOver()then
e:GetScript("OnEnter")(e)end
end
function CA2.HSBuilds.CreateButton(t,e)local n=t
local t=n:GetName()BuildButton=CreateFrame("Button",t..".SpecButton"..e,n)if(e==1)then
BuildButton:SetPoint("TOP",0,-3)else
BuildButton:SetPoint("BOTTOM",_G[t..".SpecButton"..(e-1)],0,-50)end
BuildButton:SetSize(210,54)BuildButton:SetScript("OnClick",SetUpBuild)BuildButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFFPreview build "..e.Text:GetText())GameTooltip:AddLine(e.Text_Add:GetText())GameTooltip:AddLine(" ")GameTooltip:AddLine("|cffFFFFFFSHIFT|r + |cffFFFFFFClick|r to insert link to chat")GameTooltip:Show()end)BuildButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)BuildButton.Border=BuildButton:CreateTexture(t..".SpecButton"..e..".Border","BACKGROUND")BuildButton.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\2\\SpecButton")BuildButton.Border:SetSize(256,64)BuildButton.Border:SetPoint("CENTER",0,0)BuildButton.H=BuildButton:CreateTexture(t..".SpecButton"..e..".H","OVERLAY")BuildButton.H:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\Gradient_Highlight")BuildButton.H:SetSize(256,86)BuildButton.H:SetPoint("CENTER",3,3)BuildButton:SetHighlightTexture(BuildButton.H)BuildButton.Text=BuildButton:CreateFontString(t..".SpecButton"..e..".Text")BuildButton.Text:SetFont("Fonts\\FRIZQT__.TTF",12)BuildButton.Text:SetFontObject(GameFontHighlight)BuildButton.Text:SetPoint("CENTER",10,10)BuildButton.Text:SetShadowOffset(1,-1)BuildButton.Text:SetSize(140,16)BuildButton.Text:SetJustifyH("LEFT")BuildButton.Text_Add=BuildButton:CreateFontString(t..".SpecButton"..e..".Text_Add")BuildButton.Text_Add:SetFont("Fonts\\FRIZQT__.TTF",10)BuildButton.Text_Add:SetFontObject(GameFontNormal)BuildButton.Text_Add:SetPoint("CENTER",10,-6)BuildButton.Text_Add:SetShadowOffset(1,-1)BuildButton.Text_Add:SetSize(140,16)BuildButton.Text_Add:SetJustifyH("LEFT")BuildButton.SpecIcon=CreateFrame("BUTTON",t..".SpecButton"..e..".SpecIcon",BuildButton,"PopupButtonTemplate")BuildButton.SpecIcon:SetSize(32,32)BuildButton.SpecIcon:SetPoint("LEFT",0,2)BuildButton.SpecIcon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")BuildButton.SpecIcon:GetHighlightTexture():ClearAllPoints()BuildButton.SpecIcon:GetHighlightTexture():SetPoint("CENTER",0,0)BuildButton.SpecIcon:GetHighlightTexture():SetSize(36,36)BuildButton.SpecIcon:SetScript("OnClick",a)BuildButton.SpecIcon:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFFBuild rating is: |cff00FF00"..e:GetParent().Rating.."|r")GameTooltip:AddLine("You can click the button to rate build.")GameTooltip:Show()end)BuildButton.SpecIcon:SetScript("OnLeave",function()GameTooltip:Hide()end)BuildButton.SpecIcon.Text=BuildButton.SpecIcon:CreateFontString(t..".SpecButton"..e..".SpecIcon.Text")BuildButton.SpecIcon.Text:SetFontObject(GameFontDisableSmall)BuildButton.SpecIcon.Text:SetFont("Fonts\\FRIZQT__.TTF",8.25,"OUTLINE")BuildButton.SpecIcon.Text:SetPoint("BOTTOM",0,0)BuildButton.SpecIcon.Text:SetSize(32,9)BuildButton.SpecIcon.Text:SetJustifyH("CENTER")BuildButton.SpecIcon.Icon=BuildButton.SpecIcon:CreateTexture(t..".SpecButton"..e..".SpecIcon.Icon","ARTWORK")BuildButton.SpecIcon.Icon:SetTexture(le[1])BuildButton.SpecIcon.Icon:SetSize(36,36)BuildButton.SpecIcon.Icon:SetPoint("CENTER",0,-1)BuildButton.SpecIcon.Icon:SetDesaturated(true)BuildButton.Star=CreateFrame("Button",t..".SpecButton"..e..".Star",BuildButton)BuildButton.Star:SetPoint("TOPRIGHT",21,12)BuildButton.Star:SetSize(64,64)BuildButton.Star:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\toast-star")BuildButton.Star:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\toast-star")BuildButton.Star:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:AddLine("|cffFFFFFFAscended choice!")GameTooltip:AddLine("Many people rated this build as good")GameTooltip:Show()end)BuildButton.Star:Hide()return BuildButton
end
local function a(e)T=e:GetText()SendSystemMessage("Description Saved.")end
CA2.BC.DescriptionFrame=CreateFrame("FRAME","CA2.BC.DescriptionFrame",CA2.BC)CA2.BC.DescriptionFrame:SetSize(640,512)CA2.BC.DescriptionFrame:SetPoint("CENTER",24,0)CA2.BC.DescriptionFrame:SetFrameLevel(6)CA2.BC.DescriptionFrame:Hide()CA2.BC.DescriptionFrame.EditBox=CreateFrame("EditBox","CA2.BC.DescriptionFrame.EditBox",CA2.BC.DescriptionFrame)CA2.BC.DescriptionFrame.EditBox:SetSize(565,491)CA2.BC.DescriptionFrame.EditBox:SetFontObject(GameFontHighlight)CA2.BC.DescriptionFrame.EditBox:SetMaxLetters(2500)CA2.BC.DescriptionFrame.EditBox:SetJustifyH("LEFT")CA2.BC.DescriptionFrame.EditBox:SetMultiLine(true)CA2.BC.DescriptionFrame.EditBox:ClearFocus(CA2.BC.DescriptionFrame.EditBox)CA2.BC.DescriptionFrame.EditBox:SetAutoFocus(false)CA2.BC.DescriptionFrame.EditBox:SetPoint("TOPLEFT",25,-60)CA2.BC.DescriptionFrame.EditBox:SetText("There is no description yet.")CA2.BC.DescriptionFrame.EditBox:SetScript("OnEscapePressed",function(e)e:ClearFocus(e)a(e)end)CA2.BC.DescriptionFrame.EditBox:SetScript("OnTextChanged",function(e)CA2.BC.DescriptionFrame.LimitText:SetText(string.format("Characters: %d/2500",string.len(e:GetText())))end)CA2.BC.DescriptionFrame.EditBox:SetScript("OnShow",function(e)if not(T)or(T=="")then e:SetText("There is no description yet.")else e:SetText(T)end end)CA2.BC.DescriptionFrame.BGTL=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGTL:SetSize(256,256)CA2.BC.DescriptionFrame.BGTL:SetTexture("Interface\\HelpFrame\\HelpFrame-TopLeft")CA2.BC.DescriptionFrame.BGTL:SetPoint("TOPLEFT",0,0)CA2.BC.DescriptionFrame.BGT=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGT:SetSize(256,256)CA2.BC.DescriptionFrame.BGT:SetTexture("Interface\\HelpFrame\\HelpFrame-Top")CA2.BC.DescriptionFrame.BGT:SetPoint("TOPLEFT",256,0)CA2.BC.DescriptionFrame.BGTR=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGTR:SetSize(128,256)CA2.BC.DescriptionFrame.BGTR:SetTexture("Interface\\HelpFrame\\HelpFrame-TopRight")CA2.BC.DescriptionFrame.BGTR:SetPoint("TOPRIGHT",0,0)CA2.BC.DescriptionFrame.BGBL=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGBL:SetSize(256,256)CA2.BC.DescriptionFrame.BGBL:SetTexture("Interface\\HelpFrame\\HelpFrame-BotLeft")CA2.BC.DescriptionFrame.BGBL:SetPoint("BOTTOMLEFT",0,0)CA2.BC.DescriptionFrame.BGB=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGB:SetSize(256,256)CA2.BC.DescriptionFrame.BGB:SetTexture("Interface\\HelpFrame\\HelpFrame-Bottom")CA2.BC.DescriptionFrame.BGB:SetPoint("BOTTOMLEFT",256,0)CA2.BC.DescriptionFrame.BGBR=CA2.BC.DescriptionFrame:CreateTexture(nil,"BACKGROUND")CA2.BC.DescriptionFrame.BGBR:SetSize(128,256)CA2.BC.DescriptionFrame.BGBR:SetTexture("Interface\\HelpFrame\\HelpFrame-BotRight")CA2.BC.DescriptionFrame.BGBR:SetPoint("BOTTOMRIGHT",0,0)CA2.BC.DescriptionFrame.Header=CA2.BC.DescriptionFrame:CreateTexture("CA2.BC.DescriptionFrame.Header","ARTWORK")CA2.BC.DescriptionFrame.Header:SetSize(256,64)CA2.BC.DescriptionFrame.Header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")CA2.BC.DescriptionFrame.Header:SetPoint("TOP",-22,12)CA2.BC.DescriptionFrame.HeaderText=CA2.BC.DescriptionFrame:CreateFontString(nil,"OVERLAY")CA2.BC.DescriptionFrame.HeaderText:SetFontObject(GameFontNormal)CA2.BC.DescriptionFrame.HeaderText:SetPoint("TOP",CA2.BC.DescriptionFrame.Header,0,-14)CA2.BC.DescriptionFrame.HeaderText:SetText("Description")CA2.BC.DescriptionFrame.CloseButton=CreateFrame("BUTTON","CA2.BC.DescriptionFrame.CloseButton",CA2.BC.DescriptionFrame,"UIPanelCloseButton")CA2.BC.DescriptionFrame.CloseButton:SetPoint("TOPRIGHT",-42,-3)CA2.BC.DescriptionFrame.CloseButton:EnableMouse(true)CA2.BC.DescriptionFrame.AcceptButton=CreateFrame("Button","CA2.BC.DescriptionFrame.AcceptButton",CA2.BC.DescriptionFrame,"StaticPopupButtonTemplate")CA2.BC.DescriptionFrame.AcceptButton:SetSize(131,24)CA2.BC.DescriptionFrame.AcceptButton:SetPoint("BOTTOMRIGHT",CA2.BC.DescriptionFrame,-52,19)CA2.BC.DescriptionFrame.AcceptButton:SetText("Done")CA2.BC.DescriptionFrame.AcceptButton:SetScript("OnClick",function()if(GLOBAL_BC_MODE==3)then
a(CA2.BC.DescriptionFrame.EditBox)end
CA2.BC.DescriptionFrame:Hide()end)MagicButton_OnLoad(CA2.BC.DescriptionFrame.AcceptButton)CA2.BC.DescriptionFrame.EditButton=CreateFrame("Button","CA2.BC.DescriptionFrame.EditButton",CA2.BC.DescriptionFrame,"StaticPopupButtonTemplate")CA2.BC.DescriptionFrame.EditButton:SetSize(131,24)CA2.BC.DescriptionFrame.EditButton:SetPoint("RIGHT",CA2.BC.DescriptionFrame.AcceptButton,"LEFT",0,0)CA2.BC.DescriptionFrame.EditButton:SetText("Edit")CA2.BC.DescriptionFrame.EditButton:SetScript("OnClick",function()CA2.BC.DescriptionFrame.EditBox:SetFocus()end)MagicButton_OnLoad(CA2.BC.DescriptionFrame.EditButton)table.insert(B,CA2.BC.DescriptionFrame.EditButton)CA2.BC.DescriptionFrame.LimitText=CA2.BC.DescriptionFrame:CreateFontString("CA2.BC.DescriptionFrame.LimitText","OVERLAY")CA2.BC.DescriptionFrame.LimitText:SetFontObject(GameFontNormal)CA2.BC.DescriptionFrame.LimitText:SetPoint("BOTTOMLEFT",CA2.BC.DescriptionFrame,22,28)CA2.BC.DescriptionFrame.LimitText:SetText("Characters: 50/3000")CA2.BC.DescriptionFrame.LimitText:SetJustifyH("LEFT")table.insert(B,CA2.BC.DescriptionFrame.LimitText)CA2.BC.BlockL=CreateFrame("FRAME","CA2.BC.BlockL",CA2.BC)CA2.BC.BlockL:SetSize(485,195)CA2.BC.BlockL:SetPoint("TOPLEFT",28,-70)CA2.BC.BlockL.BG=CA2.BC.BlockL:CreateTexture("CA2.BC.BlockL.BG","BACKGROUND")CA2.BC.BlockL.BG:SetSize(512,256)CA2.BC.BlockL.BG:SetPoint("CENTER",6,-24)CA2.BC.BlockL.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\CAO_BlockLeft")CA2.BC.BlockL.Header=CreateFrame("FRAME","CA2.BC.BlockL.Header",CA2.BC.BlockL)CA2.BC.BlockL.Header:SetSize(CA2.BC.BlockL:GetWidth(),25)CA2.BC.BlockL.Header:SetPoint("TOP")CA2.BC.BlockL.Header.HeadTexture=CA2.BC.BlockL.Header:CreateTexture("CA2.BC.BlockL.Header.HeadTexture","ARTWORK")CA2.BC.BlockL.Header.HeadTexture:SetSize(512,128)CA2.BC.BlockL.Header.HeadTexture:SetPoint("CENTER",-12,-11)CA2.BC.BlockL.Header.HeadTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\BlockL_Header")CA2.BC.BlockL.Header.HelpButton=CreateFrame("BUTTON","CA2.BC.BlockL.Header.HelpButton",CA2.BC.BlockL.Header)CA2.BC.BlockL.Header.HelpButton:SetPoint("RIGHT",CA2.BC.BlockL.Header,"RIGHT",-2,2)CA2.BC.BlockL.Header.HelpButton:SetSize(16,16)CA2.BC.BlockL.Header.HelpButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.BC.BlockL.Header.HelpButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\QuestIcon")CA2.BC.BlockL.Header.HelpButton.tooltipText="Armor and weapon preferences. For this build, use armor and weapon types from the list below. To achieve best results, collect on your armor and weapon given list of mystic enchants."CA2.BC.BlockL.Header.HelpButton:SetScript("OnEnter",function(e)if(e.tooltipText)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT");GameTooltip:SetText(e.tooltipText,nil,nil,nil,nil,1);end
GameTooltip:Show()end)CA2.BC.BlockL.Header.HelpButton:SetScript("OnLeave",function()GameTooltip:Hide()end)CA2.BC.BlockL.Header.Icon=CA2.BC.BlockL.Header:CreateTexture("CA2.BC.BlockL.Header.Icon","BORDER")CA2.BC.BlockL.Header.Icon:SetSize(24,24)CA2.BC.BlockL.Header.Icon:SetPoint("TOPLEFT",-6,5)SetPortraitToTexture(CA2.BC.BlockL.Header.Icon,"Interface\\Icons\\inv_chest_chain")CA2.BC.BlockL.Header.Text=CA2.BC.BlockL.Header:CreateFontString("CA2.BC.BlockL.Header.Text")CA2.BC.BlockL.Header.Text:SetFontObject(GameFontHighlight)CA2.BC.BlockL.Header.Text:SetPoint("CENTER",0,2)CA2.BC.BlockL.Header.Text:SetSize(CA2.BC.BlockL.Header:GetWidth(),CA2.BC.BlockL.Header:GetHeight())CA2.BC.BlockL.Header.Text:SetText("Armor and Weapons")CA2.BC.BlockL.Header.Text:SetJustifyH("CENTER")CA2.BC.BlockL.Enchants=CreateFrame("FRAME","CA2.BC.BlockL.Enchants",CA2.BC.BlockL)CA2.BC.BlockL.Enchants:SetSize(CA2.BC.BlockL:GetWidth()*.8,(CA2.BC.BlockL:GetHeight()/2))CA2.BC.BlockL.Enchants.DefaultWidth=CA2.BC.BlockL:GetWidth()*.8
CA2.BC.BlockL.Enchants:SetPoint("BOTTOM",0,0)CA2.BC.BlockL.EnchScroll=CreateFrame("ScrollFrame","CA2.BC.BlockL.EnchScroll",CA2.BC.BlockL)CA2.BC.BlockL.EnchScroll:SetSize(CA2.BC.BlockL.Enchants:GetSize())CA2.BC.BlockL.EnchScroll:SetPoint("BOTTOM",0,0)CA2.BC.BlockL.EnchScroll:EnableMouseWheel(true)CA2.BC.BlockL.EnchScroll:RegisterForDrag("LeftButton")CA2.BC.BlockL.EnchScroll:EnableMouse(true)CA2.BC.BlockL.EnchScroll:SetScript("OnDragStart",function(e,...)e.Start_X=GetCursorPosition()end)CA2.BC.BlockL.EnchScroll:SetScript("OnDragStop",function(e,...)e.Start_X=nil
end)CA2.BC.BlockL.EnchScroll:SetScript("OnMouseWheel",function(e,t)if(e.ScrollBar:IsVisible())and(e.ScrollBar:IsEnabled()==1)then
local n=e.ScrollBar:GetValue()e.ScrollBar:SetValue(n+t*32)end
end)CA2.BC.BlockL.EnchScroll:SetScript("OnUpdate",function(e)if(e.Start_X)then
local t=GetCursorPosition();local t=-((t-e.Start_X)*1);e.Start_X=GetCursorPosition();e.ScrollBar:SetValue(e.ScrollBar:GetValue()+t);end
end)CA2.BC.BlockL.EnchScroll.ScrollBar=CreateFrame("Slider","CA2.BC.BlockL.EnchScroll.ScrollBar",CA2.BC.BlockL.EnchScroll)CA2.BC.BlockL.EnchScroll.ScrollBar:SetPoint("TOPLEFT",CA2.BC.BlockL.EnchScroll,"TOPRIGHT",5,-15)CA2.BC.BlockL.EnchScroll.ScrollBar:SetPoint("BOTTOMLEFT",CA2.BC.BlockL.EnchScroll,"BOTTOMRIGHT",0,15)CA2.BC.BlockL.EnchScroll.ScrollBar:SetMinMaxValues(1,CA2.BC.BlockL.EnchScroll:GetWidth())CA2.BC.BlockL.EnchScroll.ScrollBar:SetValueStep(1)CA2.BC.BlockL.EnchScroll.ScrollBar.scrollStep=1
CA2.BC.BlockL.EnchScroll.ScrollBar:SetValue(0)CA2.BC.BlockL.EnchScroll.ScrollBar:SetWidth(16)CA2.BC.BlockL.EnchScroll.ScrollBar:SetScript("OnValueChanged",function(t,e)CA2.BC.BlockL.EnchScroll:SetHorizontalScroll(e)s(t,e)end)CA2.BC.BlockL.EnchScroll:SetScrollChild(CA2.BC.BlockL.Enchants)CA2.BC.BlockL.EnchScroll.HeadTexture=CA2.BC.BlockL.EnchScroll:CreateTexture("CA2.BC.BlockL.EnchScroll.HeadTexture","ARTWORK")CA2.BC.BlockL.EnchScroll.HeadTexture:SetSize(256,32)CA2.BC.BlockL.EnchScroll.HeadTexture:SetPoint("TOP",5,0)CA2.BC.BlockL.EnchScroll.HeadTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Header_Diff")CA2.BC.BlockL.EnchScroll.HeadText=CA2.BC.BlockL.EnchScroll:CreateFontString("CA2.BC.BlockL.EnchScroll.HeadText")CA2.BC.BlockL.EnchScroll.HeadText:SetFontObject(GameFontHighlight)CA2.BC.BlockL.EnchScroll.HeadText:SetPoint("TOP",0,0)CA2.BC.BlockL.EnchScroll.HeadText:SetSize(CA2.BC.BlockL.EnchScroll.HeadTexture:GetSize())CA2.BC.BlockL.EnchScroll.HeadText:SetText("Mystic Enchants")CA2.BC.BlockL.EnchScroll.HeadText:SetJustifyH("CENTER")CA2.BC.BlockL.EnchScroll.ArrowR=CreateFrame("BUTTON","CA2.BC.BlockL.EnchScroll.ArrowR",CA2.BC.BlockL.EnchScroll)CA2.BC.BlockL.EnchScroll.ArrowR:SetSize(32,64)CA2.BC.BlockL.EnchScroll.ArrowR:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.BlockL.EnchScroll.ArrowR:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.BlockL.EnchScroll.ArrowR:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.BlockL.EnchScroll.ArrowR:SetDisabledTexture(CA2.BC.BlockL.EnchScroll.ArrowR:GetNormalTexture():GetTexture())CA2.BC.BlockL.EnchScroll.ArrowR:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.BlockL.EnchScroll.ArrowR:SetPoint("RIGHT",42,-12)CA2.BC.BlockL.EnchScroll.ArrowR:SetScript("OnClick",function(e)local e=e:GetParent().ScrollBar
e:SetValue(e:GetValue()+64)end)CA2.BC.BlockL.EnchScroll.ArrowL=CreateFrame("BUTTON","CA2.BC.BlockL.EnchScroll.ArrowL",CA2.BC.BlockL.EnchScroll)CA2.BC.BlockL.EnchScroll.ArrowL:SetSize(32,64)CA2.BC.BlockL.EnchScroll.ArrowL:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.BlockL.EnchScroll.ArrowL:GetNormalTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.EnchScroll.ArrowL:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.BlockL.EnchScroll.ArrowL:GetHighlightTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.EnchScroll.ArrowL:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.BlockL.EnchScroll.ArrowL:GetPushedTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.EnchScroll.ArrowL:SetDisabledTexture(CA2.BC.BlockL.EnchScroll.ArrowL:GetNormalTexture():GetTexture())CA2.BC.BlockL.EnchScroll.ArrowL:GetDisabledTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.EnchScroll.ArrowL:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.BlockL.EnchScroll.ArrowL:Disable()CA2.BC.BlockL.EnchScroll.ArrowL:SetPoint("LEFT",-42,-12)CA2.BC.BlockL.EnchScroll.ArrowL:SetScript("OnClick",function(e)local e=e:GetParent().ScrollBar
e:SetValue(e:GetValue()-64)end)CA2.BC.BlockL.ArmorTypes=CreateFrame("FRAME","CA2.BC.BlockL.ArmorTypes",CA2.BC.BlockL)CA2.BC.BlockL.ArmorTypes:SetSize(CA2.BC.BlockL:GetWidth()*.8,(CA2.BC.BlockL:GetHeight()/2))CA2.BC.BlockL.ArmorTypes.DefaultWidth=CA2.BC.BlockL:GetWidth()*.8
CA2.BC.BlockL.ArmorTypes:SetPoint("TOP",0,0)CA2.BC.BlockL.ArmorScroll=CreateFrame("ScrollFrame","CA2.BC.BlockL.ArmorScroll",CA2.BC.BlockL)CA2.BC.BlockL.ArmorScroll:SetSize(CA2.BC.BlockL.ArmorTypes:GetSize())CA2.BC.BlockL.ArmorScroll:SetPoint("TOP",0,0)CA2.BC.BlockL.ArmorScroll:EnableMouseWheel(true)CA2.BC.BlockL.ArmorScroll:RegisterForDrag("LeftButton")CA2.BC.BlockL.ArmorScroll:EnableMouse(true)CA2.BC.BlockL.ArmorScroll:SetScript("OnDragStart",function(e,...)e.Start_X=GetCursorPosition()end)CA2.BC.BlockL.ArmorScroll:SetScript("OnDragStop",function(e,...)e.Start_X=nil
end)CA2.BC.BlockL.ArmorScroll:SetScript("OnMouseWheel",function(e,t)if(e.ScrollBar:IsVisible())and(e.ScrollBar:IsEnabled()==1)then
local n=e.ScrollBar:GetValue()e.ScrollBar:SetValue(n+t*32)end
end)CA2.BC.BlockL.ArmorScroll:SetScript("OnUpdate",function(e)if(e.Start_X)then
local t=GetCursorPosition();local t=-((t-e.Start_X)*1);e.Start_X=GetCursorPosition();e.ScrollBar:SetValue(e.ScrollBar:GetValue()+t);end
end)CA2.BC.BlockL.ArmorScroll.ScrollBar=CreateFrame("Slider","CA2.BC.BlockL.ArmorScroll.ScrollBar",CA2.BC.BlockL.ArmorScroll)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetPoint("TOPLEFT",CA2.BC.BlockL.ArmorScroll,"TOPRIGHT",5,-15)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetPoint("BOTTOMLEFT",CA2.BC.BlockL.ArmorScroll,"BOTTOMRIGHT",0,15)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetMinMaxValues(1,CA2.BC.BlockL.ArmorScroll:GetWidth())CA2.BC.BlockL.ArmorScroll.ScrollBar:SetValueStep(1)CA2.BC.BlockL.ArmorScroll.ScrollBar.scrollStep=1
CA2.BC.BlockL.ArmorScroll.ScrollBar:SetValue(0)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetWidth(16)CA2.BC.BlockL.ArmorScroll.ScrollBar:SetScript("OnValueChanged",function(t,e)CA2.BC.BlockL.ArmorScroll:SetHorizontalScroll(e)s(t,e)end)CA2.BC.BlockL.ArmorScroll:SetScrollChild(CA2.BC.BlockL.ArmorTypes)CA2.BC.BlockL.ArmorScroll.ArrowR=CreateFrame("BUTTON","CA2.BC.BlockL.ArmorScroll.ArrowR",CA2.BC.BlockL.ArmorScroll)CA2.BC.BlockL.ArmorScroll.ArrowR:SetSize(32,64)CA2.BC.BlockL.ArmorScroll.ArrowR:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.BlockL.ArmorScroll.ArrowR:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.BlockL.ArmorScroll.ArrowR:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.BlockL.ArmorScroll.ArrowR:SetDisabledTexture(CA2.BC.BlockL.ArmorScroll.ArrowR:GetNormalTexture():GetTexture())CA2.BC.BlockL.ArmorScroll.ArrowR:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.BlockL.ArmorScroll.ArrowR:SetPoint("RIGHT",42,-12)CA2.BC.BlockL.ArmorScroll.ArrowR:SetScript("OnClick",function(e)local e=e:GetParent().ScrollBar
e:SetValue(e:GetValue()+64)end)CA2.BC.BlockL.ArmorScroll.ArrowL=CreateFrame("BUTTON","CA2.BC.BlockL.ArmorScroll.ArrowL",CA2.BC.BlockL.ArmorScroll)CA2.BC.BlockL.ArmorScroll.ArrowL:SetSize(32,64)CA2.BC.BlockL.ArmorScroll.ArrowL:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.BlockL.ArmorScroll.ArrowL:GetNormalTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.ArmorScroll.ArrowL:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.BlockL.ArmorScroll.ArrowL:GetHighlightTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.ArmorScroll.ArrowL:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.BlockL.ArmorScroll.ArrowL:GetPushedTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.ArmorScroll.ArrowL:SetDisabledTexture(CA2.BC.BlockL.ArmorScroll.ArrowL:GetNormalTexture():GetTexture())CA2.BC.BlockL.ArmorScroll.ArrowL:GetDisabledTexture():SetTexCoord(1,0,0,1)CA2.BC.BlockL.ArmorScroll.ArrowL:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.BlockL.ArmorScroll.ArrowL:Disable()CA2.BC.BlockL.ArmorScroll.ArrowL:SetPoint("LEFT",-42,-12)CA2.BC.BlockL.ArmorScroll.ArrowL:SetScript("OnClick",function(e)local e=e:GetParent().ScrollBar
e:SetValue(e:GetValue()-64)end)CA2.BC.BlockR=CreateFrame("FRAME","CA2.BC.BlockR",CA2.BC)CA2.BC.BlockR:SetSize(232,195)CA2.BC.BlockR:SetPoint("TOPRIGHT",-28,-70)CA2.BC.BlockR.BG=CA2.BC.BlockR:CreateTexture("CA2.BC.BlockR.BG","BACKGROUND")CA2.BC.BlockR.BG:SetSize(256,256)CA2.BC.BlockR.BG:SetPoint("CENTER",6,-24)CA2.BC.BlockR.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\CAO_BlockRight")CA2.BC.BlockR.Header=CreateFrame("FRAME","CA2.BC.BlockR.Header",CA2.BC.BlockR)CA2.BC.BlockR.Header:SetSize(CA2.BC.BlockR:GetWidth(),25)CA2.BC.BlockR.Header:SetPoint("TOP")CA2.BC.BlockR.Header.HeadTexture=CA2.BC.BlockR.Header:CreateTexture("CA2.BC.BlockR.Header.HeadTexture","ARTWORK")CA2.BC.BlockR.Header.HeadTexture:SetSize(256,64)CA2.BC.BlockR.Header.HeadTexture:SetPoint("CENTER",-12,-3)CA2.BC.BlockR.Header.HeadTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\BlockR_Header")CA2.BC.BlockR.Header.Icon=CA2.BC.BlockR.Header:CreateTexture("CA2.BC.BlockR.Header.Icon","BORDER")CA2.BC.BlockR.Header.Icon:SetSize(24,24)CA2.BC.BlockR.Header.Icon:SetPoint("TOPLEFT",-6,5)SetPortraitToTexture(CA2.BC.BlockR.Header.Icon,"Interface\\Icons\\spell_arcane_mindmastery")CA2.BC.BlockR.Header.Text=CA2.BC.BlockR.Header:CreateFontString("CA2.BC.BlockR.Header.Text")CA2.BC.BlockR.Header.Text:SetFontObject(GameFontHighlight)CA2.BC.BlockR.Header.Text:SetPoint("CENTER",0,2)CA2.BC.BlockR.Header.Text:SetSize(CA2.BC.BlockR.Header:GetWidth(),CA2.BC.BlockR.Header:GetHeight())CA2.BC.BlockR.Header.Text:SetText("Stat Allocation")CA2.BC.BlockR.Header.Text:SetJustifyH("CENTER")CA2.BC.BlockR.CheckButton=CreateFrame("CheckButton","CA2.BC.BlockR.CheckButton",CA2.BC.BlockR,"OptionsCheckButtonTemplate")CA2.BC.BlockR.CheckButton:SetPoint("BOTTOMLEFT",8,8)CA2.BC.BlockR.CheckButton.tooltipText="System will automatically allocate stats in stat allocation each level."_G["CA2.BC.BlockR.CheckButtonText"]:SetText("|cffFFFFFFAuto allocate stats|r")CA2.BC.BlockR.CheckButton:SetChecked(true)CA2.BC.BlockR.CheckButton:Hide()CA2.BC.BlockR.EditorText=CA2.BC.BlockR:CreateFontString("CA2.BC.BlockR.EditorText")CA2.BC.BlockR.EditorText:SetFontObject(GameFontNormal)CA2.BC.BlockR.EditorText:SetPoint("BOTTOM",0,8)CA2.BC.BlockR.EditorText:SetSize(CA2.BC.BlockR:GetWidth(),CA2.BC.BlockR.CheckButton:GetHeight())CA2.BC.BlockR.EditorText:SetText("Available stat points: |cffFFFFFF5")CA2.BC.BlockR.EditorText:SetJustifyH("CENTER")CA2.BC.BlockR.EditorText:Hide()table.insert(B,CA2.BC.BlockR.EditorText)CA2.BC.BlockR.Icon=CreateFrame("Button","CA2.BC.BlockR.Icon",CA2.BC.BlockR)CA2.BC.BlockR.Icon:SetSize(32,32)CA2.BC.BlockR.Icon:SetPoint("TOPLEFT",15,-35)CA2.BC.BlockR.Icon.SizeX,CA2.BC.BlockR.Icon.SizeY=CA2.BC.BlockR.Icon:GetSize()CA2.BC.BlockR.Icon.Icon=CA2.BC.BlockR.Icon:CreateTexture(nil,"BORDER")CA2.BC.BlockR.Icon.Icon:SetSize(CA2.BC.BlockR.Icon.SizeX+2,CA2.BC.BlockR.Icon.SizeY+2)CA2.BC.BlockR.Icon.Icon:SetPoint("CENTER",0,0)CA2.BC.BlockR.Icon.Icon:SetTexture("Interface\\Icons\\inv_chest_samurai")CA2.BC.BlockR.Icon.BG=CA2.BC.BlockR.Icon:CreateTexture(nil,"BACKGROUND")CA2.BC.BlockR.Icon.BG:SetSize(CA2.BC.BlockR.Icon.SizeX+6,CA2.BC.BlockR.Icon.SizeY+6)CA2.BC.BlockR.Icon.BG:SetTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")CA2.BC.BlockR.Icon.BG:SetPoint("TOPLEFT",-3,3)table.insert(P,CA2.BC.BlockR.Icon)table.insert(I,CA2.BC.BlockR.Icon)CA2.BC.BlockR.TextFirst=CA2.BC.BlockR.Header:CreateFontString("CA2.BC.BlockR.Header.TextFirst")CA2.BC.BlockR.TextFirst:SetFontObject(GameFontNormal)CA2.BC.BlockR.TextFirst:SetPoint("TOPLEFT",CA2.BC.BlockR.Icon,"RIGHT",10,16)CA2.BC.BlockR.TextFirst:SetSize(CA2.BC.BlockR:GetWidth()*.8-CA2.BC.BlockR.Icon.Icon:GetWidth(),40)CA2.BC.BlockR.TextFirst:SetText(StrExample)CA2.BC.BlockR.TextFirst:SetJustifyH("LEFT")CA2.BC.BlockR.TextFirst:SetJustifyV("TOP")CA2.BC.BlockR.TextFirst_Hack=CA2.BC.BlockR.Header:CreateFontString("CA2.BC.BlockR.Header.TextFirst")CA2.BC.BlockR.TextFirst_Hack:SetFontObject(GameFontNormal)CA2.BC.BlockR.TextFirst_Hack:SetPoint("TOPLEFT",CA2.BC.BlockR.Icon,"RIGHT",10,16)CA2.BC.BlockR.TextFirst_Hack:SetSize(CA2.BC.BlockR:GetWidth()*.8-CA2.BC.BlockR.Icon.Icon:GetWidth(),60)CA2.BC.BlockR.TextFirst_Hack:SetText(StrExample)CA2.BC.BlockR.TextFirst_Hack:SetJustifyH("LEFT")CA2.BC.BlockR.TextFirst_Hack:SetJustifyV("TOP")CA2.BC.BlockR.TextFirst_Hack:Hide()table.insert(P,CA2.BC.BlockR.TextFirst)table.insert(I,CA2.BC.BlockR.TextFirst)CA2.BC.BlockR.TextMain=CA2.BC.BlockR.Header:CreateFontString("CA2.BC.BlockR.Header.TextMain")CA2.BC.BlockR.TextMain:SetFontObject(GameFontNormal)CA2.BC.BlockR.TextMain:SetPoint("TOP",0,-75)CA2.BC.BlockR.TextMain:SetSize(CA2.BC.BlockR:GetWidth()*.9,CA2.BC.BlockR:GetHeight()*.6)CA2.BC.BlockR.TextMain:SetText()CA2.BC.BlockR.TextMain:SetJustifyH("LEFT")CA2.BC.BlockR.TextMain:SetJustifyV("TOP")table.insert(P,CA2.BC.BlockR.TextMain)table.insert(I,CA2.BC.BlockR.TextMain)CA2.BC.AuthorFrame=CreateFrame("FRAME","CA2.BC.AuthorFrame",CA2.BC)CA2.BC.AuthorFrame:SetSize(192,58)CA2.BC.AuthorFrame:SetPoint("TOPLEFT",8,2)CA2.BC.AuthorFrame.Text=CA2.BC.AuthorFrame:CreateFontString("CA2.BC.AuthorFrame.Text")CA2.BC.AuthorFrame.Text:SetFont("Fonts\\FRIZQT__.TTF",14)CA2.BC.AuthorFrame.Text:SetFontObject(GameFontNormal)CA2.BC.AuthorFrame.Text:SetPoint("LEFT",48,0)CA2.BC.AuthorFrame.Text:SetSize(CA2.BC.AuthorFrame:GetWidth(),16)CA2.BC.AuthorFrame.Text:SetText("Stat Allocation")CA2.BC.AuthorFrame.Text:SetJustifyH("LEFT")CA2.BC.AuthorFrame.Text:SetText("|cffFFFFFFAuthor:|r Testnickname")CA2.BC.AuthorFrame.UpdateTime=CA2.BC.AuthorFrame:CreateFontString("CA2.BC.AuthorFrame.UpdateTime")CA2.BC.AuthorFrame.UpdateTime:SetFontObject(GameFontNormalSmall)CA2.BC.AuthorFrame.UpdateTime:SetPoint("BOTTOM",CA2.BC.AuthorFrame.Text,0,-14)CA2.BC.AuthorFrame.UpdateTime:SetSize(CA2.BC.AuthorFrame:GetWidth(),16)CA2.BC.AuthorFrame.UpdateTime:SetText("|cffFFFFFFLast updated: |r3 days ago")CA2.BC.AuthorFrame.UpdateTime:SetJustifyH("LEFT")CA2.BC.BottomFrame=CreateFrame("FRAME","CA2.BC.BottomFrame",CA2.BC)CA2.BC.BottomFrame:SetSize(CA2.BC:GetWidth(),32)CA2.BC.BottomFrame:SetPoint("BOTTOM",0,-1)CA2.BC.BottomFrame.ActivateButton=CreateFrame("Button","CA2.BC.BottomFrame.ActivateButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.ActivateButton:SetSize(131,22)CA2.BC.BottomFrame.ActivateButton:SetPoint("CENTER",CA2.BC.BottomFrame,"CENTER",0,-1)CA2.BC.BottomFrame.ActivateButton:SetText("Activate Build")CA2.BC.BottomFrame.ActivateButton:SetScript("OnClick",function()StaticPopupDialogs["ASC_BC_ACTIVATE_CONFIRM"].OnAccept=function()t.Handle("BuildCreator","ActivateBuild",w)f(d)C()end
StaticPopup_Show("ASC_BC_ACTIVATE_CONFIRM")end)MagicButton_OnLoad(CA2.BC.BottomFrame.ActivateButton)table.insert(P,CA2.BC.BottomFrame.ActivateButton)CA2.BC.BottomFrame.DeactivateButton=CreateFrame("Button","CA2.BC.BottomFrame.DeactivateButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.DeactivateButton:SetSize(131,22)CA2.BC.BottomFrame.DeactivateButton:SetPoint("CENTER",CA2.BC.BottomFrame,"CENTER",0,-1)CA2.BC.BottomFrame.DeactivateButton:SetText("Deactivate Build")CA2.BC.BottomFrame.DeactivateButton:SetScript("OnClick",function(e)if(R~=w)or not(R)then
StaticPopupDialogs["ASC_ERROR"].text="This build isn't your active build. You can't deactivate it."StaticPopup_Show("ASC_ERROR")return false
end
StaticPopupDialogs["ASC_BC_DEACTIVATE_CONFIRM"].OnAccept=function()t.Handle("BuildCreator","DeactivateBuild",w)end
StaticPopup_Show("ASC_BC_DEACTIVATE_CONFIRM")end)MagicButton_OnLoad(CA2.BC.BottomFrame.DeactivateButton)CA2.BC.BottomFrame.DeactivateButton:Hide()table.insert(I,CA2.BC.BottomFrame.DeactivateButton)CA2.BC.BottomFrame.PublishButton=CreateFrame("Button","CA2.BC.BottomFrame.PublishButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.PublishButton:SetSize(131,22)CA2.BC.BottomFrame.PublishButton:SetPoint("CENTER",CA2.BC.BottomFrame,"CENTER",0,-1)CA2.BC.BottomFrame.PublishButton:SetText("Publish Build")CA2.BC.BottomFrame.PublishButton:SetScript("OnClick",function(e)if not(T)then
T=""end
if(x)then
t.Handle("BuildCreator","PublishBuild",n,h,c,i,d,CA2.BC.BuildNameText:GetText(),CA2.BC.BuildSubText:GetText(),T,w)else
t.Handle("BuildCreator","PublishBuild",n,h,c,i,d,CA2.BC.BuildNameText:GetText(),CA2.BC.BuildSubText:GetText(),T)end
end)MagicButton_OnLoad(CA2.BC.BottomFrame.PublishButton)CA2.BC.BottomFrame.PublishButton:Hide()table.insert(B,CA2.BC.BottomFrame.PublishButton)CA2.BC.BottomFrame.LearnAllButton=CreateFrame("Button","CA2.BC.BottomFrame.LearnAllButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.LearnAllButton:SetSize(131,22)CA2.BC.BottomFrame.LearnAllButton:SetPoint("RIGHT",CA2.BC.BottomFrame.ActivateButton,"LEFT",0,-1)CA2.BC.BottomFrame.LearnAllButton:SetText("Learn All")CA2.BC.BottomFrame.LearnAllButton:SetScript("OnClick",function(e)local e=0
for t=1,u do
if(GLOBAL_BC_MODE==3)then
if(n[t])then
e=e+r(t)end
else
if(ie[t])then
e=e+r(t)end
end
end
if(e==0)then
StaticPopupDialogs["ASC_ERROR"].text="No new spells/talents learned"else
StaticPopupDialogs["ASC_ERROR"].text="Learned "..e.." new spells/talents"end
StaticPopup_Show("ASC_ERROR")end)MagicButton_OnLoad(CA2.BC.BottomFrame.LearnAllButton)CA2.BC.BottomFrame.DescriptionButton=CreateFrame("Button","CA2.BC.BottomFrame.LearnAllButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.DescriptionButton:SetSize(131,22)CA2.BC.BottomFrame.DescriptionButton:SetPoint("LEFT",CA2.BC.BottomFrame.ActivateButton,"RIGHT",0,-1)CA2.BC.BottomFrame.DescriptionButton:SetText("Description")CA2.BC.BottomFrame.DescriptionButton:SetScript("OnClick",function(e)if(GLOBAL_BC_MODE==3)then
CA2.BC.DescriptionFrame.EditBox:EnableMouse(true)else
CA2.BC.DescriptionFrame.EditBox:EnableMouse(false)end
if(CA2.BC.DescriptionFrame:IsVisible())then
CA2.BC.DescriptionFrame:Hide()else
CA2.BC.DescriptionFrame:Show()end
end)MagicButton_OnLoad(CA2.BC.BottomFrame.DescriptionButton)CA2.BC.BottomFrame.EditButton=CreateFrame("Button","CA2.BC.BottomFrame.EditButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.EditButton:SetSize(131,22)CA2.BC.BottomFrame.EditButton:SetPoint("RIGHT",CA2.BC.BottomFrame,"RIGHT",-1,-1)CA2.BC.BottomFrame.EditButton:SetText("Create / Edit")CA2.BC.BottomFrame.EditButton:SetScript("OnClick",function(e)x=false
if(je)then
StaticPopup_Show("ASC_BC_SPECIAL")else
StaticPopup_Show("ASC_BC_NEWBUILD")end
end)MagicButton_OnLoad(CA2.BC.BottomFrame.EditButton)CA2.BC.BottomFrame.EditorQuitButton=CreateFrame("Button","CA2.BC.BottomFrame.EditorQuitButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.EditorQuitButton:SetSize(131,22)CA2.BC.BottomFrame.EditorQuitButton:SetPoint("RIGHT",CA2.BC.BottomFrame,"RIGHT",-1,-1)CA2.BC.BottomFrame.EditorQuitButton:SetText("Cancel")CA2.BC.BottomFrame.EditorQuitButton:SetScript("OnClick",function(e)StaticPopupDialogs["ASC_BC_LEAVE"].OnAccept=function()BC_RequestBuildInfo()x=false end
StaticPopup_Show("ASC_BC_LEAVE")end)MagicButton_OnLoad(CA2.BC.BottomFrame.EditorQuitButton)table.insert(B,CA2.BC.BottomFrame.EditorQuitButton)CA2.BC.BottomFrame.LoadLinkButton=CreateFrame("Button","CA2.BC.BottomFrame.LoadLinkButton",CA2.BC.BottomFrame,"StaticPopupButtonTemplate")CA2.BC.BottomFrame.LoadLinkButton:SetSize(131,22)CA2.BC.BottomFrame.LoadLinkButton:SetPoint("LEFT",CA2.BC.BottomFrame,"LEFT",10,-1)CA2.BC.BottomFrame.LoadLinkButton:SetText("Generate link")CA2.BC.BottomFrame.LoadLinkButton:SetScript("OnClick",function(e)StaticPopup_Show("ASC_LINK_DIALOGUE")end)MagicButton_OnLoad(CA2.BC.BottomFrame.LoadLinkButton)table.insert(B,CA2.BC.BottomFrame.LoadLinkButton)CA2.BC.BottomFrame.CheckButton=CreateFrame("CheckButton","CA2.BC.BottomFrame.CheckButton",CA2.BC.BottomFrame,"OptionsCheckButtonTemplate")CA2.BC.BottomFrame.CheckButton:SetPoint("LEFT",8,-1)CA2.BC.BottomFrame.CheckButton.tooltipText="System will automatically learn spells and talents according to selected build each level."_G["CA2.BC.BottomFrame.CheckButtonText"]:SetText("|cffFFFFFFAuto learn spells/talents|r")CA2.BC.BottomFrame.CheckButton:SetScript("OnClick",function()end)table.insert(I,CA2.BC.BottomFrame.CheckButton)CA2.BC.PassFrame=CreateFrame("FRAME","CA2.BC.PassFrame",CA2.BC)CA2.BC.PassFrame:SetSize(CA2.BC:GetWidth()-128,(CA2.BC:GetHeight()/2-32))CA2.BC.PassFrame:SetPoint("BOTTOM",0,24)CA2.BC.PassScroll=CreateFrame("ScrollFrame","CA2.BC.PassScroll",CA2.BC)CA2.BC.PassScroll:SetSize(CA2.BC.PassFrame:GetSize())CA2.BC.PassScroll:SetPoint("BOTTOM",0,24)CA2.BC.PassScroll:EnableMouseWheel(true)CA2.BC.PassScroll:RegisterForDrag("LeftButton")CA2.BC.PassScroll:EnableMouse(true)CA2.BC.PassScroll:SetScript("OnDragStart",function(e,...)e.Start_X=GetCursorPosition()end)CA2.BC.PassScroll:SetScript("OnDragStop",function(e,...)e.Start_X=nil
end)CA2.BC.PassScroll:SetScript("OnMouseWheel",function(e,t)if(e.ScrollBar:IsVisible())and(e.ScrollBar:IsEnabled()==1)then
local n=e.ScrollBar:GetValue()e.ScrollBar:SetValue(n+t*32)end
end)CA2.BC.PassScroll:SetScript("OnUpdate",function(e)if(e.Start_X)then
local t=GetCursorPosition();local t=-((t-e.Start_X)*1);e.Start_X=GetCursorPosition();e.ScrollBar:SetValue(e.ScrollBar:GetValue()+t);end
end)CA2.BC.PassScroll.ScrollBar=CreateFrame("Slider","CA2.BC.PassScroll.ScrollBar",CA2.BC.PassScroll)CA2.BC.PassScroll.ScrollBar:SetPoint("TOPLEFT",CA2.BC.PassScroll,"TOPRIGHT",5,-15)CA2.BC.PassScroll.ScrollBar:SetPoint("BOTTOMLEFT",CA2.BC.PassScroll,"BOTTOMRIGHT",0,15)CA2.BC.PassScroll.ScrollBar:SetMinMaxValues(1,CA2.BC.PassFrame:GetWidth())CA2.BC.PassScroll.ScrollBar:SetValueStep(1)CA2.BC.PassScroll.ScrollBar.scrollStep=1
CA2.BC.PassScroll.ScrollBar:SetValue(0)CA2.BC.PassScroll.ScrollBar:SetWidth(16)CA2.BC.PassScroll.ScrollBar:SetScript("OnValueChanged",function(t,e)CA2.BC.PassScroll:SetHorizontalScroll(e)s(t,e)end)CA2.BC.PassScroll:SetScrollChild(CA2.BC.PassFrame)CA2.BC.PassScroll.HeadSpellsTexture=CA2.BC.PassScroll:CreateTexture("CA2.BC.PassScroll.HeadSpellsTexture","ARTWORK")CA2.BC.PassScroll.HeadSpellsTexture:SetSize(256,32)CA2.BC.PassScroll.HeadSpellsTexture:SetPoint("CENTER",5,0)CA2.BC.PassScroll.HeadSpellsTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Header_Diff")CA2.BC.PassScroll.HeadSpellsText=CA2.BC.PassScroll:CreateFontString("CA2.BC.PassScroll.HeadSpellsText","OVERLAY")CA2.BC.PassScroll.HeadSpellsText:SetFontObject(GameFontHighlight)CA2.BC.PassScroll.HeadSpellsText:SetPoint("CENTER",0,0)CA2.BC.PassScroll.HeadSpellsText:SetSize(CA2.BC.PassScroll.HeadSpellsTexture:GetSize())CA2.BC.PassScroll.HeadSpellsText:SetText("Spells")CA2.BC.PassScroll.HeadSpellsText:SetJustifyH("CENTER")CA2.BC.PassScroll.HeadTalentsTexture=CA2.BC.PassScroll:CreateTexture("CA2.BC.PassScroll.HeadTalentsTexture","ARTWORK")CA2.BC.PassScroll.HeadTalentsTexture:SetSize(256,32)CA2.BC.PassScroll.HeadTalentsTexture:SetPoint("TOP",5,0)CA2.BC.PassScroll.HeadTalentsTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Header_Diff")CA2.BC.PassScroll.HeadTalentsText=CA2.BC.PassScroll:CreateFontString("CA2.BC.PassScroll.HeadTalentsText","OVERLAY")CA2.BC.PassScroll.HeadTalentsText:SetFontObject(GameFontHighlight)CA2.BC.PassScroll.HeadTalentsText:SetPoint("TOP",0,0)CA2.BC.PassScroll.HeadTalentsText:SetSize(CA2.BC.PassScroll.HeadTalentsTexture:GetSize())CA2.BC.PassScroll.HeadTalentsText:SetText("Talents")CA2.BC.PassScroll.HeadTalentsText:SetJustifyH("CENTER")CA2.BC.PassScroll.ScrollTutorialFrame=CreateFrame("FRAME","CA2.BC.PassScroll.ScrollTutorialFrame",CA2.BC.PassScroll)CA2.BC.PassScroll.ScrollTutorialFrame:SetSize(256,256)CA2.BC.PassScroll.ScrollTutorialFrame:SetPoint("CENTER",0,0)CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState=1
CA2.BC.PassScroll.ScrollTutorialFrame:Hide()function CA2.BC.PassScroll.ScrollTutorialFrame:StopAnimation()CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init:Stop()CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init:Stop()CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:Stop()CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out:Play()end
function CA2.BC.PassScroll.ScrollTutorialFrame:HandleAnimation()if not(CA2.BC.PassScroll.ScrollTutorialFrame:IsVisible())then
CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out:Stop()CA2.BC.PassScroll.ScrollTutorialFrame:Show()CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState=1
end
if(CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Counter==2)then
CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Counter=0
CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState=3
end
if(CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState==1)and not(CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init:IsPlaying())then
CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init:Play()CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init:Play()elseif(CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState==2)and not(CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:IsPlaying())then
CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:Play()elseif(CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState==3)and not(CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out:IsPlaying())then
CA2.BC.PassScroll.ScrollTutorialFrame:StopAnimation()end
end
CA2.BC.PassScroll.ScrollTutorialFrame:SetScript("OnUpdate",function()CA2.BC.PassScroll.ScrollTutorialFrame:HandleAnimation()end)CA2.BC.PassScroll.ScrollTutorialFrame.BG=CA2.BC.PassScroll.ScrollTutorialFrame:CreateTexture("CA2.BC.PassScroll.ScrollTutorialFrame.BG","BACKGROUND")CA2.BC.PassScroll.ScrollTutorialFrame.BG:SetSize(CA2.BC.PassScroll.ScrollTutorialFrame:GetSize())CA2.BC.PassScroll.ScrollTutorialFrame.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\Shadow")CA2.BC.PassScroll.ScrollTutorialFrame.BG:SetPoint("CENTER",0,0)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor=CA2.BC.PassScroll.ScrollTutorialFrame:CreateTexture("CA2.BC.PassScroll.ScrollTutorialFrame.Cursor","ARTWORK")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor:SetSize(24,24)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor:SetTexture("Interface\\CURSOR\\Point")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor:SetPoint("CENTER",30,0)CA2.BC.PassScroll.ScrollTutorialFrame.Circle=CA2.BC.PassScroll.ScrollTutorialFrame:CreateTexture("CA2.BC.PassScroll.ScrollTutorialFrame.Circle","BORDER")CA2.BC.PassScroll.ScrollTutorialFrame.Circle:SetSize(16,16)CA2.BC.PassScroll.ScrollTutorialFrame.Circle:SetTexture("Spells\\Circle")CA2.BC.PassScroll.ScrollTutorialFrame.Circle:SetPoint("CENTER",30,0)CA2.BC.PassScroll.ScrollTutorialFrame.Circle:SetBlendMode("ADD")CA2.BC.PassScroll.ScrollTutorialFrame.Circle:SetAlpha(0)CA2.BC.PassScroll.ScrollTutorialFrame.Tip=CA2.BC.PassScroll.ScrollTutorialFrame:CreateFontString("CA2.BC.PassScroll.ScrollTutorialFrame.Tip")CA2.BC.PassScroll.ScrollTutorialFrame.Tip:SetFontObject(GameFontNormal)CA2.BC.PassScroll.ScrollTutorialFrame.Tip:SetPoint("CENTER",0,-30)CA2.BC.PassScroll.ScrollTutorialFrame.Tip:SetText("Drag this menu to scroll over it")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init=CA2.BC.PassScroll.ScrollTutorialFrame:CreateAnimationGroup()CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha0=CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init:CreateAnimation("Alpha")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha0:SetDuration(0)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha0:SetOrder(1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha0:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha0:SetChange(-1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha1=CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init:CreateAnimation("Alpha")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha1:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha1:SetOrder(2)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha1:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Init.Alpha1:SetChange(1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init=CA2.BC.PassScroll.ScrollTutorialFrame.Circle:CreateAnimationGroup()CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha0=CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init:CreateAnimation("Alpha")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha0:SetDuration(0)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha0:SetOrder(1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha0:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha0:SetChange(1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha1=CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init:CreateAnimation("Alpha")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha1:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha1:SetOrder(2)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha1:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Alpha1:SetChange(-1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Scale1=CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init:CreateAnimation("Scale")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Scale1:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Scale1:SetOrder(2)CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Scale1:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init.Scale1:SetScale(3,3)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor:CreateAnimationGroup()CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move0=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init:CreateAnimation("Translation")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move0:SetDuration(0)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move0:SetOrder(1)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move0:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move0:SetOffset(30,-10)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move1=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init:CreateAnimation("Translation")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move1:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move1:SetOrder(2)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move1:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init.Move1:SetOffset(-30,10)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Init:SetScript("OnFinished",function(e)CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState=2
CA2.BC.PassScroll.ScrollTutorialFrame.Circle.AG_Init:Play()end)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor:CreateAnimationGroup()CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Counter=0
CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move0=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:CreateAnimation("Translation")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move0:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move0:SetOrder(1)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move0:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move0:SetOffset(-60,0)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move1=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:CreateAnimation("Translation")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move1:SetDuration(.5)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move1:SetOrder(2)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move1:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Move1:SetOffset(60,0)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main:SetScript("OnFinished",function(e)CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Counter=CA2.BC.PassScroll.ScrollTutorialFrame.Cursor.AG_Main.Counter+1
end)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out=CA2.BC.PassScroll.ScrollTutorialFrame:CreateAnimationGroup()CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0=CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out:CreateAnimation("Alpha")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0:SetDuration(1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0:SetOrder(1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0:SetSmoothing("IN_OUT")CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0:SetChange(-1)CA2.BC.PassScroll.ScrollTutorialFrame.AG_Out.Alpha0:SetScript("OnFinished",function()CA2.BC.PassScroll.ScrollTutorialFrame:Hide()CA2.BC.PassScroll.ScrollTutorialFrame.AnimationState=1
end)CA2.BC.PassScroll.ArrowR=CreateFrame("BUTTON","CA2.BC.PassScroll.ArrowR",CA2.BC.PassScroll)function CA2.BC.PassScroll.ArrowR.Update(e,t)if not(e.timeSinceLast)then
e.timeSinceLast=.16
end
e.timeSinceLast=e.timeSinceLast+t;if(e.timeSinceLast>=(.16))then
if(not IsMouseButtonDown("LeftButton"))then
e:SetScript("OnUpdate",nil);elseif(e:IsMouseOver())then
if not(e.TimesUsed)then
e.TimesUsed=0
end
e.TimesUsed=e.TimesUsed+1
if(e.TimesUsed>5)then
CA2.BC.PassScroll.ScrollTutorialFrame:HandleAnimation()e.TimesUsed=0
end
local t=e:GetParent().ScrollBar
t:SetValue(t:GetValue()+(64*e.direction))e.timeSinceLast=0
end
end
end
CA2.BC.PassScroll.ArrowR:SetSize(32,64)CA2.BC.PassScroll.ArrowR:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.PassScroll.ArrowR:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.PassScroll.ArrowR:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.PassScroll.ArrowR:SetDisabledTexture(CA2.BC.PassScroll.ArrowR:GetNormalTexture():GetTexture())CA2.BC.PassScroll.ArrowR:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.PassScroll.ArrowR.direction=1
CA2.BC.PassScroll.ArrowR:SetPoint("BOTTOMRIGHT",42,42)CA2.BC.PassScroll.ArrowR:SetScript("OnMouseDown",function(e)e:SetScript("OnUpdate",e.Update)end)CA2.BC.PassScroll.ArrowR.FastButton=CreateFrame("Button","CA2.BC.PassScroll.ArrowR.FastButton",CA2.BC.PassScroll.ArrowR)CA2.BC.PassScroll.ArrowR.FastButton:SetSize(32,22)CA2.BC.PassScroll.ArrowR.FastButton:SetPoint("TOP",CA2.BC.PassScroll.ArrowR,"BOTTOM",0,15)CA2.BC.PassScroll.ArrowR.FastButton:SetText("To level 70")CA2.BC.PassScroll.ArrowR.FastButton:SetNormalFontObject(GameFontNormalSmall)CA2.BC.PassScroll.ArrowR.FastButton:SetHighlightFontObject(GameFontHighlightSmall)CA2.BC.PassScroll.ArrowR.FastButton:SetDisabledFontObject(GameFontDisableSmall)CA2.BC.PassScroll.ArrowR.FastButton:SetScript("OnMouseDown",function(e)local e=e:GetParent():GetParent().ScrollBar
local n,t=e:GetMinMaxValues()e:SetValue(t)end)CA2.BC.PassScroll.ArrowL=CreateFrame("BUTTON","CA2.BC.PassScroll.ArrowL",CA2.BC.PassScroll)CA2.BC.PassScroll.ArrowL:SetSize(32,64)CA2.BC.PassScroll.ArrowL:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow")CA2.BC.PassScroll.ArrowL:GetNormalTexture():SetTexCoord(1,0,0,1)CA2.BC.PassScroll.ArrowL:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_h")CA2.BC.PassScroll.ArrowL:GetHighlightTexture():SetTexCoord(1,0,0,1)CA2.BC.PassScroll.ArrowL:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Arrow_p")CA2.BC.PassScroll.ArrowL:GetPushedTexture():SetTexCoord(1,0,0,1)CA2.BC.PassScroll.ArrowL:SetDisabledTexture(CA2.BC.BlockL.ArmorScroll.ArrowL:GetNormalTexture():GetTexture())CA2.BC.PassScroll.ArrowL:GetDisabledTexture():SetTexCoord(1,0,0,1)CA2.BC.PassScroll.ArrowL:GetDisabledTexture():SetVertexColor(.4,.4,.4,1)CA2.BC.PassScroll.ArrowL:Disable()CA2.BC.PassScroll.ArrowL.direction=-1
CA2.BC.PassScroll.ArrowL:SetPoint("BOTTOMLEFT",-42,42)CA2.BC.PassScroll.ArrowL:SetScript("OnMouseDown",function(e)e:SetScript("OnUpdate",BuildCreator_ArrowR_OnUpdate)end)CA2.BC.PassScroll.ArrowL.FastButton=CreateFrame("Button","CA2.BC.PassScroll.ArrowL.FastButton",CA2.BC.PassScroll.ArrowL)CA2.BC.PassScroll.ArrowL.FastButton:SetSize(32,22)CA2.BC.PassScroll.ArrowL.FastButton:SetPoint("TOP",CA2.BC.PassScroll.ArrowL,"BOTTOM",0,15)CA2.BC.PassScroll.ArrowL.FastButton:SetText("To level 1")CA2.BC.PassScroll.ArrowL.FastButton:SetNormalFontObject(GameFontNormalSmall)CA2.BC.PassScroll.ArrowL.FastButton:SetHighlightFontObject(GameFontHighlightSmall)CA2.BC.PassScroll.ArrowL.FastButton:SetDisabledFontObject(GameFontDisableSmall)CA2.BC.PassScroll.ArrowL.FastButton:SetScript("OnClick",function(e)local e=e:GetParent():GetParent().ScrollBar
local t,n=e:GetMinMaxValues()e:SetValue(t)end)CA2.BC.PassScroll.ArrowL.FastButton:Disable()for e=1,u do
_G["CA2.BC.PassFrame.Level"..e.."Frame"]=CreateFrame("FRAME","CA2.BC.PassFrame.Level"..e.."Frame",CA2.BC.PassFrame)_G["CA2.BC.PassFrame.Level"..e.."Frame"]:SetSize(V,CA2.BC.PassFrame:GetHeight())if(e>1)then
_G["CA2.BC.PassFrame.Level"..e.."Frame"]:SetPoint("LEFT",_G["CA2.BC.PassFrame.Level"..(e-1).."Frame"],"RIGHT",0,0)else
_G["CA2.BC.PassFrame.Level"..e.."Frame"]:SetPoint("LEFT",10,0)end
_G["CA2.BC.PassFrame.Level"..e.."Frame"].SpellTable={}_G["CA2.BC.PassFrame.Level"..e.."Frame"].TalentTable={}_G["CA2.BC.PassFrame.Level"..e.."Frame.SeperatorTexture"]=_G["CA2.BC.PassFrame.Level"..e.."Frame"]:CreateTexture("CA2.BC.PassFrame.Level"..e.."Frame.SeperatorTexture","OVERLAY")_G["CA2.BC.PassFrame.Level"..e.."Frame.SeperatorTexture"]:SetSize(16,16)_G["CA2.BC.PassFrame.Level"..e.."Frame.SeperatorTexture"]:SetPoint("BOTTOMRIGHT",8.5,4)_G["CA2.BC.PassFrame.Level"..e.."Frame.SeperatorTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\Seperator")_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]=_G["CA2.BC.PassFrame.Level"..e.."Frame"]:CreateFontString("CA2.BC.PassFrame.Level"..e.."Frame.Text","OVERLAY")_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetFont("Fonts\\FRIZQT__.TTF",8)_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetFontObject(GameFontHighlightSmall)_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetPoint("BOTTOM",0,4)_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetSize(_G["CA2.BC.PassFrame.Level"..e.."Frame"]:GetWidth(),16)_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetText(e)_G["CA2.BC.PassFrame.Level"..e.."Frame.Text"]:SetJustifyH("CENTER")_G["CA2.BC.PassFrame.Level"..e.."Frame.BarTex"]=_G["CA2.BC.PassFrame.Level"..e.."Frame"]:CreateTexture("CA2.BC.PassFrame.Level"..e.."Frame.BarTex","ARTWORK")_G["CA2.BC.PassFrame.Level"..e.."Frame.BarTex"]:SetSize(V,8)_G["CA2.BC.PassFrame.Level"..e.."Frame.BarTex"]:SetPoint("BOTTOM",0,7)_G["CA2.BC.PassFrame.Level"..e.."Frame.BarTex"]:SetTexture("Interface\\TARGETINGFRAME\\UI-TargetingFrame-BarFill")_G["CA2.BC.PassFrame.Level"..e.."Frame.BarTex"]:SetVertexColor(.58,0,.55,1)end
CA2.BC.PassScroll.Bar=CreateFrame("FRAME","CA2.BC.PassScroll.Bar",CA2.BC.PassScroll)CA2.BC.PassScroll.Bar:SetSize(CA2.BC.PassScroll:GetWidth(),32)CA2.BC.PassScroll.Bar:SetPoint("BOTTOM",0,0)CA2.BC.PassScroll.Bar.Gradient=CA2.BC.PassScroll.Bar:CreateTexture("CA2.BC.PassScroll.Bar.Gradient","BACKGROUND")CA2.BC.PassScroll.Bar.Gradient:SetSize(2048,1024)CA2.BC.PassScroll.Bar.Gradient:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\CAO_BC_Gradient")CA2.BC.PassScroll.Bar.Gradient:SetPoint("CENTER",CA2,7,-46)CA2.BC.PassScroll.Bar.Texture=CA2.BC.PassScroll.Bar:CreateTexture("CA2.BC.PassScroll.Bar.Texture","BORDER")CA2.BC.PassScroll.Bar.Texture:SetSize(1024,64)CA2.BC.PassScroll.Bar.Texture:SetPoint("CENTER",17,6)CA2.BC.PassScroll.Bar.Texture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\BuildCreator\\BarTexture")CA2.CharacterAdvancementMain.Main.Tree2.Content:Hide()CA2.CharacterAdvancementMain.Main.Tree3.Content:Hide()function CA2MatchController()CA2.CollectionControllerTab1:SetText(CollectionController.CollectionControllerTab1:GetText())CA2.CollectionControllerTab2:SetText(CollectionController.CollectionControllerTab2:GetText())CA2.CollectionControllerTab3:SetText(CollectionController.CollectionControllerTab3:GetText())CA2.CollectionControllerTab4:SetText(CollectionController.CollectionControllerTab4:GetText())CA2.CollectionControllerTab1:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab1:GetScript("OnClick")(CollectionController.CollectionControllerTab1,t)e:Enable()end)CA2.CollectionControllerTab2:SetScript("OnClick",function(t,e)CollectionController.CollectionControllerTab2:GetScript("OnClick")(CollectionController.CollectionControllerTab2,e)end)CA2.CollectionControllerTab3:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab3:GetScript("OnClick")(CollectionController.CollectionControllerTab3,t)e:Enable()end)CA2.CollectionControllerTab4:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab4:GetScript("OnClick")(CollectionController.CollectionControllerTab4,t)e:Enable()end)CA2.CollectionControllerTab1:SetScript("OnEnter",function(t,e)CollectionController.CollectionControllerTab1:GetScript("OnEnter")(t,e)end)CA2.CollectionControllerTab2:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab2:GetScript("OnEnter")(e,t)end)CA2.CollectionControllerTab3:SetScript("OnEnter",function(t,e)CollectionController.CollectionControllerTab3:GetScript("OnEnter")(t,e)end)CA2.CollectionControllerTab4:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab4:GetScript("OnEnter")(e,t)end)CA2.CollectionControllerTab1:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab1:GetScript("OnLeave")(t,e)end)CA2.CollectionControllerTab2:SetScript("OnLeave",function(e,t)CollectionController.CollectionControllerTab2:GetScript("OnLeave")(e,t)end)CA2.CollectionControllerTab3:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab3:GetScript("OnLeave")(t,e)end)CA2.CollectionControllerTab4:SetScript("OnLeave",function(e,t)CollectionController.CollectionControllerTab4:GetScript("OnLeave")(e,t)end)CA2.CollectionControllerTab2.Icon:SetTexture(CollectionController.CollectionControllerTab2.Icon:GetTexture())CA2.CollectionControllerTab3.Icon:SetTexture(CollectionController.CollectionControllerTab3.Icon:GetTexture())CA2.CollectionControllerTab1.Icon:SetTexture(CollectionController.CollectionControllerTab1.Icon:GetTexture())CA2.CollectionControllerTab4.Icon:SetTexture(CollectionController.CollectionControllerTab4.Icon:GetTexture())CA2.CollectionControllerTab5:SetText(CollectionController.CollectionControllerTab5:GetText())CA2.CollectionControllerTab5:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab5:GetScript("OnClick")(CollectionController.CollectionControllerTab5,t)e:Enable()end)CA2.CollectionControllerTab5:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab5:GetScript("OnEnter")(e,t)end)CA2.CollectionControllerTab5:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab5:GetScript("OnLeave")(t,e)end)CA2.CollectionControllerTab5.Icon:SetTexture(CollectionController.CollectionControllerTab5.Icon:GetTexture())end
CA2.CollectionControllerTab2=CreateFrame("CheckButton","CA2.CollectionControllerTab2",CA2,nil)CA2.CollectionControllerTab2:SetSize(148,32)CA2.CollectionControllerTab2:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")CA2.CollectionControllerTab2:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)CA2.CollectionControllerTab2:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")CA2.CollectionControllerTab2:SetPoint("BOTTOMLEFT",20,-20)CA2.CollectionControllerTab2:SetNormalFontObject(GameFontNormalSmall)CA2.CollectionControllerTab2:SetHighlightFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab2:SetDisabledFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab2:SetText("Character\nAdvancement")CA2.CollectionControllerTab2:GetFontString():SetPoint("CENTER",0,4)CA2.CollectionControllerTab2:Disable()CA2.CollectionControllerTab2.BG=CA2.CollectionControllerTab2:CreateTexture(nil,"BACKGROUND")CA2.CollectionControllerTab2.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")CA2.CollectionControllerTab2.BG:SetSize(148,31)CA2.CollectionControllerTab2.BG:SetPoint("CENTER",0,0)CA2.CollectionControllerTab2.Icon=CA2.CollectionControllerTab2:CreateTexture(nil,"OVERLAY")CA2.CollectionControllerTab2.Icon:SetSize(16,16)CA2.CollectionControllerTab2.Icon:SetTexture("Interface\\icons\\INV_Misc_Book_07")CA2.CollectionControllerTab2.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(CA2.CollectionControllerTab2.Icon,"Interface\\AddOns\\AwAddons\\Textures\\Misc\\spell_Paladin_divinecircle")CA2.CollectionControllerTab5=CreateFrame("CheckButton","CA2.CollectionControllerTab5",CA2,nil)CA2.CollectionControllerTab5:SetSize(148,32)CA2.CollectionControllerTab5:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")CA2.CollectionControllerTab5:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)CA2.CollectionControllerTab5:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")CA2.CollectionControllerTab5:SetPoint("LEFT",CA2.CollectionControllerTab2,"RIGHT",-16,0)CA2.CollectionControllerTab5:SetNormalFontObject(GameFontNormalSmall)CA2.CollectionControllerTab5:SetHighlightFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab5:SetDisabledFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab5:SetText("Character\nAdvancement")CA2.CollectionControllerTab5:GetFontString():SetPoint("CENTER",0,4)CA2.CollectionControllerTab5:Enable()CA2.CollectionControllerTab5:EnableMouse(false)CA2.CollectionControllerTab5:SetNormalFontObject(GameFontDisableSmall)CA2.CollectionControllerTab5.BG=CA2.CollectionControllerTab5:CreateTexture(nil,"BACKGROUND")CA2.CollectionControllerTab5.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")CA2.CollectionControllerTab5.BG:SetSize(148,31)CA2.CollectionControllerTab5.BG:SetPoint("CENTER",0,0)CA2.CollectionControllerTab5.Icon=CA2.CollectionControllerTab5:CreateTexture(nil,"OVERLAY")CA2.CollectionControllerTab5.Icon:SetSize(16,16)CA2.CollectionControllerTab5.Icon:SetTexture("Interface\\icons\\INV_Misc_Book_07")CA2.CollectionControllerTab5.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(CA2.CollectionControllerTab5.Icon,"Interface\\AddOns\\AwAddons\\Textures\\Misc\\spell_Paladin_divinecircle")CA2.CollectionControllerTab3=CreateFrame("CheckButton","CA2.CollectionControllerTab3",CA2,nil)CA2.CollectionControllerTab3:SetSize(128,32)CA2.CollectionControllerTab3:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")CA2.CollectionControllerTab3:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)CA2.CollectionControllerTab3:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")CA2.CollectionControllerTab3:SetPoint("LEFT",CA2.CollectionControllerTab5,"RIGHT",-16,0)CA2.CollectionControllerTab3:SetNormalFontObject(GameFontNormalSmall)CA2.CollectionControllerTab3:SetHighlightFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab3:SetDisabledFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab3:SetText("Vanity")CA2.CollectionControllerTab3:GetFontString():SetPoint("CENTER",0,2)CA2.CollectionControllerTab3.BG=CA2.CollectionControllerTab3:CreateTexture(nil,"BACKGROUND")CA2.CollectionControllerTab3.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")CA2.CollectionControllerTab3.BG:SetSize(128,31)CA2.CollectionControllerTab3.BG:SetPoint("CENTER",0,0)CA2.CollectionControllerTab3.Icon=CA2.CollectionControllerTab3:CreateTexture(nil,"OVERLAY")CA2.CollectionControllerTab3.Icon:SetSize(16,16)CA2.CollectionControllerTab3.Icon:SetTexture("Interface\\icons\\INV_Chest_Awakening")CA2.CollectionControllerTab3.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(CA2.CollectionControllerTab3.Icon,"Interface\\icons\\INV_Chest_Awakening")CA2.CollectionControllerTab1=CreateFrame("CheckButton","CA2.CollectionControllerTab1",CA2,nil)CA2.CollectionControllerTab1:SetSize(128,32)CA2.CollectionControllerTab1:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")CA2.CollectionControllerTab1:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)CA2.CollectionControllerTab1:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")CA2.CollectionControllerTab1:SetPoint("LEFT",CA2.CollectionControllerTab3,"RIGHT",-16,0)CA2.CollectionControllerTab1:SetNormalFontObject(GameFontNormalSmall)CA2.CollectionControllerTab1:SetHighlightFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab1:SetDisabledFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab1:SetText("Enchants")CA2.CollectionControllerTab1:GetFontString():SetPoint("CENTER",0,2)CA2.CollectionControllerTab1.BG=CA2.CollectionControllerTab1:CreateTexture(nil,"BACKGROUND")CA2.CollectionControllerTab1.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")CA2.CollectionControllerTab1.BG:SetSize(128,31)CA2.CollectionControllerTab1.BG:SetPoint("CENTER",0,0)CA2.CollectionControllerTab1.Icon=CA2.CollectionControllerTab1:CreateTexture(nil,"OVERLAY")CA2.CollectionControllerTab1.Icon:SetSize(16,16)CA2.CollectionControllerTab1.Icon:SetTexture("Interface\\icons\\inv_custom_ReforgeToken")CA2.CollectionControllerTab1.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(CA2.CollectionControllerTab1.Icon,"Interface\\icons\\inv_custom_ReforgeToken")CA2.CollectionControllerTab4=CreateFrame("CheckButton","CA2.CollectionControllerTab4",CA2,nil)CA2.CollectionControllerTab4:SetSize(128,32)CA2.CollectionControllerTab4:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")CA2.CollectionControllerTab4:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)CA2.CollectionControllerTab4:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")CA2.CollectionControllerTab4:SetPoint("LEFT",CA2.CollectionControllerTab1,"RIGHT",-16,0)CA2.CollectionControllerTab4:SetNormalFontObject(GameFontNormalSmall)CA2.CollectionControllerTab4:SetHighlightFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab4:SetDisabledFontObject(GameFontHighlightSmall)CA2.CollectionControllerTab4:SetText("Seasonal")CA2.CollectionControllerTab4:GetFontString():SetPoint("CENTER",0,2)CA2.CollectionControllerTab4.BG=CA2.CollectionControllerTab4:CreateTexture(nil,"BACKGROUND")CA2.CollectionControllerTab4.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")CA2.CollectionControllerTab4.BG:SetSize(128,31)CA2.CollectionControllerTab4.BG:SetPoint("CENTER",0,0)CA2.CollectionControllerTab4.Icon=CA2.CollectionControllerTab4:CreateTexture(nil,"OVERLAY")CA2.CollectionControllerTab4.Icon:SetSize(16,16)CA2.CollectionControllerTab4.Icon:SetTexture("Interface\\icons\\INV_Chest_Awakening")CA2.CollectionControllerTab4.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(CA2.CollectionControllerTab4.Icon,"Interface\\icons\\season1_complete")if(CollectionController)then
CA2MatchController()end
CA2.SettingsMenu=CreateFrame("FRAME","CA2.SettingsMenu",IgnoreListFrame,"UIDropDownMenuTemplate")CA2.SettingsMenu:SetClampedToScreen(true)CA2.SettingsMenu:Show()function CA2.SettingsMenu.Init(e,t)local e;if(t==1)then
e=UIDropDownMenu_CreateInfo()e.text="Character Advancement Settings"e.isTitle=true
e.notCheckable=true
UIDropDownMenu_AddButton(e,t)e=UIDropDownMenu_CreateInfo()e.text="Quick Access"e.hasArrow=true;e.notCheckable=true;UIDropDownMenu_AddButton(e,t)e=UIDropDownMenu_CreateInfo()e.text="Close"e.justifyH="LEFT"e.notCheckable=true
UIDropDownMenu_AddButton(e,t)elseif(t==2)then
e=UIDropDownMenu_CreateInfo()e.text="Enabled"e.justifyH="LEFT"if(CA2.SettingsMenu.Status)and(fastaccessframe)and(fastaccessframe:IsVisible())then
e.checked=true
else
e.checked=false
end
e.func=function()fastaccessframe:Show()table.remove(fastacc_var,1)table.insert(fastacc_var,1,2)CA2.SettingsMenu.Status=true end
UIDropDownMenu_AddButton(e,t)e=UIDropDownMenu_CreateInfo()e.text="Disabled"e.justifyH="LEFT"if not(CA2.SettingsMenu.Status)or not(fastaccessframe)or not(fastaccessframe:IsVisible())then
e.checked=true
else
e.checked=false
end
e.func=function()fastaccessframe:Hide()table.remove(fastacc_var,1)table.insert(fastacc_var,1,1)CA2.SettingsMenu.Status=false end
UIDropDownMenu_AddButton(e,t)end
end
UIDropDownMenu_SetWidth(CA2.SettingsMenu,140);UIDropDownMenu_SetButtonWidth(CA2.SettingsMenu,70)UIDropDownMenu_JustifyText(CA2.SettingsMenu,"LEFT")UIDropDownMenu_Initialize(CA2.SettingsMenu,CA2.SettingsMenu.Init,"MENU");CA2.Settings=CreateFrame("Button","CA2.Settings",CA2)CA2.Settings:SetPoint("TOPRIGHT",-8,-32)CA2.Settings:SetSize(26,26)CA2.Settings:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon")CA2.Settings:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\CAOverhaul\\GearIcon_H")CA2.Settings:SetScript("OnClick",function()ToggleDropDownMenu(1,nil,CA2.SettingsMenu,"cursor");end)function CheckQuickAccessLogic()if not(fastacc_var)or(fastacc_var[1]==1)then
fastacc_var={}CA2.SettingsMenu.Status=false
table.remove(fastacc_var,1)table.insert(fastacc_var,1,1)if(fastaccessframe)then
fastaccessframe:Hide()end
else
fastacc_var={}CA2.SettingsMenu.Status=true
table.remove(fastacc_var,1)table.insert(fastacc_var,1,2)if(fastaccessframe)then
fastaccessframe:Show()end
end
if fastaccessframe and(fastacc_var[1]==1)and(fastaccessframe:IsVisible())then
fastaccessframe:Hide()CA2.SettingsMenu.Status=false
end
end
CheckQuickAccessLogic()t.AddSavedVar("fastacc_var")function ChangeSpecCommands(n)local e=tonumber(n)if(e and e>0 and e<=#M)then
t.Handle("SwitchSpec","ChangeSpecPrep",e)else
SendSystemMessage("You can't switch to spec '"..n.."'")end
end
SLASH_CHANGESPEC1,SLASH_CHANGESPEC2='/changespec','/cs'SlashCmdList["CHANGESPEC"]=ChangeSpecCommands
t.AddSavedVarChar("SpecNamesCustom")t.AddSavedVarChar("SpecIconsCustom")t.AddSavedVarChar("CAO_RankUpList")