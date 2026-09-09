Ulocal e=AIO or require("AIO")local t=3.05
if e.AddAddon()then
return
end
local e=CreateFrame("Frame","TrainingFrame",UIParent,nil)local d=false
local L=false
local b=false
local P=1101243
local I=1101244
local se=1101245
local c=nil
local S="BASIC"local O=383080
local W=383081
local t=383082
local l=383083
local de="Interface\\Icons\\inv_custom_tutorial"local J="Interface\\Icons\\inv_custom_scrollofunlearning_seasonal"local Z="Interface\\Icons\\inv_custom_scrollofunlearning"local j="Interface\\Icons\\inv_misc_coin_02"local w="Interface\\Icons\\inv_misc_scrollunrolled01c"ClassColorCodes={"C79C6E","F58CBA","ABD473","FFF569","FFFFFF","C41F3B","0070DE","69CCF0","9482C9",nil,"FF7D0A"}local Q={}local ue={}local Y={}local f={}local l={}local o={}local H={}local K={}local m={}local u={}local q={}local x={}local re=44
local M=1
local V={"|cff"..ClassColorCodes[11].."Balance Druid|r","|cff"..ClassColorCodes[11].."Feral Druid|r","|cff"..ClassColorCodes[11].."Restoration Druid|r","|cff"..ClassColorCodes[3].."Beast Mastery Hunter|r","|cff"..ClassColorCodes[3].."Marksmanship Hunter|r","|cff"..ClassColorCodes[3].."Survival Hunter|r","|cff"..ClassColorCodes[8].."Arcane Mage|r","|cff"..ClassColorCodes[8].."Fire Mage|r","|cff"..ClassColorCodes[8].."Frost Mage|r","|cff"..ClassColorCodes[2].."Holy Paladin|r","|cff"..ClassColorCodes[2].."Protection Paladin|r","|cff"..ClassColorCodes[2].."Retribution Paladin|r","|cff"..ClassColorCodes[5].."Discipline Priest|r","|cff"..ClassColorCodes[5].."Holy Priest|r","|cff"..ClassColorCodes[5].."Shadow Priest|r","|cff"..ClassColorCodes[4].."Assassination Rogue|r","|cff"..ClassColorCodes[4].."Combat Rogue|r","|cff"..ClassColorCodes[4].."Subtlety Rogue|r","|cff"..ClassColorCodes[7].."Elemental Shaman|r","|cff"..ClassColorCodes[7].."Enhancement Shaman|r","|cff"..ClassColorCodes[7].."Restoration Shaman|r","|cff"..ClassColorCodes[9].."Affliction Warlock|r","|cff"..ClassColorCodes[9].."Demonology Warlock|r","|cff"..ClassColorCodes[9].."Destruction Warlock|r","|cff"..ClassColorCodes[1].."Arms Warrior|r","|cff"..ClassColorCodes[1].."Fury Warrior|r","|cff"..ClassColorCodes[1].."Protection Warrior|r","|cff6b625bGeneral|r",}local B={{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}}local r={}local n={}local s,a={},{}local i={}local F=0
local E=14
local T=0
local h=1
local A=0
local g=0
local C=0
local y=1
local te={{"DRUID","BALANCE"},{"DRUID","FERAL"},{"DRUID","RESTORATION"},{"HUNTER","BEASTMASTERY"},{"HUNTER","MARKSMANSHIP"},{"HUNTER","SURVIVAL"},{"MAGE","ARCANE"},{"MAGE","FIRE"},{"MAGE","FROST"},{"PALADIN","HOLY"},{"PALADIN","PROTECTION"},{"PALADIN","RETRIBUTION"},{"PRIEST","DISCIPLINE"},{"PRIEST","HOLY"},{"PRIEST","SHADOW"},{"ROGUE","ASSASSINATION"},{"ROGUE","COMBAT"},{"ROGUE","SUBTLETY"},{"SHAMAN","ELEMENTAL"},{"SHAMAN","ENHANCEMENT"},{"SHAMAN","RESTORATION"},{"WARLOCK","AFFLICTION"},{"WARLOCK","DEMONOLOGY"},{"WARLOCK","DESTRUCTION"},{"WARRIOR","ARMS"},{"WARRIOR","FURY"},{"WARRIOR","PROTECTION"},{"GENERAL","GENERAL"}}local ee={"DRUIDBALANCE","DRUIDFERAL","DRUIDRESTORATION","HUNTERBEASTMASTERY","HUNTERMARKSMANSHIP","HUNTERSURVIVAL","MAGEARCANE","MAGEFIRE","MAGEFROST","PALADINHOLY","PALADINPROTECTION","PALADINRETRIBUTION","PRIESTDISCIPLINE","PRIESTHOLY","PRIESTSHADOW","ROGUEASSASSINATION","ROGUECOMBAT","ROGUESUBTLETY","SHAMANELEMENTAL","SHAMANENHANCEMENT","SHAMANRESTORATION","WARLOCKAFFLICTION","WARLOCK","DEMONOLOGY","WARLOCKDESTRUCTION","WARRIORARMS","WARRIORFURY","WARRIORPROTECTION"}local p,ie=UIParent:GetSize()local D=1
local G=1
local k={[355]={71},[6572]={71},[2565]={71},[871]={71},[23922]={71},[23920]={71},[1719]={2458},[6343]={2457,71},[20230]={2457},[921]={1784},[6770]={1784},[703]={1784},[8676]={1784},[1833]={1784},[53407]={20165,21084,20166,20164,20375},[20271]={20165,21084,20166,20164,20375},[53408]={20165,21084,20166,20164,20375},[99]={5487,9634},[6807]={5487,9634},[6795]={5487,9634},[5229]={5487,9634},[5211]={5487,9634},[779]={5487,9634},[16857]={5487,9634,768},[1082]={768},[5215]={768},[62078]={768},[5221]={768},[1822]={768},[5217]={768},[1850]={768},[8998]={768},[5209]={5487,9634},[22568]={768},[6785]={768},[9005]={768},[22842]={5487,9634},[62600]={5487,9634},[22570]={768},[33745]={5487,9634},[1079]={768},}local le={}local R={}StaticPopupDialogs["ASC_ERROR"]={text="ERROR!",button1="Continue",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"]={button1="Learn",button2="Cancel",whileDead=true,timeout=0,hideOnEscape=true,}function GetListOfAllKnownSpells()local e={}for l,t in pairs(r)do
if(t[5])then
e[l]=true
end
end
for l,t in pairs(n)do
if(t[6]>0)then
e[t[2][1]]=true
end
end
return e
end
local p=CreateFrame("GameTooltip","SpellDescTooltip",UIParent,"GameTooltipTemplate")function GetSpellTooltipText(t)local e=""for l=1,t:NumLines()do
e=e.."\n".._G[t:GetName().."TextLeft"..l]:GetText()end
return e
end
function GetSpellDescription(t)p:SetOwner(WorldFrame,"ACHOR_NONE")local l=nil
local e=GetSpellInfo(t)if not(e)then
return false
end
local e="|cff71d5ff|Hspell:"..t.."|h["..e.."]|h|r"p:SetHyperlink(e)l=GetSpellTooltipText(p)p:Hide()return l
end
function ResetAccessFrameHandle()if(S=="SPELLS")then
ResetAccessFrame.MainButton:SetText("Reset Spells |cffFFFFFF(Gold)|r")ResetAccessFrame.MainButton:Enable()ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your spells|r")GameTooltip:AddLine("Change the |cffFFFFFFgold|r you have to a spell reset")GameTooltip:AddLine("Use this option once you decide to clear all spells of your build")GameTooltip:Show()end)if(UnitLevel("player")<10)then
ResetAccessFrame.MainButton:SetText("Reset Spells |cffFFFFFF(Free)|r")ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your spells|r")GameTooltip:AddLine("Up to level |cffFFFFFF10|r all your resets are free")GameTooltip:AddLine("Use this option once you decide to clear all spells of your build")GameTooltip:Show()end)elseif GetItemCount(t)and(GetItemCount(t)>0)then
ResetAccessFrame.MainButton:SetText("Reset Spells |cffFFFFFF(Token)|r")ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your spells|r")GameTooltip:AddLine("Seems like you have enough |cffFFFFFF[Ability Purge]|r to exchange it to a reset")GameTooltip:AddLine("Use this option once you decide to clear all spells of your build")GameTooltip:Show()end)end
ResetAccessFrame.MainButton:SetScript("OnClick",function(t)PlaySound("igMainMenuOptionCheckBoxOn")PlaySound("TalentScreenOpen")if(t:IsEnabled()==0)then
return false
end
if not(ResetFrame_main:IsVisible())then
ResetFrame_main:Show()StatFrame:Hide()e:Hide()CollectionController:Hide()else
ResetFrame_main:Hide()end
ResetButton_button_pushed(ResetFrame_main_AbilityResetButton)end)ResetAccessFrame:Show()elseif(S=="TALENTS")then
ResetAccessFrame.MainButton:SetText("Reset Talents |cffFFFFFF(Gold)|r")ResetAccessFrame.MainButton:Enable()ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your talents|r")GameTooltip:AddLine("Change the |cffFFFFFFgold|r you have to a talent reset")GameTooltip:AddLine("Use this option once you decide to clear all talents of your build")GameTooltip:Show()end)if(UnitLevel("player")<10)then
ResetAccessFrame.MainButton:SetText("Reset Talents |cffFFFFFF(Free)|r")ResetAccessFrame.MainButton:Disable()ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your talents|r")GameTooltip:AddLine("Up to level |cffFFFFFF10|r all your resets are free")GameTooltip:AddLine("Use this option once you decide to clear all talents of your build")GameTooltip:Show()end)elseif GetItemCount(t)and(GetItemCount(t)>0)then
ResetAccessFrame.MainButton:SetText("Reset Talents |cffFFFFFF(Token)|r")ResetAccessFrame.MainButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFReset all your talents|r")GameTooltip:AddLine("Seems like you have enough |cffFFFFFF[Talent Purge]|r to exchange it to a reset")GameTooltip:AddLine("Use this option once you decide to clear all talents of your build")GameTooltip:Show()end)end
ResetAccessFrame.MainButton:SetScript("OnClick",function(t)PlaySound("igMainMenuOptionCheckBoxOn")PlaySound("TalentScreenOpen")if(t:IsEnabled()==0)then
return false
end
if not(ResetFrame_main:IsVisible())then
ResetFrame_main:Show()StatFrame:Hide()e:Hide()CollectionController:Hide()else
ResetFrame_main:Hide()end
ResetButton_t_button_pushed(ResetFrame_main_TalentResetButton)end)ResetAccessFrame:Show()else
ResetAccessFrame:Hide()end
end
local function oe()end
local function U(o)local e=":"local l=r
local t=n
if(o)then
l=s
t=a
end
for l,t in pairs(l)do
if(t[5])then
e=e..l..":"end
end
for l,t in pairs(t)do
if(t[6]>0)then
e=e..l.."t"..t[6]..":"end
end
if(e~=":")then
LoadBuildFromLinkFrame.SearchBox:SetText(e)return e
end
end
local function p(e)local t=" |cffFFFFFF "if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].AE>0)then
t=t.._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].AE.." |TInterface\\Icons\\inv_custom_abilityessence.blp:13:13:0:0|t "end
if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].TE>0)then
t=t.._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].TE.." |TInterface\\Icons\\inv_custom_talentessence.blp:13:13:0:0|t "end
t=t.."|r"if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Known)then
t=t.."|cff00FF00Known|r"end
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetVertexColor(1,1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1:SetVertexColor(1,1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder:SetVertexColor(1,1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon:SetVertexColor(1,1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetVertexColor(1,1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetVertexColor(1,1,1,1)SetPortraitToTexture(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1,_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Icon)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SpellName)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].BuildName..t)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SpellKit\\AbilityMaxHighlight")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].ReqLevel)if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].IsTalentTalentRank)then
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SpellKit\\TalentMaxHighlight")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SpellName.." (Rank ".._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].IsTalentTalentRank..")")end
if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].ReqLevel>UnitLevel("player"))or(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Known)then
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetVertexColor(.6,.6,.6,.6)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1:SetVertexColor(.6,.6,.6,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder:SetVertexColor(.6,.6,.6,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetText("|cff6b625b".._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:GetText().."|r")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon:SetVertexColor(.6,.6,.6,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetVertexColor(.6,.6,.6,.6)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetVertexColor(.6,.6,.6,.6)if(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].ReqLevel>UnitLevel("player"))then
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetText("|cffFF0000".._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:GetText().."|r")else
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetText("|cff6b625b".._G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:GetText().."|r")end
end
BaseFrameFadeIn(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e])_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup:Play()end
local function X(e,n,l,t,o,i,a,S,s,r,u)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Spell=n
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Known=l
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].IsTalentTalentRank=t
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].BuildName=o
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Icon=i
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SpellName=a
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].ReqLevel=S
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].AE=s
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].TE=r
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].TalentID=u
p(e)end
local function ne()T=math.ceil(F/E)end
local function v()LoadBuildFromLinkFrame.SkillsFrame.BalanceText:SetText("Total to Activate: |cffFFFFFF"..A.." |TInterface\\Icons\\inv_custom_abilityessence.blp:13:13|t "..g.." |TInterface\\Icons\\inv_custom_talentessence.blp:13:13|t|r")end
local function z()LoadBuildFromLinkFrame.SkillsFrame.RequiredLevelText:SetText("Required level: |cffFFFFFF"..y.."|r")end
local function p()s={}a={}i={}F=0
T=0
h=1
A=0
g=0
y=1
LoadBuildFromLinkFrame.LoadButton:Show()LoadBuildFromLinkFrame.ActivateButton:Hide()LoadBuildFromLinkFrame.ClearnButton:Hide()LoadBuildFromLinkFrame.GenerateButton:Show()LoadBuildFromLinkFrame_CloseButton:Hide()LoadBuildFromLinkFrame_CloseButton:Disable()ProgressionLoadBuildFromLinkBG:Hide()LoadBuildFromLinkFrame.SkillsFrame:Hide()LoadBuildFromLinkFrame.SearchBox:SetText("Enter Link")C=0
v()z()end
local function N(n)PlaySound("igMainMenuContinue")if(n>T)then
return false
end
if not(n)then
n=1
end
if(T<=1)or(n==T)then
LoadBuildFromLinkFrame.SkillsFrame.NextButton:Disable()else
LoadBuildFromLinkFrame.SkillsFrame.NextButton:Enable()end
if(n==1)then
LoadBuildFromLinkFrame.SkillsFrame.PrevButton:Disable()else
LoadBuildFromLinkFrame.SkillsFrame.PrevButton:Enable()end
for e=1,E do
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:Hide()end
local l=n*E-(E-1)local t=n*E
if(F<t)then
t=F
end
local e={}for t=l,t do
table.insert(e,i[t])end
for t=1,#e do
local n,s,l,u,i,r,S,a,o,d
if(e[t][#e[t]]=="spell")then
n=e[t][1]s=e[t][5]l=nil
u=V[e[t][8]]r,_,i=GetSpellInfo(n)S=e[t][4]a=e[t][2]o=e[t][3]elseif(e[t][#e[t]]=="talent")then
l=e[t][1]n=e[t][2][l]s=false
u=V[e[t][8]]r,_,i=GetSpellInfo(n)S=e[t][5]a=(l-e[t][6])*e[t][3]o=(l-e[t][6])*e[t][4]if(a==0)and(o==0)then
a=l*e[t][3]o=l*e[t][4]s=true
end
d=e[t][9]end
if not(r)or not(i)then
StaticPopupDialogs["ASC_ERROR"].text="Spell link is broken. Please, update patch-A.MPQ\n Spell ID is: "..n
StaticPopup_Show("ASC_ERROR")return false
end
X(t,n,s,l,u,i,r,S,a,o,d)end
h=n
LoadBuildFromLinkFrame.SkillsFrame.PageText:SetText("Page "..h.."/"..T)end
local function ae()PlaySound("igMainMenuOptionCheckBoxOn")local e=UnitLevel("player")local i=GetItemCount(O)or 0
local S=GetItemCount(W)or 0
if(s=={})and(a=={})then
StaticPopupDialogs["ASC_ERROR"].text="Error! No spell related data or talent related data found!"StaticPopup_Show("ASC_ERROR")return false
end
for o,t in pairs(s)do
local t,a,a,n,l=unpack(t)local t=GetSpellInfo(t)if(n>e)then
StaticPopupDialogs["ASC_ERROR"].text="You can't learn spell |cff71d5ff["..t.."]|h|r because of its required level is higher than your level."StaticPopup_Show("ASC_ERROR")p()return false
end
if(l)then
s[o]=nil
end
end
for r,t in pairs(a)do
local t,n,i,i,l,o=unpack(t)local n=GetSpellInfo(n[t])if(l>e)then
StaticPopupDialogs["ASC_ERROR"].text="You can't rank talent |cff71d5ff["..n.."]|h|r because of its required level is higher than your level."StaticPopup_Show("ASC_ERROR")p()return false
end
if(o==t)then
a[r]=nil
end
end
if(i<A)or(S<g)then
StaticPopupDialogs["ASC_ERROR"].text="You don't have enough |cff0070dd[Ability Essence]|r or |cff0070dd[Talent Essence]|r to use that build."StaticPopup_Show("ASC_ERROR")p()return false
end
if not(next(s))and not(next(a))then
StaticPopupDialogs["ASC_ERROR"].text="You already have all spells from that build"StaticPopup_Show("ASC_ERROR")p()return false
end
p()end
local function X(e,o)local n={}local t=1
i={}F=0
for l,e in pairs(e)do
local l=e[8]local n=e[4]if not(i[l])then
i[l]={}end
if(n>t)then
t=n
end
if not(e[#e]=="spell")then
e[#e+1]="spell"end
table.insert(i[l],e)F=F+1
end
for l,e in pairs(o)do
local l=e[8]local n=e[5]if(n>t)then
t=n
end
if not(i[l])then
i[l]={}end
if not(e[#e]=="talent")then
e[#e+1]="talent"end
table.insert(i[l],e)F=F+1
end
for t,e in pairs(i)do
for t=1,#e do
table.insert(n,e[t])end
end
i=n
ne()y=t
z()if(C~=0)then
if(C>T)then
C=T
end
N(C)else
N(1)end
end
local function _(e,o)local t=0
local l=0
s,a={},{}for n,e in pairs(e)do
if not(r[e])then
StaticPopupDialogs["ASC_ERROR"].text="No spell with entry "..e.." found."StaticPopup_Show("ASC_ERROR")return false
end
local i,n,o,i,a=unpack(r[e])if not(s[e])then
if not(a)then
t=t+n
l=l+o
end
s[e]=r[e]end
end
for e,o in pairs(o)do
local e=o[1]local o=o[2]if not(n[e])then
StaticPopupDialogs["ASC_ERROR"].text="No talent with entry "..e.." found."StaticPopup_Show("ASC_ERROR")return false
end
local r,u,S,s,u,i=unpack(n[e])if not(o>r)and not(a[e])then
if not(i==r)then
for e=i+1,o do
t=t+S
l=l+s
end
end
a[e]=n[e]a[e][1]=o
end
end
X(s,a)A=t
g=l
v()LoadBuildFromLinkFrame.LoadButton:Hide()LoadBuildFromLinkFrame_CloseButton:Show()LoadBuildFromLinkFrame_CloseButton:Enable()LoadBuildFromLinkFrame.ActivateButton:Show()LoadBuildFromLinkFrame.ClearnButton:Show()LoadBuildFromLinkFrame.GenerateButton:Hide()ProgressionLoadBuildFromLinkBG:Show()LoadBuildFromLinkFrame.SkillsFrame:Show()end
function CountBuildByLink(i,s)local e=nil
if(s)then
e=i
else
e=i:GetText()end
local a={}local o={}TrainingFrame_model:Hide()TrainingFrame_model2:Hide()local t,l,r,n
t,l,r=string.find(e,":(%d+):")while t do
t,l,r=string.find(e,":(%d+):")if(t)then
table.insert(a,tonumber(r))e=string.sub(e,1,t-1)..string.sub(e,l)end
end
t,l,n=string.find(e,":(%d+t%d+):")while t do
t,l,n=string.find(e,":(%d+t%d+):")if(t)then
local a,i,r=string.find(n,"(t%d+)")local a=tonumber(string.sub(n,1,a-1))local n=tonumber(string.sub(r,2,-1))table.insert(o,{a,n})e=string.sub(e,1,t-1)..string.sub(e,l)end
end
if not(s)then
i:ClearFocus()end
if(#a>0)or(#o>0)then
_(a,o)else
StaticPopupDialogs["ASC_ERROR"].text="No proper build data found."StaticPopup_Show("ASC_ERROR")end
end
function DebugPrintSpellTalentData(e)if not(e)then
for t,e in pairs(r)do
print(unpack(e))end
else
for t,e in pairs(n)do
print(unpack(e))end
for t,e in pairs(a)do
print(unpack(e))end
end
end
function CharacterAdvancementSendBuild(e)local e=U(false)if not(e)then
return false
end
end
local function ne(e,e)local e,e,t=GameTooltip:GetSpell()local e=IsSpellLearned(t)if(e==false)and(t==5487)then
e=IsSpellLearned(9634)end
if(GameTooltip:GetSpell()and e)then
return true
end
return false
end
local function i(n)local l=nil
local t=nil
local e=UnitLevel("player")if(e<=19)then
t=32
elseif(e>=20 and e<=29)then
t=71
elseif(e>=30 and e<=49)then
t=521
elseif(e>=50 and e<=59)then
t=1107
elseif(e>=60)then
t=2221
end
l=(e+n)*t
return l
end
local function _()local l=nil
local t=nil
local e=UnitLevel("player")if(e<=19)then
t=32
elseif(e>=20 and e<=29)then
t=71
elseif(e>=30 and e<=49)then
t=521
elseif(e>=50 and e<=59)then
t=1107
elseif(e>=60)then
t=2221
end
l=(e)*t
return l
end
function display_frame_CA()if(lostSpec==true)then
SelectSpecTip=SelectSpecTip or CreateFrame("GameTooltip","SelectSpecTip",nil,"GameTooltipTemplate");SelectSpecTip:SetOwner(SwitchSpecButton,"ANCHOR_TOP",0,-70)SelectSpecTip:AddLine("Something has gone wrong. Please select your currently active spec!")e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\progress"})DisplaySpellsButton:Show()DisplayTalentsButton:Show()LoadBuildFromLinkFrame:Show()SwitchSpecButton:Show()ProgressionBlueBookBorder:Hide()ProgressionPurpleBookBorder:Hide()TrainingFrame_model:Hide()TrainingFrame_model2:Hide()for t,e in ipairs(all_spell_slots)do
e[1]:Hide()end
TrainingFrameDialog:Hide()scrollframe:Hide()scrollbar:Hide()top_left_bg:Hide()top_right_bg:Hide()bottom_left_bg:Hide()bottom_right_bg:Hide()SwitchSpecMainFrame:Show()SelectSpecTip:Show()elseif S=="BASIC"then
e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\progress",})DisplaySpellsButton:Show()DisplayTalentsButton:Show()LoadBuildFromLinkFrame:Show()SwitchSpecButton:Show()ProgressionBlueBookBorder:Hide()ProgressionPurpleBookBorder:Hide()TrainingFrame_model:Hide()TrainingFrame_model2:Hide()SwitchSpecMainFrame:Hide()ResetAccessFrameHandle()for t,e in ipairs(all_spell_slots)do
e[1]:Hide()end
TrainingFrameDialog:Hide()scrollframe:Hide()scrollbar:Hide()top_left_bg:Hide()top_right_bg:Hide()bottom_left_bg:Hide()bottom_right_bg:Hide()current_talenList={}Y={}elseif S=="SPELLS"then
for t,e in ipairs(all_spell_slots)do
e[1]:Show()end
TrainingFrameDialog:Hide()DisplaySpellsButton:Hide()LoadBuildFromLinkFrame:Hide()DisplayTalentsButton:Hide()scrollframe:Hide()scrollbar:Hide()SwitchSpecButton:Hide()elseif S=="TALENTS"then
scrollframe:Show()scrollbar:Show()TrainingFrameDialog:Hide()DisplaySpellsButton:Hide()LoadBuildFromLinkFrame:Hide()DisplayTalentsButton:Hide()SwitchSpecButton:Hide()for t,e in ipairs(all_spell_slots)do
e[1]:Hide()end
end
end
function display_stuff(o)PlaySound("TalentScreenOpen")local n={BalanceDruid,FeralDruid,RestorationDruid,BeastMasteryHunter,MarksmanshipHunter,SurvivalHunter,ArcaneMage,FireMage,FrostMage,HolyPaladin,ProtectionPaladin,RetributionPaladin,DisciplinePriest,HolyPriest,ShadowPriest,AssassinationRogue,CombatRogue,SubtletyRogue,ElementalShaman,EnhancementShaman,RestorationShaman,AfflictionWarlock,DemonologyWarlock,DestructionWarlock,ArmsWarrior,FuryWarrior,ProtectionWarrior,GeneralStuff}local l={texture_BalanceDruid,texture_FeralDruid,texture_RestorationDruid,texture_BeastMasteryHunter,texture_MarksmanshipHunter,texture_SurvivalHunter,texture_ArcaneMage,texture_FireMage,texture_FrostMage,texture_HolyPaladin,texture_ProtectionPaladin,texture_RetributionPaladin,texture_DisciplinePriest,texture_HolyPriest,texture_ShadowPriest,texture_AssassinationRogue,texture_CombatRogue,texture_SubtletyRogue,texture_ElementalShaman,texture_EnhancementShaman,texture_RestorationShaman,texture_AfflictionWarlock,texture_DemonologyWarlock,texture_DestructionWarlock,texture_ArmsWarrior,texture_FuryWarrior,texture_ProtectionWarrior,texture_GeneralStuff}local t={{1,.49,.04,},{1,.49,.04,},{1,.49,.04,},{.67,.83,.45},{.67,.83,.45},{.67,.83,.45},{.41,.8,.94},{.41,.8,.94},{.41,.8,.94},{.96,.55,.73},{.96,.55,.73},{.96,.55,.73},{1,1,1},{1,1,1},{1,1,1},{1,.96,.41},{1,.96,.41},{1,.96,.41},{0,.44,.87},{0,.44,.87},{0,.44,.87},{.58,.51,.79},{.58,.51,.79},{.58,.51,.79},{.78,.61,.43},{.78,.61,.43},{.78,.61,.43},{.4,.4,.4}}for e,n in ipairs(n)do
if o==n then
l[e]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button")l[e]:SetVertexColor(t[e][1],t[e][2],t[e][3],.8)c=n
else
l[e]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")l[e]:SetVertexColor(t[e][1],t[e][2],t[e][3],.8)end
end
DisplaySpellsButton:Enable()DisplayTalentsButton:Enable()BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars1)TrainingFrame_SelectedTitle_Stars1_glow:Show()BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars2)TrainingFrame_SelectedTitle_Stars2_glow:Show()BaseFrameFadeIn(TrainingFrame_SelectedTitle_Glow)e.DisplayControlFrame:Show()S="BASIC"display_frame_CA()DisplayControlFrameValueChange(1)ShowSpellSelectEffect()if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and((BeginnerForcedTutorial.Tip==3)or(BeginnerForcedTutorial.Tip==1)or(BeginnerForcedTutorial.Tip==4))then
BeginnerForcedTutorial_PlayTip(2)end
end
end
function SearchSpell(t)local o=t:GetText()local e=":"for n,l in pairs(R)do
if(string.find(l,string.lower(o)))then
e=e..n..":"end
end
t:ClearFocus()if(e~=":")then
LoadBuildFromLinkFrame.SearchBox:SetText(e)PlaySound("igMainMenuOptionCheckBoxOn")CountBuildByLink(LoadBuildFromLinkFrame.SearchBox)display_stuff(nil)return e
else
StaticPopupDialogs["ASC_ERROR"].text="No Abilities or Talents found."StaticPopup_Show("ASC_ERROR")end
display_stuff(nil)end
local function z(t)PlaySound("TalentScreenClose")if(t:IsEnabled()==0)then
SendSystemMessage("Please, choose specialization first!")return false
end
if t==DisplaySpellsButton then
if not(c)then
SendSystemMessage("Please, choose specialization first!")return false
end
local t={BalanceDruid,FeralDruid,RestorationDruid,BeastMasteryHunter,MarksmanshipHunter,SurvivalHunter,ArcaneMage,FireMage,FrostMage,HolyPaladin,ProtectionPaladin,RetributionPaladin,DisciplinePriest,HolyPriest,ShadowPriest,AssassinationRogue,CombatRogue,SubtletyRogue,ElementalShaman,EnhancementShaman,RestorationShaman,AfflictionWarlock,DemonologyWarlock,DestructionWarlock,ArmsWarrior,FuryWarrior,ProtectionWarrior,GeneralStuff}for e,t in ipairs(t)do
if c==t then
if(Q[e])then
return false
end
sideBar.CurrentSpellSpec={te[e][1],te[e][2]}end
end
S="SPELLS"HideSpellSelectEffect()HideTalentsSelectEffect()HideMultiSpecSelectEffect()e.DisplayControlFrame:Hide()ResetAccessFrameHandle()e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_blue",})ProgressionBlueBookBorder:Show()end
display_frame_CA()end
local function y(t)PlaySound("TalentScreenClose")if(t:IsEnabled()==0)then
SendSystemMessage("Please, choose specialization first!")return false
end
if c~=GeneralStuff then
if not(c)then
SendSystemMessage("Please, choose specialization first!")return false
end
S="TALENTS"HideSpellSelectEffect()HideTalentsSelectEffect()HideMultiSpecSelectEffect()ResetAccessFrameHandle()e.DisplayControlFrame:Hide()e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_purple",})ProgressionPurpleBookBorder:Show()local t={BalanceDruid,FeralDruid,RestorationDruid,BeastMasteryHunter,MarksmanshipHunter,SurvivalHunter,ArcaneMage,FireMage,FrostMage,HolyPaladin,ProtectionPaladin,RetributionPaladin,DisciplinePriest,HolyPriest,ShadowPriest,AssassinationRogue,CombatRogue,SubtletyRogue,ElementalShaman,EnhancementShaman,RestorationShaman,AfflictionWarlock,DemonologyWarlock,DestructionWarlock,ArmsWarrior,FuryWarrior,ProtectionWarrior,GeneralStuff}local e=nil
for t,l in ipairs(t)do
if l==c then
e=ee[t]break
end
end
sideBar.CurrentTalentSpec=e
display_frame_CA()if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and(BeginnerForcedTutorial.Tip==2)then
BeginnerForcedTutorial_PlayTip(1)end
end
end
end
local function E(a,t,r)PlaySound("igMainMenuOptionCheckBoxOn")local e=false
local n
if(t)then
if t~="LeftButton"then
return false
end
end
for t,l in ipairs(o)do
if l==a then
if(m[t])then
e=m[t]end
if not(r)and e then
local t=e[2]if(t>0)then
local t=GetSpellInfo(e[1])StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].text="Are you sure you want to learn \n|cff71d5ff|Hspell:"..e[1].."|h["..t.."]|h|r"StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].OnAccept=function()E(a,nil,true)end
StaticPopup_Show("ASC_SPELL_LEARN_CONFIRM")return
end
end
m[t]=nil
n=t
break
end
end
if e~=false then
if(d)and(l[n].UnlearnTex:GetTexture()==w)and b then
else
end
end
end
local function Fe(e,t)PlaySound("igMainMenuOptionCheckBoxOn")if(t)then
if t~="LeftButton"then
return false
end
end
if not(e.UnlearnTex:IsVisible())or((e.UnlearnTex:GetTexture()==w)and b)then
for t,l in ipairs(l)do
if l==e then
E(o[t])break
end
end
return false
end
local o=false
local t
local a=0
for n,l in ipairs(l)do
if l==e then
spellName,spellRank,spellID=GameTooltip:GetSpell()o=spellID
t=n
break
end
end
if o~=false then
TrainingFrameDialog.Yes.talent_attached=o
TrainingFrameDialog.Yes.indexAt=t
TrainingFrameDialog.Yes.Type="Talent"TrainingFrameDialog.Alert:SetTexture(e:GetBackdrop()["bgFile"])local l,r,o=GameTooltip:GetSpell()local l="|cff71d5ff|Hspell:"..o.."|h["..l.."]|h|r"local t=tonumber(u[t]:GetText())local t=i(t)local r,o,t=GetGoldForMoney(t)if(e.talent_ID and n[e.talent_ID])then
a=n[e.talent_ID][3]end
if(GetItemCount(P)>0)or(UnitLevel("player")<10)or((GetItemCount(I)>0)and(d or L)and(a>0))then
TrainingFrameDialog.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_UNLEARNTALENTDIALOG)..l)else
TrainingFrameDialog.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_UNLEARNTALENTDIALOG)..l.."\n"..r.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..o.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r")end
TrainingFrameDialog:Show()end
end
function learn_spell(n,l)PlaySound("igMainMenuOptionCheckBoxOn")local e=nil
local o=nil
local t,t=unpack(sideBar.CurrentSpellSpec)for t,l in ipairs(all_learn_spell_buttons)do
if n==l then
e=all_attached_spells[t]o=t
end
end
if e~=nil then
if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and((BeginnerForcedTutorial.Tip==3)or(BeginnerForcedTutorial.Tip==5))and(GetItemCount(O)<=1)then
BeginnerForcedTutorial_PlayTip(5)else
BeginnerForcedTutorial_PlayTip(4)end
end
if(k[e[1]])and not(l)then
local l=""for t=1,#k[e[1]]do
local n=GetSpellInfo(k[e[1]][t])if(t==1)then
l="|cff71d5ff|Hspell:"..k[e[1]][t].."|h["..n.."]|h|r"else
l=l.." or |cff71d5ff|Hspell:"..k[e[1]][t].."|h["..n.."]|h|r"end
end
local t=GetSpellInfo(e[1])StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].text="|cff71d5ff|Hspell:"..e[1].."|h["..t.."]|h|r requires following spells to be used:\n"..l
StaticPopupDialogs["ASC_SPELL_LEARN_CONFIRM"].OnAccept=function()learn_spell(n,true)end
StaticPopup_Show("ASC_SPELL_LEARN_CONFIRM")return
end
else
if(n.Spell)then
GameTooltip:SetHyperlink(GetSpellLink(n.Spell))unlearn_spell(all_spell_slot_buttons[o],true)end
end
end
function unlearn_spell(t,e)if(ne()or(e and(e==true)))then
PlaySound("igMainMenuOptionCheckBoxOn")local e=nil
local l
local r,a=unpack(sideBar.CurrentSpellSpec)for n,o in ipairs(all_spell_slot_buttons)do
if t==o then
spellName,spellRank,spellID=GameTooltip:GetSpell()e=spellID
l=n
end
end
if e~=nil then
TrainingFrameDialog.Yes.got_spell=e
TrainingFrameDialog.Yes.got_index=l
TrainingFrameDialog.Yes.class=r
TrainingFrameDialog.Yes.spec=a
TrainingFrameDialog.Yes.Type="Spell"TrainingFrameDialog.Alert:SetTexture(t:GetBackdrop()["bgFile"])local t,l,e=GameTooltip:GetSpell()local e="|cff71d5ff|Hspell:"..e.."|h["..t.."]|h|r"local t=_()local n,l,t=GetGoldForMoney(t)if(GetItemCount(P)>0)or(UnitLevel("player")<10)or((GetItemCount(I)>0)and(d or L))then
TrainingFrameDialog.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_UNLEARNSPELLDIALOG)..e)else
TrainingFrameDialog.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_UNLEARNSPELLDIALOG)..e.."\n"..n.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..l.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r")end
TrainingFrameDialog:Show()end
end
end
local function V()local e={BalanceDruid,FeralDruid,RestorationDruid,BeastMasteryHunter,MarksmanshipHunter,SurvivalHunter,ArcaneMage,FireMage,FrostMage,HolyPaladin,ProtectionPaladin,RetributionPaladin,DisciplinePriest,HolyPriest,ShadowPriest,AssassinationRogue,CombatRogue,SubtletyRogue,ElementalShaman,EnhancementShaman,RestorationShaman,AfflictionWarlock,DemonologyWarlock,DestructionWarlock,ArmsWarrior,FuryWarrior,ProtectionWarrior,GeneralStuff}local o={CLIENTEXTRABUTTONS_BALDRU,CLIENTEXTRABUTTONS_FERDRU,CLIENTEXTRABUTTONS_RESTDRU,CLIENTEXTRABUTTONS_BMHUNT,CLIENTEXTRABUTTONS_MARKHUNT,CLIENTEXTRABUTTONS_SURVHUNT,CLIENTEXTRABUTTONS_ARCMAGE,CLIENTEXTRABUTTONS_FIREMAGE,CLIENTEXTRABUTTONS_FROSTMAGE,CLIENTEXTRABUTTONS_HOLYPAL,CLIENTEXTRABUTTONS_PROTOPAL,CLIENTEXTRABUTTONS_RETROPAL,CLIENTEXTRABUTTONS_DISCPRI,CLIENTEXTRABUTTONS_HOLYPRI,CLIENTEXTRABUTTONS_SHADOWPRI,CLIENTEXTRABUTTONS_ASSROGUE,CLIENTEXTRABUTTONS_COMBATROGUE,CLIENTEXTRABUTTONS_SUBROGUE,CLIENTEXTRABUTTONS_ELSHAM,CLIENTEXTRABUTTONS_ENCHSHAM,CLIENTEXTRABUTTONS_RESTSHAM,CLIENTEXTRABUTTONS_AFFLOCK,CLIENTEXTRABUTTONS_DEMLOCK,CLIENTEXTRABUTTONS_DESTROLOCK,CLIENTEXTRABUTTONS_ARMSWAR,CLIENTEXTRABUTTONS_FURYWAR,CLIENTEXTRABUTTONS_PROTOWAR,CLIENTEXTRABUTTONS_GENERALSPELLS}for l,n in pairs(e)do
local e,t=unpack(B[l])if(e and t)and((e>0)or(t>0))then
n:SetText(GetLocalization(o[l]).." |cffFFFFFF"..e.." |cffE1AB18|TInterface\\Icons\\inv_custom_abilityessence.blp:15:15:0:0|t|r |cffFFFFFF"..t.." |cffE1AB18|TInterface\\Icons\\inv_custom_talentessence.blp:15:15:0:0|t")else
n:SetText(GetLocalization(o[l]))end
end
end
function DisplayControlFrameValueChange(t)e.DisplayControlFrame.MainButton.Value=t
if(e.DisplayControlFrame.MainButton.Value==1)then
e.DisplayControlFrame.MainButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Spells")e.DisplayControlFrame.MainButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Spells_pressed")e.DisplayControlFrame.MainButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Highlight")e.DisplayControlFrame.MainButton.String=font_TrainingFrame_SelectedTitle_Spells
font_TrainingFrame_SwitchSpec:Hide()font_TrainingFrame_SelectedTitle_Talents:Hide()font_TrainingFrame_SelectedTitle_Disabled:Hide()e.DisplayControlFrame.MainButton:Enable()e.DisplayControlFrame.NextB:Enable()e.DisplayControlFrame.PrevB:Enable()e.DisplayControlFrame.MainButton.Script=ShowSpellSelectEffect
e.DisplayControlFrame.MainButton:Show()e.DisplayControlFrame.MainButton:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
z(DisplaySpellsButton)end
end)elseif(e.DisplayControlFrame.MainButton.Value==2)then
e.DisplayControlFrame.MainButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_SwitchSpec")e.DisplayControlFrame.MainButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_SwitchSpec_Pressed")e.DisplayControlFrame.MainButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_SwitchSpec_Highlight")e.DisplayControlFrame.MainButton.String=font_TrainingFrame_SwitchSpec
font_TrainingFrame_SelectedTitle_Spells:Hide()font_TrainingFrame_SelectedTitle_Talents:Hide()font_TrainingFrame_SelectedTitle_Disabled:Hide()e.DisplayControlFrame.MainButton:Enable()e.DisplayControlFrame.NextB:Enable()e.DisplayControlFrame.PrevB:Enable()e.DisplayControlFrame.MainButton.Script=ShowMultiSpecSelectEffect
e.DisplayControlFrame.MainButton:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
BaseFrameFadeIn(SwitchSpecMainFrame)HideMultiSpecSelectEffect()BaseFrameFadeOut(font_TrainingFrame_SwitchSpec)end
end)elseif(e.DisplayControlFrame.MainButton.Value==3)then
e.DisplayControlFrame.MainButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Talents")e.DisplayControlFrame.MainButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Talents_Pressed")e.DisplayControlFrame.MainButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Highlight")e.DisplayControlFrame.MainButton.String=font_TrainingFrame_SelectedTitle_Talents
font_TrainingFrame_SwitchSpec:Hide()font_TrainingFrame_SelectedTitle_Spells:Hide()font_TrainingFrame_SelectedTitle_Disabled:Hide()e.DisplayControlFrame.MainButton:Enable()e.DisplayControlFrame.NextB:Enable()e.DisplayControlFrame.PrevB:Enable()e.DisplayControlFrame.MainButton.Script=ShowTalentsSelectEffect
e.DisplayControlFrame.MainButton:Show()e.DisplayControlFrame.MainButton:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
y(DisplayTalentsButton)end
end)elseif(e.DisplayControlFrame.MainButton.Value==0)then
e.DisplayControlFrame.MainButton.String=font_TrainingFrame_SelectedTitle_Disabled
e.DisplayControlFrame.NextB:Disable()e.DisplayControlFrame.PrevB:Disable()e.DisplayControlFrame.MainButton:Disable()e.DisplayControlFrame.MainButton.Script=nil
end
end
local function te(e,t)if not(font_TrainingFrame_SelectedTitle_Spells:IsVisible()and font_TrainingFrame_SelectedTitle_Talents:IsVisible()and font_TrainingFrame_SwitchSpec:IsVisible())then
BaseFrameFadeIn(e.String)end
end
local function i(t)if(e.DisplayControlFrame.MainButton:IsEnabled()==0)or(e.DisplayControlFrame.MainButton:IsEnabled()==0)then
return false
end
if((e.DisplayControlFrame.MainButton.Value+t)>3)then
DisplayControlFrameValueChange(1)elseif((e.DisplayControlFrame.MainButton.Value+t)<1)then
DisplayControlFrameValueChange(3)elseif((e.DisplayControlFrame.MainButton.Value+t)==2)and(SwitchSpecButton:IsEnabled()==0)then
DisplayControlFrameValueChange(3)else
DisplayControlFrameValueChange(e.DisplayControlFrame.MainButton.Value+t)end
e.DisplayControlFrame.MainButton.Script()end
local function _e(e)i(1)end
local function Se(e)i(-1)end
function CharAdvancementHandler()local a={}function a.RecieveFreeSpellsToUnlearnInRandomMode(e)le=e
end
function a.UpdateRandomModeStatus(t,e)if(t)then
d=true
else
d=false
end
if(e)then
L=true
else
L=false
end
end
function a.Update3AETalentStatus(e)b=e
end
function a.SetBackgroundImages(G,e,a,g,i,y)ue=a
Y=g
for t,l in ipairs(ee)do
if l==G and c~=nil and((S=="SPELLS")or(S=="TALENTS"))then
top_left_bg_t:SetTexture(e[t][1])top_left_bg:Show()top_right_bg_t:SetTexture(e[t][2])top_right_bg:Show()bottom_left_bg_t:SetTexture(e[t][3])bottom_left_bg:Show()bottom_right_bg_t:SetTexture(e[t][4])bottom_right_bg:Show()end
end
for e,t in ipairs(x)do
x[e]=false
end
on_talent=1
talent_index=1
for h,e in ipairs(a)do
local k=false
local r=0
local _=GetLocalization(CLIENTEXTRABUTTONS_LEARNGRAY2)local s={.3,.3,.3}local T=false
local S=e[1]local B=i
local c=talent_index
local a=e[2]local i=e[3]local p=e[4]local C=e[5]local N=e[6]local t=e[7]local A="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"local O={.46,.36,.34,1}local F=GetLocalization(CLIENTEXTRABUTTONS_COST)..i..GetLocalization(CLIENTEXTRABUTTONS_AETIP)..p..GetLocalization(CLIENTEXTRABUTTONS_TETIP)local E=GetSpellLink(a[1])local M,M,D,M,M,M,M=GetSpellInfo(a[1])if g[h]~=false then
k=true
r=g[h]end
n[t]={S,a,i,p,C,r,G,y,t}if not(R[t.."t1"])then
if(GetSpellDescription(a[1])and(GetSpellDescription(a[1])~=""))then
R[t.."t1"]=string.lower(GetSpellDescription(a[1]))end
end
if C<=UnitLevel("player")then
if k==true then
E="|cffFFFFFF|Hspell:"..a[r].."|h[Talent]|h|r"O={1,1,1,1}if r==S then
F=GetLocalization(CLIENTEXTRABUTTONS_MAXOUT)s={1,1,0}_=GetLocalization(CLIENTEXTRABUTTONS_MAX)A="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank_max"else
T={a[r+1],i,p,a,S}s={0,.5,0}_=GetLocalization(CLIENTEXTRABUTTONS_UPGRADE)A="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank"end
else
_=GetLocalization(CLIENTEXTRABUTTONS_LEARNNORMAL)T={a[1],i,p,a,S}end
else
F=F.."|r\n"..GetLocalization(CLIENTEXTRABUTTONS_REQUIRESLEVEL)..e[5]end
local e=(((C-10)/5)*4)+N
l[e]:SetBackdrop({bgFile=D})l[e]:SetBackdropColor(unpack(O))f[e]:SetBackdrop({bgFile=A,insets={left=-11,right=-11,top=-11,bottom=-11}})l[e].HyperLink=E
l[e].talent_ID=t
local function p(t,n)GameTooltip:SetOwner(t,"ANCHOR_RIGHT")if t.HyperLink~=nil then
GameTooltip:SetHyperlink(t.HyperLink)elseif(GetTalentLink(B,c,false,false,nil))then
GameTooltip:SetTalent(B,c,false,false,nil)else
GameTooltip:SetHyperlink("|cffFFFFFF|Hspell:"..a[1].."|h[Talent]|h|r")end
GameTooltip:Show()local n,o,o,o=t:GetBackdropColor()if(n)and(n>.98)then
if(GetItemCount(I)>0)and(d or L)and(i>0)then
t.UnlearnTex:SetTexture(J)BaseFrameFadeIn(t.UnlearnTex)GameTooltip:AppendText(GetLocalization(CLIENTEXTRABUTTONS_SCROLLOFFORTUNEHINT))elseif(GetItemCount(P)>0)then
t.UnlearnTex:SetTexture(Z)BaseFrameFadeIn(t.UnlearnTex)GameTooltip:AppendText(GetLocalization(CLIENTEXTRABUTTONS_SCROLLOFUNLHINT))else
t.UnlearnTex:SetTexture(j)BaseFrameFadeIn(t.UnlearnTex)GameTooltip:AppendText("\n|cffFF0000Click on the icon to unlearn this talent|r")end
else
if(GetItemCount(se)>0)and d and(i==3)and b then
t.UnlearnTex:SetTexture(w)BaseFrameFadeIn(t.UnlearnTex)GameTooltip:AppendText("\n|cffFF0000Click on the icon to use ...|r")end
end
if t.HyperLink~=nil or((t.HyperLink==nil)and not(GetTalentLink(B,c,false,false,nil)))then
GameTooltip:AppendText(GetLocalization(CLIENTEXTRABUTTONS_RANK)..u[e]:GetText().."/"..S.."")end
end
l[e]:SetScript("OnEnter",p)local function t(e)if(e.UnlearnTex:IsVisible())then
BaseFrameFadeOut(e.UnlearnTex)end
GameTooltip:Hide()end
l[e]:SetScript("OnLeave",t)H[e]:SetTexture(s[1],s[2],s[3],0)local function t(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(F)GameTooltip:Show()end
o[e]:SetScript("OnEnter",t)local function t(e,e)GameTooltip:Hide()end
o[e]:SetScript("OnLeave",t)m[e]=T
o[e]:SetText(_)u[e]:SetText(r)x[e]=true
on_talent=on_talent+1
talent_index=talent_index+1
end
for e,t in ipairs(x)do
if t==true then
f[e]:Show()l[e]:Show()o[e]:Show()u[e]:Show()else
f[e]:Hide()l[e]:Hide()o[e]:Hide()u[e]:Hide()end
end
content:Show()end
function a.TalentGoBack(e,t)m[t]=e
end
function a.UpdateTalent(t,i,e)local B=t[2]local L=t[3]local a=t[4]local d=t[5]local c=t[1]local T={0,.5,0}local F=GetLocalization(CLIENTEXTRABUTTONS_UPGRADE)local S=nil
local p=nil
local s="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"local _=1
local r={.46,.36,.34,1}if(n[i])then
n[i][6]=n[i][6]+1
end
for t,n in ipairs(a)do
if n==c then
_=t
if t==d then
T={1,1,0}S=GetLocalization(CLIENTEXTRABUTTONS_MAXOUT)F=GetLocalization(CLIENTEXTRABUTTONS_MAX)l[e].HyperLink="|cffFFFFFF|Hspell:"..a[t].."|h[Talent]|h|r"s="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank_max"r={1,1,1,1}else
l[e].HyperLink="|cffFFFFFF|Hspell:"..a[t].."|h[Talent]|h|r"p={a[t+1],B,L,a,d}s="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank"r={1,1,1,1}end
break
end
end
if S~=nil then
local function t(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(S)GameTooltip:Show()end
o[e]:SetScript("OnEnter",t)end
m[e]=p
o[e]:SetText(F)u[e]:SetText(_)f[e]:SetBackdrop({bgFile=s,insets={left=-11,right=-11,top=-11,bottom=-11}})l[e]:SetBackdropColor(unpack(r))end
function a.UnLearnTalent(t,i,e)local a=t[2]local a=t[3]local _=t[4]local d=t[1]local a={0,.5,0}local F=GetLocalization(CLIENTEXTRABUTTONS_LEARNWHITE)local r=nil
local s="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"local a=0
local S={.46,.36,.34,1}l[e].HyperLink="|cffFFFFFF|Hspell:".._[1].."|h[Talent]|h|r"local _,_,_=GetSpellInfo(d)if r~=nil then
local function t(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(r)GameTooltip:Show()end
o[e]:SetScript("OnEnter",t)end
m[e]=t
o[e]:SetText(F)if(n[i])then
n[i][6]=a
end
u[e]:SetText(a)f[e]:SetBackdrop({bgFile=s,insets={left=-11,right=-11,top=-11,bottom=-11}})l[e]:SetBackdropColor(unpack(S))GameTooltip:Hide()if(l[e].UnlearnTex:IsVisible())then
BaseFrameFadeOut(l[e].UnlearnTex)end
end
function a.GetSpellCount(S,l,_,u,n)local e=1
if(S<e)then
Q[n]=true
return false
end
repeat
local t=l[e][1]local i=l[e][2]local s=l[e][3]local a=l[e][4]local l,l,F,l,l,l,l=GetSpellInfo(t)local o=IsSpellLearned(t)if(o==false)and(t==5487)then
o=IsSpellLearned(9634)end
r[t]={t,i,s,a,o,_,u,n}if not(R[t])then
if(GetSpellDescription(t)and(GetSpellDescription(t)~=""))then
R[t]=string.lower(GetSpellDescription(t))end
end
local n=GetLocalization(CLIENTEXTRABUTTONS_COST)..i..GetLocalization(CLIENTEXTRABUTTONS_AETIP)..s..GetLocalization(CLIENTEXTRABUTTONS_TETIP)local u={.9,.2,.1}local r=GetLocalization(CLIENTEXTRABUTTONS_LEARNNORMAL)local l={t,i,s}_G[all_spell_slot_buttons[e]:GetName().."_KnownTexture"]:Hide()if o==true then
n=GetLocalization(CLIENTEXTRABUTTONS_KNOWN)r=GetLocalization(CLIENTEXTRABUTTONS_LEARNGRAY)u={.3,.3,.3}all_learn_spell_buttons[e].Spell=l[1]BaseFrameFadeIn(_G[all_spell_slot_buttons[e]:GetName().."_KnownTexture"])l=nil
elseif a>UnitLevel("player")then
n=n.."|r\n"..GetLocalization(CLIENTEXTRABUTTONS_REQUIRESLEVEL)..a
r=GetLocalization(CLIENTEXTRABUTTONS_LEARNGRAY2)u={.3,.3,.3}l=nil
end
all_spell_slot_buttons[e]:SetBackdrop({bgFile=F})all_learn_spell_buttons[e]:Enable()local o=GetSpellLink(t)local function a(e,l)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(o)GameTooltip:Show()if(ne())then
if d and le[t]then
GameTooltip:AppendText("\n|cffFF0000Click on the icon to unlearn this spell.\n|cff00FF00This spell is free to unlearn.|r")_G[e:GetName().."_UnlearnTex"]:SetTexture(de)BaseFrameFadeIn(_G[e:GetName().."_UnlearnTex"])all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",e,"CENTER",0,0)BaseFrameFadeIn(all_spell_slot_buttons_UnLearnEffect)elseif(GetItemCount(I)>0)and(d or L)then
GameTooltip:AppendText(GetLocalization(CLIENTEXTRABUTTONS_SCROLLOFUNLHINT))_G[e:GetName().."_UnlearnTex"]:SetTexture(J)BaseFrameFadeIn(_G[e:GetName().."_UnlearnTex"])all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",e,"CENTER",0,0)BaseFrameFadeIn(all_spell_slot_buttons_UnLearnEffect)elseif(GetItemCount(P)>0)then
GameTooltip:AppendText(GetLocalization(CLIENTEXTRABUTTONS_SCROLLOFUNLHINT))_G[e:GetName().."_UnlearnTex"]:SetTexture(Z)BaseFrameFadeIn(_G[e:GetName().."_UnlearnTex"])all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",e,"CENTER",0,0)BaseFrameFadeIn(all_spell_slot_buttons_UnLearnEffect)else
GameTooltip:AppendText("\n|cffFF0000Click on the icon to unlearn this spell|r")_G[e:GetName().."_UnlearnTex"]:SetTexture(j)BaseFrameFadeIn(_G[e:GetName().."_UnlearnTex"])all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",e,"CENTER",0,0)BaseFrameFadeIn(all_spell_slot_buttons_UnLearnEffect)end
end
end
all_spell_slot_buttons[e]:SetScript("OnEnter",a)local function t(e)GameTooltip:Hide()if(_G[e:GetName().."_UnlearnTex"]:IsVisible())then
BaseFrameFadeOut(_G[e:GetName().."_UnlearnTex"])BaseFrameFadeOut(all_spell_slot_buttons_UnLearnEffect)end
end
all_spell_slot_buttons[e]:SetScript("OnLeave",t)local function t(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(n)GameTooltip:Show()end
all_learn_spell_buttons[e]:SetScript("OnEnter",t)local function t(e,e)GameTooltip:Hide()end
all_learn_spell_buttons[e]:SetScript("OnLeave",t)all_attached_spells[e]=l
all_learn_spell_buttons[e]:SetText(r)e=e+1
until e==S+1
repeat
all_spell_slot_buttons[e]:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackgroundold"})all_spell_slot_buttons[e]:SetScript("OnEnter",nil)all_spell_slot_buttons[e]:SetScript("OnLeave",nil)all_learn_spell_buttons[e]:SetScript("OnEnter",nil)all_learn_spell_buttons[e]:SetScript("OnLeave",nil)all_learn_spell_buttons[e]:SetText("")all_learn_spell_buttons[e]:Disable()_G[all_spell_slot_buttons[e]:GetName().."_KnownTexture"]:Hide()all_attached_spells[e]=nil
e=e+1
until e==36+1
if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and(BeginnerForcedTutorial.Tip==2)then
BeginnerForcedTutorial_PlayTip(3)SolveLearnButtonHighlight(true)end
end
end
function a.ChangeLearnButton(e,t)local function l(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(GetLocalization(CLIENTEXTRABUTTONS_KNOWN))GameTooltip:Show()end
if(r[t])then
r[t][5]=true
end
if not(all_spell_slot_buttons[e])or not(all_attached_spells[e])then
return false
end
BaseFrameFadeIn(_G[all_spell_slot_buttons[e]:GetName().."_KnownTexture"])all_learn_spell_buttons[e]:SetText(GetLocalization(CLIENTEXTRABUTTONS_LEARNGRAY))all_learn_spell_buttons[e]:SetScript("OnEnter",l)all_learn_spell_buttons[e].Spell=all_attached_spells[e][1]all_attached_spells[e]=nil
if BeginnerForcedTutorial:IsVisible()and((BeginnerForcedTutorial.Tip==3)or(BeginnerForcedTutorial.Tip==4))then
SolveLearnButtonHighlight(true)end
end
function a.ChangeLearnButtonBack(e,t,l,n)local o=l
local a=n
local t=t
local function i(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(GetLocalization(CLIENTEXTRABUTTONS_COST)..o..GetLocalization(CLIENTEXTRABUTTONS_AETIP)..a..GetLocalization(CLIENTEXTRABUTTONS_TETIP))GameTooltip:Show()end
if(r[t])then
r[t][5]=false
end
_G[all_spell_slot_buttons[e]:GetName().."_KnownTexture"]:Hide()BaseFrameFadeOut(_G[all_spell_slot_buttons[e]:GetName().."_UnlearnTex"])BaseFrameFadeOut(all_spell_slot_buttons_UnLearnEffect)all_learn_spell_buttons[e]:SetText(GetLocalization(CLIENTEXTRABUTTONS_LEARNWHITE))all_learn_spell_buttons[e]:SetScript("OnEnter",i)all_attached_spells[e]={t,l,n}end
function a.UpdateProgressionButtonsVisual(l,t,e)if(t)then
for e,t in pairs(r)do
r[e][5]=false
end
for t,e in pairs(B)do
e[1]=0
end
elseif(e)then
for e,t in pairs(n)do
n[e][6]=0
end
for t,e in pairs(B)do
e[2]=0
end
elseif not(e)and not(t)then
B=l
end
V()end
function a.UpdateProgressionButtonSpeciefic(e,l,t)B[e]={B[e][1]+l,B[e][2]+t}V()end
return a
end
e:SetSize(950,860)e:SetPoint("CENTER",0,45)e:SetFrameStrata("DIALOG")e:EnableMouseWheel(true)e:SetScript("OnMouseWheel",function(t,e)if(scrollbar:IsVisible())then
local t=scrollbar:GetValue()scrollbar:SetValue(t-e*50)end
end)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\progress",})e:Hide()TrainingFrame_model=CreateFrame("Model","TrainingFrame_model",e)TrainingFrame_model:SetWidth(560);TrainingFrame_model:SetHeight(655);TrainingFrame_model:SetPoint("CENTER",e,"CENTER",-105,-30)TrainingFrame_model:SetModel("World\\Expansion01\\doodads\\theexodar\\passivedoodads\\paladin_energy_fx\\exodar_paladin_shrine_energyfx.m2")TrainingFrame_model:SetModelScale(.04)TrainingFrame_model:SetCamera(0)TrainingFrame_model:SetPosition(.075,.09,0)TrainingFrame_model:SetAlpha(.002)TrainingFrame_model:SetFacing(.1)TrainingFrame_model:SetFrameStrata("TOOLTIP")TrainingFrame_model:Hide()TrainingFrame_model2=CreateFrame("Model","TrainingFrame_model2",e)TrainingFrame_model2:SetWidth(560);TrainingFrame_model2:SetHeight(655);TrainingFrame_model2:SetPoint("CENTER",e,"CENTER",-105,-30)TrainingFrame_model2:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")TrainingFrame_model2:SetModelScale(.2)TrainingFrame_model2:SetCamera(0)TrainingFrame_model2:SetPosition(.18,.2,0)TrainingFrame_model2:SetAlpha(.8)TrainingFrame_model2:SetFacing(.1)TrainingFrame_model2:SetFrameStrata("TOOLTIP")TrainingFrame_model2:Hide()TrainingFrame_SelectedTitle=CreateFrame("Frame","TrainingFrame_SelectedTitle",e,nil)TrainingFrame_SelectedTitle:SetSize(e:GetSize())TrainingFrame_SelectedTitle:SetPoint("CENTER",0,0)local t=CreateFrame("Model","TrainingFrame_SelectedTitle_Stars1",TrainingFrame_SelectedTitle)t:SetWidth(560);t:SetHeight(655);t:SetPoint("CENTER",e,"CENTER",-105,-30)t:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")t:SetModelScale(.3)t:SetCamera(0)t:SetPosition(0,0,2)t:SetAlpha(.4)t:SetFacing(.1)t:Hide()local i=CreateFrame("Model","TrainingFrame_SelectedTitle_Stars1_glow",TrainingFrame_SelectedTitle)i:SetWidth(256);i:SetHeight(256);i:SetPoint("CENTER",t,"CENTER",-160,0)i:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")i:SetModelScale(.02)i:SetCamera(0)i:SetPosition(.075,.09,0)i:SetAlpha(.7)i:SetFacing(0)i:Hide()local n=CreateFrame("Model","TrainingFrame_SelectedTitle_Stars2",TrainingFrame_SelectedTitle)n:SetWidth(560);n:SetHeight(655);n:SetPoint("CENTER",e,"CENTER",230,-30)n:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")n:SetModelScale(.3)n:SetCamera(0)n:SetPosition(0,0,2)n:SetAlpha(.4)n:SetFacing(.1)n:Hide()local r=CreateFrame("Model","TrainingFrame_SelectedTitle_Stars2_glow",TrainingFrame_SelectedTitle)r:SetWidth(256);r:SetHeight(256);r:SetPoint("CENTER",n,"CENTER",-160,0)r:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")r:SetModelScale(.02)r:SetCamera(0)r:SetPosition(.075,.09,0)r:SetAlpha(.7)r:SetFacing(0)r:Hide()TrainingFrame_SelectedTitle:SetScript("OnShow",function()if(GetCVar("useUiScale")=="1")then
D=1
G=GetCVar("uiScale")else
SetCVar("uiScale","1")D=ie/768
G=1
end
t:SetModel("Particles\\Lootfx2.m2")t:SetModelScale(.1)t:SetPosition(.2,0,1.85/G*D)t:SetAlpha(.8)n:SetModel("Particles\\Lootfx2.m2")n:SetModelScale(.1)n:SetPosition(.2,0,1.85/G*D)n:SetAlpha(.8)end)local _=TrainingFrame_SelectedTitle:CreateTexture("TrainingFrame_SelectedTitle_Glow")_:SetAllPoints()_:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_glow")_:SetSize(TrainingFrame_SelectedTitle:GetSize())_:Hide()local F=CreateFrame("Button","TrainingFrame_CloseButton",e,"UIPanelCloseButton")F:SetPoint("TOPRIGHT",-63,-112)F:EnableMouse(true)F:SetSize(31,31)F:SetFrameStrata("FULLSCREEN_DIALOG")F:SetScript("OnMouseUp",function()if(lostSpec~=true)then
PlaySound("Glyph_MinorCreate")e:Hide()end
end)local c=e:CreateFontString("TrainingFrame_TitleText")c:SetFont("Fonts\\MORPHEUS.TTF",14)c:SetFontObject(GameFontNormal)c:SetPoint("TOPRIGHT",-130,-103)c:SetText(GetLocalization(CLIENTEXTRABUTTONS_PROGRESSIONMAIN))e.DisplayControlFrame=CreateFrame("FRAME","TrainingFrameDislayControlFrame",e)e.DisplayControlFrame:SetSize(300,128)e.DisplayControlFrame:SetPoint("CENTER",-115,-180)e.DisplayControlFrame.MainButton=CreateFrame("Button","TrainingFrameDisplayControlFrameMainButton",e.DisplayControlFrame,nil)e.DisplayControlFrame.MainButton:SetSize(256,128)e.DisplayControlFrame.MainButton:SetPoint("CENTER")e.DisplayControlFrame.MainButton:EnableMouse(true)e.DisplayControlFrame.MainButton:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButtonDisabled")e.DisplayControlFrame.MainButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Spells")e.DisplayControlFrame.MainButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Spells_pressed")e.DisplayControlFrame.MainButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementButton_Highlight")e.DisplayControlFrame.MainButton:Disable()e.DisplayControlFrame.MainButton:SetScript("OnUpdate",te)e.DisplayControlFrame.MainButton:SetFrameLevel(3)e.DisplayControlFrame.NextB=CreateFrame("Button","TrainingFrameDisplayControlFrameNextB",e.DisplayControlFrame,nil)e.DisplayControlFrame.NextB:SetSize(32,32)e.DisplayControlFrame.NextB:SetPoint("RIGHT",-30,0)e.DisplayControlFrame.NextB:EnableMouse(true)e.DisplayControlFrame.NextB:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowRight_disabled")e.DisplayControlFrame.NextB:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowRight")e.DisplayControlFrame.NextB:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowRight_pressed")e.DisplayControlFrame.NextB:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowRight_disabled")e.DisplayControlFrame.NextB:Disable()e.DisplayControlFrame.NextB:SetFrameLevel(4)e.DisplayControlFrame.NextB:SetScript("OnClick",_e)e.DisplayControlFrame.PrevB=CreateFrame("Button","TrainingFrameDisplayControlFramePrevB",e.DisplayControlFrame,nil)e.DisplayControlFrame.PrevB:SetSize(32,32)e.DisplayControlFrame.PrevB:SetPoint("LEFT",30,0)e.DisplayControlFrame.PrevB:EnableMouse(true)e.DisplayControlFrame.PrevB:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowLeft_disabled")e.DisplayControlFrame.PrevB:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowLeft")e.DisplayControlFrame.PrevB:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowLeft_pressed")e.DisplayControlFrame.PrevB:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\AdvancementArrowLeft_disabled")e.DisplayControlFrame.PrevB:Disable()e.DisplayControlFrame.PrevB:SetFrameLevel(4)e.DisplayControlFrame.PrevB:SetScript("OnClick",Se)font_TrainingFrame_SelectedTitle_Spells=e.DisplayControlFrame.MainButton:CreateFontString("TrainingFrame_SelectedTitle_Spells")font_TrainingFrame_SelectedTitle_Spells:SetFontObject(GameFontNormal)font_TrainingFrame_SelectedTitle_Spells:SetShadowOffset(1,-1)font_TrainingFrame_SelectedTitle_Spells:SetText(GetLocalization(CLIENTEXTRABUTTONS_DISPLAYSPELLS))font_TrainingFrame_SelectedTitle_Spells:SetPoint("CENTER")font_TrainingFrame_SelectedTitle_Spells:Hide()font_TrainingFrame_SelectedTitle_Talents=e.DisplayControlFrame.MainButton:CreateFontString("TrainingFrame_SelectedTitle_Talents")font_TrainingFrame_SelectedTitle_Talents:SetFontObject(GameFontNormal)font_TrainingFrame_SelectedTitle_Talents:SetShadowOffset(1,-1)font_TrainingFrame_SelectedTitle_Talents:SetText(GetLocalization(CLIENTEXTRABUTTONS_DISPLAYTALENTS))font_TrainingFrame_SelectedTitle_Talents:SetPoint("CENTER")font_TrainingFrame_SelectedTitle_Talents:Hide()font_TrainingFrame_SwitchSpec=e.DisplayControlFrame.MainButton:CreateFontString("TrainingFrame_SwitchSpec")font_TrainingFrame_SwitchSpec:SetFontObject(GameFontNormal)font_TrainingFrame_SwitchSpec:SetShadowOffset(1,-1)font_TrainingFrame_SwitchSpec:SetText("Change specialization")font_TrainingFrame_SwitchSpec:SetPoint("CENTER")font_TrainingFrame_SwitchSpec:Hide()font_TrainingFrame_SelectedTitle_Disabled=e.DisplayControlFrame.MainButton:CreateFontString("TrainingFrame_SelectedTitle_Disabled")font_TrainingFrame_SelectedTitle_Disabled:SetFontObject(GameFontDisable)font_TrainingFrame_SelectedTitle_Disabled:SetShadowOffset(1,-1)font_TrainingFrame_SelectedTitle_Disabled:SetText("Choose specialization")font_TrainingFrame_SelectedTitle_Disabled:SetPoint("CENTER")font_TrainingFrame_SelectedTitle_Disabled:Hide()e.DisplayControlFrame.MainButton.String=font_TrainingFrame_SelectedTitle_Disabled
DisplayControlFrameValueChange(0)BalanceDruid=CreateFrame("Button","TrainingFrame_BalanceDruid",e,nil)BalanceDruid:SetSize(234,25.5)BalanceDruid:SetPoint("TOPRIGHT",-68.5,-136)BalanceDruid:EnableMouse(true)texture_BalanceDruid=BalanceDruid:CreateTexture("BalanceDruid")texture_BalanceDruid:SetAllPoints(BalanceDruid)texture_BalanceDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_BalanceDruid:SetVertexColor(1,.49,.04,.8)BalanceDruid:SetNormalTexture(texture_BalanceDruid)BalanceDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_BalanceDruid=BalanceDruid:CreateFontString("BalanceDruid_Font","OVERLAY")font_BalanceDruid:SetFont("Fonts\\FRIZQT__.TTF",11)font_BalanceDruid:SetShadowOffset(1,-1)BalanceDruid:SetFontString(font_BalanceDruid)BalanceDruid:SetText(GetLocalization(CLIENTEXTRABUTTONS_BALDRU))BalanceDruid:SetScript("OnMouseUp",display_stuff)FeralDruid=CreateFrame("Button","TrainingFrame_FeralDruid",e,nil)FeralDruid:SetSize(234,25.5)FeralDruid:SetPoint("TOPRIGHT",-68.5,-159.5)FeralDruid:EnableMouse(true)texture_FeralDruid=BalanceDruid:CreateTexture("FeralDruid")texture_FeralDruid:SetAllPoints(FeralDruid)texture_FeralDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_FeralDruid:SetVertexColor(1,.49,.04,.8)FeralDruid:SetNormalTexture(texture_FeralDruid)FeralDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_FeralDruid=FeralDruid:CreateFontString("FeralDruid_Font","OVERLAY")font_FeralDruid:SetFont("Fonts\\FRIZQT__.TTF",11)font_FeralDruid:SetShadowOffset(1,-1)FeralDruid:SetFontString(font_FeralDruid)FeralDruid:SetText(GetLocalization(CLIENTEXTRABUTTONS_FERDRU))FeralDruid:SetScript("OnMouseUp",display_stuff)RestorationDruid=CreateFrame("Button","TrainingFrame_RestorationDruid",e,nil)RestorationDruid:SetSize(234,25.5)RestorationDruid:SetPoint("TOPRIGHT",-68.5,-183)RestorationDruid:EnableMouse(true)texture_RestorationDruid=RestorationDruid:CreateTexture("RestorationDruid")texture_RestorationDruid:SetAllPoints(RestorationDruid)texture_RestorationDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_RestorationDruid:SetVertexColor(1,.49,.04,.8)RestorationDruid:SetNormalTexture(texture_RestorationDruid)RestorationDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_RestorationDruid=RestorationDruid:CreateFontString("RestorationDruid_Font","OVERLAY")font_RestorationDruid:SetFont("Fonts\\FRIZQT__.TTF",11)font_RestorationDruid:SetShadowOffset(1,-1)RestorationDruid:SetFontString(font_RestorationDruid)RestorationDruid:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESTDRU))RestorationDruid:SetScript("OnMouseUp",display_stuff)BeastMasteryHunter=CreateFrame("Button","TrainingFrame_BeastMasteryHunter",e,nil)BeastMasteryHunter:SetSize(234,25.5)BeastMasteryHunter:SetPoint("TOPRIGHT",-68.5,-206,5)BeastMasteryHunter:EnableMouse(true)texture_BeastMasteryHunter=BeastMasteryHunter:CreateTexture("BeastMasteryHunter")texture_BeastMasteryHunter:SetAllPoints(BeastMasteryHunter)texture_BeastMasteryHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_BeastMasteryHunter:SetVertexColor(.67,.83,.45,.8)BeastMasteryHunter:SetNormalTexture(texture_BeastMasteryHunter)BeastMasteryHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_BeastMasteryHunter=BeastMasteryHunter:CreateFontString("BeastMasteryHunter_Font","OVERLAY")font_BeastMasteryHunter:SetFont("Fonts\\FRIZQT__.TTF",11)font_BeastMasteryHunter:SetShadowOffset(1,-1)BeastMasteryHunter:SetFontString(font_BeastMasteryHunter)BeastMasteryHunter:SetText(GetLocalization(CLIENTEXTRABUTTONS_BMHUNT))BeastMasteryHunter:SetScript("OnMouseUp",display_stuff)MarksmanshipHunter=CreateFrame("Button","TrainingFrame_MarksmanshipHunter",e,nil)MarksmanshipHunter:SetSize(234,25.5)MarksmanshipHunter:SetPoint("TOPRIGHT",-68.5,-230)MarksmanshipHunter:EnableMouse(true)texture_MarksmanshipHunter=MarksmanshipHunter:CreateTexture("MarksmanshipHunter")texture_MarksmanshipHunter:SetAllPoints(MarksmanshipHunter)texture_MarksmanshipHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_MarksmanshipHunter:SetVertexColor(.67,.83,.45,.8)MarksmanshipHunter:SetNormalTexture(texture_MarksmanshipHunter)MarksmanshipHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_MarksmanshipHunter=MarksmanshipHunter:CreateFontString("MarksmanshipHunter_Font","OVERLAY")font_MarksmanshipHunter:SetFont("Fonts\\FRIZQT__.TTF",11)font_MarksmanshipHunter:SetShadowOffset(1,-1)MarksmanshipHunter:SetFontString(font_MarksmanshipHunter)MarksmanshipHunter:SetText(GetLocalization(CLIENTEXTRABUTTONS_MARKHUNT))MarksmanshipHunter:SetScript("OnMouseUp",display_stuff)SurvivalHunter=CreateFrame("Button","TrainingFrame_SurvivalHunter",e,nil)SurvivalHunter:SetSize(234,25.5)SurvivalHunter:SetPoint("TOPRIGHT",-68.5,-253,5)SurvivalHunter:EnableMouse(true)texture_SurvivalHunter=MarksmanshipHunter:CreateTexture("SurvivalHunter")texture_SurvivalHunter:SetAllPoints(SurvivalHunter)texture_SurvivalHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_SurvivalHunter:SetVertexColor(.67,.83,.45,.8)SurvivalHunter:SetNormalTexture(texture_SurvivalHunter)SurvivalHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_SurvivalHunter=SurvivalHunter:CreateFontString("SurvivalHunter_Font","OVERLAY")font_SurvivalHunter:SetFont("Fonts\\FRIZQT__.TTF",11)font_SurvivalHunter:SetShadowOffset(1,-1)SurvivalHunter:SetFontString(font_SurvivalHunter)SurvivalHunter:SetText(GetLocalization(CLIENTEXTRABUTTONS_SURVHUNT))SurvivalHunter:SetScript("OnMouseUp",display_stuff)ArcaneMage=CreateFrame("Button","TrainingFrame_ArcaneMage",e,nil)ArcaneMage:SetSize(234,25.5)ArcaneMage:SetPoint("TOPRIGHT",-68.5,-277)ArcaneMage:EnableMouse(true)texture_ArcaneMage=ArcaneMage:CreateTexture("FireMage")texture_ArcaneMage:SetAllPoints(ArcaneMage)texture_ArcaneMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ArcaneMage:SetVertexColor(.41,.8,.94,.8)ArcaneMage:SetNormalTexture(texture_ArcaneMage)ArcaneMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ArcaneMage=ArcaneMage:CreateFontString("ArcaneMage_Font","OVERLAY")font_ArcaneMage:SetFont("Fonts\\FRIZQT__.TTF",11)font_ArcaneMage:SetShadowOffset(1,-1)ArcaneMage:SetFontString(font_ArcaneMage)ArcaneMage:SetText(GetLocalization(CLIENTEXTRABUTTONS_ARCMAGE))ArcaneMage:SetScript("OnMouseUp",display_stuff)FireMage=CreateFrame("Button","TrainingFrame_FireMage",e,nil)FireMage:SetSize(234,25.5)FireMage:SetPoint("TOPRIGHT",-68.5,-300.5)FireMage:EnableMouse(true)texture_FireMage=FireMage:CreateTexture("FireMage")texture_FireMage:SetAllPoints(FireMage)texture_FireMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_FireMage:SetVertexColor(.41,.8,.94,.8)FireMage:SetNormalTexture(texture_FireMage)FireMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_FireMage=FireMage:CreateFontString("FireMage_Font","OVERLAY")font_FireMage:SetFont("Fonts\\FRIZQT__.TTF",11)font_FireMage:SetShadowOffset(1,-1)FireMage:SetFontString(font_FireMage)FireMage:SetText(GetLocalization(CLIENTEXTRABUTTONS_FIREMAGE))FireMage:SetScript("OnMouseUp",display_stuff)FrostMage=CreateFrame("Button","TrainingFrame_FrostMage",e,nil)FrostMage:SetSize(234,25.5)FrostMage:SetPoint("TOPRIGHT",-68.5,-324)FrostMage:EnableMouse(true)texture_FrostMage=FrostMage:CreateTexture("FrostMage")texture_FrostMage:SetAllPoints(FrostMage)texture_FrostMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_FrostMage:SetVertexColor(.41,.8,.94,.8)FrostMage:SetNormalTexture(texture_FrostMage)FrostMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_FrostMage=FrostMage:CreateFontString("FrostMage_Font","OVERLAY")font_FrostMage:SetFont("Fonts\\FRIZQT__.TTF",11)font_FrostMage:SetShadowOffset(1,-1)FrostMage:SetFontString(font_FrostMage)FrostMage:SetText(GetLocalization(CLIENTEXTRABUTTONS_FROSTMAGE))FrostMage:SetScript("OnMouseUp",display_stuff)HolyPaladin=CreateFrame("Button","TrainingFrame_HolyPaladin",e,nil)HolyPaladin:SetSize(234,25.5)HolyPaladin:SetPoint("TOPRIGHT",-68.5,-347,5)HolyPaladin:EnableMouse(true)texture_HolyPaladin=HolyPaladin:CreateTexture("HolyPaladin")texture_HolyPaladin:SetAllPoints(HolyPaladin)texture_HolyPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_HolyPaladin:SetVertexColor(.96,.55,.73,.8)HolyPaladin:SetNormalTexture(texture_HolyPaladin)HolyPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_HolyPaladin=HolyPaladin:CreateFontString("HolyPaladin_Font","OVERLAY")font_HolyPaladin:SetFont("Fonts\\FRIZQT__.TTF",11)font_HolyPaladin:SetShadowOffset(1,-1)HolyPaladin:SetFontString(font_HolyPaladin)HolyPaladin:SetText(GetLocalization(CLIENTEXTRABUTTONS_HOLYPAL))HolyPaladin:SetScript("OnMouseUp",display_stuff)ProtectionPaladin=CreateFrame("Button","TrainingFrame_ProtectionPaladin",e,nil)ProtectionPaladin:SetSize(234,25.5)ProtectionPaladin:SetPoint("TOPRIGHT",-68.5,-371)ProtectionPaladin:EnableMouse(true)texture_ProtectionPaladin=ProtectionPaladin:CreateTexture("ProtectionPaladin")texture_ProtectionPaladin:SetAllPoints(ProtectionPaladin)texture_ProtectionPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ProtectionPaladin:SetVertexColor(.96,.55,.73,.8)ProtectionPaladin:SetNormalTexture(texture_ProtectionPaladin)ProtectionPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ProtectionPaladin=ProtectionPaladin:CreateFontString("ProtectionPaladin_Font","OVERLAY")font_ProtectionPaladin:SetFont("Fonts\\FRIZQT__.TTF",11)font_ProtectionPaladin:SetShadowOffset(1,-1)ProtectionPaladin:SetFontString(font_ProtectionPaladin)ProtectionPaladin:SetText(GetLocalization(CLIENTEXTRABUTTONS_PROTOPAL))ProtectionPaladin:SetScript("OnMouseUp",display_stuff)RetributionPaladin=CreateFrame("Button","TrainingFrame_RetributionPaladin",e,nil)RetributionPaladin:SetSize(234,25.5)RetributionPaladin:SetPoint("TOPRIGHT",-68.5,-394,5)RetributionPaladin:EnableMouse(true)texture_RetributionPaladin=RetributionPaladin:CreateTexture("RetributionPaladin")texture_RetributionPaladin:SetAllPoints(RetributionPaladin)texture_RetributionPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_RetributionPaladin:SetVertexColor(.96,.55,.73,.8)RetributionPaladin:SetNormalTexture(texture_RetributionPaladin)RetributionPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_RetributionPaladin=RetributionPaladin:CreateFontString("RetributionPaladin_Font","OVERLAY")font_RetributionPaladin:SetFont("Fonts\\FRIZQT__.TTF",11)font_RetributionPaladin:SetShadowOffset(1,-1)RetributionPaladin:SetFontString(font_RetributionPaladin)RetributionPaladin:SetText(GetLocalization(CLIENTEXTRABUTTONS_RETROPAL))RetributionPaladin:SetScript("OnMouseUp",display_stuff)DisciplinePriest=CreateFrame("Button","TrainingFrame_DisciplinePriest",e,nil)DisciplinePriest:SetSize(234,25.5)DisciplinePriest:SetPoint("TOPRIGHT",-68.5,-418)DisciplinePriest:EnableMouse(true)texture_DisciplinePriest=DisciplinePriest:CreateTexture("DisciplinePriest")texture_DisciplinePriest:SetAllPoints(DisciplinePriest)texture_DisciplinePriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_DisciplinePriest:SetVertexColor(1,1,1,.8)DisciplinePriest:SetNormalTexture(texture_DisciplinePriest)DisciplinePriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_DisciplinePriest=DisciplinePriest:CreateFontString("DisciplinePriest_Font","OVERLAY")font_DisciplinePriest:SetFont("Fonts\\FRIZQT__.TTF",11)font_DisciplinePriest:SetShadowOffset(1,-1)DisciplinePriest:SetFontString(font_DisciplinePriest)DisciplinePriest:SetText(GetLocalization(CLIENTEXTRABUTTONS_DISCPRI))DisciplinePriest:SetScript("OnMouseUp",display_stuff)HolyPriest=CreateFrame("Button","TrainingFrame_HolyPriest",e,nil)HolyPriest:SetSize(234,25.5)HolyPriest:SetPoint("TOPRIGHT",-68.5,-441,5)HolyPriest:EnableMouse(true)texture_HolyPriest=HolyPriest:CreateTexture("HolyPriest")texture_HolyPriest:SetAllPoints(HolyPriest)texture_HolyPriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_HolyPriest:SetVertexColor(1,1,1,.8)HolyPriest:SetNormalTexture(texture_HolyPriest)HolyPriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_HolyPriest=HolyPriest:CreateFontString("HolyPriest_Font","OVERLAY")font_HolyPriest:SetFont("Fonts\\FRIZQT__.TTF",11)font_HolyPriest:SetShadowOffset(1,-1)HolyPriest:SetFontString(font_HolyPriest)HolyPriest:SetText(GetLocalization(CLIENTEXTRABUTTONS_HOLYPRI))HolyPriest:SetScript("OnMouseUp",display_stuff)ShadowPriest=CreateFrame("Button","TrainingFrame_ShadowPriest",e,nil)ShadowPriest:SetSize(234,25.5)ShadowPriest:SetPoint("TOPRIGHT",-68.5,-465)ShadowPriest:EnableMouse(true)texture_ShadowPriest=ShadowPriest:CreateTexture("ShadowPriest")texture_ShadowPriest:SetAllPoints(ShadowPriest)texture_ShadowPriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ShadowPriest:SetVertexColor(1,1,1,.8)ShadowPriest:SetNormalTexture(texture_ShadowPriest)ShadowPriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ShadowPriest=ShadowPriest:CreateFontString("ShadowPriest_Font","OVERLAY")font_ShadowPriest:SetFont("Fonts\\FRIZQT__.TTF",11)font_ShadowPriest:SetShadowOffset(1,-1)ShadowPriest:SetFontString(font_ShadowPriest)ShadowPriest:SetText(GetLocalization(CLIENTEXTRABUTTONS_SHADOWPRI))ShadowPriest:SetScript("OnMouseUp",display_stuff)AssassinationRogue=CreateFrame("Button","TrainingFrame_AssassinationRogue",e,nil)AssassinationRogue:SetSize(234,25.5)AssassinationRogue:SetPoint("TOPRIGHT",-68.5,-488,5)AssassinationRogue:EnableMouse(true)texture_AssassinationRogue=AssassinationRogue:CreateTexture("AssassinationRogue")texture_AssassinationRogue:SetAllPoints(AssassinationRogue)texture_AssassinationRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_AssassinationRogue:SetVertexColor(1,.96,.41,.8)AssassinationRogue:SetNormalTexture(texture_AssassinationRogue)AssassinationRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_AssassinationRogue=AssassinationRogue:CreateFontString("AssassinationRogue_Font","OVERLAY")font_AssassinationRogue:SetFont("Fonts\\FRIZQT__.TTF",11)font_AssassinationRogue:SetShadowOffset(1,-1)AssassinationRogue:SetFontString(font_AssassinationRogue)AssassinationRogue:SetText(GetLocalization(CLIENTEXTRABUTTONS_ASSROGUE))AssassinationRogue:SetScript("OnMouseUp",display_stuff)CombatRogue=CreateFrame("Button","TrainingFrame_CombatRogue",e,nil)CombatRogue:SetSize(234,25.5)CombatRogue:SetPoint("TOPRIGHT",-68.5,-512)CombatRogue:EnableMouse(true)texture_CombatRogue=CombatRogue:CreateTexture("CombatRogue")texture_CombatRogue:SetAllPoints(CombatRogue)texture_CombatRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_CombatRogue:SetVertexColor(1,.96,.41,.8)CombatRogue:SetNormalTexture(texture_CombatRogue)CombatRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_CombatRogue=CombatRogue:CreateFontString("CombatRogue_Font","OVERLAY")font_CombatRogue:SetFont("Fonts\\FRIZQT__.TTF",11)font_CombatRogue:SetShadowOffset(1,-1)CombatRogue:SetFontString(font_CombatRogue)CombatRogue:SetText(GetLocalization(CLIENTEXTRABUTTONS_COMBATROGUE))CombatRogue:SetScript("OnMouseUp",display_stuff)SubtletyRogue=CreateFrame("Button","TrainingFrame_SubtletyRogue",e,nil)SubtletyRogue:SetSize(234,25.5)SubtletyRogue:SetPoint("TOPRIGHT",-68.5,-535,5)SubtletyRogue:EnableMouse(true)texture_SubtletyRogue=SubtletyRogue:CreateTexture("SubtletyRogue")texture_SubtletyRogue:SetAllPoints(SubtletyRogue)texture_SubtletyRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_SubtletyRogue:SetVertexColor(1,.96,.41,.8)SubtletyRogue:SetNormalTexture(texture_SubtletyRogue)SubtletyRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_SubtletyRogue=SubtletyRogue:CreateFontString("SubtletyRogue_Font","OVERLAY")font_SubtletyRogue:SetFont("Fonts\\FRIZQT__.TTF",11)font_SubtletyRogue:SetShadowOffset(1,-1)SubtletyRogue:SetFontString(font_SubtletyRogue)SubtletyRogue:SetText(GetLocalization(CLIENTEXTRABUTTONS_SUBROGUE))SubtletyRogue:SetScript("OnMouseUp",display_stuff)ElementalShaman=CreateFrame("Button","TrainingFrame_ElementalShaman",e,nil)ElementalShaman:SetSize(234,25.5)ElementalShaman:SetPoint("TOPRIGHT",-68.5,-559)ElementalShaman:EnableMouse(true)texture_ElementalShaman=ElementalShaman:CreateTexture("ElementalShaman")texture_ElementalShaman:SetAllPoints(ElementalShaman)texture_ElementalShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ElementalShaman:SetVertexColor(0,.44,.87,.8)ElementalShaman:SetNormalTexture(texture_ElementalShaman)ElementalShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ElementalShaman=ElementalShaman:CreateFontString("ElementalShaman_Font","OVERLAY")font_ElementalShaman:SetFont("Fonts\\FRIZQT__.TTF",11)font_ElementalShaman:SetShadowOffset(1,-1)ElementalShaman:SetFontString(font_ElementalShaman)ElementalShaman:SetText(GetLocalization(CLIENTEXTRABUTTONS_ELSHAM))ElementalShaman:SetScript("OnMouseUp",display_stuff)EnhancementShaman=CreateFrame("Button","TrainingFrame_EnhancementShaman",e,nil)EnhancementShaman:SetSize(234,25.5)EnhancementShaman:SetPoint("TOPRIGHT",-68.5,-582,5)EnhancementShaman:EnableMouse(true)texture_EnhancementShaman=EnhancementShaman:CreateTexture("EnhancementShaman")texture_EnhancementShaman:SetAllPoints(EnhancementShaman)texture_EnhancementShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_EnhancementShaman:SetVertexColor(0,.44,.87,.8)EnhancementShaman:SetNormalTexture(texture_EnhancementShaman)EnhancementShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_EnhancementShaman=EnhancementShaman:CreateFontString("EnhancementShaman_Font","OVERLAY")font_EnhancementShaman:SetFont("Fonts\\FRIZQT__.TTF",11)font_EnhancementShaman:SetShadowOffset(1,-1)EnhancementShaman:SetFontString(font_EnhancementShaman)EnhancementShaman:SetText(GetLocalization(CLIENTEXTRABUTTONS_ENCHSHAM))EnhancementShaman:SetScript("OnMouseUp",display_stuff)RestorationShaman=CreateFrame("Button","TrainingFrame_RestorationShaman",e,nil)RestorationShaman:SetSize(234,25.5)RestorationShaman:SetPoint("TOPRIGHT",-68.5,-606)RestorationShaman:EnableMouse(true)texture_RestorationShaman=RestorationShaman:CreateTexture("RestorationShaman")texture_RestorationShaman:SetAllPoints(RestorationShaman)texture_RestorationShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_RestorationShaman:SetVertexColor(0,.44,.87,.8)RestorationShaman:SetNormalTexture(texture_RestorationShaman)RestorationShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_RestorationShaman=RestorationShaman:CreateFontString("RestorationShaman_Font","OVERLAY")font_RestorationShaman:SetFont("Fonts\\FRIZQT__.TTF",11)font_RestorationShaman:SetShadowOffset(1,-1)RestorationShaman:SetFontString(font_RestorationShaman)RestorationShaman:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESTSHAM))RestorationShaman:SetScript("OnMouseUp",display_stuff)AfflictionWarlock=CreateFrame("Button","TrainingFrame_AfflictionWarlock",e,nil)AfflictionWarlock:SetSize(234,25.5)AfflictionWarlock:SetPoint("TOPRIGHT",-68.5,-629,5)AfflictionWarlock:EnableMouse(true)texture_AfflictionWarlock=AfflictionWarlock:CreateTexture("AfflictionWarlock")texture_AfflictionWarlock:SetAllPoints(AfflictionWarlock)texture_AfflictionWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_AfflictionWarlock:SetVertexColor(.58,.51,.79,.8)AfflictionWarlock:SetNormalTexture(texture_AfflictionWarlock)AfflictionWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_AfflictionWarlock=AfflictionWarlock:CreateFontString("AfflictionWarlock_Font","OVERLAY")font_AfflictionWarlock:SetFont("Fonts\\FRIZQT__.TTF",11)font_AfflictionWarlock:SetShadowOffset(1,-1)AfflictionWarlock:SetFontString(font_AfflictionWarlock)AfflictionWarlock:SetText(GetLocalization(CLIENTEXTRABUTTONS_AFFLOCK))AfflictionWarlock:SetScript("OnMouseUp",display_stuff)DemonologyWarlock=CreateFrame("Button","TrainingFrame_DemonologyWarlock",e,nil)DemonologyWarlock:SetSize(234,25.5)DemonologyWarlock:SetPoint("TOPRIGHT",-68.5,-653)DemonologyWarlock:EnableMouse(true)texture_DemonologyWarlock=DemonologyWarlock:CreateTexture("DemonologyWarlock")texture_DemonologyWarlock:SetAllPoints(DemonologyWarlock)texture_DemonologyWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_DemonologyWarlock:SetVertexColor(.58,.51,.79,.8)DemonologyWarlock:SetNormalTexture(texture_DemonologyWarlock)DemonologyWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_DemonologyWarlock=DemonologyWarlock:CreateFontString("DemonologyWarlock_Font","OVERLAY")font_DemonologyWarlock:SetFont("Fonts\\FRIZQT__.TTF",11)font_DemonologyWarlock:SetShadowOffset(1,-1)DemonologyWarlock:SetFontString(font_DemonologyWarlock)DemonologyWarlock:SetText(GetLocalization(CLIENTEXTRABUTTONS_DEMLOCK))DemonologyWarlock:SetScript("OnMouseUp",display_stuff)DestructionWarlock=CreateFrame("Button","TrainingFrame_DestructionWarlock",e,nil)DestructionWarlock:SetSize(234,25.5)DestructionWarlock:SetPoint("TOPRIGHT",-68.5,-676,5)DestructionWarlock:EnableMouse(true)texture_DestructionWarlock=DestructionWarlock:CreateTexture("DestructionWarlock")texture_DestructionWarlock:SetAllPoints(DestructionWarlock)texture_DestructionWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_DestructionWarlock:SetVertexColor(.58,.51,.79,.8)DestructionWarlock:SetNormalTexture(texture_DestructionWarlock)DestructionWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_DestructionWarlock=DestructionWarlock:CreateFontString("DestructionWarlock_Font","OVERLAY")font_DestructionWarlock:SetFont("Fonts\\FRIZQT__.TTF",11)font_DestructionWarlock:SetShadowOffset(1,-1)DestructionWarlock:SetFontString(font_DestructionWarlock)DestructionWarlock:SetText(GetLocalization(CLIENTEXTRABUTTONS_DESTROLOCK))DestructionWarlock:SetScript("OnMouseUp",display_stuff)ArmsWarrior=CreateFrame("Button","TrainingFrame_ArmsWarrior",e,nil)ArmsWarrior:SetSize(234,25.5)ArmsWarrior:SetPoint("TOPRIGHT",-68.5,-700)ArmsWarrior:EnableMouse(true)texture_ArmsWarrior=ArmsWarrior:CreateTexture("ArmsWarrior")texture_ArmsWarrior:SetAllPoints(ArmsWarrior)texture_ArmsWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ArmsWarrior:SetVertexColor(.78,.61,.43,.8)ArmsWarrior:SetNormalTexture(texture_ArmsWarrior)ArmsWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ArmsWarrior=ArmsWarrior:CreateFontString("ArmsWarrior_Font","OVERLAY")font_ArmsWarrior:SetFont("Fonts\\FRIZQT__.TTF",11)font_ArmsWarrior:SetShadowOffset(1,-1)ArmsWarrior:SetFontString(font_ArmsWarrior)ArmsWarrior:SetText(GetLocalization(CLIENTEXTRABUTTONS_ARMSWAR))ArmsWarrior:SetScript("OnMouseUp",display_stuff)FuryWarrior=CreateFrame("Button","TrainingFrame_FuryWarrior",e,nil)FuryWarrior:SetSize(234,25.5)FuryWarrior:SetPoint("TOPRIGHT",-68.5,-723,5)FuryWarrior:EnableMouse(true)texture_FuryWarrior=FuryWarrior:CreateTexture("FuryWarrior")texture_FuryWarrior:SetAllPoints(FuryWarrior)texture_FuryWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_FuryWarrior:SetVertexColor(.78,.61,.43,.8)FuryWarrior:SetNormalTexture(texture_FuryWarrior)FuryWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_FuryWarrior=FuryWarrior:CreateFontString("FuryWarrior_Font","OVERLAY")font_FuryWarrior:SetFont("Fonts\\FRIZQT__.TTF",11)font_FuryWarrior:SetShadowOffset(1,-1)FuryWarrior:SetFontString(font_FuryWarrior)FuryWarrior:SetText(GetLocalization(CLIENTEXTRABUTTONS_FURYWAR))FuryWarrior:SetScript("OnMouseUp",display_stuff)ProtectionWarrior=CreateFrame("Button","TrainingFrame_ProtectionWarrior",e,nil)ProtectionWarrior:SetSize(234,25.5)ProtectionWarrior:SetPoint("TOPRIGHT",-68.5,-747)ProtectionWarrior:EnableMouse(true)texture_ProtectionWarrior=ProtectionWarrior:CreateTexture("ProtectionWarrior")texture_ProtectionWarrior:SetAllPoints(ProtectionWarrior)texture_ProtectionWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")texture_ProtectionWarrior:SetVertexColor(.78,.61,.43,.8)ProtectionWarrior:SetNormalTexture(texture_ProtectionWarrior)ProtectionWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")font_ProtectionWarrior=ProtectionWarrior:CreateFontString("ProtectionWarrior_Font","OVERLAY")font_ProtectionWarrior:SetFont("Fonts\\FRIZQT__.TTF",11)font_ProtectionWarrior:SetShadowOffset(1,-1)ProtectionWarrior:SetFontString(font_ProtectionWarrior)ProtectionWarrior:SetText(GetLocalization(CLIENTEXTRABUTTONS_PROTOWAR))ProtectionWarrior:SetScript("OnMouseUp",display_stuff)SearchBox=CreateFrame("EditBox","SearchBox",e,"InputBoxTemplate")SearchBox:SetWidth(190)SearchBox:SetHeight(25.5)SearchBox:SetFontObject(GameFontNormal)SearchBox:SetPoint("TOPRIGHT",-72.5,-770,5)SearchBox:ClearFocus(self)SearchBox:SetAutoFocus(false)SearchBox:SetFontObject(GameFontDisable)SearchBox:SetScript("OnEnterPressed",SearchSpell)SearchBox:SetScript("OnEscapePressed",function(e)local t=e:GetText()if not(t)or(t=="")then
e:ClearFocus(e)e:SetText("Search Spell")return false
end
e:ClearFocus(e)end)SearchBox:SetText("Search Spell")SearchBox.Icon=SearchBox:CreateTexture(nil,"OVERLAY")SearchBox.Icon:SetSize(38,38)SearchBox.Icon:SetPoint("LEFT",-38,-1)SearchBox.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton")local T=e:CreateTexture()T:SetAllPoints()T:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_purple")T:SetSize(e:GetSize())T:Hide()local F=e:CreateTexture()F:SetAllPoints()F:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_Blue")F:SetSize(e:GetSize())F:Hide()CreateFrame("Frame","TrainingFrameBorder",e,nil)TrainingFrameBorder:SetSize(e:GetSize())TrainingFrameBorder:SetPoint("CENTER",0,0)TrainingFrameBorder:SetFrameStrata("FULLSCREEN")e.Text_Ability=TrainingFrameBorder:CreateFontString()e.Text_Ability:SetFontObject(GameFontNormal)e.Text_Ability:SetPoint("BOTTOM",c,0,-18);e.Text_Ability:SetFont("Fonts\\FRIZQT__.TTF",12)local c=GetItemCount(O)or 0
local B=GetItemCount(W)or 0
e.Text_Ability:SetText("|cffFFFFFF"..c.." |cffE1AB18|TInterface\\Icons\\inv_custom_abilityessence.blp:13:13:0:0|t|r   |cffFFFFFF"..B.." |cffE1AB18|TInterface\\Icons\\inv_custom_talentessence.blp:13:13:0:0|t|r")local c=TrainingFrameBorder:CreateTexture("ProgressionBlueBookBorder","BACKGROUND")c:SetAllPoints()c:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_add_blue")c:SetSize(e:GetSize())c:SetVertexColor(1,1,1,.7)c:Hide()local c=TrainingFrameBorder:CreateTexture("ProgressionPurpleBookBorder","BACKGROUND")c:SetAllPoints()c:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_add_Purple")c:SetSize(e:GetSize())c:SetVertexColor(1,1,1,1)c:Hide()local c=TrainingFrameBorder:CreateTexture("ProgressionAdditionalBorder","DIALOG")c:SetAllPoints()c:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_frame")c:SetSize(e:GetSize())c:SetVertexColor(1,1,1,1)function ShowSpellSelectEffect()HideTalentsSelectEffect()HideMultiSpecSelectEffect()BaseFrameFadeIn(F)if not(LoadBuildFromLinkFrame.SkillsFrame:IsVisible())then
BaseFrameFadeIn(TrainingFrame_model2)end
BaseFrameFadeOut(t)i:Hide()BaseFrameFadeOut(n)r:Hide()BaseFrameFadeOut(_)BaseFrameFadeIn(font_TrainingFrame_SelectedTitle_Spells)DisplayControlFrameValueChange(1)end
function HideSpellSelectEffect()BaseFrameFadeOut(F)BaseFrameFadeOut(TrainingFrame_model2)BaseFrameFadeIn(t)i:Show()BaseFrameFadeIn(n)r:Show()BaseFrameFadeIn(_)BaseFrameFadeOut(font_TrainingFrame_SelectedTitle_Spells)end
function ShowTalentsSelectEffect()HideSpellSelectEffect()HideMultiSpecSelectEffect()BaseFrameFadeIn(T)if not(LoadBuildFromLinkFrame.SkillsFrame:IsVisible())then
BaseFrameFadeIn(TrainingFrame_model)end
BaseFrameFadeOut(t)i:Hide()BaseFrameFadeOut(n)r:Hide()BaseFrameFadeOut(_)BaseFrameFadeIn(font_TrainingFrame_SelectedTitle_Talents)DisplayControlFrameValueChange(3)end
function HideTalentsSelectEffect()BaseFrameFadeOut(T)BaseFrameFadeOut(TrainingFrame_model)BaseFrameFadeIn(t)i:Show()BaseFrameFadeIn(n)r:Show()BaseFrameFadeIn(_)BaseFrameFadeOut(font_TrainingFrame_SelectedTitle_Talents)end
function ShowMultiSpecSelectEffect()if(DisplaySpellsButton:IsEnabled()==1)then
HideSpellSelectEffect()HideTalentsSelectEffect()DisplayControlFrameValueChange(2)BaseFrameFadeIn(font_TrainingFrame_SwitchSpec)end
BaseFrameFadeIn(SwitchSpecButton_Highlight)end
function HideMultiSpecSelectEffect()BaseFrameFadeOut(SwitchSpecButton_Highlight)if(DisplaySpellsButton:IsEnabled()==1)then
BaseFrameFadeOut(font_TrainingFrame_SwitchSpec)end
DisplayControlFrameValueChange(0)end
DisplaySpellsButton=CreateFrame("Button","TrainingFrame_DisplaySpellsButton",e,nil)DisplaySpellsButton:SetSize(200,250)DisplaySpellsButton:SetPoint("CENTER",-250,-20)DisplaySpellsButton:EnableMouse(true)texture_DisplaySpellsButton=DisplaySpellsButton:CreateTexture("DisplaySpellsButton")texture_DisplaySpellsButton:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")texture_DisplaySpellsButton:SetSize(128,64)texture_DisplaySpellsButton:SetPoint("CENTER",0,0)texture_DisplaySpellsButton_p=DisplaySpellsButton:CreateTexture("DisplaySpellsButton_p")texture_DisplaySpellsButton_p:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")texture_DisplaySpellsButton_p:SetSize(128,64)texture_DisplaySpellsButton_p:SetPoint("CENTER",0,0)DisplaySpellsButton:SetNormalTexture(texture_DisplaySpellsButton)DisplaySpellsButton:SetHighlightTexture(texture_DisplaySpellsButton_p)font_DisplaySpellsButton=DisplaySpellsButton:CreateFontString("DisplaySpellsButton_Font")font_DisplaySpellsButton:SetFont("Fonts\\MORPHEUS.TTF",15,"OUTLINE")font_DisplaySpellsButton:SetShadowOffset(1,-1)font_DisplaySpellsButton:SetText("Spells")DisplaySpellsButton:SetFontString(font_DisplaySpellsButton)DisplaySpellsButton:SetScript("OnMouseUp",z)DisplaySpellsButton:SetScript("OnEnter",ShowSpellSelectEffect)DisplayTalentsButton=CreateFrame("Button","TrainingFrame_DisplayTalentsButton",e,nil)DisplayTalentsButton:SetSize(200,250)DisplayTalentsButton:SetPoint("CENTER",22,-20)DisplayTalentsButton:EnableMouse(true)texture_DisplayTalentsButton=DisplayTalentsButton:CreateTexture("DisplayTalentsButton")texture_DisplayTalentsButton:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")texture_DisplayTalentsButton:SetSize(128,64)texture_DisplayTalentsButton:SetPoint("CENTER",0,0)texture_DisplayTalentsButton_p=DisplayTalentsButton:CreateTexture("DisplayTalentsButton_p")texture_DisplayTalentsButton_p:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")texture_DisplayTalentsButton_p:SetSize(128,64)texture_DisplayTalentsButton_p:SetPoint("CENTER",0,0)DisplayTalentsButton:SetNormalTexture(texture_DisplayTalentsButton)DisplayTalentsButton:SetHighlightTexture(texture_DisplayTalentsButton_p)font_DisplayTalentsButton=DisplayTalentsButton:CreateFontString("DisplayTalentsButton_Font")font_DisplayTalentsButton:SetFont("Fonts\\MORPHEUS.TTF",15,"OUTLINE")font_DisplayTalentsButton:SetShadowOffset(1,-1)font_DisplayTalentsButton:SetText("Talents")DisplayTalentsButton:SetFontString(font_DisplayTalentsButton)DisplayTalentsButton:SetScript("OnMouseUp",y)DisplayTalentsButton:SetScript("OnEnter",ShowTalentsSelectEffect)DisplaySpellsButton:Disable()DisplayTalentsButton:Disable()e:SetScript("OnUpdate",function()if not(DisplaySpellsButton:IsVisible())then
t:Hide()i:Hide()n:Hide()r:Hide()_:Hide()end
end)e:RegisterEvent("BAG_UPDATE")e:SetScript("OnEvent",function(t,t,...)local t=GetItemCount(O)or 0
local l=GetItemCount(W)or 0
e.Text_Ability:SetText("|cffFFFFFF"..t.." |cffE1AB18|TInterface\\Icons\\inv_custom_abilityessence.blp:13:13:0:0|t|r   |cffFFFFFF"..l.." |cffE1AB18|TInterface\\Icons\\inv_custom_talentessence.blp:13:13:0:0|t|r")if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and((BeginnerForcedTutorial.Tip==3)or(BeginnerForcedTutorial.Tip==4))and(GetItemCount(O)<=1)then
BeginnerForcedTutorial_PlayTip(5)end
end
end)e:SetScript("OnShow",function()oe()if not(BeginnerForcedTutorial:IsVisible())then
return false
end
if(BeginnerForcedTutorial.Tip)and(BeginnerForcedTutorial.Tip==1)and not(S=="TALENTS")then
if not(S=="SPELLS")then
BeginnerForcedTutorial_PlayTip(2)else
SolveLearnButtonHighlight(true)BeginnerForcedTutorial_PlayTip(3)end
end
end)e:SetScript("OnHide",function()if BeginnerForcedTutorial:IsVisible()then
if(BeginnerForcedTutorial.Tip)and(BeginnerForcedTutorial.Tip==5)then
BeginnerForcedTutorial_PlayTip(6)elseif(BeginnerForcedTutorial.Tip)and(BeginnerForcedTutorial.Tip<5)then
BeginnerForcedTutorial_PlayTip(1)end
end
end)Spell_slot1=CreateFrame("Frame","TrainingFrame_Spell_slot1",e,nil)Spell_slot1Button=CreateFrame("Button","TrainingFrame_Spell_slot1Button",Spell_slot1,nil)Spell_slot1ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot1ButtonL",Spell_slot1,nil)Spell_slot1ButtonLT=Spell_slot1ButtonL:CreateTexture("Spell_slot1ButtonLT")Spell_slot1ButtonF=Spell_slot1ButtonL:CreateFontString("Spell_slot1ButtonF")Spell_slot1_AttachedSpell=nil
Spell_slot2=CreateFrame("Frame","TrainingFrame_Spell_slot2",e,nil)Spell_slot2Button=CreateFrame("Button","TrainingFrame_Spell_slot2Button",Spell_slot2,nil)Spell_slot2ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot2ButtonL",Spell_slot2,nil)Spell_slot2ButtonLT=Spell_slot2ButtonL:CreateTexture("Spell_slot2ButtonLT")Spell_slot2ButtonF=Spell_slot2ButtonL:CreateFontString("Spell_slot2ButtonF")Spell_slot2_AttachedSpell=nil
Spell_slot3=CreateFrame("Frame","TrainingFrame_Spell_slot3",e,nil)Spell_slot3Button=CreateFrame("Button","TrainingFrame_Spell_slot3Button",Spell_slot3,nil)Spell_slot3ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot3ButtonL",Spell_slot3,nil)Spell_slot3ButtonLT=Spell_slot3ButtonL:CreateTexture("Spell_slot3ButtonLT")Spell_slot3ButtonF=Spell_slot3ButtonL:CreateFontString("Spell_slot3ButtonF")Spell_slot3_AttachedSpell=nil
Spell_slot4=CreateFrame("Frame","TrainingFrame_Spell_slot4",e,nil)Spell_slot4Button=CreateFrame("Button","TrainingFrame_Spell_slot4Button",Spell_slot4,nil)Spell_slot4ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot4ButtonL",Spell_slot4,nil)Spell_slot4ButtonLT=Spell_slot4ButtonL:CreateTexture("Spell_slot4ButtonLT")Spell_slot4ButtonF=Spell_slot1ButtonL:CreateFontString("Spell_slot4ButtonF")Spell_slot4_AttachedSpell=nil
Spell_slot5=CreateFrame("Frame","TrainingFrame_Spell_slot5",e,nil)Spell_slot5Button=CreateFrame("Button","TrainingFrame_Spell_slot5Button",Spell_slot5,nil)Spell_slot5ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot5ButtonL",Spell_slot5,nil)Spell_slot5ButtonLT=Spell_slot5ButtonL:CreateTexture("Spell_slot5ButtonLT")Spell_slot5ButtonF=Spell_slot5ButtonL:CreateFontString("Spell_slot5ButtonF")Spell_slot5_AttachedSpell=nil
Spell_slot6=CreateFrame("Frame","TrainingFrame_Spell_slot6",e,nil)Spell_slot6Button=CreateFrame("Button","TrainingFrame_Spell_slot6Button",Spell_slot6,nil)Spell_slot6ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot6ButtonL",Spell_slot6,nil)Spell_slot6ButtonLT=Spell_slot6ButtonL:CreateTexture("Spell_slot6ButtonLT")Spell_slot6ButtonF=Spell_slot6ButtonL:CreateFontString("Spell_slot6ButtonF")Spell_slot6_AttachedSpell=nil
Spell_slot7=CreateFrame("Frame","TrainingFrame_Spell_slot7",e,nil)Spell_slot7Button=CreateFrame("Button","TrainingFrame_Spell_slot7Button",Spell_slot7,nil)Spell_slot7ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot7ButtonL",Spell_slot7,nil)Spell_slot7ButtonLT=Spell_slot7ButtonL:CreateTexture("Spell_slot7ButtonLT")Spell_slot7ButtonF=Spell_slot7ButtonL:CreateFontString("Spell_slot7ButtonF")Spell_slot7_AttachedSpell=nil
Spell_slot8=CreateFrame("Frame","TrainingFrame_Spell_slot8",e,nil)Spell_slot8Button=CreateFrame("Button","TrainingFrame_Spell_slot8Button",Spell_slot8,nil)Spell_slot8ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot8ButtonL",Spell_slot8,nil)Spell_slot8ButtonLT=Spell_slot8ButtonL:CreateTexture("Spell_slot8ButtonLT")Spell_slot8ButtonF=Spell_slot8ButtonL:CreateFontString("Spell_slot8ButtonF")Spell_slot8_AttachedSpell=nil
Spell_slot9=CreateFrame("Frame","TrainingFrame_Spell_slot9",e,nil)Spell_slot9Button=CreateFrame("Button","TrainingFrame_Spell_slot9Button",Spell_slot9,nil)Spell_slot9ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot9ButtonL",Spell_slot9,nil)Spell_slot9ButtonLT=Spell_slot9ButtonL:CreateTexture("Spell_slot9ButtonLT")Spell_slot9ButtonF=Spell_slot9ButtonL:CreateFontString("Spell_slot9ButtonF")Spell_slot9_AttachedSpell=nil
Spell_slot10=CreateFrame("Frame","TrainingFrame_Spell_slot10",e,nil)Spell_slot10Button=CreateFrame("Button","TrainingFrame_Spell_slot10Button",Spell_slot10,nil)Spell_slot10ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot10ButtonL",Spell_slot10,nil)Spell_slot10ButtonLT=Spell_slot10ButtonL:CreateTexture("Spell_slot10ButtonLT")Spell_slot10ButtonF=Spell_slot10ButtonL:CreateFontString("Spell_slot10ButtonF")Spell_slot10_AttachedSpell=nil
Spell_slot11=CreateFrame("Frame","TrainingFrame_Spell_slot11",e,nil)Spell_slot11Button=CreateFrame("Button","TrainingFrame_Spell_slot11Button",Spell_slot11,nil)Spell_slot11ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot11ButtonL",Spell_slot11,nil)Spell_slot11ButtonLT=Spell_slot11ButtonL:CreateTexture("Spell_slot11ButtonLT")Spell_slot11ButtonF=Spell_slot11ButtonL:CreateFontString("Spell_slot11ButtonF")Spell_slot11_AttachedSpell=nil
Spell_slot12=CreateFrame("Frame","TrainingFrame_Spell_slot12",e,nil)Spell_slot12Button=CreateFrame("Button","TrainingFrame_Spell_slot12Button",Spell_slot12,nil)Spell_slot12ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot12ButtonL",Spell_slot12,nil)Spell_slot12ButtonLT=Spell_slot12ButtonL:CreateTexture("Spell_slot12ButtonLT")Spell_slot12ButtonF=Spell_slot12ButtonL:CreateFontString("Spell_slot12ButtonF")Spell_slot12_AttachedSpell=nil
Spell_slot13=CreateFrame("Frame","TrainingFrame_Spell_slot13",e,nil)Spell_slot13Button=CreateFrame("Button","TrainingFrame_Spell_slot13Button",Spell_slot13,nil)Spell_slot13ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot13ButtonL",Spell_slot13,nil)Spell_slot13ButtonLT=Spell_slot13ButtonL:CreateTexture("Spell_slot13ButtonLT")Spell_slot13ButtonF=Spell_slot13ButtonL:CreateFontString("Spell_slot13ButtonF")Spell_slot13_AttachedSpell=nil
Spell_slot14=CreateFrame("Frame","TrainingFrame_Spell_slot14",e,nil)Spell_slot14Button=CreateFrame("Button","TrainingFrame_Spell_slot14Button",Spell_slot14,nil)Spell_slot14ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot14ButtonL",Spell_slot14,nil)Spell_slot14ButtonLT=Spell_slot14ButtonL:CreateTexture("Spell_slot14ButtonLT")Spell_slot14ButtonF=Spell_slot14ButtonL:CreateFontString("Spell_slot14ButtonF")Spell_slot14_AttachedSpell=nil
Spell_slot15=CreateFrame("Frame","TrainingFrame_Spell_slot15",e,nil)Spell_slot15Button=CreateFrame("Button","TrainingFrame_Spell_slot15Button",Spell_slot15,nil)Spell_slot15ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot15ButtonL",Spell_slot15,nil)Spell_slot15ButtonLT=Spell_slot15ButtonL:CreateTexture("Spell_slot15ButtonLT")Spell_slot15ButtonF=Spell_slot15ButtonL:CreateFontString("Spell_slot15ButtonF")Spell_slot15_AttachedSpell=nil
Spell_slot16=CreateFrame("Frame","TrainingFrame_Spell_slot16",e,nil)Spell_slot16Button=CreateFrame("Button","TrainingFrame_Spell_slot16Button",Spell_slot16,nil)Spell_slot16ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot16ButtonL",Spell_slot16,nil)Spell_slot16ButtonLT=Spell_slot16ButtonL:CreateTexture("Spell_slot16ButtonLT")Spell_slot16ButtonF=Spell_slot16ButtonL:CreateFontString("Spell_slot16ButtonF")Spell_slot16_AttachedSpell=nil
Spell_slot17=CreateFrame("Frame","TrainingFrame_Spell_slot17",e,nil)Spell_slot17Button=CreateFrame("Button","TrainingFrame_Spell_slot17Button",Spell_slot17,nil)Spell_slot17ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot17ButtonL",Spell_slot17,nil)Spell_slot17ButtonLT=Spell_slot17ButtonL:CreateTexture("Spell_slot17ButtonLT")Spell_slot17ButtonF=Spell_slot17ButtonL:CreateFontString("Spell_slot17ButtonF")Spell_slot17_AttachedSpell=nil
Spell_slot18=CreateFrame("Frame","TrainingFrame_Spell_slot18",e,nil)Spell_slot18Button=CreateFrame("Button","TrainingFrame_Spell_slot18Button",Spell_slot18,nil)Spell_slot18ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot18ButtonL",Spell_slot18,nil)Spell_slot18ButtonLT=Spell_slot18ButtonL:CreateTexture("Spell_slot18ButtonLT")Spell_slot18ButtonF=Spell_slot18ButtonL:CreateFontString("Spell_slot18ButtonF")Spell_slot18_AttachedSpell=nil
Spell_slot19=CreateFrame("Frame","TrainingFrame_Spell_slot19",e,nil)Spell_slot19Button=CreateFrame("Button","TrainingFrame_Spell_slot19Button",Spell_slot19,nil)Spell_slot19ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot19ButtonL",Spell_slot19,nil)Spell_slot19ButtonLT=Spell_slot19ButtonL:CreateTexture("Spell_slot19ButtonLT")Spell_slot19ButtonF=Spell_slot19ButtonL:CreateFontString("Spell_slot19ButtonF")Spell_slot19_AttachedSpell=nil
Spell_slot20=CreateFrame("Frame","TrainingFrame_Spell_slot20",e,nil)Spell_slot20Button=CreateFrame("Button","TrainingFrame_Spell_slot20Button",Spell_slot20,nil)Spell_slot20ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot20ButtonL",Spell_slot20,nil)Spell_slot20ButtonLT=Spell_slot20ButtonL:CreateTexture("Spell_slot20ButtonLT")Spell_slot20ButtonF=Spell_slot20ButtonL:CreateFontString("Spell_slot20ButtonF")Spell_slot20_AttachedSpell=nil
Spell_slot21=CreateFrame("Frame","TrainingFrame_Spell_slot21",e,nil)Spell_slot21Button=CreateFrame("Button","TrainingFrame_Spell_slot21Button",Spell_slot21,nil)Spell_slot21ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot21ButtonL",Spell_slot21,nil)Spell_slot21ButtonLT=Spell_slot21ButtonL:CreateTexture("Spell_slot21ButtonLT")Spell_slot21ButtonF=Spell_slot21ButtonL:CreateFontString("Spell_slot21ButtonF")Spell_slot21_AttachedSpell=nil
Spell_slot22=CreateFrame("Frame","TrainingFrame_Spell_slot22",e,nil)Spell_slot22Button=CreateFrame("Button","TrainingFrame_Spell_slot22Button",Spell_slot22,nil)Spell_slot22ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot22ButtonL",Spell_slot22,nil)Spell_slot22ButtonLT=Spell_slot22ButtonL:CreateTexture("Spell_slot22ButtonLT")Spell_slot22ButtonF=Spell_slot22ButtonL:CreateFontString("Spell_slot22ButtonF")Spell_slot22_AttachedSpell=nil
Spell_slot23=CreateFrame("Frame","TrainingFrame_Spell_slot23",e,nil)Spell_slot23Button=CreateFrame("Button","TrainingFrame_Spell_slot23Button",Spell_slot23,nil)Spell_slot23ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot23ButtonL",Spell_slot23,nil)Spell_slot23ButtonLT=Spell_slot23ButtonL:CreateTexture("Spell_slot23ButtonLT")Spell_slot23ButtonF=Spell_slot23ButtonL:CreateFontString("Spell_slot23ButtonF")Spell_slot23_AttachedSpell=nil
Spell_slot24=CreateFrame("Frame","TrainingFrame_Spell_slot24",e,nil)Spell_slot24Button=CreateFrame("Button","TrainingFrame_Spell_slot24Button",Spell_slot24,nil)Spell_slot24ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot24ButtonL",Spell_slot24,nil)Spell_slot24ButtonLT=Spell_slot24ButtonL:CreateTexture("Spell_slot24ButtonLT")Spell_slot24ButtonF=Spell_slot24ButtonL:CreateFontString("Spell_slot24ButtonF")Spell_slot24_AttachedSpell=nil
Spell_slot25=CreateFrame("Frame","TrainingFrame_Spell_slot25",e,nil)Spell_slot25Button=CreateFrame("Button","TrainingFrame_Spell_slot25Button",Spell_slot25,nil)Spell_slot25ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot25ButtonL",Spell_slot25,nil)Spell_slot25ButtonLT=Spell_slot25ButtonL:CreateTexture("Spell_slot25ButtonLT")Spell_slot25ButtonF=Spell_slot25ButtonL:CreateFontString("Spell_slot25ButtonF")Spell_slot25_AttachedSpell=nil
Spell_slot26=CreateFrame("Frame","TrainingFrame_Spell_slot26",e,nil)Spell_slot26Button=CreateFrame("Button","TrainingFrame_Spell_slot26Button",Spell_slot26,nil)Spell_slot26ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot26ButtonL",Spell_slot26,nil)Spell_slot26ButtonLT=Spell_slot26ButtonL:CreateTexture("Spell_slot26ButtonLT")Spell_slot26ButtonF=Spell_slot26ButtonL:CreateFontString("Spell_slot26ButtonF")Spell_slot26_AttachedSpell=nil
Spell_slot27=CreateFrame("Frame","TrainingFrame_Spell_slot27",e,nil)Spell_slot27Button=CreateFrame("Button","TrainingFrame_Spell_slot27Button",Spell_slot27,nil)Spell_slot27ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot27ButtonL",Spell_slot27,nil)Spell_slot27ButtonLT=Spell_slot27ButtonL:CreateTexture("Spell_slot27ButtonLT")Spell_slot27ButtonF=Spell_slot27ButtonL:CreateFontString("Spell_slot27ButtonF")Spell_slot27_AttachedSpell=nil
Spell_slot28=CreateFrame("Frame","TrainingFrame_Spell_slot28",e,nil)Spell_slot28Button=CreateFrame("Button","TrainingFrame_Spell_slot28Button",Spell_slot28,nil)Spell_slot28ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot28ButtonL",Spell_slot28,nil)Spell_slot28ButtonLT=Spell_slot28ButtonL:CreateTexture("Spell_slot28ButtonLT")Spell_slot28ButtonF=Spell_slot28ButtonL:CreateFontString("Spell_slot28ButtonF")Spell_slot28_AttachedSpell=nil
Spell_slot29=CreateFrame("Frame","TrainingFrame_Spell_slot29",e,nil)Spell_slot29Button=CreateFrame("Button","TrainingFrame_Spell_slot29Button",Spell_slot29,nil)Spell_slot29ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot29ButtonL",Spell_slot29,nil)Spell_slot29ButtonLT=Spell_slot29ButtonL:CreateTexture("Spell_slot29ButtonLT")Spell_slot29ButtonF=Spell_slot29ButtonL:CreateFontString("Spell_slot29ButtonF")Spell_slot29_AttachedSpell=nil
Spell_slot30=CreateFrame("Frame","TrainingFrame_Spell_slot30",e,nil)Spell_slot30Button=CreateFrame("Button","TrainingFrame_Spell_slot30Button",Spell_slot30,nil)Spell_slot30ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot30ButtonL",Spell_slot30,nil)Spell_slot30ButtonLT=Spell_slot30ButtonL:CreateTexture("Spell_slot30ButtonLT")Spell_slot30ButtonF=Spell_slot30ButtonL:CreateFontString("Spell_slot30ButtonF")Spell_slot30_AttachedSpell=nil
Spell_slot31=CreateFrame("Frame","TrainingFrame_Spell_slot31",e,nil)Spell_slot31Button=CreateFrame("Button","TrainingFrame_Spell_slot31Button",Spell_slot31,nil)Spell_slot31ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot31ButtonL",Spell_slot31,nil)Spell_slot31ButtonLT=Spell_slot31ButtonL:CreateTexture("Spell_slot31ButtonLT")Spell_slot31ButtonF=Spell_slot31ButtonL:CreateFontString("Spell_slot31ButtonF")Spell_slot31_AttachedSpell=nil
Spell_slot32=CreateFrame("Frame","TrainingFrame_Spell_slot32",e,nil)Spell_slot32Button=CreateFrame("Button","TrainingFrame_Spell_slot32Button",Spell_slot32,nil)Spell_slot32ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot32ButtonL",Spell_slot32,nil)Spell_slot32ButtonLT=Spell_slot32ButtonL:CreateTexture("Spell_slot32ButtonLT")Spell_slot32ButtonF=Spell_slot32ButtonL:CreateFontString("Spell_slot32ButtonF")Spell_slot32_AttachedSpell=nil
Spell_slot33=CreateFrame("Frame","TrainingFrame_Spell_slot33",e,nil)Spell_slot33Button=CreateFrame("Button","TrainingFrame_Spell_slot33Button",Spell_slot33,nil)Spell_slot33ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot33ButtonL",Spell_slot33,nil)Spell_slot33ButtonLT=Spell_slot33ButtonL:CreateTexture("Spell_slot33ButtonLT")Spell_slot33ButtonF=Spell_slot33ButtonL:CreateFontString("Spell_slot33ButtonF")Spell_slot33_AttachedSpell=nil
Spell_slot34=CreateFrame("Frame","TrainingFrame_Spell_slot34",e,nil)Spell_slot34Button=CreateFrame("Button","TrainingFrame_Spell_slot34Button",Spell_slot34,nil)Spell_slot34ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot34ButtonL",Spell_slot34,nil)Spell_slot34ButtonLT=Spell_slot34ButtonL:CreateTexture("Spell_slot34ButtonLT")Spell_slot34ButtonF=Spell_slot34ButtonL:CreateFontString("Spell_slot34ButtonF")Spell_slot34_AttachedSpell=nil
Spell_slot35=CreateFrame("Frame","TrainingFrame_Spell_slot35",e,nil)Spell_slot35Button=CreateFrame("Button","TrainingFrame_Spell_slot35Button",Spell_slot35,nil)Spell_slot35ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot35ButtonL",Spell_slot35,nil)Spell_slot35ButtonLT=Spell_slot35ButtonL:CreateTexture("Spell_slot35ButtonLT")Spell_slot35ButtonF=Spell_slot35ButtonL:CreateFontString("Spell_slot35ButtonF")Spell_slot35_AttachedSpell=nil
Spell_slot36=CreateFrame("Frame","TrainingFrame_Spell_slot36",e,nil)Spell_slot36Button=CreateFrame("Button","TrainingFrame_Spell_slot36Button",Spell_slot36,nil)Spell_slot36ButtonL=CreateFrame("Button","TrainingFrame_Spell_slot36ButtonL",Spell_slot36,nil)Spell_slot36ButtonLT=Spell_slot36ButtonL:CreateTexture("Spell_slot36ButtonLT")Spell_slot36ButtonF=Spell_slot36ButtonL:CreateFontString("Spell_slot36ButtonF")Spell_slot36_AttachedSpell=nil
all_spell_slots={{Spell_slot1,-300,-160},{Spell_slot2,-220,-160},{Spell_slot3,-140,-160},{Spell_slot4,-60,-160},{Spell_slot5,20,-160},{Spell_slot6,100,-160},{Spell_slot7,-300,-260},{Spell_slot8,-220,-260},{Spell_slot9,-140,-260},{Spell_slot10,-60,-260},{Spell_slot11,20,-260},{Spell_slot12,100,-260},{Spell_slot13,-300,-360},{Spell_slot14,-220,-360},{Spell_slot15,-140,-360},{Spell_slot16,-60,-360},{Spell_slot17,20,-360},{Spell_slot18,100,-360},{Spell_slot19,-300,-460},{Spell_slot20,-220,-460},{Spell_slot21,-140,-460},{Spell_slot22,-60,-460},{Spell_slot23,20,-460},{Spell_slot24,100,-460},{Spell_slot25,-300,-560},{Spell_slot26,-220,-560},{Spell_slot27,-140,-560},{Spell_slot28,-60,-560},{Spell_slot29,20,-560},{Spell_slot30,100,-560},{Spell_slot31,-300,-660},{Spell_slot32,-220,-660},{Spell_slot33,-140,-660},{Spell_slot34,-60,-660},{Spell_slot35,20,-660},{Spell_slot36,100,-660}}all_spell_slot_buttons={Spell_slot1Button,Spell_slot2Button,Spell_slot3Button,Spell_slot4Button,Spell_slot5Button,Spell_slot6Button,Spell_slot7Button,Spell_slot8Button,Spell_slot9Button,Spell_slot10Button,Spell_slot11Button,Spell_slot12Button,Spell_slot13Button,Spell_slot14Button,Spell_slot15Button,Spell_slot16Button,Spell_slot17Button,Spell_slot18Button,Spell_slot19Button,Spell_slot20Button,Spell_slot21Button,Spell_slot22Button,Spell_slot23Button,Spell_slot24Button,Spell_slot25Button,Spell_slot26Button,Spell_slot27Button,Spell_slot28Button,Spell_slot29Button,Spell_slot30Button,Spell_slot31Button,Spell_slot32Button,Spell_slot33Button,Spell_slot34Button,Spell_slot35Button,Spell_slot36Button}all_learn_spell_buttons={Spell_slot1ButtonL,Spell_slot2ButtonL,Spell_slot3ButtonL,Spell_slot4ButtonL,Spell_slot5ButtonL,Spell_slot6ButtonL,Spell_slot7ButtonL,Spell_slot8ButtonL,Spell_slot9ButtonL,Spell_slot10ButtonL,Spell_slot11ButtonL,Spell_slot12ButtonL,Spell_slot13ButtonL,Spell_slot14ButtonL,Spell_slot15ButtonL,Spell_slot16ButtonL,Spell_slot17ButtonL,Spell_slot18ButtonL,Spell_slot19ButtonL,Spell_slot20ButtonL,Spell_slot21ButtonL,Spell_slot22ButtonL,Spell_slot23ButtonL,Spell_slot24ButtonL,Spell_slot25ButtonL,Spell_slot26ButtonL,Spell_slot27ButtonL,Spell_slot28ButtonL,Spell_slot29ButtonL,Spell_slot30ButtonL,Spell_slot31ButtonL,Spell_slot32ButtonL,Spell_slot33ButtonL,Spell_slot34ButtonL,Spell_slot35ButtonL,Spell_slot36ButtonL}all_learn_spell_buttons_t={Spell_slot1ButtonLT,Spell_slot2ButtonLT,Spell_slot3ButtonLT,Spell_slot4ButtonLT,Spell_slot5ButtonLT,Spell_slot6ButtonLT,Spell_slot7ButtonLT,Spell_slot8ButtonLT,Spell_slot9ButtonLT,Spell_slot10ButtonLT,Spell_slot11ButtonLT,Spell_slot12ButtonLT,Spell_slot13ButtonLT,Spell_slot14ButtonLT,Spell_slot15ButtonLT,Spell_slot16ButtonLT,Spell_slot17ButtonLT,Spell_slot19ButtonLT,Spell_slot18ButtonLT,Spell_slot20ButtonLT,Spell_slot21ButtonLT,Spell_slot22ButtonLT,Spell_slot23ButtonLT,Spell_slot24ButtonLT,Spell_slot25ButtonLT,Spell_slot26ButtonLT,Spell_slot27ButtonLT,Spell_slot28ButtonLT,Spell_slot29ButtonLT,Spell_slot30ButtonLT,Spell_slot31ButtonLT,Spell_slot32ButtonLT,Spell_slot33ButtonLT,Spell_slot34ButtonLT,Spell_slot35ButtonLT,Spell_slot36ButtonLT}all_learn_spell_buttons_f={Spell_slot1ButtonF,Spell_slot2ButtonF,Spell_slot3ButtonF,Spell_slot4ButtonF,Spell_slot5ButtonF,Spell_slot6ButtonF,Spell_slot7ButtonF,Spell_slot8ButtonF,Spell_slot9ButtonF,Spell_slot10ButtonF,Spell_slot11ButtonF,Spell_slot12ButtonF,Spell_slot13ButtonF,Spell_slot14ButtonF,Spell_slot15ButtonF,Spell_slot16ButtonF,Spell_slot17ButtonF,Spell_slot18ButtonF,Spell_slot19ButtonF,Spell_slot20ButtonF,Spell_slot21ButtonF,Spell_slot22ButtonF,Spell_slot23ButtonF,Spell_slot24ButtonF,Spell_slot25ButtonF,Spell_slot26ButtonF,Spell_slot27ButtonF,Spell_slot28ButtonF,Spell_slot29ButtonF,Spell_slot30ButtonF,Spell_slot31ButtonF,Spell_slot32ButtonF,Spell_slot33ButtonF,Spell_slot34ButtonF,Spell_slot35ButtonF,Spell_slot36ButtonF}all_attached_spells={Spell_slot1_AttachedSpell,Spell_slot2_AttachedSpell,Spell_slot3_AttachedSpell,Spell_slot4_AttachedSpell,Spell_slot5_AttachedSpell,Spell_slot6_AttachedSpell,Spell_slot7_AttachedSpell,Spell_slot8_AttachedSpell,Spell_slot9_AttachedSpell,Spell_slot10_AttachedSpell,Spell_slot11_AttachedSpell,Spell_slot12_AttachedSpell,Spell_slot13_AttachedSpell,Spell_slot14_AttachedSpell,Spell_slot15_AttachedSpell,Spell_slot16_AttachedSpell,Spell_slot17_AttachedSpell,Spell_slot18_AttachedSpell,Spell_slot19_AttachedSpell,Spell_slot20_AttachedSpell,Spell_slot21_AttachedSpell,Spell_slot22_AttachedSpell,Spell_slot23_AttachedSpell,Spell_slot24_AttachedSpell,Spell_slot25_AttachedSpell,Spell_slot26_AttachedSpell,Spell_slot27_AttachedSpell,Spell_slot28_AttachedSpell,Spell_slot29_AttachedSpell,Spell_slot30_AttachedSpell,Spell_slot31_AttachedSpell,Spell_slot32_AttachedSpell,Spell_slot33_AttachedSpell,Spell_slot34_AttachedSpell,Spell_slot35_AttachedSpell,Spell_slot36_AttachedSpell}for t,e in ipairs(all_spell_slots)do
e[1]:SetSize(50,50)e[1]:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground",edgeFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground-Border",edgeSize=15})e[1]:SetPoint("TOP",e[2],e[3])e[1]:Hide()end
for t,e in ipairs(all_spell_slot_buttons)do
e:SetSize(40,40)e:SetPoint("CENTER")e:EnableMouse(true)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground"})e:SetScript("OnMouseUp",unlearn_spell)_G[e:GetName().."_UnlearnTex"]=e:CreateTexture()_G[e:GetName().."_UnlearnTex"]:SetAllPoints()_G[e:GetName().."_UnlearnTex"]:SetSize(e:GetSize())_G[e:GetName().."_UnlearnTex"]:SetPoint("CENTER",0,0)_G[e:GetName().."_UnlearnTex"]:SetTexture("Interface\\Icons\\inv_custom_scrollofunlearning")_G[e:GetName().."_UnlearnTex"]:Hide()_G[e:GetName().."_KnownTexture"]=e:CreateTexture()_G[e:GetName().."_KnownTexture"]:SetSize(128,64)_G[e:GetName().."_KnownTexture"]:SetPoint("CENTER",-.5,-5)_G[e:GetName().."_KnownTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\LearnedSpell_TextureNormal")_G[e:GetName().."_KnownTexture"]:Hide()if(t==1)then
all_spell_slot_buttons_UnLearnEffect=CreateFrame("Model","all_spell_slot_buttons_UnLearnEffect",e)all_spell_slot_buttons_UnLearnEffect:SetWidth(256);all_spell_slot_buttons_UnLearnEffect:SetHeight(256);all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",e,"CENTER",0,0)all_spell_slot_buttons_UnLearnEffect:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")all_spell_slot_buttons_UnLearnEffect:SetModelScale(.035)all_spell_slot_buttons_UnLearnEffect:SetCamera(0)all_spell_slot_buttons_UnLearnEffect:SetPosition(.08,.087,0)all_spell_slot_buttons_UnLearnEffect:SetFacing(.1)all_spell_slot_buttons_UnLearnEffect:Hide()end
end
for t,e in ipairs(all_learn_spell_buttons)do
e:SetSize(50,20)e:SetPoint("CENTER",0,-42)e:EnableMouse(true)e:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")e:SetScript("OnMouseUp",function(e)learn_spell(e,false)end)end
for t,e in ipairs(all_learn_spell_buttons_t)do
e:SetAllPoints(all_learn_spell_buttons[t])all_learn_spell_buttons[t]:SetNormalTexture(e)end
for t,e in ipairs(all_learn_spell_buttons_f)do
e:SetFont("Fonts\\MORPHEUS.TTF",15,"OUTLINE")e:SetShadowOffset(1,-1)all_learn_spell_buttons[t]:SetFontString(e)all_learn_spell_buttons[t]:SetText(GetLocalization(CLIENTEXTRABUTTONS_LEARNWHITE))end
scrollframe=CreateFrame("ScrollFrame",nil,e)scrollframe:SetPoint("TOPLEFT",95,-135)scrollframe:SetSize(500,650)e.scrollframe=scrollframe
scrollframe:Hide()scrollbar=CreateFrame("Slider",nil,scrollframe,"UIPanelScrollBarTemplate")scrollbar:SetPoint("TOPLEFT",scrollframe,"TOPRIGHT",33,0)scrollbar:SetPoint("BOTTOMLEFT",scrollframe,"BOTTOMRIGHT",33,0)scrollbar:SetMinMaxValues(0,670)scrollbar:SetValueStep(1)scrollbar.scrollStep=1
scrollbar:SetValue(0)scrollbar:SetWidth(16)scrollbar:SetFrameStrata("FULLSCREEN")scrollbar:SetScript("OnValueChanged",function(t,e)t:GetParent():SetVerticalScroll(e)end)local t=scrollbar:CreateTexture(nil,"BACKGROUND")t:SetAllPoints(scrollbar)t:SetTexture(0,0,0,.4)e.scrollbar=scrollbar
scrollbar:Hide()top_left_bg=CreateFrame("Frame",nil,e)top_left_bg:SetSize(305,402)top_left_bg:SetPoint("TOPLEFT",90,-138)top_left_bg_t=top_left_bg:CreateTexture()top_left_bg_t:SetAllPoints()top_left_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-TopLeft")top_left_bg.texture=top_left_bg_t
top_left_bg:Hide()top_right_bg=CreateFrame("Frame",nil,e)top_right_bg:SetSize(305,402)top_right_bg:SetPoint("TOPLEFT",395,-138)top_right_bg_t=top_right_bg:CreateTexture()top_right_bg_t:SetAllPoints()top_right_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-TopRight")top_right_bg.texture=top_right_bg_t
top_right_bg:Hide()bottom_left_bg=CreateFrame("Frame",nil,e)bottom_left_bg:SetSize(305,402)bottom_left_bg:SetPoint("TOPLEFT",90,-540)bottom_left_bg_t=bottom_left_bg:CreateTexture()bottom_left_bg_t:SetAllPoints()bottom_left_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-BottomLeft")bottom_left_bg.texture=bottom_left_bg_t
bottom_left_bg:Hide()bottom_right_bg=CreateFrame("Frame",nil,e)bottom_right_bg:SetSize(305,402)bottom_right_bg:SetPoint("TOPLEFT",395,-540)bottom_right_bg_t=bottom_right_bg:CreateTexture()bottom_right_bg_t:SetAllPoints()bottom_right_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-BottomRight")bottom_right_bg.texture=bottom_right_bg_t
bottom_right_bg:Hide()content=CreateFrame("Frame",nil,scrollframe)content:SetSize(500,1320)scrollframe.content=content
content:Hide()scrollframe:SetScrollChild(content)repeat
local e=CreateFrame("Frame","TrainingFrame_talent_slot1",content,nil)table.insert(f,e)local t=CreateFrame("Button","TrainingFrame_talent_slotButton",e,nil)table.insert(l,t)local t=CreateFrame("Button","TrainingFrame_talent_slotButtonL",e,nil)table.insert(o,t)local l=t:CreateTexture("talent_slotButtonLT")table.insert(H,l)local t=t:CreateFontString("talent_slotButtonF")table.insert(K,t)local t=nil
table.insert(m,t)local e=CreateFrame("Button","TrainingFrame_talent_slotFrameNumber",e,nil)table.insert(u,e)local e=e:CreateFontString("talent_stotFNF")table.insert(q,e)table.insert(x,false)M=M+1
until(M>re)all_talent_coords={{-165,-83},{-40,-83},{85,-83},{210,-83},{-165,-191},{-40,-191},{85,-191},{210,-191},{-165,-299},{-40,-299},{85,-299},{210,-299},{-165,-407},{-40,-407},{85,-407},{210,-407},{-165,-515},{-40,-515},{85,-515},{210,-515},{-165,-623},{-40,-623},{85,-623},{210,-623},{-165,-731},{-40,-731},{85,-731},{210,-731},{-165,-839},{-40,-839},{85,-839},{210,-839},{-165,-947},{-40,-947},{85,-947},{210,-947},{-165,-1055},{-40,-1055},{85,-1055},{210,-1055},{-165,-1163},{-40,-1163},{85,-1163},{210,-1163}}for t,e in ipairs(f)do
e:SetSize(56,56)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg",insets={left=-11,right=-11,top=-11,bottom=-11}})e:SetPoint("TOP",all_talent_coords[t][1],all_talent_coords[t][2])e:Show()end
for t,e in ipairs(l)do
e:SetSize(48,48)e:SetPoint("CENTER")e:EnableMouse(true)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackgroundold"})e:SetScript("OnMouseUp",Fe)_G[e:GetName().."_UnlearnTex"]=e:CreateTexture()_G[e:GetName().."_UnlearnTex"]:SetAllPoints()_G[e:GetName().."_UnlearnTex"]:SetSize(e:GetSize())_G[e:GetName().."_UnlearnTex"]:SetPoint("CENTER",0,0)_G[e:GetName().."_UnlearnTex"]:SetTexture("Interface\\Icons\\inv_custom_scrollofunlearning")_G[e:GetName().."_UnlearnTex"]:Hide()e.UnlearnTex=_G[e:GetName().."_UnlearnTex"]end
for t,e in ipairs(o)do
e:SetSize(50,20)e:SetPoint("CENTER",0,-42)e:EnableMouse(true)e:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")e:SetScript("OnMouseUp",E)end
for e,t in ipairs(H)do
t:SetAllPoints(o[e])o[e]:SetText(GetLocalization(CLIENTEXTRABUTTONS_LEARNGRAY2))o[e]:SetNormalTexture(t)end
for t,e in ipairs(K)do
e:SetFont("Fonts\\MORPHEUS.TTF",15,"OUTLINE")e:SetShadowOffset(1,-1)o[t]:SetFontString(e)o[t]:SetText(GetLocalization(CLIENTEXTRABUTTONS_LEARNNORMAL))end
for t,e in ipairs(u)do
e:SetSize(16,16)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_fn",insets={left=-7,right=-7,top=-7,bottom=-7}})e:EnableMouse(false)e:SetPoint("BOTTOMRIGHT",2,-1)end
for t,e in ipairs(q)do
e:SetFont("Fonts\\FRIZQT__.ttf",13)e:SetPoint("CENTER",0,-1)e:SetShadowOffset(1,1)u[t]:SetFontString(e)u[t]:SetText(" ")end
TrainingFrameDialog=CreateFrame("Frame","TrainingFrameDialog",TrainingFrameBorder,nil)TrainingFrameDialog:ClearAllPoints()TrainingFrameDialog:SetBackdrop(StaticPopup1:GetBackdrop())TrainingFrameDialog:SetHeight(115)TrainingFrameDialog:SetWidth(390)TrainingFrameDialog:SetPoint("CENTER",e,0,0)TrainingFrameDialog:Hide()TrainingFrameDialog.text=TrainingFrameDialog:CreateFontString(nil,"BACKGROUND","GameFontHighlight")TrainingFrameDialog.text:SetFont("Fonts\\FRIZQT__.TTF",11)TrainingFrameDialog.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_UNLEARNABILITYDIALOG))TrainingFrameDialog.text:SetPoint("TOP",0,-20)TrainingFrameDialog.Alert=TrainingFrameDialog:CreateTexture("TrainingFrameDialog.Alert")TrainingFrameDialog.Alert:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")TrainingFrameDialog.Alert:SetSize(48,48)TrainingFrameDialog.Alert:SetPoint("LEFT",24,0)TrainingFrameDialog.Yes=CreateFrame("Button",nil,TrainingFrameDialog,"StaticPopupButtonTemplate")TrainingFrameDialog.Yes:SetWidth(110)TrainingFrameDialog.Yes:SetHeight(19)TrainingFrameDialog.Yes:SetPoint("BOTTOM",-60,15)TrainingFrameDialog.Yes:SetScript("OnClick",function(t)if(t.Type=="Spell")then
if(d or L)then
else
end
elseif(t.Type=="Talent")then
elseif(t.Type=="SwitchSpec")then
SwitchSpecMainFrame:Hide()e:Hide()end
TrainingFrameDialog:Hide()end)TrainingFrameDialog.No=CreateFrame("Button",nil,TrainingFrameDialog,"StaticPopupButtonTemplate")TrainingFrameDialog.No:SetWidth(110)TrainingFrameDialog.No:SetHeight(19)TrainingFrameDialog.No:SetPoint("BOTTOM",60,15)TrainingFrameDialog.No:SetScript("OnClick",function()TrainingFrameDialog:Hide()end)TrainingFrameDialog.Yes.text=TrainingFrameDialog.Yes:CreateFontString(nil,"BACKGROUND","GameFontNormal")TrainingFrameDialog.Yes.text:SetFont("Fonts\\FRIZQT__.TTF",11)TrainingFrameDialog.Yes.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_ACCEPT))TrainingFrameDialog.Yes.text:SetPoint("CENTER",0,1)TrainingFrameDialog.No.text=TrainingFrameDialog.No:CreateFontString(nil,"BACKGROUND","GameFontNormal")TrainingFrameDialog.No.text:SetFont("Fonts\\FRIZQT__.TTF",11)TrainingFrameDialog.No.text:SetText(GetLocalization(CLIENTEXTRABUTTONS_CANCEL))TrainingFrameDialog.No.text:SetPoint("CENTER",0,1)TrainingFrameDialog.Yes:SetFontString(TrainingFrameDialog.Yes.text)TrainingFrameDialog.No:SetFontString(TrainingFrameDialog.No.text)TrainingFrameDialog:SetScript("OnShow",function(e)PlaySound("igMainMenuOpen")end)TrainingFrameDialog:SetScript("OnHide",function(e)PlaySound("igMainMenuClose")end)local t=CreateFrame("FRAME","LoadBuildFromLinkFrame",TrainingFrameBorder)t:SetSize(e:GetSize())t:SetPoint("CENTER",0,0)t:SetFrameLevel(0)local e=t:CreateTexture("ProgressionLoadBuildFromLinkBG","BACKGROUND")e:SetAllPoints()e:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_BuildFromLinkBG")e:Hide()local e=t:CreateTexture("ProgressionLoadBuildFromLinkBG_border","BORDER")e:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_BuildFromLink")e:SetSize(1024,1024)e:SetPoint("CENTER",-10,70)local e=CreateFrame("Button","LoadBuildFromLinkFrame_CloseButton",t,"UIPanelCloseButton")e:SetPoint("BOTTOM",155,60)e:EnableMouse(true)e:SetSize(31,31)e:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
p()end
end)e:Hide()e:Disable()t.LoadButton=CreateFrame("Button","LoadBuildFromLinkFrameLoadButton",t,"StaticPopupButtonTemplate")t.LoadButton:SetPoint("BOTTOM",-26,65)t.LoadButton:EnableMouse(true)t.LoadButton:SetWidth(79)t.LoadButton:SetHeight(20)t.LoadButton:SetText("Load Build")t.LoadButton:SetScript("OnClick",function()PlaySound("igMainMenuOptionCheckBoxOn")CountBuildByLink(t.SearchBox)end)t.ActivateButton=CreateFrame("Button","LoadBuildFromLinkFrameActivateButton",t,"StaticPopupButtonTemplate")t.ActivateButton:SetPoint("BOTTOM",-26,65)t.ActivateButton:EnableMouse(true)t.ActivateButton:SetWidth(79)t.ActivateButton:SetHeight(20)t.ActivateButton:SetText("Activate")t.ActivateButton:SetScript("OnClick",ae)t.ActivateButton:Hide()t.ClearnButton=CreateFrame("Button","LoadBuildFromLinkFrameClearnButton",t,"StaticPopupButtonTemplate")t.ClearnButton:SetPoint("BOTTOM",53,65)t.ClearnButton:EnableMouse(true)t.ClearnButton:SetWidth(79)t.ClearnButton:SetHeight(20)t.ClearnButton:SetText("Clear")t.ClearnButton:SetScript("OnClick",function()PlaySound("igMainMenuOptionCheckBoxOn")p()end)t.ClearnButton:Hide()t.GenerateButton=CreateFrame("Button","LoadBuildFromLinkFrameClearnButton",t,"StaticPopupButtonTemplate")t.GenerateButton:SetPoint("BOTTOM",53,65)t.GenerateButton:EnableMouse(true)t.GenerateButton:SetWidth(79)t.GenerateButton:SetHeight(20)t.GenerateButton:SetText("Generate")t.GenerateButton:SetScript("OnClick",function()PlaySound("igMainMenuOptionCheckBoxOn")U(false)end)t.GenerateButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFClick to generate your current build link")GameTooltip:AddLine("Share your current abilities and talents with your friends")GameTooltip:Show()end)t.GenerateButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)t.SearchBox=CreateFrame("EditBox","LoadBuildFromLinkFrameSearchBox",t,"InputBoxTemplate")t.SearchBox:SetWidth(270)t.SearchBox:SetHeight(26)t.SearchBox:SetFontObject(GameFontNormal)t.SearchBox:SetPoint("BOTTOM",t,-205,62)t.SearchBox:ClearFocus(self)t.SearchBox:SetAutoFocus(false)t.SearchBox:SetFontObject(GameFontDisable)t.SearchBox:SetScript("OnEnterPressed",CountBuildByLink)t.SearchBox:SetText("Search")t.SearchBox:SetScript("OnEscapePressed",function(e)local t=e:GetText()if not(t)or(t=="")then
e:ClearFocus(e)e:SetText("Enter Link")return false
end
e:ClearFocus(e)end)t.SearchBox:SetText("Enter Link")t.SkillsFrame=CreateFrame("FRAME","LoadBuildFromLinkFrameSkillsFrame",t)t.SkillsFrame:SetPoint("CENTER",-118,-15)t.SkillsFrame:SetSize(575,659)t.SkillsFrame:EnableMouse(true)t.SkillsFrame:Hide()for e=1,14 do
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]=CreateFrame("FRAME","LoadBuildFromLinkFrameSkillsFrameSpell"..e,t.SkillsFrame)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetSize(256,64)if(e<=7)then
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetPoint("CENTER",-150,250-80*(e-1))else
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetPoint("CENTER",150,250-80*(e-8))end
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetScript("OnEnter",function(e)if(e.Spell)then
local t=GetSpellInfo(e.Spell)local t="|cff71d5ff|Hspell:"..e.Spell.."|h["..t.."]|h|r"GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(t)GameTooltip:AddLine("|cffFF0000Click on this spell to remove it from list|r")GameTooltip:Show()end
end)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetScript("OnLeave",function(e)GameTooltip:Hide()end)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:SetScript("OnMouseDown",function(e)if(e.Spell)then
PlaySound("igQuestCancel")if(e.TalentID)then
a[e.TalentID]=nil
else
s[e.Spell]=nil
end
local t=next(s)local l=next(a)if not(t)and not(l)then
p()else
C=h
if not(e.Known)then
A=A-e.AE
g=g-e.TE
end
v()X(s,a)U(true)end
end
end)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:EnableMouse(true)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Spell=nil
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Known=nil
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].IsTalentTalentRank=nil
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].BuildName="Shaman"_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Icon="Interface\\Icons\\INV_Chest_Samurai"_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SpellName="SpellName"_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].ReqLevel=nil
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].AE=0
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].TE=0
_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."Texture","BACKGROUND")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG:SetTexture("Interface\\LevelUp\\LevelUpTex")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG:SetSize(223,115)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG:SetPoint("TOP",0,43)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG:SetTexCoord(.56054688,.99609375,.2421875,.46679688)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG:SetVertexColor(1,1,1,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."Texture","BACKGROUND",nil,2)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture:SetTexture("Interface\\LevelUp\\LevelUpTex")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture:SetSize(284,115)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture:SetPoint("TOP",0,50)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture:SetTexCoord(.00195313,.63867188,.03710938,.23828125)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].Texture:SetVertexColor(1,1,1,.6)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."Texture","BORDER",nil,2)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetTexture("Interface\\LevelUp\\LevelUpTex")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetSize(280,7)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetPoint("TOP")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetTexCoord(.00195313,.81835938,.01953125,.03320313)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:SetVertexColor(1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."Texture","BORDER",nil,2)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetTexture("Interface\\LevelUp\\LevelUpTex")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetSize(280,7)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetPoint("BOTTOM")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetTexCoord(.00195313,.81835938,.01953125,.03320313)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:SetVertexColor(1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp:CreateAnimationGroup()_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup:CreateAnimation("Scale")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetScale(.001,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetDuration(0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetStartDelay(0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetOrder(1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup:CreateAnimation("Scale")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetScale(1e3,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetDuration(.3)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetOrder(2)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown:CreateAnimationGroup()_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup:CreateAnimation("Scale")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetScale(.001,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetDuration(0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetStartDelay(0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetOrder(1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup:CreateAnimation("Scale")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetScale(1e3,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetDuration(.3)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetOrder(2)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineDown.AnimationGroup.Grow:SetScript("OnPlay",function()_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].LineUp.AnimationGroup:Play();end)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame=CreateFrame("Frame","LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrame",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e])_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:SetPoint("BOTTOM",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].GoldBG,"BOTTOM",0,5)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:SetSize(418,72)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:SetFrameLevel(4)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIconBG","BACKGROUND")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetSize(70,70)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SpellKit\\AbilityMaxHighlight")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetPoint("CENTER",-90,-4)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBG:SetBlendMode("ADD")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIcon1","BACKGROUND")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1:SetSize(36,36)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1:SetTexture("Interface\\Icons\\INV_Chest_Samurai")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1:SetPoint("CENTER",-90,-4)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIconBorder","BORDER")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder:SetSize(54,54)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder:SetTexture("Interface\\Addons\\AwAddons\\Textures\\Collections\\StoreCollectionRound")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconBorder:SetPoint("CENTER",-90,-4)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateFontString("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIcon1Name","OVERLAY")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetFontObject(GameFontNormalLarge)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetPoint("BOTTOMLEFT",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1,"BOTTOMRIGHT",10,4)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetShadowOffset(0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SpellName)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetSize(190,16)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetJustifyH("LEFT")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name:SetVertexColor(1,1,1)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateFontString("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIcon1SubText","OVERLAY")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetFontObject(GameFontNormal)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetPoint("BOTTOMLEFT",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1Name,"TOPLEFT",0,3)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetShadowOffset(0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetText(_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].BuildName)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1SubText:SetJustifyH("LEFT")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateTexture("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameLevelUpIcon1Book","ARTWORK",nil,3)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_fn")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon:SetSize(30,30)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.LevelReqIcon:SetPoint("BOTTOMLEFT",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1,-8,-10)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText=_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame:CreateFontString("LoadBuildFromLinkFrame.SkillsFrame.Spell"..e.."SkillFrameIconIconLevelReqText","OVERLAY")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetFontObject(GameFontHighlightSmall)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetPoint("BOTTOMLEFT",_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.Icon1,0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetShadowOffset(0,0)_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetText("60")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e].SkillFrame.IconLevelReqText:SetJustifyH("LEFT")_G["LoadBuildFromLinkFrame.SkillsFrame.Spell"..e]:Hide()end
t.SkillsFrame.PageText=t.SkillsFrame:CreateFontString("LoadBuildFromLinkFrameSkillsFramePageText")t.SkillsFrame.PageText:SetFontObject(GameFontHighlight)t.SkillsFrame.PageText:SetPoint("BOTTOM",0,28)t.SkillsFrame.PageText:SetShadowOffset(0,-1)t.SkillsFrame.PageText:SetText("Page 1/1")t.SkillsFrame.RequiredLevelText=t.SkillsFrame:CreateFontString("LoadBuildFromLinkFrameSkillsFrameRequiredLevelText")t.SkillsFrame.RequiredLevelText:SetFontObject(GameFontNormal)t.SkillsFrame.RequiredLevelText:SetPoint("BOTTOMRIGHT",-30,28)t.SkillsFrame.RequiredLevelText:SetShadowOffset(0,-1)t.SkillsFrame.RequiredLevelText:SetText("Required level: |cffFFFFFF60|r")t.SkillsFrame.BalanceText=t.SkillsFrame:CreateFontString("LoadBuildFromLinkFrameSkillsFrameBalanceText")t.SkillsFrame.BalanceText:SetFontObject(GameFontNormal)t.SkillsFrame.BalanceText:SetPoint("BOTTOMLEFT",30,28)t.SkillsFrame.BalanceText:SetShadowOffset(0,-1)t.SkillsFrame.BalanceText:SetText("5 |TInterface\\Icons\\inv_custom_abilityessence.blp:13:13|t 10 |TInterface\\Icons\\inv_custom_talentessence.blp:13:13|t ")t.SkillsFrame.BackgroundTexture=t.SkillsFrame:CreateTexture(nil,"BACKGROUND")t.SkillsFrame.BackgroundTexture:SetSize(110,55)t.SkillsFrame.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\main_b")t.SkillsFrame.BackgroundTexture:SetPoint("BOTTOM",t.SkillsFrame,0,8)t.SkillsFrame.NextButton=CreateFrame("Button","LoadBuildFromLinkFrame.SkillsFrame.NextButton",t.SkillsFrame,nil)t.SkillsFrame.NextButton:SetSize(26,26)t.SkillsFrame.NextButton:SetPoint("BOTTOM",70,25)t.SkillsFrame.NextButton:EnableMouse(true)t.SkillsFrame.NextButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")t.SkillsFrame.NextButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")t.SkillsFrame.NextButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")t.SkillsFrame.NextButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")t.SkillsFrame.NextButton:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
N(h+1)end
end)t.SkillsFrame.NextButton:Disable()t.SkillsFrame.PrevButton=CreateFrame("Button","LoadBuildFromLinkFrame.SkillsFrame.PrevButton",t.SkillsFrame,nil)t.SkillsFrame.PrevButton:SetSize(26,26)t.SkillsFrame.PrevButton:SetPoint("BOTTOM",-70,25)t.SkillsFrame.PrevButton:EnableMouse(true)t.SkillsFrame.PrevButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")t.SkillsFrame.PrevButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")t.SkillsFrame.PrevButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")t.SkillsFrame.PrevButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")t.SkillsFrame.PrevButton:SetScript("OnClick",function(e)if(e:IsEnabled()==1)then
N(h-1)end
end)t.SkillsFrame.PrevButton:Disable()StaticPopup1:SetFrameStrata("FULLSCREEN_DIALOG")local e=CreateFrame("FRAME","ResetAccessFrame",TrainingFrameBorder)e:SetSize(256,32)e:SetPoint("BOTTOM",-118,48)e:SetFrameLevel(5)e:Hide()local t=e:CreateTexture("ProgressionResetAccessBG","BORDER")t:SetAllPoints()t:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\Enchant_RefundButton")e.MainButton=CreateFrame("Button","ResetAccessFrameMainButton",e,"StaticPopupButtonTemplate")e.MainButton:SetPoint("CENTER",1,1)e.MainButton:EnableMouse(true)e.MainButton:SetWidth(148)e.MainButton:SetHeight(19)e.MainButton:SetText("Reset Spells")e.MainButton:SetScript("OnLeave",function()GameTooltip:Hide()end)