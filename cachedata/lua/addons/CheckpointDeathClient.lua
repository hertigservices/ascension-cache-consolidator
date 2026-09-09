Ulocal t=AIO or require("AIO")local a=1.16
if t.AddAddon()then
return
end
local d=t.AddHandlers("CheckPointDeath",{})local i=false
local n=false
local function o()local e=UnitInRaid("player")local t=UnitName("party1")if(e)then
for e=1,40 do
if not(UnitIsDeadOrGhost("raid"..e))and UnitName("raid"..e)and UnitIsConnected("raid"..e)then
return false
end
end
elseif t then
for e=1,5 do
if not(UnitIsDeadOrGhost("party"..e))and UnitName("party"..e)and UnitIsConnected("party"..e)then
return false
end
end
end
if(UnitIsDeadOrGhost("player"))then
return true
else
return false
end
end
function d.UpdateRaidStatus(t,e)i=e
if(StaticPopup_Visible("DEATH"))then
StaticPopup_Hide("DEATH")StaticPopup_Show("DEATH")end
end
local e=CreateFrame("FRAME")e:RegisterEvent("PLAYER_DEAD")e:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")e:SetScript("OnEvent",function(i,e,...)if(e=="PLAYER_DEAD")then
t.Handle("CheckPointDeath","RequestRaidInfo")else
local t,e=...if(e=="UNIT_DIED")then
n=o()end
end
end)StaticPopupDialogs["DEATH"]={text=DEATH_RELEASE_TIMER,button1=DEATH_RELEASE,button2=USE_SOULSTONE,button3="Last Checkpoint",OnShow=function(e)e.timeleft=GetReleaseTimeRemaining();local t=HasSoulstone();if(t)then
e.button2:SetText(t);end
if(IsActiveBattlefieldArena())then
e.text:SetText(DEATH_RELEASE_SPECTATOR);elseif(e.timeleft==-1)then
e.text:SetText(DEATH_RELEASE_NOTIMER);end
end,OnAccept=function(e)if(IsActiveBattlefieldArena())then
local e=ChatTypeInfo["SYSTEM"];DEFAULT_CHAT_FRAME:AddMessage(ARENA_SPECTATOR,e.r,e.g,e.b,e.id);end
RepopMe();if(CannotBeResurrected())then
return 1
end
end,OnCancel=function(t,t,e)if(e=="override")then
return;end
if(e=="timeout")then
return;end
if(e=="clicked")then
if(HasSoulstone())then
UseSoulstone();else
RepopMe();end
if(CannotBeResurrected())then
return 1
end
end
end,OnAlt=function(e)n=o()if(i and n)then
t.Handle("CheckPointDeath","RessurectAtCheckpoint")else
SendSystemMessage("You can't use that option now")RepopMe();return;end
end,OnUpdate=function(e,t)if(IsFalling()and(not IsOutOfBounds()))then
e.button1:Disable();e.button2:Disable();elseif(HasSoulstone())then
e.button1:Enable();e.button2:Enable();else
e.button1:Enable();e.button2:Disable();end
if(i and n)then
e.button3:Enable();else
e.button3:Disable();end
end,DisplayButton2=function(e)return HasSoulstone();end,DisplayButton3=function(e)return i;end,timeout=0,whileDead=1,interruptCinematic=1,notClosableByLogout=1,cancels="RECOVER_CORPSE"};print(string.format("|cFF00FF00Loaded Checkpoint System v%.2f |r",a))