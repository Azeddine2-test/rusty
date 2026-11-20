-- Reconstructed server-side inventory operations.
-- All client requests are validated against the requesting player and live element data.

local ORDER_KEYS = { inv = "invOrder", loot = "invOrder", keybar = "keybarOrder", pedSide = "pedSideOrder" }

local function playerIsValid(player)
    return isElement(player) and getElementType(player) == "player"
        and not getElementData(player, "isDead") and getElementData(player, "account") ~= nil
end

local function getOrder(element, kind)
    if not isElement(element) or not ORDER_KEYS[kind] then return {} end
    local value = getElementData(element, ORDER_KEYS[kind])
    return type(value) == "table" and value or {}
end

local function putOrder(element, kind, order)
    if not isElement(element) or not ORDER_KEYS[kind] then return false end
    setElementData(element, ORDER_KEYS[kind], order)
    return true
end

local function getContainer(player, object)
    if not isElement(object) or getElementType(object) ~= "object" then return false end
    if not getElementData(object, "obName") or not getElementData(object, "maxSlots") then return false end
    if getDistanceBetweenPoints3D(player, object) > 6 then return false end

    local owner = getElementData(object, "owner")
    local account = getElementData(player, "account")
    if owner and owner ~= account then
        local ownerPlayer = getAccountPlayer(owner)
        local ownerGroup = ownerPlayer and getElementData(ownerPlayer, "Group") or GetAccountData(owner, "Group")
        local playerGroup = getElementData(player, "Group")
        if not ownerGroup or ownerGroup ~= playerGroup then return false end
    end
    return true
end

local function itemCount(element, itemName)
    return math.max(0, tonumber(getElementData(element, itemName)) or 0)
end

local function changeItemCount(element, itemName, delta)
    if not isElement(element) or type(itemName) ~= "string" then return false end
    local nextValue = math.max(0, itemCount(element, itemName) + delta)
    if nextValue > 0 then setElementData(element, itemName, nextValue) else removeElementData(element, itemName) end
    return true
end

local function freeSlot(element, kind, preferred)
    return getInventoryFreeSlot(element, kind, preferred)
end

local function setEntry(element, kind, slot, entry)
    local order = getOrder(element, kind)
    if entry and type(entry) == "table" and entry.quantity > 0 then
        order[slot] = { itemName = entry.itemName, quantity = math.floor(entry.quantity) }
    else
        order[slot] = nil
    end
    return putOrder(element, kind, order)
end

local function transfer(player, fromElement, fromKind, fromSlot, toElement, toKind, toSlot)
    if not playerIsValid(player) or not isElement(fromElement) or not isElement(toElement) then return false end
    if fromKind == "loot" and not getContainer(player, fromElement) then return false end
    if toKind == "loot" and not getContainer(player, toElement) then return false end

    fromSlot, toSlot = tonumber(fromSlot), tonumber(toSlot)
    if not fromSlot then return false end
    local fromOrder, toOrder = getOrder(fromElement, fromKind), getOrder(toElement, toKind)
    local sourceEntry = fromOrder[fromSlot]
    if type(sourceEntry) ~= "table" or type(sourceEntry.itemName) ~= "string" then return false end

    if not toSlot then toSlot = freeSlot(toElement, toKind) end
    if not toSlot then return false end

    local destinationEntry = toOrder[toSlot]
    if destinationEntry and destinationEntry.itemName == sourceEntry.itemName then
        local maxStack = getItemMaxStack(sourceEntry.itemName)
        local room = math.max(0, maxStack - (tonumber(destinationEntry.quantity) or 0))
        local moved = math.min(room, tonumber(sourceEntry.quantity) or 0)
        if moved <= 0 then return false end
        destinationEntry.quantity = destinationEntry.quantity + moved
        sourceEntry.quantity = sourceEntry.quantity - moved
        if sourceEntry.quantity <= 0 then fromOrder[fromSlot] = nil end
    elseif destinationEntry then
        fromOrder[fromSlot], toOrder[toSlot] = destinationEntry, sourceEntry
    else
        toOrder[toSlot] = sourceEntry
        fromOrder[fromSlot] = nil
    end

    putOrder(fromElement, fromKind, fromOrder)
    if fromElement ~= toElement or fromKind ~= toKind then putOrder(toElement, toKind, toOrder) end

    if fromElement ~= toElement then
        local afterFrom = fromOrder[fromSlot]
        local movedQuantity = (sourceEntry.quantity or 0)
        if not destinationEntry then
            movedQuantity = tonumber(sourceEntry.quantity) or 0
        end
        -- Counts are authoritative element data; derive the actual transfer from before/after orders.
        local beforeFromCount = itemCount(fromElement, sourceEntry.itemName)
        local beforeToCount = itemCount(toElement, sourceEntry.itemName)
        local fromTotal = 0
        for _, item in pairs(fromOrder) do if item.itemName == sourceEntry.itemName then fromTotal = fromTotal + item.quantity end end
        local toTotal = 0
        for _, item in pairs(toOrder) do if item.itemName == sourceEntry.itemName then toTotal = toTotal + item.quantity end end
        if fromTotal < beforeFromCount then changeItemCount(fromElement, sourceEntry.itemName, fromTotal - beforeFromCount) end
        if toTotal > beforeToCount then changeItemCount(toElement, sourceEntry.itemName, toTotal - beforeToCount) end
    end
    return true
end

local function register(name, callback)
    addEvent(name, true)
    addEventHandler(name, root, function(...)
        if not playerIsValid(client) or source ~= client and source ~= resourceRoot then return end
        return callback(client, ...)
    end)
end

register("inv:reorganize", function(player, requestedPlayer)
    if requestedPlayer ~= player then return end
    normalizeInventoryOrder(player, "inv")
end)

register("inv:splitItem", function(player, element, slot)
    if element == player then
        splitInventorySlot(player, "inv", slot)
    elseif getContainer(player, element) then
        splitInventorySlot(element, "loot", slot)
    end
end)

register("inv:moveItem", function(player, element, fromSlot, toSlot, kind)
    if element == player and kind == "inv" then
        swapInventorySlots(player, "inv", fromSlot, toSlot)
    elseif getContainer(player, element) and kind == "loot" then
        swapInventorySlots(element, "loot", fromSlot, toSlot)
    end
end)

register("inv:dropItem", function(player, fromSlot, toSlot, object, fromKind, toKind)
    local fromElement = player
    if fromKind ~= "inv" then return end
    local order = getOrder(player, "inv")
    local entry = order[tonumber(fromSlot)]
    if not entry then return end

    if isElement(object) and getContainer(player, object) and toKind == "loot" then
        transfer(player, player, "inv", fromSlot, object, "loot", toSlot)
    else
        local x, y, z = getElementPosition(player)
        local quantity = tonumber(entry.quantity) or 0
        if quantity > 0 then
            exports["stoneage_pickups"]:createSack(x, y, z, {{entry.itemName, quantity}}, "Drop")
            changeItemCount(player, entry.itemName, -quantity)
            setEntry(player, "inv", fromSlot, false)
        end
    end
end)

register("inv:takeItem", function(player, object, toSlot, fromSlot, fromKind, toKind)
    if not getContainer(player, object) or fromKind ~= "loot" then return end
    local targetKind = toKind or "inv"
    if targetKind ~= "inv" then return end
    transfer(player, object, "loot", fromSlot, player, "inv", toSlot)
end)

register("inv:putItemOnKeybar", function(player, itemName, quantity, fromSlot, toSlot, fromKind)
    if fromKind ~= "inv" then return end
    local order = getOrder(player, "inv")
    local entry = order[tonumber(fromSlot)]
    if not entry or entry.itemName ~= itemName or tonumber(entry.quantity) ~= tonumber(quantity) then return end
    local target = getOrder(player, "keybar")
    if target[tonumber(toSlot)] then return end
    target[tonumber(toSlot)] = entry
    order[tonumber(fromSlot)] = nil
    putOrder(player, "inv", order)
    putOrder(player, "keybar", target)
end)

register("inv:putItemOnEquippedItems", function(player, fromSlot, toSlot, fromKind)
    if fromKind ~= "inv" then return end
    local order = getOrder(player, "inv")
    local entry = order[tonumber(fromSlot)]
    if not entry or not wearables[getItemType(entry.itemName)] then return end
    local target = getOrder(player, "pedSide")
    if target[tonumber(toSlot)] then return end
    target[tonumber(toSlot)] = entry
    order[tonumber(fromSlot)] = nil
    putOrder(player, "inv", order)
    putOrder(player, "pedSide", target)
end)

register("inv:takeItemToKeybar", function(player, object, fromSlot, toSlot, fromKind)
    if not getContainer(player, object) or fromKind ~= "loot" then return end
    transfer(player, object, "loot", fromSlot, player, "keybar", toSlot)
end)

register("inv:takeItemToEquippedItems", function(player, object, fromSlot, toSlot, fromKind)
    if not getContainer(player, object) or fromKind ~= "loot" then return end
    local order = getOrder(object, "loot")
    local entry = order[tonumber(fromSlot)]
    if not entry or not wearables[getItemType(entry.itemName)] then return end
    transfer(player, object, "loot", fromSlot, player, "pedSide", toSlot)
end)

register("inv:moveItemOnKeyBar", function(player, fromSlot, toSlot)
    swapInventorySlots(player, "keybar", fromSlot, toSlot)
end)

register("inv:removeItemFromKeyBar", function(player, fromSlot, toSlot, target, fromKind, toKind)
    if fromKind ~= "keybar" or not isElement(target) then return end
    local targetKind = toKind == "loot" and "loot" or "inv"
    if targetKind == "loot" and not getContainer(player, target) then return end
    transfer(player, player, "keybar", fromSlot, target, targetKind, toSlot)
end)

register("inv:removeItemFromKeyBarAndPutOnEquipped", function(player, itemName, fromSlot, toSlot)
    local order = getOrder(player, "keybar")
    local entry = order[tonumber(fromSlot)]
    if not entry or entry.itemName ~= itemName or not wearables[getItemType(itemName)] then return end
    local target = getOrder(player, "pedSide")
    if target[tonumber(toSlot)] then return end
    target[tonumber(toSlot)] = entry
    order[tonumber(fromSlot)] = nil
    putOrder(player, "keybar", order)
    putOrder(player, "pedSide", target)
end)

register("inv:moveItemOnEquippedItems", function(player, fromSlot, toSlot)
    swapInventorySlots(player, "pedSide", fromSlot, toSlot)
end)

register("inv:putEquippedItemOnInventory", function(player, fromSlot, toSlot)
    transfer(player, player, "pedSide", fromSlot, player, "inv", toSlot)
end)

register("inv:putEquippedItemOnLootOb", function(player, object, fromSlot, toSlot)
    if getContainer(player, object) then transfer(player, player, "pedSide", fromSlot, object, "loot", toSlot) end
end)

register("inv:putEquippedItemOnKeybar", function(player, fromSlot, toSlot)
    transfer(player, player, "pedSide", fromSlot, player, "keybar", toSlot)
end)

register("inv:fillBottle", function(player, slot)
    if not isElementInWater(player) then return end
    local order = getOrder(player, "inv")
    local entry = order[tonumber(slot)]
    if not entry or entry.itemName ~= "Empty Bottle" or itemCount(player, "Empty Bottle") < 1 then return end
    entry.itemName = "Water"
    order[tonumber(slot)] = entry
    putOrder(player, "inv", order)
    changeItemCount(player, "Empty Bottle", -1)
    changeItemCount(player, "Water", 1)
end)
