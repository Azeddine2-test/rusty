table_mochilas = {
{"Improvised Survivor"},
{"Survivor"},
{"Student Survivor"},
{"Experienced Survivor"},
{"Alone Survivor"},
{"Traveler Survivor"},
{"Hunter Survivor"},
{"Warrior Survivor"},
{"Warrior_C Survivor"},
}

local itemTable = {
["loots"] = {
{"Improvised Survivor",2275,1,90,3},
{"P1911",346,1,90,2},
{'Sinalizador',324,1,0,1},
{'Bomba Relógio',1654,1,0,0.5},
{'Pólvora',17076,0.002,0,2},
{'Relógio',2253,2,0,3}, 
{'Caixa de Ferramentas',2969,1,0,3}, 
{'Garrafa Vazia',2683,1,0,3}, 
{'Bandagem',1578,1.5,0,3}, 
{'Morfina',1579,1.5,0,2}, 
{'Antibiótico',2709,1.5,0,3}, 
{'Kit Médico',2891,1.5,0,3}, 
{'Bolsa Térmica',1576,1.5,0,3}, 
{'Primeiros Socorros',1580,1.5,0,3}, 
{'Maçã',328,1.5,0,3},
{'Garrafa de Água',2683,1.5,0,3}, 
{'Caixa de Fósforo',2039,0.8,0,2},
{'Leite',2856,1,0,3},
{'Carne Crua',2804,1,0,3},
{'Carne Cozida',2806,0.5,0,3},

{"P1911",346,1.5,90,2},
{"P92",347,1.5,90,2},
{"S1897",349,1.5,90,2},
{"S686",351,1.5,90,2},
{"PDW",352,1.5,90,2},
{"MP5A5",353,1.5,90,2},
{"Granada",342,1,0,2},
{"Kar98k",357,1,90,2},
{"AKM",355,1,90,1},
{"M16A4",356,1,90,1},
{"Sniper",358,1,90,0.5},
{"Facão",335,1,90,2},
{"Machado",339,1,90,2},
{"Pá",337,1,90,2},
{"Picareta",333,1,90,2},

{"Pneu",1073,2,0,1},
{"Tank",1008,2,0.8,4},
{"Motor",929,2,0,2.5},
{"Galão Vazio",1650,1,90,2},
{"Galão Cheio",1650,1,90,3},

{"Colete",1922,1,90,1},
{"Máscara de Gás",1604,1,90,1},
{"Capacete",2254,1,90,1},

{"Improvised Survivor",2275,1,90,1.15},
{"Survivor",2274,1,90,1.15},
{"Experienced Survivor",2272,1,90,1.15},
{"Student Survivor",2273,1,90,1.15},
{"Alone Survivor",2271,1,90,1.15},
{"Traveler Survivor",2270,1,90,1.15},
{"Hunter Survivor",2269,1,90,1.15},
{"Warrior Survivor",2268,1,90,1.15},
{"Warrior_C Survivor",2267,1,90,1.15},

},
['raros'] = {
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
{"Bomba Relógio",1654,1,90,5},

},
["other"] = {
--{'nome',id,scale,rotation}
{'Madeira',1463,1.5,0},
{'Ferro',2936,0.25,0},
{'Pedra',868,0.15,0},

{'Sementes',328,0.4,0},
{'Sinalizador',324,1,90},
{'Bomba Relógio',1654,1,-90},
{'Pólvora',17076,0.002,0},
{'Relógio',2253,2,0}, 
{'Caixa de Ferramentas',2969,1,0}, 
{'Garrafa Vazia',2683,1,0}, 

{'Bandagem',1578,1.5,0}, 
{'Morfina',1579,1.5,0}, 
{'Antibiótico',2709,1.5,0}, 
{'Kit Médico',2891,1.5,0}, 
{'Bolsa Térmica',1576,1.5,0}, 
{'Primeiros Socorros',1580,1.5,0}, 

{'Maçã',328,1.5,0},
{'Garrafa de Água',2683,1.5,0}, 
{'Caixa de Fósforo',2039,0.8,0}, 
{'Leite',2856,1,0},
{'Carne Crua',2804,1,0},
{'Carne Cozida',2806,0.5,0},

{"9mm",3013,2,0},
{".45 ACP",3013,2,0},
{"7.62mm",1271,2,0},
{"5.56mm",1271,2,0},
{".300 Magnum",2358,2,0},
{"12 Gauge",2358,2,0},

{"P1911",346,1.5,90},
{"P92",347,1.5,90},
{"S1897",349,1.5,90},
{"S686",351,1.5,90},
{"PDW",352,1.5,90},
{"MP5A5",353,1.5,90},
{"Granada",342,1,0},
{"Kar98k",357,1,90},
{"AKM",355,1,90},
{"M16A4",356,1,90},
{"Sniper",358,1,90},
{"Facão",335,1,90},
{"Machado",339,1,90},
{"Pá",337,1,90},
{"Picareta",333,1,90},

{"Pneu",1073,2,0,1},
{"Tank",1008,2,0.8,4},
{"Motor",929,2,0,3.5},
{"Galão Vazio",1650,1,90},
{"Galão Cheio",1650,1,90},

{"Colete",1922,1,90},
{"Máscara de Gás",1604,1,90},
{"Capacete",2254,1,90},

{"Improvised Survivor",2275,1,90,1.15},-- esse ultimo argumento é a altura do item em relacao ao chao
{"Survivor",2274,1,90,1.15},
{"Experienced Survivor",2272,1,90,1.15},
{"Student Survivor",2273,1,90,1.15},
{"Alone Survivor",2271,1,90,1.15},
{"Traveler Survivor",2270,1,90,1.15},
{"Hunter Survivor",2269,1,90,1.15},
{"Warrior Survivor",2268,1,90,1.15},
{"Warrior_C Survivor",2267,1,90,1.15},
},
}

weaponAmmoTable = {
["9mm"] = {{"PDW",28},{"MP5A5",29}},
[".45 ACP"] = {{"P1911",22},{"P92",23}},
["7.62mm"] = {{"AKM",30},{"Kar98k",33},},
["5.56mm"] = {{"M16A4",31},},
["12 Gauge"] = {{"S1897",25},{"S686",27}},
[".300 Magnum"] = {{"Sniper",34}},
["others"] = {
{"Granada",16},
{"Facão",4},
{"Machado",8},
{"Picareta",2},
{"Pá",6},
},
}

function getWeaponAmmoType (weaponName,notOthers)
    if not notOthers then
        for i,weaponData in ipairs(weaponAmmoTable["others"]) do
            if weaponName == weaponData[1] then
                return weaponData[1],weaponData[2]
            end
        end
    end    
    for i,weaponData in ipairs(weaponAmmoTable["9mm"]) do
        if weaponName == weaponData[1] then
            return "9mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".45 ACP"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["7.62mm"]) do
        if weaponName == weaponData[1] then
            return "7.62mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56mm"]) do
        if weaponName == weaponData[1] then
            return "5.56mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".300 Magnum"]) do
        if weaponName == weaponData[1] then
            return ".300 Magnum",weaponData[2]
        end
    end
    return false
end

function isBackPack(item)
	for i, data in ipairs(table_mochilas) do 
		if item == data[1] then 
		return true
		end
	end
end

function createItemPickup(item,x,y,z,tableStringName,itemName)
    if item and x and y and z then
		if isBackPack(itemName) then
		plusY = 1.15
        else
		plusY = 0.9
        end
		local object = createObject(itemTable[tostring(tableStringName)][item][2],x,y,z-plusY,itemTable[tostring(tableStringName)][item][4],0,math.random(0,360))
		setObjectScale(object,itemTable[tostring(tableStringName)][item][3])
        setElementCollisionsEnabled(object, false)
        setElementFrozen (object,true)
        local col = createColSphere(x,y,z,0.75)
        setElementData(col,"item",itemTable[tostring(tableStringName)][item][1])
        setElementData(col,"parent",object)
        setTimer(function()
            if isElement(col) then
                destroyElement(col)
                destroyElement(object)
            end    
        end,900000,1)
        return object
    end
end

function table.size(tab)
if not tab then outputDebugString('havent tab') return end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function math.percentChance (percent,repeatTime)
    local hits = 0
    for i = 1, repeatTime do
    local number = math.random(0,200)/2
        if number <= percent then
            hits = hits+1
        end
    end
    return hits
end

function createItemLoot (lootPlace,x,y,z,id)
    col = createColSphere(x,y,z,1.25)
    setElementData(col,"itemloot",true)
    setElementData(col,"isTimerToRefresh",false)
    setElementData(col,"parent",lootPlace)
    setElementData(col,"MAX_Slots",0)
	--blip = createBlip ( x,y,z, 0, 1, 0,0,255, 255, 0, 170,getRootElement())
	--theMarker = createMarker ( x, y, z-1, "cylinder", 1.5, 0, 0, 255, 255)
    for i, item in ipairs(itemTable[lootPlace]) do
        local value =  math.percentChance (item[5],math.random(1,2))
        setElementData(col,item[1],value)
        local ammoData,weapID = getWeaponAmmoType (item[1],true)
        if ammoData and value > 0 then
            setElementData(col,ammoData,math.random(1,2))
        end
    end
    refreshItemLoot (col,lootPlace)
    return col
end

function refreshItemLoot (col,place,creating)
    if not creating and not getElementData(col,"isTimerToRefresh") then
	setElementData(col,"isTimerToRefresh",true)
    setTimer(refreshItemLoots,timetorefresh,1,col)
	end
    local objects = getElementData(col,"objectsINloot")
    if objects then
        if objects[1] ~= nil then
            destroyElement(objects[1])
        end
        if objects[2] ~= nil then
            destroyElement(objects[2])
        end
        if objects[3] ~= nil then
            destroyElement(objects[3])
        end
    end
    local counter = 0
    local obejctItem = {}
    for i, item in ipairs(itemTable["other"]) do
        if getElementData(col,item[1]) and getElementData(col,item[1]) > 0 then
            if counter == 3 then
                break
            end    
            counter = counter + 1
            local x,y,z = getElementPosition(col)
			if item[5] then zplus = item[5] else zplus = 0.9 end
            obejctItem[counter] = createObject(item[2],x+math.random(-1,1),y+math.random(-1,1),z-zplus,item[4])
            setObjectScale(obejctItem[counter],item[3])
            setElementCollisionsEnabled(obejctItem[counter], false)
            setElementFrozen (obejctItem[counter],true)
        end
    end
    if obejctItem[1] == nil then
        local x,y,z = getElementPosition(col)
        obejctItem[1] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
        setObjectScale(obejctItem[1],0)
        setElementCollisionsEnabled(obejctItem[1], false)
        setElementFrozen (obejctItem[1],true)
    end
    if obejctItem[2] == nil then
        local x,y,z = getElementPosition(col)
        obejctItem[2] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
        setObjectScale(obejctItem[2],0)
        setElementCollisionsEnabled(obejctItem[2], false)
        setElementFrozen (obejctItem[2],true)
    end
    if obejctItem[3] == nil then
        local x,y,z = getElementPosition(col)
        obejctItem[3] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
        setObjectScale(obejctItem[3],0)
        setElementCollisionsEnabled(obejctItem[3], false)
        setElementFrozen (obejctItem[3],true)
    end
    setElementData(col,"objectsINloot",{obejctItem[1], obejctItem[2], obejctItem[3]})
end
addEvent( "refreshItemLoot", true )
addEventHandler( "refreshItemLoot", getRootElement(), refreshItemLoot )


function refreshItemLoots(loot)
  local lootPlace = getElementData(loot,"parent")
  setElementData(loot,"isTimerToRefresh",false)
  for i, item in ipairs(itemTable[lootPlace]) do
	if not item[5] then
	  numb = 0
	else
	  numb = item[5]
	end
	local value =  math.percentChance(numb,math.random(1,2))
	setElementData(loot,item[1],value)
	local ammoData,weapID = getWeaponAmmoType (item[1],true)
	if ammoData and value > 0 then
	  setElementData(loot,ammoData,math.random(1,2))
	end
  end
  refreshItemLoot(loot,lootPlace,true)
end



function createPickupsOnServerStart()
    iPickup = 0
    for i,pos in ipairs(pickupPositions["loots"]) do
        iPickup = iPickup + 1
        createItemLoot("loots",pos[1],pos[2],pos[3],iPickup)
    end
	setTimer(createPickupsOnServerStart2,5000,1)
end

function createPickupsOnServerStart2()
    for i,pos in ipairs(pickupPositions["raros"]) do
        iPickup = iPickup + 1
        createItemLoot("raros",pos[1],pos[2],pos[3],iPickup)
    end
end
createPickupsOnServerStart()

function onPlayerTakeItemFromGround (itemName,col)
    itemPlus = 1
    if itemName == "9mm" then
        itemPlus = 25
    elseif itemName == ".45 ACP" then
        itemPlus = 10
    elseif itemName == "7.62mm" then
        itemPlus = 30
    elseif itemName == "5.56mm" then
        itemPlus = 20
    elseif itemName == "12 Gauge" then
        itemPlus = 7
    elseif itemName == ".300 Magnum" then
        itemPlus = 5
    elseif itemName == "M16A4" or 
	itemName == "AKM" or 
	itemName == "Sniper" or 
	itemName == "S1897" or 
	itemName == "S686" or 
	itemName == "Kar98k" then
        removeBackWeaponOnDrop()    
    end
    local x,y,z = getElementPosition(source)
    local id,ItemType = getItemTablePosition (itemName)
    setElementData(source,itemName,(getElementData(source,itemName) or 0)+itemPlus)
    destroyElement(getElementData(col,"parent"))
    destroyElement(col)
	setPedAnimation (source,"BOMBER","bom_plant_crouch_in",-1, false, false, false, false)
end
addEvent( "onPlayerTakeItemFromGround", true )
addEventHandler( "onPlayerTakeItemFromGround", getRootElement(), onPlayerTakeItemFromGround )

function onPlayerChangeLoot(loot)
local players = getElementsWithinColShape (loot,"player")
    for theKey,player in ipairs(players) do 
        triggerClientEvent(player,"refreshLootManual",player,loot)
    end    
end
addEvent( "onPlayerChangeLoot", true )
addEventHandler( "onPlayerChangeLoot", getRootElement(), onPlayerChangeLoot )

function playerDropAItem(itemName)
    local x,y,z = getElementPosition(source)
    local item,itemString = getItemTablePosition(itemName)
    local itemPickup = createItemPickup(item,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString,itemName)
	if getElementData(source,'MAX_Slots') == 8 then
	setPedAnimation (source,"BOMBER","bom_plant_crouch_in",-1, false, false, false, false)
	end
end
addEvent( "playerDropAItem", true )
addEventHandler( "playerDropAItem", getRootElement(), playerDropAItem )

function getItemTablePosition (itema)
    for id, item in ipairs(itemTable[tostring("other")]) do
        if itema == item[1] then
            return id,"other"
        end
    end
    return item,itemString
end