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

addEventHandler("onElementDataChange", root, function(dataName, oldValue, newValue)
    if IS_STILL_LOADING[source] then return end
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

function onPlayerEquipItem(_ARG_0_, _ARG_1_)
  _ARG_1_ = _ARG_1_ or source
  if not isElement(_ARG_1_) then
    return false
  end
  if not getElementData(_ARG_1_, "keybarOrder") then
    return false
  end
  takeAllWeapons(_ARG_1_)
  if isWeapon(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) then
    if getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "ammo") then
    end
    if getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings") and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings").weapID and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings") and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings").slotID then
      if not getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "ammo").name then
        if getItemType(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) == "weapon-melee" then
          giveWeapon(_ARG_1_, getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings") and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings").weapID, 1, true)
          detachWeaponFromBone(getItemType(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName), _ARG_1_)
        end
      elseif 0 < (getElementData(_ARG_1_, getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "ammo").name) or 0) then
        giveWeapon(_ARG_1_, getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings") and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings").weapID, getElementData(_ARG_1_, getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "ammo").name) or 0, true)
        if getElementData(root, "weapon_switch_anim") and 1 < getSlotFromWeapon(getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings") and getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "weaponSettings").weapID) then
          setPedAnimation(_ARG_1_, "colt45", "colt45_reload", 1, false, true, true, false, 0, true)
        end
        detachWeaponFromBone(getItemType(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName), _ARG_1_)
      else
        onPlayerDisequipItem(_ARG_0_, source)
        triggerClientEvent(_ARG_1_, "inv:disequipCurrentKeybarItem", _ARG_1_)
        exports.stoneage_notifications:CreateNotification(_ARG_1_, translate(_ARG_1_, "precisa de muni\195\167\195\163o", nil, translate(_ARG_1_, getPlayerDataSetting(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, "ammo").name, "name")), "error")
        return
      end
    end
    if (getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) == "Torch" then
      setPedWalkingStyle(_ARG_1_, 127)
    end
  end
  attachItemToBone(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, _ARG_1_)
  setElementData(_ARG_1_, "equippedItem", getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName)
  setElementData(_ARG_1_, "equippedSlotID", _ARG_0_)
  triggerClientEvent(_ARG_1_, "rust:onClientPlayerEquipItem", _ARG_1_, getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName, _ARG_0_)
end
loadEvent("rust:onPlayerEquipItem", root, onPlayerEquipItem)
function onPlayerDisequipItem(_ARG_0_, _ARG_1_)
  _ARG_1_ = _ARG_1_ or source
  if type((getElementData(_ARG_1_, "keybarOrder"))) ~= "table" then
    return false
  end
  if not (getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) then
    return false
  end
  if isWeapon(getElementData(_ARG_1_, "keybarOrder")[_ARG_0_] and getElementData(_ARG_1_, "keybarOrder")[_ARG_0_].itemName) then
    setTimer(function()
      takeAllWeapons(_UPVALUE0_)
      detachItemFromBone(_UPVALUE1_, _UPVALUE0_)
      attachWeaponToBody(_UPVALUE1_, _UPVALUE0_)
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
