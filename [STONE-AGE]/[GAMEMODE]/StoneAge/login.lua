addCommandHandler("kill", function (source)
setElementFrozen(source,true)
setPedAnimation (source,"knife","kill_knife_ped_damage",-1, false, false, false, false)
setTimer(function()
setPedHeadless(source,true)
triggerEvent('kilLDayZPlayer',source,source)
--setElementData(source,"blood",-5)
end,2000,1)
end)

local playerDataTable = {
--Server
{"inRadiation"},
{"can_go_cama"},
{"quant_craft"},
{"quant_craft_max"},
{"Colete"},
{"Máscara de Gás"},
{"Mask_used"},
{"Colete_used"},
{"Colete_vida"},
{"Capacete"},
{"Capacete_used"},
{"cama"},
{"camaX"},
{"camaY"},
{"camaZ"},
{"cargo"},
{"gang"},
{"accountName"},
{"volume_som_geral"},
{"HUD_PESSOAL_Render"},
{"HUD_ARMAS_Render"},
{"HUD_VEH_Render"},
--DataPlayer
{"experiencia"},
{"experiencia_need"},
{"level"},
{"alivetime"},
{"MAX_Slots"},
{"blood"},
{"food"},
{"thirst"},
{"temperature"},
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
--itens
{"Madeira"},
{"Ferro"},
{"Maçã"},
{"Sementes"},
{"Pedra"},
{"Sinalizador"},
{"Bomba Relógio"},
{"Box Simple"},
{"Box Protected"},
{"GPS"},
{"Pólvora"},
{"Relógio"},
{"Caixa de Ferramentas"},
{"Wire Fence"},
{"Garrafa Vazia"},
--medical
{"Bandagem"},
{"Morfina"},
{"Antibiótico"},
{"Kit Médico"},
{"Bolsa Térmica"},
{"Primeiros Socorros"},
--alimentacao
{"Garrafa de Água"},
{"Caixa de Fósforo"},
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

preSetData = {
  {"quant_craft"},
  {"quant_craft_max"},
  {"accountName"},
  {"experiencia"},
  {"experiencia_need"},
  {"level"},
  {"cargo"},
  {"cama"},
  {"camaX"},
  {"camaY"},
  {"camaZ"},
  {"gang"},
  {"HUD_PESSOAL_Render"},
  {"HUD_ARMAS_Render"},
  {"HUD_VEH_Render"},
  {"VIP"},
}

function givePresetData(player) -- quando loga morto tem que dar esses elementos
account = getPlayerAccount(player)
for i, data in ipairs(preSetData) do 
setElementData(player,data[1],getAccountData(account,data[1]))
end
createBlipCamaInLogin(player)
end

function playerLogin(username, pass, player)
    local playerID = getAccountData(getPlayerAccount(player),"playerID")
    account = getPlayerAccount(player)
    local x,y,z =  getAccountData(account,"last_x") or 0,getAccountData(account,"last_y") or 0,getAccountData(account,"last_z") or 0
    if getAccountData(account,"isDead") then
        spawnDayZPlayer(player,"Aleatorio")
		givePresetData(player)
        return
    end
    spawnPlayer (player, x,y,z+0.5, math.random(0,360), 0, 0, 0)
    setElementFrozen(player, true)
    fadeCamera (player, true)
    setCameraTarget (player, player)
    setTimer( function(player)
        if isElement(player) then
            setElementFrozen(player, false)
        end
    end,500,1,player)
    playerCol = createColSphere(x,y,z,1.5)
    setElementData(player,"playerCol",playerCol)
    attachElements ( playerCol, player, 0, 0, 0 )
    setElementData(playerCol,"parent",player)
    setElementData(playerCol,"player",true)
	
  for i,data in ipairs(playerDataTable) do
    local elementData = getAccountData(account, data[1])
    if not elementData then 
    setElementData(player, data[1], false)
	else
    setElementData(player, data[1], elementData)	
    end
  end
    setElementData(player,"logedin",true)
    local weapon = getElementData(player,"currentweapon_1")
    if weapon then
        local ammoData,weapID = getWeaponAmmoType (weapon)
        giveWeapon(player,weapID,getElementData(player,ammoData), true )
    end
    local weapon = getElementData(player,"currentweapon_2")
    if weapon then
        local ammoData,weapID = getWeaponAmmoType (weapon)
        giveWeapon(player,weapID,getElementData(player,ammoData), false )
    end
    local weapon = getElementData(player,"currentweapon_3")
    if weapon then
        local ammoData,weapID = getWeaponAmmoType (weapon)
        giveWeapon(player,weapID,getElementData(player,ammoData), false )
    end

    setElementData(player,"admin",getAccountData(account,"admin") or false)
    setElementData(player,"supporter",getAccountData(account,"supporter") or false)
	
	
createBlipCamaInLogin(player)
		
end
addEvent("onPlayerDayZLogin", true)
addEventHandler("onPlayerDayZLogin", getRootElement(), playerLogin)


function createBlipCamaInLogin(player)
	local cama = getElementsByType ( "object" )
	for index, cama in ipairs(cama) do
	col = getElementData(cama,'parent')
		if player and col then
			if getElementData(player,'accountName') == getElementData(col,'creator') and getElementData(col,'cama') then
			triggerEvent('createBlipCama',root,cama,player)
			end
		end
	end
end




registerItems = {
  {"Bandagem",2},
  {"Improvised Survivor",1},
  {"Antibiótico",1},
  {"Morfina",1},
  {"MAX_Slots",8},
  {"blood",10000},
  {"temperature",37},
  {"level",1},
  {"experiencia",1},
  {"experiencia_need",1000},
  {"HUD_PESSOAL_Render",true},
  {"HUD_ARMAS_Render",true},
  {"HUD_VEH_Render",true},
  {"food",100},
  {"thirst",100},
  {"humanity",2500},
  {"quant_craft",0},
  {"quant_craft_max",30},
  {"brokenbone",false},
  {"gang",'None'},
  {"Colete_used",false},
  {"Mask_used",false},
  {"Colete_vida",0},
  {"Capacete_used",false},
  {"pain",false},
  {"cold",false},
  {"cama",false},
  {"inRadiation",false},
  {"currentweapon_1",false},
  {"currentweapon_2",false},
  {"currentweapon_3",false},
}
function checkThis(itemname)
  for _,item in pairs(registerItems)do
	if item[1] == itemname and item[2] == false then
	  return true
	end
  end
  return false
end

function checkThis_2(itemname)
  for _,item in pairs(playerDataTable)do
	if item[1] == itemname and item[2] == false then
	  return true
	end
  end
  return false
end

function playerRegister(username, pass, player)
local number = math.random(table.size(coords_spawn['Aleatorio']))
local x,y,z = coords_spawn['Aleatorio'][number][1],coords_spawn['Aleatorio'][number][2],coords_spawn['Aleatorio'][number][3]    
spawnPlayer (player, x,y,z, math.random(0,360), 0, 0, 0)
    fadeCamera (player, true)
    setCameraTarget (player, player)
    playerCol = createColSphere(x,y,z,1.5)
    attachElements ( playerCol, player, 0, 0, 0 )
    setElementData(playerCol,"parent",player)
    setElementData(playerCol,"player",true)
    for i,data in ipairs(playerDataTable) do
            setElementData(player,data[1],0)
    end
  for _,item in pairs(registerItems)do
	setElementData(player,item[1],item[2])
  end	
    account = getAccount(username)
    local value = getAccounts()
    local value = #value
	
    setElementData(player,"accountName",getAccountName(getPlayerAccount(player)))
    setElementData(player,"playerID",value+1)
	if account then
    setAccountData(account,"playerID",value+1)
	end
    setElementData(player,"logedin",true)
end
addEvent("onPlayerDayZRegister", true)
addEventHandler("onPlayerDayZRegister", getRootElement(), playerRegister)

function saveAccounts ()
    local account = getPlayerAccount(source)
    if account then		
    for i,data in ipairs(playerDataTable) do
        setAccountData(account,data[1],getElementData(source,data[1]))
    end
	cur_cloth_0 = getElementData ( source, "cloth0")
	cur_cloth_1 = getElementData ( source, "cloth1")
	cur_cloth_2 = getElementData ( source, "cloth2")
	cur_cloth_3 = getElementData ( source, "cloth3")
	cur_cloth_15 = getElementData ( source, "cloth15")
	cur_cloth_16 = getElementData ( source, "cloth16")
        setAccountData(account,"cloth0",cur_cloth_0)
        setAccountData(account,"cloth1",cur_cloth_1)
        setAccountData(account,"cloth2",cur_cloth_2)	
        setAccountData(account,"cloth3",cur_cloth_3)	
        setAccountData(account,"cloth15",cur_cloth_15)	
        setAccountData(account,"cloth16",cur_cloth_16)	
        local x,y,z =  getElementPosition(source)
        setAccountData(account,"last_x",x)
        setAccountData(account,"last_y",y)
        setAccountData(account,"last_z",z)
		if isElement(getElementData(source,"playerCol")) then
        destroyElement(getElementData(source,"playerCol"))
		end    
    end    
    setElementData(source,"logedin",false)
end
addEventHandler ("onPlayerQuit", root, saveAccounts )

function saveAccounts2 ()
for i, player in ipairs(getElementsByType("player")) do
    local account = getPlayerAccount(player)
    if account then
    for i,data in ipairs(playerDataTable) do
        setAccountData(account,data[1],getElementData(player,data[1]))
    end
        local x,y,z =  getElementPosition(player)
        setAccountData(account,"last_x",x)
        setAccountData(account,"last_y",y)
        setAccountData(account,"last_z",z)
    end    
end    
end
addEventHandler ( "onResourceStop", getRootElement(), saveAccounts2 )

local vehicleDataTable = {
{"cama"},
{"blip"},
{"MAX_Slots"},
{"Tire_inVehicle"},
{"Engine_inVehicle"},
{"Parts_inVehicle"},
{"password"},
{"fuel"},
{"Bandagem"},
{"Garrafa de Água"},
{"Caixa de Fósforo"},
{"9mm"},
{"P1911"},
{"P92"},
{".45 ACP"},
{"S1897"},
{"PDW"},
{"Facão"},
{"Morfina"},
{"Hatchet"},
{"Pizza"},
{"Galão Vazio"},
{"Galão Cheio"},
{"Sinalizador"},
{"Bomba Relógio"},
{"Leite"},
{"7.62mm"},
{"5.56mm"},
{"Tear Gas"},
{"Granada"},
{"S686"},
{"MP5A5"},
{"Kit Médico"},
{"Bolsa Térmica"},
{"Kar98k"},
{"AKM"},
{"Primeiros Socorros"},
{"GPS"},
{"Pólvora"},
{"Relógio"},
{"Caixa de Ferramentas"},
{"Wire Fence"},
{"Pneu"},
{"Motor"},
{"Tank"},
{".300 Magnum"},
{"M16A4"},
{"Sniper"},
{"Box Simple"},
{"Box Protected"},
{"Carne Crua"},
{"Carne Cozida"},
{"Antibiótico"},
{"Garrafa Vazia"},
{"12 Gauge"},
{"Improvised Survivor"},
{"Survivor"},
{"Experienced Survivor"},
{"Student Survivor"},
{"Alone Survivor"},
{"Traveler Survivor"},
{"Hunter Survivor"},
{"Warrior Survivor"},
{"Warrior_C Survivor"},
{"Machado"},
{"Pá"},
{"Picareta"},
{"creator"},
{"password"},
}

function saveallvehicles(ps,command)
    counter = 0
    counterTent = 0
    counterCama = 0
    local vehicleManager = getAccount("vehicleManager","ds4f9$")
    for i, col in ipairs (getElementsByType("colshape")) do
        local veh = getElementData(col,"vehicle")
        local helicrash = getElementData(col,"helicrash")
        local hospitalbox = getElementData(col,"hospitalbox")
        local tent = getElementData(col,"tent")
        local cama = getElementData(col,"cama")
        if not helicrash or veh and not hospitalbox then
            if tent then
                counterTent = counterTent +1
                account = getAccount("tent_number_"..counterTent,"ds4f9$") or false
                if not account then
                    account = addAccount("tent_number_"..counterTent,"ds4f9$")
                end    
                local tent = getElementData(col,"parent")
                local x,y,z = getElementPosition(tent)
                local rx,ry,rz = getElementRotation(tent)
                setAccountData(account,"last_x",x)
                setAccountData(account,"last_y",y)
                setAccountData(account,"last_z",z)
                setAccountData(account,"last_rx",rx)
                setAccountData(account,"last_ry",ry)
                setAccountData(account,"last_rz",rz)
                for i, data in ipairs(vehicleDataTable) do 
                    setAccountData(account,data[1],getElementData(col,data[1]))
                end
				elseif veh then
				counter = counter +1
                account = getAccount("vehicle_number_"..counter,"ds4f9$") or false
                if not account then
                    account = addAccount("vehicle_number_"..counter,"ds4f9$")
                end    
                setAccountData(account,"spawn_x",getElementData(col,"spawn")[2])
                setAccountData(account,"spawn_y",getElementData(col,"spawn")[3])
                setAccountData(account,"spawn_z",getElementData(col,"spawn")[4])
                for i, data in ipairs(vehicleDataTable) do 
                    setAccountData(account,data[1],getElementData(col,data[1]))
                end
                local vehicle = getElementData(col,"parent")
                local model = getElementModel(vehicle)
                local x,y,z = getElementPosition(vehicle)
                local rx,ry,rz = getElementRotation(vehicle)
                local health = getElementHealth(vehicle)
                setAccountData(account,"last_x",x)
                setAccountData(account,"last_y",y)
                setAccountData(account,"last_z",z)
                setAccountData(account,"last_rx",rx)
                setAccountData(account,"last_ry",ry)
                setAccountData(account,"last_rz",rz)
                setAccountData(account,"health",health)
                setAccountData(account,"model",model)
                setAccountData(account,"isExploded",getElementData(vehicle,"isExploded") or false)
            end
        end
			if cama then
                counterCama = counterCama +1
                account = getAccount("cama_number_"..counterCama,"ds4f9$") or false
                if not account then
                    account = addAccount("cama_number_"..counterCama,"ds4f9$")
                end    
                local cama = getElementData(col,"parent")
                local x,y,z = getElementPosition(cama)
                local rx,ry,rz = getElementRotation(cama)
                setAccountData(account,"last_x",x)
                setAccountData(account,"last_y",y)
                setAccountData(account,"last_z",z)
                setAccountData(account,"last_rx",rx)
                setAccountData(account,"last_ry",ry)
                setAccountData(account,"last_rz",rz)
                for i, data in ipairs(vehicleDataTable) do 
                    setAccountData(account,data[1],getElementData(col,data[1]))
                end	
            end			
		if vehicleManager then
        setAccountData(vehicleManager,"vehicleamount",counter)
        setAccountData(vehicleManager,"tentamount",counterTent)
        setAccountData(vehicleManager,"camaamount",counterCama)
		else
		vehicleManager = addAccount("vehicleManager","ds4f9$")
		end
    end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveallvehicles)



function createVehicleOnServerStart()
    local vehicleManager = getAccount("vehicleManager","ds4f9$")
	if vehicleManager then
   --[[ for i = 1, (getAccountData(vehicleManager,"vehicleamount") or 0) do
        wastedVehicle = false
        vehicle = getAccount("vehicle_number_"..i,"ds4f9$")
        if not vehicle then break end
        if getAccountData(vehicle,"isExploded") == true then
            setAccountData(vehicle,"health",1000)
            wastedVehicle = true
        end
        local veh = createVehicle(getAccountData(vehicle,"model"),getAccountData(vehicle,"last_x"),getAccountData(vehicle,"last_y"),getAccountData(vehicle,"last_z"),getAccountData(vehicle,"last_rx"),getAccountData(vehicle,"last_ry"),getAccountData(vehicle,"last_rz"))
        vehCol = createColSphere(getAccountData(vehicle,"last_x"),getAccountData(vehicle,"last_y"),getAccountData(vehicle,"last_z"),4)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",getAccountData(vehicle,"MAX_Slots"))
        setElementHealth(veh,getAccountData(vehicle,"health"))
        --vehicle_indentifikation
        xxx,yyy,zzz = getAccountData(vehicle,"spawn_x"),getAccountData(vehicle,"spawn_y"),getAccountData(vehicle,"spawn_z")
        setElementData(vehCol,"spawn",{getAccountData(vehicle,"model"),xxx,yyy,zzz})
        if wastedVehicle then
            if getAccountData(vehicle,"model") == 497 then
                item_id = math.random(table.size(hunterSpawns))
                xxx,yyy,zzz = hunterSpawns[item_id][1],hunterSpawns[item_id][2],hunterSpawns[item_id][3]
            end
            if getAccountData(vehicle,"model") == 487 then
                local item_id = math.random(table.size(maverikSpawns))
                x,y,z = maverikSpawns[item_id][1],maverikSpawns[item_id][2],maverikSpawns[item_id][3]
            end
            setElementPosition(veh,xxx,yyy,zzz+1)
            setElementRotation(veh,0,0,0)
            --Engine + Tires + Tank Parts
            local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
            setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
            setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
            setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        end
        --others
        setElementData(vehCol,"fuel",getAccountData(vehicle,"fuel"))
        if not wastedVehicle then
            for i, data in ipairs(vehicleDataTable) do 
                setElementData(vehCol,data[1],getAccountData(vehicle,data[1]))
            end
        else
            if getElementModel(veh) == 433 or getElementModel(veh) == 470 then
                for i,items in ipairs(lootItems["helicrashsides"]) do
                    local randomNumber = math.random(1,10)
                    if randomNumber == 5 then
                        setElementData(vehCol,items[1],math.random(1,2))
                    end
                end
            end    
            setElementData(vehCol,"fuel",10)
        end
    end
	]]
    for i = 1, (getAccountData(vehicleManager,"tentamount") or 0) do
        tentData = getAccount("tent_number_"..i,"ds4f9$")
        if not tentData then break end
		if getAccountData(tentData,"MAX_Slots") ==  75 then
        tent = createObject(3243,getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),0,0,(getAccountData(tentData,"last_rz") or 0))
        setObjectScale(tent,1)
        tentCol = createColSphere(getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),2)
        attachElements ( tentCol, tent, 0, 0, 1 )
        setElementData(tentCol,"parent",tent)
        setElementData(tent,"parent",tentCol)
        setElementData(tentCol,"tent",true)
        setElementData(tentCol,"vehicle",true)
		elseif getAccountData(tentData,"MAX_Slots") ==  150 then 
        tent = createObject(2266,getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),0,0,(getAccountData(tentData,"last_rz") or 0))
        setObjectScale(tent,1)
        tentCol = createColSphere(getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),2)
        attachElements ( tentCol, tent, 0, 0, 1 )
        setElementData(tentCol,"parent",tent)
        setElementData(tent,"parent",tentCol)
        setElementData(tentCol,"tent",true)
        setElementData(tentCol,"vehicle",true)
		end
        for i, data in ipairs(vehicleDataTable) do 
            setElementData(tentCol,data[1],getAccountData(tentData,data[1]))
        end
    end   
	for i = 1, (getAccountData(vehicleManager,"camaamount") or 0) do
        tentData = getAccount("cama_number_"..i,"ds4f9$")
        if not tentData then break end
        tent = createObject(1800,getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),0,0,(getAccountData(tentData,"last_rz") or 0))
        setObjectScale(tent,1)
        tentCol = createColSphere(getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),2)
        attachElements ( tentCol, tent, 0, 0, 1 )
        setElementData(tentCol,"parent",tent)
        setElementData(tent,"parent",tentCol)
        setElementData(tent,"creator",getAccountData(tentData,'creator'))
        setElementData(tentCol,"cama",true)
        for i, data in ipairs(vehicleDataTable) do 
            setElementData(tentCol,data[1],getAccountData(tentData,data[1]))
        end
		
		local players = getElementsByType ( "player" )
		for index, player in ipairs(players) do
		if getElementData(player,'accountName') == getElementData(tentCol,'creator') then
		triggerEvent('createBlipCama',root,tent,player)
		end
		end
	end
	if vehicleManager then
	--[[outputChatBox(getAccountData(vehicleManager,"tentamount").." tendas foram carregadas!")
	outputChatBox(getAccountData(vehicleManager,"camaamount").." camas foram carregadas!")
	outputChatBox(getAccountData(vehicleManager,"vehicleamount").." veiculos foram carregados")]]
	end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createVehicleOnServerStart)