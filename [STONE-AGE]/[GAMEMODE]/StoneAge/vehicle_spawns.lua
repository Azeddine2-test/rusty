picape_spawns = gameplayVariables["picape_spawns"]
nrg_spawns = gameplayVariables["nrgspawns"]
alpha_spawns = gameplayVariables["alphaspawns"]
camper_spawns = gameplayVariables["camperspawns"]
ambulance_spawns = gameplayVariables["ambulancespawns"]
bmx_spawns = gameplayVariables["bmxspawns"]
family_spawns = gameplayVariables["familyspawns"]
ferrari_spawns = gameplayVariables["ferrarispawns"]
harley_spawns = gameplayVariables["harleyspawns"]
caminhao_spawns = gameplayVariables["caminhaospawns"]
hornet_spawns = gameplayVariables["hornetspawns"]
tentSpawns = gameplayVariables["tent"]
heliCrashSites = gameplayVariables["helicrashsides"]

--[[
outputChatBox('picapes: '..#picape_spawns)
outputChatBox('ninjas: '..#nrg_spawns)
outputChatBox('alphas: '..#alpha_spawns)
outputChatBox('combis: '..#camper_spawns)
outputChatBox('ambulancias: '..#ambulance_spawns)
outputChatBox('bikes: '..#bmx_spawns)
outputChatBox('family: '..#family_spawns)
outputChatBox('ferrari: '..#ferrari_spawns)
outputChatBox('harley: '..#harley_spawns)
outputChatBox('caminhao: '..#caminhao_spawns)
outputChatBox('police:' ..#hornet_spawns)
outputChatBox('total: '..#picape_spawns+#nrg_spawns+#alpha_spawns+#camper_spawns+#ambulance_spawns+#bmx_spawns+#family_spawns+#ferrari_spawns+#harley_spawns+#caminhao_spawns+#hornet_spawns)
]]--



function setVehicleWheelsIn ( veh )
if isElement ( veh ) then
local parent = getElementData ( veh, "parent" )
if isElement ( parent ) then
local wheels = getElementData ( parent, "Tire_inVehicle" ) or 0
local tires = getVehicleAddonInfos ( getElementModel ( veh ) ) or 0 
if tires > 3 then
setTimer(function() if tires > wheels then setElementFrozen(veh,true) end end,5000,1)


if wheels == 0 then
setTimer ( function (car) setVehicleWheelStates ( car, 2, 2, 2, 2) end, 50, 1, veh )
elseif wheels == 1 then
setTimer ( function (car) setVehicleWheelStates ( car, 0, 2, 2, 2) end, 50, 1, veh )
elseif wheels == 2 then
setTimer ( function (car) setVehicleWheelStates ( car, 0, 0, 2, 2) end, 50, 1, veh )
elseif wheels == 3 then
setTimer ( function (car) setVehicleWheelStates ( car, 0, 0, 0, 2) end, 50, 1, veh )
else 
setTimer ( function (car) setVehicleWheelStates ( car, 0,0,0, 0); setElementFrozen(veh,false) end, 50, 1, veh )
end
end
end
end
end

function wheelsChanged(dataName,oldValue)
if getElementType(source) == "colshape" and dataName == "Tire_inVehicle" then 
setVehicleWheelsIn ( getElementData ( source, "parent" ) )
end
end
addEventHandler("onElementDataChange",getRootElement(),wheelsChanged)

patrolPoints = {
{-1610.9594726563,-2721.9887695313,48.5390625},
{-1611.1275634766,-2721.5834960938,48.5390625},
{-1607.9012451172,-2717.1381835938,48.5390625},
{-1604.4671630859,-2712.8425292969,48.533473968506},
{-1600.1409912109,-2707.2026367188,48.5390625},
{-2240.8959960938,-2562.4074707031,31.921875},
{-2245.970703125,-2560.0407714844,31.921875},
{-90.974182128906,-1176.2899169922,2.1790165901184},
{-96.190612792969,-1174.1997070313,2.3351848125458},
{-91.149978637695,-1162.1669921875,2.2455525398254},
{-86.053024291992,-1164.6785888672,2.2433881759644},
{-1023.9959716797,-688.26812744141,32.0078125},
{-1030.1038818359,-687.96026611328,32.0078125},
{-1037.3298339844,-688.32556152344,32.0078125},
{-1477.658203125,1868.1158447266,32.639846801758},
{-1478.0374755859,1860.4938964844,32.6328125},
{-1464.6685791016,1861.3741455078,32.639846801758},
{-1465.5118408203,1867.4959716797,32.6328125},
{-1329.3303222656,2668.5236816406,50.46875},
{-1328.8540039063,2673.9587402344,50.0625},
{-1327.9750976563,2680.9619140625,50.0625},
{-1326.8199462891,2684.7524414063,50.0625},
{377.6921081543,2601.1765136719,16.484375},
{603.32623291016,1708.0772705078,6.9921875},
{606.42254638672,1702.8956298828,6.9995288848877},
{609.79071044922,1697.8828125,6.9921875},
{613.10284423828,1692.8024902344,7.1875},
{616.70501708984,1688.0998535156,6.9921875},
{619.96130371094,1683.0451660156,6.9921875},
{623.66522216797,1678.2766113281,6.9921875},
}


lootItems = {
["helicrashsides"] = {
{"P1911",346,1.5,90,4},
{"P92",347,1.5,90,4},
{"S1897",349,1.5,90,4},
{"S686",351,1.5,90,4},
{"PDW",352,1.5,90,4},
{"MP5A5",353,1.5,90,4},
{"Granada",342,1,0,4},
{"Kar98k",357,1,90,4},
{"AKM",355,1,90,5},
{"M16A4",356,1,90,5},
{"Sniper",358,1,90,5},
},
}

function createHeliCrashSite()
    if cargoCol then
        destroyElement(blip_helicrash)
        destroyElement(getElementData(cargoCol,"parent"))
        destroyElement(cargoCol)
    end
    local item_id = math.random(table.size(heliCrashSites))
    local x,y,z = heliCrashSites[item_id][1],heliCrashSites[item_id][2],heliCrashSites[item_id][3]
    cargobob = createVehicle(548,x,y,z,nil,nil,nil)
	blip_helicrash = createBlipAttachedTo(cargobob,5)

    setElementHealth(cargobob,0)
    setElementFrozen(cargobob,true)
    cargoCol = createColSphere(x,y,z,3)
    setElementData(cargoCol,"parent",cargobob)
    setElementData(cargoCol,"helicrash",true)
    setElementData(cargoCol,"MAX_Slots",1000)
    setElementData(cargoCol,"Bomba Relógio",math.random(0,1))
    for i, item in ipairs(lootItems["helicrashsides"]) do
        local value =  math.percentChance (item[5]*3.5,math.random(1,2))
        setElementData(cargoCol,item[1],value)
        local ammoData,weapID = getWeaponAmmoType (item[1],true)
        if ammoData and value > 0 then
            setElementData(cargoCol,ammoData,math.random(1,2))
            setElementData(cargoCol,ammoData,math.random(1,2))
        end
    end
    setTimer(createHeliCrashSite,math.random(2700000,3600000),1)
	outputChatBox('Um helicrash surgiu!',root,255,255,255)
end
createHeliCrashSite()

for i,patrol in ipairs(patrolPoints) do
    local x,y,z = patrol[1],patrol[2],patrol[3]
    patrolCol = createColSphere(x,y,z,2)
    setElementData(patrolCol,"patrolstation",true)
end

dayzVehicles = {}
function spawnDayZVehicles()
    if getElementData(getRootElement(),"serverhasloadvehicles") then return end
    for i,veh in ipairs(picape_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(422,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",20)
        setElementData(vehCol,"vehicle_ID",422)
        --Engine + Tires
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{422,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
    setVehicleWheelsIn ( veh )
	end     
	for i,veh in ipairs(alpha_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(602,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",20)
        setElementData(vehCol,"vehicle_ID",602)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{602,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end	
	for i,veh in ipairs(camper_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(483,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",20)
        setElementData(vehCol,"vehicle_ID",483)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{483,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end 	
	for i,veh in ipairs(ambulance_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(416,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",20)
        setElementData(vehCol,"vehicle_ID",416)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{416,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end 
	for i,veh in ipairs(nrg_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(522,x,y,z)
        vehCol = createColSphere(x,y,z,1.5)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",6)
		setElementData(vehCol,"vehicle_ID",522)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{522,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
    end	
	for i,veh in ipairs(bmx_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(481,x,y,z)
        vehCol = createColSphere(x,y,z,1.5)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",0)
		setElementData(vehCol,"vehicle_ID",481)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{481,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
    end	
	for i,veh in ipairs(family_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(400,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",6)
		setElementData(vehCol,"vehicle_ID",400)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(4,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(1,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{400,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end	
	for i,veh in ipairs(ferrari_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(411,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",6)
		setElementData(vehCol,"vehicle_ID",411)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{411,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end		
	for i,veh in ipairs(caminhao_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(433,x,y,z)
        vehCol = createColSphere(x,y,z,2.25)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",100)
		setElementData(vehCol,"vehicle_ID",433)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{433,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end	
	for i,veh in ipairs(harley_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(463,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",6)
		setElementData(vehCol,"vehicle_ID",463)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{463,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
    end	
	for i,veh in ipairs(hornet_spawns) do
        local x,y,z = veh[1],veh[2],veh[3]
        veh = createVehicle(461,x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",6)
		setElementData(vehCol,"vehicle_ID",461)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{461,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
    end
    for i,tent in ipairs(tentSpawns) do
        local x,y,z = tent[1],tent[2],tent[3]
        tent = createObject(3243,x,y,z-1)
        setObjectScale(tent,0.5)
        tentCol = createColSphere(x,y,z,4)
        attachElements ( tentCol, tent, 0, 0, 0 )
        setElementData(tentCol,"parent",tent)
        setElementData(tent,"parent",tentCol)
        setElementData(tentCol,"tent",true)
        setElementData(tentCol,"vehicle",true)
        setElementData(tentCol,"MAX_Slots",30)
    end
end
spawnDayZVehicles()

--[[
function spawnVehiclePack (ps,cmd)
    if getElementData(ps,"admin") then
        spawnDayZVehicles()
        outputChatBox("Vehicles have been respawned!",ps,255,0,0,true)
    end
end
addCommandHandler("svp",spawnVehiclePack)
]]

function notifyAboutExplosion()
    local col = getElementData(source,"parent")
    local x1,y1,z1 = getElementPosition(source)
	if getElementModel(source) == 548 then return end -- helicrash
    id,x,y,z  = getElementData(col,"spawn")[1] or false,getElementData(col,"spawn")[2] or false ,getElementData(col,"spawn")[3] or false ,getElementData(col,"spawn")[4] or false
	setElementData(col,"deadVehicle",true)
    setElementData(source,"isExploded",true)
    createExplosion (x1+4,y1+1,z1,4)
    createExplosion (x1+2,y1-4,z1,4)
    createExplosion (x1-1,y1+5,z1,4)
    createExplosion (x1-4,y1,z1-2,4)
	destroyElement(col)
		if not id then 
			setTimer(function()
				if isElement(veh) then 
				destroyElement(veh)
				end
			end,10000,1)
		return end		
	setTimer(respawnDayZVehicle,1800000,1,id,x,y,z,source,col,getElementData(col,"MAX_Slots"))
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

function respawnVehiclesInWater (vehiclesInWater)
    for i,veh in ipairs(vehiclesInWater) do
        if getElementModel(veh) == 453 then break end
        local col = getElementData(veh,"parent")
        id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
		if not id then 
			setTimer(function()
				if isElement(veh) then 
				destroyElement(veh)
				end			
				if isElement(col) then 
				destroyElement(col)
				end
			end,10000,1)
		return end	
        respawnDayZVehicle(id,x,y,z,veh,col,getElementData(col,"MAX_Slots"))
    end
end
addEvent("respawnVehiclesInWater",true)
addEventHandler("respawnVehiclesInWater",getRootElement(),respawnVehiclesInWater)

function checkVehicleInWater ()
    local randomPlayer = getRandomPlayer()
    if randomPlayer then
        triggerClientEvent(randomPlayer,"checkVehicleInWaterClient",randomPlayer)
    end
end
setTimer(checkVehicleInWater,1800000,0) 

function respawnDayZVehicle(id,x,y,z,veh,col,max_slots)
        destroyElement(veh)
        destroyElement(col)
        veh = createVehicle(id,x,y,z+1)
        vehCol = createColSphere(x,y,z,4)
        attachElements ( vehCol, veh, 0, 0, 0 )
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",max_slots)
		setElementData(vehCol,"vehicle_ID",id)
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
        setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
        setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
        setElementData(vehCol,"spawn",{id,x,y,z})
        setElementData(vehCol,"fuel",math.random(0,getVehicleMaxFuel(vehCol)))
		setVehicleWheelsIn ( veh )
end

function onPlayerEnterDayzVehicle(veh,seat)
triggerClientEvent('hide_menu',source)
    local col = getElementData(veh,"parent")
    local id = getElementModel(veh)
    local tires,engine,parts = getVehicleAddonInfos (id)
    setElementData(veh,"maxfuel",getVehicleMaxFuel(col))
    setElementData(veh,"needtires",tires)
    setElementData(veh,"needengines",engine)
    setElementData(veh,"needparts",parts)
	if id == 481 then 
    setVehicleEngineState ( veh, true )
	return 
	end
	if seat == 0 then
    setVehicleEngineState ( veh, false )
    outputChatBox("Pressione 'K' para ligar/desligar o veiculo!",source,255,255,0)
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), onPlayerEnterDayzVehicle )

function onPlayerExitDayzVehicle(veh,seat)
local id = getElementModel(veh)
if id == 481 then return end
    if seat == 0 then
        if getVehicleEngineState(veh) == true then
        setVehicleEngineState ( veh, false )
		x,y,z = getElementPosition(veh)
		triggerClientEvent('motor_carro_som',root,'desligando',x,y,z)
		end
    end    
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), onPlayerExitDayzVehicle )

function setVehiclesFuelPerMinute ()
    for i,veh in ipairs(getElementsByType("vehicle")) do
        if getVehicleEngineState(veh) == true then
		x,y,z = getElementPosition(veh)

		if getElementModel(veh) == 481 then return end
            if getElementData(getElementData(veh,"parent"),"fuel") > 0 then
                setElementData(getElementData(veh,"parent"),"fuel",getElementData(getElementData(veh,"parent"),"fuel")-getVehicleFuelRemove(getElementModel(veh),getElementData(veh,"parent")))
			else
		outputChatBox('A gasolina acabou!',source,255,255,0)
		triggerClientEvent('motor_carro_som',root,'desligando',x,y,z)
                setVehicleEngineState ( veh, false )
				return
            end
        end
    end
end
setTimer(setVehiclesFuelPerMinute,3000,0)


repairTimer = {}
function repairVehicle (veh)
if not getElementData(source,'Caixa de Ferramentas') or getElementData(source,'Caixa de Ferramentas') == 0 then return outputChatBox('Você não tem Caixa de Ferramentas!',source,255,0,0) end
    local id = getElementModel(veh)
    if repairTimer[veh] then triggerClientEvent (source, "displayClientInfo", source,"Vehicle",getVehicleNameStoneAge(id).." Já está sendo reparado!",255,22,0) return end
    local health = math.floor(getElementHealth(veh))
    repairTimer[veh] = setTimer(fixVehicleDayZ,(1000-health)*120,1,veh,source)
    setElementFrozen (veh,true)
    setElementData(veh,"repairer",source)
    setElementData(source,"repairingvehicle",veh)
    setPedAnimation (source,"SCRATCHING","sclng_r",nil,true,false)
    triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You started to repair "..getVehicleNameStoneAge(id),22,255,0)
end
addEvent("repairVehicle",true)
addEventHandler("repairVehicle",getRootElement(),repairVehicle)

function abastecer (col,status,item,itemName) 
	if status == "add" then
	if not getElementData(source,itemName) or getElementData(source,itemName) == 0 then return outputChatBox('Você não tem '..itemName..'!',source,255,0,0) end
		if getElementData(col,item) < getVehicleMaxFuel(col)-20 then
		quant = 20
		else 
		quant = getVehicleMaxFuel(col)-getElementData(col,item)
		end
		setElementData(col,item,getElementData(col,item)+quant)
		setElementData(source,itemName,getElementData(source,itemName)-1)
		outputChatBox(quant..'L de combustivel foram adicionados!',source,255,255,0)
	end
		setPedAnimation (source,"BOMBER","bom_plant_loop",-1,false, false, false, false)
end
addEvent("add_fuel",true)
addEventHandler("add_fuel",getRootElement(),abastecer)

function change_veh_status (col,status,item,itemName)
	if status == "remove" then
		setElementData(col,item,getElementData(col,item)-1)
		outputChatBox('Um '..itemName..' foi removido!',source,255,255,0)
		local x,y,z = getElementPosition(source)
		local drop,itemString = getItemTablePosition(itemName)
		local itemPickup = createItemPickup(drop,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString)
	elseif status == "add" then
	if not getElementData(source,itemName) or getElementData(source,itemName) == 0 then return outputChatBox('Você não tem '..itemName..'!',source,255,0,0) end
		setElementData(col,item,getElementData(col,item)+1)
		setElementData(source,itemName,getElementData(source,itemName)-1)
		outputChatBox('Um '..itemName..' foi adicionado!',source,255,255,0)
	end
		setPedAnimation (source,"BOMBER","bom_plant_loop",-1,false, false, false, false)
end
addEvent("change_veh_status",true)
addEventHandler("change_veh_status",getRootElement(),change_veh_status)

function fixVehicleDayZ(veh,player)
if not veh then return end
   local id = getElementModel(veh)
    setElementHealth(veh,1000)
    fixVehicle (veh)
    setPedAnimation(player,false)
    setElementFrozen (veh,false)
    repairTimer[veh] = nil
    setElementData(veh,"repairer",nil)
    setElementData(player,"repairingvehicle",nil)
    triggerClientEvent (player, "displayClientInfo", player,"Vehicle","Você terminou de reparar o(a) "..getVehicleNameStoneAge(id),22,255,0)
end

function stopFixxingWhileMoving()
    local veh = getElementData(source,"repairingvehicle")
    setPedAnimation(source)
	   local id = getElementModel(veh)

    setElementFrozen (veh,false)
    setElementData(veh,"repairer",nil)
    setElementData(source,"1",nil)
    triggerClientEvent (source, "displayClientInfo", source,"Vehicle","Você parou de reparar "..getVehicleNameStoneAge(id),255,22,0)
    killTimer(repairTimer[veh])
    repairTimer[veh] = nil
end
addEvent("onClientMovesWhileAnimation",true)
addEventHandler("onClientMovesWhileAnimation",getRootElement(),stopFixxingWhileMoving)

function debugFixxing()
    for i,veh in ipairs(getElementsByType("vehicle")) do
        if getElementData(veh,"repairer") == source then
            outputDebugString("Vehicle repairer disconnected - destroyed tables")
            killTimer(repairTimer[veh])
            setElementFrozen (veh,false)
            repairTimer[veh] = nil
            setElementData(veh,"repairer",nil)
        end    
    end
end
addEventHandler("onPlayerQuit",getRootElement(),debugFixxing)

function setEngineStateByPlayer (playersource)
local veh = getPedOccupiedVehicle (playersource)
if veh then
local id = getElementModel(veh)
if id == 481 then return end
x,y,z = getElementPosition(playersource)
local col = getElementData(veh,"parent")
local tires,engine = getElementData(veh,"needtires"),getElementData(veh,"needengines")
if (getPedOccupiedVehicleSeat (playersource) == 0) then
	if ((getElementData(col,"Tire_inVehicle") or 0) < tonumber(tires)) then
		falta = tires-getElementData(col,"Tire_inVehicle")
		outputChatBox('Falta(m) '..falta..' Pneu!(us)',playersource,255,255,0)
		triggerClientEvent('motor_carro_som',root,'fail',x,y,z)
        return    
    end		
	if ((getElementData(col,"Engine_inVehicle") or 0) < tonumber(engine)) then
		falta = engine-getElementData(col,"Engine_inVehicle")
		outputChatBox('Falta(m) '..falta..' Motor!(res)',playersource,255,255,0)
		triggerClientEvent('motor_carro_som',root,'fail',x,y,z)
        return    
    end		
	if getElementData(col,"fuel") <= 0 then
		outputChatBox('Sem gasolina!',playersource,255,255,0)
		triggerClientEvent('motor_carro_som',root,'fail',x,y,z)
        return    	
    end
	if getVehicleEngineState(veh) == false then
		if (getPedOccupiedVehicleSeat (playersource) == 0) then
		setVehicleEngineState (veh, true)	
		triggerClientEvent('motor_carro_som',root,'ligando',x,y,z)
		setVehicleOverrideLights(veh,2)
		return
		end
	end
	if getVehicleEngineState(veh) == true then
		if (getPedOccupiedVehicleSeat (playersource) == 0) then
		setVehicleEngineState (veh, false)	
		setVehicleOverrideLights(veh,1)
		triggerClientEvent('motor_carro_som',root,'desligando',x,y,z)
		return
		end
	end
end
end
end

for id, player in ipairs(getElementsByType("player")) do
bindKey(player,"k","down",setEngineStateByPlayer)
end

function bindTheKey ()
  bindKey(source,"k","down",setEngineStateByPlayer)
end
addEventHandler("onPlayerLogin", getRootElement(), bindTheKey)