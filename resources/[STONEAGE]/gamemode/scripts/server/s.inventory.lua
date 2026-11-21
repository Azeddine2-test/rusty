-- Rebuilt inventory synchronization: item element-data changes must update
-- the slot order used by the client inventory and loot UI.
IS_STILL_LOADING = IS_STILL_LOADING or {}
local inventoryPreferences = {}

local function inventorySlotLimit(element)
    local limit = tonumber(getElementData(element, "maxSlots")) or 0
    if limit <= 0 then limit = getElementType(element) == "player" and 28 or 21 end
    return math.max(1, math.floor(limit))
end

local function inventoryStackLimit(itemName)
    local limit = tonumber(getItemMaxStack(itemName)) or 0
    if limit <= 0 then
        local settings = getPlayerDataSetting(itemName, "invSettings")
        limit = type(settings) == "table" and tonumber(settings.maxStack) or 1
    end
    return math.max(1, math.floor(limit))
end

local function updateInventoryOrder(element, itemName, oldValue, newValue)
    local oldCount = math.max(0, tonumber(oldValue) or 0)
    local newCount = math.max(0, tonumber(newValue) or 0)
    local delta = newCount - oldCount
    if delta == 0 then return end

    local order = getElementData(element, "invOrder")
    if type(order) ~= "table" then order = {} end
    local preference = inventoryPreferences[element] and inventoryPreferences[element][itemName]

    if delta > 0 then
        local remaining = delta
        local stackLimit = inventoryStackLimit(itemName)
        if preference and tonumber(preference.id) then
            local slot = math.floor(tonumber(preference.id))
            local entry = order[slot]
            if entry and entry.itemName == itemName then
                local wanted = math.min(remaining, tonumber(preference.quantity) or remaining)
                local moved = math.min(wanted, math.max(0, stackLimit - (tonumber(entry.quantity) or 0)))
                entry.quantity = (tonumber(entry.quantity) or 0) + moved
                remaining = remaining - moved
            elseif not entry and slot >= 1 and slot <= inventorySlotLimit(element) then
                local moved = math.min(remaining, tonumber(preference.quantity) or remaining, stackLimit)
                if moved > 0 then
                    order[slot] = {itemName = itemName, quantity = moved}
                    remaining = remaining - moved
                end
            end
        end
        for slot, entry in pairs(order) do
            if remaining <= 0 then break end
            if type(entry) == "table" and entry.itemName == itemName then
                local moved = math.min(remaining, math.max(0, stackLimit - (tonumber(entry.quantity) or 0)))
                entry.quantity = (tonumber(entry.quantity) or 0) + moved
                remaining = remaining - moved
            end
        end
        local maxSlots = inventorySlotLimit(element)
        for slot = 1, maxSlots do
            if remaining <= 0 then break end
            if not order[slot] then
                local moved = math.min(remaining, stackLimit)
                order[slot] = {itemName = itemName, quantity = moved}
                remaining = remaining - moved
            end
        end
    else
        local remaining = -delta
        if preference and tonumber(preference.id) then
            local slot = math.floor(tonumber(preference.id))
            local entry = order[slot]
            if entry and entry.itemName == itemName then
                local wanted = math.min(remaining, tonumber(preference.quantity) or remaining)
                local moved = math.min(wanted, tonumber(entry.quantity) or 0)
                entry.quantity = (tonumber(entry.quantity) or 0) - moved
                remaining = remaining - moved
                if entry.quantity <= 0 then order[slot] = nil end
            end
        end
        for slot, entry in pairs(order) do
            if remaining <= 0 then break end
            if type(entry) == "table" and entry.itemName == itemName then
                local moved = math.min(remaining, tonumber(entry.quantity) or 0)
                entry.quantity = (tonumber(entry.quantity) or 0) - moved
                remaining = remaining - moved
                if entry.quantity <= 0 then order[slot] = nil end
            end
        end
    end

    if inventoryPreferences[element] then
        inventoryPreferences[element][itemName] = nil
        if not next(inventoryPreferences[element]) then inventoryPreferences[element] = nil end
    end
    setElementData(element, "invOrder", order)
end

addEventHandler("onElementDataChange", root, function(dataName, oldValue)
    if IS_STILL_LOADING[source] then return end
    local newValue = getElementData(source, dataName)
    local elementType = getElementType(source)
    if elementType ~= "player" and elementType ~= "object" and elementType ~= "vehicle" then return end
    if elementType == "player" and not getElementData(source, "account") then return end
    if elementType == "object" and getElementData(source, "obName") == "farmObject" then return end
    if not isItemOfInventory(dataName) then return end
    updateInventoryOrder(source, dataName, oldValue, newValue)
end)

function setPreference(element, slotID, itemName, quantity)
    if not isElement(element) or type(itemName) ~= "string" then return false end
    slotID = tonumber(slotID)
    quantity = tonumber(quantity)
    if not slotID or slotID < 1 or not quantity or quantity <= 0 then return false end
    inventoryPreferences[element] = inventoryPreferences[element] or {}
    inventoryPreferences[element][itemName] = {
        id = math.floor(slotID),
        quantity = math.floor(quantity),
    }
    return true
end

function getPreference(element, itemName)
    local preferences = inventoryPreferences[element]
    if not preferences or not preferences[itemName] then return {} end
    local result = preferences[itemName]
    preferences[itemName] = nil
    if not next(preferences) then inventoryPreferences[element] = nil end
    return result
end


-- Inventory slot movement. All changes are validated server-side before syncing.
local function copyInventoryEntry(entry)
    if type(entry) ~= "table" then return nil end
    return { itemName = entry.itemName, quantity = math.floor(tonumber(entry.quantity) or 0) }
end

local function validLootContainer(player, container)
    if not isElement(container) or getElementType(container) ~= "object" then return false end
    if getElementData(container, "obName") == "farmObject" then return false end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(container)
    return getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) <= 10
end

local function syncInventorySlots(player, inventoryType, firstSlot, secondSlot)
    triggerClientEvent(player, "receiveMoveSync", player, inventoryType, firstSlot)
    if secondSlot then
        triggerClientEvent(player, "receiveMoveSync", player, inventoryType, secondSlot)
    end
end

local function syncAllInventorySlots(player, inventoryType, container)
    local limit = inventorySlotLimit(container)
    for slot = 1, limit do
        triggerClientEvent(player, "receiveMoveSync", player, inventoryType, slot)
    end
end

addEvent("inv:moveItem", true)
addEventHandler("inv:moveItem", root, function(container, fromSlot, toSlot, inventoryType)
    local player = client
    if not isElement(player) or source ~= player then return end
    if inventoryType ~= "inv" and inventoryType ~= "loot" then return end
    if inventoryType == "inv" then
        if container ~= player then return end
    elseif not validLootContainer(player, container) then
        return
    end

    fromSlot, toSlot = tonumber(fromSlot), tonumber(toSlot)
    if not fromSlot or not toSlot or fromSlot < 1 or toSlot < 1 then return end
    fromSlot, toSlot = math.floor(fromSlot), math.floor(toSlot)
    local order = getElementData(container, "invOrder")
    if type(order) ~= "table" or fromSlot == toSlot then return end
    local sourceEntry = copyInventoryEntry(order[fromSlot])
    if not sourceEntry or sourceEntry.quantity <= 0 then return end

    local maxSlots = inventoryType == "inv"
        and (tonumber(getElementData(player, "maxSlots")) or 28)
        or (tonumber(getElementData(container, "maxSlots")) or 21)
    if toSlot > maxSlots then return end

    order[fromSlot], order[toSlot] = order[toSlot], order[fromSlot]
    setElementData(container, "invOrder", order)
    syncInventorySlots(player, inventoryType, fromSlot, toSlot)
end)

addEvent("inv:putItemOnKeybar", true)
addEventHandler("inv:putItemOnKeybar", root, function(itemName, quantity, fromSlot, toSlot, sourceType, targetType)
    local player = client
    if not isElement(player) or source ~= player or sourceType ~= "inv" or targetType ~= "keybar" then return end
    fromSlot, toSlot = tonumber(fromSlot), tonumber(toSlot)
    if type(itemName) ~= "string" or not fromSlot or not toSlot then return end
    fromSlot, toSlot = math.floor(fromSlot), math.floor(toSlot)
    if fromSlot < 1 or fromSlot > inventorySlotLimit(player) or toSlot < 1 or toSlot > 7 then return end

    local inventory = getElementData(player, "invOrder")
    local keybar = getElementData(player, "keybarOrder")
    if type(inventory) ~= "table" then return end
    if type(keybar) ~= "table" then keybar = {} end
    local entry = copyInventoryEntry(inventory[fromSlot])
    if not entry or entry.itemName ~= itemName or entry.quantity <= 0 then return end

    local oldKeybarEntry = copyInventoryEntry(keybar[toSlot])
    keybar[toSlot] = entry
    inventory[fromSlot] = oldKeybarEntry
    setElementData(player, "invOrder", inventory)
    setElementData(player, "keybarOrder", keybar)
    syncInventorySlots(player, "inv", fromSlot)
    triggerClientEvent(player, "receiveMoveSync", player, "keybar", toSlot)
end)

addEvent("inv:removeItemFromKeyBar", true)
addEventHandler("inv:removeItemFromKeyBar", root, function(fromSlot, toSlot, targetElement, sourceType, targetType)
    local player = client
    if not isElement(player) or source ~= player or targetElement ~= player
        or sourceType ~= "keybar" or targetType ~= "inv" then return end
    fromSlot, toSlot = tonumber(fromSlot), tonumber(toSlot)
    if not fromSlot or not toSlot then return end
    fromSlot, toSlot = math.floor(fromSlot), math.floor(toSlot)
    if fromSlot < 1 or fromSlot > 7 or toSlot < 1 or toSlot > inventorySlotLimit(player) then return end

    local keybar = getElementData(player, "keybarOrder")
    local inventory = getElementData(player, "invOrder")
    if type(keybar) ~= "table" or type(inventory) ~= "table" then return end
    local entry = copyInventoryEntry(keybar[fromSlot])
    if not entry or entry.quantity <= 0 then return end

    keybar[fromSlot] = copyInventoryEntry(inventory[toSlot])
    inventory[toSlot] = entry
    setElementData(player, "keybarOrder", keybar)
    setElementData(player, "invOrder", inventory)
    triggerClientEvent(player, "receiveMoveSync", player, "keybar", fromSlot)
    triggerClientEvent(player, "receiveMoveSync", player, "inv", toSlot)
end)

addEvent("inv:moveItemOnKeyBar", true)
addEventHandler("inv:moveItemOnKeyBar", root, function(fromSlot, toSlot)
    local player = client
    if not isElement(player) or source ~= player then return end
    fromSlot, toSlot = tonumber(fromSlot), tonumber(toSlot)
    if not fromSlot or not toSlot then return end
    fromSlot, toSlot = math.floor(fromSlot), math.floor(toSlot)
    if fromSlot < 1 or fromSlot > 7 or toSlot < 1 or toSlot > 7 then return end
    local keybar = getElementData(player, "keybarOrder")
    if type(keybar) ~= "table" or not keybar[fromSlot] then return end
    keybar[fromSlot], keybar[toSlot] = keybar[toSlot], keybar[fromSlot]
    setElementData(player, "keybarOrder", keybar)
    triggerClientEvent(player, "receiveMoveSync", player, "keybar", fromSlot)
    triggerClientEvent(player, "receiveMoveSync", player, "keybar", toSlot)
end)

-- Transfer loot from a container into the player's real inventory.
addEvent("inv:takeItem", true)
addEventHandler("inv:takeItem", root, function(container, targetSlot, sourceSlot, sourceType, targetType)
    local player = client
    if not isElement(player) or source ~= player then return end
    if sourceType ~= "loot" or (targetType ~= nil and targetType ~= "inv") then return end
    if not isElement(container) or getElementType(container) ~= "object" then return end
    if container == player or getElementData(container, "obName") == "farmObject" then return end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(container)
    if getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 10 then return end

    sourceSlot = tonumber(sourceSlot)
    targetSlot = tonumber(targetSlot)
    if not sourceSlot or sourceSlot < 1 then return end

    local sourceOrder = getElementData(container, "invOrder")
    if type(sourceOrder) ~= "table" then return end
    local entry = sourceOrder[sourceSlot]
    if type(entry) ~= "table" or type(entry.itemName) ~= "string" then return end

    local itemName = entry.itemName
    local quantity = math.floor(tonumber(entry.quantity) or 0)
    local containerQuantity = math.floor(tonumber(getElementData(container, itemName)) or 0)
    if quantity <= 0 or containerQuantity <= 0 then return end
    quantity = math.min(quantity, containerQuantity)

    local playerOrder = getElementData(player, "invOrder")
    if type(playerOrder) ~= "table" then playerOrder = {} end
    local maxSlots = math.max(1, tonumber(getElementData(player, "maxSlots")) or 28)
    local maxStack = math.max(1, tonumber(getItemMaxStack(itemName)) or 1)
    local capacity = 0
    local usedSlots = 0
    for _, item in pairs(playerOrder) do
        if type(item) == "table" then
            usedSlots = usedSlots + 1
            if item.itemName == itemName then
                capacity = capacity + math.max(0, maxStack - (tonumber(item.quantity) or 0))
            end
        end
    end
    capacity = capacity + math.max(0, maxSlots - usedSlots) * maxStack
    if capacity < quantity then
        triggerClientEvent(player, "receiveMoveSync", player, "loot", sourceSlot)
        if targetSlot then triggerClientEvent(player, "receiveMoveSync", player, "inv", targetSlot) end
        return
    end

    if targetSlot then setPreference(player, targetSlot, itemName, quantity) end
    setPreference(container, sourceSlot, itemName, quantity)

    setElementData(container, itemName, math.max(0, containerQuantity - quantity))
    setElementData(player, itemName, (tonumber(getElementData(player, itemName)) or 0) + quantity)

    syncAllInventorySlots(player, "loot", container)
    syncAllInventorySlots(player, "inv", player)
end)

-- Secure server-side drop/transfer handler. The client only supplies slot IDs;
-- item names and quantities are always read from authoritative server element-data.
addEvent("inv:dropItem", true)
addEventHandler("inv:dropItem", root, function(fromSlot, targetSlot, lootObject, sourceType, targetType)
    local player = client
    if not isElement(player) or source ~= player or sourceType ~= "inv" then return end
    if getElementData(player, "isDead") or not getElementData(player, "account") then return end

    fromSlot = tonumber(fromSlot)
    if not fromSlot then return end
    fromSlot = math.floor(fromSlot)
    if fromSlot < 1 or fromSlot > inventorySlotLimit(player) then return end

    local order = getElementData(player, "invOrder")
    local entry = type(order) == "table" and order[fromSlot]
    if type(entry) ~= "table" or type(entry.itemName) ~= "string" then return end
    local itemName = entry.itemName
    local quantity = math.floor(tonumber(entry.quantity) or 0)
    local owned = math.floor(tonumber(getElementData(player, itemName)) or 0)
    if quantity <= 0 or owned <= 0 then return end
    quantity = math.min(quantity, owned)

    if targetType == "loot" or isElement(lootObject) then
        if not validLootContainer(player, lootObject) then return end
        local containerName = getElementData(lootObject, "obName")
        if containerName == "Fornalha" and not getItemFurnanceSettings(itemName) then return end
        if containerName == "Mesa de pesquisa" then return end
        local maxSlots = math.max(1, tonumber(getElementData(lootObject, "maxSlots")) or 21)
        local lootOrder = getElementData(lootObject, "invOrder")
        if type(lootOrder) ~= "table" then lootOrder = {} end
        local used, stackRoom = 0, 0
        local stackLimit = inventoryStackLimit(itemName)
        for _, current in pairs(lootOrder) do
            if type(current) == "table" then
                used = used + 1
                if current.itemName == itemName then
                    stackRoom = stackRoom + math.max(0, stackLimit - (tonumber(current.quantity) or 0))
                end
            end
        end
        if stackRoom + math.max(0, maxSlots - used) * stackLimit < quantity then
            triggerClientEvent(player, "receiveMoveSync", player, "inv", fromSlot)
            return
        end
        targetSlot = tonumber(targetSlot)
        if targetSlot and targetSlot >= 1 and targetSlot <= maxSlots then
            setPreference(lootObject, targetSlot, itemName, quantity)
        end
        setPreference(player, fromSlot, itemName, quantity)
        setElementData(lootObject, itemName, (tonumber(getElementData(lootObject, itemName)) or 0) + quantity)
        setElementData(player, itemName, math.max(0, owned - quantity))
        syncAllInventorySlots(player, "inv", player)
        syncAllInventorySlots(player, "loot", lootObject)
        return
    end

    local x, y, z = getElementPosition(player)
    local sack = exports.stoneage_pickups:createSack(x, y, z - 0.8, {{itemName, quantity}}, "Loot")
    if not isElement(sack) then
        triggerClientEvent(player, "receiveMoveSync", player, "inv", fromSlot)
        return
    end

    setPreference(player, fromSlot, itemName, quantity)
    setElementData(player, itemName, math.max(0, owned - quantity))
    syncAllInventorySlots(player, "inv", player)
end)

function onPlayerEquipItem(slotID, player)
    player = player or source
    if not isElement(player) or getElementType(player) ~= "player" then return false end

    slotID = tonumber(slotID)
    if not slotID then return false end
    slotID = math.floor(slotID)

    local keybar = getElementData(player, "keybarOrder")
    local entry = type(keybar) == "table" and keybar[slotID]
    if type(entry) ~= "table" or type(entry.itemName) ~= "string" then return false end

    local itemName = entry.itemName
    if (tonumber(getElementData(player, itemName)) or 0) <= 0 then return false end

    -- Remove the previously held object/weapon before attaching the next hotbar item.
    local previousItem = getElementData(player, "equippedItem")
    if previousItem and type(onPlayerDisequipItem) == "function" then
        onPlayerDisequipItem(getElementData(player, "equippedSlotID"), player)
    end

    local weapon = getPlayerDataSetting(itemName, "weaponSettings")
    local ammoSettings = getPlayerDataSetting(itemName, "ammo")
    if type(weapon) == "table" and tonumber(weapon.weapID) then
        local ammo = 0
        if weapon.type == "melee" or getItemType(itemName) == "weapon-melee" then
            ammo = 1
        elseif type(ammoSettings) == "table" and type(ammoSettings.name) == "string" then
            ammo = math.max(0, tonumber(getElementData(player, ammoSettings.name)) or 0)
            if ammo <= 0 then
                exports.stoneage_notifications:CreateNotification(
                    player,
                    translate(player, "precisa de munição", nil, translate(player, ammoSettings.name, "name")),
                    "error"
                )
                return false
            end
        end

        takeAllWeapons(player)
        if not giveWeapon(player, tonumber(weapon.weapID), ammo, true) then return false end
        if weapon.slotID then setPedWeaponSlot(player, tonumber(weapon.slotID)) end
        if type(detachWeaponFromBone) == "function" then
            detachWeaponFromBone(getItemType(itemName), player)
        end
    elseif getPlayerDataSetting(itemName, "clothSettings") then
        applyClothes(player, itemName)
    end

    if getItemType(itemName) == "defenseItem" and type(attachDefenseToBody) == "function" then
        attachDefenseToBody(itemName, player)
    end
    if type(attachItemToBone) == "function" then attachItemToBone(itemName, player) end
    if itemName == "Torch" then
        setPedWalkingStyle(player, 127)
    end

    setElementData(player, "equippedItem", itemName)
    setElementData(player, "equippedSlotID", slotID)
    triggerClientEvent(player, "rust:onClientPlayerEquipItem", player, itemName, slotID)
    return true
end
-- Event is registered by s.player.lua, which validates the originating client.

function onPlayerDisequipItem(_ARG_0_, _ARG_1_)
  _ARG_1_ = _ARG_1_ or source
  if type((getElementData(_ARG_1_, "keybarOrder"))) ~= "table" then
    return false
  end
  if not (getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) then
    return false
  end
  if isWeapon(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) then
    local player = _ARG_1_
    local itemName = getElementData(player, "keybarOrder")[_ARG_0_].itemName
    setTimer(function()
      if not isElement(player) then return end
      takeAllWeapons(player)
      detachItemFromBone(itemName, player)
      attachWeaponToBody(itemName, player)
    end, 180, 1)
  else
    detachItemFromBone(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, _ARG_1_)
  end
  if (getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) == "Torch" then
    setPedWalkingStyle(_ARG_1_, 0)
  end
  triggerClientEvent(_ARG_1_, "inv:disequipCurrentKeybarItem", _ARG_1_)
  triggerClientEvent(root, "rust:onClientPlayerDisequipItem", _ARG_1_, getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, getElementData(_ARG_1_, "equippedSlotID"))
  setElementData(_ARG_1_, "equippedItem", nil)
  setElementData(_ARG_1_, "equippedSlotID", nil)
end
loadEvent("rust:onPlayerDisequipItem", root, onPlayerDisequipItem)
function playerUseDefenseItem(_ARG_0_, _ARG_1_)
  if not isElement(_ARG_0_) then
    return
  end
  if _ARG_1_ == "Radial" then
    setElementModel(_ARG_0_, 73)
  elseif _ARG_1_ == "Vest" then
    setElementData(_ARG_0_, "vest_health", 6500)
    setElementData(_ARG_0_, ("%s_used"):format(_ARG_1_), true)
    attachDefenseToBody(_ARG_1_, _ARG_0_)
  elseif _ARG_1_ == "Mask" or _ARG_1_ == "Helmet" then
    setElementData(_ARG_0_, ("%s_used"):format(_ARG_1_), true)
    attachDefenseToBody(_ARG_1_, _ARG_0_)
  end
end
function playerRemoveDefenseItem(_ARG_0_, _ARG_1_)
  if not isElement(_ARG_0_) then
    return
  end
  if _ARG_1_ == "Radial" then
    setElementModel(_ARG_0_, 0)
  elseif _ARG_1_ == "Vest" then
    setElementData(_ARG_0_, "vest_health", nil)
    setElementData(_ARG_0_, ("%s_used"):format(_ARG_1_), nil)
    detachDefenseFromBone(_ARG_1_, _ARG_0_)
  elseif _ARG_1_ == "Mask" or _ARG_1_ == "Helmet" then
    setElementData(_ARG_0_, ("%s_used"):format(_ARG_1_), nil)
    detachDefenseFromBone(_ARG_1_, _ARG_0_)
  end
end
loadEvent("removeDefenseItemOnDestroy", root, function(_ARG_0_, _ARG_1_)
  if not isElement(_ARG_0_) then
    return false
  end
  if type((getElementData(_ARG_0_, "pedSideOrder"))) ~= "table" then
    return false
  end
  for _FORV_6_, _FORV_7_ in pairs((getElementData(_ARG_0_, "pedSideOrder"))) do
    if _FORV_7_.itemName == _ARG_1_ then
      playerRemoveDefenseItem(_ARG_0_, _ARG_1_)
      getElementData(_ARG_0_, "pedSideOrder")[_FORV_6_] = nil
      setElementData(_ARG_0_, "pedSideOrder", (getElementData(_ARG_0_, "pedSideOrder")))
      break
    end
  end
end)
loadEvent("rust:onAmmoChange", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  _ARG_1_ = _ARG_1_ or 0
  if 0 < _ARG_1_ then
    setWeaponAmmo(source, _ARG_0_, _ARG_1_)
    setPedWeaponSlot(source, _ARG_2_)
    if getPedAmmoInClip(source) == 0 then
      reloadPedWeapon(source)
    end
  else
    takeAllWeapons(source)
  end
end)
loadEvent("rust:onPlayerConsumeItem", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) then
    return false
  end
  if (getElementData(source, (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) or 0) <= 0 and not _ARG_2_ then
    return
  end
  if getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "food" or getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "drink" then
    if ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Meat Cooked" then
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Corn" then
      if math.random(100) <= 25 then
      end
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Potato" then
      if math.random(100) <= 25 then
      end
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Pumpkin" then
      if math.random(100) <= 25 then
      end
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Beans Can" then
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Water" then
    elseif ((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "Apple" then
      setElementData(source, "sede", math.min((getElementData(source, "sede") or 0) + math.random(2, 7), 100))
    end
    if _ARG_2_ then
      if not getElementData(source, "keybarOrder") or not getElementData(source, "keybarOrder")[_ARG_1_] then
        return false
      end
      getElementData(source, "keybarOrder")[_ARG_1_].quantity = getElementData(source, "keybarOrder")[_ARG_1_].quantity - 1
      if 0 >= getElementData(source, "keybarOrder")[_ARG_1_].quantity then
        getElementData(source, "keybarOrder")[_ARG_1_] = nil
        onPlayerDisequipItem(_ARG_1_, source)
      end
      if "Empty Bottle" and not getElementData(source, "keybarOrder")[_ARG_1_] then
        getElementData(source, "keybarOrder")[_ARG_1_] = {
          itemName = "Empty Bottle",
          quantity = 1
        }
        setElementData(source, "keybarOrder", (getElementData(source, "keybarOrder")))
        triggerClientEvent(source, "playerUseItem", source, "Empty Bottle", _ARG_1_)
      end
      setElementData(source, "keybarOrder", (getElementData(source, "keybarOrder")))
    else
      setPreference(source, _ARG_1_, (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName, 1)
      setElementData(source, (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName, (getElementData(source, (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) or 0) - 1)
      if "Empty Bottle" then
        setPreference(source, _ARG_1_, "Empty Bottle", 1)
        setElementData(source, "Empty Bottle", (getElementData(source, "Empty Bottle") or 0) + 1)
      end
    end
    setElementData(source, "blood", (math.min((getElementData(source, "blood") or 0) + math.random(200, 300), getPlayerDataSetting("blood", "max"))))
    setElementData(source, getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "food" and "fome" or "sede", math.min(100, (getElementData(source, getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "food" and "fome" or "sede") or 0) + math.random(5, 10)))
    if not isElementInWater(source) then
      if getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "food" then
        setPedAnimation(source, "food", "eat_burger", -1, false, false, false, false)
      elseif getItemType((_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder")) and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_] and (_ARG_2_ and getElementData(source, "keybarOrder") or getElementData(source, "invOrder"))[_ARG_1_].itemName) == "drink" then
        setPedAnimation(source, "vending", "vend_drink2_p", -1, false, false, false, false)
      end
    end
  end
  if not _ARG_2_ then
    triggerClientEvent(source, "receiveMoveSync", source, "inv", _ARG_1_)
  end
end)
loadEvent("rust:onPlayerConsumeMedicament", root, function(_ARG_0_, _ARG_1_, _ARG_2_)
  if not isElement(_ARG_0_) then
    return
  end
  if not getElementData(source, "keybarOrder") or not getElementData(source, "keybarOrder")[_ARG_2_] then
    return false
  end
  if (getElementData(source, "keybarOrder")[_ARG_2_].quantity or 0) <= 0 then
    return false
  end
  if _ARG_1_ == "Morphine" then
    removeElementData(_ARG_0_, "brokenbone")
  elseif _ARG_1_ == "Bandage" then
    setElementData(_ARG_0_, "bleeding", 0)
    setElementData(_ARG_0_, "blood", (math.min(getPlayerDataSetting("blood", "max"), (getElementData(_ARG_0_, "blood") or 0) + math.random(300, 500))))
  elseif _ARG_1_ == "Blood Kit" then
    setElementData(_ARG_0_, "blood", (math.min(getPlayerDataSetting("blood", "max"), (getElementData(_ARG_0_, "blood") or 0) + math.random(5000, 6000))))
  elseif _ARG_1_ == "Frist Aid" then
    setElementData(_ARG_0_, "blood", (math.min(getPlayerDataSetting("blood", "max"), (getElementData(_ARG_0_, "blood") or 0) + math.random(3000, 4000))))
    setElementData(_ARG_0_, "bleeding", 0)
    removeElementData(_ARG_0_, "brokenbone")
  end
  getElementData(source, "keybarOrder")[_ARG_2_].quantity = getElementData(source, "keybarOrder")[_ARG_2_].quantity - 1
  if getElementData(source, "keybarOrder")[_ARG_2_].quantity <= 0 then
    onPlayerDisequipItem(_ARG_2_, source)
    getElementData(source, "keybarOrder")[_ARG_2_] = nil
  end
  setElementData(source, "keybarOrder", (getElementData(source, "keybarOrder")))
  setPedAnimation(source, "bomber", "bom_plant", -1, false, false, false, false)
end)
loadEvent("inv:fillBottle", root, function(_ARG_0_)
  if not isElement(source) then
    return
  end
  if not getElementData(source, "invOrder") or not getElementData(source, "invOrder")[_ARG_0_] then
    return
  end
  setPreference(source, _ARG_0_, "Empty Bottle", 1)
  setElementData(source, "Empty Bottle", (getElementData(source, "Empty Bottle") or 0) - 1)
  setPreference(source, _ARG_0_, "Water", 1)
  setElementData(source, "Water", (getElementData(source, "Water") or 0) + 1)
end)
