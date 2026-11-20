-- Reconstructed server implementation for the StoneAge farm resource.
-- Keeps the public client/server event and export contracts declared in meta.xml.

local FarmObjects = {}
local RespawnTimers = {}
local FARM_DATA_KEY = 'farmObject'

local function randomBetween(range)
    if type(range) ~= 'table' then
        return tonumber(range) or 0
    end
    local minimum = tonumber(range[1]) or 0
    local maximum = tonumber(range[2]) or minimum
    if maximum < minimum then
        minimum, maximum = maximum, minimum
    end
    return math.random(minimum, maximum)
end

local function getFarmItems(farmType, variant)
    local result = {}
    for _, entry in ipairs((variant and variant.items) or {}) do
        local itemName = entry[1]
        local quantity = randomBetween(entry[2])
        if itemName and quantity > 0 then
            result[#result + 1] = { itemName, quantity }
        end
    end
    return result
end

local function spawnFarmAt(index)
    local position = farmSpawns[index]
    if type(position) ~= 'table' then
        return false
    end

    local farmTypes = {}
    for farmType, definition in pairs(farms) do
        if type(definition) == 'table' and type(definition.variants) == 'table' and #definition.variants > 0 then
            farmTypes[#farmTypes + 1] = farmType
        end
    end
    if #farmTypes == 0 then
        return false
    end

    local farmType = farmTypes[math.random(1, #farmTypes)]
    local definition = farms[farmType]
    local variant = definition.variants[math.random(1, #definition.variants)]
    local x, y, z = tonumber(position[1]), tonumber(position[2]), tonumber(position[3])
    if not x or not y or not z or not tonumber(variant.model) then
        return false
    end

    local object = createObject(variant.model, x, y, z + (tonumber(variant.zOffset) or 0))
    if not isElement(object) then
        return false
    end

    setElementParent(object, resourceRoot)
    setElementFrozen(object, true)
    setObjectBreakable(object, false)
    setElementData(object, 'obName', FARM_DATA_KEY)
    setElementData(object, 'farmType', farmType)
    setElementData(object, 'farmSpawnIndex', index)
    if variant.scale then
        setObjectScale(object, tonumber(variant.scale) or 1)
    end

    for _, item in ipairs(getFarmItems(farmType, variant)) do
        setElementData(object, item[1], item[2])
    end

    FarmObjects[index] = object
    return object
end

local function scheduleFarmRespawn(index)
    if RespawnTimers[index] and isTimer(RespawnTimers[index]) then
        killTimer(RespawnTimers[index])
    end

    local minimum = tonumber(FarmConfigs.respawnTime and FarmConfigs.respawnTime.min) or 300000
    local maximum = tonumber(FarmConfigs.respawnTime and FarmConfigs.respawnTime.max) or minimum
    if maximum < minimum then
        minimum, maximum = maximum, minimum
    end

    RespawnTimers[index] = setTimer(function(spawnIndex)
        RespawnTimers[spawnIndex] = nil
        if isElement(FarmObjects[spawnIndex]) then
            return
        end
        spawnFarmAt(spawnIndex)
    end, math.random(minimum, maximum), 1, index)
end

local function getRemainingFarmItems(object)
    local items = {}
    for _, itemName in ipairs(FarmConfigs.possibleFarmDrops or {}) do
        local quantity = tonumber(getElementData(object, itemName)) or 0
        if quantity > 0 then
            items[#items + 1] = { itemName, math.floor(quantity) }
        end
    end
    return items
end

local function destroyFarm(object, giveDrops)
    if not isElement(object) then
        return false
    end

    local index = tonumber(getElementData(object, 'farmSpawnIndex'))
    local x, y, z = getElementPosition(object)
    local remaining = giveDrops and getRemainingFarmItems(object) or {}

    FarmObjects[index] = nil
    destroyElement(object)

    if #remaining > 0 then
        exports['stoneage_pickups']:createSack(x, y, z, remaining, 'Farm')
    end
    if index then
        scheduleFarmRespawn(index)
    end
    return true
end

local function onFarmHit(object, itemName)
    if source ~= client or not isElement(source) or getElementType(source) ~= 'player' then
        return
    end
    if not isElement(object) or getElementType(object) ~= 'object' then
        return
    end
    if getElementData(object, 'obName') ~= FARM_DATA_KEY then
        return
    end

    local farmType = getElementData(object, 'farmType')
    local definition = farms[farmType]
    local equippedItem = getElementData(source, 'equippedItem')
    local hitSettings = definition and definition.hitSettings and definition.hitSettings[equippedItem]
    if not hitSettings or type(itemName) ~= 'string' then
        return
    end

    local current = tonumber(getElementData(object, itemName)) or 0
    if current <= 0 then
        return
    end

    local removeQuantity = math.max(1, randomBetween(hitSettings.removeQuantity))
    local remaining = math.max(0, current - removeQuantity)
    if remaining > 0 then
        setElementData(object, itemName, remaining)
    else
        removeElementData(object, itemName)
    end

    local x, y, z = getElementPosition(object)
    local sound = hitSettings.sound
    if sound then
        local soundFile = sound == 'axe hit.mp3' and 'axe_hit.mp3' or 'pickaxe_hit.mp3'
        triggerEvent('rust:play3DSound', source, soundFile, x, y, z, 0.5, 50)
    end

    local hasResources = false
    for _, name in ipairs(FarmConfigs.possibleFarmDrops or {}) do
        if (tonumber(getElementData(object, name)) or 0) > 0 then
            hasResources = true
            break
        end
    end
    if not hasResources then
        destroyFarm(object, true)
    end
end

addEvent('farm:onHitObject', true)
addEventHandler('farm:onHitObject', root, onFarmHit)

function wipeFarms()
    for index, object in pairs(FarmObjects) do
        if isElement(object) then
            destroyElement(object)
        end
        FarmObjects[index] = nil
    end
    for index, timer in pairs(RespawnTimers) do
        if isTimer(timer) then
            killTimer(timer)
        end
        RespawnTimers[index] = nil
    end
    return true
end

addEventHandler('onResourceStart', resourceRoot, function()
    math.randomseed(getRealTime().timestamp + getTickCount())
    for index = 1, #farmSpawns do
        spawnFarmAt(index)
    end
end)

addEventHandler('onElementDestroy', resourceRoot, function()
    for index, object in pairs(FarmObjects) do
        if object == source then
            FarmObjects[index] = nil
            break
        end
    end
end)

addEventHandler('onResourceStop', resourceRoot, function()
    for _, timer in pairs(RespawnTimers) do
        if isTimer(timer) then
            killTimer(timer)
        end
    end
    RespawnTimers = {}
    FarmObjects = {}
end)
