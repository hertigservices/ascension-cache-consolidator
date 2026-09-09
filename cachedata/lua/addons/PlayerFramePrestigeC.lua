Ulocal e=AIO or require("AIO")local r=1
if e.AddAddon()then
return
end
local i=false
local r={["Alliance"]={50,52,976562e-9,.0498047,.763672,.865234},["Horde"]={50,52,976562e-9,.0498047,.869141,.970703},["Neutral"]={50,52,.0517578,.100586,.763672,.865234},}local l={[1]={128,128,976562e-9,.125977,.00195312,.251953},[2]={128,128,.12793,.25293,.00195312,.251953},[3]={128,128,.12793,.25293,.255859,.505859},[4]={128,128,.12793,.25293,.509766,.759766},[5]={128,128,.254883,.379883,.00195312,.251953},[6]={128,128,.254883,.379883,.255859,.505859},[7]={128,128,.254883,.379883,.509766,.759766},[8]={128,128,.381836,.506836,.00195312,.251953},[9]={128,128,.381836,.506836,.255859,.505859},[10]={128,128,976562e-9,.125977,.255859,.505859},[11]={128,128,976562e-9,.125977,.509766,.759766},}local P={[1]="I",[2]="II",[3]="III",[4]="IV",[5]="V",[6]="VI",[7]="VII",[8]="VII",[9]="IX",[10]="X",[11]="X+"}_G["PlayerFrame"].PlayerPrestigePortrait=CreateFrame("FRAME","PlayerFrame.PlayerPrestigePortrait",_G["PlayerFrame"])_G["PlayerFrame"].PlayerPrestigePortrait:SetFrameLevel(3)_G["PlayerFrame"].PlayerPrestigePortrait:SetSize(50,52)_G["PlayerFrame"].PlayerPrestigePortrait:SetPoint("TOPLEFT",15,-13)_G["PlayerFrame"].PlayerPrestigePortrait.Texture=_G["PlayerFrame"].PlayerPrestigePortrait:CreateTexture("PlayerFrame.PlayerPrestigePortrait.Texture","OVERLAY")_G["PlayerFrame"].PlayerPrestigePortrait.Texture:SetTexture("Interface\\PVPFrame\\PvPPrestigeIcons")_G["PlayerFrame"].PlayerPrestigePortrait.Texture:SetSize(50,52)_G["PlayerFrame"].PlayerPrestigePortrait.Texture:SetPoint("CENTER",0,0)portrait=r[UnitFactionGroup("player")]if portrait==nil then
portrait=r["Neutral"]end
_G["PlayerFrame"].PlayerPrestigePortrait.Texture:SetTexCoord(portrait[3],portrait[4],portrait[5],portrait[6])_G["PlayerFrame"].PlayerPrestigePortrait:Hide()badge=l[1]_G["PlayerFrame"].PlayerPrestigeBadge=CreateFrame("FRAME","PlayerFrame.PlayerPrestigeBadge",_G["PlayerFrame"])_G["PlayerFrame"].PlayerPrestigeBadge:SetFrameLevel(4)_G["PlayerFrame"].PlayerPrestigeBadge:SetSize(30,30)_G["PlayerFrame"].PlayerPrestigeBadge:SetPoint("CENTER",_G["PlayerFrame"].PlayerPrestigePortrait,0,0)_G["PlayerFrame"].PlayerPrestigeBadge.Texture=_G["PlayerFrame"].PlayerPrestigeBadge:CreateTexture("PlayerFrame.PlayerPrestigeBadge.Texture","OVERLAY")_G["PlayerFrame"].PlayerPrestigeBadge.Texture:SetTexture("Interface\\PVPFrame\\PvPPrestigeIcons")_G["PlayerFrame"].PlayerPrestigeBadge.Texture:SetPoint("CENTER",_G["PlayerFrame"].PlayerPrestigePortrait,0,0)_G["PlayerFrame"].PlayerPrestigeBadge.Texture:SetSize(20,20)_G["PlayerFrame"].PlayerPrestigeBadge.Texture:SetTexCoord(badge[3],badge[4],badge[5],badge[6])_G["PlayerFrame"].PlayerPrestigeBadge:Hide()function PlayerPrestige_HookSetUnit(r,r)local r,a=GameTooltip:GetUnit()if not UnitIsPlayer(a)then
return
end
local t=2
local r=GetGuildInfo(a)if r~=nil then
t=3
end
local r=_G["GameTooltipTextLeft"..tostring(t)]:GetText()r=r:gsub("Hero %(Player%)","")_G["GameTooltipTextLeft"..tostring(t)]:SetText(r)local t=tonumber(UnitGUID(a):sub(13,18),16);local a,r=string.find(r,"Level%s*(%d+)")if r~=nil then
e.Handle("PlayerFramePrestigeS","SetPrestigeLevelGameTooltip",t)end
end
if i==true then
GameTooltip:HookScript("OnTooltipSetUnit",PlayerPrestige_HookSetUnit)end
local r=e.AddHandlers("PlayerFramePrestigeC",{})e.Handle("PlayerFramePrestigeS","LoadPrestigeLevel")function r.UpdatePrestigeLevel(r,e)if e==0 then
return
end
if e>11 then
e=11
end
_G["PlayerFrame"].PlayerPrestigePortrait:Show()badge=l[e]_G["PlayerFrame"].PlayerPrestigeBadge.Texture:SetTexCoord(badge[3],badge[4],badge[5],badge[6])_G["PlayerFrame"].PlayerPrestigeBadge:Show()end
function r.SetPrestigeLevelGameTooltip(e,a,r)if r==0 then
return
end
if r>11 then
r=11
end
local t,e=GameTooltip:GetUnit()if e==nil then
return
end
if not UnitIsPlayer(e)then
return
end
local t=tonumber(UnitGUID(e):sub(13,18),16);if t~=a then
return
end
local t=2
local e=GetGuildInfo(e)if e~=nil then
t=3
end
local e=_G["GameTooltipTextLeft"..tostring(t)]:GetText()if string.find(e,"Prestige")==nil then
return
end
local l,a=string.find(e,"Level%s*(%d+)")if a~=nil then
_G["GameTooltipTextLeft"..tostring(t)]:SetText(e:sub(1,a).." |cFFE6CC80(Prestige: "..P[r]..")|r"..e:sub(a+1))_G["GameTooltip"]:Show()end
end
