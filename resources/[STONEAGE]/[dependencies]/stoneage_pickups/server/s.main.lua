pickups = {
    decorations = {},
    loots = {},
}

-- //------------------- LOAD LOOT POINTS ON START -------------------\\--
addEventHandler('onResourceStart', resourceRoot, function()
    local xml = xmlLoadFile('loot-points.map')
    if not xml then
        outputDebugString('[stoneage_pickups] Impossible de lire loot-points.map ; aucun point de loot chargé.', 2)
        return
    end

    local nodes = xmlNodeGetChildren(xml)
    if type(nodes) ~= 'table' then
        xmlUnloadFile(xml)
        outputDebugString('[stoneage_pickups] loot-points.map ne contient aucun point valide.', 2)
        return
    end

    Async:foreach(nodes, function(node, k)
        local attr = xmlNodeGetAttributes(node)
        local model = tonumber(attr.model)
        local x, y, z = attr.posX, attr.posY, attr.posZ
        local rx, ry, rz = attr.rotX, attr.rotY, attr.rotZ

        if possibleLootPoints[model] then
            local ob = createObject(model, x, y, z, rx, ry, rz)
            setElementFrozen(ob, true)

            -- for k, v in ipairs(decorations) do
            --     local offX, offY, offZ = unpack(v.offsets)
            --     if type(offX) == 'table' then
            --         offX = UTILS:randomFloatNumber(offX[1], offX[2])
            --     end
            --     if type(offY) == 'table' then
            --         offY = UTILS:randomFloatNumber(offY[1], offY[2])
            --     end
            --     if type(offZ) == 'table' then
            --         offZ = UTILS:randomFloatNumber(offZ[1], offZ[2])
            --     end
            --     local x, y, z = UTILS:getPositionFromElementOffset(ob, offX, offY, offZ)
            --     local dec = createObject(v.model, x, y, z)
            --     setObjectScale(dec, v.scale or 1)
            --     setElementCollisionsEnabled(dec, false)
            -- end

            generateLoots(ob)

        elseif lootPointsFromModel[model] then
            local lootType = lootPointsFromModel[model]

            createLootPoint(lootType, x, y, z, rx, ry, rz)
        end
    end, function()
        if isElement(xml) then xmlUnloadFile(xml) end
    end)
end)
-- //------------------- LOAD LOOT POINTS ON START -------------------\\--
-- //------------------- CREATE LOOT POINT -------------------\\--
function createLootPoint(lootType, x, y, z, rx, ry, rz)
    if math.random(100) <= getPickupSetting(lootType, 'chancesToSpawn') then
        local ob = createObject(getPickupSetting(lootType, 'modelID'), x, y, z, rx, ry, rz)
        setElementFrozen(ob, true)

        if string.find(lootType, 'barrel') then
            setElementData(ob, 'lootPickup', true)
            setElementData(ob, 'health', getPickupSetting(lootType, 'maxHealth') or 9999999)
            setElementData(ob, 'maxHealth', getPickupSetting(lootType, 'maxHealth') or 9999999)
        else
            setElementData(ob, 'lootBox', true)
            setElementData(ob, 'maxSlots', getPickupSetting(lootType, 'maxSlots') or 21)

            local loots = generateLootToGive(lootType)
            for k, v in ipairs(loots) do
                setElementData(ob, v[1], (getElementData(ob, v[1]) or 0) + v[2])
            end
        end
        setElementData(ob, 'obName', lootType)
    else
        local respawnTime = getPickupSetting(lootType, 'respawnTime')
        if respawnTime then
            setTimer(createLootPoint, math.random(respawnTime[1], respawnTime[2]), 1, lootType, x, y, z, rx, ry, rz)
        end
    end
end
-- //------------------- CREATE LOOT POINT -------------------\\--

-- //------------------- GENERATE LOOT LOOTPOINT -------------------\\--
function generateLoots(ob)
    if ob and isElement(ob) then
        local model = getElementModel(ob)
        local config = possibleLootPoints[model]
        if config then
            if config.possibleLootType and config.possibleLootPositions then
                local addedQuant = 0
                for k, lootType in ipairs(config.possibleLootType) do
                    local chancesToSpawn = getPickupSetting(lootType, 'chancesToSpawn')
                    if chancesToSpawn then
                        if math.random(100) <= chancesToSpawn then
                            local model = getPickupSetting(lootType, 'modelID')
                            if model then
                                addedQuant = addedQuant + 1
                                local x, y, z = getElementPosition(ob)
                                local offX, offY, offZ = unpack(config.possibleLootPositions[addedQuant])

                                local loot = createObject(model, x, y, z)
                                attachElements(loot, ob, offX, offY, offZ + (getPickupSetting(lootType, 'zOffset') or 0), 0, 0, math.random(360))
                                setElementFrozen(loot, true)

                                if string.find(lootType, 'barrel') then
                                    setElementData(loot, 'lootPickup', true)
                                    setElementData(loot, 'health', getPickupSetting(lootType, 'maxHealth') or 9999999)
                                    setElementData(loot, 'maxHealth', getPickupSetting(lootType, 'maxHealth') or 9999999)
                                else
                                    setElementData(loot, 'lootBox', true)
                                    setElementData(loot, 'maxSlots', getPickupSetting(lootType, 'maxSlots') or 21)

                                    local loots = generateLootToGive(lootType)
                                    for k, v in ipairs(loots) do
                                        setElementData(loot, v[1], (getElementData(loot, v[1]) or 0) + v[2])
                                    end
                                end
                                setElementData(loot, 'obName', lootType)
                                setElementParent(loot, ob)
                            end
                        end
                    end
                end
                addedQuant = nil
            end
        end
    end
end
-- //------------------- GENERATE LOOT LOOTPOINT -------------------\\--
function randomizeTable(x)
    local shuffled = {}
    for i, v in ipairs(x) do
        local pos = math.random(1, #shuffled + 1)
        table.insert(shuffled, pos, v)
    end
    return shuffled
end

-- //------------------- SELECT ITEMS TO SPAWN -------------------\\--
function generateLootToGive(lootType)
    local sourceLoot = possibleLoots and possibleLoots[lootType]
    if type(sourceLoot) ~= "table" then return {} end
    local possible = randomizeTable(sourceLoot)

    if (lootType == "default-barrel" or lootType == "default-box") and type(Roupas) == "table" then
        for _, clothing in ipairs(Roupas) do
            if math.random(100) <= 30 then possible[#possible + 1] = clothing end
        end
    end

    local maxLoot = math.max(1, tonumber(exports["stoneage_settings"]:getConfig("Limite de itens no mesmo spawn", 3)) or 3)
    local extraPercent = tonumber(exports["stoneage_settings"]:getConfig("Porcentagem extra de spawn de loot", 0)) or 0
    local loots = {}

    local function addLoot(itemName)
        if type(itemName) ~= "string" or not exports["gamemode"]:isItemOfInventory(itemName) then return false end
        local quantity = tonumber(exports["gamemode"]:getItemMaxSpawnQuantity(itemName)) or 0
        if quantity <= 0 then return false end
        if quantity > 1 then quantity = math.floor(math.random(math.max(1, math.floor(quantity / 2)), quantity)) end
        if quantity <= 0 then return false end
        loots[#loots + 1] = {itemName, quantity}

        local ammo = exports["gamemode"]:getPlayerDataSetting(itemName, "ammo")
        if type(ammo) == "table" and type(ammo.name) == "string" and exports["gamemode"]:isItemOfInventory(ammo.name) then
            local ammoQuantity = tonumber(exports["gamemode"]:getItemMaxSpawnQuantity(ammo.name)) or 0
            if ammoQuantity > 0 then loots[#loots + 1] = {ammo.name, ammoQuantity} end
        end
        return true
    end

    for _, entry in ipairs(possible) do
        local itemName, chance = entry[1], tonumber(entry[2])
        if itemName and chance and math.random(100) <= math.min(100, chance + extraPercent) then
            addLoot(itemName)
            if #loots >= maxLoot then break end
        end
    end

    if #loots == 0 then
        for _, entry in ipairs(possible) do
            if addLoot(entry[1]) then break end
        end
    end
    return loots
end

local timerSack = {}
function createSack(x, y, z, items, sackName)
    if type(items) ~= "table" or #items == 0 then return false end
    local ob = getNearSack(x, y, z)
    if not isElement(ob) then
        ob = createObject(1575, x, y, z, 0, math.random(200, 320), 0)
        if not isElement(ob) then return false end
        setObjectScale(ob, 1.5)
        setElementData(ob, "maxSlots", 21)
        setElementData(ob, "obName", sackName or "Loot")
        setElementData(ob, "gearPickup", true)
        addEventHandler("onElementDestroy", ob, removeTimerOnDestroy)
    end

    local order = getElementData(ob, "invOrder")
    if type(order) ~= "table" then order = {} end
    local nextSlot = 1
    while order[nextSlot] do nextSlot = nextSlot + 1 end

    for _, item in ipairs(items) do
        local itemName = item[1]
        local quantity = math.floor(tonumber(item[2]) or 0)
        if type(itemName) == "string" and quantity > 0 and exports["gamemode"]:isItemOfInventory(itemName) then
            setElementData(ob, itemName, (tonumber(getElementData(ob, itemName)) or 0) + quantity)
            local merged = false
            for _, entry in pairs(order) do
                if entry.itemName == itemName then
                    entry.quantity = (tonumber(entry.quantity) or 0) + quantity
                    merged = true
                    break
                end
            end
            if not merged and nextSlot <= 21 then
                order[nextSlot] = {itemName = itemName, quantity = quantity}
                nextSlot = nextSlot + 1
            end
        end
    end

    setElementData(ob, "invOrder", order)
    if timerSack[ob] and isTimer(timerSack[ob]) then killTimer(timerSack[ob]) end
    timerSack[ob] = setTimer(destroySack, getTimeToDestroySack(), 1, ob)
    return ob
end
addEventHandler("pickups:createSack", root, createSack)

-- //------------------- SYNC SACK TO GROUND POSITION -------------------\\--
function sendSackToGround(ob, x, y, z)
    if isElement(ob) then
        setElementPosition(ob, x, y, z + 0.35)
        setElementData(ob, 'syncedPos', true)
    end
end
addEvent('pickups:syncSackPos', true)
addEventHandler('pickups:syncSackPos', root, sendSackToGround)
-- //------------------- SYNC SACK TO GROUND POSITION -------------------\\--
-- //------------------- CANCEL TIMER TO DESTROY WHEN SACK GETS DESTROYED -------------------\\--
function removeTimerOnDestroy()
    if timerSack[source] then
        if isTimer(timerSack[source]) then
            killTimer(timerSack[source])
        end
        timerSack[source] = nil
    end
end
-- //------------------- CANCEL TIMER TO DESTROY WHEN SACK GETS DESTROYED -------------------\\--
-- //------------------- DESTROY SACK -------------------\\--
function destroySack(ob, forced)
    if isElement(ob) then
        if isTimer(timerSack[ob]) then
            killTimer(timerSack[ob])
        end

        if (#UTILS:getElementsNear(ob, 'player', 5) == 0) or forced then
            destroyElement(ob)
            timerSack[ob] = nil
        else
            timerSack[ob] = setTimer(destroySack, getTimeToDestroySack(), 1, ob)
        end
    end
end
addEvent('destroySack', true)
addEventHandler('destroySack', root, destroySack)
-- //------------------- DESTROY SACK -------------------\\--
-- //------------------- CHECK FOR NEAR SACKS -------------------\\--
function getNearSack(x, y, z)
    local nearObjects = getElementsWithinRange(x, y, z, 2, 'object')
    for k, v in pairs(nearObjects) do
        if getElementData(v, 'gearPickup') and (getDistanceBetweenPoints3D(x, y, z, getElementPosition(v)) <= 2) then
            local order = getElementData(v, 'invOrder')
            if order then
                if (UTILS:getTableSize(order) < 21) then
                    return v
                end
            else
                return v
            end
        end
    end
    return false
end
-- //------------------- CHECK FOR NEAR SACKS -------------------\\--
-- //------------------- RESPAWN LOOT POINT -------------------\\--
function setupRespawn(ob)
    if ob and isElement(ob) then
        local x, y, z = getElementPosition(ob)
        local rx, ry, rz = getElementRotation(ob)
        local lootType = getElementData(ob, 'obName')

        local respawnTime = getPickupSetting(lootType, 'respawnTime')
        if not respawnTime then
            return false
        end

        local offX, offY, offZ, offRX, offRY, offRZ = getElementAttachedOffsets(ob)

        local respawnTime = math.random(respawnTime[1], respawnTime[2])
        setTimer(function(x, y, z, rx, ry, rz, lootType, parent, offX, offY, offZ, offRX, offRY, offRZ)
            local model = getPickupSetting(lootType, 'modelID')
            local loot = createObject(model, x, y, z, rx, ry, rz)
            setElementFrozen(loot, true)

            if string.find(lootType, 'barrel') then
                setElementData(loot, 'lootPickup', true)
                setElementData(loot, 'health', getPickupSetting(lootType, 'maxHealth') or 9999999)
                setElementData(loot, 'maxHealth', getPickupSetting(lootType, 'maxHealth') or 9999999)
            else
                setElementData(loot, 'lootBox', true)
                setElementData(loot, 'maxSlots', getPickupSetting(lootType, 'maxSlots') or 21)

                local loots = generateLootToGive(lootType)
                for k, v in ipairs(loots) do
                    setElementData(loot, v[1], (getElementData(loot, v[1]) or 0) + v[2])
                end
            end
            setElementData(loot, 'obName', lootType)

            if parent and isElement(parent) then
                setElementParent(loot, parent)
                if offX then
                    attachElements(loot, parent, offX, offY, offZ, offRX, offRY, offRZ)
                end
            end
        end, respawnTime, 1, x, y, z, rx, ry, rz, lootType, getElementParent(ob), offX, offY, offZ, offRX, offRY, offRZ)
    end
end
-- //------------------- RESPAWN LOOT POINT -------------------\\--
-- //------------------- ON OPEN BARREL -------------------\\--
local openingBarrels = {}
local barrelDamageCooldown = {}

local function openBarrel(player, ob)
    if not isElement(player) or getElementType(player) ~= 'player' or not isElement(ob) then return false end
    if not getElementData(ob, 'lootPickup') or openingBarrels[ob] then return false end

    local itemName = getElementData(ob, 'obName')
    if not itemName or type(possibleLoots[itemName]) ~= 'table' then return false end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 7 then return false end
    if (tonumber(getElementData(ob, 'health')) or 1) > 0 then return false end

    openingBarrels[ob] = true
    local loots = generateLootToGive(itemName)
    if #loots > 0 then createSack(ox, oy, oz - 0.35, loots, 'Loot') end
    triggerEvent('rust:play3DSound', player, 'barrel-destroy.mp3', ox, oy, oz, 0.5, 50)
    if exports['stoneage_economy'] then
        exports['stoneage_economy']:giveExp(player, math.random(2, 7))
    end
    setupRespawn(ob)
    destroyElement(ob)
    return true
end

-- Le serveur valide les dégâts : distance, outil équipé et cadence anti-spam.
addEvent('pickups:damageBarrel', true)
addEventHandler('pickups:damageBarrel', root, function(ob, requestedDamage)
    local player = client
    if not isElement(player) or source ~= player or not isElement(ob) then return end
    if not getElementData(ob, 'lootPickup') or openingBarrels[ob] then return end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 7 then return end

    local equippedItem = getElementData(player, 'equippedItem')
    local validTools = { Stone = true, Hatchet = true, Pickaxe = true, Chainsaw = true, JackHammer = true }
    if not validTools[equippedItem] then return end

    local now = getTickCount()
    barrelDamageCooldown[player] = barrelDamageCooldown[player] or {}
    local lastHit = barrelDamageCooldown[player][ob] or 0
    if now - lastHit < 350 then return end
    barrelDamageCooldown[player][ob] = now

    local damage = math.floor(tonumber(requestedDamage) or 0)
    damage = math.max(1, math.min(150, damage))
    local health = math.max(0, tonumber(getElementData(ob, 'health')) or tonumber(getElementData(ob, 'maxHealth')) or 1000)
    health = math.max(0, health - damage)
    setElementData(ob, 'health', health)

    if health <= 0 then openBarrel(player, ob) end
end)

-- Compatibilité avec l'ancien événement : impossible d'ouvrir un baril encore intact.
addEvent('pickups:onOpenBarrel', true)
addEventHandler('pickups:onOpenBarrel', root, function(ob)
    local player = client
    if not isElement(player) or source ~= player or not isElement(ob) then return end
    openBarrel(player, ob)
end)

-- //------------------- UTILS -------------------\\--
function getTimeToDestroySack()
    local settings = getSettings('timeToDestroySack')
    return math.random(settings.min, settings.max)
end
-- //------------------- UTILS -------------------\\--
function getSettings(settingName)
    return configs[settingName]
end

function getPickupSetting(lootName, configName)
    local lootSettings = getSettings('lootSettings')
    return lootSettings and lootSettings[lootName] and lootSettings[lootName][configName]
end
