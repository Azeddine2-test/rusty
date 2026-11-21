-- Reconstructed player persistence and equipment controller for StoneAge.

local SQL = exports.stoneage_sql
local loadingPlayerData = {}
local savingPlayerData = {}

local function isAccountFlagEnabled(value)
    return value == true or tonumber(value) == 1
end

local function giveRespawnStarterKit(player)
    if not isElement(player) or getElementType(player) ~= "player" then return false end

    -- Standard Rust starter tools: pickaxe, hatchet and torch.
    local starterItems = { "Pickaxe", "Hatchet", "Torch" }

    if isAccountFlagEnabled(getElementData(player, "starterKitGiven")) then
        return false
    end

    for _, itemName in ipairs(starterItems) do
        if getPlayerDataSetting(itemName, "invSettings") then
            local quantity = math.max(0, tonumber(getElementData(player, itemName)) or 0)
            setElementData(player, itemName, quantity + 1)
        end
    end

    setAccountData(player, "starterKitGiven", true)
    return true
end

local function getOnlinePlayerByAccount(accountName)
    if type(accountName) ~= "string" then return false end
    for _, onlinePlayer in ipairs(getElementsByType("player")) do
        if getElementData(onlinePlayer, "account") == accountName then return onlinePlayer end
    end
    return false
end

local function applySavedCharacterClothes(player)
    if not isElement(player) then return false end
    local clothes = getElementData(player, "Clothes")
    if type(clothes) ~= "table" then return false end

    local slots = {
        { 0, tonumber(clothes.shirt) },
        { 1, tonumber(clothes.head) },
        { 2, tonumber(clothes.pants) },
    }
    for _, entry in ipairs(slots) do
        if entry[2] and type(getClothesByTypeIndex) == "function" then
            local texture, model = getClothesByTypeIndex(entry[1], entry[2])
            if texture and model then setPedClothes(player, entry[1], entry[2]) end
        end
    end
    return true
end

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

    local ok = SQL:Exec("UPDATE `Accounts` SET `??` = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
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
                    SQL:Exec("UPDATE `Accounts` SET `??` = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
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

    -- Retour au système de compte MTA : connexion directe, sans créateur obligatoire.
    if not getElementData(player, "isDead") then
        local position = getElementData(player, "position")
        local x = type(position) == "table" and tonumber(position.x)
        local y = type(position) == "table" and tonumber(position.y)
        local z = type(position) == "table" and tonumber(position.z)
        local validPosition = x and y and z and math.abs(x) < 4000 and math.abs(y) < 4000 and z >= 0 and z < 2000 and not (x == 0 and y == 0 and z == 0)

        if not validPosition then
            x, y, z = getRandomSpawnPos()
            setElementData(player, "position", { x = x, y = y, z = z })
        end

        local skin = tonumber(getElementData(player, "Skin")) or 7
        if skin <= 0 or skin > 311 then
            skin = 7
            setElementData(player, "Skin", skin)
            SQL:Exec("UPDATE `Accounts` SET `Skin` = ? WHERE `Owner` = ?", skin, account)
        end
        local spawned = spawnPlayer(player, x, y, z, math.random(0, 359), skin, 0, 0)
        if not spawned then
            x, y, z = getRandomSpawnPos()
            setElementData(player, "position", { x = x, y = y, z = z })
            spawned = spawnPlayer(player, x, y, z, math.random(0, 359), skin, 0, 0)
        end

        if spawned then
            applySavedCharacterClothes(player)
            setCameraTarget(player, player)
            fadeCamera(player, true)
            setElementFrozen(player, false)
            giveRespawnStarterKit(player)
        else
            outputDebugString("[STONEAGE] Echec du spawn initial de " .. getPlayerName(player), 1)
        end
    end

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
    if not getElementData(player, "isDead") then
        local x, y, z = getElementPosition(player)
        setElementData(player, "position", { x = x, y = y, z = z })
    end
    for dataName, definition in pairs(playerDataTable) do
        if definition.savableInDB and definition.savableInDB.Accounts then
            local value = getElementData(player, dataName)
            SQL:Exec("UPDATE `Accounts` SET `??` = ? WHERE `Owner` = ?", dataName, encodeAccountValue(value), account)
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


-- Authentification historique MTA : les mots de passe restent dans les comptes MTA.
-- La table SQL Accounts ne stocke que les données du personnage et de l'inventaire.
local authAttempts = {}
local authPending = {}

local function sendAuthResult(player, success, message)
    if isElement(player) then
        authPending[player] = nil
        triggerClientEvent(player, "rust:auth:result", player, success, message)
    end
end

local function finishNativeLogin(player, username, password, nativeAccount)
    if not isElement(player) then return end
    nativeAccount = nativeAccount or getAccount(username)
    if not nativeAccount then
        sendAuthResult(player, false, "Compte MTA introuvable.")
        return
    end

    if not GetAccount(username) and not createAccount(username) and not GetAccount(username) then
        sendAuthResult(player, false, "Impossible de créer les données du personnage.")
        return
    end
    if not logIn(player, nativeAccount, password) then
        sendAuthResult(player, false, "Identifiant ou mot de passe incorrect.")
        return
    end

    setElementData(player, "account", username)
    sendAuthResult(player, true, "Connexion réussie.")
end

addEvent("rust:auth:submit", true)
addEventHandler("rust:auth:submit", root, function(mode, username, password, confirmation)
    local player = client
    if not isElement(player) or source ~= player or authPending[player] or getElementData(player, "account") then return end
    if mode ~= "register" and mode ~= "login" then return end
    if type(username) ~= "string" or type(password) ~= "string" then return end

    local now = getTickCount()
    local attempt = authAttempts[player]
    if attempt and now - attempt.tick < 10000 and attempt.count >= 5 then
        sendAuthResult(player, false, "Trop de tentatives. Attends quelques secondes.")
        return
    end
    if not attempt or now - attempt.tick >= 10000 then
        attempt = { tick = now, count = 0 }
        authAttempts[player] = attempt
    end
    attempt.count = attempt.count + 1

    username = username:match("^%s*(.-)%s*$")
    if #username < 3 or #username > 30 then
        sendAuthResult(player, false, "L'identifiant doit contenir entre 3 et 30 caractères.")
        return
    end
    if #password < 1 or #password > 64 then
        sendAuthResult(player, false, "Mot de passe invalide.")
        return
    end

    authPending[player] = true

    if mode == "register" then
        if type(confirmation) ~= "string" or password ~= confirmation then
            sendAuthResult(player, false, "Les deux mots de passe ne correspondent pas.")
            return
        end
        if getAccount(username) or GetAccount(username) then
            sendAuthResult(player, false, "Ce compte existe déjà. Utilise Connexion.")
            return
        end
        local nativeAccount = addAccount(username, password)
        if not nativeAccount then
            sendAuthResult(player, false, "Impossible de créer le compte MTA.")
            return
        end
        if not createAccount(username) and not GetAccount(username) then
            removeAccount(nativeAccount)
            sendAuthResult(player, false, "Impossible de créer les données du personnage.")
            return
        end
        finishNativeLogin(player, username, password, nativeAccount)
        return
    end

    local nativeAccount = getAccount(username)
    if nativeAccount then
        finishNativeLogin(player, username, password, nativeAccount)
        return
    end

    -- Récupération unique des comptes créés pendant l'essai du nouveau système.
    local row = GetAccount(username)
    local storedHash = row and row.PasswordHash
    if type(storedHash) == "string" and storedHash ~= "" then
        passwordVerify(password, storedHash, {}, function(matches)
            if not isElement(player) then return end
            if not matches then
                sendAuthResult(player, false, "Identifiant ou mot de passe incorrect.")
                return
            end
            local migrated = addAccount(username, password)
            if not migrated then
                sendAuthResult(player, false, "Impossible de restaurer le compte MTA.")
                return
            end
            finishNativeLogin(player, username, password, migrated)
        end)
        return
    end
    sendAuthResult(player, false, "Identifiant ou mot de passe incorrect.")
end)

addEvent("rust:player:ensureSpawn", true)
addEventHandler("rust:player:ensureSpawn", root, function()
    local player = client
    if not isElement(player) or source ~= player or not getElementData(player, "account") then return end

    local px, py, pz = getElementPosition(player)
    local invalidPosition = not px or not py or not pz or math.abs(px) > 4000 or math.abs(py) > 4000 or pz < 0 or pz > 2000 or (px == 0 and py == 0 and pz == 0)
    if invalidPosition or getElementData(player, "isDead") then
        local position = getElementData(player, "position")
        local x = type(position) == "table" and tonumber(position.x)
        local y = type(position) == "table" and tonumber(position.y)
        local z = type(position) == "table" and tonumber(position.z)
        if not x or not y or not z or math.abs(x) > 4000 or math.abs(y) > 4000 or z < 0 or z > 2000 or (x == 0 and y == 0 and z == 0) then
            x, y, z = getRandomSpawnPos()
        end
        local skin = tonumber(getElementData(player, "Skin")) or 7
        if skin <= 0 or skin > 311 then skin = 7 end
        if spawnPlayer(player, x, y, z, math.random(0, 359), skin, 0, 0) then
            setElementData(player, "isDead", false)
            applySavedCharacterClothes(player)
            giveRespawnStarterKit(player)
            triggerClientEvent(player, "rust:onClientPlayerSpawn", player)
        end
    end
    setCameraTarget(player, player)
    fadeCamera(player, true)
    setElementFrozen(player, false)
end)

addEvent("rust:skin:change", true)
addEventHandler("rust:skin:change", root, function(skin)
    local player = client
    if not isElement(player) or source ~= player or not getElementData(player, "account") or getElementData(player, "isDead") then return end
    skin = tonumber(skin)
    local allowed = { [7]=true, [14]=true, [15]=true, [16]=true, [17]=true, [18]=true, [19]=true, [20]=true, [21]=true, [22]=true, [23]=true, [24]=true, [25]=true }
    if not skin or not allowed[skin] then
        triggerClientEvent(player, "rust:skin:result", player, false, "Skin non autorisé.")
        return
    end
    if not setElementModel(player, skin) then
        triggerClientEvent(player, "rust:skin:result", player, false, "Impossible d'appliquer ce skin.")
        return
    end
    setAccountData(player, "Skin", skin)
    applySavedCharacterClothes(player)
    triggerClientEvent(player, "rust:skin:result", player, true, "Skin modifié.")
end)

addEventHandler("onPlayerQuit", root, function()
    authAttempts[source] = nil
    authPending[source] = nil
end)

loadEvent("player:onDie", root, function(details)
    local player = client or source
    if not isElement(player) or getElementType(player) ~= "player" or getElementData(player, "isDead") then return end
    details = type(details) == "table" and details or {}
    setElementData(player, "isDead", true)
    setAccountData(player, "starterKitGiven", false)
    setElementData(player, "blood", 0)
    onPlayerDisequipItem(false, player)
    local alivetime = tonumber(getElementData(player, "alivetime")) or 0
    triggerClientEvent(player, "rust:onClientPlayerDie", player, details.reason or "Unknown", details.weapon, alivetime)
    savePlayerData(player)
end)

loadEvent("player:onSpawn", root, function(x, y, z, model)
    local player = client or source
    if not isElement(player) or getElementType(player) ~= "player" then return end
    if not isAccountFlagEnabled(getElementData(player, "isDead")) then return end
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    if not x or not y or not z then return end
    local skin = tonumber(model) or tonumber(getElementData(player, "Skin")) or 0
    spawnPlayer(player, x, y, z, math.random(0, 359), skin, getElementInterior(player), getElementDimension(player))
    applySavedCharacterClothes(player)
    setCameraTarget(player, player)
    setElementData(player, "isDead", false)
    setElementData(player, "blood", getPlayerDataSetting("blood", "max") or 15000)
    setElementData(player, "bleeding", 0)
    setElementData(player, "alivetime", 0)
    setElementHealth(player, 100)
    giveRespawnStarterKit(player)
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
        local ownerPlayer = getOnlinePlayerByAccount(owner)
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
            SQL:Exec("UPDATE `Accounts` SET `??` = ? WHERE `Owner` = ?", key, encodeAccountValue(value), account)
            ClearAccountDataCache(account)
        end
    end
end)

addEventHandler("onPlayerQuit", root, function()
    savePlayerData(source)
end)

-- Preserve the last position and inventory when the gamemode resource is restarted.
addEventHandler("onResourceStop", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        savePlayerData(player)
    end
end)

-- Broken bones periodically make the player stumble/fall.
local brokenboneFallCooldown = {}
addEvent("player:onFallByBrokenbone", true)
addEventHandler("player:onFallByBrokenbone", root, function()
    local player = client
    if not isElement(player) or source ~= player or getElementType(player) ~= "player" then return end
    if not getElementData(player, "account") or getElementData(player, "isDead")
        or not getElementData(player, "brokenbone") then return end

    local now = getTickCount()
    if brokenboneFallCooldown[player] and now - brokenboneFallCooldown[player] < 9000 then return end
    brokenboneFallCooldown[player] = now

    -- getPedAnimation is client-side only; setPedAnimation is valid server-side.
    setPedAnimation(player, "ped", "FLOOR_hit_f", 1000, false, false, false, false)
end)

addEventHandler("onPlayerQuit", root, function()
    brokenboneFallCooldown[source] = nil
end)

addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        local account = resolveAccount(player)
        if account then loadPlayerData(player, account) end
    end
end)
