Ulocal i=AIO or require("AIO")local o=1.08
if i.AddAddon()then
return
end
lostSpec=false
local S={"I","II","III","IV","V"}i.AddSavedVarChar("SpecNamesCustom")local c=i.AddHandlers("SwitchSpec",{})SwitchSpecButton=CreateFrame("Button","SwitchSpecButton",TrainingFrame)SwitchSpecButton:SetSize(256,256)SwitchSpecButton:SetPoint("CENTER",-115,55)SwitchSpecButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\SwitchSpecDisable")SwitchSpecButton:SetScript("OnEnter",ShowMultiSpecSelectEffect)SwitchSpecButton:Disable()SwitchSpecButton_Highlight=SwitchSpecButton:CreateTexture(nil,"OVERLAY")SwitchSpecButton_Highlight:SetSize(256,256)SwitchSpecButton_Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\SwitchSpecActive")SwitchSpecButton_Highlight:SetPoint("CENTER")SwitchSpecButton_Highlight:Hide()function c.EnableButton(e)SwitchSpecButton:Enable()end
SwitchSpecButton:SetScript("OnShow",function()i.Handle("SwitchSpec","CheckDualSpec")end)SwitchSpecButton:SetScript("OnClick",function(e)if not(e:IsEnabled())then
return false
end
BaseFrameFadeIn(SwitchSpecMainFrame)HideMultiSpecSelectEffect()BaseFrameFadeOut(font_TrainingFrame_SwitchSpec)end)local function n(e,t)if not(_G["SwitchSpecMainFrame_SpecEditBox"..e])then
return false
end
if not(SpecNamesCustom)then
SpecNamesCustom={}end
SpecNamesCustom[e]=t
_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetText(t)end
local function a(e)local t=e:GetText()if not(t)or t==""then
return false
end
e:ClearFocus(self)if not(e.Number)then
return false
end
n(e.Number,t)end
local n={[1]={"I",false,false},[2]={"II",false,false},[3]={"III",false,false},[4]={"IV",false,false},[5]={"V",false,false},}local t=CreateFrame("FRAME","SwitchSpecMainFrame",SwitchSpecButton)t:SetSize(512,256)t:SetPoint("CENTER",TrainingFrame,-114,12)t:EnableMouse(true)t:SetBackdrop({bgFile="Interface\\AddOns\\AwAddons\\Textures\\progress\\SwapMainFrame",})t:Hide()local e=CreateFrame("Button","SwitchSpecMainFrame_CloseButton",t,"UIPanelCloseButton")e:SetPoint("CENTER",130,27)e:EnableMouse(true)e:SetAlpha(.8)e:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\UI-Panel-MinimizeButton-Up")e:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\UI-Panel-MinimizeButton-Highlight")e:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\UI-Panel-MinimizeButton-Down")SwitchSpecMainFrame_Effect=CreateFrame("Model","SwitchSpecMainFrame_Effect",t)SwitchSpecMainFrame_Effect:SetWidth(256);SwitchSpecMainFrame_Effect:SetHeight(256);SwitchSpecMainFrame_Effect:SetPoint("CENTER",t,"CENTER",0,20)SwitchSpecMainFrame_Effect:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")SwitchSpecMainFrame_Effect:SetModelScale(.04)SwitchSpecMainFrame_Effect:SetCamera(0)SwitchSpecMainFrame_Effect:SetPosition(.08,.1,0)SwitchSpecMainFrame_Effect:SetAlpha(.5)SwitchSpecMainFrame_Effect:SetFacing(.1)for e=1,5 do
_G["SwitchSpecMainFrame_SpecButton"..e]=CreateFrame("Button","SwitchSpecMainFrame_SpecButton"..e,t)_G["SwitchSpecMainFrame_SpecButton"..e]:SetSize(64,128)_G["SwitchSpecMainFrame_SpecButton"..e]:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\SwapButtonLocked")_G["SwitchSpecMainFrame_SpecButton"..e]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\SwapButtonUnLocked")_G["SwitchSpecMainFrame_SpecButton"..e]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\SwapButtonUnlockedH")_G["SwitchSpecMainFrame_SpecEditBox"..e]=CreateFrame("EditBox","SwitchSpecMainFrame_SpecEditBox"..e,_G["SwitchSpecMainFrame_SpecButton"..e])_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetWidth(50)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetHeight(30)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetFontObject(GameFontNormal)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetBackdrop(GameTooltip:GetBackdrop())_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetBackdropColor(1,0,0,0)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetBackdropBorderColor(1,0,0,0)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetTextColor(1,1,1,1)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetMaxLetters(10)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetIndentedWordWrap(false)_G["SwitchSpecMainFrame_SpecEditBox"..e]:ClearFocus(self)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetAutoFocus(false)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetFont("Fonts\\FRIZQT__.TTF",11)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetJustifyH("CENTER")_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetPoint("CENTER",_G["SwitchSpecMainFrame_SpecButton"..e],0,-25)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetScript("OnEnterPressed",a)_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetScript("OnEscapePressed",a)_G["SwitchSpecMainFrame_SpecEditBox"..e].Number=e
_G["SwitchSpecMainFrame_SpecButton"..e]:SetScript("OnUpdate",function(t)if(t:IsEnabled()==1)then
_G["SwitchSpecMainFrame_SpecEditBox"..e]:EnableMouse(true)_G["SwitchSpecMainFrame_SpecEditBox"..e]:Show()else
_G["SwitchSpecMainFrame_SpecEditBox"..e]:EnableMouse(false)_G["SwitchSpecMainFrame_SpecEditBox"..e]:Hide()end
end)_G["SwitchSpecMainFrame_SpecButton"..e]:SetScript("OnEnter",function(t)GameTooltip:SetOwner(t,"ANCHOR_RIGHT",0,-70)GameTooltip:AddLine("|cffFFFFFF".._G["SwitchSpecMainFrame_SpecEditBox"..e]:GetText().."|r")GameTooltip:AddLine("Click to change your specialization")GameTooltip:Show()end)_G["SwitchSpecMainFrame_SpecButton"..e]:SetScript("OnLeave",function(e)GameTooltip:Hide()end)_G["SwitchSpecMainFrame_SpecButton"..e]:SetScript("OnClick",function()if(IsSpellLearned(1515)and lostSpec==false)then
TrainingFrameDialog.text:SetText("Please, stable your pet\nbefore specialization change if you have one.\nOtherwise you may lose it without any\nchance to revive or summon it.")TrainingFrameDialog.Alert:SetTexture("Interface\\Icons\\Ability_Hunter_MendPet")TrainingFrameDialog.Yes.Type="SwitchSpec"TrainingFrameDialog.Yes.SpecNum=e
TrainingFrameDialog:Show()else
lostSpec=false
if(SelectSpecTip)then
SelectSpecTip:Hide()end
t:Hide()TrainingFrame:Hide()i.Handle("SwitchSpec","ChangeSpecPrep",e)end
end)end
SwitchSpecMainFrame_SpecButton1:SetPoint("CENTER",-120,-34)SwitchSpecMainFrame_SpecButton2:SetPoint("CENTER",-60,-34)SwitchSpecMainFrame_SpecButton3:SetPoint("CENTER",0,-34)SwitchSpecMainFrame_SpecButton4:SetPoint("CENTER",60,-34)SwitchSpecMainFrame_SpecButton5:SetPoint("CENTER",120,-34)SwitchSpecMainFrame_SpecEditBox1:SetText(S[1])SwitchSpecMainFrame_SpecEditBox2:SetText(S[2])SwitchSpecMainFrame_SpecEditBox3:SetText(S[3])SwitchSpecMainFrame_SpecEditBox4:SetText(S[4])SwitchSpecMainFrame_SpecEditBox5:SetText(S[5])local function a()for e,t in pairs(n)do
if(t[2])then
_G["SwitchSpecMainFrame_SpecButton"..e]:Enable()local i=S[e]if SpecNamesCustom and(SpecNamesCustom[e])then
_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetText(SpecNamesCustom[e])else
_G["SwitchSpecMainFrame_SpecEditBox"..e]:SetText(i)end
if(t[3])then
_G["SwitchSpecMainFrame_SpecButton"..e]:EnableMouse(0)_G["SwitchSpecMainFrame_SpecButton"..e]:GetNormalTexture():SetVertexColor(.5,.5,.5,1)else
_G["SwitchSpecMainFrame_SpecButton"..e]:EnableMouse(1)_G["SwitchSpecMainFrame_SpecButton"..e]:GetNormalTexture():SetVertexColor(1,1,1,1)end
else
_G["SwitchSpecMainFrame_SpecButton"..e]:Disable()end
end
end
t:SetScript("OnShow",function()a()DisplaySpellsButton:Disable()DisplayTalentsButton:Disable()TrainingFrame_SelectedTitle_Stars1_glow:Hide()TrainingFrame_SelectedTitle_Stars2_glow:Hide()if(TrainingFrame_SelectedTitle_Stars1:IsVisible())then
BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars1)BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars2)BaseFrameFadeOut(TrainingFrame_SelectedTitle_Glow)end
i.Handle("SwitchSpec","RequestSpecs")end)function c.GetListItems(t,e)if not(e)then
return false
end
n=e
a()end
local function S(t,e)local e=tonumber(t)if(e and e>0 and e<=5)then
i.Handle("SwitchSpec","ChangeSpecPrep",e)else
print("You can't switch to spec '"..t.."'")end
end
SLASH_CHANGESPEC1,SLASH_CHANGESPEC2='/changespec','/cs'SlashCmdList["CHANGESPEC"]=S
function c.ReChooseActiveSpec(e)lostSpec=true
display_frame_CA()TrainingFrame:Show()end
print(string.format("|cFF00FF00Loaded SwitchSpec v%.2f |r",o))