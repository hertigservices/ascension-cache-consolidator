Ulocal l=AIO or require("AIO")local e=1.13
if l.AddAddon()then
return
end
local e=CreateFrame("Frame","ResetFrame_main",UIParent,nil)local F=0
local S=0
local t={[0]={2500,2700,105,105},[10]={5e3,7500,150,150},[20]={7500,1e4,2150,2150},[30]={5e4,15e4,3250,3250},[40]={75e3,3e5,9250,9250},[50]={9e4,4e5,10550,10550},[60]={1e5,5e5,25e3,5e4},[70]={25e4,25e5,25e3,5e4},[80]={25e4,25e5,25e3,5e4},}for n,e in pairs(t)do
for a,e in pairs(e)do
t[n][a]=math.floor(e/3)end
end
local T=false
local s=true
local function o(n)local l=nil
local r=nil
local i=nil
local a=nil
local o=1
if(n==2)then
r=F
l=GetItemCount(383082)elseif(n==1)then
r=S
l=GetItemCount(383083)end
if(l>1)then
i="token"a="token"return i,a
else
for e,s in pairs(t)do
if(UnitLevel("player")>=e)and(UnitLevel("player")<e+10)then
if(n==2)then
o=t[e][4]elseif(n==1)then
o=t[e][3]end
if(l==1)then
i="token"a=t[e][n]+o*(UnitLevel("player")-e+r*2)else
i=t[e][n]+o*(UnitLevel("player")-e+r*2)a=t[e][n]+o*(UnitLevel("player")-e+(r+1)*2)end
if(tonumber(i))then
if(i>t[e][n]*3)then
i=t[e][n]*3
end
end
if(tonumber(a))then
if(a>t[e][n]*3)then
a=t[e][n]*3
end
end
return i,a
end
end
end
end
local function i()ResetFrame_AmountOfResets_Count:SetText("|cffFFFFFF"..F+S.."|r")local n=0
local a=0
for e,t in pairs(t)do
if(UnitLevel("player")>=e)and(UnitLevel("player")<e+10)then
n=e
a=e+10
if(e==0)then
n=1
end
end
end
ResetFrame_AmountOfResets_Count_Text:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSYOUHAD)..n.."-"..a.."]|r")end
function ResetFrame_GetPurgeCost(n)local t,e,a,a=nil
if(n=="talent")then
t,e=o(1)if(t=="token")then
dialogText="1 Talent Purge |TInterface\\Icons\\inv_custom_talentpurge.blp:14:14:0:0|t"else
local e,t,n=GetGoldForMoney(t)dialogText=e.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..n.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"end
if(e=="token")then
dialogText_2="1 Talent Purge |TInterface\\Icons\\inv_custom_talentpurge.blp:14:14:0:0|t"else
local n,e,t=GetGoldForMoney(e)dialogText_2=n.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..e.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"end
if(UnitLevel("player")==10)then
return"FREE","FREE"end
return dialogText,dialogText_2
elseif(n=="ability")then
if(T)then
ResetFrame_AbilityFrame_Cost:SetText("|cffFF0000Not Available in Wildcard Mode|r")ResetFrame_AbilityFrame_NextCost:SetText("|cffFF0000Not Available in Wildcard Mode|r")elseif(s)then
ResetFrame_AbilityFrame_Cost:SetText("|cffFF0000Not Available in Draft Mode|r")ResetFrame_AbilityFrame_NextCost:SetText("|cffFF0000Not Available in Draft Mode|r")elseif not(UnitLevel("player")<11)then
t,e=o(2)if(t=="token")then
dialogText="1 Ability Purge |TInterface\\Icons\\inv_custom_abilitypurge.blp:14:14:0:0|t|cffFFFFFF"else
local n,t,e=GetGoldForMoney(t)dialogText=n.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..e.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"end
if(e=="token")then
dialogText_2="1 Ability Purge |TInterface\\Icons\\inv_custom_abilitypurge.blp:14:14:0:0|t|cffFFFFFF"else
local e,t,n=GetGoldForMoney(e)dialogText_2=e.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..t.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..n.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"end
ResetFrame_AbilityFrame_Cost:SetText(dialogText)ResetFrame_AbilityFrame_NextCost:SetText(dialogText_2)return dialogText,dialogText_2
else
ResetFrame_AbilityFrame_Cost:SetText("Free")ResetFrame_AbilityFrame_NextCost:SetText("Free")return"FREE","FREE"end
end
end
function ResetButton_button_pushed(e)PlaySound("igMainMenuOptionCheckBoxOn")if(e:IsEnabled()==0)then
return false
end
if(TrainingFrame:IsVisible())then
TrainingFrame:Hide()end
if not(ResetButton_yes:IsVisible())then
ResetDialog_text:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSDIALOG))ResetFrame:Show()ResetFrame_Animgroup:Play()ResetButton_yesTalents:Hide()ResetButton_yes:Show()else
ResetFrame:Hide()end
end
local function _(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSHINT))GameTooltip:Show()BaseFrameFadeIn(ResetFrame_main_AbilityResetButton_Highlight)end
local function u(e)GameTooltip:Hide()BaseFrameFadeOut(ResetFrame_main_AbilityResetButton_Highlight)end
function ResetButton_t_button_pushed(e)PlaySound("igMainMenuOptionCheckBoxOn")if(e:IsEnabled()==0)then
return false
end
if(TrainingFrame:IsVisible())then
TrainingFrame:Hide()end
if not(ResetButton_yesTalents:IsVisible())then
ResetDialog_text:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTSDIALOG))ResetFrame:Show()ResetFrame_Animgroup:Play()ResetButton_yesTalents:Show()ResetButton_yes:Hide()else
ResetFrame:Hide()end
end
local function E(e,t)GameTooltip:SetOwner(e,"ANCHOR_RIGHT")GameTooltip:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTSHINT))GameTooltip:Show()BaseFrameFadeIn(ResetFrame_main_TalentResetButton_Highlight)end
local function d(e)GameTooltip:Hide()BaseFrameFadeOut(ResetFrame_main_TalentResetButton_Highlight)end
local function R(e)if not(TrainingFrame:IsVisible())then
l.Handle("sideBar","ResetSpells")end
end
local function m(e)if not(TrainingFrame:IsVisible())then
l.Handle("sideBar","ResetTalents")end
end
function ClientResetHandler()local t={}function t.InitResetFrame(n,a,t,e)F=a
S=n
if(t)then
T=true
else
T=false
end
if(e)then
s=true
else
s=false
end
i()ResetFrame_GetPurgeCost("talent")ResetFrame_GetPurgeCost("ability")if not(ResetFrame_AmountOfResets:IsVisible())then
BaseFrameFadeIn(ResetFrame_AmountOfResets)BaseFrameFadeIn(ResetFrame_TalentFrame)BaseFrameFadeIn(ResetFrame_AbilityFrame)end
if(o(1)=="token")or(o(1)<=GetMoney())then
if not(UnitLevel("player")<10)then
ResetFrame_main_TalentResetButton:Enable()else
ResetFrame_main_TalentResetButton:Disable()end
else
ResetFrame_main_TalentResetButton:Disable()end
if((o(2)=="token")or(o(2)<=GetMoney())or(UnitLevel("player")<11))and not(t)and not(e)then
ResetFrame_main_AbilityResetButton:Enable()else
ResetFrame_main_AbilityResetButton:Disable()end
end
return t
end
SubHandlers.ResetFrameAIO=ClientResetHandler()e:SetSize(380,400)e:SetPoint("CENTER")e:SetMovable(true)e:EnableMouse(true)e:RegisterForDrag("LeftButton")e:SetFrameStrata("MEDIUM")e:SetClampedToScreen(true)e:SetScript("OnDragStart",e.StartMoving)e:SetScript("OnHide",e.StopMovingOrSizing)e:SetScript("OnDragStop",e.StopMovingOrSizing)e:SetScript("OnShow",ResetFrame_Init)e:Hide()l.SavePosition(e)e:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_main",insets={left=-40,right=-40,top=-40,bottom=-40}})local t=CreateFrame("Button","ResetFrame_main_CloseButton",e,"UIPanelCloseButton")t:SetPoint("TOPRIGHT",-13.5,11)t:EnableMouse(true)t:SetScript("OnMouseUp",function()PlaySound("TalentScreenOpen")HideUIPanel(e)end)local t=e:CreateFontString("ResetFrame_main_TitleText")t:SetFont("Fonts\\FRIZQT__.TTF",12.2)t:SetFontObject(GameFontNormal)t:SetPoint("TOP",0,2)t:SetShadowOffset(1,-1)t:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTITLE))local n=CreateFrame("Button","ResetFrame_main_TalentResetButton",e,nil)n:SetWidth(120)n:SetHeight(28)n:SetPoint("BOTTOM",-75,18)n:RegisterForClicks("AnyUp")n:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")n:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")n:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button-pressed")n.Text_Talent=n:CreateFontString()n.Text_Talent:SetFontObject(GameFontNormal)n.Text_Talent:SetPoint("CENTER",n,0,0);n.Text_Talent:SetFont("Fonts\\FRIZQT__.TTF",11)n.Text_Talent:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTS))n:SetFontString(n.Text_Talent)n:SetScript("OnDisable",function(e)n.Text_Talent:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTSTITLE))end)n:SetScript("OnEnable",function(e)n.Text_Talent:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTS))end)n:Disable()local t=CreateFrame("Button","ResetFrame_main_AbilityResetButton",e,nil)t:SetWidth(120)t:SetHeight(28)t:SetPoint("BOTTOM",75,18)t:RegisterForClicks("AnyUp")t:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLS))t:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")t:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")t:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button-pressed")t.Text_Ability=t:CreateFontString()t.Text_Ability:SetFontObject(GameFontNormal)t.Text_Ability:SetPoint("CENTER",t,0,0);t.Text_Ability:SetFont("Fonts\\FRIZQT__.TTF",11)t.Text_Ability:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLS))t:SetFontString(t.Text_Ability)t:SetScript("OnDisable",function(e)t.Text_Ability:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSTITLE))end)t:SetScript("OnEnable",function(e)t.Text_Ability:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLS))end)t:Disable()local a=CreateFrame("Frame","ResetFrame",e,nil)a:SetSize(256,100)a:SetPoint("BOTTOM",0,-100)a:SetClampedToScreen(true)a:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\misc\\dialogframe",})local i=a:CreateFontString("ResetDialog_text")i:SetFont("Fonts\\MORPHEUS.TTF",15,"OUTLINE")i:SetSize(300,500)i:SetPoint("CENTER",0,22)i:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSDIALOG))local i=CreateFrame("Button","ResetButton_yes",a)i:SetSize(64,30)i:SetPoint("CENTER",-30,-15)i:EnableMouse(true)i:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")i:SetFrameLevel(3)i:Hide()local o=i:CreateFontString("ResetButton_yes_text")o:SetFont("Fonts\\MORPHEUS.TTF",19,"OUTLINE")o:SetSize(250,5)o:SetPoint("CENTER",0,0)o:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETYES))i:SetFontString(o)local o=CreateFrame("Button","ResetButton_yesTalents",a)o:SetSize(64,30)o:SetPoint("CENTER",-30,-15)o:EnableMouse(true)o:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")o:SetFrameLevel(3)o:Hide()local r=o:CreateFontString("ResetButton_yesTalents_text")r:SetFont("Fonts\\MORPHEUS.TTF",19,"OUTLINE")r:SetSize(250,5)r:SetPoint("CENTER",0,0)r:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETYES))o:SetFontString(r)i:SetScript("OnMouseUp",function()PlaySound("igMainMenuOptionCheckBoxOn")if(TrainingFrame:IsVisible())then
TrainingFrame:Hide()end
R()a:Hide()end)o:SetScript("OnMouseUp",function()PlaySound("igMainMenuOptionCheckBoxOn")if(TrainingFrame:IsVisible())then
TrainingFrame:Hide()end
m()a:Hide()end)local i=CreateFrame("Button","ResetButton_No",a)i:SetSize(64,30)i:SetPoint("CENTER",30,-15)i:EnableMouse(true)i:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")i:SetFrameLevel(3)i:SetScript("OnMouseUp",function()PlaySound("igMainMenuOptionCheckBoxOn")a:Hide()end)local o=i:CreateFontString("ResetButton_No_text")o:SetFont("Fonts\\MORPHEUS.TTF",19,"OUTLINE")o:SetSize(250,5)o:SetPoint("CENTER",0,0)o:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETNO))i:SetFontString(o)a:Hide()ResetFrame_Animgroup2=a:CreateAnimationGroup()local i=ResetFrame_Animgroup2:CreateAnimation("Scale")i:SetDuration(.5)i:SetOrder(1)i:SetEndDelay(0)i:SetScale(10,1)ResetFrame_Animgroup=a:CreateAnimationGroup()local a=ResetFrame_Animgroup:CreateAnimation("Scale")a:SetDuration(0)a:SetOrder(1)a:SetEndDelay(.5)a:SetScale(.1,1)ResetFrame_Animgroup:SetScript("OnPlay",function()ResetFrame_Animgroup2:Play()end)ResetFrame_main_AbilityResetButton_Highlight=e:CreateTexture(nil,"ARTWORK")ResetFrame_main_AbilityResetButton_Highlight:SetHeight(64)ResetFrame_main_AbilityResetButton_Highlight:SetWidth(250)ResetFrame_main_AbilityResetButton_Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_buttonhighlight")ResetFrame_main_AbilityResetButton_Highlight:SetPoint("BOTTOM",75,0)ResetFrame_main_AbilityResetButton_Highlight:SetBlendMode("ADD")ResetFrame_main_AbilityResetButton_Highlight:Hide()ResetFrame_main_TalentResetButton_Highlight=e:CreateTexture(nil,"ARTWORK")ResetFrame_main_TalentResetButton_Highlight:SetHeight(64)ResetFrame_main_TalentResetButton_Highlight:SetWidth(250)ResetFrame_main_TalentResetButton_Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_buttonhighlight")ResetFrame_main_TalentResetButton_Highlight:SetPoint("BOTTOM",-75,0)ResetFrame_main_TalentResetButton_Highlight:SetBlendMode("ADD")ResetFrame_main_TalentResetButton_Highlight:Hide()t:SetScript("OnMouseUp",ResetButton_button_pushed)t:SetScript("OnEnter",_)t:SetScript("OnLeave",u)n:SetScript("OnMouseUp",ResetButton_t_button_pushed)n:SetScript("OnEnter",E)n:SetScript("OnLeave",d)ResetFrame_AmountOfResets=CreateFrame("Frame","ResetFrame_main",e,nil)ResetFrame_AmountOfResets:SetSize(450,113)ResetFrame_AmountOfResets:SetPoint("TOP",0,-6)ResetFrame_AmountOfResets:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_resetcountframe",})ResetFrame_AmountOfResets:Hide()local t=ResetFrame_AmountOfResets:CreateFontString("ResetFrame_AmountOfResets_Count")t:SetFont("Fonts\\MORPHEUS.TTF",17,"OUTLINE")t:SetSize(300,500)t:SetPoint("CENTER",2,20)t:SetText("|cffE1AB180|r")local t=ResetFrame_AmountOfResets:CreateFontString("ResetFrame_AmountOfResets_Count_Text")t:SetFont("Fonts\\MORPHEUS.TTF",16,"OUTLINE")t:SetSize(300,500)t:SetPoint("CENTER",2,-17)t:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSLASTTEN))ResetFrame_TalentFrame=CreateFrame("Frame","ResetFrame_main",e,nil)ResetFrame_TalentFrame:SetSize(512,128)ResetFrame_TalentFrame:SetPoint("CENTER",-8,15)ResetFrame_TalentFrame:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_Talentframe",})ResetFrame_TalentFrame:Hide()local t=ResetFrame_TalentFrame:CreateFontString("ResetFrame_TalentFrame_Cost")t:SetFont("Fonts\\MORPHEUS.TTF",12,"OUTLINE")t:SetSize(300,500)t:SetPoint("CENTER",8,13)t:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTSDIALOG))local t=ResetFrame_TalentFrame:CreateFontString("ResetFrame_TalentFrame_NextCost")t:SetFont("Fonts\\MORPHEUS.TTF",12,"OUTLINE")t:SetSize(300,500)t:SetPoint("CENTER",8,-19)t:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETTALENTSDIALOG))ResetFrame_AbilityFrame=CreateFrame("Frame","ResetFrame_main",e,nil)ResetFrame_AbilityFrame:SetSize(512,128)ResetFrame_AbilityFrame:SetPoint("BOTTOM",-8,45)ResetFrame_AbilityFrame:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_abilityframe",})ResetFrame_AbilityFrame:Hide()local e=ResetFrame_AbilityFrame:CreateFontString("ResetFrame_AbilityFrame_Cost")e:SetFont("Fonts\\MORPHEUS.TTF",12,"OUTLINE")e:SetSize(300,500)e:SetPoint("CENTER",8,13)e:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSDIALOG))local e=ResetFrame_AbilityFrame:CreateFontString("ResetFrame_AbilityFrame_NextCost")e:SetFont("Fonts\\MORPHEUS.TTF",12,"OUTLINE")e:SetSize(300,500)e:SetPoint("CENTER",8,-19)e:SetText(GetLocalization(CLIENTEXTRABUTTONS_RESETSPELLSDIALOG))