Ulocal o=AIO or require("AIO")if o.AddAddon()then
return
end
local function H(e)local t=e:GetText()if not(t)or(t=="")then
e:SetText(SEARCH)end
e:ClearFocus(e)end
local C=o.AddHandlers("BuildCreator",{})local s={}local T=nil
local F={}local S={}local I=18
local c=70
local a={[1]=2,[100]=3,[500]=4,[1e3]=5,}local u={{"Strength","Interface\\Icons\\spell_holy_sealofwrath",1},{"Agility","Interface\\Icons\\ability_rogue_sprint",3},{"Intellect","Interface\\Icons\\spell_holy_magicalsentry",4},{"Spirit","Interface\\Icons\\spell_holy_sealofwisdom",5},}local n={MSG_STAT_FORMAT="Primary stat: %s",MSG_RATING="Rating: %s%d|r",MSG_AUTHOR="Author: |cffFFFFFF%s|r",MSG_TOOLTIP_PREVIEW="|cffFFFFFFPreview build %s",MSG_TOOLTIP_PREVIEW_TEXT="%s\n\n|cffFFFFFFSHIFT|r + |cffFFFFFFClick|r to insert link to chat",MSG_TOOLTIP_RATING_TITLE="|cffFFFFFFBuild rating is: |cff00FF00%d|r",MSG_TOOLTIP_RATING_TEXT="You can click the button to rate build.",MSG_SEARCH_DEFAULT="Enter build name here",MSG_DESCRIPTION_DEFAULT="There is no description yet.",MSG_REQUIRED_LEVEL="Required level: |cffFFFFFF%d|r",}local r={"C79C6E","F58CBA","ABD473","FFF569","FFFFFF","C41F3B","0070DE","69CCF0","9482C9",nil,"FF7D0A"}local R={"DRUIDBALANCE","DRUIDFERAL","DRUIDRESTORATION","HUNTERBEASTMASTERY","HUNTERMARKSMANSHIP","HUNTERSURVIVAL","MAGEARCANE","MAGEFIRE","MAGEFROST","PALADINHOLY","PALADINPROTECTION","PALADINRETRIBUTION","PRIESTDISCIPLINE","PRIESTHOLY","PRIESTSHADOW","ROGUEASSASSINATION","ROGUECOMBAT","ROGUESUBTLETY","SHAMANELEMENTAL","SHAMANENHANCEMENT","SHAMANRESTORATION","WARLOCKAFFLICTION","WARLOCKDEMONOLOGY","WARLOCKDESTRUCTION","WARRIORARMS","WARRIORFURY","WARRIORPROTECTION"}local h={["DRUIDBALANCE"]={name="|cff"..r[11].."Balance Druid|r",color={1,.49,.04,1},classID=11,iconSpellID=16821,},["DRUIDFERAL"]={name="|cff"..r[11].."Feral Druid|r",color={1,.49,.04,1},classID=11,iconSpellID=5487,},["DRUIDRESTORATION"]={name="|cff"..r[11].."Restoration Druid|r",color={1,.49,.04,1},classID=11,iconSpellID=5185,},["HUNTERBEASTMASTERY"]={name="|cff"..r[3].."Beast Mastery Hunter|r",color={.67,.83,.45,1},classID=3,iconSpellID=965200,},["HUNTERMARKSMANSHIP"]={name="|cff"..r[3].."Marksmanship Hunter|r",color={.67,.83,.45,1},classID=3,iconSpellID=1510,},["HUNTERSURVIVAL"]={name="|cff"..r[3].."Survival Hunter|r",color={.67,.83,.45,1},classID=3,iconSpellID=1495,},["MAGEARCANE"]={name="|cff"..r[8].."Arcane Mage|r",color={.41,.8,.94,1},classID=8,iconSpellID=1459,},["MAGEFIRE"]={name="|cff"..r[8].."Fire Mage|r",color={.41,.8,.94,1},classID=8,iconSpellID=133,},["MAGEFROST"]={name="|cff"..r[8].."Frost Mage|r",color={.41,.8,.94,1},classID=8,iconSpellID=116,},["PALADINHOLY"]={name="|cff"..r[2].."Holy Paladin|r",color={.96,.55,.73,1},classID=2,iconSpellID=635,},["PALADINPROTECTION"]={name="|cff"..r[2].."Protection Paladin|r",color={.96,.55,.73,1},classID=2,iconSpellID=465,},["PALADINRETRIBUTION"]={name="|cff"..r[2].."Retribution Paladin|r",color={.96,.55,.73,1},classID=2,iconSpellID=7294,},["PRIESTDISCIPLINE"]={name="|cff"..r[5].."Discipline Priest|r",color={1,1,1,1},classID=5,iconSpellID=1243,},["PRIESTHOLY"]={name="|cff"..r[5].."Holy Priest|r",color={1,1,1,1},classID=5,iconSpellID=635,},["PRIESTSHADOW"]={name="|cff"..r[5].."Shadow Priest|r",color={1,1,1,1},classID=5,iconSpellID=589,},["ROGUEASSASSINATION"]={name="|cff"..r[4].."Assassination Rogue|r",color={1,.96,.41,1},classID=4,iconSpellID=12320,},["ROGUECOMBAT"]={name="|cff"..r[4].."Combat Rogue|r",color={1,.96,.41,1},classID=4,iconSpellID=53,},["ROGUESUBTLETY"]={name="|cff"..r[4].."Subtlety Rogue|r",color={1,.96,.41,1},classID=4,iconSpellID=1784,},["SHAMANELEMENTAL"]={name="|cff"..r[7].."Elemental Shaman|r",color={0,.44,.87,1},classID=7,iconSpellID=403,},["SHAMANENHANCEMENT"]={name="|cff"..r[7].."Enhancement Shaman|r",color={0,.44,.87,1},classID=7,iconSpellID=324,},["SHAMANRESTORATION"]={name="|cff"..r[7].."Restoration Shaman|r",color={0,.44,.87,1},classID=7,iconSpellID=331,},["WARLOCKAFFLICTION"]={name="|cff"..r[9].."Affliction Warlock|r",color={.58,.51,.79,1},classID=9,iconSpellID=6789,},["WARLOCKDEMONOLOGY"]={name="|cff"..r[9].."Demonology Warlock|r",color={.58,.51,.79,1},classID=9,iconSpellID=5500,},["WARLOCKDESTRUCTION"]={name="|cff"..r[9].."Destruction Warlock|r",color={.58,.51,.79,1},classID=9,iconSpellID=5740,},["WARRIORARMS"]={name="|cff"..r[1].."Arms Warrior|r",color={.78,.61,.43,1},classID=1,iconSpellID=12320,},["WARRIORFURY"]={name="|cff"..r[1].."Fury Warrior|r",color={.78,.61,.43,1},classID=1,iconSpellID=1834,},["WARRIORPROTECTION"]={name="|cff"..r[1].."Protection Warrior|r",color={.78,.61,.43,1},classID=1,iconSpellID=12298,},}local v={"Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewEpic","Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewGreen","Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewBlue","Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewEpic","Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewLeg",}local e={1180,15590,196,198,201,200,227,197,199,202,264,5011,266,2567,5009,750,8737,9077,9078,9116,27763,27762,}local A=#e
local M=400
local t={[1]={9,0}}for e=1,9 do
t[e]={9,0}end
for e=10,c do
local o,r=unpack(t[e-1])t[e]={o+1,r+1}end
local l={}local function G()local e={}e.spells={}e.info={0,0,UnitName("player"),"Build Name","by "..UnitName("player")}e.stat={0,0,0,0,0}e.description=n.MSG_DESCRIPTION_DEFAULT
e.editable=false
e.currency={}e.tips={}e.levelingSpells={}e.armourSpells={}e.enchantSpells={}e.old=0
e.isMaxLevel=false
e.maxLevel=1
for t,r in pairs(t)do
e.currency[t]={unpack(r)}end
function e:HandleTime(t,e)self.old=math.floor((t-e)/86400)end
function e:HandleSpells()local r=0
for t,e in pairs(self.spells)do
local o=e[2]local a=e[3]local e=e[1]if(o==2)then
table.insert(self.armourSpells,t)elseif(o==3)then
table.insert(self.enchantSpells,t)elseif(o==1)then
if not(self.levelingSpells[e])then
self.levelingSpells[e]={}if(self.maxLevel<e)then
self.maxLevel=e
end
r=r+1
end
table.insert(self.levelingSpells[e],t)local t,r,o=CA_GetSpellInfo(t)for e=e,c do
self.currency[e][1]=self.currency[e][1]-t
self.currency[e][2]=self.currency[e][2]-r
end
end
if(SpellTip)and(SpellTip~="")then
self.tips[t]=SpellTip
end
end
if(r==1)then
self.isMaxLevel=true
end
end
return e
end
local function B(e,r,a)if r>a then
return
end
local t=r
for o=r+1,a do
if(e[o][4]>e[r][4])then
t=t+1
e[t],e[o]=e[o],e[t]end
end
e[t],e[r]=e[r],e[t]B(e,r,t-1)B(e,t+1,a)end
local function b(t)local r={}local e=t:GetText()if not(e)or(e=="")or(e:lower()==n.MSG_SEARCH_DEFAULT:lower())then
t:ClearFocus(t)t:SetText(n.MSG_SEARCH_DEFAULT)BuildCreator.BuildExplorer.HSBuilds.LoadData()BuildCreator.BuildExplorer.HSBuilds.RefreshLayout()BuildCreator.BuildExplorer:Show()BuildCreator.PreviewLeveling:Hide()BuildCreator.PreviewMax:Hide()return
end
e=e:lower()for o,t in pairs(S)do
local a=t[2]:lower()local o=t[3]:lower()if(string.find(a,e,1,true)or string.find(o,e,1,true))then
table.insert(r,{t[1],t[2],t[3],t[4]})end
end
B(r,1,#r)BuildCreator.BuildExplorer.HSBuilds.DisplaySearchResults(r)BuildCreator.BuildExplorer:Show()BuildCreator.PreviewLeveling:Hide()BuildCreator.PreviewMax:Hide()t:ClearFocus(t)end
local function P(e)HideCards()end
local function L(e)local e=e:GetParent().ID
if not(e)then
return false
end
o.Handle("BuildCreator","RateBuild",e)end
local function E(e)if(IsModifiedClick("CHATLINK"))then
ChatEdit_InsertLink("|cff00ff96|Hcabuild:"..e.ID.."|h["..e.Text:GetText().."]|h|r")return
end
o.Handle("BuildCreator","RequestBuildInfo",e.ID)end
local function g(r)local e=0
for t,o in pairs(a)do
if(r>=t)and(e<t)then
e=t
end
end
if(a[e])then
return a[e]else
return 1
end
end
local function o(e)if(e.highlight:IsVisible())then
e.highlight:Hide()else
e.highlight:Show()end
end
local function p(e)if(e.tooltipTitle)then
GameTooltip_SetDefaultAnchor(GameTooltip,e)GameTooltip:AddLine(e.tooltipTitle)GameTooltip:AddLine(e.tooltipText)GameTooltip:Show()end
end
local function O(t,r,e)local e=math.ceil(r/e)t:SetHeight(32+16+(26*e)+(16*e))end
local function x(r,o,e,t)e=e+1
if(e>r)then
e=1
t=t+1
end
return e,t
end
local function d(e,t)local e=CreateFrame("CheckButton",t,e,nil)e:SetSize(148,32)e:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")e:GetHighlightTexture():SetPoint("TOPLEFT",3,5,"BOTTOMRIGHT",-3,0)e:SetDisabledTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")e:SetNormalFontObject(GameFontNormalSmall)e:SetHighlightFontObject(GameFontHighlightSmall)e:SetDisabledFontObject(GameFontHighlightSmall)e:SetText("Character\nAdvancement")e:GetFontString():SetPoint("CENTER",0,4)e:Disable()e.BG=e:CreateTexture(nil,"BACKGROUND")e.BG:SetTexture("Interface\\PaperDollInfoFrame\\UI-CHARACTER-INACTIVETAB")e.BG:SetSize(148,31)e.BG:SetPoint("CENTER",0,0)e.Icon=e:CreateTexture(nil,"OVERLAY")e.Icon:SetSize(16,16)e.Icon:SetTexture("Interface\\icons\\INV_Misc_Book_07")return e
end
local function m(t,e)local e=CreateFrame("BUTTON",e,t)e:SetSize(248,55)e.selected=false
e.highlight=e:CreateTexture(nil,"OVERLAY")e.highlight:SetSize(512,64)e.highlight:SetPoint("CENTER",0,0)e.highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\CategoryTabH")e.highlight:SetBlendMode("ADD")e.highlight:Hide()e.bg=e:CreateTexture(nil,"BACKGROUND")e.bg:SetSize(512,64)e.bg:SetPoint("CENTER",0,0)e.bg:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\CategoryTab")e.icon=e:CreateTexture(nil,"BORDER")e.icon:SetSize(36,36)e.icon:SetPoint("LEFT",9,0)SetPortraitToTexture(e.icon,"Interface\\Icons\\inv_custom_trainerBook")e.iconBorder=e:CreateTexture(nil,"ARTWORK")e.iconBorder:SetSize(70,70)e.iconBorder:SetPoint("LEFT",-8,0)e.iconBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\BlueMenuRing")e.text=e:CreateFontString(nil,"ARTWORK")e.text:SetJustifyH("LEFT")e.text:SetPoint("LEFT",e.icon,"RIGHT",12,0)e.text:SetFontObject(GameFontNormal)e.text:SetText("Category Name")e:SetScript("OnEnter",function(e)if not(e.highlight:IsVisible())then
e.highlight:Show()e.text:SetFontObject(GameFontHighlight)end
end)e:SetScript("OnLeave",function(e)if not(e.selected)then
e.highlight:Hide()e.text:SetFontObject(GameFontNormal)end
end)e:SetScript("OnMouseUp",function(t)for r,e in pairs(s)do
if(e~=t)then
e.highlight:Hide()e.selected=false
e.text:SetFontObject(GameFontNormal)end
end
t.text:SetPoint("LEFT",e.icon,"RIGHT",12,0)t.selected=not(t.selected)if not(t.selected)and(T==t)then
t.selected=true
else
T=t
t.highlight:Show()t.text:SetFontObject(GameFontHighlight)end
end)e:SetScript("OnMouseDown",function(t)t.text:SetPoint("LEFT",e.icon,"RIGHT",14,-2)end)table.insert(s,e)return e
end
local function f(t,e)local e=CreateFrame("BUTTON",e,t,nil)e:SetSize(128,32)e.highlight=e:CreateTexture(nil,"OVERLAY")e.highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_highlight")e.highlight:SetSize(48,48)e.highlight:SetPoint("LEFT",-7,0)e.highlight:SetBlendMode("ADD")e.highlight:Hide()e.iconBorder=e:CreateTexture(nil,"BORDER")e.iconBorder:SetSize(48,48)e.iconBorder:SetPoint("LEFT",-8,0)e.iconBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\StatBorder")e.icon=e:CreateTexture(nil,"BACKGROUND")e.icon:SetSize(24,24)e.icon:SetPoint("LEFT",4,0)SetPortraitToTexture(e.icon,"Interface\\Icons\\ability_rogue_sprint")e.titleText=e:CreateFontString(nil,"ARTWORK")e.titleText:SetFontObject(GameFontNormal)e.titleText:SetShadowOffset(0,0)e.titleText:SetText("Primary stat: Agility")e.titleText:SetJustifyH("LEFT")e.titleText:SetPoint("LEFT",e.iconBorder,"RIGHT",0,0)e.titleText:SetVertexColor(.2,.1,0,1)e:SetScript("OnEnter",o)e:SetScript("OnLeave",o)return e
end
local function a(e,t)local e=f(e,t)e.icon:SetVertexColor(0,0,0,1)e.titleText:Hide()e.activeText=e:CreateFontString(nil,"ARTWORK")e.activeText:SetFontObject(GameFontGreen)e.activeText:SetText("Active build")e.activeText:SetJustifyH("LEFT")e.activeText:SetPoint("LEFT",e.iconBorder,"RIGHT",0,0)e.activeTex=e:CreateTexture(nil,"ARTWORK")e.activeTex:SetSize(40,40)e.activeTex:SetPoint("LEFT",-1,2)e.activeTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\GreenCheckMark")e.activeTexH=e:CreateTexture(nil,"OVERLAY")e.activeTexH:SetSize(40,40)e.activeTexH:SetPoint("LEFT",-1,2)e.activeTexH:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\GreenCheckMark")e.activeTexH:SetAlpha(.5)e.activeTexH:SetBlendMode("ADD")e.activeTexH:Hide()e:SetScript("OnEnter",function(e)e.activeTexH:Show()o(e)end)e:SetScript("OnLeave",function(e)e.activeTexH:Hide()o(e)end)return e
end
local function N(e,t)local e=CreateFrame("BUTTON",t,e)e:SetSize(40,40)e.bg=e:CreateTexture(nil,"BACKGROUND")e.bg:SetSize(85,90)e.bg:SetPoint("CENTER",-4,0)e.bg:SetTexture("Interface\\LFGFrame\\UI-LFG-ICONS-ROLEBACKGROUNDS")e.bg:SetTexCoord(_G.LFDQueueFrameRoleButtonTank.background:GetTexCoord())e.bg:SetAlpha(.8)e.iconBorder=e:CreateTexture(nil,"ARTWORK")e.iconBorder:SetSize(64,64)e.iconBorder:SetPoint("CENTER",-1,-1)e.iconBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\SquareBorder")e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e.icon=e:CreateTexture(nil,"BORDER")e.icon:SetSize(40,40)e.icon:SetPoint("CENTER",-1,-1)e.icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\tankRole")return e
end
local function T(t,e)local e=CreateFrame("BUTTON",e,t)e:SetSize(32,24)e:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\friendship-heart")e:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\friendship-heart")e:SetScript("OnEnter",function(e)p(e)end)e:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e:SetScript("OnClick",function(e)L(e:GetParent())end)return e
end
local function s(e,t)local e=CreateFrame("BUTTON",t,e)e:SetSize(756,119)e.bg=e:CreateTexture(nil,"BACKGROUND")e.bg:SetSize(1024,256)e.bg:SetPoint("CENTER",0,0)e.bg:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\buildPreviewTabSmall")e.qualityBorder=e:CreateTexture(nil,"BORDER")e.qualityBorder:SetSize(1024,256)e.qualityBorder:SetPoint("CENTER",0,0)e.qualityBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\buildPreviewTabSmallBorder")e.highlight=e:CreateTexture(nil,"OVERLAY")e.highlight:SetSize(1024,256)e.highlight:SetPoint("CENTER",0,0)e.highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\buildPreviewTabSmallH")e.highlight:SetBlendMode("ADD")e.highlight:Hide()e:SetScript("OnEnter",function(e)o(e)p(e)end)e:SetScript("OnLeave",function(e)o(e)GameTooltip:Hide()end)e:SetScript("OnClick",E)e.activateButton=CreateFrame("Button",t..".activateButton",e,"StaticPopupButtonTemplate")e.activateButton:SetWidth(185)e.activateButton:SetPoint("BOTTOMRIGHT",-4.5,18)e.activateButton:SetText("Choose this build")e.iconBorder=e:CreateTexture(nil,"ARTWORK")e.iconBorder:SetSize(95,95)e.iconBorder:SetPoint("TOPLEFT",-2,7)e.iconBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\MainBorder")e.icon=e:CreateTexture(nil,"BORDER")e.icon:SetSize(48,48)e.icon:SetPoint("TOPLEFT",22,-17)SetPortraitToTexture(e.icon,"Interface\\Icons\\newplayerhelp_newcomer")e.titleText=e:CreateFontString(nil,"ARTWORK")e.titleText:SetFontObject(GameFontNormalLarge)e.titleText:SetShadowOffset(0,0)e.titleText:SetText("Build name goes here")e.titleText:SetJustifyH("LEFT")e.titleText:SetPoint("LEFT",e.icon,"TOPRIGHT",16,-8)e.titleText:SetVertexColor(.2,.1,0,.9)e.bottomFrame=CreateFrame("BUTTON",t..".bottomFrame",e)e.bottomFrame:SetPoint("BOTTOMLEFT",5,17)e.bottomFrame:SetHeight(e.activateButton:GetHeight()+2)e.bottomFrame:SetWidth(561)e.bottomFrame:EnableMouse(false)e.bottomFrame.ratingText=e.bottomFrame:CreateFontString(nil,"ARTWORK")e.bottomFrame.ratingText:SetFontObject(GameFontNormal)e.bottomFrame.ratingText:SetPoint("LEFT",8,0)e.bottomFrame.ratingText:SetText("Rating: |cffFFFFFF12345")e.bottomFrame.ratingText:SetJustifyH("LEFT")e.bottomFrame.ratingButton=T(e.bottomFrame,"BUTTON",t..".bottomFrame.ratingButton")e.bottomFrame.ratingButton:SetPoint("LEFT",e.bottomFrame.ratingText,"RIGHT",0,-2)e.bottomFrame.authorText=e.bottomFrame:CreateFontString(nil,"ARTWORK")e.bottomFrame.authorText:SetFontObject(GameFontNormal)e.bottomFrame.authorText:SetPoint("LEFT",e.bottomFrame.ratingButton,"RIGHT",8,2)e.bottomFrame.authorText:SetText("Author: |cffFFFFFF12345")e.bottomFrame.authorText:SetJustifyH("LEFT")e.statFrame=f(e,t..".statFrame")e.statFrame:SetPoint("TOPLEFT",e.titleText,"BOTTOMLEFT",0,-6)e.roleFrame=N(e,t..".roleFrame")e.roleFrame:SetPoint("TOPRIGHT",-22,-22)e.activeButton=a(e,t..".activeButton")e.activeButton:SetPoint("LEFT",e.statFrame.titleText,"RIGHT",12,0)e.activeButton:Hide()function e:SetQuality(t)local o,t,r=GetItemQualityColor(t)e.qualityBorder:SetVertexColor(o,t,r)end
function e:SetText(t)e.titleText:SetText(t)end
function e:SetTexture(t)SetPortraitToTexture(e.icon,t)end
function e:SetStat(t)if not(u[t])then
print("|cffFF0000ERROR NO STAT "..t.." EXIST")t=1
end
local r=u[t][1]local t=u[t][2]e.statFrame.titleText:SetText(string.format(n.MSG_STAT_FORMAT,r))SetPortraitToTexture(e.statFrame.icon,t)end
function e:SetRating(t,r)local o,o,o,r=GetItemQualityColor(r)e.bottomFrame.ratingText:SetText(string.format(n.MSG_RATING,r,t))e.bottomFrame.ratingButton.tooltipTitle=string.format(n.MSG_TOOLTIP_RATING_TITLE,t)e.bottomFrame.ratingButton.tooltipText=n.MSG_TOOLTIP_RATING_TEXT
end
function e:SetAuthor(t)e.bottomFrame.authorText:SetText(string.format(n.MSG_AUTHOR,t))end
function e:SetTooltip(r,t)e.tooltipTitle=string.format(n.MSG_TOOLTIP_PREVIEW,r)e.tooltipText=string.format(n.MSG_TOOLTIP_PREVIEW_TEXT,t)end
function e:SetUpButton(t,a,n,r,l)local o=g(r)e:SetText(t)e.ID=n
e:SetQuality(o)e:SetRating(r,o)e:SetAuthor(l)e:SetTooltip(t,a)end
function e:Activate()e.activeButton:Show()end
function e:Deactivate()e.activeButton:Hide()end
return e
end
local function e(t,e)local e=s(t,e)e:SetSize(756,192)e.bg:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\buildPreviewTab")e.highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\buildPreviewTabH")e.activateButton:SetPoint("BOTTOMRIGHT",-4.5,6)e.qualityBorder:Hide()return e
end
local function o(t,e)local e=CreateFrame("BUTTON",e,t,nil)e:SetSize(26,26)e.icon=e:CreateTexture(nil,"BORDER")e.icon:SetSize(e:GetSize())e.icon:SetPoint("CENTER",0,0)e.icon:SetTexture("Interface\\Icons\\newplayerhelp_newcomer")e.slot=e:CreateTexture(nil,"BACKGROUND")e.slot:SetSize(48,48)e.slot:SetPoint("CENTER",0,0)e.slot:SetTexture("Interface\\Buttons\\UI-EmptySlot-White")e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")e.text=e:CreateFontString(nil,"ARTWORK")e.text:SetFontObject(GameFontNormal)e.text:SetPoint("LEFT",e,"RIGHT",8,0)e.text:SetJustifyH("LEFT")e.text:SetWidth(100)e.text:SetText("Text example goes here")function e:SetTexture(t)e.icon:SetTexture(t)end
function e:SetSpell(o,r,o,t)e:SetTexture(t)e.text:SetText(r)end
return e
end
local function E(e,t)local e=o(e,t)e:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")e.classBorder=e:CreateTexture(nil,"ARTWORK")e.classBorder:SetSize(48,48)e.classBorder:SetPoint("CENTER",-4,0)e.classBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\StatBorder")e.classBG=e:CreateTexture(nil,"ARTWORK")e.classBG:SetSize(250,130)e.classBG:SetPoint("CENTER",58,-17)e.classBG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\CardFrame\\RewardName_Highlight_Nocolor")e.classBG:SetBlendMode("ADD")e.text:SetWidth(116)function e:SetSpell(o,r,o,t)e:SetTexture(t)e.text:SetText(r)e.classBG:Hide()e.slot:Show()e.classBorder:Hide()e.icon:SetPoint("CENTER",0,0)e.text:SetPoint("LEFT",e,"RIGHT",8,0)end
function e:SetClass(o,r,t)e.slot:Hide()e.classBorder:Show()e.text:SetText(r)e.classBG:Show()e.classBG:SetVertexColor(unpack(t))SetPortraitToTexture(e.icon,o)e.icon:SetPoint("CENTER",-4,0)end
return e
end
local function a(e,t)local e=CreateFrame("FRAME",t,e,nil)e:SetSize(128,64)e.BackgroundTexture=e:CreateTexture(nil,"BORDER")e.BackgroundTexture:SetSize(31,31)e.BackgroundTexture:SetTexture("Interface\\Icons\\INV_Chest_Samurai")e.BackgroundTexture:SetPoint("LEFT",e,-1,0)SetPortraitToTexture(e.BackgroundTexture,"Interface\\Icons\\INV_Chest_Samurai")e.BG=e:CreateTexture(nil,"BACKGROUND")e.BG:SetSize(350,64)e.BG:SetTexture("Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\EBG")e.BG:SetPoint("CENTER",64,-8)e.Button=CreateFrame("Button",t..".Button",e,nil)e.Button:SetSize(200,32)e.Button:SetPoint("CENTER",32,0)e.Button:EnableMouse(true)e.IconBorder=e:CreateTexture(nil,"ARTWORK")e.IconBorder:SetSize(42,42)e.IconBorder:SetTexture("Interface\\Addons\\AwAddons\\Textures\\EnchOverhaul\\BorderNewGreen")e.IconBorder:SetPoint("LEFT",e,-7,0)e.IconHighlight=e:CreateTexture(nil,"OVERLAY")e.IconHighlight:SetSize(64,64)e.IconHighlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_highlight")e.IconHighlight:SetPoint("CENTER",e.IconBorder,0,0)e.IconHighlight:SetBlendMode("ADD")e.IconHighlight:Hide()e.Button.TextNormal=e.Button:CreateFontString(nil,"ARTWORK")e.Button.TextNormal:SetSize(175,32)e.Button.TextNormal:SetFont("Fonts\\FRIZQT__.TTF",11)e.Button.TextNormal:SetFontObject(GameFontNormal)e.Button.TextNormal:SetPoint("LEFT",e.IconBorder,"RIGHT",0,1)e.Button.TextNormal:SetShadowOffset(0,-1)e.Button.TextNormal:SetText("Enchant Effect Name Example Text Lol Kekxasdasd")e.Button.TextNormal:SetJustifyH("LEFT")function e:SetTexure(t)SetPortraitToTexture(e.BackgroundTexture,t)end
function e:SetText(t)e.Button.TextNormal:SetText(t)end
function e:SetQuality(t)e.IconBorder:SetTexture(v[t])end
function e:HandleEnchant(a,t,o)local r=2
t=string.match(t,"(%d+)")if(t)and(t~="")then
r=tonumber(t)end
e:SetText(a)e:SetTexure(o)e:SetQuality(r)end
return e
end
local function T(e,t)local e=CreateFrame("FRAME",t,e)e:SetSize(749,200)e.frameHeader=f(e,t..".frameHeader")e.frameHeader:SetPoint("TOPLEFT",e,"TOPLEFT",4,0)e.frameHeader.highlight:SetSize(64,64)e.frameHeader.iconBorder:SetSize(64,64)e.frameHeader.icon:SetSize(36,36)e.frameHeader.icon:SetPoint("LEFT",8,1)e.frameHeader.titleText:Hide()e.frameHeader.titleText=e.frameHeader:CreateFontString(nil,"ARTWORK")e.frameHeader.titleText:SetFontObject(GameFontHighlightLarge)e.frameHeader.titleText:SetText("Mystic Enchants")e.frameHeader.titleText:SetJustifyH("LEFT")e.frameHeader.titleText:SetPoint("LEFT",e.frameHeader.icon,"RIGHT",8,0)return e
end
local function L(e,t)local e=CreateFrame("FRAME",t,e)e:SetSize(749,412)e.requiredLeveltext=e:CreateFontString(nil,"ARTWORK")e.requiredLeveltext:SetFontObject(GameFontNormal)e.requiredLeveltext:SetPoint("TOP",0,-10)e.requiredLeveltext:SetJustifyH("CENTER")e.requiredLeveltext:SetText(n.MSG_REQUIRED_LEVEL)e.enchantsFrame=T(e,t..".enchantsFrame")e.enchantsFrame:SetPoint("TOP",e.requiredLeveltext,"BOTTOM",0,-10)e.enchantsFrame.enchants={}e.enchantsFrame.enchant1=a(e.enchantsFrame,t..".enchantsFrame.enchant1")e.enchantsFrame.enchant1:SetPoint("TOPLEFT",e.enchantsFrame.frameHeader.icon,"BOTTOMLEFT",32,0)e.enchantsFrame.enchant2=a(e.enchantsFrame,t..".enchantsFrame.enchant2")e.enchantsFrame.enchant2:SetPoint("LEFT",e.enchantsFrame.enchant1,"RIGHT",96,0)e.enchantsFrame.enchant3=a(e.enchantsFrame,t..".enchantsFrame.enchant3")e.enchantsFrame.enchant3:SetPoint("LEFT",e.enchantsFrame.enchant2,"RIGHT",96,0)e.enchantsFrame.enchant4=a(e.enchantsFrame,t..".enchantsFrame.enchant4")e.enchantsFrame.enchant4:SetPoint("TOP",e.enchantsFrame.enchant1,"BOTTOM",0,16)e.enchantsFrame.enchant5=a(e.enchantsFrame,t..".enchantsFrame.enchant5")e.enchantsFrame.enchant5:SetPoint("LEFT",e.enchantsFrame.enchant4,"RIGHT",96,0)e.enchantsFrame.enchant6=a(e.enchantsFrame,t..".enchantsFrame.enchant6")e.enchantsFrame.enchant6:SetPoint("LEFT",e.enchantsFrame.enchant5,"RIGHT",96,0)e.enchantsFrame.enchant7=a(e.enchantsFrame,t..".enchantsFrame.enchant7")e.enchantsFrame.enchant7:SetPoint("TOP",e.enchantsFrame.enchant4,"BOTTOM",0,16)e.enchantsFrame.enchant8=a(e.enchantsFrame,t..".enchantsFrame.enchant8")e.enchantsFrame.enchant8:SetPoint("LEFT",e.enchantsFrame.enchant7,"RIGHT",96,0)e.enchantsFrame.enchant9=a(e.enchantsFrame,t..".enchantsFrame.enchant9")e.enchantsFrame.enchant9:SetPoint("LEFT",e.enchantsFrame.enchant8,"RIGHT",96,0)e.enchantsFrame.enchant10=a(e.enchantsFrame,t..".enchantsFrame.enchant10")e.enchantsFrame.enchant10:SetPoint("TOP",e.enchantsFrame.enchant7,"BOTTOM",0,16)e.enchantsFrame.enchant11=a(e.enchantsFrame,t..".enchantsFrame.enchant11")e.enchantsFrame.enchant11:SetPoint("LEFT",e.enchantsFrame.enchant10,"RIGHT",96,0)e.enchantsFrame.enchant12=a(e.enchantsFrame,t..".enchantsFrame.enchant12")e.enchantsFrame.enchant12:SetPoint("LEFT",e.enchantsFrame.enchant11,"RIGHT",96,0)e.enchantsFrame.enchant13=a(e.enchantsFrame,t..".enchantsFrame.enchant13")e.enchantsFrame.enchant13:SetPoint("TOP",e.enchantsFrame.enchant10,"BOTTOM",0,16)e.enchantsFrame.enchant14=a(e.enchantsFrame,t..".enchantsFrame.enchant14")e.enchantsFrame.enchant14:SetPoint("LEFT",e.enchantsFrame.enchant13,"RIGHT",96,0)e.enchantsFrame.enchant15=a(e.enchantsFrame,t..".enchantsFrame.enchant15")e.enchantsFrame.enchant15:SetPoint("LEFT",e.enchantsFrame.enchant14,"RIGHT",96,0)e.enchantsFrame.enchant16=a(e.enchantsFrame,t..".enchantsFrame.enchant16")e.enchantsFrame.enchant16:SetPoint("TOP",e.enchantsFrame.enchant13,"BOTTOM",0,16)e.enchantsFrame.enchant17=a(e.enchantsFrame,t..".enchantsFrame.enchant17")e.enchantsFrame.enchant17:SetPoint("LEFT",e.enchantsFrame.enchant16,"RIGHT",96,0)e.enchantsFrame.enchant18=a(e.enchantsFrame,t..".enchantsFrame.enchant18")e.enchantsFrame.enchant18:SetPoint("LEFT",e.enchantsFrame.enchant17,"RIGHT",96,0)for r=1,I do
e.enchantsFrame.enchants[r]=_G[t..".enchantsFrame.enchant"..r]end
e.armorFrame=T(e,t..".armorFrame")e.armorFrame:SetPoint("TOP",e.enchantsFrame,"BOTTOM",0,-10)e.armorFrame.frameHeader.titleText:SetText("Armor and Weapons")e.armorFrame.armors={}e.armorFrame.armor1=o(e.armorFrame,t..".armorFrame.armor1")e.armorFrame.armor1:SetPoint("TOPLEFT",e.armorFrame.frameHeader.icon,"BOTTOMLEFT",32,-16)e.armorFrame.armor2=o(e.armorFrame,t..".armorFrame.armor2")e.armorFrame.armor2:SetPoint("LEFT",e.armorFrame.armor1.text,"RIGHT",4,0)e.armorFrame.armor3=o(e.armorFrame,t..".armorFrame.armor3")e.armorFrame.armor3:SetPoint("LEFT",e.armorFrame.armor2.text,"RIGHT",4,0)e.armorFrame.armor4=o(e.armorFrame,t..".armorFrame.armor4")e.armorFrame.armor4:SetPoint("LEFT",e.armorFrame.armor3.text,"RIGHT",4,0)e.armorFrame.armor5=o(e.armorFrame,t..".armorFrame.armor5")e.armorFrame.armor5:SetPoint("LEFT",e.armorFrame.armor4.text,"RIGHT",4,0)e.armorFrame.armor6=o(e.armorFrame,t..".armorFrame.armor6")e.armorFrame.armor6:SetPoint("TOP",e.armorFrame.armor1,"BOTTOM",0,-16)e.armorFrame.armor7=o(e.armorFrame,t..".armorFrame.armor7")e.armorFrame.armor7:SetPoint("LEFT",e.armorFrame.armor6.text,"RIGHT",4,0)e.armorFrame.armor8=o(e.armorFrame,t..".armorFrame.armor8")e.armorFrame.armor8:SetPoint("LEFT",e.armorFrame.armor7.text,"RIGHT",4,0)e.armorFrame.armor9=o(e.armorFrame,t..".armorFrame.armor9")e.armorFrame.armor9:SetPoint("LEFT",e.armorFrame.armor8.text,"RIGHT",4,0)e.armorFrame.armor10=o(e.armorFrame,t..".armorFrame.armor10")e.armorFrame.armor10:SetPoint("LEFT",e.armorFrame.armor9.text,"RIGHT",4,0)e.armorFrame.armor11=o(e.armorFrame,t..".armorFrame.armor11")e.armorFrame.armor11:SetPoint("TOP",e.armorFrame.armor6,"BOTTOM",0,-16)e.armorFrame.armor12=o(e.armorFrame,t..".armorFrame.armor12")e.armorFrame.armor12:SetPoint("LEFT",e.armorFrame.armor11.text,"RIGHT",4,0)e.armorFrame.armor13=o(e.armorFrame,t..".armorFrame.armor13")e.armorFrame.armor13:SetPoint("LEFT",e.armorFrame.armor12.text,"RIGHT",4,0)e.armorFrame.armor14=o(e.armorFrame,t..".armorFrame.armor14")e.armorFrame.armor14:SetPoint("LEFT",e.armorFrame.armor13.text,"RIGHT",4,0)e.armorFrame.armor15=o(e.armorFrame,t..".armorFrame.armor15")e.armorFrame.armor15:SetPoint("LEFT",e.armorFrame.armor14.text,"RIGHT",4,0)e.armorFrame.armor16=o(e.armorFrame,t..".armorFrame.armor16")e.armorFrame.armor16:SetPoint("TOP",e.armorFrame.armor11,"BOTTOM",0,-16)e.armorFrame.armor17=o(e.armorFrame,t..".armorFrame.armor17")e.armorFrame.armor17:SetPoint("LEFT",e.armorFrame.armor16.text,"RIGHT",4,0)e.armorFrame.armor18=o(e.armorFrame,t..".armorFrame.armor18")e.armorFrame.armor18:SetPoint("LEFT",e.armorFrame.armor17.text,"RIGHT",4,0)e.armorFrame.armor19=o(e.armorFrame,t..".armorFrame.armor19")e.armorFrame.armor19:SetPoint("LEFT",e.armorFrame.armor18.text,"RIGHT",4,0)e.armorFrame.armor20=o(e.armorFrame,t..".armorFrame.armor20")e.armorFrame.armor20:SetPoint("LEFT",e.armorFrame.armor19.text,"RIGHT",4,0)e.armorFrame.armor21=o(e.armorFrame,t..".armorFrame.armor21")e.armorFrame.armor21:SetPoint("TOP",e.armorFrame.armor16,"BOTTOM",0,-16)e.armorFrame.armor22=o(e.armorFrame,t..".armorFrame.armor22")e.armorFrame.armor22:SetPoint("LEFT",e.armorFrame.armor21.text,"RIGHT",4,0)for r=1,A do
e.armorFrame.armors[r]=_G[t..".armorFrame.armor"..r]end
e.descriptionFrame=T(e,t..".descriptionFrame")e.descriptionFrame:SetPoint("TOP",e.armorFrame,"BOTTOM",0,-10)e.descriptionFrame.frameHeader.titleText:SetText("Description")e.descriptionFrame.editBox=CreateFrame("EditBox",t..".descriptionFrame.editBox",e.descriptionFrame)e.descriptionFrame.editBox:SetSize(565,491)e.descriptionFrame.editBox:SetFontObject(GameFontNormal)e.descriptionFrame.editBox:SetMaxLetters(2500)e.descriptionFrame.editBox:SetJustifyH("LEFT")e.descriptionFrame.editBox:SetMultiLine(true)e.descriptionFrame.editBox:ClearFocus(e.descriptionFrame.editBox)e.descriptionFrame.editBox:SetAutoFocus(false)e.descriptionFrame.editBox:SetPoint("TOPLEFT",e.descriptionFrame.frameHeader.icon,"BOTTOMLEFT",32,-16)e.descriptionFrame.editBox:SetText("There is no description yet.")e.descriptionFrame.editBox:SetScript("OnEscapePressed",function(e)e:ClearFocus(e)SaveDescription(e)end)e.descriptionFrame.editBox:EnableMouse(false)function e.enchantsFrame:LoadEnchants(o)local t=0
local r=1
for t=1,I do
e.enchantsFrame.enchants[t]:Hide()end
for a,o in pairs(o)do
local r,n,a=GetSpellInfo(o)if r then
t=t+1
e.enchantsFrame.enchants[t]:HandleEnchant(r,n,a)e.enchantsFrame.enchants[t]:Show()else
print("|cffFF0000ERROR. Can't load enchant "..o)end
end
r=math.ceil(t/3)e.enchantsFrame:SetHeight(32+(64*r)-(16*(r-1)))end
function e.armorFrame:LoadArmor(r)local t=0
local o=1
for t=1,A do
e.armorFrame.armors[t]:Hide()end
for o,r in pairs(r)do
local o,a,n=GetSpellInfo(r)if o then
t=t+1
e.armorFrame.armors[t]:SetSpell(r,o,a,n)e.armorFrame.armors[t]:Show()else
print("|cffFF0000ERROR. Can't load enchant "..r)end
end
O(e.armorFrame,t,5)end
function e.descriptionFrame:LoadDescription(t)if not(t)then
e.descriptionFrame:Hide()elseif not(string.match(t,"(%a)"))and not(string.match(t,"(%d)"))then
e.descriptionFrame:Hide()else
e.descriptionFrame.editBox:SetText(t)e.descriptionFrame:Show()end
end
return e
end
local function f(e)local e=CreateFrame("FRAME",e:GetName()..".Seperator",e)e:SetSize(29,71)e.BG=e:CreateTexture(nil,"BACKGROUND")e.BG:SetPoint("CENTER")e.BG:SetSize(128,128)e.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\Seperator")e.levelOrb=e:CreateTexture(nil,"BORDER")e.levelOrb:SetPoint("CENTER")e.levelOrb:SetSize(32,32)e.levelOrb:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\OrbLevel")e.levelBorder=e:CreateTexture(nil,"ARTWORK")e.levelBorder:SetPoint("CENTER")e.levelBorder:SetSize(32,32)e.levelBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\BorderLevel")e.text=e:CreateFontString(nil,"OVERLAY")e.text:SetPoint("CENTER")e.text:SetFontObject(GameFontNormal)e.text:SetText("1")return e
end
local function I(t,e)local e=CreateFrame("FRAME",e,t)e:SetSize(128,t:GetHeight())e.spells={}function e:CorrectSize(t)if(t==0)then
e:SetWidth(.1)else
e:SetWidth((t*128)+(t*16)+32)end
end
function e:ClearSpells()for t,r in pairs(e.spells)do
e.spells[t]:Hide()e.spells[t]=nil
_G[e:GetName()..".spell"..t]=nil
end
end
function e:AddSpell(a)local r=#e.spells+1
local t=o(e,e:GetName()..".spell"..r)table.insert(e.spells,t)if(r==1)then
t:SetPoint("LEFT",e,"LEFT",32,0)else
t:SetPoint("LEFT",e.spells[(r-1)].text,"RIGHT",8,0)end
local r,n,o=GetSpellInfo(a)if not(r)then
print("|cffFF0000ERROR Can't load spell "..a)else
t:SetSpell(a,r,n,o)end
end
e.Seperator=f(e)e.Seperator:SetPoint("RIGHT",e,"LEFT",e.Seperator:GetWidth()/2,0)e.Seperator.text:SetText(i)return e
end
local function i(e)local r=0
local t=CreateFrame("FRAME",e:GetName()..".scrollContentFrame",e)t:SetSize(650,75)t.levelFrames={}t.seperatorTable={}t.activeSeperator=1
local e=CreateFrame("ScrollFrame",e:GetName()..".scrollFrame",e)e:SetSize(t:GetSize())e:EnableMouseWheel(true)e:RegisterForDrag("LeftButton")e:EnableMouse(true)e.ScrollBar=CreateFrame("Slider","scrollFrame.ScrollBar",e)e.ScrollBar:SetPoint("TOPLEFT",e,"TOPRIGHT",5,-15)e.ScrollBar:SetPoint("BOTTOMLEFT",e,"BOTTOMRIGHT",0,15)e.ScrollBar:SetMinMaxValues(1,t:GetWidth())e.ScrollBar:SetValueStep(1)e.ScrollBar.scrollStep=1
e.ScrollBar:SetValue(0)e.ScrollBar:SetWidth(16)e.ScrollBar:SetScript("OnValueChanged",function(r,t)e:SetHorizontalScroll(t)HandleParentArrow(r,t)end)e:SetScrollChild(t)e.SeperatorMain=f(e)e.SeperatorMain:SetPoint("RIGHT",e,"LEFT",16,0)e.SeperatorMain.animTex=e.SeperatorMain:CreateTexture(nil,"OVERLAY")e.SeperatorMain.animTex:SetPoint("CENTER")e.SeperatorMain.animTex:SetSize(32,32)e.SeperatorMain.animTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\BorderLevel")e.SeperatorMain.animTex:SetBlendMode("ADD")e.SeperatorMain.animTex:SetAlpha(0)e.SeperatorMain.animTex.AG=e.SeperatorMain.animTex:CreateAnimationGroup()e.SeperatorMain.animTex.Alpha0=e.SeperatorMain.animTex.AG:CreateAnimation("Alpha")e.SeperatorMain.animTex.Alpha0:SetStartDelay(0)e.SeperatorMain.animTex.Alpha0:SetDuration(.1)e.SeperatorMain.animTex.Alpha0:SetOrder(1)e.SeperatorMain.animTex.Alpha0:SetEndDelay(0)e.SeperatorMain.animTex.Alpha0:SetSmoothing("IN")e.SeperatorMain.animTex.Alpha0:SetChange(1)e.SeperatorMain.animTex.Rotation=e.SeperatorMain.animTex.AG:CreateAnimation("Rotation")e.SeperatorMain.animTex.Rotation:SetStartDelay(0)e.SeperatorMain.animTex.Rotation:SetDuration(1)e.SeperatorMain.animTex.Rotation:SetOrder(1)e.SeperatorMain.animTex.Rotation:SetEndDelay(0)e.SeperatorMain.animTex.Rotation:SetSmoothing("IN_OUT")e.SeperatorMain.animTex.Rotation:SetDegrees(360)e.SeperatorMain.animTex.Alpha1=e.SeperatorMain.animTex.AG:CreateAnimation("Alpha")e.SeperatorMain.animTex.Alpha1:SetStartDelay(.5)e.SeperatorMain.animTex.Alpha1:SetDuration(.5)e.SeperatorMain.animTex.Alpha1:SetOrder(1)e.SeperatorMain.animTex.Alpha1:SetEndDelay(0)e.SeperatorMain.animTex.Alpha1:SetSmoothing("OUT")e.SeperatorMain.animTex.Alpha1:SetChange(-1)for e=1,c do
t.levelFrame=I(t,t:GetName().."levelFrame"..e)table.insert(t.levelFrames,t.levelFrame)if(e>1)then
t.levelFrame:SetPoint("LEFT",t.levelFrames[(e-1)],"RIGHT",0,0)else
t.levelFrame:SetPoint("LEFT",16,0)end
t.levelFrame.Seperator.text:SetText(e)end
function e:SwtichSeperators()local o=nil
local a=nil
if(t.seperatorTable[t.activeSeperator+1])then
o=t.seperatorTable[t.activeSeperator+1]:GetCenter()end
if(t.seperatorTable[t.activeSeperator])then
a=t.seperatorTable[t.activeSeperator]:GetCenter()end
if(o)and(o<r)then
if(t.seperatorTable[t.activeSeperator+1])then
t.activeSeperator=t.activeSeperator+1
e.SeperatorMain.text:SetText(t.seperatorTable[t.activeSeperator].text:GetText())e.SeperatorMain.animTex.AG:Stop()e.SeperatorMain.animTex.AG:Play()end
return
end
if(a)and(a>r)then
if(t.seperatorTable[t.activeSeperator-1])then
t.activeSeperator=t.activeSeperator-1
e.SeperatorMain.text:SetText(t.seperatorTable[t.activeSeperator].text:GetText())e.SeperatorMain.animTex.AG:Stop()e.SeperatorMain.animTex.AG:Play()end
return
end
end
e:SetScript("OnDragStart",function(e,...)e.Start_X=GetCursorPosition()end)e:SetScript("OnDragStop",function(e,...)e.Start_X=nil
end)e:SetScript("OnMouseWheel",function(e,r)if(e.ScrollBar:IsVisible())and(e.ScrollBar:IsEnabled()==1)then
local t=e.ScrollBar:GetValue()e.ScrollBar:SetValue(t+r*32)end
end)e:SetScript("OnUpdate",function(t)if(t.Start_X)then
local e=GetCursorPosition();local e=-((e-t.Start_X)*1);t.Start_X=GetCursorPosition();t.ScrollBar:SetValue(t.ScrollBar:GetValue()+e);end
t:SwtichSeperators()r=e.SeperatorMain:GetCenter()end)return t,e
end
local function o(e,t)local e=s(e,t)e:SetSize(761,587)e:EnableMouse(false)e.qualityBorder:Hide()e.bg:SetSize(1024,1024)e.bg:SetPoint("CENTER",0,0)e.bg:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\BuildTab")e.activateButton:Hide()e.bottomFrame:SetPoint("BOTTOMLEFT",4,-27)e.bottomFrame.BG_Left=e.bottomFrame:CreateTexture(nil,"BACKGROUND")e.bottomFrame.BG_Left:SetSize(6,19)e.bottomFrame.BG_Left:SetPoint("LEFT",0,0)e.bottomFrame.BG_Left:SetTexCoord(0,.01171875,.421875,.5625)e.bottomFrame.BG_Left:SetTexture("Interface\\Buttons\\UI-Button-Borders2")e.bottomFrame.BG_Middle=e.bottomFrame:CreateTexture(nil,"BACKGROUND")e.bottomFrame.BG_Middle:SetSize(372,19)e.bottomFrame.BG_Middle:SetPoint("LEFT",e.bottomFrame.BG_Left,"RIGHT")e.bottomFrame.BG_Middle:SetTexCoord(.01171875,.3046875,.421875,.5625)e.bottomFrame.BG_Middle:SetTexture("Interface\\Buttons\\UI-Button-Borders2")e.bottomFrame.BG_Right=e.bottomFrame:CreateTexture(nil,"BACKGROUND")e.bottomFrame.BG_Right:SetSize(6,19)e.bottomFrame.BG_Right:SetPoint("LEFT",e.bottomFrame.BG_Middle,"RIGHT")e.bottomFrame.BG_Right:SetTexCoord(.3046875,.31640625,.421875,.5625)e.bottomFrame.BG_Right:SetTexture("Interface\\Buttons\\UI-Button-Borders2")e.bottomFrame:SetWidth(386)MagicButton_OnLoad(e.bottomFrame)e.LearnAllButton=CreateFrame("Button","frame.LearnAllButton",e,"StaticPopupButtonTemplate")e.LearnAllButton:SetSize(185,22)e.LearnAllButton:SetPoint("LEFT",e.bottomFrame,"RIGHT",0,0)e.LearnAllButton:SetText("Learn All")MagicButton_OnLoad(e.LearnAllButton)e.ActivateButton=CreateFrame("Button","frame.LearnAllButton",e,"StaticPopupButtonTemplate")e.ActivateButton:SetSize(185,22)e.ActivateButton:SetPoint("LEFT",e.LearnAllButton,"RIGHT",0,0)e.ActivateButton:SetText("Choose this build")MagicButton_OnLoad(e.ActivateButton)e.contentFrame=L(e,t..".contentFrame")e.contentFrame:SetPoint("BOTTOM",0,4)e.scroll=CreateFrame("ScrollFrame",t..".scroll",e)e.scroll:SetSize(e.contentFrame:GetSize())e.scroll:SetPoint("BOTTOM",0,6)e.scroll:EnableMouseWheel(true)e.scroll.ScrollBar=CreateFrame("Slider",nil,e.scroll,"UIPanelScrollBarTemplate")e.scroll.ScrollBar:SetPoint("TOPLEFT",e.scroll,"TOPRIGHT",11.5,154)e.scroll.ScrollBar:SetPoint("BOTTOMLEFT",e.scroll,"BOTTOMRIGHT",0,10)e.scroll.ScrollBar:SetMinMaxValues(1,500)e.scroll.ScrollBar:SetValueStep(1)e.scroll.ScrollBar.scrollStep=1
e.scroll.ScrollBar:SetValue(0)e.scroll.ScrollBar:SetWidth(16)e.scroll.ScrollBar:SetScript("OnValueChanged",function(r,t)e.scroll:SetVerticalScroll(t)end)e.scroll:SetScrollChild(e.contentFrame)function e:LoadBuild(r)local t=l[r]if not(t)then
print("|cffFF0000ERROR. No build found "..r)end
local r=1
for a,o in pairs(u)do
r=o[3]if(tonumber(t.stat[r])==1)then
r=a
break
end
end
e:SetUpButton(t.info[4],t.info[5],t.info[1],F[t.info[1]],t.info[3])e:SetStat(r)e.contentFrame.enchantsFrame:LoadEnchants(t.enchantSpells)e.contentFrame.armorFrame:LoadArmor(t.armourSpells)e.contentFrame.descriptionFrame:LoadDescription(t.description)e.contentFrame.requiredLeveltext:SetText(string.format(n.MSG_REQUIRED_LEVEL,t.maxLevel))e:LoadSpells(t.levelingSpells,t.maxLevel)end
return e
end
local function u(t,e)local e=o(t,e)e.spellsFrame,e.spellsFrameScroll=i(e)e.spellsFrame:SetPoint("TOP",0,-80)e.spellsFrameScroll:SetPoint("TOP",0,-80)function e:CorrectSize()local t=20
for r=1,c do
if(e.spellsFrame.levelFrames[r]:GetWidth()>1)then
print(e.spellsFrame.levelFrames[r]:GetWidth())t=t+e.spellsFrame.levelFrames[r]:GetWidth()end
end
print(t)print(t-e.spellsFrameScroll:GetWidth())if(t-e.spellsFrameScroll:GetWidth())>1 then
e.spellsFrameScroll.ScrollBar:SetMinMaxValues(1,t-e.spellsFrameScroll:GetWidth())else
e.spellsFrameScroll.ScrollBar:SetMinMaxValues(1,1)end
end
function e:LoadSpells(r)for t=1,c do
local e=e.spellsFrame.levelFrames[t]e:ClearSpells()e:CorrectSize(0)e:Hide()end
e.spellsFrameScroll.SeperatorMain.text:SetText("")e.spellsFrame.seperatorTable={}e.spellsFrame.activeSeperator=1
e.spellsFrameScroll.ScrollBar:SetValue(1)for t=1,c do
local o=r[t]if(o)then
if(not(e.spellsFrame.levelFrames[t]))then
print("|cffFF0000ERROR NO SUCH LEVEL "..t)else
if not(e.spellsFrameScroll.SeperatorMain.text:GetText())or(e.spellsFrameScroll.SeperatorMain.text:GetText()=="")then
e.spellsFrameScroll.SeperatorMain.text:SetText(t)end
local t=e.spellsFrame.levelFrames[t]local r=0
for o,e in pairs(o)do
r=r+1
t:AddSpell(e)end
t:CorrectSize(r)t:Show()table.insert(e.spellsFrame.seperatorTable,t.Seperator)if(#e.spellsFrame.seperatorTable==1)then
t.Seperator:Hide()end
end
end
end
e:CorrectSize()end
return e
end
local function f(e,a)local e=o(e,a)e.bg:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\BuildTab2")e.contentFrame:SetHeight(498)e.scroll:SetSize(e.contentFrame:GetSize())e.scroll.ScrollBar:SetPoint("TOPLEFT",e.scroll,"TOPRIGHT",11.5,68)e.contentFrame.spellsFrame=T(e.contentFrame,a..".contentFrame.spellsFrame")e.contentFrame.spellsFrame:SetPoint("TOP",e.contentFrame.requiredLeveltext,"BOTTOM",0,-10)e.contentFrame.spellsFrame.frameHeader.titleText:SetText("Abilities and Talents")e.contentFrame.spellsFrame.spells={}e.contentFrame.spellsFrame.spell1=E(e.contentFrame.spellsFrame,a..".contentFrame.spellsFrame.spell1")e.contentFrame.spellsFrame.spell1:SetPoint("TOPLEFT",e.contentFrame.spellsFrame.frameHeader.icon,"BOTTOMLEFT",32,-16)e.contentFrame.spellsFrame.spells[1]={}e.contentFrame.spellsFrame.spells[1][1]=e.contentFrame.spellsFrame.spell1
local t=1
local o=1
local i=4
for r=2,M do
e.contentFrame.spellsFrame.spell=E(e.contentFrame.spellsFrame,a..".contentFrame.spellsFrame.spell"..r)if((r-1)%i==0)then
t=t+1
o=1
e.contentFrame.spellsFrame.spell:SetPoint("TOP",e.contentFrame.spellsFrame.spells[(t-1)][1],"BOTTOM",0,-16)else
o=o+1
e.contentFrame.spellsFrame.spell:SetPoint("LEFT",e.contentFrame.spellsFrame.spells[t][o-1].text,"RIGHT",24,0)end
if not(e.contentFrame.spellsFrame.spells[t])then
e.contentFrame.spellsFrame.spells[t]={}end
e.contentFrame.spellsFrame.spells[t][o]=e.contentFrame.spellsFrame.spell
end
e.contentFrame.enchantsFrame:SetPoint("TOP",e.contentFrame.spellsFrame,"BOTTOM",0,-10)function e:LoadSpells(S,c)local a={}local n=0
local t=1
local o=1
local l=1
for t,e in pairs(e.contentFrame.spellsFrame.spells)do
for t,e in pairs(e)do
e:Hide()end
end
for t,e in pairs(S[c])do
local t,r,r=GetSpellInfo(e)if t then
local t=ReturnClassDataBySpellID(e)if(t)then
local o,r,t=unpack(t)local t=CAO_Talent_References[e]if not(a[o..r])then
a[o..r]={}n=n+1
end
if(t)then
local l=1
for r=1,#CAO_Talents[t][2]do
if(e==CAO_Talents[t][2][r])then
l=r
end
end
if not(a[o..r][t])then
n=n+1
end
if not(a[o..r][t])or(a[o..r][t]<l)then
a[o..r][t]=l
end
else
a[o..r][e]=0
n=n+1
end
else
print("|cffFF0000ERROR. Can't load spell because of no class data"..e)end
else
print("|cffFF0000ERROR. Can't load spell "..e)end
end
l=math.ceil(n/i)if(l<i)then
l=n
end
for n=1,#R do
local n=R[n]if(a[n])then
local d=h[n].name
local S=h[n].color
local c=h[n].classID
local T=h[n].iconSpellID
local c=r[c]local T,T,r=GetSpellInfo(T)e.contentFrame.spellsFrame.spells[t][o]:SetClass(r,d,S)e.contentFrame.spellsFrame.spells[t][o]:Show()t,o=x(l,i,t,o)for r,a in pairs(a[n])do
if(a~=0)then
local n=CAO_Talents[r][2][a]local S,T,d=GetSpellInfo(n)if(S)then
e.contentFrame.spellsFrame.spells[t][o]:SetSpell(n,"|cff"..c..S.."|r |cffFFFFFF"..a.."/"..CAO_Talents[r][1],T,d)e.contentFrame.spellsFrame.spells[t][o]:Show()t,o=x(l,i,t,o)else
print("|cffFF0000ERROR. Can't load spell because of no talent data"..r)end
else
local a,S,n=GetSpellInfo(r)if(a)then
e.contentFrame.spellsFrame.spells[t][o]:SetSpell(r,"|cff"..c..a.."|r",S,n)e.contentFrame.spellsFrame.spells[t][o]:Show()t,o=x(l,i,t,o)else
print("|cffFF0000ERROR. Can't load spell because of no talent data"..r)end
end
end
end
end
O(e.contentFrame.spellsFrame,l,1)end
return e
end
function C.SendError(t,e,o)local t=""if(o)then
local r=GetSpellInfo(e)if not(r)or(r=="")then
return false
end
t=string.format(o,e,r)else
t=e
end
StaticPopupDialogs["ASC_ERROR"].text=t
StaticPopup_Show("ASC_ERROR")end
function C.GetRatingData(t,e)F=e
end
function C.GetBuildList(t,e)S={}for r,e in pairs(e)do
local e=e[1]local t=0
if(F[r])then
t=F[r]end
table.insert(S,{e[1],e[4],e[5],t,e[3]})end
B(S,1,#S)if not(BuildCreator.BuildExplorer.HSBuilds.Content)then
BuildCreator.BuildExplorer.HSBuilds.Init()else
BuildCreator.BuildExplorer.HSBuilds.LoadData()BuildCreator.BuildExplorer.HSBuilds.RefreshLayout()end
end
function C.GetBuildData(e,t)local e=t[1][1]l[e]=G()l[e].info=t[1]l[e].spells=t[2]l[e].stat=t[3]l[e].description=t[5]l[e].editable=t[6]l[e]:HandleTime(t[7],l[e].info[6])l[e]:HandleSpells()BuildCreator.LevelingFrame:Hide()BuildCreator.BuildExplorer:Hide()if(l[e].isMaxLevel)then
BuildCreator.PreviewMax:Show()BuildCreator.PreviewMax:LoadBuild(e)else
BuildCreator.PreviewLeveling:Show()BuildCreator.PreviewLeveling:LoadBuild(e)end
end
BuildCreator=CreateFrame("FRAME","BuildCreator",UIParent)BuildCreator:SetSize(1060,698)BuildCreator:SetPoint("CENTER",0,0)BuildCreator:SetClampedToScreen(true)BuildCreator:SetFrameStrata("DIALOG")BuildCreator:SetMovable(true)BuildCreator:EnableMouse(true)BuildCreator:RegisterForDrag("LeftButton")BuildCreator:SetScript("OnDragStart",BuildCreator.StartMoving)BuildCreator:SetScript("OnDragStop",BuildCreator.StopMovingOrSizing)BuildCreator:SetScript("OnMouseDown",function()CloseDropDownMenus()end)BuildCreator:SetScript("OnShow",P)BuildCreator:Hide()BuildCreator.TitleText=BuildCreator:CreateFontString("BuildCreatorTitleText")BuildCreator.TitleText:SetFont("Fonts\\FRIZQT__.TTF",12)BuildCreator.TitleText:SetFontObject(GameFontNormal)BuildCreator.TitleText:SetPoint("TOP",0,-10)BuildCreator.TitleText:SetShadowOffset(1,-1)BuildCreator.TitleText:SetText("Hero Architect - WIP")BuildCreator.CloseButton=CreateFrame("BUTTON","BuildCreatorCloseButton",BuildCreator,"UIPanelCloseButton")BuildCreator.CloseButton:SetPoint("TOPRIGHT",5,0)BuildCreator.CloseButton:EnableMouse(true)BuildCreator.Icon=BuildCreator:CreateTexture(nil,"BACKGROUND")BuildCreator.Icon:SetSize(60,60)BuildCreator.Icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\spell_Paladin_divinecircle")BuildCreator.Icon:SetPoint("TOPLEFT",-1,3)SetPortraitToTexture(BuildCreator.Icon,"Interface\\AddOns\\AwAddons\\Textures\\misc\\spell_Paladin_divinecircle")BuildCreator.Border=BuildCreator:CreateTexture(nil,"BORDER")BuildCreator.Border:SetSize(2048,1024)BuildCreator.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\BCNew\\CAO_ReworkBC5")BuildCreator.Border:SetPoint("CENTER",7,-46)BuildCreator.SearchBox=CreateFrame("EditBox","BuildCreator.SearchBox",BuildCreator,"InputBoxTemplate")BuildCreator.SearchBox:SetWidth(308)BuildCreator.SearchBox:SetHeight(26)BuildCreator.SearchBox:SetFontObject(GameFontNormal)BuildCreator.SearchBox:SetPoint("TOPRIGHT",BuildCreator,-30,-33)BuildCreator.SearchBox:ClearFocus(self)BuildCreator.SearchBox:SetAutoFocus(false)BuildCreator.SearchBox:SetFontObject(GameFontDisable)BuildCreator.SearchBox:SetScript("OnEnterPressed",b)BuildCreator.SearchBox:SetScript("OnEscapePressed",H)BuildCreator.SearchBox:SetText(n.MSG_SEARCH_DEFAULT)BuildCreator.SearchBox.text=BuildCreator.SearchBox:CreateFontString(nil,"ARTWORK")BuildCreator.SearchBox.text:SetFontObject(GameFontNormal)BuildCreator.SearchBox.text:SetText("Search for builds: ")BuildCreator.SearchBox.text:SetJustifyH("RIGHT")BuildCreator.SearchBox.text:SetPoint("RIGHT",BuildCreator.SearchBox,"LEFT",-8,0)BuildCreator.SearchBox.icon=BuildCreator.SearchBox:CreateTexture(nil,"ARTWORK")BuildCreator.SearchBox.icon:SetSize(32,32)BuildCreator.SearchBox.icon:SetPoint("RIGHT",BuildCreator.SearchBox.text,"LEFT",4,0)BuildCreator.SearchBox.icon:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton")BuildCreator.Categories=CreateFrame("FRAME","BuildCreator.Categories",BuildCreator)BuildCreator.Categories:SetSize(251,588)BuildCreator.Categories:SetPoint("LEFT",11,-15)BuildCreator.Categories.tabLeveling=m(BuildCreator.Categories,"BuildCreator.Categories.tabLeveling")BuildCreator.Categories.tabLeveling:SetPoint("TOP",0,-2)BuildCreator.Categories.tabLeveling:GetScript("OnMouseUp")(BuildCreator.Categories.tabLeveling)BuildCreator.Categories.tabLeveling.text:SetText("Best Leveling Builds")SetPortraitToTexture(BuildCreator.Categories.tabLeveling.icon,"Interface\\Icons\\newplayerhelp_newcomer")BuildCreator.Categories.tabLevel60=m(BuildCreator.Categories,"BuildCreator.Categories.tabLevel60")BuildCreator.Categories.tabLevel60:SetPoint("TOP",BuildCreator.Categories.tabLeveling,"BOTTOM",0,-3)BuildCreator.Categories.tabLevel60.text:SetText("Level 60 Builds")SetPortraitToTexture(BuildCreator.Categories.tabLevel60.icon,"Interface\\Icons\\achievement_level_60")BuildCreator.Categories.tabLevel70=m(BuildCreator.Categories,"BuildCreator.Categories.tabLevel70")BuildCreator.Categories.tabLevel70:SetPoint("TOP",BuildCreator.Categories.tabLevel60,"BOTTOM",0,-3)BuildCreator.Categories.tabLevel70.text:SetText("Level 70 Builds")SetPortraitToTexture(BuildCreator.Categories.tabLevel70.icon,"Interface\\Icons\\achievement_level_70")BuildCreator.Categories.tabNew=m(BuildCreator.Categories,"BuildCreator.Categories.tabNew")BuildCreator.Categories.tabNew:SetPoint("TOP",BuildCreator.Categories.tabLevel70,"BOTTOM",0,-3)BuildCreator.Categories.tabNew.text:SetText("Fresh Builds")BuildCreator.LevelingFrame=CreateFrame("FRAME","BuildCreator.LevelingFrame",BuildCreator)BuildCreator.LevelingFrame:SetSize(761,587)BuildCreator.LevelingFrame:SetPoint("CENTER",0,-15)BuildCreator.LevelingScroll=CreateFrame("ScrollFrame","BuildCreator.LevelingScroll",BuildCreator)BuildCreator.LevelingScroll:SetSize(761,587)BuildCreator.LevelingScroll:SetPoint("CENTER",118,-15)BuildCreator.LevelingScroll:EnableMouseWheel(true)BuildCreator.LevelingScroll.ScrollBar=CreateFrame("Slider",nil,BuildCreator.LevelingScroll,"UIPanelScrollBarTemplate")BuildCreator.LevelingScroll.ScrollBar:SetPoint("TOPLEFT",BuildCreator.LevelingScroll,"TOPRIGHT",5.5,-15)BuildCreator.LevelingScroll.ScrollBar:SetPoint("BOTTOMLEFT",BuildCreator.LevelingScroll,"BOTTOMRIGHT",0,15)BuildCreator.LevelingScroll.ScrollBar:SetMinMaxValues(1,2)BuildCreator.LevelingScroll.ScrollBar:SetValueStep(1)BuildCreator.LevelingScroll.ScrollBar.scrollStep=1
BuildCreator.LevelingScroll.ScrollBar:SetValue(0)BuildCreator.LevelingScroll.ScrollBar:SetWidth(16)BuildCreator.LevelingScroll.ScrollBar:SetScript("OnValueChanged",function(t,e)BuildCreator.LevelingScroll:SetVerticalScroll(e)end)BuildCreator.LevelingScroll:SetScrollChild(BuildCreator.LevelingFrame)BuildCreator.LevelingFrame.BuildBox1=s(BuildCreator.LevelingFrame,"BuildCreator.LevelingFrame.BuildBox1")BuildCreator.LevelingFrame.BuildBox1:SetPoint("TOP",0,-1)BuildCreator.LevelingFrame.BuildBox1:SetQuality(3)BuildCreator.LevelingFrame.BuildBox1:SetStat(1)BuildCreator.LevelingScroll:Hide()BuildCreator.BuildExplorer=CreateFrame("FRAME","BuildCreator.LevelingFrame",BuildCreator)BuildCreator.BuildExplorer:SetSize(761,587)BuildCreator.BuildExplorer:SetPoint("CENTER",118,-15)BuildCreator.BuildExplorer.HSBuilds=HybridScroll()BuildCreator.BuildExplorer.HSBuilds.Parent=BuildCreator.BuildExplorer
BuildCreator.BuildExplorer.HSBuilds.ParentName=BuildCreator.BuildExplorer:GetName()BuildCreator.BuildExplorer.HSBuilds.Name="BuildCreator.BuildExplorer.HSBuilds"BuildCreator.BuildExplorer.HSBuilds.Width=761
BuildCreator.BuildExplorer.HSBuilds.Height=587
BuildCreator.BuildExplorer.HSBuilds.doNotHide=true
BuildCreator.BuildExplorer.HSBuilds.point={"CENTER",0,0}BuildCreator.BuildExplorer.HSBuilds.scrollup_point={5.5,-15}BuildCreator.BuildExplorer.HSBuilds.scrolldown_point={0,15}function BuildCreator.BuildExplorer.HSBuilds.LoadData()BuildCreator.BuildExplorer.HSBuilds.items=S;end
function BuildCreator.BuildExplorer.HSBuilds.SetUpButton(e,t)local r=t[1]local a=t[2]local o=t[3]local n=t[4]local t=t[5]e:SetUpButton(a,o,r,n,t)if(BC_ACTIVE_BUILD==r)then
e:Activate()else
e:Deactivate()end
if e:IsMouseOver()then
p(e)end
end
function BuildCreator.BuildExplorer.HSBuilds.CreateButton(t,e)local r=t
local t=r:GetName()btn=s(r,t..".SpecButton"..e)if(e==1)then
btn:SetPoint("TOP",1,-1)else
btn:SetPoint("TOP",_G[t..".SpecButton"..(e-1)],"BOTTOM",0,0)end
return btn
end
BuildCreator.PreviewLeveling=u(BuildCreator,"BuildCreator.PreviewLeveling")BuildCreator.PreviewLeveling:SetPoint("CENTER",118,-15)BuildCreator.PreviewLeveling:Hide()BuildCreator.PreviewMax=f(BuildCreator,"BuildCreator.PreviewMax")BuildCreator.PreviewMax:SetPoint("CENTER",118,-15)BuildCreator.PreviewMax:Hide()function BuildCreatorMatchController()BuildCreator.CollectionControllerTab1:SetText(CollectionController.CollectionControllerTab1:GetText())BuildCreator.CollectionControllerTab2:SetText(CollectionController.CollectionControllerTab2:GetText())BuildCreator.CollectionControllerTab3:SetText(CollectionController.CollectionControllerTab3:GetText())BuildCreator.CollectionControllerTab4:SetText(CollectionController.CollectionControllerTab4:GetText())BuildCreator.CollectionControllerTab1:SetScript("OnClick",function(t,e)CollectionController.CollectionControllerTab1:GetScript("OnClick")(CollectionController.CollectionControllerTab1,e)t:Enable()end)BuildCreator.CollectionControllerTab2:SetScript("OnClick",function(t,e)CollectionController.CollectionControllerTab2:GetScript("OnClick")(CollectionController.CollectionControllerTab2,e)end)BuildCreator.CollectionControllerTab3:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab3:GetScript("OnClick")(CollectionController.CollectionControllerTab3,t)e:Enable()end)BuildCreator.CollectionControllerTab4:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab4:GetScript("OnClick")(CollectionController.CollectionControllerTab4,t)e:Enable()end)BuildCreator.CollectionControllerTab1:SetScript("OnEnter",function(t,e)CollectionController.CollectionControllerTab1:GetScript("OnEnter")(t,e)end)BuildCreator.CollectionControllerTab2:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab2:GetScript("OnEnter")(e,t)end)BuildCreator.CollectionControllerTab3:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab3:GetScript("OnEnter")(e,t)end)BuildCreator.CollectionControllerTab4:SetScript("OnEnter",function(e,t)CollectionController.CollectionControllerTab4:GetScript("OnEnter")(e,t)end)BuildCreator.CollectionControllerTab1:SetScript("OnLeave",function(e,t)CollectionController.CollectionControllerTab1:GetScript("OnLeave")(e,t)end)BuildCreator.CollectionControllerTab2:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab2:GetScript("OnLeave")(t,e)end)BuildCreator.CollectionControllerTab3:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab3:GetScript("OnLeave")(t,e)end)BuildCreator.CollectionControllerTab4:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab4:GetScript("OnLeave")(t,e)end)BuildCreator.CollectionControllerTab2.Icon:SetTexture(CollectionController.CollectionControllerTab2.Icon:GetTexture())BuildCreator.CollectionControllerTab3.Icon:SetTexture(CollectionController.CollectionControllerTab3.Icon:GetTexture())BuildCreator.CollectionControllerTab1.Icon:SetTexture(CollectionController.CollectionControllerTab1.Icon:GetTexture())BuildCreator.CollectionControllerTab4.Icon:SetTexture(CollectionController.CollectionControllerTab4.Icon:GetTexture())BuildCreator.CollectionControllerTab5:SetText(CollectionController.CollectionControllerTab5:GetText())BuildCreator.CollectionControllerTab5:SetScript("OnClick",function(e,t)CollectionController.CollectionControllerTab5:GetScript("OnClick")(CollectionController.CollectionControllerTab5,t)e:Enable()end)BuildCreator.CollectionControllerTab5:SetScript("OnLeave",function(t,e)CollectionController.CollectionControllerTab5:GetScript("OnLeave")(t,e)end)BuildCreator.CollectionControllerTab5.Icon:SetTexture(CollectionController.CollectionControllerTab5.Icon:GetTexture())end
BuildCreator.CollectionControllerTab2=d(BuildCreator,"BuildCreator.CollectionControllerTab2")BuildCreator.CollectionControllerTab2:SetSize(148,32)BuildCreator.CollectionControllerTab2:SetPoint("BOTTOMLEFT",20,-20)BuildCreator.CollectionControllerTab2.BG:SetSize(148,31)BuildCreator.CollectionControllerTab2.BG:SetPoint("CENTER",0,0)BuildCreator.CollectionControllerTab2.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(BuildCreator.CollectionControllerTab2.Icon,"Interface\\AddOns\\AwAddons\\Textures\\Misc\\spell_Paladin_divinecircle")BuildCreator.CollectionControllerTab2:Enable()BuildCreator.CollectionControllerTab5=d(BuildCreator,"BuildCreator.CollectionControllerTab5")BuildCreator.CollectionControllerTab5:SetSize(148,32)BuildCreator.CollectionControllerTab5:SetPoint("LEFT",BuildCreator.CollectionControllerTab2,"RIGHT",-16,0)BuildCreator.CollectionControllerTab5:SetText("Build\nCreator")BuildCreator.CollectionControllerTab5.BG:SetSize(148,31)BuildCreator.CollectionControllerTab5.BG:SetPoint("CENTER",0,0)BuildCreator.CollectionControllerTab5.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(BuildCreator.CollectionControllerTab5.Icon,"Interface\\AddOns\\AwAddons\\Textures\\Misc\\spell_Paladin_divinecircle")BuildCreator.CollectionControllerTab3=d(BuildCreator,"BuildCreator.CollectionControllerTab3")BuildCreator.CollectionControllerTab3:SetSize(128,32)BuildCreator.CollectionControllerTab3:SetPoint("LEFT",BuildCreator.CollectionControllerTab5,"RIGHT",-16,0)BuildCreator.CollectionControllerTab3:SetText("Vanity")BuildCreator.CollectionControllerTab3:GetFontString():SetPoint("CENTER",0,2)BuildCreator.CollectionControllerTab3.BG:SetSize(128,31)BuildCreator.CollectionControllerTab3.BG:SetPoint("CENTER",0,0)BuildCreator.CollectionControllerTab3.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(BuildCreator.CollectionControllerTab3.Icon,"Interface\\icons\\INV_Chest_Awakening")BuildCreator.CollectionControllerTab3:Enable()BuildCreator.CollectionControllerTab1=d(BuildCreator,"BuildCreator.CollectionControllerTab1")BuildCreator.CollectionControllerTab1:SetSize(128,32)BuildCreator.CollectionControllerTab1:SetPoint("LEFT",BuildCreator.CollectionControllerTab3,"RIGHT",-16,0)BuildCreator.CollectionControllerTab1:SetText("Enchants")BuildCreator.CollectionControllerTab1:GetFontString():SetPoint("CENTER",0,2)BuildCreator.CollectionControllerTab1.BG:SetSize(128,31)BuildCreator.CollectionControllerTab1.BG:SetPoint("CENTER",0,0)BuildCreator.CollectionControllerTab1.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(BuildCreator.CollectionControllerTab1.Icon,"Interface\\icons\\inv_custom_ReforgeToken")BuildCreator.CollectionControllerTab1:Enable()BuildCreator.CollectionControllerTab4=d(BuildCreator,"BuildCreator.CollectionControllerTab4")BuildCreator.CollectionControllerTab4:SetSize(128,32)BuildCreator.CollectionControllerTab4:SetPoint("LEFT",BuildCreator.CollectionControllerTab1,"RIGHT",-16,0)BuildCreator.CollectionControllerTab4:SetText("Seasonal")BuildCreator.CollectionControllerTab4:GetFontString():SetPoint("CENTER",0,2)BuildCreator.CollectionControllerTab4.BG:SetSize(128,31)BuildCreator.CollectionControllerTab4.BG:SetPoint("CENTER",0,0)BuildCreator.CollectionControllerTab4.Icon:SetPoint("LEFT",19,3)SetPortraitToTexture(BuildCreator.CollectionControllerTab4.Icon,"Interface\\icons\\season1_complete")BuildCreator.CollectionControllerTab4:Enable()if(CollectionController)then
BuildCreatorMatchController()end