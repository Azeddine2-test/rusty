loadEvent('rust:customKick', root, function(customMsg)
    local player = client or source
    if not isElement(player) or getElementType(player) ~= 'player' then
        return
    end
    -- A client may request only its own disconnect. Server-side anti-cheat calls
    -- use triggerEvent (client is nil) and may still disconnect the selected player.
    if isElement(client) and source ~= client then
        return
    end
    if type(customMsg) ~= 'string' then
        customMsg = 'Disconnected'
    end
    kickPlayer(player, customMsg:sub(1, 120))
end)

local lastGrenadeLauncherExplosion = {}
addEventHandler('onPlayerQuit', root, function()
    lastGrenadeLauncherExplosion[source] = nil
end)

loadEvent('rust:createGreandeLauncherExplosion', root, function(x, y, z)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or getElementData(player, 'equippedItem') ~= 'Grenade Launcher' then
        return
    end
    if type(x) ~= 'number' or type(y) ~= 'number' or type(z) ~= 'number'
        or x ~= x or y ~= y or z ~= z then
        return
    end
    local weaponSettings = getPlayerDataSetting('Grenade Launcher', 'weaponSettings')
    if type(weaponSettings) ~= 'table' or getPedWeapon(player) ~= weaponSettings.weapID then
        return
    end
    local px, py, pz = getElementPosition(player)
    local maxDistance = tonumber(weaponSettings.distance) or 0
    if maxDistance <= 0 or getDistanceBetweenPoints3D(px, py, pz, x, y, z) > maxDistance then
        return
    end
    local now = getTickCount()
    if lastGrenadeLauncherExplosion[player] and now - lastGrenadeLauncherExplosion[player] < 400 then
        return
    end
    lastGrenadeLauncherExplosion[player] = now
    createExplosion(x, y, z, 12, player)
end)

-- //------------------- LEVEL UP SYSTEM -------------------\\--
addEventHandler('onElementDataChange', root, function(key, old, new)
    if getElementType(source) == 'player' and tonumber(new) and tonumber(old) then
        if key == 'Exp' then
            local level = getElementData(source, 'Level') or 0
            if (new > old) and (new >= getExpNeeded(level)) then
                setElementData(source, 'Exp', 0)
                setElementData(source, 'Level', level + 1)
                exports['stoneage_notifications']:CreateNotification(source, '+1 Level', 'info')
            end
        elseif key == 'Level' then
            if new >= 5 and new < 10 then
                setPedFightingStyle(source, 7)
            elseif new >= 10 and new < 15 then
                setPedFightingStyle(source, 5)
            elseif new >= 15 then
                setPedFightingStyle(source, 6)
            end
        end
    end
end)
-- //------------------- LEVEL UP SYSTEM -------------------\\--

-- //------------------- Fill bottle from menu -------------------\\--
loadEvent('rust:fillBottleFromMenu', root, function(slotID)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or not getElementData(player, 'account')
        or not isElementInWater(player) then
        return
    end
    slotID = tonumber(slotID)
    if not slotID then return end
    slotID = math.floor(slotID)
    local order = getElementData(player, 'keybarOrder')
    local entry = type(order) == 'table' and order[slotID]
    if not entry or entry.itemName ~= 'Empty Bottle' or (tonumber(entry.quantity) or 0) <= 0
        or (tonumber(getElementData(player, 'Empty Bottle')) or 0) <= 0 then
        return
    end

    onPlayerDisequipItem(slotID, player)
    entry.itemName = 'Water'
    setElementData(player, 'Empty Bottle', getElementData(player, 'Empty Bottle') - 1)
    setElementData(player, 'Water', (getElementData(player, 'Water') or 0) + 1)
    setElementData(player, 'keybarOrder', order)
    triggerClientEvent(player, 'playerUseItem', player, 'Water', slotID)
end)
-- //------------------- Fill bottle from menu -------------------\\--

-- //------------------- LEARN BLUEPRINT -------------------\\--
loadEvent('rust:learnBlueprint', root, function(slotID, itemName)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or not getElementData(player, 'account') then
        return
    end
    slotID = tonumber(slotID)
    if not slotID or type(itemName) ~= 'string' or getItemType(itemName) ~= 'blueprint' then
        return
    end
    slotID = math.floor(slotID)
    local order = getElementData(player, 'keybarOrder')
    local entry = type(order) == 'table' and order[slotID]
    if not entry or entry.itemName ~= itemName or (tonumber(entry.quantity) or 0) <= 0
        or (tonumber(getElementData(player, itemName)) or 0) <= 0 then
        return
    end

    local alreadyLearned = getElementData(player, 'learnedBlueprint') or {}
    if alreadyLearned[itemName] then
        exports['stoneage_notifications']:CreateNotification(player, translate(player, 'já aprendeu blueprint'))
        return
    end

    alreadyLearned[itemName] = true
    setElementData(player, 'learnedBlueprint', alreadyLearned)
    local str = translate(player, 'acabou de aprender blueprint', nil, translate(player, itemName:gsub(':BLUEPRINT', ''), 'name'))
    exports['stoneage_notifications']:CreateNotification(player, str, 'info')

    entry.quantity = entry.quantity - 1
    if entry.quantity <= 0 then
        onPlayerDisequipItem(slotID, player)
        order[slotID] = nil
    end
    setElementData(player, itemName, math.max(0, (tonumber(getElementData(player, itemName)) or 0) - 1))
    setElementData(player, 'keybarOrder', order)
end)

loadEvent('rust:learnBlueprintFromInv', root, function(_, id)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or not getElementData(player, 'account') then
        return
    end
    id = tonumber(id)
    if not id then return end
    id = math.floor(id)
    if id < 1 or id > (tonumber(getElementData(player, 'maxSlots')) or 28) then return end

    local inventory = getElementData(player, 'invOrder') or {}
    local entry = inventory[id]
    local itemName = entry and entry.itemName
    if type(itemName) ~= 'string' or getItemType(itemName) ~= 'blueprint'
        or (tonumber(entry.quantity) or 0) <= 0 or (tonumber(getElementData(player, itemName)) or 0) <= 0 then
        return false
    end

    local alreadyLearned = getElementData(player, 'learnedBlueprint') or {}
    if alreadyLearned[itemName] then
        exports['stoneage_notifications']:CreateNotification(player, translate(player, 'já aprendeu blueprint'))
        return
    end

    alreadyLearned[itemName] = true
    setElementData(player, 'learnedBlueprint', alreadyLearned)
    setPreference(player, id, itemName, 1)
    setElementData(player, itemName, math.max(0, (tonumber(getElementData(player, itemName)) or 0) - 1))
    local str = translate(player, 'acabou de aprender blueprint', nil, translate(player, itemName:gsub(':BLUEPRINT', ''), 'name'))
    exports['stoneage_notifications']:CreateNotification(player, str, 'info')
end)
-- //------------------- LEARN BLUEPRINT -------------------\\--

