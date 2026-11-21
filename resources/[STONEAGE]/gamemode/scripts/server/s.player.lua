-- Reconstructed player persistence and equipment controller for StoneAge.

local SQL = exports.stoneage_sql
local loadingPlayerData = {}
local savingPlayerData = {}

local function syncPedSide(player, oldOrder, newOrder)
    if not isElement(player) then return end
    oldOrder = type(oldOrder) == "table" and oldOrder or {}
    newOrder = type(newOrder) == "table" and newOrder or {}

    for _, entry in pairs(oldOrder) do
        local itemName = type(entry) == "table" and entry.itemName
        if itemName then
            if getPlayerDataSetting(itemName, "clothSettings") then removeClothes(player, itemName) end
            if type(detachDefenseFromBone) == "function" then detachDefenseFromBone(itemName, player) end
        end
    end

    local helmet, vest = false, false
    for _, entry in pairs(newOrder) do
        local itemName = type(entry) == "table" and entry.itemName
        if itemName then
            if getPlayerDataSetting(itemName, "clothSettings") then applyClothes(player, itemName) end
            if getItemType(itemName) == "defenseItem" and type(attachDefenseToBody) == "function" then
                attachDefenseToBody(itemName, player)
            end
            if itemName == "Helmet" then helmet = true end
            if itemName == "Vest" then vest = true end
        end
    end

    setElementData(player, "Helmet_used", helmet)
    setElementData(player, "Vest_used", vest)
end

-- Fallback effects for consumables whose balance data was absent from the recovered config.
local DEFAULT_CONSUMPTION = {
    ["Apple"] = { fome = 10 },
    ["Corn"] = { fome = 15 },
    ["Potato"] = { fome = 20 },
    ["Pumpkin"] = { fome = 25 },
    ["Meat Cooked"] = { fome = 40 },
    ["Beans Can"] = { fome = 30 },
    ["Water"] = { sede = 25 },
}

local function encodeAccountValue(value)
    if type(value) == "table" then return toJSON(value) end
    return value
end

local function resolveAccount(value)
    if isElement(value) and getElementType(value) == "player" then
        return getElementData(value, "account")
    end
    return type(value) == "string" and value or false
end

function setAccountData(accountOrPlayer, dataName, value)
    local account = resolveAccount(accountOrPlayer)
    if not account or type(dataName) ~= "string" or not SQL then return false end
    local definition = playerDataTable[dataName]
    if not definition or not definition.savableInDB or not definition.savableInDB.Accounts then return false end

    local ok = SQL:Exec("UPDATE `Accounts` SET ?? = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
    ClearAccountDataCache(account)

    if isElement(accountOrPlayer) then
        loadingPlayerData[accountOrPlayer] = true
        if value == nil then removeElementData(accountOrPlayer, dataName)
        else setElementData(accountOrPlayer, dataName, value) end
        loadingPlayerData[accountOrPlayer] = nil
    end
    return ok
end

function setPreference(element, slotID, itemName, quantity)
    if not isElement(element) then return false end
    slotID = tonumber(slotID)
    quantity = tonumber(quantity)
    if not slotID or slotID < 1 then return false end
    local order = getElementData(element, "invOrder")
    if type(order) ~= "table" then order = {} end
    if type(itemName) ~= "string" or not quantity or quantity <= 0 then
        order[slotID] = nil
    else
        order[slotID] = { itemName = itemName, quantity = math.floor(quantity) }
    end
    setElementData(element, "invOrder", order)
    return true
end

local function loadPlayerData(player, account)
    if not isElement(player) or type(account) ~= "string" or account == "" then return false end
    if loadingPlayerData[player] then return false end
    loadingPlayerData[player] = true

    if not GetAccount(account) then createAccount(account) end
    setElementData(player, "account", account)

    for dataName, definition in pairs(playerDataTable) do
        if definition.savableInDB and definition.savableInDB.Accounts then
            local value = GetAccountData(account, dataName)
            if value == false or value == nil then
                value = definition.initialValue
                if type(value) == "function" then value = value(player) end
                if value ~= nil then
                    SQL:Exec("UPDATE `Accounts` SET ?? = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
                end
            end
            if value ~= nil and value ~= false then setElementData(player, dataName, value) end
        elseif definition.initialValue ~= nil and getElementData(player, dataName) == nil then
            local value = definition.initialValue
            if type(value) == "function" then value = value(player) end
            if value ~= nil then setElementData(player, dataName, value) end
        end
    end

    ClearAccountDataCache(account)
    syncPedSide(player, {}, getElementData(player, "pedSideOrder"))
    loadingPlayerData[player] = nil
    triggerClientEvent(player, "rust:onClientPlayerLogin", player, account)
    if getElementData(player, "isDead") then
        triggerClientEvent(player, "rust:onClientPlayerDie", player, "Reconnect", false, getElementData(player, "alivetime") or 0)
    else
        triggerClientEvent(player, "rust:onClientPlayerSpawn", player)
    end
    return true
end

local function savePlayerData(player)
    local account = resolveAccount(player)
    if not account or savingPlayerData[player] or loadingPlayerData[player] then return false end
    savingPlayerData[player] = true
    for dataName, definition in pairs(playerDataTable) do
        if definition.savableInDB and definition.savableInDB.Accounts then
            local value = getElementData(player, dataName)
            SQL:Exec("UPDATE `Accounts` SET ?? = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
        end
    end
    ClearAccountDataCache(account)
    savingPlayerData[player] = nil
    return true
end

local function getKeybarItem(player, slotID)
    local order = getElementData(player, "keybarOrder") or {}
    local entry = type(order) == "table" and order[tonumber(slotID)]
    return type(entry) == "table" and entry or false
end

function onPlayerDisequipItem(slotID, player)
    if not isElement(player) or getElementType(player) ~= "player" then return false end
    local entry = getKeybarItem(player, slotID)
    local itemName = entry and entry.itemName or getElementData(player, "equippedItem")
    if not itemName then return false end

    local settings = getPlayerDataSetting(itemName, "weaponSettings")
    if settings and settings.weapID then
        takeWeapon(player, settings.weapID)
        setPedWeaponSlot(player, 0)
    end
    if getPlayerDataSetting(itemName, "clothSettings") then
        removeClothes(player, itemName)
    end
    if type(detachDefenseFromBone) == "function" then detachDefenseFromBone(itemName, player) end
    if type(detachItemFromBone) == "function" then detachItemFromBone(itemName, player) end

    if getElementData(player, "equippedItem") == itemName then
        removeElementData(player, "equippedItem")
        removeElementData(player, "equippedSlotID")
    end
    triggerClientEvent(player, "rust:onClientPlayerDisequipItem", player, itemName)
    return true
end

function onPlayerEquipItem(slotID, player)
    if not isElement(player) or getElementType(player) ~= "player" then return false end
    local entry = getKeybarItem(player, slotID)
    if not entry or type(entry.itemName) ~= "string" then return false end
    local itemName = entry.itemName
    if (tonumber(getElementData(player, itemName)) or 0) <= 0 then return false end
    setElementData(player, "equippedSlotID", tonumber(slotID))

    local weapon = getPlayerDataSetting(itemName, "weaponSettings")
    if weapon and weapon.weapID then
        local ammo = 0
        if weapon.type == "melee" then
            ammo = 1
        elseif getPlayerDataSetting(itemName, "ammo") then
            local ammoName = getPlayerDataSetting(itemName, "ammo").name
            ammo = tonumber(getElementData(player, ammoName)) or 0
        end
        giveWeapon(player, weapon.weapID, ammo, true)
        if weapon.slotID then
            setPedWeaponSlot(player, weapon.slotID)
            setElementData(player, "equippedSlotID", tonumber(slotID))
        end
    elseif getPlayerDataSetting(itemName, "clothSettings") then
        applyClothes(player, itemName)
    end

    if getItemType(itemName) == "defenseItem" and type(attachDefenseToBody) == "function" then
        attachDefenseToBody(itemName, player)
    end
    if type(attachItemToBone) == "function" then attachItemToBone(itemName, player) end
    setElementData(player, "equippedItem", itemName)
    triggerClientEvent(player, "rust:onClientPlayerEquipItem", player, itemName)
    return true
end

local function consumeItem(player, itemName, slotID)
    if not isElement(player) or getElementType(player) ~= "player" or not getElementData(player, "account") or getElementData(player, "isDead") then return false end
    if type(itemName) ~= "string" or (tonumber(getElementData(player, itemName)) or 0) <= 0 then return false end
    local settings = getPlayerDataSetting(itemName, "consumeSettings") or DEFAULT_CONSUMPTION[itemName]
    if type(settings) ~= "table" then return false end

    for dataName, amount in pairs(settings) do
        if playerDataTable[dataName] and type(amount) == "number" then
            local maximum = tonumber(getPlayerDataSetting(dataName, "max")) or math.huge
            local current = tonumber(getElementData(player, dataName)) or 0
            setElementData(player, dataName, math.min(maximum, math.max(0, current + amount)))
        end
    end

    local quantity = math.max(0, (tonumber(getElementData(player, itemName)) or 0) - 1)
    if quantity > 0 then setElementData(player, itemName, quantity) else removeElementData(player, itemName) end
    local order = getElementData(player, "invOrder") or {}
    if order[tonumber(slotID)] then
        order[tonumber(slotID)].quantity = math.max(0, (tonumber(order[tonumber(slotID)].quantity) or 0) - 1)
        if order[tonumber(slotID)].quantity <= 0 then order[tonumber(slotID)] = nil end
        setElementData(player, "invOrder", order)
    end
    triggerClientEvent(player, "playItemSound", player, itemName)
    return true
end

addEvent("removeDefenseItemOnDestroy", false)
addEventHandler("removeDefenseItemOnDestroy", root, function(victim, itemName)
    if not isElement(victim) or getElementType(victim) ~= "player" then return end
    if itemName ~= "Helmet" and itemName ~= "Vest" then return end
    local order = getElementData(victim, "pedSideOrder") or {}
    for slot, entry in pairs(order) do
        if type(entry) == "table" and entry.itemName == itemName then
            order[slot] = nil
            break
        end
    end
    setElementData(victim, "pedSideOrder", order)
    local quantity = math.max(0, (tonumber(getElementData(victim, itemName)) or 0) - 1)
    if quantity > 0 then setElementData(victim, itemName, quantity) else removeElementData(victim, itemName) end
    if itemName == "Helmet" then setElementData(victim, "Helmet_used", false) end
    if itemName == "Vest" then setElementData(victim, "Vest_used", false) end
end)

loadEvent("rust:onPlayerEquipItem", root, function(slotID)
    if source == client then onPlayerEquipItem(slotID, client) end
end)

loadEvent("rust:onPlayerDisequipItem", root, function(slotID)
    if source == client then onPlayerDisequipItem(slotID, client) end
end)

loadEvent("rust:onAmmoChange", root, function(weaponID, ammoCount, slotID)
    if source ~= client then return end
    local itemName = getElementData(client, "equippedItem")
    local weapon = itemName and getPlayerDataSetting(itemName, "weaponSettings")
    local ammo = itemName and getPlayerDataSetting(itemName, "ammo")
    if not weapon or not ammo or tonumber(weapon.weapID) ~= tonumber(weaponID)
        or tonumber(weapon.slotID) ~= tonumber(slotID)
        or tonumber(getElementData(client, "equippedSlotID")) ~= tonumber(slotID) then
        return
    end
    local total = math.max(0, tonumber(getElementData(client, ammo.name)) or tonumber(ammoCount) or 0)
    local clip = math.min(total, tonumber(ammo.magSize) or total)
    setWeaponAmmo(client, tonumber(weaponID), total, clip)
end)

loadEvent("rust:onPlayerConsumeItem", root, function(itemName, slotID)
    if source == client then consumeItem(client, itemName, slotID) end
end)

loadEvent("player:onTryToLogin", root, function()
    if source == client then triggerClientEvent(client, "toggleLogin", client, true) end
end)


-- Secure account registration/login using MTA's built-in account storage.
-- Passwords are never written to the StoneAge gameplay database.
local authAttempts = {}

addEvent("rust:auth:submit", true)
addEventHandler("rust:auth:submit", root, function(mode, username, password)
    local player = client
    if not isElement(player) or source ~= player then return end
    if type(mode) ~= "string" or type(username) ~= "string" or type(password) ~= "string" then return end

    local now = getTickCount()
    local attempt = authAttempts[player]
    if attempt and now - attempt.tick < 10000 and attempt.count >= 5 then
        triggerClientEvent(player, "rust:auth:result", player, false, "Trop de tentatives. Attends quelques secondes.")
        return
    end
    if not attempt or now - attempt.tick >= 10000 then
        attempt = { tick = now, count = 0 }
        authAttempts[player] = attempt
    end
    attempt.count = attempt.count + 1

    username = username:match("^%s*(.-)%s*$")
    if #username < 3 or #username > 20 or not username:match("^[%w_%-]+$") then
        triggerClientEvent(player, "rust:auth:result", player, false, "Identifiant : 3 à 20 caractères (lettres, chiffres, _ ou -).")
        return
    end
    if #password < 6 or #password > 64 then
        triggerClientEvent(player, "rust:auth:result", player, false, "Le mot de passe doit contenir entre 6 et 64 caractères.")
        return
    end

    if mode == "register" then
        if getAccount(username) or GetAccount(username) then
            triggerClientEvent(player, "rust:auth:result", player, false, "Ce compte existe déjà. Connecte-toi.")
            return
        end

        local account = addAccount(username, password)
        if not account then
            triggerClientEvent(player, "rust:auth:result", player, false, "Impossible de créer ce compte. Vérifie l'identifiant.")
            return
        end

        local created = createAccount(username)
        if not created then
            removeAccount(account)
            triggerClientEvent(player, "rust:auth:result", player, false, "La base de données a refusé la création du compte.")
            return
        end

        if not logIn(player, account, password) then
            triggerClientEvent(player, "rust:auth:result", player, false, "Compte créé, mais la connexion automatique a échoué. Essaie de te connecter.")
            return
        end
    elseif mode == "login" then
        local account = getAccount(username, password)
        if not account then
            triggerClientEvent(player, "rust:auth:result", player, false, "Identifiant ou mot de passe incorrect.")
            return
        end

        if not GetAccount(username) then
            local created = createAccount(username)
            if not created then
                triggerClientEvent(player, "rust:auth:result", player, false, "Impossible de préparer les données du joueur.")
                return
            end
        end

        if not logIn(player, account, password) then
            triggerClientEvent(player, "rust:auth:result", player, false, "La connexion a échoué. Réessaie.")
            return
        end
    else
        return
    end

    setElementData(player, "account", username)
    triggerClientEvent(player, "rust:auth:result", player, true, "Connexion réussie.")
end)

addEventHandler("onPlayerQuit", root, function()
    authAttempts[source] = nil
end)

loadEvent("player:onDie", root, function(details)
    local player = client or source
    if not isElement(player) or getElementType(player) ~= "player" or getElementData(player, "isDead") then return end
    details = type(details) == "table" and details or {}
    setElementData(player, "isDead", true)
    setElementData(player, "blood", 0)
    onPlayerDisequipItem(false, player)
    local alivetime = tonumber(getElementData(player, "alivetime")) or 0
    triggerClientEvent(player, "rust:onClientPlayerDie", player, details.reason or "Unknown", details.weapon, alivetime)
    savePlayerData(player)
end)

loadEvent("player:onSpawn", root, function(x, y, z, model)
    local player = client or source
    if not isElement(player) or getElementType(player) ~= "player" then return end
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    if not x or not y or not z then return end
    local skin = tonumber(model) or tonumber(getElementData(player, "Skin")) or 0
    spawnPlayer(player, x, y, z, math.random(0, 359), skin, getElementInterior(player), getElementDimension(player))
    setCameraTarget(player, player)
    setElementData(player, "isDead", false)
    setElementData(player, "blood", getPlayerDataSetting("blood", "max") or 15000)
    setElementData(player, "bleeding", 0)
    setElementData(player, "alivetime", 0)
    setElementHealth(player, 100)
    syncPedSide(player, {}, getElementData(player, "pedSideOrder"))
    triggerClientEvent(player, "rust:onClientPlayerSpawn", player)
    savePlayerData(player)
end)

loadEvent("onPlayerSpawnAtBed", root, function(bed)
    local player = client or source
    if not isElement(player) or not isElement(bed) or getElementData(bed, "obName") ~= "Cama" then return end
    local owner = getElementData(bed, "owner")
    local account = getElementData(player, "account")
    if owner ~= account then
        local ownerPlayer = getAccountPlayer(owner)
        local ownerGroup = ownerPlayer and getElementData(ownerPlayer, "Group") or GetAccountData(owner, "Group")
        if not ownerGroup or ownerGroup ~= getElementData(player, "Group") then return end
    end
    local x, y, z = getElementPosition(bed)
    triggerEvent("player:onSpawn", player, x, y, z + 1, getElementModel(player))
end)

addEventHandler("onElementDataChange", root, function(key, oldValue, value)
    if getElementType(source) ~= "player" then return end
    if key == "pedSideOrder" then syncPedSide(source, oldValue, value) end
    if key == "account" and type(value) == "string" and value ~= "" then
        loadPlayerData(source, value)
        return
    end
    if loadingPlayerData[source] or savingPlayerData[source] then return end
    local definition = playerDataTable[key]
    if definition and definition.savableInDB and definition.savableInDB.Accounts then
        local account = resolveAccount(source)
        if account and SQL then
            SQL:Exec("UPDATE `Accounts` SET ?? = ? WHERE `Owner` = ?", key, encodeAccountValue(value), account)
            ClearAccountDataCache(account)
        end
    end
end)

addEventHandler("onPlayerQuit", root, function()
    savePlayerData(source)
end)

addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        local account = resolveAccount(player)
        if account then loadPlayerData(player, account) end
    end
end)
