addEvent("farm:onHitObject", true)

local farmObjects = {}

local function getFarmTypes()
    local types = {}
    for farmType, config in pairs(farms or {}) do
        if type(config) == "table" and type(config.variants) == "table" and #config.variants > 0 then
            types[#types + 1] = farmType
            config.spawnedQuantity = config.spawnedQuantity or 0
        end
    end
    table.sort(types)
    return types
end

function randomizeTable(sourceTable)
    local shuffled = {}
    for index, value in ipairs(sourceTable or {}) do shuffled[index] = value end
    for index = #shuffled, 2, -1 do
        local swapIndex = math.random(index)
        shuffled[index], shuffled[swapIndex] = shuffled[swapIndex], shuffled[index]
    end
    return shuffled
end

local function createFarmObject(x, y, z, farmType)
    local farmTypes = getFarmTypes()
    if #farmTypes == 0 or not x or not y or not z then return false end
    farmType = farmType or farmTypes[math.random(#farmTypes)]
    local config = farms[farmType]
    if not config then return false end

    local variant = config.variants[math.random(#config.variants)]
    local object = createObject(variant.model, x, y, z + (variant.zOffset or 0))
    if not isElement(object) then return false end

    setElementFrozen(object, true)
    setObjectScale(object, variant.scale or 1)
    setElementData(object, "obName", "farmObject")
    setElementData(object, "farmType", farmType)
    setElementData(object, "zOffset", variant.zOffset or 0, false)

    for _, drop in ipairs(variant.items or {}) do
        local itemName, range = drop[1], drop[2]
        if itemName and type(range) == "table" and tonumber(range[1]) and tonumber(range[2]) then
            local amount = math.random(range[1], range[2])
            if amount > 0 then setElementData(object, itemName, amount) end
        end
    end

    config.spawnedQuantity = (config.spawnedQuantity or 0) + 1
    farmObjects[object] = {x = x, y = y, z = z, farmType = farmType}
    return object
end

function spawnFarms()
    local positions = randomizeTable(farmSpawns or {})
    local types = getFarmTypes()
    if #types == 0 then
        outputDebugString("[stoneage_farms] Aucun type de ressource valide dans farms.", 1)
        return
    end
    for index, position in ipairs(positions) do
        createFarmObject(position[1], position[2], position[3], types[((index - 1) % #types) + 1])
    end
    outputDebugString(("[stoneage_farms] %d points de récolte créés."):format(#positions), 3)
end

addEventHandler("onResourceStart", resourceRoot, function()
    math.randomseed(getTickCount() + getRealTime().timestamp)
    spawnFarms()
end)

local function destroyFarmObject(object, respawn)
    if not isElement(object) then return end
    local info = farmObjects[object]
    local farmType = getElementData(object, "farmType")
    if farms[farmType] then
        farms[farmType].spawnedQuantity = math.max(0, (farms[farmType].spawnedQuantity or 1) - 1)
    end
    if respawn and info then
        local x, y, z, savedType = info.x, info.y, info.z, info.farmType
        setTimer(function() createFarmObject(x, y, z, savedType) end,
            exports.stoneage_settings:getConfig("Minutos para respawnar farm", 30) * 60000, 1)
    end
    farmObjects[object] = nil
    destroyElement(object)
end

local lastFarmHit = {}
addEventHandler("onPlayerQuit", root, function()
    lastFarmHit[source] = nil
end)

addEventHandler("farm:onHitObject", root, function(object, itemName)
    local player = client
    if not isElement(player) or getElementType(player) ~= "player" or source ~= player
        or getElementData(player, "isDead") or not getElementData(player, "account")
        or not isElement(object) or getElementType(object) ~= "object" then
        return
    end
    if getElementData(object, "obName") ~= "farmObject" or type(itemName) ~= "string" then
        return
    end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(object)
    if getElementDimension(player) ~= getElementDimension(object)
        or getElementInterior(player) ~= getElementInterior(object)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 5 then
        return
    end

    local now = getTickCount()
    if lastFarmHit[player] and now - lastFarmHit[player] < 450 then
        return
    end
    lastFarmHit[player] = now

    local validDrop = false
    for _, dropName in ipairs(FarmConfigs.possibleFarmDrops or {}) do
        if dropName == itemName then
            validDrop = true
            break
        end
    end
    if not validDrop then
        return
    end

    local farmType = getElementData(object, "farmType")
    local config = farms[farmType]
    local equippedItem = getElementData(player, "equippedItem")
    local hitSettings = config and config.hitSettings and config.hitSettings[equippedItem]
    if not hitSettings or type(hitSettings.removeQuantity) ~= "table" then return end

    local available = math.floor(tonumber(getElementData(object, itemName)) or 0)
    if available <= 0 then return end
    local minimum = math.max(1, math.floor(tonumber(hitSettings.removeQuantity[1]) or 1))
    local maximum = math.max(minimum, math.floor(tonumber(hitSettings.removeQuantity[2]) or minimum))
    local amount = math.min(available, math.random(minimum, maximum))
    if amount <= 0 then return end

    setElementData(object, itemName, available - amount)
    setElementData(player, itemName, (tonumber(getElementData(player, itemName)) or 0) + amount)

    if hitSettings.sound then
        exports.stoneage_sound3D:play3DSound((":stoneage_farms/files/%s"):format(hitSettings.sound), {getElementPosition(object)}, 1, 200)
    end
    if exports.stoneage_economy then
        exports.stoneage_economy:giveExp(player, math.max(1, math.floor(amount * (math.random(10, 20) / 100))))
    end

    local hasDrops = false
    for _, possibleItem in ipairs(FarmConfigs.possibleFarmDrops or {}) do
        if (tonumber(getElementData(object, possibleItem)) or 0) > 0 then
            hasDrops = true
            break
        end
    end
    if not hasDrops then
        if config.destroySound then
            exports.stoneage_sound3D:play3DSound((":stoneage_farms/files/%s"):format(config.destroySound), {getElementPosition(object)}, 1, 200)
        end
        destroyFarmObject(object, true)
    end
end)

function wipeFarms()
    for object in pairs(farmObjects) do
        if isElement(object) then destroyElement(object) end
    end
    farmObjects = {}
    for _, config in pairs(farms or {}) do config.spawnedQuantity = 0 end
    spawnFarms()
end
