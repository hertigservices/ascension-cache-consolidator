Ulocal o=AIO or require("AIO")local G=1.38
if o.AddAddon()then
return
end
local a=o.AddHandlers("StoreCollections",{})local C=CreateFrame("GameTooltip","CacheFixTooltip",UIParent,"GameTooltipTemplate")local e=CreateFrame("FRAME","StoreCollectionFrame",CollectionController,nil)e:Hide()e.Items={}e.ItemsCurrent={}e.TotalItems=0
e.KnownItems=0
e.Preview_Items={}e.Preview_Creatures={}e.Preview_Current={}e.PageCount=0
e.MaxItemsPerPage=9
e.CurrentPage=1
e.ItemsSorted={}e.ItemSelected=0
e.ItemInternal=0
e.GroupIcons={[3]={"Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-mounts","Mounts"},[4]={"Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-pets","Pets"},[5]={"Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-toys","Toys"},[7]={"Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-armor","Appearances"},[15]={"Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-featured","Ascension Exclusives"},}e.DefaultPreviewTexture="Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewItems\\Store_PreviewMain"e.DefaultArtworkTexture="Interface\\AddOns\\AwAddons\\Textures\\Collections\\StorePaperArtwork"e.SPBalance=0
e.DPBalance=0
e.SP_Cost_Current=0
e.DP_Cost_Current=0
local function F()CollectionsFrame:Hide()SeasonalCollectionFrame:Hide()TomeCollectionsFrame:Hide()if(e.TotalItems==0)then
o.Handle("StoreCollections","RequestList")end
end
local function r(t)StoreCollectionListFrame.PageText:SetText("Page "..t.."/"..e.PageCount)end
local function i()e.ModelPreview_fake:Hide()e.ModelPreview:Hide()end
local function T(t)if(e.Preview_Creatures[t])then
return true
end
local o,o,o,o,o,o,o,o,n=GetItemInfo(t)if not(e.Preview_Items[t])then
if n and n~=""and equipSlot_Check~="INVTYPE_BAG"then
e.Preview_Items[t]={t}else
return false
end
return true
else
for o,n in pairs(e.Preview_Items[t])do
local i,i,i,i,i,i,i,i,n=GetItemInfo(n)if not(n)or(n=="")or(n=="INVTYPE_BAG")then
e.Preview_Items[t][o]=nil
end
end
if not(next(e.Preview_Items[t]))then
return false
end
return true
end
return true
end
local function I(n)local t=e.Preview_Items[n]if not(t)then
t=e.Preview_Creatures[n]end
return t or{}end
local function m(t,o,m,r,a,S,i,u,l)local n=e.Items[o][8]local i=e.GroupIcons[i]SetPortraitToTexture(_G["StoreCollectionItemFrame"..t..".Icon"],a)_G["StoreCollection"..t..".TextNormal"]:SetText(m.."["..r.."]|r")_G["StoreCollectionItemFrame"..t..".Button.SeasonalPointsCost"]=l
_G["StoreCollectionItemFrame"..t..".Button.DonatePointsCost"]=u
_G["StoreCollectionItemFrame"..t..".Button.ItemInternal"]=o
_G["StoreCollectionItemFrame"..t..".Button.Icon"]=a
_G["StoreCollectionItemFrame"..t..".Button.ItemName"]=r
_G["StoreCollectionItemFrame"..t..".Button.ItemDescription"]=e.Items[o][6]if not(n)or(n=="")then
n=e.DefaultArtworkTexture
_G["StoreCollectionItemFrame"..t..".Button.ArtWorkPreview"]=e.DefaultPreviewTexture
else
_G["StoreCollectionItemFrame"..t..".Button.ArtWorkPreview"]="Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewItems\\"..n
n="Interface\\AddOns\\AwAddons\\Textures\\Collections\\"..n
end
_G["StoreCollectionItemFrame"..t..".Button.ArtWork"]=n
if not(i)then
i="Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-featured"else
i=i[1]end
_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetTexture(i)if not(S)then
_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetVertexColor(.4,.4,.4,.8)_G["StoreCollectionItemFrame"..t..".Button.Item"]=0
_G["StoreCollectionItemFrame"..t..".Icon"]:SetVertexColor(.8,.8,.8,.8)_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]:SetVertexColor(1,1,1,.2)_G["StoreCollectionItemFrame"..t..".RoundBG"]:SetVertexColor(1,1,1,.2)_G["StoreCollectionItemFrame"..t..".Circle"]:SetVertexColor(.5,.5,.5,1)_G["StoreCollection"..t..".TextNormal"]:SetVertexColor(1,1,1,.5)else
_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetVertexColor(1,1,1,1)_G["StoreCollectionItemFrame"..t..".Button.Item"]=o
_G["StoreCollectionItemFrame"..t..".Icon"]:SetVertexColor(1,1,1,1)_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]:SetVertexColor(1,1,1,1)_G["StoreCollectionItemFrame"..t..".RoundBG"]:SetVertexColor(1,1,1,1)_G["StoreCollectionItemFrame"..t..".Circle"]:SetVertexColor(1,1,1,1)_G["StoreCollection"..t..".TextNormal"]:SetVertexColor(1,1,1,1)end
if(l>0)then
_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreButtonBG_Seasonal")else
_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreButtonBG")end
if(T(o))then
_G["StoreCollectionItemFrame"..t..".Button.PreviewData"]=I(o)else
_G["StoreCollectionItemFrame"..t..".Button.PreviewData"]={}end
end
local function l(n)for e=1,e.MaxItemsPerPage do
_G["StoreCollectionItemFrame"..e]:Hide()end
local t={}local o=n*e.MaxItemsPerPage-(e.MaxItemsPerPage-1)local n=n*e.MaxItemsPerPage
if(#e.ItemsCurrent<n)then
n=#e.ItemsCurrent
end
for n=o,n do
table.insert(t,e.ItemsCurrent[n])end
local e=1
while(e<=#t)do
local i=t[e][1]local S=t[e][11]local u=t[e][5]local r=t[e][9]local l=t[e][10]local n,n,n,a=GetItemQualityColor(t[e][3])local n,c,c,c,c,c,c,c,c,o=GetItemInfo(i)if not(n)then
n=t[e][2]end
o="Interface\\Icons\\"..t[e][7]m(e,i,a,n,o,S,u,r,l)_G["StoreCollectionItemFrame"..e]:Show()e=e+1
end
end
local function n(n,t)e.ItemsCurrent={}if not(t)then
t=1
end
for n,t in pairs(n)do
table.insert(e.ItemsCurrent,t)end
e.PageCount=math.ceil(#e.ItemsCurrent/e.MaxItemsPerPage)if(e.PageCount<1)then
e.PageCount=1
end
e.CurrentPage=t
r(e.CurrentPage)if(e.PageCount<=1)then
StoreCollectionListFrame.NextButton:Disable()else
StoreCollectionListFrame.NextButton:Enable()end
if(t==1)then
StoreCollectionListFrame.PrevButton:Disable()end
l(t)end
local function u(t)PlaySound("igMainMenuContinue")e.CurrentPage=e.CurrentPage+1
if(e.CurrentPage==e.PageCount)then
t:Disable()end
if(StoreCollectionListFrame.PrevButton:IsEnabled()==0)then
StoreCollectionListFrame.PrevButton:Enable()end
r(e.CurrentPage)l(e.CurrentPage)end
local function c(t)PlaySound("igMainMenuContinue")e.CurrentPage=e.CurrentPage-1
if(e.CurrentPage==1)then
t:Disable()end
if(StoreCollectionListFrame.NextButton:IsEnabled()==0)then
StoreCollectionListFrame.NextButton:Enable()end
r(e.CurrentPage)l(e.CurrentPage)end
local function P()local t={}for o,e in pairs(e.Items)do
if(e[11])then
table.insert(t,e)end
end
n(t)end
local function x()local t={}for o,e in pairs(e.Items)do
if(e[10]>0)then
table.insert(t,e)end
end
n(t)end
local function r(o)local t={}for i,e in pairs(e.Items)do
if(e[5]==o)then
table.insert(t,e)end
end
n(t)end
local function A(t)local r={}local o=t:GetText()if not(o)or(o=="")or(o:lower()=="search")then
t:ClearFocus(t)t:SetText("Search")return false
end
o=o:lower()for t,i in pairs(e.Items)do
local n=e.Items[t][2]:lower()if(string.find(n,o))then
table.insert(r,e.Items[t])end
end
n(r)t:ClearFocus(t)i()end
local function l(t)local e=1
if(GetCVar("useUiScale")=="1")then
e=GetCVar("uiScale")else
SetCVar("uiScale","1")e=1
end
t:SetPosition(0,0,1.65/e)end
local function d(t)if tonumber(e.Preview_Current)then
t.Creature=e.Preview_Current
elseif next(e.Preview_Current)then
t.Creature=nil
end
if(t.Creature)then
t:SetCreature(t.Creature)t:SetCamera(0)else
t:SetCamera(0)t:SetUnit("player")t:RefreshUnit()end
t:SetFacing(e.ModelPreview.DefaultFacing)t:SetModelScale(e.ModelPreview.DefaultSize)l(t)end
local function S()if not(e.ModelPreview.Creature)then
for n,t in pairs(e.Preview_Current)do
e.ModelPreview:TryOn(t)end
end
end
local function t()if tonumber(e.Preview_Current)or(next(e.Preview_Current))then
e.Paper.ItemPreview:Show()e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup:Stop()e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup:Play()else
e.Paper.ItemPreview:Hide()end
end
local function m()BaseFrameFadeIn(e.Paper)BaseFrameFadeIn(e.Paper_fake)e.Paper.Icon:Show()e.Paper.GoldBG:Show()e.Paper.Texture:Show()e.Paper.LineUp:Show()e.Paper.LineDown:Show()e.Paper.DescText:Show()e.Paper.BorderTex:Show()e.Paper.LineDown.AnimationGroup:Stop()e.Paper.LineDown.AnimationGroup:Play()t()end
local function t()BaseFrameFadeOut(e.Paper)BaseFrameFadeOut(e.Paper_fake)e.Paper.Icon:Hide()e.Paper.GoldBG:Hide()e.Paper.Texture:Hide()e.Paper.LineUp:Hide()e.Paper.LineDown:Hide()e.Paper.DescText:Hide()e.Paper.BorderTex:Hide()e.Paper.LineDown.AnimationGroup:Stop()end
local function w()d(e.ModelPreview)e.ModelPreview_fake:Show()end
local function p()local t=e.ItemsSorted[math.random(1,#e.ItemsSorted)]local n,i,i,i,i,i,i,i,i,o=GetItemInfo(t[1])if not(n)then
n=t[2]end
o="Interface\\Icons\\"..t[7]local i=t[4]e.Banner.Item=t[1]e.Banner.Icon:SetTexture(o)e.Banner.TitleText:SetText(strupper(n))e.Banner.TitleText_UNEDITED=n
e.Banner.DescText:SetText(strupper(i))end
local function s()if not(e.Banner.Item)then
return false
end
local t=e.Items[e.Banner.Item][8]if not(t)or(t=="")then
t=e.DefaultArtworkTexture
e.ModelPreview.BGTex:SetTexture(e.DefaultPreviewTexture)else
if not(e.ModelPreview.BGTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewItems\\"..t))then
e.ModelPreview.BGTex:SetTexture(e.DefaultPreviewTexture)end
t="Interface\\AddOns\\AwAddons\\Textures\\Collections\\"..t
end
e.Paper.Icon:SetNormalTexture(e.Banner.Icon:GetTexture())e.Paper.ArtWork:SetTexture(t)e.Paper.TitleText:SetText(e.Banner.TitleText_UNEDITED)e.Paper.DescText:SetText(e.Items[e.Banner.Item][6])e.ItemInternal=e.Banner.Item
if(e.Items[e.Banner.Item][9]~=0)or(e.Items[e.Banner.Item][10]~=0)then
e.SP_Cost_Current=e.Items[e.Banner.Item][9]e.DP_Cost_Current=e.Items[e.Banner.Item][10]e.BuyStoreButton:Enable()else
e.BuyStoreButton:Disable()end
if(e.Items[e.Banner.Item][11])then
e.ItemSelected=e.Banner.Item
e.ActivateStoreButton:Enable()e.BuyStoreButton:Disable()else
e.ItemSelected=0
e.ActivateStoreButton:Disable()end
if(T(e.Banner.Item))then
e.Preview_Current=I(e.Banner.Item)else
e.Preview_Current={}end
i()m()end
local function T(t)PlaySound("igMainMenuOptionCheckBoxOn")if(e.ItemSelected~=0)and(t:IsEnabled()==1)then
o.Handle("StoreCollections","DeliverItem",e.ItemSelected)end
end
local function I(t)PlaySound("igMainMenuOptionCheckBoxOn")if(e.ItemInternal~=0)and(t:IsEnabled()==1)then
o.Handle("StoreCollections","BuyItem",e.ItemInternal)end
end
function a.UpdateBalance(o,t,n)e.SPBalance=n
e.DPBalance=t
e.SPCounter_Text:SetText(n)e.DPCounter_Text:SetText(t)end
function a.BuildItemList(a,r,i,t)e.Preview_Items=i
e.Preview_Creatures=t
for t,n in pairs(r)do
e.Items[t]=n
table.insert(e.Items[t],false)if not(GetItemInfo(t))then
C:SetHyperlink("item:"..t..":0:0:0:0:0:0:0")end
table.insert(e.ItemsSorted,n)e.TotalItems=e.TotalItems+1
end
for t,e in pairs(i)do
for t,e in pairs(e)do
if not(GetItemInfo(e))then
C:SetHyperlink("item:"..e..":0:0:0:0:0:0:0")end
end
end
n(e.Items)o.Handle("StoreCollections","RequestKnownList")end
function a.UpdateItemList(o,t)for n,t in pairs(t)do
if(e.Items[t])then
e.Items[t][11]=true
e.KnownItems=e.KnownItems+1
end
end
if(#t>0)then
n(e.Items)end
end
function a.UnlockNewItem(n,t,o)PlaySound("LEVELUP")if not(NewItemInCollection:IsVisible())then
local e,i,i,i,i,i,i,i,i,n=GetItemInfo(t[1])if not(e)then
e=t[2]end
n="Interface\\Icons\\"..t[7]SetPortraitToTexture(NewItemInCollectionMain.Icon,n)NewItemInCollectionMain.TextNormal:SetText(strupper(e))NewItemInCollectionMain.TextAdd:SetText("|cffFFFFFFNew |rVanity Item|cffFFFFFF unlocked - "..o.."|cffFFFFFF!|r")NewItemInCollectionMain.AnimationGroup:Stop()NewItemInCollection:Show()NewItemInCollectionMain.AnimationGroup:Play()end
end
e:SetSize(784,512)e:SetPoint("CENTER",0,0)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreCollection",insets={left=-120,right=-120,top=-256,bottom=-256}})e:SetClampedToScreen(true)e:SetScript("OnShow",F)e:SetScript("OnUpdate",function()if not(e.ModelPreview:IsVisible())and e.ModelPreview_fake:IsVisible()then
e.ModelPreview.HackFix=e.ModelPreview.HackFix+1
if(e.ModelPreview.HackFix>=5)then
e.ModelPreview:Show()e.ModelPreview.HackFix=0
end
end
if not(e.Banner:IsVisible())then
if(#e.ItemsSorted<=0)then
return false
end
p()e.Banner.AnimationGroup:Stop()BaseFrameFadeIn(e.Banner)e.Banner.AnimationGroup:Play()end
end)e.CloseButton=CreateFrame("Button","StoreCollectionFrameCloseButton",e,"UIPanelCloseButton")e.CloseButton:SetPoint("TOPRIGHT",-4,-1)e.CloseButton:EnableMouse(true)e.CloseButton:SetScript("OnMouseUp",function()PlaySound("igMainMenuClose")CollectionController:Hide()end)e.TitleText=e:CreateFontString("StoreCollectionFrameTitleText")e.TitleText:SetFont("Fonts\\FRIZQT__.TTF",12)e.TitleText:SetFontObject(GameFontNormal)e.TitleText:SetPoint("TOP",0,-11)e.TitleText:SetShadowOffset(1,-1)e.TitleText:SetText("Vanity Items Collection")e.SearchBox=CreateFrame("EditBox","StoreCollectionFrameSearchBox",e,"InputBoxTemplate")e.SearchBox:SetWidth(120)e.SearchBox:SetHeight(26)e.SearchBox:SetFontObject(GameFontNormal)e.SearchBox:SetPoint("TOPRIGHT",e,-110,-33)e.SearchBox:ClearFocus(self)e.SearchBox:SetAutoFocus(false)e.SearchBox:SetFontObject(GameFontDisable)e.SearchBox:SetScript("OnEnterPressed",A)e.SearchBox:SetScript("OnEscapePressed",ClearSearchEscape)e.SearchBox:SetText("Search")e.SPCounter_BackgroundTexture=e:CreateTexture(nil,"ARTWORK")e.SPCounter_BackgroundTexture:SetSize(110,55)e.SPCounter_BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DP_Counter")e.SPCounter_BackgroundTexture:SetPoint("CENTER",90,206)e.DPCounter_BackgroundTexture=e:CreateTexture(nil,"ARTWORK")e.DPCounter_BackgroundTexture:SetSize(110,55)e.DPCounter_BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\SP_Counter")e.DPCounter_BackgroundTexture:SetPoint("CENTER",-17,206)e.DPCounter_BackgroundTexture:Hide()e.SPCounter_Icon=e:CreateTexture(nil,"OVERLAY")e.SPCounter_Icon:SetSize(21,21)e.SPCounter_Icon:SetTexture("Interface\\icons\\inv_archaeology_70_demon_orbofinnerchaos")e.SPCounter_Icon:SetPoint("CENTER",57.5,210)SetPortraitToTexture(e.SPCounter_Icon,"Interface\\icons\\inv_archaeology_70_demon_orbofinnerchaos")e.DPCounter_Icon=e:CreateTexture(nil,"OVERLAY")e.DPCounter_Icon:SetSize(21,21)e.DPCounter_Icon:SetTexture("Interface\\icons\\spell_frostfire_orb")e.DPCounter_Icon:SetPoint("CENTER",-49.5,210)SetPortraitToTexture(e.DPCounter_Icon,"Interface\\icons\\spell_frostfire_orb")e.DPCounter_Icon:Hide()e.SPCounter_Text=e:CreateFontString("StoreCollectionFrameSPCounter_Text")e.SPCounter_Text:SetFont("Fonts\\FRIZQT__.TTF",11)e.SPCounter_Text:SetFontObject(GameFontNormal)e.SPCounter_Text:SetPoint("CENTER",95,204.5)e.SPCounter_Text:SetShadowOffset(1,-1)e.SPCounter_Text:SetText("0")e.SPCounter_Text:SetJustifyH("CENTER")e.DPCounter_Text=e:CreateFontString("StoreCollectionFrameDPCounter_Text")e.DPCounter_Text:SetFont("Fonts\\FRIZQT__.TTF",11)e.DPCounter_Text:SetFontObject(GameFontNormal)e.DPCounter_Text:SetPoint("CENTER",-12,204.5)e.DPCounter_Text:SetShadowOffset(1,-1)e.DPCounter_Text:SetText("0")e.DPCounter_Text:SetJustifyH("CENTER")e.DPCounter_Text:Hide()e.SPCounterHintButton=CreateFrame("Button","StoreCollectionFrameActivateStoreButton",e,nil)e.SPCounterHintButton:SetWidth(38)e.SPCounterHintButton:SetHeight(38)e.SPCounterHintButton:SetPoint("CENTER",57.5,210)e.SPCounterHintButton:RegisterForClicks("AnyUp")e.SPCounterHintButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")e.SPCounterHintButton:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFSeasonal Points|r")GameTooltip:AddLine("Points you earned progressing")GameTooltip:AddLine("through previous seasons")GameTooltip:Show()end)e.SPCounterHintButton:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e.StoreTypeList=CreateFrame("Button","StoreCollectionFrameStoreTypeList",e,"UIDropDownMenuTemplate")e.StoreTypeList:SetPoint("TOPRIGHT",e,-10,-32)e.StoreTypeList.List={"All","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-mounts.blp:32:32:0:0|t Mounts","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-pets.blp:32:32:0:0|t Pets","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-toys.blp:32:32:0:0|t Toys","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-armor.blp:32:32:0:0|t Appearances","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-featured.blp:32:32:0:0|t Ascension Exclusives","|TInterface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-sale.blp:32:32:0:0|t Seasonal Rewards","Known",}function e.StoreTypeList.Init(t,a)local o=UIDropDownMenu_CreateInfo()for l,t in pairs(e.StoreTypeList.List)do
o=UIDropDownMenu_CreateInfo()o.text=t
o.value=t
o.func=function(t)UIDropDownMenu_SetSelectedID(StoreCollectionFrameStoreTypeList,t:GetID())if(t:GetID()==1)then
n(e.Items)elseif(t:GetID()==2)then
r(3)elseif(t:GetID()==3)then
r(4)elseif(t:GetID()==4)then
r(5)elseif(t:GetID()==5)then
r(7)elseif(t:GetID()==6)then
r(15)elseif(t:GetID()==7)then
x()elseif(t:GetID()==8)then
P()end
i()end
UIDropDownMenu_AddButton(o,a)end
end
UIDropDownMenu_Initialize(e.StoreTypeList,e.StoreTypeList.Init)UIDropDownMenu_SetWidth(e.StoreTypeList,60);UIDropDownMenu_SetButtonWidth(e.StoreTypeList,70)UIDropDownMenu_SetSelectedID(e.StoreTypeList,1)UIDropDownMenu_JustifyText(e.StoreTypeList,"LEFT")e.ActivateStoreButton=CreateFrame("Button","StoreCollectionFrameActivateStoreButton",e,"UIPanelButtonTemplate")e.ActivateStoreButton:SetWidth(118)e.ActivateStoreButton:SetHeight(21)e.ActivateStoreButton:SetPoint("BOTTOMLEFT",180,37)e.ActivateStoreButton:RegisterForClicks("AnyUp")e.ActivateStoreButton:SetText("Deliver Item")e.ActivateStoreButton:Disable()e.ActivateStoreButton:SetScript("OnMouseDown",T)e.BuyStoreButton=CreateFrame("Button","StoreCollectionFrameBuyStoreButton",e,"UIPanelButtonTemplate")e.BuyStoreButton:SetWidth(118)e.BuyStoreButton:SetHeight(21)e.BuyStoreButton:SetPoint("BOTTOMLEFT",62,37)e.BuyStoreButton:RegisterForClicks("AnyUp")e.BuyStoreButton:SetText("Purchase Item")e.BuyStoreButton:Disable()e.BuyStoreButton:SetScript("OnMouseDown",function(t)e.ConfirmBuy:Show()end)e.Banner=CreateFrame("FRAME","StoreCollectionFrameBanner",e,nil)e.Banner:SetPoint("TOP",-235,-65)e.Banner:SetSize(280,55)e.Banner:Hide()e.Banner:EnableMouse(true)e.Banner:SetScript("OnUpdate",function()if not(e.Banner.HighlightTex.AnimG:IsPlaying())then
e.Banner.HighlightTex.AnimG:Play()end
end)e.Banner:SetScript("OnMouseDown",s)e.Banner.HighlightTex=e.Banner:CreateTexture(nil,"BACKGROUND")e.Banner.HighlightTex:SetSize(140,140)e.Banner.HighlightTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DragonHighlight")e.Banner.HighlightTex:SetPoint("LEFT",-39,0)e.Banner.HighlightTex:SetBlendMode("ADD")e.Banner.HighlightTex.AnimG=e.Banner.HighlightTex:CreateAnimationGroup()e.Banner.HighlightTex.AnimG.Rotation=e.Banner.HighlightTex.AnimG:CreateAnimation("Rotation")e.Banner.HighlightTex.AnimG.Rotation:SetDuration(20)e.Banner.HighlightTex.AnimG.Rotation:SetOrder(1)e.Banner.HighlightTex.AnimG.Rotation:SetEndDelay(0)e.Banner.HighlightTex.AnimG.Rotation:SetSmoothing("NONE")e.Banner.HighlightTex.AnimG.Rotation:SetDegrees(360)e.Banner.Glow=CreateFrame("Model","StoreCollectionFrameBannerGlow",e.Banner)e.Banner.Glow:SetWidth(256);e.Banner.Glow:SetHeight(256);e.Banner.Glow:SetPoint("LEFT",-90,-5)e.Banner.Glow:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")e.Banner.Glow:SetModelScale(.01)e.Banner.Glow:SetCamera(0)e.Banner.Glow:SetPosition(.075,.09,0)e.Banner.Glow:SetFacing(0)e.Banner.Glow:SetFrameLevel(2)e.Banner.Icon=e.Banner:CreateTexture(nil,"ARTWORK")e.Banner.Icon:SetSize(40,40)e.Banner.Icon:SetTexture("Interface\\icons\\FoxMountIcon")e.Banner.Icon:SetPoint("LEFT",10,0)e.Banner.TitleText=e.Banner:CreateFontString("StoreCollectionListFrameTitleText")e.Banner.TitleText:SetFont("Fonts\\FRIZQT__.ttf",22)e.Banner.TitleText:SetFontObject(GameFontHighlight)e.Banner.TitleText:SetPoint("TOP",e.Banner,"TOPLEFT",164.5,-9)e.Banner.TitleText:SetShadowOffset(0,-1)e.Banner.TitleText:SetSize(220,23)e.Banner.TitleText:SetText("MISTY FOX")e.Banner.TitleText:SetJustifyH("LEFT")e.Banner.DescText=e.Banner:CreateFontString("StoreCollectionListFrameTitleText")e.Banner.DescText:SetFont("Fonts\\FRIZQT__.ttf",12)e.Banner.DescText:SetFontObject(GameFontNormal)e.Banner.DescText:SetPoint("TOP",e.Banner,"TOPLEFT",168.5,-31)e.Banner.DescText:SetShadowOffset(1,-1)e.Banner.DescText:SetSize(225,13)e.Banner.DescText:SetText("YOU WON'T EVER GET LOST")e.Banner.DescText:SetJustifyH("LEFT")e.Banner.AnimationGroup=e.Banner:CreateAnimationGroup()e.Banner.AnimationGroup.Rotation=e.Banner.AnimationGroup:CreateAnimation("Translation")e.Banner.AnimationGroup.Rotation:SetStartDelay(.15)e.Banner.AnimationGroup.Rotation:SetDuration(0)e.Banner.AnimationGroup.Rotation:SetOrder(1)e.Banner.AnimationGroup.Rotation:SetEndDelay(0)e.Banner.AnimationGroup.Rotation:SetSmoothing("OUT")e.Banner.AnimationGroup.Rotation:SetOffset(0,30)e.Banner.AnimationGroup.Rotation2=e.Banner.AnimationGroup:CreateAnimation("Translation")e.Banner.AnimationGroup.Rotation2:SetDuration(1.2)e.Banner.AnimationGroup.Rotation2:SetOrder(2)e.Banner.AnimationGroup.Rotation2:SetEndDelay(15)e.Banner.AnimationGroup.Rotation2:SetSmoothing("OUT")e.Banner.AnimationGroup.Rotation2:SetOffset(0,-30)e.Banner.AnimationGroup.Rotation3=e.Banner.AnimationGroup:CreateAnimation("Translation")e.Banner.AnimationGroup.Rotation3:SetDuration(1.2)e.Banner.AnimationGroup.Rotation3:SetOrder(3)e.Banner.AnimationGroup.Rotation3:SetEndDelay(0)e.Banner.AnimationGroup.Rotation3:SetSmoothing("OUT")e.Banner.AnimationGroup.Rotation3:SetOffset(0,-30)e.Banner.AnimationGroup.Rotation3:SetScript("OnPlay",function()BaseFrameFadeOut(e.Banner)end)e.Paper=CreateFrame("FRAME","StoreCollectionFrameBanner",e,nil)e.Paper:SetPoint("CENTER",-235,-41)e.Paper:SetSize(280,305)e.Paper:SetFrameLevel(4)e.Paper_fake=CreateFrame("FRAME","StoreCollectionFrameBannerFake",e,nil)e.Paper_fake:SetPoint("CENTER",-235,-41)e.Paper_fake:SetSize(280,305)e.Paper_fake:SetFrameLevel(2)e.Paper.Icon=CreateFrame("Button","StoreCollectionFramePaperIcon",e.Paper_fake,nil)e.Paper.Icon:SetSize(40,40)e.Paper.Icon:SetPoint("BOTTOMLEFT",14,28)e.Paper.Icon:EnableMouse(true)e.Paper.Icon:SetNormalTexture("Interface\\icons\\FoxMountIcon")e.Paper.Icon:SetHighlightTexture("Interface\\BUTTONS\\ButtonHilight-Square")e.Paper.Icon:SetScript("OnEnter",function(t)GameTooltip:SetOwner(t,"ANCHOR_RIGHT")GameTooltip:SetHyperlink("item:"..e.ItemInternal..":0:0:0:0:0:0:0")GameTooltip:Show()end)e.Paper.Icon:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e.Paper.Icon:Hide()e.Paper.ItemPreview=CreateFrame("Button","StoreCollectionFramePaperIcon",e.Paper,nil)e.Paper.ItemPreview:SetSize(46,46)e.Paper.ItemPreview:SetPoint("BOTTOMLEFT",28,10)e.Paper.ItemPreview:EnableMouse(true)e.Paper.ItemPreview:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton")e.Paper.ItemPreview:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton_H")e.Paper.ItemPreview:SetScript("OnEnter",function(e)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:AddLine("|cffFFFFFFPreview Items|r")GameTooltip:AddLine("Click here to preview items")GameTooltip:Show()end)e.Paper.ItemPreview:SetScript("OnLeave",function(e)GameTooltip:Hide()end)e.Paper.ItemPreview:SetScript("OnClick",function(t)if not(e.ModelPreview_fake:IsVisible())then
w()else
i()end
end)e.Paper.ItemPreview:Hide()e.Paper.ItemPreview.HighLightAnimTex=e.Paper:CreateTexture(nil,"OVERLAY")e.Paper.ItemPreview.HighLightAnimTex:SetSize(46,46)e.Paper.ItemPreview.HighLightAnimTex:SetPoint("BOTTOMLEFT",28,10)e.Paper.ItemPreview.HighLightAnimTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewButton_H")e.Paper.ItemPreview.HighLightAnimTex:SetAlpha(0)e.Paper.ItemPreview.HighLightAnimTex:SetBlendMode("ADD")e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup=e.Paper.ItemPreview.HighLightAnimTex:CreateAnimationGroup()e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha1=e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup:CreateAnimation("Alpha")e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha1:SetDuration(.3)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha1:SetStartDelay(0)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha1:SetOrder(1)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha1:SetChange(1)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha2=e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup:CreateAnimation("Alpha")e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha2:SetDuration(.7)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha2:SetStartDelay(0)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha2:SetOrder(2)e.Paper.ItemPreview.HighLightAnimTex.AnimationGroup.Alpha2:SetChange(-1)e.Paper.BorderTex=e.Paper:CreateTexture(nil,"OVERLAY")e.Paper.BorderTex:SetSize(128,64)e.Paper.BorderTex:SetPoint("BOTTOMLEFT",-30,12)e.Paper.BorderTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\LearnedSpell_TextureNormal")e.Paper.BorderTex:Hide()e.Paper.ArtWork=e.Paper:CreateTexture(nil,"BACKGROUND")e.Paper.ArtWork:SetSize(256,256)e.Paper.ArtWork:SetTexture(e.DefaultArtworkTexture)e.Paper.ArtWork:SetPoint("CENTER",0,25)e.Paper.GoldBG=e.Paper:CreateTexture("StoreCollectionFramePaperGoldBG","BACKGROUND")e.Paper.GoldBG:SetTexture("Interface\\LevelUp\\LevelUpTex")e.Paper.GoldBG:SetSize(223,115)e.Paper.GoldBG:SetPoint("BOTTOM",0,16)e.Paper.GoldBG:SetTexCoord(.56054688,.99609375,.2421875,.46679688)e.Paper.GoldBG:SetVertexColor(1,1,1,0)e.Paper.Texture=e.Paper:CreateTexture("StoreCollectionFramePaperTexture","BACKGROUND",nil,2)e.Paper.Texture:SetTexture("Interface\\LevelUp\\LevelUpTex")e.Paper.Texture:SetSize(284,115)e.Paper.Texture:SetPoint("BOTTOM",0,14)e.Paper.Texture:SetTexCoord(.00195313,.63867188,.03710938,.23828125)e.Paper.Texture:SetVertexColor(1,1,1,.6)e.Paper.LineUp=e.Paper:CreateTexture("StoreCollectionFramePaperLineUp","BORDER",nil,2)e.Paper.LineUp:SetTexture("Interface\\LevelUp\\LevelUpTex")e.Paper.LineUp:SetSize(264,7)e.Paper.LineUp:SetPoint("BOTTOM",0,75)e.Paper.LineUp:SetTexCoord(.00195313,.81835938,.01953125,.03320313)e.Paper.LineUp:SetVertexColor(1,1,1)e.Paper.LineDown=e.Paper:CreateTexture("StoreCollectionFramePaperLineDown","BORDER",nil,2)e.Paper.LineDown:SetTexture("Interface\\LevelUp\\LevelUpTex")e.Paper.LineDown:SetSize(264,7)e.Paper.LineDown:SetPoint("BOTTOM",0,14)e.Paper.LineDown:SetTexCoord(.00195313,.81835938,.01953125,.03320313)e.Paper.LineDown:SetVertexColor(1,1,1)e.Paper.TitleText=e.Paper:CreateFontString("StoreCollectionListFrameTitleText")e.Paper.TitleText:SetFont("Fonts\\MORPHEUS.TTF",18)e.Paper.TitleText:SetFontObject(GameFontNormal)e.Paper.TitleText:SetPoint("CENTER",0,-35)e.Paper.TitleText:SetShadowOffset(1,-1)e.Paper.TitleText:SetSize(270,40)e.Paper.TitleText:SetText("Welcome to Vanity Items Collection!")e.Paper.DescText=e.Paper:CreateFontString("StoreCollectionListFrameTitleText")e.Paper.DescText:SetFont("Fonts\\FRIZQT__.TTF",11)e.Paper.DescText:SetFontObject(GameFontHighlight)e.Paper.DescText:SetPoint("BOTTOM",0,22)e.Paper.DescText:SetShadowOffset(0,-1)e.Paper.DescText:SetSize(160,50)e.Paper.DescText:SetText("Make sure to use your Vanity Items, that way they appear in your collection!")e.Paper.Texture.AnimationGroup=e.Paper.Texture:CreateAnimationGroup()e.Paper.Texture.AnimationGroup.Grow=e.Paper.Texture.AnimationGroup:CreateAnimation("Scale")e.Paper.Texture.AnimationGroup.Grow:SetScale(1,.001)e.Paper.Texture.AnimationGroup.Grow:SetDuration(0)e.Paper.Texture.AnimationGroup.Grow:SetStartDelay(0)e.Paper.Texture.AnimationGroup.Grow:SetOrder(1)e.Paper.Texture.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.Texture.AnimationGroup.Grow=e.Paper.Texture.AnimationGroup:CreateAnimation("Scale")e.Paper.Texture.AnimationGroup.Grow:SetScale(1,1e3)e.Paper.Texture.AnimationGroup.Grow:SetDuration(.15)e.Paper.Texture.AnimationGroup.Grow:SetStartDelay(.15)e.Paper.Texture.AnimationGroup.Grow:SetOrder(2)e.Paper.Texture.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.LineUp.AnimationGroup=e.Paper.LineUp:CreateAnimationGroup()e.Paper.LineUp.AnimationGroup.Grow=e.Paper.LineUp.AnimationGroup:CreateAnimation("Scale")e.Paper.LineUp.AnimationGroup.Grow:SetScale(.001,1)e.Paper.LineUp.AnimationGroup.Grow:SetDuration(0)e.Paper.LineUp.AnimationGroup.Grow:SetStartDelay(.15)e.Paper.LineUp.AnimationGroup.Grow:SetOrder(1)e.Paper.LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.LineUp.AnimationGroup.Grow=e.Paper.LineUp.AnimationGroup:CreateAnimation("Scale")e.Paper.LineUp.AnimationGroup.Grow:SetScale(1e3,1)e.Paper.LineUp.AnimationGroup.Grow:SetDuration(.5)e.Paper.LineUp.AnimationGroup.Grow:SetOrder(2)e.Paper.LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.LineDown.AnimationGroup=e.Paper.LineDown:CreateAnimationGroup()e.Paper.LineDown.AnimationGroup.Grow=e.Paper.LineDown.AnimationGroup:CreateAnimation("Scale")e.Paper.LineDown.AnimationGroup.Grow:SetScale(.001,1)e.Paper.LineDown.AnimationGroup.Grow:SetDuration(0)e.Paper.LineDown.AnimationGroup.Grow:SetStartDelay(.15)e.Paper.LineDown.AnimationGroup.Grow:SetOrder(1)e.Paper.LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.LineDown.AnimationGroup.Grow=e.Paper.LineDown.AnimationGroup:CreateAnimation("Scale")e.Paper.LineDown.AnimationGroup.Grow:SetScale(1e3,1)e.Paper.LineDown.AnimationGroup.Grow:SetDuration(.5)e.Paper.LineDown.AnimationGroup.Grow:SetOrder(2)e.Paper.LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)e.Paper.LineDown.AnimationGroup.Grow:SetScript("OnPlay",function()e.Paper.Texture.AnimationGroup:Stop();e.Paper.LineUp.AnimationGroup:Stop();e.Paper.Texture.AnimationGroup:Play();e.Paper.LineUp.AnimationGroup:Play();end)local t=CreateFrame("FRAME","StoreCollectionListFrame",e,nil)t:SetPoint("CENTER",150,-15)t:SetSize(470,425)t:EnableMouseWheel(true)t:SetScript("OnMouseWheel",function(n,e)if(t.PrevButton:IsEnabled()==1)and(e==-1)then
c(t.PrevButton)elseif(t.NextButton:IsEnabled()==1)and(e==1)then
u(t.NextButton)end
end)t.Glow=CreateFrame("Model","StoreCollectionListFrameGlow",t)t.Glow:SetSize(470,425)t.Glow:SetPoint("CENTER",0,0)t.Glow:SetModel("World\\Kalimdor\\orgrimmar\\passivedoodads\\orgrimmarbonfire\\orgrimmarfloatingembers.m2")t.Glow:SetModelScale(.1)t.Glow:SetCamera(0)t.Glow:SetPosition(.085,.21,0)t.Glow:SetFacing(0)t.Glow:SetFrameLevel(2)t.Glow2=CreateFrame("Model","StoreCollectionListFrameGlow2",t)t.Glow2:SetSize(470,425)t.Glow2:SetPoint("CENTER",0,0)t.Glow2:SetModel("World\\Kalimdor\\orgrimmar\\passivedoodads\\orgrimmarbonfire\\orgrimmarfloatingembers.m2")t.Glow2:SetModelScale(.1)t.Glow2:SetCamera(0)t.Glow2:SetPosition(.085,.21,0)t.Glow2:SetFacing(0)t.Glow2:SetFrameLevel(2)t.TitleText=t:CreateFontString("StoreCollectionListFrameTitleText")t.TitleText:SetFont("Fonts\\MORPHEUS.TTF",14)t.TitleText:SetFontObject(GameFontNormal)t.TitleText:SetPoint("TOP",0,-32)t.TitleText:SetShadowOffset(0,-1)t.TitleText:SetText("Vanity Items Collection")t.PageText=t:CreateFontString("StoreCollectionListFrameTitleText")t.PageText:SetFont("Fonts\\FRIZQT__.TTF",12)t.PageText:SetFontObject(GameFontHighlight)t.PageText:SetPoint("BOTTOM",0,15)t.PageText:SetShadowOffset(0,-1)t.PageText:SetText("Page 1/1")t.NextButton=CreateFrame("Button","StoreCollectionListFrameNextButton",t,nil)t.NextButton:SetSize(26,26)t.NextButton:SetPoint("BOTTOM",150,12)t.NextButton:EnableMouse(true)t.NextButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")t.NextButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")t.NextButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")t.NextButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")t.NextButton:SetScript("OnClick",u)t.PrevButton=CreateFrame("Button","StoreCollectionListFramePrevButton",t,nil)t.PrevButton:SetSize(26,26)t.PrevButton:SetPoint("BOTTOM",-150,12)t.PrevButton:EnableMouse(true)t.PrevButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")t.PrevButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")t.PrevButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")t.PrevButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")t.PrevButton:SetScript("OnClick",c)StoreCollectionItemFrame1=CreateFrame("FRAME","StoreCollectionItemFrame1",t,nil)StoreCollectionItemFrame1:SetPoint("CENTER",-152,95)StoreCollectionItemFrame1:SetSize(256,128)StoreCollectionItemFrame2=CreateFrame("FRAME","StoreCollectionItemFrame2",t,nil)StoreCollectionItemFrame2:SetPoint("CENTER",-2,95)StoreCollectionItemFrame2:SetSize(256,128)StoreCollectionItemFrame3=CreateFrame("FRAME","StoreCollectionItemFrame3",t,nil)StoreCollectionItemFrame3:SetPoint("CENTER",148,95)StoreCollectionItemFrame3:SetSize(256,128)StoreCollectionItemFrame4=CreateFrame("FRAME","StoreCollectionItemFrame4",t,nil)StoreCollectionItemFrame4:SetPoint("CENTER",-152,-11)StoreCollectionItemFrame4:SetSize(256,128)StoreCollectionItemFrame4:SetFrameLevel(5)StoreCollectionItemFrame5=CreateFrame("FRAME","StoreCollectionItemFrame5",t,nil)StoreCollectionItemFrame5:SetPoint("CENTER",-2,-11)StoreCollectionItemFrame5:SetSize(256,128)StoreCollectionItemFrame5:SetFrameLevel(5)StoreCollectionItemFrame6=CreateFrame("FRAME","StoreCollectionItemFrame6",t,nil)StoreCollectionItemFrame6:SetPoint("CENTER",148,-11)StoreCollectionItemFrame6:SetSize(256,128)StoreCollectionItemFrame6:SetFrameLevel(5)StoreCollectionItemFrame7=CreateFrame("FRAME","StoreCollectionItemFrame7",t,nil)StoreCollectionItemFrame7:SetPoint("CENTER",-152,-117)StoreCollectionItemFrame7:SetSize(256,128)StoreCollectionItemFrame7:SetFrameLevel(6)StoreCollectionItemFrame8=CreateFrame("FRAME","StoreCollectionItemFrame8",t,nil)StoreCollectionItemFrame8:SetPoint("CENTER",-2,-117)StoreCollectionItemFrame8:SetSize(256,128)StoreCollectionItemFrame8:SetFrameLevel(6)StoreCollectionItemFrame9=CreateFrame("FRAME","StoreCollectionItemFrame9",t,nil)StoreCollectionItemFrame9:SetPoint("CENTER",148,-117)StoreCollectionItemFrame9:SetSize(256,128)StoreCollectionItemFrame9:SetFrameLevel(6)for t=1,9 do
_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]=_G["StoreCollectionItemFrame"..t]:CreateTexture(nil,"BACKGROUND")_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]:SetSize(_G["StoreCollectionItemFrame"..t]:GetSize())_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreButtonBG")_G["StoreCollectionItemFrame"..t..".BackgroundTexture"]:SetPoint("CENTER")_G["StoreCollectionItemFrame"..t..".Button"]=CreateFrame("Button","StoreCollectionItemFrame"..t.."Button",_G["StoreCollectionItemFrame"..t],nil)_G["StoreCollectionItemFrame"..t..".Button"]:SetSize(131,99)_G["StoreCollectionItemFrame"..t..".Button"]:SetPoint("CENTER",0,0)_G["StoreCollectionItemFrame"..t..".Button"]:EnableMouse(true)_G["StoreCollectionItemFrame"..t..".Button"]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreButtonBG_Highlight")_G["StoreCollectionItemFrame"..t..".Button"]:GetHighlightTexture():ClearAllPoints()_G["StoreCollectionItemFrame"..t..".Button"]:GetHighlightTexture():SetPoint("CENTER",0,0)_G["StoreCollectionItemFrame"..t..".Button"]:GetHighlightTexture():SetSize(256,128)_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]=_G["StoreCollectionItemFrame"..t]:CreateTexture(nil,"ARTWORK")_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]:SetSize(92,92)_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\prestige-icon-4")_G["StoreCollectionItemFrame"..t..".PrestigeTexture"]:SetPoint("CENTER",0,10)_G["StoreCollectionItemFrame"..t..".IconFrame"]=CreateFrame("FRAME","StoreCollectionItemFrame"..t.."IconFrame",_G["StoreCollectionItemFrame"..t],nil)_G["StoreCollectionItemFrame"..t..".IconFrame"]:SetPoint("CENTER")_G["StoreCollectionItemFrame"..t..".IconFrame"]:SetSize(_G["StoreCollectionItemFrame"..t]:GetSize())_G["StoreCollectionItemFrame"..t..".Icon"]=_G["StoreCollectionItemFrame"..t..".IconFrame"]:CreateTexture(nil,"BACKGROUND")_G["StoreCollectionItemFrame"..t..".Icon"]:SetSize(40,40)_G["StoreCollectionItemFrame"..t..".Icon"]:SetTexture("Interface\\icons\\FoxMountIcon")_G["StoreCollectionItemFrame"..t..".Icon"]:SetPoint("CENTER",0,11)SetPortraitToTexture(_G["StoreCollectionItemFrame"..t..".Icon"],"Interface\\icons\\FoxMountIcon")_G["StoreCollectionItemFrame"..t..".RoundBG"]=_G["StoreCollectionItemFrame"..t..".IconFrame"]:CreateTexture(nil,"BACKGROUND")_G["StoreCollectionItemFrame"..t..".RoundBG"]:SetSize(128,64)_G["StoreCollectionItemFrame"..t..".RoundBG"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreCollectionRoundBG")_G["StoreCollectionItemFrame"..t..".RoundBG"]:SetPoint("CENTER",0,10)_G["StoreCollectionItemFrame"..t..".Circle"]=_G["StoreCollectionItemFrame"..t..".IconFrame"]:CreateTexture(nil,"ARTWORK")_G["StoreCollectionItemFrame"..t..".Circle"]:SetSize(64,64)_G["StoreCollectionItemFrame"..t..".Circle"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreCollectionRound")_G["StoreCollectionItemFrame"..t..".Circle"]:SetPoint("CENTER",0,10)_G["StoreCollectionItemFrame"..t..".GroupIcon"]=_G["StoreCollectionItemFrame"..t..".IconFrame"]:CreateTexture(nil,"OVERLAY")_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetSize(40,40)_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\category-icon-featured")_G["StoreCollectionItemFrame"..t..".GroupIcon"]:SetPoint("CENTER",0,-10)_G["StoreCollection"..t..".TextNormal"]=_G["StoreCollectionItemFrame"..t]:CreateFontString("StoreCollection"..t.."TextNormal")_G["StoreCollection"..t..".TextNormal"]:SetSize(120,22)_G["StoreCollection"..t..".TextNormal"]:SetFont("Fonts\\FRIZQT__.TTF",11)_G["StoreCollection"..t..".TextNormal"]:SetFontObject(GameFontHighlight)_G["StoreCollection"..t..".TextNormal"]:SetPoint("CENTER",0,-30)_G["StoreCollection"..t..".TextNormal"]:SetShadowOffset(0,-1)_G["StoreCollection"..t..".TextNormal"]:SetText("[Misty Fox]")_G["StoreCollection"..t..".TextNormal"]:SetJustifyH("CENTER")_G["StoreCollectionItemFrame"..t..".Button"]:SetScript("OnClick",function(n)PlaySound("igMainMenuOptionCheckBoxOn")local I=_G["StoreCollectionItemFrame"..t..".Button.Icon"]local u=_G["StoreCollectionItemFrame"..t..".Button.ArtWork"]local c=_G["StoreCollectionItemFrame"..t..".Button.ArtWorkPreview"]local S=_G["StoreCollectionItemFrame"..t..".Button.ItemName"]local l=_G["StoreCollectionItemFrame"..t..".Button.ItemDescription"]local n=_G["StoreCollectionItemFrame"..t..".Button.SeasonalPointsCost"]local o=_G["StoreCollectionItemFrame"..t..".Button.DonatePointsCost"]local a=_G["StoreCollectionItemFrame"..t..".Button.ItemInternal"]local r=_G["StoreCollectionItemFrame"..t..".Button.Item"]local t=_G["StoreCollectionItemFrame"..t..".Button.PreviewData"]e.Paper.Icon:SetNormalTexture(I)e.Paper.ArtWork:SetTexture(u)e.Paper.TitleText:SetText(S)e.Paper.DescText:SetText(l)e.ItemInternal=a
e.Preview_Current=t
if not(e.ModelPreview.BGTex:SetTexture(c))then
e.ModelPreview.BGTex:SetTexture(e.DefaultPreviewTexture)end
if(n~=0)or(o~=0)then
e.SP_Cost_Current=n
e.DP_Cost_Current=o
e.BuyStoreButton:Enable()else
e.BuyStoreButton:Disable()end
if(r~=0)then
e.ItemSelected=r
e.ActivateStoreButton:Enable()e.BuyStoreButton:Disable()else
e.ItemSelected=0
e.ActivateStoreButton:Disable()end
i()m()end)_G["StoreCollectionItemFrame"..t]:Hide()end
NewItemInCollection=CreateFrame("FRAME","NewItemInCollectionAnimationBackground",UIParent,nil)NewItemInCollection:SetPoint("CENTER",UIParent,0,200)NewItemInCollection:SetSize(512,512)NewItemInCollection:SetFrameLevel(7)NewItemInCollection:Hide()NewItemInCollection.HighLightOfNewItem=CreateFrame("FRAME","NewItemInCollectionAnimationBackgroundHighLightOfNewItem",NewItemInCollection,nil)NewItemInCollection.HighLightOfNewItem:SetPoint("CENTER",NewItemInCollection,0,40)NewItemInCollection.HighLightOfNewItem:SetSize(256,256)NewItemInCollection.HighLightOfNewItem:SetFrameLevel(7)NewItemInCollection.HighLightOfNewItem.HighlightTex=NewItemInCollection.HighLightOfNewItem:CreateTexture(nil,"ARTWORK")NewItemInCollection.HighLightOfNewItem.HighlightTex:SetSize(256,256)NewItemInCollection.HighLightOfNewItem.HighlightTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\DragonHighlight")NewItemInCollection.HighLightOfNewItem.HighlightTex:SetPoint("CENTER",0,0)NewItemInCollection.HighLightOfNewItem.HighlightTex:SetBlendMode("ADD")NewItemInCollection.HighLightOfNewItem.Glow=CreateFrame("Model","NewItemInCollectionAnimationBackgroundHighLightOfNewItemGlow",NewItemInCollection.HighLightOfNewItem)NewItemInCollection.HighLightOfNewItem.Glow:SetWidth(256);NewItemInCollection.HighLightOfNewItem.Glow:SetHeight(256);NewItemInCollection.HighLightOfNewItem.Glow:SetPoint("CENTER",0,0)NewItemInCollection.HighLightOfNewItem.Glow:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")NewItemInCollection.HighLightOfNewItem.Glow:SetModelScale(.02)NewItemInCollection.HighLightOfNewItem.Glow:SetCamera(0)NewItemInCollection.HighLightOfNewItem.Glow:SetPosition(.075,.09,0)NewItemInCollection.HighLightOfNewItem.Glow:SetFacing(0)NewItemInCollection.HighLightOfNewItem.Glow:SetFrameLevel(7)NewItemInCollectionMain=CreateFrame("FRAME","NewItemInCollectionMain",NewItemInCollection,nil)NewItemInCollectionMain:SetPoint("CENTER",0,25)NewItemInCollectionMain:SetSize(256,128)NewItemInCollectionMain:SetFrameLevel(8)NewItemInCollectionMain:EnableMouse(true)NewItemInCollectionMain:SetAlpha(0)NewItemInCollectionMain.PrestigeTexture=NewItemInCollectionMain:CreateTexture(nil,"BORDER",nil,10)NewItemInCollectionMain.PrestigeTexture:SetSize(92,92)NewItemInCollectionMain.PrestigeTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\prestige-icon-4")NewItemInCollectionMain.PrestigeTexture:SetPoint("CENTER",0,10)NewItemInCollectionMain.Icon=NewItemInCollectionMain:CreateTexture(nil,"ARTWORK",nil,2)NewItemInCollectionMain.Icon:SetSize(40,40)NewItemInCollectionMain.Icon:SetTexture("Interface\\icons\\FoxMountIcon")NewItemInCollectionMain.Icon:SetPoint("CENTER",0,11)SetPortraitToTexture(NewItemInCollectionMain.Icon,"Interface\\icons\\FoxMountIcon")NewItemInCollectionMain.RoundBG=NewItemInCollectionMain:CreateTexture(nil,"ARTWORK",nil,2)NewItemInCollectionMain.RoundBG:SetSize(128,64)NewItemInCollectionMain.RoundBG:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreCollectionRoundBG")NewItemInCollectionMain.RoundBG:SetPoint("CENTER",0,10)NewItemInCollectionMain.Circle=NewItemInCollectionMain:CreateTexture(nil,"OVERLAY",nil,1)NewItemInCollectionMain.Circle:SetSize(64,64)NewItemInCollectionMain.Circle:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\StoreCollectionRound")NewItemInCollectionMain.Circle:SetPoint("CENTER",0,10)NewItemInCollectionMain.TextAdd=NewItemInCollectionMain:CreateFontString("NewItemInCollectionNewEnchantInCollectionTextAdd","OVERLAY")NewItemInCollectionMain.TextAdd:SetSize(300,20)NewItemInCollectionMain.TextAdd:SetFont("Fonts\\FRIZQT__.TTF",11)NewItemInCollectionMain.TextAdd:SetFontObject(GameFontNormal)NewItemInCollectionMain.TextAdd:SetPoint("CENTER",0,-60)NewItemInCollectionMain.TextAdd:SetShadowOffset(0,-1)NewItemInCollectionMain.TextAdd:SetText("|cffFFFFFFYou have successfuly unlocked|r Vanity Item|cffFFFFFF!|r")NewItemInCollectionMain.TextNormal=NewItemInCollectionMain:CreateFontString("NewItemInCollectionMainTextNorma","OVERLAY")NewItemInCollectionMain.TextNormal:SetSize(300,20)NewItemInCollectionMain.TextNormal:SetFont("Fonts\\FRIZQT__.TTF",14)NewItemInCollectionMain.TextNormal:SetFontObject(GameFontNormal)NewItemInCollectionMain.TextNormal:SetPoint("CENTER",0,-30)NewItemInCollectionMain.TextNormal:SetShadowOffset(0,-1)NewItemInCollectionMain.TextNormal:SetText("VANITY ITEM NAME")NewItemInCollectionMain.Texture=NewItemInCollectionMain:CreateTexture("NewItemInCollectionMainTexture","BACKGROUND",nil,2)NewItemInCollectionMain.Texture:SetTexture("Interface\\LevelUp\\LevelUpTex")NewItemInCollectionMain.Texture:SetSize(284,115)NewItemInCollectionMain.Texture:SetPoint("CENTER",0,10)NewItemInCollectionMain.Texture:SetTexCoord(.00195313,.63867188,.03710938,.23828125)NewItemInCollectionMain.Texture:SetVertexColor(1,1,1,.6)NewItemInCollectionMain.LineUp=NewItemInCollectionMain:CreateTexture("NewItemInCollectionMainLineUp","BORDER",nil,2)NewItemInCollectionMain.LineUp:SetTexture("Interface\\LevelUp\\LevelUpTex")NewItemInCollectionMain.LineUp:SetSize(264,7)NewItemInCollectionMain.LineUp:SetPoint("CENTER",0,15)NewItemInCollectionMain.LineUp:SetTexCoord(.00195313,.81835938,.01953125,.03320313)NewItemInCollectionMain.LineUp:SetVertexColor(1,1,1)NewItemInCollectionMain.LineDown=NewItemInCollectionMain:CreateTexture("NewItemInCollectionMainLineDown","BORDER",nil,2)NewItemInCollectionMain.LineDown:SetTexture("Interface\\LevelUp\\LevelUpTex")NewItemInCollectionMain.LineDown:SetSize(264,7)NewItemInCollectionMain.LineDown:SetPoint("CENTER",0,-46)NewItemInCollectionMain.LineDown:SetTexCoord(.00195313,.81835938,.01953125,.03320313)NewItemInCollectionMain.LineDown:SetVertexColor(1,1,1)NewItemInCollectionMain.Texture.AnimationGroup=NewItemInCollectionMain.Texture:CreateAnimationGroup()NewItemInCollectionMain.Texture.AnimationGroup.Grow=NewItemInCollectionMain.Texture.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetScale(1,.001)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetDuration(0)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetStartDelay(0)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetOrder(1)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.Texture.AnimationGroup.Grow=NewItemInCollectionMain.Texture.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetScale(1,1e3)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetDuration(.15)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetStartDelay(.15)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetOrder(2)NewItemInCollectionMain.Texture.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.LineUp.AnimationGroup=NewItemInCollectionMain.LineUp:CreateAnimationGroup()NewItemInCollectionMain.LineUp.AnimationGroup.Grow=NewItemInCollectionMain.LineUp.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetScale(.001,1)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetDuration(0)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetStartDelay(.15)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetOrder(1)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.LineUp.AnimationGroup.Grow=NewItemInCollectionMain.LineUp.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetScale(1e3,1)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetDuration(.5)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetOrder(2)NewItemInCollectionMain.LineUp.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.LineDown.AnimationGroup=NewItemInCollectionMain.LineDown:CreateAnimationGroup()NewItemInCollectionMain.LineDown.AnimationGroup.Grow=NewItemInCollectionMain.LineDown.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetScale(.001,1)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetDuration(0)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetStartDelay(.15)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetOrder(1)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.LineDown.AnimationGroup.Grow=NewItemInCollectionMain.LineDown.AnimationGroup:CreateAnimation("Scale")NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetScale(1e3,1)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetDuration(.5)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetOrder(2)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetOrigin("BOTTOM",0,0)NewItemInCollectionMain.LineDown.AnimationGroup.Grow:SetScript("OnPlay",function()NewItemInCollectionMain.Texture.AnimationGroup:Stop();NewItemInCollectionMain.LineUp.AnimationGroup:Stop();NewItemInCollectionMain.Texture.AnimationGroup:Play();NewItemInCollectionMain.LineUp.AnimationGroup:Play();end)NewItemInCollection.HighLightOfNewItem.AnimationGroup=NewItemInCollection.HighLightOfNewItem:CreateAnimationGroup()NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation=NewItemInCollection.HighLightOfNewItem.AnimationGroup:CreateAnimation("Rotation")NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetStartDelay(0)NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetDuration(6)NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetOrder(1)NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetEndDelay(0)NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetSmoothing("NONE")NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetDegrees(90)NewItemInCollection.HighLightOfNewItem.AnimationGroup.Rotation:SetScript("OnPlay",function()PlaySound("igQuestListComplete")BaseFrameFadeIn(NewItemInCollection)end)NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut=NewItemInCollection.HighLightOfNewItem.AnimationGroup:CreateAnimation("Alpha")NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetStartDelay(0)NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetDuration(3)NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetOrder(2)NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetEndDelay(0)NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetSmoothing("NONE")NewItemInCollection.HighLightOfNewItem.AnimationGroup.AlphaFadeOut:SetChange(-1)NewItemInCollection.HighLightOfNewItem.AnimationGroup:SetScript("OnStop",function()NewItemInCollection:Hide()end)NewItemInCollection.HighLightOfNewItem.AnimationGroup:SetScript("OnFinished",function()NewItemInCollection:Hide()end)NewItemInCollectionMain.AnimationGroup=NewItemInCollectionMain:CreateAnimationGroup()NewItemInCollectionMain.AnimationGroup.Alpha=NewItemInCollectionMain.AnimationGroup:CreateAnimation("Alpha")NewItemInCollectionMain.AnimationGroup.Alpha:SetStartDelay(0)NewItemInCollectionMain.AnimationGroup.Alpha:SetDuration(1)NewItemInCollectionMain.AnimationGroup.Alpha:SetOrder(1)NewItemInCollectionMain.AnimationGroup.Alpha:SetEndDelay(5)NewItemInCollectionMain.AnimationGroup.Alpha:SetSmoothing("NONE")NewItemInCollectionMain.AnimationGroup.Alpha:SetChange(1)NewItemInCollectionMain.AnimationGroup.Alpha:SetScript("OnPlay",function()NewItemInCollectionMain:Show()NewItemInCollectionMain.LineDown.AnimationGroup:Play()NewItemInCollection.HighLightOfNewItem.AnimationGroup:Play()end)NewItemInCollectionMain.AnimationGroup.AlphaFadeOut=NewItemInCollectionMain.AnimationGroup:CreateAnimation("Alpha")NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetStartDelay(0)NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetDuration(3)NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetOrder(2)NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetEndDelay(0)NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetSmoothing("NONE")NewItemInCollectionMain.AnimationGroup.AlphaFadeOut:SetChange(-1)NewItemInCollectionMain.AnimationGroup:SetScript("OnStop",function()NewItemInCollectionMain:Hide()NewItemInCollection.HighLightOfNewItem.AnimationGroup:Finish()end)NewItemInCollectionMain.AnimationGroup:SetScript("OnFinished",function()NewItemInCollectionMain:Hide()NewItemInCollection.HighLightOfNewItem.AnimationGroup:Finish()end)e.ModelPreview=CreateFrame("DressUpModel","StoreCollectionFrameModelPreview",e)e.ModelPreview.HackFix=0
e.ModelPreview.MaxSize=1.2
e.ModelPreview.MinSize=.6
e.ModelPreview.Creature=101230
e.ModelPreview.DefaultSize=e.ModelPreview.MaxSize-(e.ModelPreview.MaxSize-e.ModelPreview.MinSize)/2
e.ModelPreview.DefaultFacing=.75
e.ModelPreview:SetSize(455,410)e.ModelPreview:SetPoint("CENTER",147,-15)e.ModelPreview:SetFrameLevel(9)e.ModelPreview:SetCreature(e.ModelPreview.Creature)e.ModelPreview:RefreshUnit()e.ModelPreview:SetFacing(e.ModelPreview.DefaultFacing)e.ModelPreview:SetCamera(0)e.ModelPreview:SetLight(1,0,0,-.707,-.707,.7,1,1,1,.8,1,1,.8);e.ModelPreview:SetModelScale(e.ModelPreview.DefaultSize)l(e.ModelPreview)e.ModelPreview:Hide()e.ModelPreview_fake=CreateFrame("Frame","StoreCollectionFrameModelPreview_fake",e)e.ModelPreview_fake:SetSize(455,410)e.ModelPreview_fake:SetPoint("CENTER",147,-15)e.ModelPreview_fake:SetFrameLevel(9)e.ModelPreview_fake:EnableMouse(true)e.ModelPreview_fake:EnableMouseWheel(true)e.ModelPreview_fake:Hide()e.ModelPreview_fake.CloseButton=CreateFrame("Button","StoreCollectionFrameModelPreview_fakeCloseButton",e.ModelPreview_fake,"UIPanelCloseButton")e.ModelPreview_fake.CloseButton:SetPoint("TOPRIGHT",6,6)e.ModelPreview_fake.CloseButton:EnableMouse(true)e.ModelPreview_fake.CloseButton:SetScript("OnMouseUp",function()PlaySound("igMainMenuClose")i()m()end)d(e.ModelPreview)e.ModelPreview.BGTex=e.ModelPreview_fake:CreateTexture(nil,"BACKGROUND")e.ModelPreview.BGTex:SetSize(1024,512)e.ModelPreview.BGTex:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Collections\\PreviewMounts\\MountPreview")e.ModelPreview.BGTex:SetPoint("CENTER",1,0)e.ModelPreview:SetScript("OnShow",function(t)l(t)t:SetFacing(e.ModelPreview.DefaultFacing)t:SetModelScale(.8)S()end)e.ModelPreview:SetScript("OnHide",function(t)l(t)t:SetFacing(e.ModelPreview.DefaultFacing)t:SetModelScale(e.ModelPreview.DefaultSize)S()end)e.ModelPreview_fake:SetScript("OnUpdate",function()if(ModelPreview_SELECT_ROTATION_START_X)then
local t=GetCursorPosition();local t=(t-ModelPreview_SELECT_ROTATION_START_X)*.01;ModelPreview_SELECT_ROTATION_START_X=GetCursorPosition();e.ModelPreview:SetFacing((e.ModelPreview:GetFacing()+t));end
end)e.ModelPreview_fake:SetScript("OnMouseDown",function(n,t)if(t=="LeftButton")then
ModelPreview_SELECT_ROTATION_START_X=GetCursorPosition();ModelPreview_SELECT_INITIAL_FACING=e.ModelPreview:GetFacing();end
end)e.ModelPreview_fake:SetScript("OnMouseUp",function(t,e)if(e=="LeftButton")then
ModelPreview_SELECT_ROTATION_START_X=nil
end
end)e.ModelPreview_fake:SetScript("OnMouseWheel",function(n,t)if e.ModelPreview:GetModelScale()>=e.ModelPreview.MaxSize and t>0 then
return false
end
if e.ModelPreview:GetModelScale()<=e.ModelPreview.MinSize and t<0 then
return false
end
e.ModelPreview:SetModelScale(e.ModelPreview:GetModelScale()+(t*.1))end)e.ConfirmBuy=CreateFrame("Frame","StoreCollectionFrameConfirmDisenchant",e,nil)e.ConfirmBuy:ClearAllPoints()e.ConfirmBuy:SetBackdrop(StaticPopup1:GetBackdrop())e.ConfirmBuy:SetHeight(115)e.ConfirmBuy:SetWidth(390)e.ConfirmBuy:SetPoint("CENTER",e,0,0)e.ConfirmBuy:SetFrameLevel(14)e.ConfirmBuy:EnableMouse(true)e.ConfirmBuy:Hide()e.ConfirmBuy.text=e.ConfirmBuy:CreateFontString(nil,"BORDER","GameFontHighlight")e.ConfirmBuy.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmBuy.text:SetText("Are you sure that you want\nto purchase following item:\nITEMLINK\n\nItem cost: |cffFFFFFF10|r Seasonal Points")e.ConfirmBuy.text:SetPoint("TOP",0,-20)e.ConfirmBuy.Alert=e.ConfirmBuy:CreateTexture("StoreCollectionFrameConfirmDisenchantAlert")e.ConfirmBuy.Alert:SetTexture("Interface\\Icons\\inv_archaeology_70_demon_orbofinnerchaos")e.ConfirmBuy.Alert:SetSize(48,48)e.ConfirmBuy.Alert:SetPoint("LEFT",24,0)e.ConfirmBuy.Yes=CreateFrame("Button",nil,e.ConfirmBuy,"StaticPopupButtonTemplate")e.ConfirmBuy.Yes:SetWidth(110)e.ConfirmBuy.Yes:SetHeight(19)e.ConfirmBuy.Yes:SetPoint("BOTTOM",-60,15)e.ConfirmBuy.Yes:SetScript("OnClick",function(t)I(t)e.ConfirmBuy:Hide()end)e.ConfirmBuy.No=CreateFrame("Button",nil,e.ConfirmBuy,"StaticPopupButtonTemplate")e.ConfirmBuy.No:SetWidth(110)e.ConfirmBuy.No:SetHeight(19)e.ConfirmBuy.No:SetPoint("BOTTOM",60,15)e.ConfirmBuy.No:SetScript("OnClick",function()e.ConfirmBuy:Hide()end)e.ConfirmBuy.Yes.text=e.ConfirmBuy.Yes:CreateFontString(nil,"BACKGROUND","GameFontNormal")e.ConfirmBuy.Yes.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmBuy.Yes.text:SetText("Accept")e.ConfirmBuy.Yes.text:SetPoint("CENTER",0,1)e.ConfirmBuy.No.text=e.ConfirmBuy.No:CreateFontString(nil,"BACKGROUND","GameFontNormal")e.ConfirmBuy.No.text:SetFont("Fonts\\FRIZQT__.TTF",11)e.ConfirmBuy.No.text:SetText("Cancel")e.ConfirmBuy.No.text:SetPoint("CENTER",0,1)e.ConfirmBuy.Yes:SetFontString(e.ConfirmBuy.Yes.text)e.ConfirmBuy.No:SetFontString(e.ConfirmBuy.No.text)e.ConfirmBuy:SetScript("OnShow",function(t)PlaySound("igMainMenuOpen")if(e.ItemInternal~=0)then
local n,t=GetItemInfo(e.ItemInternal)e.ConfirmBuy.text:SetText("|cffE1AB18Are you sure that you want\nto purchase following item:\n"..t.."\n\n|cffE1AB18Item cost: |cffFFFFFF"..e.SP_Cost_Current.."|r|cffE1AB18 Seasonal Points")if(e.SP_Cost_Current<=e.SPBalance)then
e.ConfirmBuy.Yes:Enable()else
e.ConfirmBuy.Yes:Disable()end
end
end)e.ConfirmBuy:SetScript("OnHide",function(e)PlaySound("igMainMenuClose")end)if(e.TotalItems==0)then
o.Handle("StoreCollections","RequestList")end
print(string.format("|cFF00FF00Loaded Store Collections Client v%.2f |r",G))