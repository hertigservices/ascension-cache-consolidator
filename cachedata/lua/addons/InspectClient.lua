Ulocal e=AIO or require("AIO")local o=1.02
if e.AddAddon()then
return
end
local t=e.AddHandlers("Inspect",{})local n=false
InspectFrameUpdate=CreateFrame("FRAME")InspectFrameUpdate:RegisterEvent("ADDON_LOADED")InspectFrameUpdate:SetScript("OnEvent",function(a,o,t)if not(t=="Blizzard_InspectUI")then
return false
end
InspectFrameTab3:SetText("Specialization")InspectFrameTab3:SetScript("OnClick",function()if not(UnitName("target"))then
return false
end
e.Handle("Inspect","AskForInspectData")end)if not(n)then
hooksecurefunc("InspectFrame_OnLoad",function()InspectFrameTab3:Hide()PanelTemplates_SetNumTabs(a,2);end)hooksecurefunc("InspectFrame_Show",function()InspectFrameTab3:Hide()end)end
end)function t.GenerateBuild(a,t,e)if not(n)then
return false
end
if((inspect_allow)or(e))then
CharacterAdvancementSendBuild(t)end
end
function t.LoadInspectBuild(t,e)if not(n)then
return false
end
if not(TrainingFrame:IsVisible())then
PlaySound("Glyph_MinorCreate")TrainingFrame:Show()StatFrame:Hide()ResetFrame_main:Hide()CollectionController:Hide()end
CountBuildByLink(e,true)end
function t.LoadSystem(t)Inspect_CheckBox=CreateFrame("CheckButton","Inspect_CheckBox",TrainingFrameDisplayControlFrameMainButton,"ChatConfigSmallCheckButtonTemplate")Inspect_CheckBox:ClearAllPoints()Inspect_CheckBox:SetPoint("CENTER",TrainingFrameDisplayControlFrameMainButton,-70,-150)Inspect_CheckBox:RegisterForClicks("AnyUp")Inspect_CheckBox:SetScript("OnClick",function(e)PlaySound("igMainMenuOptionCheckBoxOn")if not(e:GetChecked())then
inspect_allow=false
else
inspect_allow=true
end
end)Inspect_CheckBox.Text=Inspect_CheckBox:CreateFontString()Inspect_CheckBox.Text:SetFontObject(GameFontNormal)Inspect_CheckBox.Text:SetPoint("LEFT",Inspect_CheckBox,20,0);Inspect_CheckBox.Text:SetShadowOffset(0,-1)Inspect_CheckBox.Text:SetText("Allow inspect my build")if(inspect_allow)then
Inspect_CheckBox:SetChecked(1)end
n=true
print(string.format("|cFF00FF00Loaded Inspect v%.2f |r",o))end
e.Handle("Inspect","RequestStatus")e.AddSavedVar("inspect_allow")