Ulocal l=AIO or require("AIO")local o=1
if l.AddAddon()then
return
end
function HybridScroll()local l={Parent=UIParent,ParentName="",Name="HybridScroll",Width=256,Height=256,items={},doNotHide=true,point={"CENTER",0,0},scrollup_point={0,0},scrolldown_point={0,0},}local function n()l.Content=CreateFrame("FRAME",l.ParentName.."."..l.Name..".Content",l.Parent)l.Content:SetSize(l.Width,l.Height)l.Content:SetPoint(unpack(l.point))l.Scroll=CreateFrame("ScrollFrame",l.ParentName.."."..l.Name..".Scroll",l.Parent)l.Scroll:SetSize(l.Width,l.Height)l.Scroll:SetPoint(unpack(l.point))l.Scroll:EnableMouseWheel(true)l.Scroll.update=function()l.RefreshLayout();end
l.Scroll.scrollChild=l.Content
l.Scroll:SetScript("OnMouseWheel",HybridScrollFrame_OnMouseWheel)l.Scroll.scrollBar=CreateFrame("Slider",l.ParentName.."."..l.Name..".Scroll.scrollBar",l.Scroll,"UIPanelScrollBarTemplate")l.Scroll.scrollBar:SetPoint("TOPLEFT",l.Scroll,"TOPRIGHT",unpack(l.scrollup_point))l.Scroll.scrollBar:SetPoint("BOTTOMLEFT",l.Scroll,"BOTTOMRIGHT",unpack(l.scrolldown_point))l.Scroll.scrollBar.doNotHide=l.doNotHide
l.Scroll.scrollBar:SetWidth(16)l.Scroll.scrollBar:SetScript("OnValueChanged",function(o,l)HybridScrollFrame_OnValueChanged(o:GetParent(),l)end)l.Scroll:SetScrollChild(l.Content)l.Scroll.scrollBar.thumbTexture=_G[l.ParentName.."."..l.Name..".Scroll.scrollBarThumbTexture"]l.Scroll.scrollDown=_G[l.ParentName.."."..l.Name..".Scroll.scrollBarScrollDownButton"]l.Scroll.scrollDown:Disable();l.Scroll.scrollDown:RegisterForClicks("LeftButtonUp","LeftButtonDown");l.Scroll.scrollDown.direction=-1;l.Scroll.scrollDown:SetScript("OnClick",HybridScrollFrameScrollButton_OnClick)l.Scroll.scrollDown.parent=l.Scroll
l.Scroll.scrollUp=_G[l.ParentName.."."..l.Name..".Scroll.scrollBarScrollUpButton"]l.Scroll.scrollUp:Disable();l.Scroll.scrollUp:RegisterForClicks("LeftButtonUp","LeftButtonDown");l.Scroll.scrollUp.direction=1;l.Scroll.scrollUp:SetScript("OnClick",HybridScrollFrameScrollButton_OnClick)l.Scroll.scrollUp.parent=l.Scroll
end
function l.CreateButton(l,l)end
function l.LoadData()local o={};l.items=o
end
function l.SetUpButton(l,l)end
function l:Show()if(self.Content)then
self.Content:Show()self.Scroll:Show()end
end
function l:Hide()if(self.Content)then
self.Content:Hide()self.Scroll:Hide()end
end
function l.RefreshLayout()local r=HybridScrollFrame_GetOffset(l.Scroll);local o=l.Scroll.buttons
local e=l.Scroll.buttonHeight
for t=1,#o do
local o=o[t];local t=t+r;if t<=#l.items then
local t=l.items[t];l.SetUpButton(o,t)o:Show();else
o:Hide();end
end
local t=#l.items*e
local o=#o*e
HybridScrollFrame_Update(l.Scroll,t,o);end
function l.DisplaySearchResults(o)l.items=o
l.RefreshLayout()end
function l.CreateButtons(t)local r=l.CreateButton(t,1)l.Scroll.buttons={}l.Scroll.buttonHeight=r:GetHeight()local e=l.Scroll.buttons
local o=l.Scroll.buttonHeight
l.numButtons=math.ceil(t:GetHeight()/o)+1
table.insert(e,r)for o=(#e+1),l.numButtons do
local l=l.CreateButton(t,o)table.insert(e,l)end
l.Scroll.stepSize=o
l.Scroll.scrollBar:SetValueStep(.005)l.Content:SetSize(l.Width,o*l.numButtons)l.Scroll.scrollBar:SetMinMaxValues(0,o*l.numButtons)l.Scroll.scrollBar:SetValue(0)l.RefreshLayout()end
function l.Init()l.LoadData()n()l.CreateButtons(l.Content)l.initialized=true
end
return l
end
