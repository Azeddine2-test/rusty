-- Shared inventory primitives used by the server inventory handlers.
-- Inventory orders are element-data tables keyed by slot ID.

local INVENTORY_ORDER_KEYS = {
    inv = "invOrder",
    loot = "invOrder",
    keybar = "keybarOrder",
    pedSide = "pedSideOrder",
}

function getInventoryOrder(element, inventoryType)
    if not isElement(element) then return {} end
    local key = INVENTORY_ORDER_KEYS[inventoryType]
    if not key then return {} end
    local order = getElementData(element, key)
    return type(order) == "table" and order or {}
end

function getInventoryLimit(element, inventoryType)
    if not isElement(element) then return 0 end
    if inventoryType == "keybar" then return 7 end
    if inventoryType == "pedSide" then return 99 end
    return math.max(0, tonumber(getElementData(element, "maxSlots")) or 0)
end

function getInventoryFreeSlot(element, inventoryType, preferredSlot)
    local order = getInventoryOrder(element, inventoryType)
    local limit = getInventoryLimit(element, inventoryType)
    preferredSlot = tonumber(preferredSlot)
    if preferredSlot and preferredSlot >= 1 and preferredSlot <= limit and not order[preferredSlot] then
        return preferredSlot
    end
    for slot = 1, limit do
        if not order[slot] then return slot end
    end
    return false
end

function getInventoryItemCount(element, itemName, inventoryType)
    if not isElement(element) or type(itemName) ~= "string" then return 0 end
    local order = getInventoryOrder(element, inventoryType or "inv")
    local quantity = 0
    for _, entry in pairs(order) do
        if type(entry) == "table" and entry.itemName == itemName then
            quantity = quantity + math.max(0, tonumber(entry.quantity) or 0)
        end
    end
    return quantity
end

function setInventoryOrder(element, inventoryType, order)
    if not isElement(element) or type(order) ~= "table" then return false end
    local key = INVENTORY_ORDER_KEYS[inventoryType]
    if not key then return false end
    setElementData(element, key, order)
    return true
end

function setInventorySlot(element, inventoryType, slot, itemName, quantity)
    slot = tonumber(slot)
    quantity = tonumber(quantity)
    if not isElement(element) or not INVENTORY_ORDER_KEYS[inventoryType] or not slot or slot < 1 or slot > getInventoryLimit(element, inventoryType) then return false end
    local order = getInventoryOrder(element, inventoryType)
    if type(itemName) ~= "string" or not quantity or quantity <= 0 then
        order[slot] = nil
    else
        order[slot] = { itemName = itemName, quantity = math.floor(quantity) }
    end
    return setInventoryOrder(element, inventoryType, order)
end

function swapInventorySlots(element, inventoryType, firstSlot, secondSlot)
    firstSlot, secondSlot = tonumber(firstSlot), tonumber(secondSlot)
    if not isElement(element) or not INVENTORY_ORDER_KEYS[inventoryType] or not firstSlot or not secondSlot then return false end
    local limit = getInventoryLimit(element, inventoryType)
    if firstSlot < 1 or secondSlot < 1 or firstSlot > limit or secondSlot > limit then return false end
    if firstSlot == secondSlot then return true end
    local order = getInventoryOrder(element, inventoryType)
    order[firstSlot], order[secondSlot] = order[secondSlot], order[firstSlot]
    if not order[firstSlot] then order[firstSlot] = nil end
    if not order[secondSlot] then order[secondSlot] = nil end
    return setInventoryOrder(element, inventoryType, order)
end

function normalizeInventoryOrder(element, inventoryType)
    if not isElement(element) or not INVENTORY_ORDER_KEYS[inventoryType] then return false end
    local current = getInventoryOrder(element, inventoryType)
    local compact = {}
    local limit = getInventoryLimit(element, inventoryType)

    for oldSlot = 1, limit do
        local entry = current[oldSlot]
        if type(entry) == "table" and type(entry.itemName) == "string" then
            local remaining = math.floor(tonumber(entry.quantity) or 0)
            local maximum = getItemMaxStack(entry.itemName)
            while remaining > 0 do
                local merged = false
                for slot = 1, #compact do
                    local existing = compact[slot]
                    if existing.itemName == entry.itemName and existing.quantity < maximum then
                        local moved = math.min(remaining, maximum - existing.quantity)
                        existing.quantity = existing.quantity + moved
                        remaining = remaining - moved
                        merged = true
                        if remaining <= 0 then break end
                    end
                end
                if remaining > 0 then
                    if #compact >= limit then break end
                    local moved = math.min(remaining, maximum)
                    compact[#compact + 1] = { itemName = entry.itemName, quantity = moved }
                    remaining = remaining - moved
                elseif merged then
                    break
                end
            end
        end
    end
    return setInventoryOrder(element, inventoryType, compact)
end

function splitInventorySlot(element, inventoryType, slot)
    slot = tonumber(slot)
    if not isElement(element) or not INVENTORY_ORDER_KEYS[inventoryType] or not slot then return false end
    local order = getInventoryOrder(element, inventoryType)
    local entry = order[slot]
    if type(entry) ~= "table" then return false end
    local quantity = math.floor(tonumber(entry.quantity) or 0)
    if quantity < 2 then return false end
    local freeSlot = getInventoryFreeSlot(element, inventoryType)
    if not freeSlot then return false end
    local splitQuantity = math.floor(quantity / 2)
    entry.quantity = quantity - splitQuantity
    order[slot] = entry
    order[freeSlot] = { itemName = entry.itemName, quantity = splitQuantity }
    return setInventoryOrder(element, inventoryType, order), freeSlot
end
