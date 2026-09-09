Ulocal a=AIO or require("AIO")local k=2.07
if a.AddAddon()then
return
end
local r=a.AddHandlers("EnchantReRoll",{})local e=CreateFrame("FRAME","CollectionsFrame",CollectionController,nil)e:Hide()local u=98462
local n=98463
local f=98570
local o=0
local t=0
local i=0
local l=0
local E=0
local S="Interface\\Icons\\Inv_Custom_ReforgeToken"local h="Interface\\Icons\\Inv_Custom_MysticExtract"local c="Interface\\Icons\\inv_custom_CollectionRCurrency"local m={["INVTYPE_BAG"]=true,["INVTYPE_BODY"]=true,["INVTYPE_AMMO"]=true,["INVTYPE_TABARD"]=true}local H={"GameTooltip","ItemRefTooltip",}e.MaxEcnhantsPerPage=15
e.EnchantList={}e.CurrentList={}e.CurrentPage=1
e.PageCount=1
e.SlotStackData={}e.ActiveEnchantButton=0
e.CollectionsEnchant=0
e.SuccessChance=100
e.KnownEnchants=0
e.TotalEnchants=#e.EnchantList
e.AnimationInProcess=false
e.EnchantQualitySettings={[0]={"|cff00FF00","Spells\\Creature_spellportallarge_green.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_UnCommon"},[1]={"|cffffffff","Spells\\Creature_spellportallarge_lightred.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Common"},[2]={"|cff1eff00","Spells\\Creature_spellportallarge_green.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_UnCommon"},[3]={"|cff0070dd","Spells\\Creature_spellportallarge_blue.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Rare"},[4]={"|cffa335ee","Spells\\Creature_spellportallarge_purple.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Epic"},[5]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[6]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[7]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[8]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[9]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[10]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[11]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},[12]={"|cffff8000","Spells\\Creature_spellportallarge_yellow.m2","Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary"},}function DebugPrintEnchantData()for e,t in pairs(e.EnchantList)do
local e=t[1][2]local n,a,o=GetSpellInfo(e)SendSystemMessage(t[1][1].." - "..e.." - "..n.." - "..o)end
end
function GetEnchantColor(t)local n=e.EnchantQualitySettings[0][1]if not(t)then
return n,0
end
local t=string.match(t,"(%d+)")if(t)then
n=e.EnchantQualitySettings[tonumber(t)][1]end
return n,t
end
local function d(t,e)local a,a,o,a,n,a,a,a,e=GetItemInfo(e)if e and(e~="")and not(m[e])and(n<(UnitLevel("player")-20))and(o>=2)then
t:AddLine("|cffD00000Mystic Enchants won't apply an effect on this\nitem because of level difference|r")t:Show()end
end
local function b(t,n)if(EnchantReRollFrame.item and e.Initializated)and not(e.AnimationInProcess)then
t:Enable()else
t:Disable()end
end
local function s(e)if GetItemCount(n)and(GetItemCount(n)>0)then
e:Enable()else
SetButtonPulse(e,0,1)e:Disable()end
end
local function T(...)local a=t
o=GetItemCount(u)t=GetItemCount(n)i=GetItemCount(f)if not(o)then
o=0
end
if not(t)then
t=0
end
if not(i)then
i=0
end
s(EnchantReRollFrame.Item.Button.Disenchant)e.AdditionalText:SetText("|cffa335ee[Mystic Rune]|r: "..o.."  |T"..S..".blp:12:12|t |cffa335ee[Mystic Extract]|r: "..t.."  |T"..h..".blp:12:12|t |cffa335ee[Mystic Orb]|r: "..i.." |T"..c..".blp:12:12|t")if(a<t)then
SetButtonPulse(EnchantReRollFrame.Item.Button.Disenchant,60,1)end
end
local function v(t,n)if(e.CollectionsEnchant~=0)and EnchantReRollFrame.item and e.Initializated and not(e.AnimationInProcess)then
t:Enable()RefundFrame.Button:Enable()else
t:Disable()RefundFrame.Button:Disable()end
end
local function y(e,t)if(e and t)then
if(e==0)then
EnchantReRollFrame.Bag_Temp=255
EnchantReRollFrame.Slot_Temp=t+22
else
EnchantReRollFrame.Bag_Temp=e+18
EnchantReRollFrame.Slot_Temp=t-1
end
elseif(e and(t==nil))then
EnchantReRollFrame.Bag_Temp=255
EnchantReRollFrame.Slot_Temp=e-1
end
end
local function M(e)if(EnchantReRollFrame.item)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(EnchantReRollFrame.item)GameTooltip:Show()end
end
local function L(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFClick to Extract|r")GameTooltip:AddLine("Requires |cffFFFFFFx1 |T"..h..".blp:13:13|t Mystic Extract|r ")GameTooltip:Show()end
local function G(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(EnchantReRollFrame.EffectCurrent)GameTooltip:Show()end
local function x(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(EnchantReRollFrame.EffectReforged)GameTooltip:Show()end
local function B()e.Initializated=false
end
local function I()T()if(e.TotalEnchants==0)then
a.Handle("EnchantReRoll","RequestLists")end
end
local function m(n,t)local n,o,o,o=GetCursorInfo()if((n=="item")or t)and EnchantReRollFrame.Bag_Temp and EnchantReRollFrame.Slot_Temp and e.Initializated then
a.Handle("EnchantReRoll","SetItem",EnchantReRollFrame.Bag_Temp,EnchantReRollFrame.Slot_Temp)else
RefundFrame:Hide()EnchantReRollFrame.Item.Button:SetNormalTexture(nil)EnchantReRollFrame.item=nil
EnchantReRollFrame.Item.BackgroundTexture:SetAlpha(.6)EnchantReRollFrame.CostText:SetText("")BaseFrameFadeOut(EnchantReRollFrame.Item.BackgroundTexture.Effect)BaseFrameFadeOut(EnchantReRollFrame.CurrentEnchant)e.ConfirmDisenchant:Hide()if(EnchantReRollFrame.Item.Button.Disenchant:IsVisible())then
BaseFrameFadeOut(EnchantReRollFrame.Item.Button.Disenchant)end
end
end
local function O(e,t)if(e and t)then
if(e==0)then
e=255
t=t+22
else
e=e+18
t=t-1
end
elseif(e and(t==nil))then
t=e-1
e=255
end
if(EnchantReRollFrame.item)and(EnchantReRollFrame.Bag==e)and(EnchantReRollFrame.Slot==t)then
EnchantReRollFrame.Bag_Temp=e
EnchantReRollFrame.Slot_Temp=t
m(nil,true)end
end
local function N(e)if(EnchantReRollFrame.item and EnchantReRollFrame.Bag and EnchantReRollFrame.Slot)and(e:IsEnabled()==1)then
PlaySound("igMainMenuOptionCheckBoxOn")a.Handle("EnchantReRoll","ReforgeItem_Prep",EnchantReRollFrame.Bag,EnchantReRollFrame.Slot)end
end
local function w()if(EnchantReRollFrame.item and EnchantReRollFrame.Bag and EnchantReRollFrame.Slot and e.CollectionsEnchant)then
PlaySound("igMainMenuOptionCheckBoxOn")a.Handle("EnchantReRoll","ReforgeItem_Collection",EnchantReRollFrame.Bag,EnchantReRollFrame.Slot,e.CollectionsEnchant)end
end
local function D(t)if not(t)then
t=0
end
t=tonumber(t)e.AnimationFrame.GlassGlowTexture:SetTexture(e.EnchantQualitySettings[t][3])e.AnimationFrame.GlassGlowTextureAdd:SetTexture(e.EnchantQualitySettings[t][3])e.AnimationFrame.Effect:SetModel(e.EnchantQualitySettings[t][2])e.AnimationFrame.Effect.AnimationGroup:Stop()EnchantReRollFrame.ReforgedEnchant.AnimationGroup:Stop()e.AnimationFrame.AnimationGroup:Stop()e.AnimationFrame.AnimationGroup:Play()e.AnimationInProcess=true
s(EnchantReRollFrame.Item.Button.Disenchant)end
local function p()EnchantReRollFrame.EffectCurrent=EnchantReRollFrame.EffectReforged
local e=GetEnchantColor(EnchantReRollFrame.EffectReforgedQuality)if(EnchantReRollFrame.item)then
EnchantReRollFrame.Item.Button:SetNormalTexture(EnchantReRollFrame.EffectReforgedTexture)end
EnchantReRollFrame.CurrentEnchant.EffectText:SetText(e..EnchantReRollFrame.EffectCurrent.."|r")end
local function g()if GetItemCount(n)and(GetItemCount(n)>0)then
if(EnchantReRollFrame.item and EnchantReRollFrame.Bag and EnchantReRollFrame.Slot)then
PlaySound("igMainMenuOptionCheckBoxOn")a.Handle("EnchantReRoll","DisenchantItem",EnchantReRollFrame.Bag,EnchantReRollFrame.Slot)m(nil,false)end
else
SendSystemMessage("You don't have enough Mystic Extract to disenchant that item")end
end
local function P()if not(EnchantReRollFrame.item or EnchantReRollFrame.Bag or EnchantReRollFrame.Slot)then
return false
end
local t=GetCursorInfo()if t and(t=="item")then
return false
end
local o,t,o,o,o,o,o,o,o,n=GetItemInfo(EnchantReRollFrame.item)e.ConfirmDisenchant.Mode="DISENCHANT"e.ConfirmDisenchant:Show()e.ConfirmDisenchant.text:SetText("Are you sure you want to remove\nMystic Enchant from following item:\n(This will remove the enchant from the item)\n\n"..t)e.ConfirmDisenchant.Alert:SetTexture(n)end
local function U()if not(EnchantReRollFrame.item or EnchantReRollFrame.Bag or EnchantReRollFrame.Slot)then
return false
end
local t,t,t,t,t,t,t,t,t,a=GetItemInfo(EnchantReRollFrame.item)local t=0
local o=0
local n=0
if not(l=="Token")then
t,o,n=GetGoldForMoney(l)e.ConfirmDisenchant.text:SetText("|cffE1AB18Collection Reforge Cost: |cffFFFFFF"..t.." |TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-5|t "..o.." |TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-5|t "..n.." |TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-5|t|r\n|cffE1AB18Reforge Success Chance: |cffFFFFFF"..e.SuccessChance.."%|r\n\nAre you sure you want to continue?\n")e.ConfirmDisenchant.Alert:SetTexture(a)else
e.ConfirmDisenchant.text:SetText("|cffE1AB18Collection Reforge Cost: |cffFFFFFF"..E.." |TInterface\\Icons\\inv_custom_CollectionRCurrency.blp:11:11:0:-5|t\n|cffE1AB18Reforge Success Chance: |cffFFFFFF100%|r\n\nAre you sure you want to continue?\n")e.ConfirmDisenchant.Alert:SetTexture(c)end
e.ConfirmDisenchant.Mode="COLLECTIONREFORGE"e.ConfirmDisenchant:Show()end
local function i(t)for e=1,15 do
_G["CollectionItemFrame"..e]:Hide()end
local n={}local o=t*e.MaxEcnhantsPerPage-(e.MaxEcnhantsPerPage-1)local t=t*e.MaxEcnhantsPerPage
if(#e.CurrentList<t)then
t=#e.CurrentList
end
for t=o,t do
table.insert(n,e.CurrentList[t])end
local t=1
while(t<=#n)do
local a=n[t][1][1]local o=n[t][1][2]local l=n[t][3]local n,i,r=GetSpellInfo(o)local i=GetEnchantColor(i)if not(n)then
print("|cffFFFF00Please, update your patch. Client can't load spell "..o.." for using in enchant collection|r")return false
end
_G["CollectionItemFrame"..t..".BackgroundTexture"]:SetTexture(r)if(l)then
_G["CollectionItemFrame"..t..".Button"]:Enable()_G["CollectionItemFrame"..t..".Button.TextNormal"]:SetTextColor(1,1,1,textAlpha)_G["CollectionItemFrame"..t..".BackgroundTexture"]:SetVertexColor(1,1,1,1)_G["CollectionItemFrame"..t..".Button.Enchant"]=a
if(a==e.CollectionsEnchant)then
_G["CollectionItemFrame"..t..".Button"]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemActive")e.ActiveEnchantButton=t
else
_G["CollectionItemFrame"..t..".Button"]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemNormal")end
else
_G["CollectionItemFrame"..t..".Button"]:Disable()_G["CollectionItemFrame"..t..".Button.TextNormal"]:SetTextColor(0,0,0,.3)_G["CollectionItemFrame"..t..".BackgroundTexture"]:SetVertexColor(.4,.4,.4,.8)end
_G["CollectionItemFrame"..t..".Button.Spell"]="|Hspell:"..o.."|h["..n.."]|h"_G["CollectionItemFrame"..t..".Button.TextNormal"]:SetText(i..n.."|r")_G["CollectionItemFrame"..t]:Show()t=t+1
end
end
local function u(t)CollectionListFrame.PageText:SetText("Page "..t.."/"..e.PageCount)end
local function f(e)if not(e)then
return 0
end
local n=e[2]local e=0
local t=nil
if not(n)then
return e
end
_,t,_=GetSpellInfo(n)if not(t)then
return e
end
_,e=GetEnchantColor(t)if(e)then
e=tonumber(e)else
e=0
end
return e
end
local function c(e,n,a)if n>a then
return
end
local t=n
for o=n+1,a do
if(e[o][4]<e[n][4])then
t=t+1
e[t],e[o]=e[o],e[t]end
end
e[t],e[n]=e[n],e[t]c(e,n,t-1)c(e,t+1,a)end
local function n(n,t)e.CurrentList={}if not(t)then
t=1
end
for n,t in pairs(n)do
table.insert(e.CurrentList,t)end
c(e.CurrentList,1,#e.CurrentList)e.PageCount=math.ceil(#e.CurrentList/e.MaxEcnhantsPerPage)if(e.PageCount<1)then
e.PageCount=1
end
e.CurrentPage=t
u(e.CurrentPage)if(e.PageCount<=1)then
CollectionListFrame.NextButton:Disable()else
CollectionListFrame.NextButton:Enable()end
if(t==1)then
CollectionListFrame.PrevButton:Disable()end
i(t)end
local function A(t)PlaySound("igMainMenuContinue")e.CurrentPage=e.CurrentPage+1
if(e.CurrentPage==e.PageCount)then
t:Disable()end
if(CollectionListFrame.PrevButton:IsEnabled()==0)then
CollectionListFrame.PrevButton:Enable()end
u(e.CurrentPage)i(e.CurrentPage)end
local function C(t)PlaySound("igMainMenuContinue")e.CurrentPage=e.CurrentPage-1
if(e.CurrentPage==1)then
t:Disable()end
if(CollectionListFrame.NextButton:IsEnabled()==0)then
CollectionListFrame.NextButton:Enable()end
u(e.CurrentPage)i(e.CurrentPage)end
local function u(a)local t={}for o,r in pairs(e.EnchantList)do
if(e.EnchantList[o][2]==a)then
table.insert(t,e.EnchantList[o])end
end
n(t)end
local function c(a)local o={}for t,r in pairs(e.EnchantList)do
if(e.EnchantList[t][3]and a)then
table.insert(o,e.EnchantList[t])elseif not(a)and not(e.EnchantList[t][3])then
table.insert(o,e.EnchantList[t])end
end
n(o)end
local function i(a)local o={}for t,r in pairs(e.EnchantList)do
if(e.EnchantList[t][4]==a)then
table.insert(o,e.EnchantList[t])end
end
n(o)end
function ClearSearchEscape(e)local t=e:GetText()if not(t)or(t=="")then
e:ClearFocus(e)e:SetText("Search")return false
end
e:ClearFocus(e)end
local function R(t)local a={}local o=t:GetText()if not(o)or(o=="")or(o:lower()=="search")then
t:ClearFocus(t)t:SetText("Search")return false
end
o=o:lower()for t,r in pairs(e.EnchantList)do
local n=e.EnchantList[t][1][3]:lower()if(string.find(n,o))then
table.insert(a,e.EnchantList[t])end
end
n(a)t:ClearFocus(t)end
local function F(e)local n=0
local t=0
local o=0
if tonumber(e)then
n,t,o=GetGoldForMoney(e)EnchantReRollFrame.CostText:SetText("|cffE1AB18Reforge cost: |cffFFFFFF"..n.." |TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:0|t "..t.." |TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:0|t "..o.." |TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:0|t|r")else
EnchantReRollFrame.CostText:SetText("|cffE1AB18Reforge cost: |cffa335ee[Mystic Rune]|r|cffE1AB18 |cffFFFFFFx"..e[2].." |T"..S..".blp:12:12|t")end
end
function r.UnlockRefund(t,e)if(e)then
RefundFrame:Show()RefundFrame.HighLight.AnimGroup:Play()else
RefundFrame:Hide()end
end
function r.UpdateReRollCost(n,t)if not(EnchantReRollFrame.item)or not(e.Initializated)then
return false
end
F(t)end
function r.UpdateCollectionReForgeCost(n,t,e)l=t
if(l=="Token")then
E=e
end
end
function r.GetKnownEnchantsList(t,n)for n,t in pairs(n)do
e.EnchantList[t]={e.EnchantList[t][1],e.EnchantList[t][2],true,f(e.EnchantList[t][1])}end
e.KnownEnchants=#n
if(e.KnownEnchants>0)then
c(true)UIDropDownMenu_SetSelectedID(LookupFrameTypeSelect,4)end
end
function r.BuildEnchantList(o,t)e.EnchantList={}for o=1,#t do
local n=t[o][1]local o=t[o][2]if next(n)then
for n,t in pairs(n)do
e.EnchantList[t[1]]={t,o,false,f(t)}e.TotalEnchants=e.TotalEnchants+1
end
end
end
n(e.EnchantList)a.Handle("EnchantReRoll","RequestKnownList")end
function r.FillCollectionByEnchant(n,t)if not(t)or(t==0)then
return false
end
local t=e.EnchantList[t][1][2]local n,e,o=GetSpellInfo(t)local e=GetEnchantColor(e)CollectionListFrame.NewEnchantInCollection.Enchant="|Hspell:"..t.."|h["..n.."]|h"CollectionListFrame.NewEnchantInCollection.BackgroundTexture:SetTexture(o)CollectionListFrame.NewEnchantInCollection.TextNormal:SetText(e..CollectionListFrame.NewEnchantInCollection.Enchant.."|r")CollectionListFrame.NewEnchantInCollection.TextAdd:SetText("|cffFFFFFFYou have successfuly unlocked "..e..CollectionListFrame.NewEnchantInCollection.Enchant.."|r enchant")CollectionListFrame.NewEnchantInCollection.AnimationGroup:Stop()CollectionListFrame.NewEnchantInCollection.AnimationGroup:Play()end
function r.EnchantReRoll_PlaceItem(o,n,t,r,i,l)PlaySound("Glyph_MajorCreate")local c,c,c,c,c,c,c,c,c,o,c=GetItemInfo(n)ClearCursor()EnchantReRollFrame.Item.Button:SetNormalTexture(o)EnchantReRollFrame.item=n
EnchantReRollFrame.EffectCurrentName,EnchantReRollFrame.EffectCurrentQuality,EnchantTexture=GetSpellInfo(t)local n=GetEnchantColor(EnchantReRollFrame.EffectCurrentQuality)if(not(EnchantReRollFrame.EffectCurrentName))or(EnchantReRollFrame.EffectCurrentName=="Enchanting")then
EnchantReRollFrame.EffectCurrentName="Ready to be Enchanted!"t=964998
else
EnchantReRollFrame.Item.Button:SetNormalTexture(EnchantTexture)end
EnchantReRollFrame.EffectCurrent="|Hspell:"..t.."|h["..EnchantReRollFrame.EffectCurrentName.."]|h"EnchantReRollFrame.itemCost=r
EnchantReRollFrame.Slot=l
EnchantReRollFrame.Bag=i
F(EnchantReRollFrame.itemCost)EnchantReRollFrame.CurrentEnchant.EffectText:SetText(n..EnchantReRollFrame.EffectCurrent.."|r")EnchantReRollFrame.Item.BackgroundTexture:SetAlpha(1)BaseFrameFadeIn(EnchantReRollFrame.Item.BackgroundTexture.Effect)BaseFrameFadeIn(EnchantReRollFrame.CurrentEnchant)if not(t==964998)then
BaseFrameFadeIn(EnchantReRollFrame.Item.Button.Disenchant)elseif(EnchantReRollFrame.Item.Button.Disenchant:IsVisible())then
BaseFrameFadeOut(EnchantReRollFrame.Item.Button.Disenchant)end
if(EnchantReRollFrame.Bag and EnchantReRollFrame.Slot and e.CollectionsEnchant~=0)then
a.Handle("EnchantReRoll","RequestCollectionReforgeCost",EnchantReRollFrame.Bag,EnchantReRollFrame.Slot,e.CollectionsEnchant)end
end
function r.EnchantReRoll_Init(t)PlaySound("Glyph_MajorCreate")CollectionController:Show()TomeCollectionsFrame:Hide()StoreCollectionFrame:Hide()SeasonalCollectionFrame:Hide()e:Show()CollectionController.CollectionControllerTab2:SetChecked(false)CollectionController.CollectionControllerTab3:SetChecked(false)CollectionController.CollectionControllerTab1:SetChecked(true)CollectionController.CollectionControllerTab2:Enable()CollectionController.CollectionControllerTab3:Enable()CollectionController.CollectionControllerTab1:Disable()e.Initializated=true
end
function r.EnchantReRoll_Close(t)PlaySound("igMainMenuOptionCheckBoxOn")e:Hide()CollectionController:Hide()end
function r.EnchantReRollMain_Reforge(n,t)EnchantReRollFrame.EffectReforgedName,EnchantReRollFrame.EffectReforgedQuality,EnchantReRollFrame.EffectReforgedTexture=GetSpellInfo(t)local o,n=GetEnchantColor(EnchantReRollFrame.EffectReforgedQuality)if(not(EnchantReRollFrame.EffectReforgedName))or(EnchantReRollFrame.EffectReforgedName=="Enchanting")then
print("|cff00FF00==Enchant Reforge debug==")print(t)print("|cff00FF00==Enchant Reforge debug==")EnchantReRollFrame.EffectReforgedName="Enhant Reforged"n=0
EnchantReRollFrame.EffectReforgedQuality=nil
o=e.EnchantQualitySettings[n][0]t=964998
end
EnchantReRollFrame.EffectReforged="|Hspell:"..t.."|h["..EnchantReRollFrame.EffectReforgedName.."]|h"EnchantReRollFrame.ReforgedEnchant.EffectText:SetText(o..EnchantReRollFrame.EffectReforged.."|r")if not(t==964998)and not(EnchantReRollFrame.Item.Button.Disenchant:IsVisible())then
BaseFrameFadeIn(EnchantReRollFrame.Item.Button.Disenchant)end
if(e.CollectionsEnchant~=0)then
a.Handle("EnchantReRoll","RequestSuccessChance",e.CollectionsEnchant)end
D(n)end
function r.UpdateProgress(a,n,o,t)if(tonumber(e.ProgressBar.TitleText:GetText())~=n)then
e.ProgressBar.MinMaxValues=t
e.ProgressBar.ValueToSet=t-o
e.ProgressBar.NextLevel=n
e.ProgressBar.Hover.AnimationGroup:Play()else
e.ProgressBar:SetMinMaxValues(0,t)e.ProgressBar:SetValue(t-o)e.ProgressBar.TitleText:SetText(n)end
end
function r.GetSuccessChance(n,t)e.SuccessChance=t
end
e:SetSize(784,512)e:SetPoint("CENTER",0,0)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantRework",insets={left=-120,right=-120,top=-256,bottom=-256}})e.CloseButton=CreateFrame("Button","CollectionsFrameCloseButton",e,"UIPanelCloseButton")e.CloseButton:SetPoint("TOPRIGHT",-4,-1)e.CloseButton:EnableMouse(true)e.CloseButton:SetScript("OnMouseUp",function()PlaySound("QUESTLOGCLOSE")CollectionController:Hide()end)e:RegisterEvent("ITEM_LOCKED")e:RegisterEvent("ITEM_UNLOCKED")e:SetScript("OnEvent",function(t,e,...)if(e=="ITEM_LOCKED")then
y(...)elseif(e=="ITEM_UNLOCKED")then
O(...)end
end)e:SetScript("OnHide",B)e:SetScript("OnShow",I)e.TitleText=e:CreateFontString("CollectionsFrameTitleText")e.TitleText:SetFont("Fonts\\FRIZQT__.TTF",12)e.TitleText:SetFontObject(GameFontNormal)e.TitleText:SetPoint("TOP",0,-11)e.TitleText:SetShadowOffset(1,-1)e.TitleText:SetText("Mystic Altar")e.AdditionalText=e:CreateFontString("CollectionsFrameAdditionalText")e.AdditionalText:SetFont("Fonts\\FRIZQT__.TTF",11)e.AdditionalText:SetFontObject(GameFontHighlight)e.AdditionalText:SetPoint("TOP",-45,-41)e.AdditionalText:SetShadowOffset(1,-1)e.AdditionalText:SetText("|cffa335ee[Mystic Rune]|r:  |T"..S..".blp:12:12|t |cffa335ee[Mystic Extract]|r:  |T"..h..".blp:12:12|t")e.AdditionalText:SetJustifyH("RIGHT")e.ProgressBar=CreateFrame("StatusBar","CollectionsFrameProgressBar",e)e.ProgressBar:SetBackdrop(GameTooltip:GetBackdrop())e.ProgressBar:SetBackdropColor(0,0,0,1)e.ProgressBar:SetBackdropBorderColor(0,0,0,1)e.ProgressBar:SetSize(280,13)e.ProgressBar:SetPoint("BOTTOM",0,11)e.ProgressBar:SetStatusBarTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsBarEnchants")e.ProgressBar:SetMinMaxValues(0,100)e.ProgressBar:SetValue(0)e.ProgressBar:GetStatusBarTexture():SetDrawLayer("BORDER")e.ProgressBar:EnableMouse(true)e.ProgressBar.ArtWork=e.ProgressBar:CreateTexture(nil,"ARTWORK")e.ProgressBar.ArtWork:SetSize(512,64)e.ProgressBar.ArtWork:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsBar")e.ProgressBar.ArtWork:SetPoint("CENTER",e.ProgressBar,0,25)e.ProgressBar.ArtWork_Hover=e.ProgressBar:CreateTexture(nil,"OVERLAY")e.ProgressBar.ArtWork_Hover:SetSize(512,64)e.ProgressBar.ArtWork_Hover:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsBar_Hover")e.ProgressBar.ArtWork_Hover:SetPoint("CENTER",e.ProgressBar,0,25)e.ProgressBar.ArtWork_Hover:SetBlendMode("ADD")e.ProgressBar.ArtWork_Hover:SetAlpha(0)e.ProgressBar.ArtWork_Hover:Hide()e.ProgressBar.Hover=e.ProgressBar:CreateTexture(nil,"OVERLAY")e.ProgressBar.Hover:SetSize(280,13)e.ProgressBar.Hover:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsBarEnchants")e.ProgressBar.Hover:SetPoint("CENTER",0,0)e.ProgressBar.Hover:SetBlendMode("ADD")e.ProgressBar.Hover:Hide()e.ProgressBar.TitleText=e.ProgressBar:CreateFontString("CollectionsFrameTitleText","OVERLAY")e.ProgressBar.TitleText:SetFont("Fonts\\FRIZQT__.TTF",11)e.ProgressBar.TitleText:SetFontObject(GameFontNormal)e.ProgressBar.TitleText:SetPoint("TOP",0,13)e.ProgressBar.TitleText:SetShadowOffset(1,-1)e.ProgressBar.TitleText:SetText(e.KnownEnchants)e.SearchBox=CreateFrame("EditBox","CollectionsFrameSearchBox",e,"InputBoxTemplate")e.SearchBox:SetWidth(110)e.SearchBox:SetHeight(26)e.SearchBox:SetFontObject(GameFontNormal)e.SearchBox:SetPoint("TOPRIGHT",e,-107,-33)e.SearchBox:ClearFocus(self)e.SearchBox:SetAutoFocus(false)e.SearchBox:SetFontObject(GameFontDisable)e.SearchBox:SetScript("OnEnterPressed",R)e.SearchBox:SetScript("OnEscapePressed",ClearSearchEscape)e.SearchBox:SetText("Search")e.EnchantTypeList=CreateFrame("Button","LookupFrameTypeSelect",e,"UIDropDownMenuTemplate")e.EnchantTypeList:SetPoint("TOPRIGHT",e,-10,-32)e.EnchantTypeList.List={"All","Weapon Enchants","Armor and Weapon Enchants","Known enchants","Unknown enchants","Common","|cff1eff00Uncommon|r","|cff0070ddRare|r","|cffa335eeEpic|r","|cffff8000Legendary|r",}function e.EnchantTypeList.Init(t,a)local o=UIDropDownMenu_CreateInfo()for r,t in pairs(e.EnchantTypeList.List)do
o=UIDropDownMenu_CreateInfo()o.text=t
o.value=t
o.func=function(t)UIDropDownMenu_SetSelectedID(LookupFrameTypeSelect,t:GetID())if(t:GetID()==1)then
n(e.EnchantList)elseif(t:GetID()==2)then
u("WEAPON")elseif(t:GetID()==3)then
u("ANY")elseif(t:GetID()==4)then
c(true)elseif(t:GetID()==5)then
c(false)elseif(t:GetID()==6)then
i(1)elseif(t:GetID()==7)then
i(2)elseif(t:GetID()==8)then
i(3)elseif(t:GetID()==9)then
i(4)elseif(t:GetID()==10)then
i(5)end
end
UIDropDownMenu_AddButton(o,a)end
end
UIDropDownMenu_Initialize(e.EnchantTypeList,e.EnchantTypeList.Init)UIDropDownMenu_SetWidth(e.EnchantTypeList,60);UIDropDownMenu_SetButtonWidth(e.EnchantTypeList,70)UIDropDownMenu_SetSelectedID(e.EnchantTypeList,1)UIDropDownMenu_JustifyText(e.EnchantTypeList,"LEFT")e.ProgressBar.ArtWork_Hover.AnimationGroup=e.ProgressBar.ArtWork_Hover:CreateAnimationGroup()e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha=e.ProgressBar.ArtWork_Hover.AnimationGroup:CreateAnimation("Alpha")e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetStartDelay(0)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetDuration(.5)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetOrder(1)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetEndDelay(0)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetSmoothing("IN_OUT")e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetChange(1)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha:SetScript("OnPlay",function()PlaySound("LEVELUP")e.ProgressBar.ArtWork_Hover:Show()end)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2=e.ProgressBar.ArtWork_Hover.AnimationGroup:CreateAnimation("Alpha")e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetStartDelay(0)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetDuration(2)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetOrder(2)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetEndDelay(0)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetSmoothing("NONE")e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetChange(-1)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetScript("OnFinished",function()e.ProgressBar.ArtWork_Hover:SetAlpha(0)e.ProgressBar.ArtWork_Hover:Hide()end)e.ProgressBar.ArtWork_Hover.AnimationGroup.Alpha2:SetScript("OnStop",function()e.ProgressBar.ArtWork_Hover:SetAlpha(0)e.ProgressBar.ArtWork_Hover:Hide()end)e.ProgressBar.Hover.AnimationGroup=e.ProgressBar.Hover:CreateAnimationGroup()e.ProgressBar.Hover.AnimationGroup.Scale=e.ProgressBar.Hover.AnimationGroup:CreateAnimation("Scale")e.ProgressBar.Hover.AnimationGroup.Scale:SetStartDelay(0)e.ProgressBar.Hover.AnimationGroup.Scale:SetDuration(0)e.ProgressBar.Hover.AnimationGroup.Scale:SetOrder(1)e.ProgressBar.Hover.AnimationGroup.Scale:SetEndDelay(0)e.ProgressBar.Hover.AnimationGroup.Scale:SetScale(.1,1)e.ProgressBar.Hover.AnimationGroup.Scale:SetScript("OnPlay",function()BaseFrameFadeIn(e.ProgressBar.Hover)e.ProgressBar.ArtWork_Hover.AnimationGroup:Play()end)e.ProgressBar.Hover.AnimationGroup.Scale2=e.ProgressBar.Hover.AnimationGroup:CreateAnimation("Scale")e.ProgressBar.Hover.AnimationGroup.Scale2:SetDuration(.2)e.ProgressBar.Hover.AnimationGroup.Scale2:SetOrder(2)e.ProgressBar.Hover.AnimationGroup.Scale2:SetEndDelay(0)e.ProgressBar.Hover.AnimationGroup.Scale2:SetScale(10,1)e.ProgressBar.Hover.AnimationGroup.Scale2:SetScript("OnFinished",function()BaseFrameFadeOut(e.ProgressBar.Hover)e.ProgressBar:SetMinMaxValues(0,e.ProgressBar.MinMaxValues)e.ProgressBar:SetValue(e.ProgressBar.ValueToSet)e.ProgressBar.TitleText:SetText(e.ProgressBar.NextLevel)end)e.ProgressBar.Hover.AnimationGroup.Scale2:SetScript("OnStop",function()BaseFrameFadeOut(e.ProgressBar.Hover)e.ProgressBar:SetMinMaxValues(0,e.ProgressBar.MinMaxValues)e.ProgressBar:SetValue(e.ProgressBar.ValueToSet)e.ProgressBar.TitleText:SetText(e.ProgressBar.NextLevel)end)local t=CreateFrame("FRAME","EnchantReRollFrame",e,nil)t:SetSize(290,340)t:SetPoint("LEFT",10,-60)t:RegisterEvent("BAG_UPDATE")t:SetScript("OnEvent",T)t.TitleText=t:CreateFontString("EnchantReRollFrameTitleText")t.TitleText:SetFont("Fonts\\FRIZQT__.TTF",11)t.TitleText:SetFontObject(GameFontNormal)t.TitleText:SetPoint("TOP",0,23)t.TitleText:SetShadowOffset(1,-1)t.TitleText:SetText("|cffFFFFFFExtract|r enchants to fill your Collection")t.RollButton=CreateFrame("Button","EnchantReRollFrameRollButton",t,"UIPanelButtonTemplate")t.RollButton:SetWidth(120)t.RollButton:SetHeight(22)t.RollButton:SetPoint("BOTTOMRIGHT",-10,16)t.RollButton:RegisterForClicks("AnyUp")t.RollButton:SetText("Reforge Item")t.RollButton:Disable()t.RollButton:SetScript("OnMouseDown",N)t.RollButton:SetScript("OnUpdate",b)t.RollButton:SetScript("OnEnter",function(e)if(t.item)and(e:IsEnabled()==1)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT")d(GameTooltip,t.item)end
end)t.RollButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)t.UseKnownEnchantButton=CreateFrame("Button","EnchantReRollFrameUseKnownEnchantButton",t,"UIPanelButtonTemplate")t.UseKnownEnchantButton:SetWidth(120)t.UseKnownEnchantButton:SetHeight(22)t.UseKnownEnchantButton:SetPoint("BOTTOMLEFT",10,16)t.UseKnownEnchantButton:RegisterForClicks("AnyUp")t.UseKnownEnchantButton:SetText("Collection Reforge")t.UseKnownEnchantButton:Disable()t.UseKnownEnchantButton:SetScript("OnMouseDown",U)t.UseKnownEnchantButton:SetScript("OnUpdate",v)t.UseKnownEnchantButton:SetScript("OnEnter",function(e)if(t.item)and(e:IsEnabled()==1)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT")d(GameTooltip,t.item)end
end)t.UseKnownEnchantButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)t.CostText=t:CreateFontString("EnchantReRollFrameCostText")t.CostText:SetFont("Fonts\\FRIZQT__.TTF",12)t.CostText:SetShadowOffset(0,-1)t.CostText:SetPoint("BOTTOM",0,48)t.CostText:SetShadowOffset(0,0)t.CurrentEnchant=CreateFrame("Frame","EnchantReRollFrame.CurrentEnchant",t,nil)t.CurrentEnchant:SetSize(100,44)t.CurrentEnchant:SetPoint("CENTER",0,30)t.CurrentEnchant:SetFrameLevel(8)t.CurrentEnchant:EnableMouse(true)t.CurrentEnchant:SetScript("OnEnter",G)t.CurrentEnchant:SetScript("OnLeave",function()GameTooltip:Hide()end)t.CurrentEnchant:Hide()t.CurrentEnchant.BackgroundTexture=t.CurrentEnchant:CreateTexture(nil,"BACKGROUND")t.CurrentEnchant.BackgroundTexture:SetSize(420,420)t.CurrentEnchant.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_textH")t.CurrentEnchant.BackgroundTexture:SetPoint("CENTER",t.CurrentEnchant,0,-50)t.CurrentEnchant.EffectText=t.CurrentEnchant:CreateFontString("EnchantReRollFrameCurrentEnchantEffectText")t.CurrentEnchant.EffectText:SetFont("Fonts\\MORPHEUS.TTF",14,"OUTLINE")t.CurrentEnchant.EffectText:SetShadowOffset(1,-1)t.CurrentEnchant.EffectText:SetSize(200,14)t.CurrentEnchant.EffectText:SetPoint("CENTER",t.CurrentEnchant,0,5)t.CurrentEnchant.EffectText:SetShadowOffset(0,0)t.CurrentEnchant.EffectText:SetText("|cff00FF00Enchant Effect|r")t.ReforgedEnchant=CreateFrame("Frame","EnchantReRollFrame.ReforgedEnchant",t,nil)t.ReforgedEnchant:SetSize(100,44)t.ReforgedEnchant:SetPoint("CENTER",0,-40)t.ReforgedEnchant:SetFrameLevel(8)t.ReforgedEnchant:EnableMouse(true)t.ReforgedEnchant:SetScript("OnEnter",x)t.ReforgedEnchant:SetScript("OnLeave",function()GameTooltip:Hide()end)t.ReforgedEnchant:Hide()t.ReforgedEnchant.BackgroundTexture=t.ReforgedEnchant:CreateTexture(nil,"BACKGROUND")t.ReforgedEnchant.BackgroundTexture:SetSize(420,420)t.ReforgedEnchant.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_textH")t.ReforgedEnchant.BackgroundTexture:SetPoint("CENTER",t.ReforgedEnchant,0,-50)t.ReforgedEnchant.BackgroundTexture:SetBlendMode("ADD")t.ReforgedEnchant.EffectText=t.ReforgedEnchant:CreateFontString("EnchantReRollFrameReforgedEnchantEffectText")t.ReforgedEnchant.EffectText:SetFont("Fonts\\MORPHEUS.TTF",14,"OUTLINE")t.ReforgedEnchant.EffectText:SetShadowOffset(1,-1)t.ReforgedEnchant.EffectText:SetSize(200,14)t.ReforgedEnchant.EffectText:SetPoint("CENTER",t.ReforgedEnchant,0,5)t.ReforgedEnchant.EffectText:SetShadowOffset(0,0)t.ReforgedEnchant.EffectText:SetText("|cff00FF00Reforged Effect|r")t.Item=CreateFrame("Frame","EnchantReRollFrameItem",t,nil)t.Item:SetSize(108,108)t.Item:SetPoint("CENTER",0,100)t.Item:SetFrameLevel(8)t.Item:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemslot",})t.Item.Button=CreateFrame("Button","EnchantReRollFrameItemButton",t.Item,nil)t.Item.Button:SetSize(34,34)t.Item.Button:SetPoint("CENTER",0,0)t.Item.Button:EnableMouse(true)t.Item.Button:SetFrameLevel(8)t.Item.Button:SetHighlightTexture("Interface\\BUTTONS\\ButtonHilight-Square")t.Item.Button:SetScript("OnMouseDown",function(e)m(e,false)end)t.Item.Button:SetScript("OnEnter",M)t.Item.Button:SetScript("OnLeave",function()GameTooltip:Hide()end)t.Item.Border=t.Item.Button:CreateTexture(nil,"OVERLAY")t.Item.Border:SetSize(t.Item:GetSize())t.Item.Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemborder")t.Item.Border:SetPoint("CENTER",1,-2)t.Item.Button.Disenchant=CreateFrame("Button","EnchantReRollFrameItemButtonDisenchant",t.Item.Button,nil)t.Item.Button.Disenchant:SetSize(45,45)t.Item.Button.Disenchant:SetPoint("CENTER",16,-16)t.Item.Button.Disenchant:EnableMouse(true)t.Item.Button.Disenchant:SetFrameLevel(9)t.Item.Button.Disenchant:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DisenchantIcon")t.Item.Button.Disenchant:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DisenchantIconPushed")t.Item.Button.Disenchant:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DisenchantIconPushed")t.Item.Button.Disenchant:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DisenchantIconHighLight")t.Item.Button.Disenchant:SetScript("OnEnter",L)t.Item.Button.Disenchant:SetScript("OnClick",P)t.Item.Button.Disenchant:SetScript("OnLeave",function()GameTooltip:Hide()end)t.Item.Button.Disenchant:SetScript("OnShow",s)t.Item.Button.Disenchant:Hide()t.Item.Background=CreateFrame("FRAME","EnchantReRollFrameItemBackground",t)t.Item.Background:SetSize(t:GetSize())t.Item.Background:SetPoint("CENTER")t.Item.Background:SetFrameLevel(7)t.Item.BackgroundTexture=t.Item.Background:CreateTexture(nil,"BACKGROUND")t.Item.BackgroundTexture:SetSize(256,64)t.Item.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemHighlight")t.Item.BackgroundTexture:SetPoint("CENTER",t.Item,0,-5)t.Item.BackgroundTexture:SetBlendMode("ADD")t.Item.BackgroundTexture:SetAlpha(.6)t.Item.BackgroundTexture.Effect=CreateFrame("Model","EnchantReRollFrameItemBackgroundTextureEffect",t.Item.Background)t.Item.BackgroundTexture.Effect:SetWidth(256);t.Item.BackgroundTexture.Effect:SetHeight(256);t.Item.BackgroundTexture.Effect:SetPoint("CENTER",t.Item,"CENTER",0,-20)t.Item.BackgroundTexture.Effect:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")t.Item.BackgroundTexture.Effect:SetModelScale(.07)t.Item.BackgroundTexture.Effect:SetCamera(0)t.Item.BackgroundTexture.Effect:SetPosition(.08,.1,0)t.Item.BackgroundTexture.Effect:SetFacing(.1)t.Item.BackgroundTexture.Effect:Hide()RefundFrame=CreateFrame("FRAME","RefundFrame",t,nil)RefundFrame:SetSize(256,32)RefundFrame:SetPoint("CENTER",0,-89)RefundFrame.BG=RefundFrame:CreateTexture(nil,"OVERLAY")RefundFrame.BG:SetAllPoints()RefundFrame.BG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\Enchant_RefundButton")RefundFrame.HighLight=RefundFrame:CreateTexture(nil,"OVERLAY")RefundFrame.HighLight:SetAllPoints()RefundFrame.HighLight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\Enchant_RefundButton_Highlight")RefundFrame.HighLight:SetBlendMode("ADD")RefundFrame.HighLight:Hide()RefundFrame.Button=CreateFrame("Button","RefundFrameButton",RefundFrame,"StaticPopupButtonTemplate")RefundFrame.Button:SetPoint("CENTER",1,0)RefundFrame.Button:EnableMouse(true)RefundFrame.Button:SetScript("OnMouseUp",function(n)if(t.item and t.Bag and t.Slot and e.CollectionsEnchant)then
PlaySound("igMainMenuOptionCheckBoxOn")a.Handle("EnchantReRoll","RefundEnchant",t.Bag,t.Slot,e.CollectionsEnchant)end
end)RefundFrame.Button:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFOops, seems like we changed that enchant!|r")GameTooltip:AddLine("You can exchange the enchant on this item to equal or lower\nquality enchant using this option")GameTooltip:Show()end)RefundFrame.Button:SetScript("OnLeave",function(e)GameTooltip:Hide()end)RefundFrame.Button:SetText("Exchange Enchant")RefundFrame.Button:SetWidth(148)RefundFrame.Button:SetHeight(21)RefundFrame.Button:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\UI-DialogBox-Button-Up_Green")RefundFrame.Button:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\UI-DialogBox-Button-Highlight_Green")RefundFrame.Button:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\UI-DialogBox-Button-Down_Green")RefundFrame.HighLight.AnimGroup=RefundFrame.HighLight:CreateAnimationGroup()RefundFrame.HighLight.AnimGroup.Alpha0=RefundFrame.HighLight.AnimGroup:CreateAnimation("Alpha")RefundFrame.HighLight.AnimGroup.Alpha0:SetStartDelay(0)RefundFrame.HighLight.AnimGroup.Alpha0:SetDuration(0)RefundFrame.HighLight.AnimGroup.Alpha0:SetOrder(1)RefundFrame.HighLight.AnimGroup.Alpha0:SetEndDelay(0)RefundFrame.HighLight.AnimGroup.Alpha0:SetChange(-1)RefundFrame.HighLight.AnimGroup.Alpha0:SetScript("OnPlay",function()RefundFrame.HighLight:Show()end)RefundFrame.HighLight.AnimGroup.Alpha=RefundFrame.HighLight.AnimGroup:CreateAnimation("Alpha")RefundFrame.HighLight.AnimGroup.Alpha:SetStartDelay(0)RefundFrame.HighLight.AnimGroup.Alpha:SetDuration(.5)RefundFrame.HighLight.AnimGroup.Alpha:SetOrder(2)RefundFrame.HighLight.AnimGroup.Alpha:SetEndDelay(0)RefundFrame.HighLight.AnimGroup.Alpha:SetSmoothing("IN_OUT")RefundFrame.HighLight.AnimGroup.Alpha:SetChange(1)RefundFrame.HighLight.AnimGroup.Alpha2=RefundFrame.HighLight.AnimGroup:CreateAnimation("Alpha")RefundFrame.HighLight.AnimGroup.Alpha2:SetStartDelay(0)RefundFrame.HighLight.AnimGroup.Alpha2:SetDuration(2)RefundFrame.HighLight.AnimGroup.Alpha2:SetOrder(3)RefundFrame.HighLight.AnimGroup.Alpha2:SetEndDelay(0)RefundFrame.HighLight.AnimGroup.Alpha2:SetSmoothing("NONE")RefundFrame.HighLight.AnimGroup.Alpha2:SetChange(-1)RefundFrame.HighLight.AnimGroup.Alpha2:SetScript("OnFinished",function()RefundFrame.HighLight:Hide()end)RefundFrame.HighLight.AnimGroup.Alpha2:SetScript("OnStop",function()RefundFrame.HighLight:Hide()end)RefundFrame:Hide()e.AnimationFrame=CreateFrame("FRAME","CollectionsFrameAnimationFrame",e,nil)e.AnimationFrame:SetSize(e:GetSize())e.AnimationFrame:SetPoint("CENTER",0,0)e.AnimationFrame.GlassGlowTexture=e.AnimationFrame:CreateTexture(nil,"ARTWORK")e.AnimationFrame.GlassGlowTexture:SetSize(1024,1024)e.AnimationFrame.GlassGlowTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary")e.AnimationFrame.GlassGlowTexture:SetPoint("CENTER")e.AnimationFrame.GlassGlowTexture:SetAlpha(.9)e.AnimationFrame.GlassGlowTextureAdd=e.AnimationFrame:CreateTexture(nil,"ARTWORK")e.AnimationFrame.GlassGlowTextureAdd:SetSize(1024,1024)e.AnimationFrame.GlassGlowTextureAdd:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\EnchantEffect_Legendary")e.AnimationFrame.GlassGlowTextureAdd:SetPoint("CENTER")e.AnimationFrame.GlassGlowTextureAdd:SetAlpha(.5)e.AnimationFrame.GlassGlowTextureAdd:SetBlendMode("ADD")e.AnimationFrame.Effect=CreateFrame("Model","CollectionsFrameAnimationFrameEffect",e.AnimationFrame)e.AnimationFrame.Effect:SetWidth(300);e.AnimationFrame.Effect:SetHeight(300);e.AnimationFrame.Effect:SetPoint("LEFT",31,158)e.AnimationFrame.Effect:SetModel("Spells\\Creature_spellportallarge_green.m2")e.AnimationFrame.Effect:SetModelScale(.01)e.AnimationFrame.Effect:SetCamera(0)e.AnimationFrame.Effect:SetPosition(.08,.1,0)e.AnimationFrame.Effect:SetFacing(1)e.AnimationFrame:Hide()e.AnimationFrame.AnimationGroup=e.AnimationFrame:CreateAnimationGroup()e.AnimationFrame.AnimationGroup.Alpha=e.AnimationFrame.AnimationGroup:CreateAnimation("Alpha")e.AnimationFrame.AnimationGroup.Alpha:SetStartDelay(0)e.AnimationFrame.AnimationGroup.Alpha:SetDuration(.2)e.AnimationFrame.AnimationGroup.Alpha:SetOrder(1)e.AnimationFrame.AnimationGroup.Alpha:SetEndDelay(3)e.AnimationFrame.AnimationGroup.Alpha:SetSmoothing("IN_OUT")e.AnimationFrame.AnimationGroup.Alpha:SetChange(1)e.AnimationFrame.AnimationGroup.Alpha:SetScript("OnPlay",function()PlaySound("Glyph_MajorCreate")e.AnimationFrame.Effect.AnimationGroup:Play()e.AnimationFrame:SetAlpha(0)e.AnimationFrame:Show()end)e.AnimationFrame.AnimationGroup.Alpha:SetScript("OnFinished",function()t.ReforgedEnchant.AnimationGroup:Play()end)e.AnimationFrame.AnimationGroup.Alpha:SetScript("OnStop",function()t.ReforgedEnchant.AnimationGroup:Play()end)e.AnimationFrame.AnimationGroup.Alpha2=e.AnimationFrame.AnimationGroup:CreateAnimation("Alpha")e.AnimationFrame.AnimationGroup.Alpha2:SetStartDelay(0)e.AnimationFrame.AnimationGroup.Alpha2:SetDuration(9)e.AnimationFrame.AnimationGroup.Alpha2:SetOrder(2)e.AnimationFrame.AnimationGroup.Alpha2:SetEndDelay(0)e.AnimationFrame.AnimationGroup.Alpha2:SetSmoothing("NONE")e.AnimationFrame.AnimationGroup.Alpha2:SetChange(-1)e.AnimationFrame.Effect.AnimationGroup=e.AnimationFrame.Effect:CreateAnimationGroup()e.AnimationFrame.Effect.AnimationGroup.Alpha=e.AnimationFrame.Effect.AnimationGroup:CreateAnimation("Alpha")e.AnimationFrame.Effect.AnimationGroup.Alpha:SetStartDelay(0)e.AnimationFrame.Effect.AnimationGroup.Alpha:SetDuration(.2)e.AnimationFrame.Effect.AnimationGroup.Alpha:SetOrder(1)e.AnimationFrame.Effect.AnimationGroup.Alpha:SetEndDelay(3)e.AnimationFrame.Effect.AnimationGroup.Alpha:SetSmoothing("IN_OUT")e.AnimationFrame.Effect.AnimationGroup.Alpha:SetChange(1)e.AnimationFrame.Effect.AnimationGroup.Alpha:SetScript("OnPlay",function()e.AnimationFrame.Effect:SetAlpha(0)end)e.AnimationFrame.Effect.AnimationGroup.Alpha2=e.AnimationFrame.Effect.AnimationGroup:CreateAnimation("Alpha")e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetStartDelay(0)e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetDuration(9)e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetOrder(2)e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetEndDelay(0)e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetSmoothing("NONE")e.AnimationFrame.Effect.AnimationGroup.Alpha2:SetChange(-1)t.ReforgedEnchant.AnimationGroup=t.ReforgedEnchant:CreateAnimationGroup()t.ReforgedEnchant.AnimationGroup.Scale=t.ReforgedEnchant.AnimationGroup:CreateAnimation("Scale")t.ReforgedEnchant.AnimationGroup.Scale:SetStartDelay(0)t.ReforgedEnchant.AnimationGroup.Scale:SetDuration(0)t.ReforgedEnchant.AnimationGroup.Scale:SetOrder(1)t.ReforgedEnchant.AnimationGroup.Scale:SetEndDelay(0)t.ReforgedEnchant.AnimationGroup.Scale:SetScale(.1,1)t.ReforgedEnchant.AnimationGroup.Scale:SetScript("OnPlay",function()BaseFrameFadeIn(t.ReforgedEnchant)end)t.ReforgedEnchant.AnimationGroup.Scale2=t.ReforgedEnchant.AnimationGroup:CreateAnimation("Scale")t.ReforgedEnchant.AnimationGroup.Scale2:SetDuration(1.5)t.ReforgedEnchant.AnimationGroup.Scale2:SetOrder(2)t.ReforgedEnchant.AnimationGroup.Scale2:SetEndDelay(1)t.ReforgedEnchant.AnimationGroup.Scale2:SetScale(10,1)t.ReforgedEnchant.AnimationGroup.Scale2:SetScript("OnPlay",function()e.AnimationInProcess=false
end)t.ReforgedEnchant.AnimationGroup.Scale2:SetScript("OnFinished",function()p()BaseFrameFadeOut(t.ReforgedEnchant)end)t.ReforgedEnchant.AnimationGroup.Scale2:SetScript("OnStop",function()p()BaseFrameFadeOut(t.ReforgedEnchant)end)local n=CreateFrame("FRAME","CollectionListFrame",e,nil)n:SetPoint("CENTER",150,-15)n:SetSize(470,425)n:EnableMouseWheel(true)n.TitleText=n:CreateFontString("EnchantReRollFrameTitleText")n.TitleText:SetFont("Fonts\\MORPHEUS.TTF",14)n.TitleText:SetFontObject(GameFontNormal)n.TitleText:SetPoint("TOP",0,-37)n.TitleText:SetShadowOffset(0,-1)n.TitleText:SetText("Enchant Collection")n.PageText=n:CreateFontString("EnchantReRollFramePageText")n.PageText:SetFont("Fonts\\FRIZQT__.TTF",11)n.PageText:SetFontObject(GameFontHighlight)n.PageText:SetPoint("BOTTOM",0,28)n.PageText:SetShadowOffset(0,-1)n.BackgroundTexture=n:CreateTexture(nil,"BACKGROUND")n.BackgroundTexture:SetSize(110,55)n.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\main_b")n.BackgroundTexture:SetPoint("BOTTOM",n,0,8)n.NextButton=CreateFrame("Button","CollectionListFrameNextButton",n,nil)n.NextButton:SetSize(26,26)n.NextButton:SetPoint("BOTTOM",70,15)n.NextButton:EnableMouse(true)n.NextButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")n.NextButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")n.NextButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")n.NextButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")n.NextButton:SetScript("OnClick",A)n.PrevButton=CreateFrame("Button","CollectionListFramePrevButton",n,nil)n.PrevButton:SetSize(26,26)n.PrevButton:SetPoint("BOTTOM",-70,15)n.PrevButton:EnableMouse(true)n.PrevButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")n.PrevButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")n.PrevButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")n.PrevButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")n.PrevButton:SetScript("OnClick",C)n:SetScript("OnMouseWheel",function(t,e)if(n.PrevButton:IsEnabled()==1)and(e==-1)then
C(n.PrevButton)elseif(n.NextButton:IsEnabled()==1)and(e==1)then
A(n.NextButton)end
end)CollectionItemFrame1=CreateFrame("FRAME","CollectionItemFrame1",n,nil)CollectionItemFrame1:SetPoint("CENTER",-150,110)CollectionItemFrame1:SetSize(128,64)CollectionItemFrame2=CreateFrame("FRAME","CollectionItemFrame2",n,nil)CollectionItemFrame2:SetPoint("CENTER",0,110)CollectionItemFrame2:SetSize(128,64)CollectionItemFrame3=CreateFrame("FRAME","CollectionItemFrame3",n,nil)CollectionItemFrame3:SetPoint("CENTER",150,110)CollectionItemFrame3:SetSize(128,64)CollectionItemFrame4=CreateFrame("FRAME","CollectionItemFrame4",n,nil)CollectionItemFrame4:SetPoint("CENTER",-150,50)CollectionItemFrame4:SetSize(128,64)CollectionItemFrame5=CreateFrame("FRAME","CollectionItemFrame5",n,nil)CollectionItemFrame5:SetPoint("CENTER",0,50)CollectionItemFrame5:SetSize(128,64)CollectionItemFrame6=CreateFrame("FRAME","CollectionItemFrame6",n,nil)CollectionItemFrame6:SetPoint("CENTER",150,50)CollectionItemFrame6:SetSize(128,64)CollectionItemFrame7=CreateFrame("FRAME","CollectionItemFrame7",n,nil)CollectionItemFrame7:SetPoint("CENTER",-150,-10)CollectionItemFrame7:SetSize(128,64)CollectionItemFrame8=CreateFrame("FRAME","CollectionItemFrame8",n,nil)CollectionItemFrame8:SetPoint("CENTER",0,-10)CollectionItemFrame8:SetSize(128,64)CollectionItemFrame9=CreateFrame("FRAME","CollectionItemFrame9",n,nil)CollectionItemFrame9:SetPoint("CENTER",150,-10)CollectionItemFrame9:SetSize(128,64)CollectionItemFrame10=CreateFrame("FRAME","CollectionItemFrame10",n,nil)CollectionItemFrame10:SetPoint("CENTER",-150,-70)CollectionItemFrame10:SetSize(128,64)CollectionItemFrame11=CreateFrame("FRAME","CollectionItemFrame11",n,nil)CollectionItemFrame11:SetPoint("CENTER",0,-70)CollectionItemFrame11:SetSize(128,64)CollectionItemFrame12=CreateFrame("FRAME","CollectionItemFrame12",n,nil)CollectionItemFrame12:SetPoint("CENTER",150,-70)CollectionItemFrame12:SetSize(128,64)CollectionItemFrame13=CreateFrame("FRAME","CollectionItemFrame13",n,nil)CollectionItemFrame13:SetPoint("CENTER",-150,-130)CollectionItemFrame13:SetSize(128,64)CollectionItemFrame14=CreateFrame("FRAME","CollectionItemFrame14",n,nil)CollectionItemFrame14:SetPoint("CENTER",0,-130)CollectionItemFrame14:SetSize(128,64)CollectionItemFrame15=CreateFrame("FRAME","CollectionItemFrame15",n,nil)CollectionItemFrame15:SetPoint("CENTER",150,-130)CollectionItemFrame15:SetSize(128,64)for o=1,e.MaxEcnhantsPerPage do
_G["CollectionItemFrame"..o..".BackgroundTexture"]=_G["CollectionItemFrame"..o]:CreateTexture(nil,"BACKGROUND")_G["CollectionItemFrame"..o..".BackgroundTexture"]:SetSize(32,32)_G["CollectionItemFrame"..o..".BackgroundTexture"]:SetTexture("Interface\\Icons\\INV_Chest_Samurai")_G["CollectionItemFrame"..o..".BackgroundTexture"]:SetPoint("LEFT",_G["CollectionItemFrame"..o],1,0)_G["CollectionItemFrame"..o..".Button"]=CreateFrame("Button","CollectionItemFrame"..o.."Button",_G["CollectionItemFrame"..o],nil)_G["CollectionItemFrame"..o..".Button"]:SetSize(170,85)_G["CollectionItemFrame"..o..".Button"]:SetPoint("CENTER",0,0)_G["CollectionItemFrame"..o..".Button"]:EnableMouse(true)_G["CollectionItemFrame"..o..".Button"]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemNormal")_G["CollectionItemFrame"..o..".Button"]:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemDisabled")_G["CollectionItemFrame"..o..".Button"]:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemPushed")_G["CollectionItemFrame"..o..".Button"]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemNormal")_G["CollectionItemFrame"..o..".Button"]:Disable()_G["CollectionItemFrame"..o..".Button"]:GetDisabledTexture():SetVertexColor(.6,.6,.6,1)_G["CollectionItemFrame"..o..".Button.TextNormal"]=_G["CollectionItemFrame"..o..".Button"]:CreateFontString("CollectionItemFrame"..o.."ButtonTextNormal")_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetSize(75,20)_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetFont("Fonts\\FRIZQT__.TTF",11)_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetFontObject(GameFontNormal)_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetPoint("CENTER",15,0)_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetShadowOffset(0,-1)_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetText("Enchant Effect Name")_G["CollectionItemFrame"..o..".Button"]:SetScript("OnUpdate",function(e)if(e:IsEnabled()==0)and(_G["CollectionItemFrame"..o..".Button.TextNormal"]:GetFontObject()==GameFontNormal)then
_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetFontObject(GameFontDisable)elseif(e:IsEnabled()==1)and(_G["CollectionItemFrame"..o..".Button.TextNormal"]:GetFontObject()==GameFontDisable)then
_G["CollectionItemFrame"..o..".Button.TextNormal"]:SetFontObject(GameFontNormal)end
end)_G["CollectionItemFrame"..o..".Button"]:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT",-13,-50)GameTooltip:SetHyperlink(_G["CollectionItemFrame"..o..".Button.Spell"])GameTooltip:Show()end)_G["CollectionItemFrame"..o..".Button"]:SetScript("OnLeave",function()GameTooltip:Hide()end)_G["CollectionItemFrame"..o..".Button"]:SetScript("OnClick",function(n)PlaySound("GAMEABILITYACTIVATE")if(_G["CollectionItemFrame"..o..".Button.Enchant"])and(e.CollectionsEnchant~=_G["CollectionItemFrame"..o..".Button.Enchant"])then
if(e.ActiveEnchantButton~=0)and(_G["CollectionItemFrame"..e.ActiveEnchantButton..".Button"]:IsEnabled()==1)then
_G["CollectionItemFrame"..e.ActiveEnchantButton..".Button"]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemNormal")end
e.CollectionsEnchant=_G["CollectionItemFrame"..o..".Button.Enchant"]a.Handle("EnchantReRoll","RequestSuccessChance",e.CollectionsEnchant)if(t.Bag and t.Slot)then
a.Handle("EnchantReRoll","RequestCollectionReforgeCost",t.Bag,t.Slot,e.CollectionsEnchant)end
e.ActiveEnchantButton=o
n:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemActive")else
e.CollectionsEnchant=0
e.ActiveEnchantButton=0
n:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\CollectionsItemNormal")end
end)_G["CollectionItemFrame"..o]:Hide()end
n.AnimationBackground=CreateFrame("FRAME","CollectionListFrameAnimationBackground",n,nil)n.AnimationBackground:SetPoint("CENTER",n,0,0)n.AnimationBackground:SetSize(512,512)n.AnimationBackground:SetFrameLevel(7)n.AnimationBackground:Hide()n.AnimationBackground.BackgroundTexture=n.AnimationBackground:CreateTexture(nil,"BACKGROUND")n.AnimationBackground.BackgroundTexture:SetSize(512,512)n.AnimationBackground.BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\Shadow")n.AnimationBackground.BackgroundTexture:SetPoint("CENTER",0,0)n.AnimationBackground.HighLightOfNewItem=CreateFrame("FRAME","CollectionListFrameAnimationBackgroundHighLightOfNewItem",n.AnimationBackground,nil)n.AnimationBackground.HighLightOfNewItem:SetPoint("CENTER",n.AnimationBackground,-67,0)n.AnimationBackground.HighLightOfNewItem:SetSize(256,256)n.AnimationBackground.HighLightOfNewItem:SetFrameLevel(7)n.AnimationBackground.HighLightOfNewItem.HighlightTex=n.AnimationBackground.HighLightOfNewItem:CreateTexture(nil,"ARTWORK")n.AnimationBackground.HighLightOfNewItem.HighlightTex:SetSize(256,256)n.AnimationBackground.HighLightOfNewItem.HighlightTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DragonHighlight")n.AnimationBackground.HighLightOfNewItem.HighlightTex:SetPoint("CENTER",0,0)n.AnimationBackground.HighLightOfNewItem.HighlightTex:SetBlendMode("ADD")n.AnimationBackground.HighLightOfNewItem.Glow=CreateFrame("Model","CollectionListFrameAnimationBackgroundHighLightOfNewItemGlow",n.AnimationBackground.HighLightOfNewItem)n.AnimationBackground.HighLightOfNewItem.Glow:SetWidth(256);n.AnimationBackground.HighLightOfNewItem.Glow:SetHeight(256);n.AnimationBackground.HighLightOfNewItem.Glow:SetPoint("CENTER",5,-10)n.AnimationBackground.HighLightOfNewItem.Glow:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")n.AnimationBackground.HighLightOfNewItem.Glow:SetModelScale(.02)n.AnimationBackground.HighLightOfNewItem.Glow:SetCamera(0)n.AnimationBackground.HighLightOfNewItem.Glow:SetPosition(.075,.09,0)n.AnimationBackground.HighLightOfNewItem.Glow:SetFacing(0)n.AnimationBackground.HighLightOfNewItem.Glow:SetFrameLevel(7)n.NewEnchantInCollection=CreateFrame("FRAME","CollectionListFrameNewEnchantInCollection",n,nil)n.NewEnchantInCollection:SetPoint("CENTER",n,-10,-10)n.NewEnchantInCollection:SetSize(128,64)n.NewEnchantInCollection:SetFrameLevel(8)n.NewEnchantInCollection:EnableMouse(true)n.NewEnchantInCollection:SetAlpha(0)n.NewEnchantInCollection:Hide()n.NewEnchantInCollection.BackgroundTexture=n.NewEnchantInCollection:CreateTexture(nil,"BACKGROUND")n.NewEnchantInCollection.BackgroundTexture:SetSize(39,39)n.NewEnchantInCollection.BackgroundTexture:SetTexture("Interface\\Icons\\INV_Chest_Samurai")n.NewEnchantInCollection.BackgroundTexture:SetPoint("LEFT",n.NewEnchantInCollection,-10,-1)n.NewEnchantInCollection.Texture=n.NewEnchantInCollection:CreateTexture(nil,"OVERLAY")n.NewEnchantInCollection.Texture:SetSize(200,100)n.NewEnchantInCollection.Texture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\NewEnchantUnlocked")n.NewEnchantInCollection.Texture:SetPoint("CENTER",0,0)n.NewEnchantInCollection.TextNormal=n.NewEnchantInCollection:CreateFontString("CollectionListFrameNewEnchantInCollectionTextNormal","OVERLAY")n.NewEnchantInCollection.TextNormal:SetSize(90,20)n.NewEnchantInCollection.TextNormal:SetFont("Fonts\\FRIZQT__.TTF",12)n.NewEnchantInCollection.TextNormal:SetFontObject(GameFontNormal)n.NewEnchantInCollection.TextNormal:SetPoint("CENTER",15,0)n.NewEnchantInCollection.TextNormal:SetShadowOffset(0,-1)n.NewEnchantInCollection.TextNormal:SetText("Enchant Effect Name")n.NewEnchantInCollection.TextAdd=n.NewEnchantInCollection:CreateFontString("CollectionListFrameNewEnchantInCollectionTextAdd","OVERLAY")n.NewEnchantInCollection.TextAdd:SetSize(300,20)n.NewEnchantInCollection.TextAdd:SetFont("Fonts\\FRIZQT__.TTF",11)n.NewEnchantInCollection.TextAdd:SetFontObject(GameFontNormal)n.NewEnchantInCollection.TextAdd:SetPoint("BOTTOM",0,-20)n.NewEnchantInCollection.TextAdd:SetShadowOffset(0,-1)n.NewEnchantInCollection.TextAdd:SetText("|cffFFFFFFYou have successfuly unlocked|r!")n.AnimationBackground.HighLightOfNewItem.AnimationGroup=n.AnimationBackground.HighLightOfNewItem:CreateAnimationGroup()n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation=n.AnimationBackground.HighLightOfNewItem.AnimationGroup:CreateAnimation("Rotation")n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetStartDelay(0)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetDuration(6)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetOrder(1)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetEndDelay(0)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetSmoothing("NONE")n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetDegrees(90)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.Rotation:SetScript("OnPlay",function()BaseFrameFadeIn(n.AnimationBackground)end)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut=n.AnimationBackground.HighLightOfNewItem.AnimationGroup:CreateAnimation("Alpha")n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetStartDelay(0)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetDuration(3)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetOrder(2)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetEndDelay(0)n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetSmoothing("NONE")n.AnimationBackground.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetChange(-1)n.AnimationBackground.HighLightOfNewItem.AnimationGroup:SetScript("OnStop",function()n.AnimationBackground:Hide()end)n.AnimationBackground.HighLightOfNewItem.AnimationGroup:SetScript("OnFinished",function()n.AnimationBackground:Hide()end)n.NewEnchantInCollection.AnimationGroup=n.NewEnchantInCollection:CreateAnimationGroup()n.NewEnchantInCollection.AnimationGroup.Alpha=n.NewEnchantInCollection.AnimationGroup:CreateAnimation("Alpha")n.NewEnchantInCollection.AnimationGroup.Alpha:SetStartDelay(0)n.NewEnchantInCollection.AnimationGroup.Alpha:SetDuration(1)n.NewEnchantInCollection.AnimationGroup.Alpha:SetOrder(1)n.NewEnchantInCollection.AnimationGroup.Alpha:SetEndDelay(5)n.NewEnchantInCollection.AnimationGroup.Alpha:SetSmoothing("NONE")n.NewEnchantInCollection.AnimationGroup.Alpha:SetChange(1)n.NewEnchantInCollection.AnimationGroup.Alpha:SetScript("OnPlay",function()PlaySound("igQuestListComplete")n.NewEnchantInCollection:Show()n.AnimationBackground.HighLightOfNewItem.AnimationGroup:Play()end)n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut=n.NewEnchantInCollection.AnimationGroup:CreateAnimation("Alpha")n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetStartDelay(0)n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetDuration(3)n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetOrder(2)n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetEndDelay(0)n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetSmoothing("NONE")n.NewEnchantInCollection.AnimationGroup.AlphaFadeOut:SetChange(-1)n.NewEnchantInCollection.AnimationGroup:SetScript("OnStop",function()n.NewEnchantInCollection:Hide()n.AnimationBackground.HighLightOfNewItem.AnimationGroup:Finish()end)n.NewEnchantInCollection.AnimationGroup:SetScript("OnFinished",function()n.NewEnchantInCollection:Hide()n.AnimationBackground.HighLightOfNewItem.AnimationGroup:Finish()end)e.ConfirmDisenchant=CreateFrame("Frame","CollectionsFrameConfirmDisenchant",e,nil)e.ConfirmDisenchant:ClearAllPoints()e.ConfirmDisenchant:SetBackdrop(StaticPopup1:GetBackdrop())e.ConfirmDisenchant:SetHeight(115)e.ConfirmDisenchant:SetWidth(390)e.ConfirmDisenchant:SetPoint("CENTER",e,0,0)e.ConfirmDisenchant:SetFrameLevel(10)e.ConfirmDisenchant:EnableMouse(true)e.ConfirmDisenchant:Hide()e.ConfirmDisenchant.Mode="DISENCHANT"e.ConfirmDisenchant.text=e.ConfirmDisenchant:CreateFontString(nil,"BORDER","GameFontHighlight")e.ConfirmDisenchant.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmDisenchant.text:SetText("Are you sure that you want\nto disenchant following item:\n\nITEMLINK")e.ConfirmDisenchant.text:SetPoint("TOP",0,-20)e.ConfirmDisenchant.Alert=e.ConfirmDisenchant:CreateTexture("CollectionsFrameConfirmDisenchantAlert")e.ConfirmDisenchant.Alert:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew")e.ConfirmDisenchant.Alert:SetSize(48,48)e.ConfirmDisenchant.Alert:SetPoint("LEFT",24,0)e.ConfirmDisenchant.Yes=CreateFrame("Button",nil,e.ConfirmDisenchant,"StaticPopupButtonTemplate")e.ConfirmDisenchant.Yes:SetWidth(110)e.ConfirmDisenchant.Yes:SetHeight(19)e.ConfirmDisenchant.Yes:SetPoint("BOTTOM",-60,15)e.ConfirmDisenchant.Yes:SetScript("OnClick",function()g()e.ConfirmDisenchant:Hide()end)e.ConfirmDisenchant.No=CreateFrame("Button",nil,e.ConfirmDisenchant,"StaticPopupButtonTemplate")e.ConfirmDisenchant.No:SetWidth(110)e.ConfirmDisenchant.No:SetHeight(19)e.ConfirmDisenchant.No:SetPoint("BOTTOM",60,15)e.ConfirmDisenchant.No:SetScript("OnClick",function()e.ConfirmDisenchant:Hide()end)e.ConfirmDisenchant.Yes.text=e.ConfirmDisenchant.Yes:CreateFontString(nil,"BACKGROUND","GameFontNormal")e.ConfirmDisenchant.Yes.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmDisenchant.Yes.text:SetText("Accept")e.ConfirmDisenchant.Yes.text:SetPoint("CENTER",0,1)e.ConfirmDisenchant.No.text=e.ConfirmDisenchant.No:CreateFontString(nil,"BACKGROUND","GameFontNormal")e.ConfirmDisenchant.No.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmDisenchant.No.text:SetText("Cancel")e.ConfirmDisenchant.No.text:SetPoint("CENTER",0,1)e.ConfirmDisenchant.Yes:SetFontString(e.ConfirmDisenchant.Yes.text)e.ConfirmDisenchant.No:SetFontString(e.ConfirmDisenchant.No.text)e.ConfirmDisenchant:SetScript("OnShow",function(t)PlaySound("igMainMenuOpen")if(t.Mode=="DISENCHANT")then
e.ConfirmDisenchant.Yes:SetScript("OnClick",function()PlaySound("igMainMenuOptionCheckBoxOn")g()e.ConfirmDisenchant:Hide()end)elseif(t.Mode=="COLLECTIONREFORGE")then
e.ConfirmDisenchant.Yes:SetScript("OnClick",function()PlaySound("igMainMenuOptionCheckBoxOn")w()e.ConfirmDisenchant:Hide()end)end
end)e.ConfirmDisenchant:SetScript("OnHide",function(e)PlaySound("igMainMenuClose")end)for t,e in pairs(H)do
_G[e]:HookScript("OnTooltipSetItem",function(t)local n,e=t:GetItem()if not(e)then
return false
end
d(t,e)end)end
local i={[0]=CharacterHeadSlot,[1]=CharacterNeckSlot,[2]=CharacterShoulderSlot,[14]=CharacterBackSlot,[4]=CharacterChestSlot,[3]=CharacterShirtSlot,[18]=CharacterTabardSlot,[8]=CharacterWristSlot,[9]=CharacterHandsSlot,[5]=CharacterWaistSlot,[6]=CharacterLegsSlot,[7]=CharacterFeetSlot,[10]=CharacterFinger0Slot,[11]=CharacterFinger1Slot,[12]=CharacterTrinket0Slot,[13]=CharacterTrinket1Slot,[15]=CharacterMainHandSlot,[16]=CharacterSecondaryHandSlot,[17]=CharacterRangedSlot}local c={"Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_white","Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_green","Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_blue","Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder","Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_Yellow",}local t=CreateFrame("FRAME")t:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")t:SetScript("OnEvent",function()a.Handle("EnchantReRoll","GetStackDataAll")end)local function l(t,o)local n=2
_,enchantrank,icon=GetSpellInfo(o)if(enchantrank)then
_,n=GetEnchantColor(enchantrank)if(n)then
n=tonumber(n)else
n=2
end
end
_G["EnchantStackDisplayButton"..t]:SetNormalTexture(c[n])_G["EnchantStackDisplayButton"..t].Quality=n
SetPortraitToTexture(_G["EnchantStackDisplayButton"..t].Icon,icon)_G["EnchantStackDisplayButton"..t].Spell=o
_G["EnchantStackDisplayButton"..t].Stack=e.SlotStackData[o][1]if(e.SlotStackData[o][2]==0)then
_G["EnchantStackDisplayButton"..t].MaxStack=1
else
_G["EnchantStackDisplayButton"..t].MaxStack=e.SlotStackData[o][2]end
if(_G["EnchantStackDisplayButton"..t].Stack>_G["EnchantStackDisplayButton"..t].MaxStack)then
_G["EnchantStackDisplayButton"..t].Maxed:Show()end
_G["EnchantStackDisplayButton"..t]:Show()end
local function o(e,t)if(IsModifiedClick("CHATLINK"))then
if(e.Spell)then
local t=GetSpellInfo(e.Spell)local e="|cff71d5ff|Hspell:"..e.Spell.."|h["..t.."]|h|r"if(e)then
ChatEdit_InsertLink(e);end
end
return;end
end
function r.UpdatePaperDoll(o,t,n)e.SlotStackData=t
for e,t in pairs(i)do
_G["EnchantStackDisplayButton"..e]:Hide()_G["EnchantStackDisplayButton"..e].Maxed:Hide()end
for e,t in pairs(n)do
l(e,t)end
end
for e,t in pairs(i)do
_G["EnchantStackDisplayButton"..e]=CreateFrame("Button","EnchantStackDisplayButton"..e,t,nil)_G["EnchantStackDisplayButton"..e]:SetSize(18,18)_G["EnchantStackDisplayButton"..e]:SetPoint("BOTTOMRIGHT",0,0)_G["EnchantStackDisplayButton"..e]:EnableMouse(true)_G["EnchantStackDisplayButton"..e]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder")_G["EnchantStackDisplayButton"..e]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\EnchantBorder_highlight")_G["EnchantStackDisplayButton"..e].Icon=_G["EnchantStackDisplayButton"..e]:CreateTexture(nil,"BORDER",nil,10)_G["EnchantStackDisplayButton"..e].Icon:SetSize(8,8)SetPortraitToTexture(_G["EnchantStackDisplayButton"..e].Icon,"Interface\\Icons\\inv_chest_samurai")_G["EnchantStackDisplayButton"..e].Icon:SetPoint("CENTER",0,0)_G["EnchantStackDisplayButton"..e].Maxed=_G["EnchantStackDisplayButton"..e]:CreateTexture(nil,"OVERLAY",nil,10)_G["EnchantStackDisplayButton"..e].Maxed:SetSize(18,18)_G["EnchantStackDisplayButton"..e].Maxed:SetPoint("CENTER",0,0)_G["EnchantStackDisplayButton"..e].Maxed:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\RedSign")_G["EnchantStackDisplayButton"..e]:SetScript("OnEnter",function(e)if(e.Spell)then
local t=GetSpellInfo(e.Spell)local t="|cff71d5ff|Hspell:"..e.Spell.."|h["..t.."]|h|r"GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetHyperlink(t)if(e.Quality==5)then
GameTooltip:AddLine("\nYou can have only one |cffff8000Legendary|r\nenchant be applied on your character\n")end
if(e.Stack<=e.MaxStack)then
GameTooltip:AddLine("Active Effects: |cff00FF00"..e.Stack.."/"..e.MaxStack.."|r")else
GameTooltip:AddLine("Active Effects: |cffD000000|r")GameTooltip:AddLine("|cffD00000This Mystic Enchant won't\naffect on your character if you have\nmore than "..e.MaxStack.." applied|r")GameTooltip:AddLine("\nIf you don't have more than |cffFFFFFF"..e.MaxStack.."|r\nenchants of that kind applied,\ntry re-equipping an item")end
GameTooltip:Show()end
end)_G["EnchantStackDisplayButton"..e]:SetScript("OnLeave",function(e)GameTooltip:Hide()end)_G["EnchantStackDisplayButton"..e]:SetScript("OnClick",function(t,e)if(IsModifiedClick())then
o(t,e);end
end)_G["EnchantStackDisplayButton"..e]:Hide()end
a.Handle("EnchantReRoll","GetStackDataAll")print(string.format("|cFF00FF00Loaded Enchant Reforge Collections Client v%.2f |r",k))