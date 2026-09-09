Ulocal e=AIO or require("AIO")local t=1
if e.AddAddon()then
return
end
function IconSelectCreateFrame(e,t,a)local e={name=e,parent=t,point=a,}local m=20
local o=5
local f=4
local l=36
local function a()local i=GetNumMacroIcons()local r,t
local c=FauxScrollFrame_GetOffset(_G[e.name..".ScrollFrame"])local a
if(e.mode=="new")then
_G[e.name..".EditBox"]:SetText("")end
local n
for m=1,m do
r=_G[e.name..".CheckButton"..m.."Icon"]t=_G[e.name..".CheckButton"..m]a=(c*o)+m
n=GetMacroIconInfo(a)if(a<=i)then
r:SetTexture(n)t:Show()else
r:SetTexture("")t:Hide()end
if(_G[e.name].selectedIcon and(a==_G[e.name].selectedIcon))then
t:SetChecked(1)elseif(_G[e.name].selectedIconTexture==n)then
t:SetChecked(1)_G[e.name].selectedIcon=a
else
t:SetChecked(nil)end
end
FauxScrollFrame_Update(_G[e.name..".ScrollFrame"],ceil(i/o),f,l)end
local function t()if((strlen(_G[e.name..".EditBox"]:GetText())>0)and _G[e.name].selectedIcon)then
_G[e.name..".OkayButton"]:Enable();else
_G[e.name..".OkayButton"]:Disable();end
if(_G[e.name].mode=="edit"and(strlen(_G[e.name..".EditBox"]:GetText())>0))then
_G[e.name..".OkayButton"]:Enable();end
end
local function m(n)_G[e.name].selectedIcon=n
_G[e.name].selectedIconTexture=nil
t()local t=_G[e.name].mode
_G[e.name].mode=nil
a(_G[e.name])_G[e.name].mode=t
end
local function i(t)m(t.id+(FauxScrollFrame_GetOffset(_G[e.name..".ScrollFrame"])*o));end
local function n()_G[e.name]:Hide()a()_G[e.name].selectedIcon=nil;end
local function r()local t=1
if not(_G[e.name].selectedIcon)then
e:UpdateValues(_G[e.name..".EditBox"]:GetText(),_G[e.name].selectedIconTexture)else
e:UpdateValues(_G[e.name..".EditBox"]:GetText(),GetMacroIconInfo(_G[e.name].selectedIcon))end
_G[e.name]:Hide();end
local function o()PlaySound("igCharacterInfoOpen")t()if(_G[e.name].mode=="new")then
m(1);end
a()end
function e:CreateNew()n()_G[self.name..".EditBox"]:SetText("")_G[self.name].mode="new"_G[self.name]:Show()end
function e:EditExisting(e,t)n()_G[self.name].mode="edit"_G[self.name].selectedIconTexture=t
_G[self.name..".EditBox"]:SetText(e)_G[self.name]:Show()end
function e:UpdateValues(t,t)end
e.frame=CreateFrame("FRAME",e.name,e.parent)e.frame:EnableMouse()e.frame:SetSize(297,298)e.frame:SetPoint(unpack(e.point))e.frame:SetScript("OnShow",o)e.frame:Hide()e.frame.BG=e.frame:CreateTexture(nil,"BACKGROUND")e.frame.BG:SetTexture("Interface\\MacroFrame\\MacroPopup-TopLeft")e.frame.BG:SetSize(256,256)e.frame.BG:SetPoint("TOPLEFT")e.frame.BG=e.frame:CreateTexture(nil,"BACKGROUND")e.frame.BG:SetTexture("Interface\\MacroFrame\\MacroPopup-TopRight")e.frame.BG:SetSize(64,256)e.frame.BG:SetPoint("TOPLEFT",256,0)e.frame.BG=e.frame:CreateTexture(nil,"BACKGROUND")e.frame.BG:SetTexture("Interface\\MacroFrame\\MacroPopup-BotLeft")e.frame.BG:SetSize(256,64)e.frame.BG:SetPoint("TOPLEFT",0,-256)e.frame.BG=e.frame:CreateTexture(nil,"BACKGROUND")e.frame.BG:SetTexture("Interface\\MacroFrame\\MacroPopup-BotRight")e.frame.BG:SetSize(64,64)e.frame.BG:SetPoint("TOPLEFT",256,-256)e.frame.Text=e.frame:CreateFontString(nil,"ARTWORK")e.frame.Text:SetFontObject(GameFontHighlightSmall)e.frame.Text:SetPoint("TOPLEFT",24,-21)e.frame.Text:SetText("Enter Name (Max 32 Characters)")e.frame.Text=e.frame:CreateFontString(nil,"ARTWORK")e.frame.Text:SetFontObject(GameFontHighlightSmall)e.frame.Text:SetPoint("TOPLEFT",24,-69)e.frame.Text:SetText(MACRO_POPUP_CHOOSE_ICON)e.frame.EditBox=CreateFrame("EditBox",e.name..".EditBox",e.frame)e.frame.EditBox:SetMaxLetters(32)e.frame.EditBox:SetSize(182,20)e.frame.EditBox:SetPoint("TOPLEFT",29,-35)e.frame.EditBox:SetFontObject(ChatFontNormal)e.frame.EditBox:ClearFocus(e)e.frame.EditBox:SetAutoFocus(false)e.frame.EditBox:SetScript("OnTextChanged",function(e)t()end)e.frame.EditBox:SetScript("OnEscapePressed",n)e.frame.EditBox:SetScript("OnEnterPressed",function()if(_G[e.name..".OkayButton"]:IsEnabled()~=0)then
r(_G[e.name..".OkayButton"])end
end)e.frame.EditBox.BG_Left=e.frame.EditBox:CreateTexture(e.name..".EditBox.BG_Left","BACKGROUND")e.frame.EditBox.BG_Left:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")e.frame.EditBox.BG_Left:SetSize(12,29)e.frame.EditBox.BG_Left:SetPoint("TOPLEFT",-11,0)e.frame.EditBox.BG_Left:SetTexCoord(0,.09375,0,1)e.frame.EditBox.BG_Middle=e.frame.EditBox:CreateTexture(e.name..".EditBox.BG_Middle","BACKGROUND")e.frame.EditBox.BG_Middle:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")e.frame.EditBox.BG_Middle:SetSize(175,29)e.frame.EditBox.BG_Middle:SetPoint("LEFT",e.name..".EditBox.BG_Left","RIGHT")e.frame.EditBox.BG_Middle:SetTexCoord(.09375,.90625,0,1)e.frame.EditBox.BG_Right=e.frame.EditBox:CreateTexture(e.name..".EditBox.BG_Right","BACKGROUND")e.frame.EditBox.BG_Right:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-FilterBorder")e.frame.EditBox.BG_Right:SetSize(12,29)e.frame.EditBox.BG_Right:SetPoint("LEFT",e.name..".EditBox.BG_Middle","RIGHT")e.frame.EditBox.BG_Right:SetTexCoord(.90625,1,0,1)e.frame.ScrollFrame=CreateFrame("ScrollFrame",e.name..".ScrollFrame",e.frame,"ClassTrainerListScrollFrameTemplate")e.frame.ScrollFrame:SetSize(296,195)e.frame.ScrollFrame:SetPoint("TOPRIGHT",e.frame,"TOPRIGHT",-39,-67)e.frame.ScrollFrame:SetScript("OnVerticalScroll",function(t,e)FauxScrollFrame_OnVerticalScroll(t,e,l,a())a()end)for t=1,20 do
local a=nil
if(t==1)then
a={"TOPLEFT",24,-85}elseif(t==6)then
a={"TOPLEFT",e.name..".CheckButton1","BOTTOMLEFT",0,-8}elseif(t==11)then
a={"TOPLEFT",e.name..".CheckButton6","BOTTOMLEFT",0,-8}elseif(t==16)then
a={"TOPLEFT",e.name..".CheckButton11","BOTTOMLEFT",0,-8}end
e.frame.CheckButton=CreateFrame("CheckButton",e.name..".CheckButton"..t,e.frame,"SimplePopupButtonTemplate")if not(a)then
e.frame.CheckButton:SetPoint("LEFT",e.name..".CheckButton"..(t-1),"RIGHT",10,0)else
e.frame.CheckButton:SetPoint(unpack(a))end
e.frame.CheckButton.NormalTexture=e.frame.CheckButton:CreateTexture(e.frame.CheckButton:GetName().."Icon","ARTWORK")e.frame.CheckButton.NormalTexture:SetSize(36,36)e.frame.CheckButton.NormalTexture:SetPoint("CENTER",0,-1)e.frame.CheckButton:SetNormalTexture(e.frame.CheckButton.NormalTexture)e.frame.CheckButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")e.frame.CheckButton:SetCheckedTexture("Interface\\Buttons\\CheckButtonHilight")e.frame.CheckButton:SetScript("OnClick",i)_G[e.name..".CheckButton"..t].id=t
end
e.frame.CancelButton=CreateFrame("Button",e.name..".CancelButton",e.frame,"UIPanelButtonTemplate")e.frame.CancelButton:SetText(CANCEL)e.frame.CancelButton:SetSize(78,22)e.frame.CancelButton:SetPoint("BOTTOMRIGHT",-11,13)e.frame.CancelButton:SetScript("OnClick",function()n()PlaySound("gsTitleOptionOK")end)e.frame.OkayButton=CreateFrame("Button",e.name..".OkayButton",e.frame,"UIPanelButtonTemplate")e.frame.OkayButton:SetText(OKAY)e.frame.OkayButton:SetSize(78,22)e.frame.OkayButton:SetPoint("RIGHT",e.name..".CancelButton","LEFT",-2,0)e.frame.OkayButton:SetScript("OnClick",function()r()PlaySound("gsTitleOptionOK")end)return e
end
