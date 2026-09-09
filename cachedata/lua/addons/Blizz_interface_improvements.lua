Ulocal l=AIO or require("AIO")local e=1.44
if l.AddAddon()then
return
end
function qsort(e,a,n)if a>n then
return
end
local t=a
for n=a+1,n do
if(e[n]<e[a])then
t=t+1
e[t],e[n]=e[n],e[t]end
end
e[t],e[a]=e[a],e[t]qsort(e,a,t-1)qsort(e,t+1,n)end
ARENA_TEAM_5V5="1v1 Arena Team";StaticPopupDialogs["GOSSIP_ENTER_CODE"]={text=ENTER_CODE,button1=ACCEPT,button2=CANCEL,hasEditBox=1,OnAccept=function(t,e)SelectGossipOption(e,t.editBox:GetText(),true);end,OnShow=function(e)e.editBox:SetFocus();end,OnHide=function(e)ChatEdit_FocusActiveWindow();e.editBox:SetText("");end,EditBoxOnEnterPressed=function(e,t)local e=e:GetParent();SelectGossipOption(t,e.editBox:GetText(),true);end,EditBoxOnEscapePressed=function(e)e:GetParent():Hide();end,timeout=0,exclusive=1,hideOnEscape=1};StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"]={text=CONFIRM_BATTLEFIELD_ENTRY,button1=ENTER_BATTLE,button2=LEAVE_QUEUE,OnShow=function(e,t)local o,l,n,o,o,t,a=GetBattlefieldStatus(t);if(t==0)then
e.button2:Enable();else
e.button2:Disable();end
if(a==nil and n==0)then
e.button1:SetText("Accept");e.button2:SetText("Decline");e.button2:Enable();e.text:SetText(string.format("Your group has been challenged to a War Game in |cffe6cc80%s|h",l))end
end,OnAccept=function(t,e)if(not AcceptBattlefieldPort(e,1))then
return 1;end
if(StaticPopup_Visible("DEATH"))then
StaticPopup_Hide("DEATH");end
end,OnCancel=function(t,e)if(not AcceptBattlefieldPort(e,0))then
return 1;end
end,OnUpdate=function(e,t)if(UnitAffectingCombat("player"))then
e.button1:Disable();else
e.button1:Enable();end
end,timeout=0,whileDead=1,hideOnEscape=1,noCancelOnEscape=1,noCancelOnReuse=1,multiple=1,closeButton=1,closeButtonIsHide=1,};function LFGControl_SetActiveTab(e)local e=e.id
if(e==1)then
HideUIPanel(LFRParentFrame)ShowUIPanel(LFDParentFrame)LFGControlFrame.activeTab=1;elseif(e==2)then
ShowUIPanel(LFRParentFrame)HideUIPanel(LFDParentFrame)LFGControlFrame.activeTab=2;LFRQueueFrame:Show();LFRBrowseFrame:Hide();elseif(e==3)then
ShowUIPanel(LFRParentFrame)HideUIPanel(LFDParentFrame)LFGControlFrame.activeTab=3;LFRBrowseFrame:Show();LFRQueueFrame:Hide();end
PanelTemplates_SetTab(LFGControlFrame,e);end
function ToggleLFGControl()if(LFGControlFrame:IsShown())then
HideUIPanel(LFDParentFrame)HideUIPanel(LFRParentFrame)HideUIPanel(LFGControlFrame);else
ShowUIPanel(LFGControlFrame);end
if not(LFRParentFrame:IsVisible()and LFDParentFrame:IsVisible())then
LFGControl_SetActiveTab(LFGControlFrameTab1)end
end
RaidFrameNotInRaidRaidBrowserButton:SetScript("OnClick",function()ToggleLFGControl()LFGControl_SetActiveTab(LFGControlFrameTab2)end)LFGControlFrame=CreateFrame("FRAME","LFGControlFrame",UIParent)LFGControlFrame:SetSize(LFDParentFrame:GetSize())LFGControlFrame:SetPoint("LEFT",0,0)LFGControlFrame:Hide()LFGControlFrame.activeTab=1
PanelTemplates_SetNumTabs(LFGControlFrame,3)LFGControlFrame:SetScript("OnHide",function()HideUIPanel(LFDParentFrame)HideUIPanel(LFRParentFrame)end)local e=0
LFGControlFrame:SetScript("OnUpdate",function(t)e=e+1
if not(LFDParentFrame:IsVisible()or LFRParentFrame:IsVisible())then
if(e>=4)then
HideUIPanel(t)e=0
end
else
if(e>=4)then
e=0
end
end
end)UIPanelWindows["LFDParentFrame"]=nil
UIPanelWindows["LFRParentFrame"]=nil
UIPanelWindows["LFGControlFrame"]={area="left",pushable=0,whileDead=1};LFDMicroButton:SetScript("OnClick",ToggleLFGControl)LFGControlFrameTab1=CreateFrame("Button","LFGControlFrameTab1",LFGControlFrame,"CharacterFrameTabButtonTemplate")LFGControlFrameTab1:SetPoint("BOTTOMLEFT",20,-25)LFGControlFrameTab1:SetText("Dungeon Finder")LFGControlFrameTab1.id=1
LFGControlFrameTab1:SetScript("OnClick",LFGControl_SetActiveTab)LFGControlFrameTab2=CreateFrame("Button","LFGControlFrameTab2",LFGControlFrame,"CharacterFrameTabButtonTemplate")LFGControlFrameTab2:SetPoint("LEFT",LFGControlFrameTab1,"RIGHT",-15,0)LFGControlFrameTab2:SetText(LFRParentFrameTab1:GetText())LFGControlFrameTab2.id=2
LFGControlFrameTab2:SetScript("OnClick",LFGControl_SetActiveTab)LFGControlFrameTab3=CreateFrame("Button","LFGControlFrameTab3",LFGControlFrame,"CharacterFrameTabButtonTemplate")LFGControlFrameTab3:SetPoint("LEFT",LFGControlFrameTab2,"RIGHT",-15,0)LFGControlFrameTab3:SetText(LFRParentFrameTab2:GetText())LFGControlFrameTab3.id=3
LFGControlFrameTab3:SetScript("OnClick",LFGControl_SetActiveTab)LFRParentFrame:SetPoint("CENTER",LFGControlFrame,0,0)LFRParentFrame:SetParent(LFGControlFrame)LFDParentFrame:SetPoint("CENTER",LFGControlFrame,0,0)LFDParentFrame:SetParent(LFGControlFrame)LFRParentFrameTab1:SetParent(LFGControlFrame)LFRParentFrameTab2:SetParent(LFGControlFrame)LFRParentFrameTab1:Hide()LFRParentFrameTab2:Hide()ChannelRoster_Update=function()end;local e={AchievementMicroButton,QuestLogMicroButton,SocialsMicroButton,PVPMicroButton}local e={LFDMicroButton,MainMenuMicroButton,HelpMicroButton}BI_i=CreateFrame("Frame",nil,UIParent)BI_i:SetScript("OnUpdate",function()if(PlayerTalentFrame)then
if(PlayerTalentFrame:IsVisible())then
PlayerTalentFrameTab2:Hide()PlayerTalentFrameTab3:Hide()PlayerTalentFrameTab4:Hide()end
end
if(FriendsFrameTab2:IsVisible())then
FriendsFrameTab2:Hide()end
if(TalentMicroButton:IsVisible())then
CharUpgrades_MinimapButton:Show()CharUpdatesMicroButton:Show()TalentMicroButton:Hide()LFDMicroButton:Show()CharUpdatesMicroButton:SetSize(TalentMicroButton:GetSize())CharUpdatesMicroButton:SetScale(TalentMicroButton:GetScale())end
end)BI_i:Show()for e=1,GetNumBindings()do
local a,t,e=GetBinding(e)if t=="N"and not(e)and(a=="TOGGLETALENTS")then
SetOverrideBindingClick(BI_i,false,"N","CharUpgrades_MinimapButton")elseif t=="I"and not(e)and(a=="TOGGLELFGPARENT")then
SetOverrideBindingClick(BI_i,false,"I","LFDMicroButton")end
end
function IsSpellLearned(e)if not(tonumber(e))then
return false
end
local e=GetSpellInfo(e)local a=false
local l=false
local t=1
local n=nil
if not(e)then
return false
end
e=string.gsub(e,"%(Rank %d+%)","");while not a do
local n=GetSpellName(t,BOOKTYPE_SPELL);if not n then
a=true;elseif(n==e)then
l=true
end
t=t+1;end
return l
end
function Asc_PetPaperDollFrame_Update()local t,e=HasPetUI();e=PetCanBeAbandoned()if(not t)then
return;end
PetModelFrame:SetUnit("pet");if(UnitCreatureFamily("pet"))then
PetLevelText:SetFormattedText(UNIT_TYPE_LEVEL_TEMPLATE,UnitLevel("pet"),UnitCreatureFamily("pet"));end
if(PetPaperDollFramePetFrame:IsShown())then
PetNameText:SetText(UnitName("pet"));end
PetExpBar_Update();PetPaperDollFrame_SetResistances();PetPaperDollFrame_SetStats();PaperDollFrame_SetDamage(PetDamageFrame,"Pet");PaperDollFrame_SetArmor(PetArmorFrame,"Pet");PaperDollFrame_SetAttackPower(PetAttackPowerFrame,"Pet");PetPaperDollFrame_SetSpellBonusDamage();if(e)then
PetPaperDollPetInfo:Show();else
PetPaperDollPetInfo:Hide();end
end
PetPaperDollFrame_Update=Asc_PetPaperDollFrame_Update
local a={["Basilisk"]={false,false,true,false,false,true},["Bat"]={false,false,false,true,true,true},["Bear"]={true,true,true,true,true,true},["Beetle"]={false,false,false,true,true,false},["Bird of Prey"]={false,false,true,false,false,true},["Boar"]={true,true,true,true,true,true},["Carrion Bird"]={false,false,true,false,false,true},["Cat"]={false,false,true,false,false,true},["Chimaera"]={false,false,false,false,false,true},["Clefthoove"]={true,true,false,true,true,false},["Core Hound"]={false,false,false,false,false,true},["Crab"]={true,false,true,true,true,false},["Crane"]={true,false,true,false,false,false},["Crocolisk"]={false,false,true,false,false,true},["Devilsaur"]={false,false,false,false,false,true},["Direhorn"]={false,false,false,true,true,false},["Dog"]={true,true,true,true,true,true},["Dragonhawk"]={false,false,true,true,false,true},["Featherman"]={true,true,true,true,true,true},["Fox"]={false,false,true,true,false,true},["Goat"]={true,true,true,true,true,true},["Gorilla"]={true,false,false,true,true,false},["Hydra"]={false,false,true,false,false,true},["Hyena"]={false,false,false,false,false,true},["Mechanical"]={false,false,false,false,false,false},["Monkey"]={false,false,false,true,true,false},["Moth"]={true,true,false,true,true,false},["Nether Ray"]={false,false,false,false,true,true},["Oxen"]={true,true,false,true,true,false},["Porcupine"]={false,false,false,false,true,false},["Quilen"]={false,false,true,false,false,true},["Raptor"]={false,false,false,false,false,true},["Ravager"]={false,false,false,false,false,true},["Riverbeast"]={true,false,false,true,true,false},["Rylak"]={false,false,true,false,false,true},["Scorpid"]={false,false,false,false,false,true},["Serpent"]={false,false,false,false,false,true},["Shale Spider"]={false,false,true,false,false,true},["Silithid"]={false,false,false,false,true,true},["Spider"]={false,false,false,false,false,true},["Spirit Beast"]={false,false,true,false,false,true},["Sporebat"]={true,true,false,true,true,false},["Stag"]={true,true,false,true,true,false},["Tallstrider"]={true,true,false,true,true,false},["Turtles"]={true,false,true,true,true,false},["Warp Stalker"]={false,false,true,true,false,false},["Wasp"]={true,true,false,true,true,false},["Wind Serpent"]={true,true,true,false,false,false},["Wolve"]={false,false,false,false,false,true},["Worm"]={true,true,false,false,true,false},}local n={"Bread","Cheese","Fish","Fruit","Fungus","Meat",}function Asc_GetPetFoodTypes()local t=UnitCreatureFamily("pet")local e=""if not(t)or not(a[t])then
return e
end
for a,t in pairs(a[t])do
if(t)then
e=e..n[a].." "end
end
return e
end
GetPetFoodTypes=Asc_GetPetFoodTypes
UnitPopupButtons["ASCENSION_PETTALENTS"]={text="Pet Talents",dist=0}table.insert(UnitPopupMenus["PET"],table.getn(UnitPopupMenus["PET"]),"ASCENSION_PETTALENTS");hooksecurefunc("UnitPopup_OnClick",function(e)local t=UIDROPDOWNMENU_INIT_MENU.name
local e=e.value
if(t==MC_PLAYER)then return end
if(e=="ASCENSION_PETTALENTS")then
ToggleTalentFrame()elseif(strsub(e,1,18)=="DUNGEON_DIFFICULTY"and(strlen(e)>18))and(tonumber(strsub(e,19,19))==3)then
l.Handle("DungeonDifficulty","SetMystic")end
end);DUNGEON_DIFFICULTY3="5 Player (Mythic)"UnitPopupButtons["DUNGEON_DIFFICULTY3"]={text=DUNGEON_DIFFICULTY3,dist=0};UnitPopupMenus["DUNGEON_DIFFICULTY"]={"DUNGEON_DIFFICULTY1","DUNGEON_DIFFICULTY2","DUNGEON_DIFFICULTY3"};RAID_DIFFICULTY1="10-25 Player (Flexible)"UnitPopupButtons["RAID_DIFFICULTY1"]={text=RAID_DIFFICULTY1,dist=0};RAID_DIFFICULTY2="10-25 Player (Flexible Heroic)"UnitPopupButtons["RAID_DIFFICULTY2"]={text=RAID_DIFFICULTY2,dist=0};RAID_DIFFICULTY3="10 Player (Ascended)"UnitPopupButtons["RAID_DIFFICULTY3"]={text=RAID_DIFFICULTY3,dist=0};RAID_DIFFICULTY4="25 Player (Ascended)"UnitPopupButtons["RAID_DIFFICULTY4"]={text=RAID_DIFFICULTY4,dist=0};UnitPopupMenus["RAID_DIFFICULTY"]={"RAID_DIFFICULTY1","RAID_DIFFICULTY2","RAID_DIFFICULTY3","RAID_DIFFICULTY4"};local t=GetSavedInstanceInfo
function GetSavedInstanceInfo_Edited(e)local r,i,s,t,o,u,n,l,a,e=t(e)if(a>5)then
e=UnitPopupButtons["RAID_DIFFICULTY"..t].text
else
e=UnitPopupButtons["DUNGEON_DIFFICULTY"..t].text
end
return r,i,s,t,o,u,n,l,a,e
end
GetSavedInstanceInfo=GetSavedInstanceInfo_Edited
hooksecurefunc("UnitPopup_HideButtons",function(e)local e=UIDROPDOWNMENU_INIT_MENU;for e,t in ipairs(UnitPopupMenus[e.which])do
if(t=="ASCENSION_PETTALENTS")then
if not(PetCanBeAbandoned())then
UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][e]=0;end
elseif(t=="DUNGEON_DIFFICULTY")then
if(UnitLevel("player")<60 and GetRaidDifficulty()==1)then
UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][e]=0;else
UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][e]=1;end
elseif(t=="RAID_DIFFICULTY")then
if(UnitLevel("player")<60 and GetRaidDifficulty()==1)then
UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][e]=0;else
UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][e]=1;end
end
end
end);function Asc_PetStable_Update()SetPortraitTexture(PetStableFramePortrait,"player");local d,e=HasPetUI();if(UnitExists("pet")and d and not PetCanBeAbandoned())then
PetStable_NoPetsAllowed();PetStableCurrentPet:Disable();return;else
PetStableCurrentPet:Enable();end
local r=GetSelectedStablePet();if(r==-1)then
if(GetPetIcon())then
r=0;ClickStablePet(0);else
for e=0,NUM_PET_STABLE_SLOTS do
if(GetStablePetInfo(e))then
r=e;ClickStablePet(e);break;end
end
end
end
MoneyFrame_Update("PetStableCostMoneyFrame",GetNextStableSlotCost());local e=GetNumStableSlots();local e=GetNumStablePets();local e,s;local u;local o,l,a,t,n;for i=1,NUM_PET_STABLE_SLOTS do
s="PetStableStabledPet"..i;e=_G[s];u=_G[s.."Background"];o,l,a,t,n=GetStablePetInfo(i);SetItemButtonTexture(e,o);if(i<=GetNumStableSlots())then
u:SetVertexColor(1,1,1);e:Enable();if(o)then
e.tooltip=l;e.tooltipSubtext=format(STABLE_PET_INFO_TOOLTIP_TEXT,a,t,n);else
e.tooltip=EMPTY_STABLE_SLOT;e.tooltipSubtext="";end
if(i==r)then
if(o)then
e:SetChecked(1);PetStableLevelText:SetFormattedText(STABLE_PET_INFO_TEXT,l,a,t,n);SetPetStablePaperdoll(PetStableModel);PetStablePetInfo.tooltip=format(PET_DIET_TEMPLATE,BuildListString(GetStablePetFoodTypes(i)));if(not PetStableModel:IsShown())then
PetStableModel:Show();end
else
e:SetChecked(nil);PetStableLevelText:SetText("");PetStableModel:Hide();end
else
e:SetChecked(nil);end
if(GameTooltip:IsOwned(e))then
GameTooltip:SetOwner(e,"ANCHOR_RIGHT");GameTooltip:SetText(e.tooltip);GameTooltip:AddLine(e.tooltipSubtext,1,1,1);GameTooltip:Show();end
else
u:SetVertexColor(1,.1,.1);e:Disable();end
end
if(r==0)then
if(UnitExists("pet")and d)then
PetStableCurrentPet:SetChecked(1);l=UnitName("pet")or"";a=UnitLevel("pet");t=UnitCreatureFamily("pet")or"";n=GetPetTalentTree()or"";PetStableLevelText:SetFormattedText(STABLE_PET_INFO_TEXT,l,a,t,n);SetPetStablePaperdoll(PetStableModel);if(not PetStableModel:IsShown())then
PetStableModel:Show();end
if(GetPetFoodTypes())then
PetStablePetInfo.tooltip=format(PET_DIET_TEMPLATE,BuildListString(GetPetFoodTypes()));end
elseif(GetStablePetInfo(0))then
PetStableCurrentPet:SetChecked(1);o,l,a,t,n=GetStablePetInfo(0);PetStableLevelText:SetFormattedText(STABLE_PET_INFO_TEXT,l,a,t,n);SetPetStablePaperdoll(PetStableModel);if(not PetStableModel:IsShown())then
PetStableModel:Show();end
if(GetStablePetFoodTypes(0))then
PetStablePetInfo.tooltip=format(PET_DIET_TEMPLATE,BuildListString(GetStablePetFoodTypes(0)));end
else
PetStableCurrentPet:SetChecked(nil);PetStableLevelText:SetText("");PetStableModel:Hide();end
else
PetStableCurrentPet:SetChecked(nil);end
if(GetPetIcon()and UnitCreatureFamily("pet"))then
SetItemButtonTexture(PetStableCurrentPet,GetPetIcon());l=UnitName("pet")or"";a=UnitLevel("pet");t=UnitCreatureFamily("pet")or"";n=GetPetTalentTree()or"";PetStableCurrentPet.tooltip=l;PetStableCurrentPet.tooltipSubtext=format(STABLE_PET_INFO_TOOLTIP_TEXT,a,t,n);elseif(GetStablePetInfo(0))then
o,l,a,t,n=GetStablePetInfo(0);SetItemButtonTexture(PetStableCurrentPet,o);PetStableCurrentPet.tooltip=l;PetStableCurrentPet.tooltipSubtext=format(STABLE_PET_INFO_TOOLTIP_TEXT,a,t,n);else
SetItemButtonTexture(PetStableCurrentPet,"");PetStableCurrentPet.tooltip=EMPTY_STABLE_SLOT;PetStableCurrentPet.tooltipSubtext="";PetStableCurrentPet:SetChecked(nil);end
if(GameTooltip:IsOwned(PetStableCurrentPet))then
GameTooltip:SetOwner(PetStableCurrentPet,"ANCHOR_RIGHT");GameTooltip:SetText(PetStableCurrentPet.tooltip);GameTooltip:AddLine(PetStableCurrentPet.tooltipSubtext,1,1,1);GameTooltip:Show();end
if(r==-1)then
PetStableModel:Hide();PetStableLevelText:SetText("");end
PetStablePurchaseButton:Show();if(GetNumStableSlots()==NUM_PET_STABLE_SLOTS or(not IsAtStableMaster()))then
PetStablePurchaseButton:Hide();PetStableCostLabel:Hide();PetStableCostMoneyFrame:Hide();PetStableSlotText:Hide();elseif(GetMoney()>=GetNextStableSlotCost())then
PetStablePurchaseButton:Show();PetStablePurchaseButton:Enable();PetStableCostLabel:Show();PetStableCostMoneyFrame:Show();PetStableSlotText:Show();SetMoneyFrameColor("PetStableCostMoneyFrame","white");else
PetStablePurchaseButton:Show();PetStablePurchaseButton:Disable();PetStableCostLabel:Show();PetStableCostMoneyFrame:Show();PetStableSlotText:Show();SetMoneyFrameColor("PetStableCostMoneyFrame","red");end
end
PetStable_Update=Asc_PetStable_Update
UIPanelWindows["CA2"]={area="center",pushable=0,whileDead=1,allowOtherPanels=true};UIPanelWindows["StatFrame"]={area="left",pushable=0,whileDead=1};UIPanelWindows["ResetFrame_main"]={area="left",pushable=0,whileDead=1};UIPanelWindows["TrainingFrame"]={area="left",pushable=0,whileDead=1};UIPanelWindows["ControlFrame"]={area="center",pushable=0,whileDead=1,allowOtherPanels=true};UIPanelWindows["CollectionController"]={area="left",pushable=0,whileDead=1};local i=string.gsub(ITEM_MOD_FERAL_ATTACK_POWER,"%%d","%%d%+")local d=string.gsub(ITEM_REQ_ARENA_RATING,"%%d","")GameTooltip:HookScript("OnTooltipSetItem",function(e)for l=1,GameTooltip:NumLines()do
local e=_G[GameTooltip:GetName().."TextLeft"..l]:GetText()if(e)then
local u=string.len(e)local a=1
local n=0
local s=46
local o=false
local S=1
local t=""local r="|cff66FF00"if(string.gsub(e,i,"")=="")then
local e=string.match(e,"%d+")_G[GameTooltip:GetName().."TextLeft"..l]:SetText(string.format("Increases attack power by %d in Cat, Bear and Dire Bear forms only.",e))end
if(string.find(e,d))then
local e=string.gsub(string.gsub(e,"3v3","2v2"),"5v5","3v3")_G[GameTooltip:GetName().."TextLeft"..l]:SetText(e)end
if(e)and(u>s)and string.find(e,"^Equip:")then
local d=string.sub(e,8)local i=e
t=""while a<=u do
local e=string.sub(e,a,a)n=n+1
if(n>s)then
o=true
end
if(o and(e==" "))then
t=t.."\n"S=a
n=0
o=false
end
t=t..e
a=a+1
end
if AIO_REs_MouseOver and((AIO_REs_MouseOver[d])or(AIO_REs_MouseOver[i]))then
if(AIO_REs_MouseOver[i])then
r=GetEnchantColor(AIO_REs_MouseOver[i])else
r=GetEnchantColor(AIO_REs_MouseOver[d])end
t=string.gsub(t,"Equip%: ",r.."Equip%: ")t=t.."|r"end
_G[GameTooltip:GetName().."TextLeft"..l]:SetText(t)end
end
end
end)local e=CreateFrame("FRAME")e:RegisterEvent("AUCTION_HOUSE_SHOW")e:RegisterEvent("ADDON_LOADED")e:SetScript("OnEvent",function(n,t,a)if(t=="ADDON_LOADED")and(a=="Blizzard_AuctionUI")then
BrowseNextPageButton:SetScript("OnClick",function(t,a)PlaySound("igMainMenuOptionCheckBoxOn");AuctionFrameBrowse.page=AuctionFrameBrowse.page+1;t:Disable();BrowseScrollFrameScrollBar:SetValue(0);if(e.OnDefault)and(BrowseResetButton:IsEnabled()==0)then
UIDropDownMenu_SetSelectedValue(BrowseDropDown,6);AuctionFrameBrowse_Search();UIDropDownMenu_SetSelectedValue(BrowseDropDown,-1);else
AuctionFrameBrowse_Search();end
end)BrowsePrevPageButton:SetScript("OnClick",function(t,a)PlaySound("igMainMenuOptionCheckBoxOn");AuctionFrameBrowse.page=AuctionFrameBrowse.page-1;t:Disable();BrowseScrollFrameScrollBar:SetValue(0);if(e.OnDefault)and(BrowseResetButton:IsEnabled()==0)then
UIDropDownMenu_SetSelectedValue(BrowseDropDown,6);AuctionFrameBrowse_Search();UIDropDownMenu_SetSelectedValue(BrowseDropDown,-1);else
AuctionFrameBrowse_Search();end
end)local n=BrowseSearchButton:GetScript("OnClick")BrowseSearchButton:SetScript("OnClick",function(a,t)e.OnDefault=false
n(a,t)end)end
if(t=="AUCTION_HOUSE_SHOW")then
e.OnDefault=true
AuctionFrameBrowse_Reset(BrowseResetButton)UIDropDownMenu_SetSelectedValue(BrowseDropDown,6);AuctionFrameBrowse_Search()UIDropDownMenu_SetSelectedValue(BrowseDropDown,-1);end
end)function WorldStateAlwaysUpFrame_Update()local b=GetNumWorldStateUI();local t,e,h,L,C,r,m,o;local S,_,p,P,l;local F,f,d,i,s,T,I,u,c;local a,E=IsInInstance();local n=1;local a=1;for b=1,b do
F,i,f,d,s,T,I,S,_,p,P=GetWorldStateUIInfo(b);if((F~=1)or((WORLD_PVP_OBJECTIVES_DISPLAY=="1")or(WORLD_PVP_OBJECTIVES_DISPLAY=="2"and IsSubZonePVPPOI())or(E=="pvp")))then
if(i>0)then
if(S~="")then
l=ExtendedUI[S]if not(l)then
l=ExtendedUI["CAPTUREPOINT"]end
t=l.name..a;if(a>NUM_EXTENDED_UI_FRAMES)then
e=l.create(a);NUM_EXTENDED_UI_FRAMES=a;else
e=_G[t];end
l.update(a,_,p,P);e:Show();a=a+1;else
t="AlwaysUpFrame"..n;if(n>NUM_ALWAYS_UP_UI_FRAMES)then
e=CreateFrame("Frame",t,WorldStateAlwaysUpFrame,"WorldStateAlwaysUpTemplate");NUM_ALWAYS_UP_UI_FRAMES=n;else
e=_G[t];end
if(n==1)then
e:SetPoint("TOP",WorldStateAlwaysUpFrame,-23,-20);else
c=_G["AlwaysUpFrame"..(n-1)];e:SetPoint("TOP",c,"BOTTOM");end
h=_G[t.."Text"];C=_G[t.."Icon"];L=_G[t.."DynamicIconButtonIcon"];r=_G[t.."Flash"];m=_G[t.."FlashTexture"];o=_G[t.."DynamicIconButton"];h:SetText(f);C:SetTexture(d);L:SetTexture(s);u=nil;if(s~="")then
u=s.."Flash"end
m:SetTexture(u);o.tooltip=I;if(i==2)then
UIFrameFlash(r,.5,.5,-1);o:Show();elseif(i==3)then
UIFrameFlashStop(r);o:Show();else
UIFrameFlashStop(r);o:Hide();end
n=n+1;end
if(d~="")then
e.tooltip=T;else
e.tooltip=nil;end
e:Show();end
end
end
for t=n,NUM_ALWAYS_UP_UI_FRAMES do
e=_G["AlwaysUpFrame"..t];e:Hide();end
for t=a,NUM_EXTENDED_UI_FRAMES do
e=_G["WorldStateCaptureBar"..t];if(e)then
e:Hide();end
end
end
