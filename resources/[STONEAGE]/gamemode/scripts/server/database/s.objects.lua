-- Reconstructed object persistence layer for the StoneAge gamemode.
-- Object-specific values are stored in the Objects table created by s.database.lua.

local SQL = exports.stoneage_sql
local FIXED_COLUMNS = {
    ObjectID = true, Position = true, Name = true, Owner = true, Type = true, Others = true,
}

local function serializable(value)
    local kind = type(value)
    return kind == "string" or kind == "number" or kind == "boolean" or kind == "table"
end

local function encodeValue(value)
    if type(value) == "table" then return toJSON(value) end
    if value == nil then return nil end
    return value
end

local function decodeColumn(key, value)
    if value == nil then return nil end
    local definition = playerDataTable and playerDataTable[key]
    local columnType = definition and definition.savableInDB and definition.savableInDB.Objects
    if columnType == "INT" then return tonumber(value) end
    if columnType == "TEXT" and type(value) == "string" then
        local decoded = fromJSON(value)
        if type(decoded) == "table" then return fixJSONTable(decoded) end
        if value == "true" then return true end
        if value == "false" then return false end
        return value
    end
    return value
end

local function getObjectPositionData(object)
    local x, y, z = getElementPosition(object)
    local rx, ry, rz = getElementRotation(object)
    return toJSON({ x = x, y = y, z = z, rx = rx, ry = ry, rz = rz })
end

local function nextObjectID()
    local rows = SQL:Query("SELECT COALESCE(MAX(`ObjectID`), 0) + 1 AS `NextID` FROM `Objects`")
    return type(rows) == "table" and rows[1] and tonumber(rows[1].NextID) or false
end

function addObjectToDatabase(object, objectName)
    if not SQL or not isElement(object) or getElementType(object) ~= "object" then return false end
    objectName = objectName or getElementData(object, "obName")
    local owner = getElementData(object, "owner")
    if type(objectName) ~= "string" or type(owner) ~= "string" then return false end

    local id = tonumber(getElementData(object, "objID")) or nextObjectID()
    if not id then return false end

    local others = {}
    for key, value in pairs(getAllElementData(object) or {}) do
        if not FIXED_COLUMNS[key] and key ~= "objID" and serializable(value) then
            others[key] = value
        end
    end

    local objectType = getElementData(object, "obType") or getObjectDataSetting(objectName, "Type") or ""
    SQL:Exec(
        "INSERT OR REPLACE INTO `Objects` (`ObjectID`, `Position`, `Name`, `Owner`, `Type`, `Others`) VALUES (?, ?, ?, ?, ?, ?)",
        id, getObjectPositionData(object), objectName, owner, objectType, toJSON(others)
    )

    setElementData(object, "objID", id)
    setElementParent(object, resourceRoot)

    for key, definition in pairs(playerDataTable or {}) do
        if definition.savableInDB and definition.savableInDB.Objects then
            local value = getElementData(object, key)
            if value ~= nil then
                SQL:Exec("UPDATE `Objects` SET ?? = ? WHERE `ObjectID` = ?", key, encodeValue(value), id)
            end
        end
    end
    return id
end

function removeObjectFromDatabase(object)
    if not SQL then return false end
    local id = isElement(object) and tonumber(getElementData(object, "objID")) or tonumber(object)
    if not id then return false end
    return SQL:Exec("DELETE FROM `Objects` WHERE `ObjectID` = ?", id)
end

local function restoreObject(row)
    local position = type(row.Position) == "string" and fromJSON(row.Position)
    if type(position) ~= "table" then return false end

    local x = tonumber(position.x or position[1])
    local y = tonumber(position.y or position[2])
    local z = tonumber(position.z or position[3])
    if not x or not y or not z then return false end

    local objectName = row.Name
    local model = getObModel(objectName)
    if not model then return false end

    local object = createObject(
        model, x, y, z,
        tonumber(position.rx or position[4]) or 0,
        tonumber(position.ry or position[5]) or 0,
        tonumber(position.rz or position[6]) or 0
    )
    if not isElement(object) then return false end

    setElementParent(object, resourceRoot)
    setElementFrozen(object, true)
    setObjectBreakable(object, false)
    setElementData(object, "objID", tonumber(row.ObjectID))
    setElementData(object, "owner", row.Owner)
    setElementData(object, "obName", objectName)
    setElementData(object, "obType", row.Type or getObjectDataSetting(objectName, "Type"))

    for key, definition in pairs(playerDataTable or {}) do
        if definition.savableInDB and definition.savableInDB.Objects then
            local value = decodeColumn(key, row[key])
            if value ~= nil then setElementData(object, key, value) end
        end
    end

    local others = type(row.Others) == "string" and fromJSON(row.Others)
    if type(others) == "table" then
        for key, value in pairs(others) do
            if key ~= "objID" and key ~= "owner" and key ~= "obName" then
                setElementData(object, key, value)
            end
        end
    end

    if getElementData(object, "baseObject") == nil and isBaseItem(objectName) then
        setElementData(object, "baseObject", true)
    end
    if getElementData(object, "maxSlots") == nil then
        local slots = getObjectDataSetting(objectName, "maxSlots")
        if slots then setElementData(object, "maxSlots", slots) end
    end
    return object
end

local function loadObjects()
    if not SQL then return end
    local rows = SQL:Query("SELECT * FROM `Objects`")
    if type(rows) ~= "table" then
        outputDebugString("[gamemode] Impossible de charger les objets: requête SQL invalide.", 1)
        return
    end
    local loaded, failed = 0, 0
    for _, row in ipairs(rows) do
        if restoreObject(row) then loaded = loaded + 1 else failed = failed + 1 end
    end
    outputDebugString(("[gamemode] Objets restaurés: %d, ignorés: %d."):format(loaded, failed), 3)
end

addEventHandler("onResourceStart", resourceRoot, loadObjects)

addEventHandler("onElementDataChange", root, function(key, _, value)
    if getElementType(source) ~= "object" then return end
    local id = tonumber(getElementData(source, "objID"))
    local definition = playerDataTable and playerDataTable[key]
    if not id or not definition or not definition.savableInDB or not definition.savableInDB.Objects then return end
    SQL:Exec("UPDATE `Objects` SET ?? = ? WHERE `ObjectID` = ?", key, encodeValue(value), id)
end)

addEventHandler("onElementDestroy", root, function()
    if getElementType(source) ~= "object" then return end
    local id = tonumber(getElementData(source, "objID"))
    if id then
        -- Keep the row only when the object is being destroyed during resource shutdown.
        -- Explicit gameplay destruction removes its row through removeObjectFromDatabase().
    end
end)

function RepairAllObjects()
    local repaired = 0
    for _, object in ipairs(getElementsByType("object", resourceRoot)) do
        local name = getElementData(object, "obName")
        local maximum = name and getObjectDataSetting(name, "maxHealth")
        if maximum then
            setElementData(object, "health", maximum)
            repaired = repaired + 1
        end
    end
    return repaired
end

function RunDecay()
    -- Decay rules are server-configurable; never damage structures when no rule is configured.
    local rule = getGamePlayConfig and getGamePlayConfig("object decay")
    if type(rule) ~= "table" then return false end
    local interval = tonumber(rule.interval)
    local damage = tonumber(rule.damage)
    if not interval or interval <= 0 or not damage or damage <= 0 then return false end

    local affected = 0
    for _, object in ipairs(getElementsByType("object", resourceRoot)) do
        if getElementData(object, "baseObject") then
            local last = tonumber(getElementData(object, "decay:lastTick")) or 0
            local now = getTickCount()
            if now - last >= interval then
                local health = tonumber(getElementData(object, "health")) or 0
                setElementData(object, "health", math.max(0, health - damage))
                setElementData(object, "decay:lastTick", now)
                affected = affected + 1
                if health - damage <= 0 then
                    destroyObject(object, "decay", "Estrutura destruída pela deterioração.")
                end
            end
        end
    end
    return affected
end
