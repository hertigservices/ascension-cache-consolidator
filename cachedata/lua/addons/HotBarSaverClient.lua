Ulocal f=AIO or require("AIO")local t=1.01
if f.AddAddon()then
return
end
local b=f.AddHandlers("ActionBarSave",{})local e=GetCVar("realmname")local n=UnitName("player")local l,i,d,s,o={},{},{},{},{}local h=54
local o=18
local o=36
local u=144
local F=121
local p=132
local o=true
function HotBarSaverInit()if not(HotbarBD)or not(next(HotbarBD))then
HotbarBD={}HotbarBD[e]={}HotbarBD[e][n]={}end
print(string.format("|cFF00FF00Loaded Hotbar Saver v%.2f |r",t))end
local function c(e)e=string.gsub(e,"\n","/n")e=string.gsub(e,"/n$","")e=string.gsub(e,"||","/124")return string.trim(e)end
local function t(e)e=string.gsub(e,"/n","\n")e=string.gsub(e,"/124","|")return string.trim(e)end
local function S(a)if not(HotbarBD[e])then
HotbarBD[e]={}end
if not(HotbarBD[e][n])then
HotbarBD[e][n]={}end
HotbarBD[e][n][a]={}for o=1,u do
HotbarBD[e][n][a][o]=nil
local t,r,l,i=GetActionInfo(o)if(t and r and(o<F or o>p))then
if(t=="companion")then
HotbarBD[e][n][a][o]=string.format("%s|%s|%s|%s|%s|%s",t,r,"",a,l,i)elseif(t=="equipmentset")then
HotbarBD[e][n][a][o]=string.format("%s|%s|%s",t,r,"")elseif(t=="item")then
HotbarBD[e][n][a][o]=string.format("%s|%d|%s|%s",t,r,"",(GetItemInfo(r))or"")elseif(t=="spell"and r>0)then
local l,s=GetSpellName(r,BOOKTYPE_SPELL)if(l)then
HotbarBD[e][n][a][o]=string.format("%s|%d|%s|%s|%s|%s",t,r,"",l,s or"",i or"")end
elseif(t=="macro")then
local i,l,r=GetMacroInfo(r)if(i and l and r)then
HotbarBD[e][n][a][o]=string.format("%s|%d|%s|%s|%s|%s",t,o,"",c(i),l,c(r))end
end
end
end
print("|cffFFFF00Succesfully saved build |cffFFFFFF"..a.."|cffFFFF00.|r")end
local function r(t,n,e)if(d[t]==e)then
return t
end
for n,t in pairs(d)do
if(t==e)then
return n
end
end
if(s[n])then
return s[n]end
return nil
end
local function B(e,n,t,o,...)if(n=="spell")then
local t,o=...if(i[t])then
PickupSpell(i[t],BOOKTYPE_SPELL)elseif(o~=""and i[t..o])then
PickupSpell(i[t..o],BOOKTYPE_SPELL)end
if(GetCursorInfo()~=n)then
table.insert(l,'Unable to restore spell "'..t..'" to slot #'..e..", it does not appear to have been learned yet.")ClearCursor()return
end
PlaceAction(e)elseif(n=="equipmentset")then
local n=-1
for e=1,GetNumEquipmentSets()do
if(GetEquipmentSetInfo(e)==t)then
n=e
break
end
end
PickupEquipmentSet(n)if(GetCursorInfo()~="equipmentset")then
table.insert(l,'Unable to restore equipment set "'..t..'" to slot #'..e..", it does not appear to exist anymore.")ClearCursor()return
end
PlaceAction(e)elseif(n=="companion")then
local o,n,r=...PickupCompanion(n,t)if(GetCursorInfo()~="companion")then
table.insert(l,'Unable to restore companion "'..o..'" to slot #'..e..", it does not appear to exist yet.")ClearCursor()return
end
PlaceAction(e)elseif(n=="item")then
PickupItem(t)if(GetCursorInfo()~=n)then
local n=select(e,...)table.insert(l,'Unable to restore item "'..(n and n~=""and n or t)..'" to slot #'..e..", cannot be found in inventory.")ClearCursor()return
end
PlaceAction(e)elseif(n=="macro")then
local a,i,o=...PickupMacro(r(t,a,o or-1))if(GetCursorInfo()~=n)then
table.insert(l,"Unable to restore macro id #"..t.." to slot #"..e..", it appears to have been deleted.")ClearCursor()return
end
PlaceAction(e)end
end
local function m(o)if not(HotbarBD)or not(HotbarBD[e])or not(HotbarBD[e][n])or not(HotbarBD[e][n][o])then
SendSystemMessage('No profile with the name "|cffFFFFFF'..o..'|r" exists.')return
elseif(InCombatLockdown())then
SendSystemMessage('Unable to restore profile "|cffFFFFFF'..o..'|r", you are in combat.')return
end
table.wipe(d)table.wipe(i)table.wipe(s)table.wipe(l)for e=1,MAX_SKILLLINE_TABS do
local t,t,n,e=GetSpellTabInfo(e)for e=1,e do
local e=n+e
local n,t=GetSpellName(e,BOOKTYPE_SPELL)i[n]=e
i[string.lower(n)]=e
if(t and t~="")then
i[n..t]=e
end
end
end
local t={}for n=1,h do
local e,r,o=GetMacroInfo(n)if(e)then
if(s[e])then
t[e]=true
s[e]=n
elseif(not t[e])then
s[e]=n
end
end
d[n]=o and c(o)or nil
end
ClearCursor()local r=GetCVar("Sound_EnableAllSound")SetCVar("Sound_EnableAllSound",0)for t=1,u do
if(t<F or t>p)then
local r,a=GetActionInfo(t)if(a or r)then
PickupAction(t)ClearCursor()end
if(HotbarBD[e][n][o][t])then
B(t,string.split("|",HotbarBD[e][n][o][t]))end
end
end
SetCVar("Sound_EnableAllSound",r)if(#(l)==0)then
print("|cffFFFF00Succesfully loaded build |cffFFFFFF"..o.."|cffFFFF00.|r")else
for n,e in pairs(l)do
print(e)end
end
end
function b.ActionBarSwap(n,e)m(e)end
function b.ActionBarSave(n,e)S(e)end
f.AddSavedVar("HotbarBD")HotBarSaverInit()