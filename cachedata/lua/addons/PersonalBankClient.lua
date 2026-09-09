Ulocal e=AIO or require("AIO")local d=1.2
if e.AddAddon()then
return
end
local n=e.AddHandlers("PersonalBank",{})pBank_BankType=0
local a=CreateFrame("FRAME")a:RegisterEvent("GUILDBANKFRAME_OPENED")a:RegisterEvent("ADDON_LOADED")a:RegisterEvent("GUILDBANKFRAME_CLOSED")a:SetScript("OnEvent",function(t,a,d)if(a=="GUILDBANKFRAME_OPENED")then
e.Handle("PersonalBank","RequestBankTypeUpdate")elseif(a=="GUILDBANKFRAME_CLOSED")then
e.Handle("PersonalBank","UpdateBankPermissions")pBank_BankType=0
GuildBankFrame_UpdateTabs()else
if(d=="Blizzard_GuildBankUI")then
hooksecurefunc("GuildBankFrame_UpdateTabs",function()n.UpdateBankStatus(player,pBank_BankType)end)end
end
end)local function a()for e=1,MAX_GUILDBANK_TABS do
if(e>1)and(pBank_BankType==1)then
_G["GuildBankTab"..e]:Hide()end
end
end
function n.UpdateBankStatus(n,e)if not(GuildBankFrame)then
return false
end
pBank_BankType=e
if(e==0)then
GuildBankFrameTab2:Show()GuildBankFrameTab3:Show()GuildBankFrameTab4:Show()GuildBankMoneyFrame:Show()GuildBankFrameWithdrawButton:Show()GuildBankFrameDepositButton:Show()else
GuildBankFrameTab2:Hide()GuildBankFrameTab3:Hide()GuildBankFrameTab4:Hide()GuildBankMoneyFrame:Hide()GuildBankFrameWithdrawButton:Hide()GuildBankFrameDepositButton:Hide()end
a()end
print(string.format("|cFF00FF00Loaded Personal Bank v%.2f |r",d))