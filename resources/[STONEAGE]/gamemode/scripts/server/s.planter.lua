local settings = {
    offsetSlots = { -- slot offsets
        [1] = {0, 0, 0.5},
        [2] = {1.2, 0, 0.5},
        [3] = {-1.2, 0, 0.5},
    },
    plantSettings = {
        ['Seed Corn'] = {
            modelID = 2247,
            receive = 'Corn',
        },
        ['Seed Pumpkin'] = {
            modelID = 2250,
            receive = 'Pumpkin',
        },
        ['Seed Potato'] = {
            modelID = 2249,
            receive = 'Potato',
        },
    },
}

local plants = {}
local plantTimers = {}
local PLANT_MAX_SIZE = 2

-- //------------------- LOAD PLANTS FOR OBJECT -------------------\\--
function loadPlants(ob)
    if not isElement(ob) then
        return
    end

    local obName = getElementData(ob, 'obName')
    if obName ~= 'Planter' then
        return
    end

    local obPlants = getElementData(ob, 'planter:plants')

    if obPlants then
        for id, arr in pairs(obPlants) do
            local plant = createPlant(ob, id, arr.itemName, arr.progress)

            if plant then
                if not plants[ob] then
                    plants[ob] = {}
                end
                table.insert(plants[ob], id, plant)

                if arr.progress < 100 then
                    plantTimers[ob] = setTimer(function(ob, id)
                        updatePlantProgress(ob, id)
                    end, getGamePlayConfig('time to plants grow up'), (100 - arr.progress) / 10, ob, id)
                end
            end
        end
    end
end
-- //------------------- LOAD PLANTS FOR OBJECT -------------------\\--

-- //------------------- ON PLAYER PLANT -------------------\\--
loadEvent('planter:onPlayerPlant', root, function(ob, itemName)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(ob, 'obName') ~= 'Planter' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 5 then
        return
    end

    if not settings.plantSettings[itemName] then
        return
    end
    if getElementData(player, 'equippedItem') ~= 'Shovel' then
        return exports['stoneage_notifications']:CreateNotification(player, translate(player, 'Precisa ter %s em mãos', nil, translate(player, 'Shovel', 'name')), 'error')
    end
    if (getElementData(player, itemName) or 0) <= 0 then
        return
    end

    local plantsHere = getElementData(ob, 'planter:plants') or {}
    local usedSlot = getFreeSlotForPlant(plantsHere)
    if not usedSlot then
        return
    end

    local plant = createPlant(ob, usedSlot, itemName, 10)
    if not isElement(plant) then
        return
    end

    if not plants[ob] then
        plants[ob] = {}
    end
    plants[ob][usedSlot] = plant
    plantsHere[usedSlot] = {
        itemName = itemName,
        progress = 10,
    }
    setElementData(ob, 'planter:plants', plantsHere)

    setTimer(function(planter, id)
        updatePlantProgress(planter, id)
    end, getGamePlayConfig('time to plants grow up'), 10, ob, usedSlot)

    setElementData(player, itemName, (getElementData(player, itemName) or 0) - 1)
    setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false, 250, true)
end)

-- //------------------- ON PLAYER PICK PLANT -------------------\\--
loadEvent('planter:onPlayerPickPlant', root, function(ob, plantName)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(ob, 'obName') ~= 'Planter' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 5 then
        return
    end

    local plantsHere = getElementData(ob, 'planter:plants')
    if type(plantsHere) ~= 'table' or type(plantName) ~= 'string' then
        return
    end
    for slot, plantData in pairs(plantsHere) do
        if plantData.itemName == plantName and plantData.progress == 100 then
            if plants[ob] and isElement(plants[ob][slot]) then
                local receive = getPlantSetting(plantData.itemName, 'receive')
                if receive then
                    setElementData(player, receive, (getElementData(player, receive) or 0) + 1)
                end
                destroyElement(plants[ob][slot])
                plants[ob][slot] = nil
                plantsHere[slot] = nil
                setElementData(ob, 'planter:plants', plantsHere)
                setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false, 250, true)
                break
            end
        end
    end
end)

-- //------------------- UPDATE PROGRESS -------------------\\--
function updatePlantProgress(ob, slot)
    if isElement(ob) then
        local plantsHere = getElementData(ob, 'planter:plants')
        local arr = plantsHere and plantsHere[slot]
        if arr then
            if plants[ob] and isElement(plants[ob][slot]) then
                if arr.progress + 10 <= 100 then
                    plantsHere[slot].progress = arr.progress + 10
                    setObjectScale(plants[ob][slot], (plantsHere[slot].progress / 100) * PLANT_MAX_SIZE)
                    setElementData(ob, 'planter:plants', plantsHere)
                end
            end

            local foundIncomplete
            for k, v in pairs(getElementData(ob, 'planter:plants')) do
                if v.progress < 100 then
                    foundIncomplete = true
                    break
                end
            end

            if not foundIncomplete then
                if plantTimers[ob] then
                    if isTimer(plantTimers[ob]) then
                        killTimer(plantTimers[ob])
                    end
                    plantTimers[ob] = nil
                end
            end
        end
    else
        if sourceTimer and isTimer(sourceTimer) then
            killTimer(sourceTimer)
        end
    end
end
-- //------------------- UPDATE PROGRESS -------------------\\--

-- addCommandHandler('resetplants', function()
--     for k, v in pairs(plants) do
--         setElementData(k, 'planter:plants', nil)
--     end
-- end)

-- //------------------- CREATE PLANT -------------------\\--
function createPlant(ob, slot, plantName, progress)
    local modelID = getPlantSetting(plantName, 'modelID')
    local offx, offy, offz = getPlantOffsets(slot)
    if modelID and offx then
        local x, y, z = getElementPosition(ob)
        local plant = createObject(modelID, x + offx, y + offy, z + offz)

        attachElements(plant, ob, offx, offy, offz, 0, 0, math.random(360))
        setElementCollisionsEnabled(plant, false)
        setElementParent(plant, ob)

        local size = (progress / 100) * PLANT_MAX_SIZE

        setObjectScale(plant, size)
        return plant
    end
    return false
end
-- //------------------- CREATE PLANT -------------------\\--

-- //------------------- UTILS -------------------\\--
getFreeSlotForPlant = function(arr)
    for i = 1, 3 do
        if not arr[i] then
            return i
        end
    end
    return false
end

getPlantSetting = function(plantName, settingName)
    if settings.plantSettings[plantName] then
        return settings.plantSettings[plantName][settingName] or false
    end
    return false
end

getPlantOffsets = function(id)
    if settings.offsetSlots[id] then
        return unpack(settings.offsetSlots[id])
    end
    return false
end
-- //------------------- UTILS -------------------\\--
