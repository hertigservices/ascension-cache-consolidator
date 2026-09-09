Ulocal e=AIO or require("AIO")local a=1.01
if e.AddAddon()then
return
end
local n=e.AddHandlers("AbandonSkill",{})local i={[1]={"Alchemy","Alchemy","Alchimie","Alchemie","鍊金術","鍊金術","Alquimia","Alquimia","Алхимия"},[2]={"Blacksmithing","Blacksmithing","Forge","Schmiedekunst","鍛造","鍛造","Herrería","Herrería","Кузнечное дело"},[3]={"Enchanting","Enchanting","Enchantement","Verzauberkunst","附魔","附魔","Encantamiento","Encantamiento","Наложение чар"},[4]={"Engineering","Engineering","Ingénierie","Ingenieurskunst","工程學","工程學","Ingeniería","Ingeniería","Инженерное дело"},[5]={"Herbalism","Herbalism","Herboristerie","Kräuterkunde","草藥學","草藥學","Herboristería","Herboristería","Травничество"},[6]={"Leatherworking","Leatherworking","Travail du cuir","Lederverarbeitung","製皮","製皮","Peletería","Peletería","Кожевничество"},[7]={"Mining","Mining","Minage","Bergbau","採礦","採礦","Minería","Minería","Горное дело"},[8]={"Skinning","Skinning","Dépeçage","Kürschnerei","剝皮","剝皮","Desuello","Desuello","Снятие шкур"},[9]={"Tailoring","Tailoring","Couture","Schneiderei","裁縫","裁縫","Sastrería","Sastrería","Портняжное дело"},}StaticPopupDialogs["UNLEARN_SKILL"]={text=UNLEARN_SKILL,button1=UNLEARN,button2=CANCEL,OnAccept=function(r,n)local r={GetSkillLineInfo(n)}for n,i in pairs(i)do
for a,i in pairs(i)do
if(i==r[1])then
e.Handle("AbandonSkill","AbandonSkill",n)return
end
end
end
end,timeout=60,exclusive=1,whileDead=1,showAlert=1,hideOnEscape=1};print(string.format("|cFF00FF00Loaded Skill Unlearn System v%.2f |r",a))