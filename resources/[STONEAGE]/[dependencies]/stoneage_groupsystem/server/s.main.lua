-- Reconstructed StoneAge group system.
-- Public event, export and client data contracts are kept compatible with the
-- client files shipped in this resource.

local SQL = exports.stoneage_sql
local Groups = {}
local Invites = {}
local MAX_MEMBERS = tonumber(MAX_MEMBERS_IN_GROUP) or 6
local ROLES = { Leader = 4, Sub = 3, Staff = 2, Member = 1 }

local function accountOf(player)
    if not isElement(player) or getElementType(player) ~= "player" then return false end
    local account = getElementData(player, "account")
    return type(account) == "string" and account ~= "" and account or false
end

local function notify(player, message, kind)
    if isElement(player) then
        triggerClientEvent(player, "stoneage:groupNotification", resourceRoot, message, kind or "error")
    end
end

local function saveGroup(group)
    if not group or type(group.Name) ~= "string" then return false end
    if SQL then
        return SQL:Exec(
            "INSERT OR REPLACE INTO `Groups` (`Name`, `Data`) VALUES (?, ?)",
            group.Name, toJSON(group)
        )
    end
    return false
end

local function deleteGroupRecord(name)
    if SQL then SQL:Exec("DELETE FROM `Groups` WHERE `Name` = ?", name) end
end

local function getGroupForAccount(account)
    for _, group in pairs(Groups) do
        if group.Members and group.Members[account] then return group end
    end
    return false
end

local function syncMemberData(group)
    for account in pairs(group.Members or {}) do
        for _, player in ipairs(getElementsByType("player")) do
            if accountOf(player) == account then
                setElementData(player, "Group", group.Name)
            end
        end
    end
end

local function sendGroupState(player)
    local account = accountOf(player)
    if not account then return end
    local group = getGroupForAccount(account)
    if group then
        setElementData(player, "Group", group.Name)
        triggerClientEvent(player, "ToggleGroupSystem", player, true, group)
    else
        setElementData(player, "Group", false)
        local pending = {}
        for _, invite in ipairs(Invites[account] or {}) do
            if Groups[invite.Name] then pending[#pending + 1] = invite end
        end
        triggerClientEvent(player, "ToggleGroupSystem", player, true, false, pending)
    end
end

local function isManager(member)
    return member and (member.Role == "Leader" or member.Role == "Sub" or member.Role == "Staff")
end

local function canManage(group, account)
    local member = group and group.Members and group.Members[account]
    return isManager(member), member
end

local function validGroupName(name)
    return type(name) == "string" and utf8.len(name) and utf8.len(name) >= 5 and utf8.len(name) <= 10
end

local function removeMember(group, account)
    if not group or not group.Members or not group.Members[account] then return false end
    group.Members[account] = nil
    for _, player in ipairs(getElementsByType("player")) do
        if accountOf(player) == account then setElementData(player, "Group", false) end
    end
    if not next(group.Members) then
        Groups[group.Name] = nil
        deleteGroupRecord(group.Name)
    else
        saveGroup(group)
    end
    return true
end

function GetAllGroups()
    return Groups
end

function GetGroup(name)
    return Groups[name] or false
end

function HasPermissionToOpenGroupDoor(groupName, account)
    -- The gamemode calls this export with (groupName, accountName).
    if type(groupName) ~= "string" or type(account) ~= "string" then return false end
    local group = Groups[groupName]
    local member = group and group.Members and group.Members[account]
    return member ~= nil and member.CanOpenDoors == true
end

function RemoveSerialFromGroup(serial)
    if type(serial) ~= "string" then return false end
    for _, player in ipairs(getElementsByType("player")) do
        if getPlayerSerial(player) == serial then
            local account = accountOf(player)
            local group = account and getGroupForAccount(account)
            if group then return removeMember(group, account) end
        end
    end
    return false
end

function DestroyGroup(name)
    local group = Groups[name]
    if not group then return false end
    for account in pairs(group.Members or {}) do
        for _, player in ipairs(getElementsByType("player")) do
            if accountOf(player) == account then setElementData(player, "Group", false) end
        end
    end
    Groups[name] = nil
    deleteGroupRecord(name)
    return true
end

function InsertMemberInGroup(groupName, playerOrAccount, role)
    local group = Groups[groupName]
    local account = isElement(playerOrAccount) and accountOf(playerOrAccount) or playerOrAccount
    if not group or type(account) ~= "string" or getGroupForAccount(account) then return false end
    if table.size(group.Members) >= (tonumber(group.MaxMembers) or MAX_MEMBERS) then return false end
    group.Members[account] = {
        Role = ROLES[role] and role or "Member",
        Nick = isElement(playerOrAccount) and getPlayerName(playerOrAccount) or account,
        CanOpenDoors = false,
    }
    saveGroup(group)
    if isElement(playerOrAccount) then setElementData(playerOrAccount, "Group", groupName) end
    return true
end

function SetGroupDescription(groupName, description)
    local group = Groups[groupName]
    if not group or type(description) ~= "string" or not utf8.len(description) or utf8.len(description) < 4 or utf8.len(description) > 30 then return false end
    group.Description = description
    return saveGroup(group)
end

function SetGroupLimit(groupName, limit)
    local group = Groups[groupName]
    limit = tonumber(limit)
    if not group or not limit or limit < table.size(group.Members) or limit > 50 then return false end
    group.MaxMembers = math.floor(limit)
    return saveGroup(group)
end

local function loadGroups()
    if not SQL then return end
    SQL:Exec("CREATE TABLE IF NOT EXISTS `Groups` (`Name` TEXT PRIMARY KEY, `Data` TEXT)")
    local rows = SQL:Query("SELECT `Data` FROM `Groups`")
    if type(rows) ~= "table" then return end
    for _, row in ipairs(rows) do
        local group = type(row.Data) == "string" and fromJSON(row.Data)
        if type(group) == "table" and type(group.Name) == "string" and type(group.Members) == "table" then
            Groups[group.Name] = group
        end
    end
end

addEvent("CreateGroup", true)
addEventHandler("CreateGroup", root, function(_player, name)
    local player = client
    local account = accountOf(player)
    if source ~= player or not account or getGroupForAccount(account) or not validGroupName(name) or Groups[name] then return end
    local group = {
        Name = name,
        Description = "Sem descrição",
        MaxMembers = MAX_MEMBERS,
        Members = {
            [account] = { Role = "Leader", Nick = getPlayerName(player), CanOpenDoors = true }
        }
    }
    Groups[name] = group
    setElementData(player, "Group", name)
    saveGroup(group)
    sendGroupState(player)
end)

addEvent("AcceptGroupInvite", true)
addEventHandler("AcceptGroupInvite", root, function(name)
    local player, account = client, accountOf(client)
    if source ~= player or not account or type(name) ~= "string" then return end
    local pending = Invites[account] or {}
    local found = false
    for i = #pending, 1, -1 do
        if pending[i].Name == name then table.remove(pending, i); found = true end
    end
    Invites[account] = pending
    if found and InsertMemberInGroup(name, player, "Member") then sendGroupState(player) end
end)

addEvent("InvitePlayer", true)
addEventHandler("InvitePlayer", root, function(target)
    local player, account = client, accountOf(client)
    if source ~= player or not account or not isElement(target) or getElementType(target) ~= "player" then return end
    local group = getGroupForAccount(account)
    local allowed = canManage(group, account)
    local targetAccount = accountOf(target)
    if not allowed or not targetAccount or getGroupForAccount(targetAccount) or target == player then return end
    local list = Invites[targetAccount] or {}
    for _, invite in ipairs(list) do if invite.Name == group.Name then return end end
    list[#list + 1] = { Name = group.Name, Inviter = getPlayerName(player) }
    Invites[targetAccount] = list
    sendGroupState(target)
end)

addEvent("SetMemberRole", true)
addEventHandler("SetMemberRole", root, function(groupName, targetAccount, role)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    local allowed, actor = canManage(group, account)
    local target = group and group.Members and group.Members[targetAccount]
    if source ~= player or not allowed or not target or actor.Role == "Sub" and role ~= "Member" then return end
    if target.Role == "Leader" or target.Role == "Staff" or not ROLES[role] or role == "Leader" then return end
    if actor.Role == "Staff" and role ~= "Member" and role ~= "Sub" then return end
    target.Role = role
    saveGroup(group)
    for _, p in ipairs(getElementsByType("player")) do if accountOf(p) == account then sendGroupState(p) end end
end)

addEvent("KickPlayer", true)
addEventHandler("KickPlayer", root, function(groupName, targetAccount)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    local allowed, actor = canManage(group, account)
    local target = group and group.Members and group.Members[targetAccount]
    if source ~= player or not allowed or not target or target.Role == "Leader" or target.Role == "Staff" then return end
    if actor.Role == "Staff" and target.Role ~= "Member" then return end
    removeMember(group, targetAccount)
    sendGroupState(player)
end)

addEvent("AllowMemberToOpenDoor", true)
addEventHandler("AllowMemberToOpenDoor", root, function(groupName, targetAccount, allow)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    local allowed = canManage(group, account)
    local target = group and group.Members and group.Members[targetAccount]
    if source ~= player or not allowed or not target or target.Role == "Leader" then return end
    target.CanOpenDoors = allow == true
    saveGroup(group)
end)

addEvent("SetGroupDescription", true)
addEventHandler("SetGroupDescription", root, function(groupName, description)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    local allowed = canManage(group, account)
    if source ~= player or not allowed then return end
    if SetGroupDescription(groupName, description) then sendGroupState(player) end
end)

addEvent("DestroyGroup", true)
addEventHandler("DestroyGroup", root, function(groupName)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    if source ~= player or not group or not group.Members[account] or group.Members[account].Role ~= "Leader" then return end
    DestroyGroup(groupName)
    sendGroupState(player)
end)

addEvent("LeaveGroup", true)
addEventHandler("LeaveGroup", root, function(groupName)
    local player, account = client, accountOf(client)
    local group = Groups[groupName]
    if source ~= player or not group or not group.Members[account] or group.Members[account].Role == "Leader" then return end
    removeMember(group, account)
    sendGroupState(player)
end)

local function bindGroupKey(player)
    if isElement(player) then bindKey(player, "F1", "down", sendGroupState) end
end

addEventHandler("onResourceStart", resourceRoot, function()
    loadGroups()
    for _, player in ipairs(getElementsByType("player")) do\n        bindGroupKey(player)\n        local account = accountOf(player)\n        local group = account and getGroupForAccount(account)\n        if group then setElementData(player, "Group", group.Name) end\n    end
end)
addEventHandler("onPlayerJoin", root, function() bindGroupKey(source) end)
addEventHandler("onElementDataChange", root, function(key, _, value)
    if key == "account" and getElementType(source) == "player" and value then
        local account = accountOf(source)
        local group = account and getGroupForAccount(account)
        if group then
            setElementData(source, "Group", group.Name)
            group.Members[account].Nick = getPlayerName(source)
            saveGroup(group)
        end
    end
end)
addEventHandler("onPlayerQuit", root, function()
    local account = accountOf(source)
    local group = account and getGroupForAccount(account)
    if group and group.Members[account] then
        group.Members[account].Nick = getPlayerName(source)
        saveGroup(group)
    end
end)
