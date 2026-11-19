local takeWhenDie = {
{"Madeira"},
{"Ferro"},
{"Maçã"},
{"Sementes"},
{"Pedra"},

{"inRadiation"},
{"alivetime"},
{"MAX_Slots"},
{"blood"},
{"food"},
{"thirst"},
{"temperature"},

{"Colete"},
{"Máscara de Gás"},
{"Mask_used"},
{"Colete_used"},
{"Colete_vida"},
{"Capacete"},
{"Capacete_used"},

{"currentweapon_1"},
{"currentweapon_2"},
{"currentweapon_3"},

{"bleeding"},
{"brokenbone"},
{"pain"},
{"cold"},

{"humanity"},
{"headshots"},
{"murders"},
{"banditskilled"},

{"Sinalizador"},
{"Bomba Relógio"},

{"Box Simple"},
{"Box Protected"},

{"GPS"},
{"Relógio"},
{"Caixa de Ferramentas"},

{"Wire Fence"},
{"Caixa de Fósforo"},
{"Garrafa Vazia"},

{"Bandagem"},
{"Morfina"},
{"Antibiótico"},
{"Kit Médico"},
{"Bolsa Térmica"},
{"Primeiros Socorros"},

{"Pizza"},
{"Garrafa de Água"},

{"Leite"},
{"Carne Crua"},
{"Carne Cozida"},

--remover
{"9mm"},
{".45 ACP"},
{"P1911"},
{"P92"},
{"S1897"},
{"PDW"},
{"7.62mm"},
{"5.56mm"},
{"Granada"},
{"S686"},
{"MP5A5"},
{"Kar98k"},
{"PDW"},
{"AKM"},
{".300 Magnum"},
{"M16A4"},
{"Sniper"},
{"12 Gauge"},
--armas do server
{"Facão"},
{"Machado"},
{"Pá"},
{"Picareta"},
--Sementes
{"Sementes"},
--veiculos
{"Pneu"},{"Motor"},{"Tank"}, {"Galão Vazio"},{"Galão Cheio"},
--mochilas
{"Improvised Survivor"}, 
{"Survivor"}, 
{"Experienced Survivor"}, 
{"Student Survivor"}, 
{"Alone Survivor"}, 
{"Traveler Survivor"}, 
{"Hunter Survivor"}, 
{"Warrior Survivor"}, 
{"Warrior_C Survivor"}, 
}

giveWhenSpawn = {
  {"Bandagem",2},
  {"Antibiótico",1},
  {"Morfina",1},
  {"MAX_Slots",8},
  {"blood",10000},
  {"temperature",37},
  {"food",'aleatorio',{50,100}},
  {"thirst",'aleatorio',{50,100}},
  {"humanity",2500},
  {"brokenbone",false},
  {"pain",false},
  {"inRadiation",false},
  {"cold",false},
  {"Colete_used",false},
  {"Mask_used",false},
  {"Colete_vida",0},
  {"Capacete_used",false},
  {"currentweapon_1",false},
  {"currentweapon_2",false},
  {"currentweapon_3",false},
  {"inAnimation",false},
}

keepWhenSpawn = {
  {"quant_craft"},
  {"quant_craft_max"},
  {"experiencia"},
  {"accountName"},
  {"experiencia_need"},
  {"level"},
  {"cargo"},
  {"gang"},
  {"HUD_PESSOAL_Render"},
  {"HUD_ARMAS_Render"},
  {"HUD_VEH_Render"},
  {"VIP"},
  {"cloth0"},
  {"cloth1"},
  {"cloth2"},
  {"cloth3"},
  {"cloth15"},
  {"cloth16"},
}


coords_spawn = {
["The Farm"] = {
{-338.24423217773,-401.53164672852,5.6393585205078},
{-601.86468505859,-278.26800537109,61.509353637695},
{-845.47924804688,138.21487426758,5.0697736740112},
{-295.33987426758,290.25344848633,1.1923122406006},
{-378.55899047852,525.27227783203,7.9667019844055},
{762.95672607422,637.03741455078,6.2825617790222},
{686.37109375,401.01480102539,14.81004524231},
{-216.63031005859,-379.41119384766,4.4017248153687},
},
["Mount Chilliad"] = {
{-2199.5666503906,-1087.708984375,11.751449584961},
{-2937.2509765625,-1188.1215820313,2.4865875244141},
{-2742.365234375,-2076.2602539063,29.720134735107},
{-2797.1875,-2332.9846191406,3.8882732391357},
{-1834.3394775391,-2742.2177734375,4.0514621734619},
{-1866.1510009766,-1429.1484375,29.690925598145},
{-1348.4782714844,-1951.4854736328,5.878833770752},
{-1247.2878417969,-2569.5368652344,9.0613861083984},
},
["Flint County"] = {
{-539.8212890625,-2827.3278808594,22.520687103271},
{51.012493133545,-2750.1877441406,26.455348968506},
{-164.46989440918,-2255.0256347656,14.889791488647},
{-1194.322265625,-1899.5172119141,72.116233825684},
{-2.7315738201141,-1349.6375732422,1.9007544517517},
{40.185646057129,-949.48828125,9.9609909057617},
},
["Red County"] = {
{793.54498291016,-187.41291809082,9.1009035110474},
{1341.9691162109,-313.4919128418,4.1409606933594},
{1906.2874755859,-38.288291931152,15.780170440674},
{2342.2451171875,398.87057495117,25.574756622314},
{2819.8149414063,231.17663574219,4.3444881439209},
{2867.0698242188,-300.88818359375,5.4820966720581},
{788.25213623047,639.30773925781,8.7942695617676},
},
["Bone County"] = {
{-476.53558349609,1497.3311767578,25.48150062561},
{-931.20086669922,1633.107421875,7.397442817688},
{-1222.5252685547,1617.8342285156,13.097388267517},
{-1710.2331542969,1785.5657958984,12.492038726807},
{-819.95056152344,1768.6599121094,61.745098114014},
{-473.01965332031,1494.8153076172,24.656282424927},
{-992.19158935547,2122.0158691406,67.553855895996},
{-1368.9149169922,2096.8493652344,42.235366821289},
{-848.75610351563,2266.4943847656,69.775207519531},
{-2033.9196777344,2364.5637207031,3.9281425476074},
{-2841.9497070313,2147.0520019531,161.25402832031},
{-2003.4111328125,2835.7724609375,159.21432495117},
{-855.50329589844,2936.4294433594,40.108619689941},
{257.99807739258,2938.69140625,1.7661306858063},
},
["Aleatorio"] = {
{-338.24423217773,-401.53164672852,5.6393585205078},
{-601.86468505859,-278.26800537109,61.509353637695},
{-845.47924804688,138.21487426758,5.0697736740112},
{-295.33987426758,290.25344848633,1.1923122406006},
{-378.55899047852,525.27227783203,7.9667019844055},
{762.95672607422,637.03741455078,6.2825617790222},
{686.37109375,401.01480102539,14.81004524231},
{-216.63031005859,-379.41119384766,4.4017248153687},

{-2199.5666503906,-1087.708984375,11.751449584961},
{-2937.2509765625,-1188.1215820313,2.4865875244141},
{-2742.365234375,-2076.2602539063,29.720134735107},
{-2797.1875,-2332.9846191406,3.8882732391357},
{-1834.3394775391,-2742.2177734375,4.0514621734619},
{-1866.1510009766,-1429.1484375,29.690925598145},
{-1348.4782714844,-1951.4854736328,5.878833770752},
{-1247.2878417969,-2569.5368652344,9.0613861083984},

{-539.8212890625,-2827.3278808594,22.520687103271},
{51.012493133545,-2750.1877441406,26.455348968506},
{-164.46989440918,-2255.0256347656,14.889791488647},
{-1194.322265625,-1899.5172119141,72.116233825684},
{-2.7315738201141,-1349.6375732422,1.9007544517517},
{40.185646057129,-949.48828125,9.9609909057617},

{793.54498291016,-187.41291809082,9.1009035110474},
{1341.9691162109,-313.4919128418,4.1409606933594},
{1906.2874755859,-38.288291931152,15.780170440674},
{2342.2451171875,398.87057495117,25.574756622314},
{2819.8149414063,231.17663574219,4.3444881439209},
{2867.0698242188,-300.88818359375,5.4820966720581},
{788.25213623047,639.30773925781,8.7942695617676},

{-476.53558349609,1497.3311767578,25.48150062561},
{-931.20086669922,1633.107421875,7.397442817688},
{-1222.5252685547,1617.8342285156,13.097388267517},
{-1710.2331542969,1785.5657958984,12.492038726807},
{-819.95056152344,1768.6599121094,61.745098114014},
{-473.01965332031,1494.8153076172,24.656282424927},
{-992.19158935547,2122.0158691406,67.553855895996},
{-1368.9149169922,2096.8493652344,42.235366821289},
{-848.75610351563,2266.4943847656,69.775207519531},
{-2033.9196777344,2364.5637207031,3.9281425476074},
{-2841.9497070313,2147.0520019531,161.25402832031},
{-2003.4111328125,2835.7724609375,159.21432495117},
{-855.50329589844,2936.4294433594,40.108619689941},
{257.99807739258,2938.69140625,1.7661306858063},
},
}

function spawnDayZPlayer(player,lugar)
if not lugar then  triggerClientEvent('onClientPlayerDeathInfo',player) end
if lugar == "Cama" then
local x,y,z = getElementData(player,"camaX"),getElementData(player,"camaY"),getElementData(player,"camaZ")
    spawnPlayer (player, x,y,z+1, math.random(0,360), 0, 0, 0)
	setElementFrozen(player,true)
	playerCol = createColSphere(x,y,z,1.5)
	setElementData(player,"playerCol",playerCol)
    attachElements ( playerCol, player, 0, 0, 0 )
    setElementData(playerCol,"parent",player)
    setElementData(playerCol,"player",true)
	setPedAnimation(player,"CRACK","crckidle1",-1,false,false,false,false)
	setTimer(function()
		setElementFrozen(player,false)
	end,2000,1)
else
local number = math.random(table.size(coords_spawn[lugar]))
local x,y,z = coords_spawn[lugar][number][1],coords_spawn[lugar][number][2],coords_spawn[lugar][number][3]
    spawnPlayer (player, x,y,z, math.random(0,360), 0, 0, 0)
	playerCol = createColSphere(x,y,z,1.5)
	setElementData(player,"playerCol",playerCol)
    attachElements ( playerCol, player, 0, 0, 0 )
    setElementData(playerCol,"parent",player)
    setElementData(playerCol,"player",true)
end
	fadeCamera (player,true,3)
	setPedHeadless(player,false)
    setCameraTarget (player, player)

    local account = getPlayerAccount(player)
    setAccountData(account,"isDead",false)
    setElementData(player,"isDead",false)
    setElementData(player,"logedin",true)

	
    setElementData(player,"admin",getAccountData(account,"admin") or false)
    setElementData(player,"supporter",getAccountData(account,"supporter") or false)
    for i,data in ipairs(takeWhenDie) do
	    setElementData(player,data[1],0)    
	end
	for i, data in ipairs(keepWhenSpawn) do
	setElementData(player,data[1],getElementData(player,data[1]))
    end
	for i,data in ipairs(giveWhenSpawn) do
		if data[2] == 'aleatorio' then 
		quant = math.random(data[3][1],data[3][2])
		else
		quant = data[2]
		end
        setElementData(player,data[1],quant)    
    end	
	if getElementData(player,'VIP') then
        setElementData(player,'Student Survivor',1)
	else
        setElementData(player,'Improvised Survivor',1)	
	end
	
end
addEvent("spawnDayZPlayer",true)
addEventHandler("spawnDayZPlayer",root,spawnDayZPlayer)


function checkBuggedAccount()
    for i,player in ipairs(getElementsByType("player")) do
        local account = getPlayerAccount(player)
        if not account then return end
        if getElementData(player,"logedin") then
            if getElementModel(player) ~= 0 then
                spawnDayZPlayer(player)
                outputChatBox(getPlayerName(player).." bugou e renasceu!.",getRootElement(),22,255,22,true)
            end
        end
    end    
end
--setTimer(checkBuggedAccount,1000,0)

function notifyAboutExplosion2()
    for i,player in pairs(getVehicleOccupants(source)) do
        triggerEvent("kilLDayZPlayer",player)
    end
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion2)

function destroyDeadPlayer (ped,pedCol)
if isElement(ped) and isElement(pedCol) then
    destroyElement(ped)
    destroyElement(pedCol)
	triggerClientEvent('corpo_sound',root,x,y,z,false)
end
end

function queimarDeadPlayer (ped,pedCol,player)
if getElementData(player,'Caixa de Fósforo') and getElementData(player,'Caixa de Fósforo') >= 1 then 
if isElement(ped) and isElement(pedCol) then
x,y,x = getElementPosition(ped)
fire = createObject(3525,x,y,z-1.5)
setObjectScale(fire,0)
setPedAnimation (player,"BOMBER","BOM_Plant",-1, false, false, false, false)
setElementData(player,'experiencia',getElementData(player,'experiencia')+ math.random(20,50))
setTimer(function()
    destroyElement(fire)
    destroyElement(ped)
    destroyElement(pedCol)
	triggerClientEvent('corpo_sound',root,x,y,z,false)
end,6000,1)
end
else
triggerClientEvent (player, "displayClientInfo", player,"corpo","Você precisa de Caixa de Fósforo",255,0,0) 
end
end
addEvent('queimarDeadPlayer',true)
addEventHandler('queimarDeadPlayer',root,queimarDeadPlayer)

function setPedClothes(thePed,clothingSlot,clothingID)
  if not isElement(thePed)or type(clothingSlot)~= "number" then
	error("Invalid arguments to setPedClothes()!",2)
  end
  if not clothingID or clothingID == -1 then
	return removePedClothes(thePed,clothingSlot)
  end
  local hasClothes = getPedClothes(thePed,clothingSlot)
  if hasClothes then
	removePedClothes(thePed,clothingSlot)
  end
  local texture,model = getClothesByTypeIndex(clothingSlot,clothingID)
  return addPedClothes(thePed,texture,model,clothingSlot)
end

local dead_elementBackpack = {}
function kilLDayZPlayer (killer,headshot,weapon)
    pedCol = false
    local account = getPlayerAccount(source)
    if not account then return end
    killPed(source)
    triggerClientEvent(source,"hide_inventory_window",source)
    triggerClientEvent(source,"hide_confirm_window",source)
    triggerClientEvent(source,"hide_group_window",source)
    triggerClientEvent(source,"hide_craft_window",source)
    triggerClientEvent(source,"hide_menu",source)
    triggerClientEvent(source,"hide_config_window",source)
    triggerClientEvent(source,"hide_admin_window",source)
    triggerClientEvent(source,"hide_help_window",source)

		
	fadeCamera (source,false,1)
	    if getElementData(source,"alivetime") >= 30 then 
		setElementData(source,"can_go_cama",true)
		else
		setElementData(source,"can_go_cama",false)
		end	   
    if getElementData(source,"alivetime") >= 0 then 
        if not isElementInWater(source) then
            local x,y,z = getElementPosition(source)
            if getDistanceBetweenPoints3D (x,y,z,6000,6000,0) > 200 then
                local x,y,z = getElementPosition(source)
                local rotX,rotY,rotZ = getElementRotation(source)
                local skin = getElementModel(source)
                local ped = createPed(skin,x,y,z,rotZ)
	    setPedClothes(ped,0,getElementData(source,"cloth0"))
		setPedClothes(ped,1,getElementData(source,"cloth1"))
		setPedClothes(ped,2,getElementData(source,"cloth2"))
		setPedClothes(ped,3,getElementData(source,"cloth3"))
		setPedClothes(ped,15,getElementData(source,"cloth15"))
		setPedClothes(ped,16,getElementData(source,"cloth16"))      
				pedCol = createColSphere(x,y,z,1.5)
				    if headshot == true then
						setPedHeadless(ped,true)
					end
                killPed(ped)
				setTimer(function ()
				triggerClientEvent('corpo_sound',root,x,y,z,true)
				end,3000,1)
                setTimer(destroyDeadPlayer,math.random(600000,900000),1,ped,pedCol)    
                attachElements (pedCol,ped,0,0,0)
                setElementData(pedCol,"parent",ped)
                setElementData(pedCol,"playername",getPlayerName(source))
                setElementData(pedCol,"deadman",true)
                setElementData(pedCol,"MAX_Slots",getElementData(source,"MAX_Slots"))
				hours, minutes = getTime()
                setElementData(pedCol,"deadreason",getPlayerName(source).." está morto. Causa da morte: "..(weapon or "Desconhecida")..". Hora da morte: "..hours..":"..minutes)
            end    
        end
    end
	if killer and headshot and getElementData(source,"alivetime") >= 20 then 
		    setElementData(killer,"experiencia",getElementData(killer,"experiencia")+math.random(100,150))
			setElementData(killer,"headshots",getElementData(killer,"headshots")+1)
    elseif killer and getElementData(source,"alivetime") >= 20 then
		setElementData(killer,"experiencia",getElementData(killer,"experiencia")+math.random(80,100))
        setElementData(killer,"murders",getElementData(killer,"murders")+1)
    end
    if pedCol then
        for i,data in ipairs(takeWhenDie) do
            local plusData = getElementData(source,data[1])
            if data[1] == "9mm" then
                plusData = math.floor(getElementData(source,data[1])/25)
            elseif data[1] == ".45 ACP" then
                plusData = math.floor(getElementData(source,data[1])/10)
            elseif data[1] == "7.62mm" then
                plusData = math.floor(getElementData(source,data[1])/30)
            elseif data[1] == "5.56mm" then
                plusData = math.floor(getElementData(source,data[1])/20)
            elseif data[1] == ".300 Magnum" then
                plusData = math.floor(getElementData(source,data[1])/5)
            elseif data[1] == "12 Gauge" then
                plusData = math.floor(getElementData(source,data[1])/7)
            end
            setElementData(pedCol,data[1],plusData)
        end
		local x,y,z = getElementPosition(source)
        local backpackSlots = getElementData(source,"MAX_Slots")
        if backpackSlots == 12 then
        setElementData(pedCol,"Improvised Survivor",1)
        elseif backpackSlots == 17 then
        setElementData(pedCol,"Survivor",1)        
		elseif backpackSlots == 22 then
        setElementData(pedCol,"Student Survivor",1)
		elseif backpackSlots == 27 then
        setElementData(pedCol,"Experienced Survivor",1)
		elseif backpackSlots == 32 then
        setElementData(pedCol,"Alone Survivor",1)
		elseif backpackSlots == 37 then
        setElementData(pedCol,"Traveler Survivor",1)
		elseif backpackSlots == 42 then
        setElementData(pedCol,"Hunter Survivor",1)
		elseif backpackSlots == 47 then
        setElementData(pedCol,"Warrior Survivor",1)
		elseif backpackSlots == 57 then
        setElementData(pedCol,"Warrior_C Survivor",1)
        end
    end
    setTimer(function ()
		if source and isElement(source) then 
			setElementPosition(source,6000,6000,0)
		end
	end,500,1)
    triggerClientEvent(source,"onClientPlayerDeathInfo",source)
    setAccountData(account,"isDead",true)
    setElementData(source,"isDead",true)
	
	if isElement(getElementData(source,"playerCol")) then
    destroyElement(getElementData(source,"playerCol"))
	end
	if killer and killer == source then
	triggerClientEvent ( "onRollMessageStart", getRootElement(),getPlayerName(source).." foi morto por [Suicidio]",0,22,255, "died")
	elseif killer ~= source and killer then
	triggerClientEvent ( "onRollMessageStart", getRootElement(),getPlayerName(source).." foi morto por ["..getPlayerName(killer).."] ["..getWeaponNameFromID(killer).."]",0,22,255, "died")
	else
	triggerClientEvent ( "onRollMessageStart", getRootElement(),getPlayerName(source).." foi morto por [Sangramento]",0,22,255, "died")
	end	
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),kilLDayZPlayer)


table_weapons = {
['Armas'] = {
{'P1911','.45 ACP',10,22},
{'P92','.45 ACP',10,23},
{'PDW','9mm',25,28},
{'MP5A5','9mm',25,29},
{'M16A4','5.56mm',20,31},
{'AKM','7.62mm',30,30},
{'S1897','12 Gauge',7,25},
{'S686','12 Gauge',7,27},
{'Sniper','.300 Magnum',1,34},
{'Kar98k','7.62mm',1,33},
{'Granada','','',16},
{'Facão','','',4},
{'Machado','','',8},
{'Pá','','',6},
{'Picareta','','',2},
{'Soco','','',0},
},
}

function getWeaponNameFromID(elemento)
if not elemento then return '' end
for i, data in ipairs(table_weapons['Armas']) do 
	if getPedWeapon(elemento) == data[4] then 
		return data[1]
	end
end
end


function onStealthKill(targetPlayer)
	cancelEvent()
	return
end
addEventHandler("onPlayerStealthKill", getRootElement(), onStealthKill)

function requestSpawn (lugar)
   setTimer(spawnDayZPlayer,50,1,source,lugar)
end
addEvent("requestSpawn",true)
addEventHandler("requestSpawn",getRootElement(),requestSpawn)
