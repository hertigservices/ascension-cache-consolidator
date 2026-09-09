Ulocal e=AIO or require("AIO")local t=1
if e.AddAddon()then
return
end
function ItemButtonOnEnter(e)if(e.Item)then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT",0,0)GameTooltip:SetHyperlink("|Hitem:"..e.Item.."|h[test]|h")GameTooltip:Show()end
end
function ItemButtonOnClick(e)if(IsModifiedClick("CHATLINK"))then
if(e.Item)then
local t,e=GetItemInfo("|Hitem:"..e.Item.."|h[test]|h")if(e)then
ChatEdit_InsertLink(e);end
end
return
end
end
function MagicButton_OnLoad(e)local S=false;local i=false;for t=1,e:GetNumPoints()do
local r,t,n,o,a=e:GetPoint(t);if(t:GetObjectType()=="Button"and(r=="TOPLEFT"or r=="LEFT"))then
if(o==0 and a==0)then
e:SetPoint(r,t,n,1,0);end
if(t.RightSeparator)then
e.LeftSeparator=t.RightSeparator;else
e.LeftSeparator=e:CreateTexture(e:GetName()and e:GetName().."_LeftSeparator"or nil,"BORDER");t.RightSeparator=e.LeftSeparator;end
e.LeftSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");e.LeftSeparator:SetTexCoord(.0078125,.109375,.7578125,.953125);e.LeftSeparator:SetWidth(13);e.LeftSeparator:SetHeight(25);e.LeftSeparator:SetPoint("TOPRIGHT",e,"TOPLEFT",5,1);S=true;elseif(t:GetObjectType()=="Button"and(r=="TOPRIGHT"or r=="RIGHT"))then
if(o==0 and a==0)then
e:SetPoint(r,t,n,-1,0);end
if(t.LeftSeparator)then
e.RightSeparator=t.LeftSeparator;else
e.RightSeparator=e:CreateTexture(e:GetName()and e:GetName().."_RightSeparator"or nil,"BORDER");t.LeftSeparator=e.RightSeparator;end
e.RightSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");e.RightSeparator:SetTexCoord(.0078125,.109375,.7578125,.953125);e.RightSeparator:SetWidth(13);e.RightSeparator:SetHeight(25);e.RightSeparator:SetPoint("TOPLEFT",e,"TOPRIGHT",-5,1);i=true;elseif(r=="BOTTOMLEFT")then
if(o==0 and a==0)then
e:SetPoint(r,t,n,4,4);end
S=true;elseif(r=="BOTTOMRIGHT")then
if(o==0 and a==0)then
e:SetPoint(r,t,n,-6,4);end
i=true;elseif(r=="BOTTOM")then
if(a==0)then
e:SetPoint(r,t,n,0,4);end
end
end
if(not S)then
if(not e.LeftSeparator)then
e.LeftSeparator=e:CreateTexture(e:GetName()and e:GetName().."_LeftSeparator"or nil,"BORDER");e.LeftSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");e.LeftSeparator:SetTexCoord(.2421875,.328125,.6328125,.828125);e.LeftSeparator:SetWidth(11);e.LeftSeparator:SetHeight(25);e.LeftSeparator:SetPoint("TOPRIGHT",e,"TOPLEFT",6,2);end
end
if(not i)then
if(not e.RightSeparator)then
e.RightSeparator=e:CreateTexture(e:GetName()and e:GetName().."_RightSeparator"or nil,"BORDER");e.RightSeparator:SetTexture("Interface\\FrameGeneral\\UI-Frame");e.RightSeparator:SetTexCoord(.90625,.9921875,.0078125,.203125);e.RightSeparator:SetWidth(11);e.RightSeparator:SetHeight(25);e.RightSeparator:SetPoint("TOPLEFT",e,"TOPRIGHT",-6,2);end
end
end
