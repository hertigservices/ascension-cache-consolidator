Ulocal n=AIO or require("AIO")if n.AddAddon()then
return
end
local n=n.AddHandlers("ChatChannels",{})function n.JoinChannels(n)local n=GetLocale()local e=ChatFrame1:GetID()if(n~="enUS")and(n~="enGB")then
JoinPermanentChannel(n,nil,e,0)end
JoinPermanentChannel("World",nil,e,nil)end
