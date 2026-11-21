Dummys = {
    Sentry = createElement('Dummy', 'Sentry'),
}

addEvent('onPlayerCraftObject', true)
addEvent('onPlayerCraftItem', true)

local lastCraftRequest = {}

loadEvent('OnCraftObject', root, function(obName, pos)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return false
    end
    if getElementData(player, 'isDead') or not getElementData(player, 'account') then
        return false
    end
    if type(obName) ~= 'string' or type(pos) ~= 'table' or #pos ~= 6 then
        return false
    end

    local model = getObModel(obName)
    local custo = getObjectDataSetting(obName, 'craftingCusto')
    if not model or type(custo) ~= 'table' then
        return false
    end

    for i = 1, 6 do
        local value = pos[i]
        if type(value) ~= 'number' or value ~= value or math.abs(value) > 100000 then
            return false
        end
    end

    local px, py, pz = getElementPosition(player)
    if getDistanceBetweenPoints3D(px, py, pz, pos[1], pos[2], pos[3]) > 15 then
        return false
    end

    local now = getTickCount()
    if lastCraftRequest[player] and now - lastCraftRequest[player] < 1000 then
        return false
    end
    lastCraftRequest[player] = now

    local staff = getElementData(player, 'staffRole2') or isAdmin(player)
    local countName = isBaseItem(obName) and 'baseItems' or obName
    local limit = getObjectLimit(countName, player)
    if not staff and limit and (getElementData(player, countName) or 0) >= limit then
        exports['stoneage_notifications']:CreateNotification(player, translate(player, 'Atingiu limite de %s', nil, translate(player, countName, 'name')), 'error')
        return false
    end

    if not staff then
        for _, entry in ipairs(custo) do
            if type(entry) ~= 'table' or type(entry[1]) ~= 'string' or type(entry[2]) ~= 'number' or entry[2] < 0 then
                return false
            end
            local cost = entry[2]
            if entry[1] == 'Level' and isVIP(player) then
                cost = math.floor(cost * 0.75)
            end
            if (getElementData(player, entry[1]) or 0) < cost then
                local str = exports['stoneage_translations']:translate(player, 'Você precisa de mais %s.', nil, exports['stoneage_translations']:translate(player, entry[1], 'name'))
                exports['stoneage_notifications']:CreateNotification(player, str, 'info')
                return false
            end
        end

        -- Charge only after every requirement has been validated.
        for _, entry in ipairs(custo) do
            if entry[1] ~= 'Level' then
                setElementData(player, entry[1], (getElementData(player, entry[1]) or 0) - entry[2])
            end
        end
    end

    createNewObject(obName, pos)
end)

-- //------------------- CREATE NEW OBJECT -------------------\\--
function createNewObject(obName, pos)
    client = client or source
    local model = obName and getObModel(obName)
    if model then
        local acc = getElementData(source, 'account')
        if acc then
            local x, y, z, rx, ry, rz = unpack(pos)

            local ob = createObject(model, x, y, z, rx, ry, rz)
            setElementData(ob, 'owner', acc)
            setElementData(ob, 'obName', obName)

            setElementData(ob, 'health', getObjectDataSetting(obName, 'maxHealth') or 1000)
            setElementData(ob, 'maxSlots', getObjectDataSetting(obName, 'maxSlots') or nil)
            setElementData(ob, 'creationTime', getTimeString())
            setElementFrozen(ob, true)

            if isBaseItem(obName) then
                setElementData(client, 'baseItems', (getElementData(client, 'baseItems') or 0) + 1)
                setElementData(ob, 'baseObject', true)
                setElementData(ob, 'obType', getObjectDataSetting(obName, 'Type'))

            else
                if playerDataTable[obName] then
                    setElementData(client, obName, (getElementData(client, obName) or 0) + 1)
                end
            end

            if obName == 'Wardrobe' then
                setElementData(ob, 'wardrobe:permissions', {
                    [acc] = getPlayerName(source),
                })
                setElementID(ob, ('wardrobe:%s'):format(acc))

                addEventHandler('onElementDataChange', ob, onWardrobeDataChange)

            elseif obName == 'Cama' then
                setElementID(ob, ('cama:%s'):format(acc))

            elseif obName == 'Poço' then
                setElementData(ob, 'poço:water', 0)

            elseif obName == 'Placa' then
                setElementData(ob, 'placa:text', 'YOU SERVER NAME')

            elseif obName == 'Sentry' then
                setElementData(ob, 'sentry:ammo', 0)
                setElementParent(ob, Dummys.Sentry)
                exports['stoneage_sentrys']:InitSentry(ob)

            elseif obName == 'Fornalha' then
                initFurnance(ob)

            elseif obName == 'Espetos' then
                initEspeto(ob)

            elseif obName == 'Fogueira' then
                setTimer(function(ob)
                    if isElement(ob) then
                        destroyObject(ob)
                    end
                end, 3600000, 1, ob)
            end

            LOGS:saveLog('craft', ('%s ["%s"] acabou de craftar um "%s" em %s (%s)'):format(getPlayerName(source), acc, obName, getZoneName(x, y, z), getZoneName(x, y, z, true)))

            local has = getElementData(source, (isBaseItem(obName) and 'baseItems' or obName)) or 0
            local limit = getObjectLimit(obName, source)
            triggerEvent('onPlayerCraftObject', source, ob, has, limit)

            addObjectToDatabase(ob, obName)

            removeElementData(source, 'WaitingResponse')

        end
    end
end
-- Server-only helper: object creation is routed through the validated OnCraftObject handler.
-- //------------------- CREATE NEW OBJECT -------------------\\--

-- //------------------- DESTROY OBJECT -------------------\\--
function destroyObject(ob, logType, logMessage)
    if ob and isElement(ob) then
        local obName = getElementData(ob, 'obName')
        if obName then
            local x, y, z = getElementPosition(ob)
            local invOrder = getElementData(ob, 'invOrder')
            if invOrder then
                for k, v in pairs(invOrder) do
                    local have = getElementData(ob, v.itemName) or 0
                    if have > 0 then
                        exports['stoneage_pickups']:createSack(x, y, z, {{v.itemName, v.quantity}})
                    end
                end
            end

            local dataName = isBaseItem(obName) and 'baseItems' or obName

            local owner = getElementData(ob, 'owner')
            local player = getAccountPlayer(owner)
            local ownerGroup = 'Sem Grupo.'
            local ownerNick

            if player then
                local newValue = math.max(0, (getElementData(player, dataName) or 0) - 1)
                if (newValue > 0) then
                    setElementData(player, dataName, newValue)
                else
                    removeElementData(player, dataName)
                end
                ownerGroup = getElementData(player, 'Group')
                ownerNick = getPlayerName(player)
            else
                ownerGroup = GetAccountData(owner, 'Group')
                ownerNick = GetAccountData(owner, 'lastNick')
                local newValue = math.max(0, (GetAccountData(owner, dataName) or 0) - 1)
                SQL:Exec('UPDATE `Accounts` SET ?=? WHERE `Owner`=? ', dataName, ((newValue > 0) and newValue) or nil, owner)
                ClearAccountDataCache(owner)
            end

            if logType and logMessage and isElement(source) then

                local info = ''
                local data = {
                    ['Localização: '] = ('%s (%s)'):format(getZoneName(x, y, z), getZoneName(x, y, z, true)),
                    ['Grupo do dono deste objeto'] = ownerGroup,
                    ['Nome do dono deste objeto'] = ownerNick,
                    ['Posição'] = inspect {x, y, z},
                }

                for k, v in pairs(data) do
                    info = info .. ('%s: %s\n'):format(k, tostring(v))
                end

                local embeds = {{
                    ['description'] = logMessage,
                    ['color'] = 0xFFFF00,
                    ['fields'] = {{
                        name = 'Dados:',
                        value = ('```%s```'):format(info),
                    }, {
                        name = ('Dados de %s:'):format(getPlayerName(source)),
                        value = ('```IP: %s\nSerial: %s\nGrupo: %s```'):format(getPlayerIP(source), getPlayerSerial(source), getElementData(source, 'Group') or 'Sem grupo.'),
                    }},
                }}

                exports['stoneage_logs']:sendDiscordLog('object-destroy', embeds)

                LOGS:saveLog(logType, logMessage)
            end

            removeObjectFromDatabase(ob)
            destroyElement(ob)
        end
    end
end
loadEvent('craft:destroyObject', root, function(ob, logType, logMessage)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return false
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(player, 'isDead') then
        return false
    end

    local owner = getElementData(ob, 'owner')
    if not owner then
        return false
    end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob) then
        return false
    end
    local distance = getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz)

    if logType == 'object-destroy' then
        if owner ~= getElementData(player, 'account') and not isAdmin(player) then
            return false
        end
        if distance > 8 then
            return false
        end
    elseif logType == 'raid' then
        if (getElementData(ob, 'health') or 1) > 0 or distance > 250 then
            return false
        end
    else
        return false
    end

    if type(logMessage) ~= 'string' then
        logMessage = nil
    else
        logMessage = logMessage:sub(1, 1000)
    end

    return destroyObject(ob, logType, logMessage)
end)
-- //------------------- DESTROY OBJECT -------------------\\--

-- //------------------- CRAFTING ANIMATION -------------------\\--
loadEvent('craft:togglePedAnimation', root, function(state, fromPlanner)
    if not isElement(client) or source ~= client or getElementData(client, 'isDead') then
        return
    end
    if state then
        detachItemFromBone('Planner', client)

        if not fromPlanner then
            attachItemToBone('Planner', client)
        end

        setAttachModel('Planner', client, 3111)
        setAttachOffsets('Planner', client, 0.1, 0.35, 0.25, -160, 0, 0, 11)

        setElementFrozen(client, true)
        setPedAnimation(client, 'SnM', 'Spanking_IdleP', -1, true, false, false, true)
    else
        detachItemFromBone('Planner', client)
        if fromPlanner then
            attachItemToBone('Planner', client)
        end
        setElementFrozen(client, false)
        setPedAnimation(client)
    end
end)
-- //------------------- CRAFTING ANIMATION -------------------\\--

-- //------------------- EVOLVE OBJECT -------------------\\--
function evolveObject(ob, newObjectName)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return false
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(player, 'isDead') then
        removeElementData(player, 'WaitingResponse')
        return false
    end
    if not getElementData(player, 'account') then
        removeElementData(player, 'WaitingResponse')
        return false
    end

    local owner = getElementData(ob, 'owner')
    if owner ~= getElementData(player, 'account') and not isAdmin(player) then
        removeElementData(player, 'WaitingResponse')
        return false
    end

    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 8 then
        removeElementData(player, 'WaitingResponse')
        return false
    end

    local oldObjectName = getElementData(ob, 'obName')
    local allowedEvolution = oldObjectName and getObjectDataSetting(oldObjectName, 'evolutionTo')
    local model = type(newObjectName) == 'string' and getObModel(newObjectName)
    if not allowedEvolution or allowedEvolution ~= newObjectName or not model then
        removeElementData(player, 'WaitingResponse')
        return false
    end

    local staff = isAdmin(player)
    local custo = getObjectDataSetting(newObjectName, 'craftingCusto')
    if not staff then
        if type(custo) ~= 'table' then
            removeElementData(player, 'WaitingResponse')
            return false
        end
        for _, entry in ipairs(custo) do
            if type(entry) ~= 'table' or type(entry[1]) ~= 'string' or type(entry[2]) ~= 'number' or entry[2] < 0 then
                removeElementData(player, 'WaitingResponse')
                return false
            end
            local cost = entry[2]
            if entry[1] == 'Level' and isVIP(player) then
                cost = math.floor(cost * 0.75)
            end
            if (getElementData(player, entry[1]) or 0) < cost then
                local str = ('Você precisa de mais %s.'):format(translate(player, entry[1], 'name'))
                exports['stoneage_notifications']:CreateNotification(player, str, 'error')
                removeElementData(player, 'WaitingResponse')
                return false
            end
        end

        local limit = getObjectLimit(newObjectName, player)
        if limit and (getElementData(player, newObjectName) or 0) + 1 > limit then
            local str = translate(player, 'Atingiu limite de %s', nil, translate(player, newObjectName, 'name'))
            exports['stoneage_notifications']:CreateNotification(player, str, 'error')
            removeElementData(player, 'WaitingResponse')
            return false
        end

        for _, entry in ipairs(custo) do
            if entry[1] ~= 'Level' then
                setElementData(player, entry[1], (getElementData(player, entry[1]) or 0) - entry[2])
            end
        end
    end

    if not isBaseItem(oldObjectName) then
        setElementData(player, oldObjectName, math.max(0, (getElementData(player, oldObjectName) or 0) - 1))
        setElementData(player, newObjectName, (getElementData(player, newObjectName) or 0) + 1)
    end

    local allData = getAllElementData(ob)
    local x, y, z = getElementPosition(ob)
    local rx, ry, rz = getElementRotation(ob)
    local objID = getElementData(ob, 'objID')

    destroyElement(ob)

    local newOb = createObject(model, x, y, z, rx, ry, rz)
    if not newOb then
        removeElementData(player, 'WaitingResponse')
        return false
    end
    setElementFrozen(newOb, true)
    setElementData(newOb, 'maxSlots', getObjectDataSetting(newObjectName, 'maxSlots') or nil)

    for key, value in pairs(allData) do
        if key ~= 'obName' and key ~= 'invOrder' and key ~= 'maxSlots' then
            setElementData(newOb, key, value)
        end
    end

    setElementData(newOb, 'invOrder', allData['invOrder'])
    setElementData(newOb, 'obName', newObjectName)
    setElementData(newOb, 'health', getObjectDataSetting(newObjectName, 'maxHealth') or 1000)

    if objID then
        SQL:Exec('UPDATE `Objects` SET `Name`=?, `health`=? WHERE `ObjectID`=?', newObjectName, getObjectDataSetting(newObjectName, 'maxHealth') or 1000, objID)
    end

    removeElementData(player, 'WaitingResponse')
    return true
end
loadEvent('craft:evolveObject', root, evolveObject)
-- //------------------- EVOLVE OBJECT -------------------\\--

-- //------------------- ADD PERMISSION TO WARDROBE -------------------\\--
function addPermissionsToWardrobe(ob, targetPlayer)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(ob, 'obName') ~= 'Wardrobe' then
        return
    end
    if not isElement(targetPlayer) or getElementType(targetPlayer) ~= 'player' or targetPlayer == player then
        return
    end
    if getElementData(ob, 'owner') ~= getElementData(player, 'account') and not isAdmin(player) then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 6 then
        return
    end

    local serial = getElementData(targetPlayer, 'account')
    if serial then
        local permissions = getElementData(ob, 'wardrobe:permissions') or {}
        permissions[serial] = getPlayerName(targetPlayer)
        setElementData(ob, 'wardrobe:permissions', permissions)
    end
end
loadEvent('wardrobe:addPermission', root, addPermissionsToWardrobe)
-- //------------------- ADD PERMISSION TO WARDROBE -------------------\\--

-- //------------------- REMOVE PERMISSION FROM WARDROBE -------------------\\--
function removePermissionsFromWardrobe(ob, nick)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return
    end
    if type(nick) ~= 'string' or not isElement(ob) or getElementType(ob) ~= 'object'
        or getElementData(ob, 'obName') ~= 'Wardrobe' then
        return
    end
    if getElementData(ob, 'owner') ~= getElementData(player, 'account') and not isAdmin(player) then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 6 then
        return
    end

    local permissions = getElementData(ob, 'wardrobe:permissions')
    if type(permissions) ~= 'table' then
        return
    end
    for serial, targetNick in pairs(permissions) do
        if nick == targetNick then
            if serial ~= getElementData(player, 'account') then
                permissions[serial] = nil
            else
                exports['stoneage_notifications']:CreateNotification(player, translate(player, 'nao pode remover permissão propria'), 'info')
            end
            break
        end
    end
    setElementData(ob, 'wardrobe:permissions', permissions)
end
loadEvent('wardrobe:removePermission', root, removePermissionsFromWardrobe)
-- //------------------- REMOVE PERMISSION FROM WARDROBE -------------------\\--

-- //------------------- CHECK IF ITS A FRIENDLY DOOR -------------------\\--
function isFriendlyDoor(ob, player)
    if ob and isElement(ob) and getElementType(ob) == 'object'
        and player and isElement(player) and getElementType(player) == 'player' then
        if getElementData(player, 'isDead') then
            return false
        end
        local px, py, pz = getElementPosition(player)
        local ox, oy, oz = getElementPosition(ob)
        if getElementDimension(player) ~= getElementDimension(ob)
            or getElementInterior(player) ~= getElementInterior(ob)
            or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 4 then
            return false
        end
        if isAdmin(player) then
            return true
        end

        local acc = getElementData(player, 'account')
        local owner = getElementData(ob, 'owner')

        if acc and owner then
            if acc == owner then
                return true
            end
            local playerOwner = getAccountPlayer(owner)

            local doorGroup
            if playerOwner then
                doorGroup = getElementData(playerOwner, 'Group')
            else
                doorGroup = GetAccountData(owner, 'Group')
            end
            if not doorGroup then
                exports['stoneage_notifications']:CreateNotification(player, translate(player, 'sem grupo'), 'error')
                return false
            end
            if doorGroup ~= getElementData(player, 'Group') then
                exports['stoneage_notifications']:CreateNotification(player, translate(player, 'grupos diferentes'), 'error')
                return false
            end

            if not exports['stoneage_groupsystem']:HasPermissionToOpenGroupDoor(doorGroup, acc) then
                exports['stoneage_notifications']:CreateNotification(player, translate(player, 'permissao porta'), 'error')
                return false
            end

            return true
        end
    end
    return false
end
-- //------------------- CHECK IF ITS A FRIENDLY DOOR -------------------\\--

-- //------------------- OPEN DOOR -------------------\\--
local moving = {}
function abrirPorta(ob, direction)
    local player = client
    if not isElement(player) or source ~= player or getElementData(player, 'isDead') then return end
    if ob and isElement(ob) and (not moving[ob]) then
        if isFriendlyDoor(ob, player) then

            setPedAnimation(player, 'crib', 'crib_use_switch', -1, false, false, false, false)

            local x, y = UTILS:getPositionFromElementOffset(ob, 0.6, 0, 0)
            local px, py = getElementPosition(player)
            local pedZ = findRotation(px, py, x, y)
            setElementRotation(player, 0, 0, pedZ, 'default', true)

            setTimer(function(direction, ob)
                if isElement(ob) then
                    local x, y, z = getElementPosition(ob)
                    local newRot = direction and 90 or -90

                    moving[ob] = true
                    moveObject(ob, 1000, x, y, z, 0, 0, newRot, 'OutBounce')
                    setElementCollisionsEnabled(ob, false)

                    setTimer(function(ob, newRot)
                        if isElement(ob) then
                            local x, y, z = getElementPosition(ob)
                            moveObject(ob, 1300, x, y, z, 0, 0, -newRot, 'OutBounce')
                            setTimer(function(ob)
                                if isElement(ob) then
                                    setElementCollisionsEnabled(ob, true)
                                end
                                setTimer(function(ob)
                                    moving[ob] = nil
                                end, 500, 1, ob)
                            end, 1350, 1, ob)
                        else
                            moving[ob] = nil
                        end
                    end, 1300, 1, ob, newRot)
                end
            end, 500, 1, direction, ob)

        end
    end
end
loadEvent('craft:abrirPorta', root, abrirPorta)
-- //------------------- OPEN DOOR -------------------\\--

-- //------------------- OPEN GATE -------------------\\--
function abrirPortao(ob, direction)
    local player = client
    if not isElement(player) or source ~= player or getElementData(player, 'isDead') then return end
    if ob and isElement(ob) and not moving[ob] then
        if isFriendlyDoor(ob, player) then
            local rx, ry, rz = getElementRotation(ob)

            local openedModels = getObjectDataSetting(getElementData(ob, 'obName'), 'openedModels')
            if not openedModels then
                return
            end

            setPedAnimation(player, 'crib', 'crib_use_switch', -1, false, false, false, false)

            local x, y = UTILS:getPositionFromElementOffset(ob, 0.75, 0, 0)
            local px, py = getElementPosition(player)
            local pedZ = findRotation(px, py, x, y)
            setElementRotation(player, 0, 0, pedZ)

            setTimer(function(ob)
                if isElement(ob) and (not moving[ob]) then
                    local leftX, leftY, leftZ = UTILS:getPositionFromElementOffset(ob, 2.23, 0, 0)
                    local leftSide = createObject(openedModels.left, leftX, leftY, leftZ, rx, ry, rz)
                    setElementCollisionsEnabled(leftSide, false)

                    local newRotLeft = direction and -90 or 90
                    moveObject(leftSide, 2000, leftX, leftY, leftZ, 0, 0, newRotLeft, 'OutBounce')

                    local rightX, rightY, rightZ = UTILS:getPositionFromElementOffset(ob, -2.23, 0, 0)
                    local rightSide = createObject(openedModels.right, rightX, rightY, rightZ, rx, ry, rz)
                    setElementCollisionsEnabled(rightSide, false)

                    local newRotRight = direction and 90 or -90
                    moveObject(rightSide, 2000, rightX, rightY, rightZ, 0, 0, newRotRight, 'OutBounce')

                    moving[ob] = {
                        leftSide = leftSide,
                        rightSide = rightSide,
                    }

                    addEventHandler('onElementDestroy', ob, onOpeningGateDestroy)

                    moving[ob].Timer = setTimer(function(ob, leftSide, rotLeft, rightSide, rotRight)
                        if isElement(ob) then
                            if isElement(leftSide) then
                                local x, y, z = getElementPosition(leftSide)
                                moveObject(leftSide, 2000, x, y, z, 0, 0, rotLeft == 90 and -90 or 90, 'OutBounce')
                            end
                            if isElement(rightSide) then
                                local x, y, z = getElementPosition(rightSide)
                                moveObject(rightSide, 2000, x, y, z, 0, 0, rotRight == 90 and -90 or 90, 'OutBounce')
                            end
                            setTimer(function(ob, leftSide, rightSide)
                                if isElement(ob) then
                                    setElementAlpha(ob, 255)
                                    setElementCollisionsEnabled(ob, true)
                                end
                                if isElement(leftSide) then
                                    destroyElement(leftSide)
                                end
                                if isElement(rightSide) then
                                    destroyElement(rightSide)
                                end
                                moving[ob] = nil
                            end, 2000, 1, ob, leftSide, rightSide)
                            removeEventHandler('onElementDestroy', ob, onOpeningGateDestroy)
                        else
                            moving[ob] = nil
                        end
                    end, 15000, 1, ob, leftSide, newRotLeft, rightSide, newRotRight)

                    setElementAlpha(ob, 0)
                    setElementCollisionsEnabled(ob, false)
                else
                    moving[ob] = nil
                end
            end, 500, 1, ob)
        end
    end
end
loadEvent('craft:abrirPortão', root, abrirPortao)

onOpeningGateDestroy = function()
    if moving[source] then
        if isElement(moving[source].leftSide) then
            destroyElement(moving[source].leftSide)
        end
        if isElement(moving[source].rightSide) then
            destroyElement(moving[source].rightSide)
        end
        if isTimer(moving[source].Timer) then
            killTimer(moving[source].Timer)
        end
        moving[source] = nil
    end
end
-- //------------------- OPEN GATE -------------------\\--

-- //------------------- ON BEAT DOOR -------------------\\--
loadEvent('craft:beatDoor', root, function(ob)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 4 then
        return
    end
    setElementFrozen(player, false)
    setPedAnimation(player, 'BASEBALL', 'Bat_M', -1, true, false, false, false)
    local x, y, z = getElementPosition(ob)
    triggerEvent('rust:play3DSound', player, ':gamemode/files/sounds/door.mp3', {x, y, z})

    setTimer(function(ped)
        if not isElement(ped) then
            return
        end
        setElementFrozen(ped, false)
        setPedAnimation(ped)
    end, 2700, 1, player)
end)
-- //------------------- ON BEAT DOOR -------------------\\--

-- //------------------- COLLECT WATER FROM WELL -------------------\\--
loadEvent('craft:collectWaterFromWell', root, function(ob)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(ob, 'obName') ~= 'Poço' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 5 then
        return
    end

    local waterLevel = getElementData(ob, 'poço:water')
    if type(waterLevel) ~= 'number' then
        return
    end

    local NOTIFICATION = exports['stoneage_notifications']

    local equippedID = getElementData(player, 'equippedSlotID')
    if not equippedID then
        return NOTIFICATION:CreateNotification(player, translate(player, 'Precisa ter %s em mãos', nil, translate(player, 'Empty Bottle', 'name')), 'error')
    end

    local order = getElementData(player, 'keybarOrder')
    if not order or not order[equippedID] or order[equippedID].itemName ~= 'Empty Bottle' then
        return NOTIFICATION:CreateNotification(player, translate(player, 'Precisa ter %s em mãos', nil, translate(player, 'Empty Bottle', 'name')), 'error')
    end

    if waterLevel <= 20 then
        return NOTIFICATION:CreateNotification(player, translate(player, 'Agua insuficiente'), 'error')
    end

    order[equippedID].itemName = 'Water'
    setElementData(player, 'keybarOrder', order)
    setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false)
    onPlayerDisequipItem(equippedID, player)
    triggerClientEvent(player, 'playerUseItem', player, 'Water', equippedID)
end)
-- //------------------- COLLECT WATER FROM WELL -------------------\\--

-- //------------------- EXPLOSIVE SYSTEM -------------------\\--
loadEvent('craft:plantExplosive', root, function(explosiveName, x, y, z)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if explosiveName ~= 'C4' and explosiveName ~= 'Satchel' then
        return
    end
    if type(x) ~= 'number' or type(y) ~= 'number' or type(z) ~= 'number'
        or x ~= x or y ~= y or z ~= z then
        return
    end
    local px, py, pz = getElementPosition(player)
    if getDistanceBetweenPoints3D(px, py, pz, x, y, z) > 5 then
        return
    end

    local equippedID = getElementData(player, 'equippedSlotID')
    if not equippedID then
        return
    end

    local order = getElementData(player, 'keybarOrder')
    if not order or not order[equippedID] or order[equippedID].itemName ~= explosiveName then
        return
    end

    local attachSettings = getPlayerDataSetting(explosiveName, 'attach')
    if not attachSettings then
        return
    end

    order[equippedID].quantity = order[equippedID].quantity - 1
    if order[equippedID].quantity <= 0 then
        order[equippedID] = nil
        onPlayerDisequipItem(equippedID, player)
        triggerClientEvent(player, 'inv:disequipCurrentKeybarItem', player)
    end

    setElementData(player, 'keybarOrder', order)

    local modelID = attachSettings.modelID
    local rot = findRotation(px, py, x, y)
    local ob = createObject(modelID, x, y, z, 0, 0, rot)
    if not ob then
        return
    end
    setElementDimension(ob, getElementDimension(player))
    setElementInterior(ob, getElementInterior(player))
    setElementFrozen(ob, true)
    setElementData(ob, 'plantedExplosive', true)

    exports['stoneage_sound3D']:play3DSound(':gamemode/files/sounds/c4.mp3', {x, y, z}, 0.5, 150)

    setTimer(function(player, type, ob, x, y, z)
        if isElement(ob) then
            destroyElement(ob)
        end

        local explosionID
        if type == 'C4' then
            explosionID = 0
        elseif type == 'Satchel' then
            explosionID = 3
        end
        if explosionID then
            createExplosion(x, y, z, explosionID, player)
        end
    end, 8000, 1, player, explosiveName, ob, x, y, z)
    -- end, 2800, 1, source, explosiveName, ob, x, y, z)

    setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false)
end)
-- //------------------- EXPLOSIVE SYSTEM -------------------\\--

local movingObjects = {}
loadEvent('craft:startMovingObject', root, function(ob)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or movingObjects[ob] or movingObjects[player] then
        return
    end
    if getElementData(player, 'isDead') or not getElementData(player, 'account') then
        return
    end

    local owner = getElementData(ob, 'owner')
    if owner ~= getElementData(player, 'account') and not isAdmin(player) then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 8 then
        return
    end

    movingObjects[player] = ob
    movingObjects[ob] = player
    setElementCollisionsEnabled(ob, false)
    addEventHandler('onPlayerQuit', player, restoreMovingObjectCollision)

    if getElementData(ob, 'baseObject') then
        triggerClientEvent(player, 'base:startMovingObject', player, ob)
    else
        triggerClientEvent(player, 'craft:startMovingObject', player, ob)
    end
end)

loadEvent('craft:stopMovingObject', root, function(ob)
    if not movingObjects[ob] or not movingObjects[source] then
        return
    end

    movingObjects[source] = nil
    movingObjects[ob] = nil

    if isElement(ob) then
        setElementCollisionsEnabled(ob, true)
    end

    removeEventHandler('onPlayerQuit', source, restoreMovingObjectCollision)
end)

function restoreMovingObjectCollision()
    local ob = movingObjects[source]
    if ob then
        movingObjects[ob] = nil
        movingObjects[source] = nil

        if isElement(ob) then
            setElementCollisionsEnabled(ob, true)
        end
    end
end

loadEvent('craft:saveObjectPosition', root, function(ob, x, y, z, rx, ry, rz)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player then
        return
    end
    if not isElement(ob) or movingObjects[player] ~= ob or movingObjects[ob] ~= player then
        return
    end
    if getElementData(ob, 'owner') ~= getElementData(player, 'account') and not isAdmin(player) then
        return
    end

    local values = {x, y, z, rx, ry, rz}
    for i = 1, 6 do
        if type(values[i]) ~= 'number' or values[i] ~= values[i] or math.abs(values[i]) > 100000 then
            return
        end
    end

    local px, py, pz = getElementPosition(player)
    if getDistanceBetweenPoints3D(px, py, pz, x, y, z) > 20 then
        return
    end

    setElementPosition(ob, x, y, z)
    setElementRotation(ob, rx, ry, rz)

    local id = getElementData(ob, 'objID')
    if id then
        SQL:Exec('UPDATE `Objects` SET `Position`=? WHERE `ObjectID`=?', toJSON({x, y, z, rx, ry, rz}), id)
    end

    for _, attached in ipairs(getAttachedElements(ob)) do
        local xx, yy, zz, rxx, ryy, rzz = getElementAttachedOffsets(attached)
        xx, yy, zz = UTILS:getPositionFromElementOffset(ob, xx, yy, zz)
        setElementPosition(attached, xx, yy, zz)
        setElementRotation(attached, rx + rxx, ry + ryy, rz + rzz)
    end
end)

local windowModelStates = {
    [2052] = 1782,
    [1782] = 2052,
    [7521] = 1903,
    [1903] = 7521,
    [5781] = 6875,
    [6875] = 5781,
    [5452] = 5403,
    [5403] = 5452,
    [8954] = 10951,
    [10951] = 8954,
}

loadEvent('craft:abrirJanela', root, function(ob)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or not isElement(ob) or getElementType(ob) ~= 'object' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 4 then
        return
    end

    local newModel = windowModelStates[getElementModel(ob)]
    if newModel then
        setPedAnimation(player, 'crib', 'crib_use_switch', -1, false, false, false, false)
        setTimer(function(ob, newModel)
            if isElement(ob) then
                setElementModel(ob, newModel)
            end
        end, 500, 1, ob, newModel)
    end
end)

wardrobeHaveSustain = function(ob)
    local creator = isElement(ob) and getElementData(ob, 'owner')
    if creator then
        local Query = SQL:Query('SELECT * FROM `VIPS` WHERE `Serial`=?', creator)
        local isVIP = (#Query > 0)
        for k, v in pairs(getRequiresByOwner(creator)) do
            local needed = v
            if isVIP then
                needed = math.floor(v / 2)
            end
            if (getElementData(ob, k) or 0) < needed then
                return false
            end
        end
    end
    return true
end

removeSustain = function(ob)
    local creator = isElement(ob) and getElementData(ob, 'owner')
    if creator then
        local Query = SQL:Query('SELECT * FROM `VIPS` WHERE `Serial`=?', creator)
        local isVIP = (#Query > 0)
        for k, v in pairs(getRequiresByOwner(creator)) do
            if isVIP then
                setElementData(ob, k, (getElementData(ob, k) or 0) - math.floor(v / 2))
            else
                setElementData(ob, k, (getElementData(ob, k) or 0) - v)
            end
        end
    end
    return true
end

onWardrobeDataChange = function(key, old, new)
    if key == 'Locker' then
        if (new or 0) <= 0 then
            removeElementData(source, 'wardrobe:password')
        end
    end
end

-- DECAY
-- setTimer(function()
--     local time = getRealTime()
--     if (time.hour == 0 or time.hour == 12) and (time.minute == 0) then
--         RunDecay()
--     end
-- end, 50000, 0)

RunDecay = function()
    local sustainCache = {}
    local damageLoss = exports['stoneage_settings']:getConfig('Dano Decay', 150)

    Async:foreach(getElementsByType('object', resourceRoot), function(ob)
        if isElement(ob) and not isElementLowLOD(ob) then
            local owner = getElementData(ob, 'owner')
            if owner then
                local obName = getElementData(ob, 'obName') or 'unknown (' .. getElementModel(ob) .. ')'
                local x, y, z = getElementPosition(ob)
                local str = 'Um "%s" de "%s" acabou de ser destruido por decay em %s (%s).'
                local logMessage = (str):format(obName, owner, getZoneName(x, y, z), getZoneName(x, y, z, true))

                local wardrobe = getElementByID(('wardrobe:%s'):format(owner))
                if wardrobe then
                    local hadEnough
                    if sustainCache[owner] == nil then
                        hadEnough = wardrobeHaveSustain(wardrobe)
                        sustainCache[owner] = hadEnough
                        if hadEnough then
                            removeSustain(wardrobe)
                        end
                    else
                        hadEnough = sustainCache[owner]
                    end
                    if not hadEnough then
                        setElementData(ob, 'health', (getElementData(ob, 'health') or 0) - damageLoss)
                        if getElementData(ob, 'health') <= 0 then
                            destroyObject(ob, 'decay', logMessage)
                        end
                    end
                else
                    setElementData(ob, 'health', (getElementData(ob, 'health') or 0) - damageLoss)
                    if (getElementData(ob, 'health') or 0) <= 0 then
                        destroyObject(ob, 'decay', logMessage)
                    end
                end
            end
        end
    end, function()
        for k, v in ipairs(getElementsByType('player')) do
            local acc = getElementData(v, 'account')
            if acc then
                if sustainCache[acc] then
                    exports['stoneage_notifications']:CreateNotification(v, translate(v, 'atingiu meta'), 'info')
                else
                    exports['stoneage_notifications']:CreateNotification(v, translate(v, 'não atingiu meta'), 'error')
                end
            end
        end
        sustainCache = nil

        setTimer(RunDecay, hours(exports['stoneage_settings']:getConfig('horas decay', 3)), 1)
    end)
end
setTimer(RunDecay, hours(exports['stoneage_settings']:getConfig('horas decay', 3)), 1)

local repairCache = {}
canRepair = function(acc, player)
    local last = repairCache[acc]
    if last then
        local repairTime = hours(12)
        local passed = getTickCount() - last
        local resta = repairTime - passed
        if passed >= repairTime then
            return true
        else
            exports['stoneage_notifications']:CreateNotification(player, translate(player, 'precisa esperar para reparar', nil, UTILS:secondsToTimeDesc(resta / 1000, player)), 'error')
            return false
        end
    else
        return true
    end
    return false
end

loadEvent('craft:repairAllObjects', root, function(ob)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' or getElementData(ob, 'obName') ~= 'Wardrobe' then
        return
    end
    local owner = getElementData(ob, 'owner')
    if owner and (owner == getElementData(player, 'account') or isAdmin(player)) then
        local px, py, pz = getElementPosition(player)
        local ox, oy, oz = getElementPosition(ob)
        if getElementDimension(player) ~= getElementDimension(ob)
            or getElementInterior(player) ~= getElementInterior(ob)
            or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 6 then
            return
        end
        if not canRepair(owner, player) then
            playSoundFrontEnd(player, 14)
            return
        end
        repairCache[owner] = getTickCount()

        exports['stoneage_notifications']:CreateNotification(player, translate(player, 'iniciando reparo'), 'info')

        Async:foreach(getElementsByType('object', resourceRoot), function(ob)
            if isElement(ob) then
                if getElementData(ob, 'owner') == owner then
                    local obName = getElementData(ob, 'obName')
                    if obName then
                        setElementData(ob, 'health', getObjectDataSetting(obName, 'maxHealth') or 1000)
                    end
                end
            end
        end, function()
            exports['stoneage_notifications']:CreateNotification(player, translate(player, 'reparo concluido!'), 'info')
        end)
    end
end)

addEventHandler('onPlayerQuit', root, function()
    local myAccount = getElementData(source, 'account')
    if myAccount and repairCache[myAccount] then
        repairCache[myAccount] = nil
    end
end)

RepairAllObjects = function()
    for k, v in ipairs(getElementsByType('object', resourceRoot)) do
        if (not isElementLowLOD(v)) then
            local owner = getElementData(v, 'owner')
            if owner then
                local obName = getElementData(v, 'obName')
                local maxHealth = obName and getObjectDataSetting(obName, 'maxHealth')
                if maxHealth then
                    setElementData(v, 'health', maxHealth)
                end
            end
        end
    end
end

local fireTimer = {}
loadEvent('craft:toggleFire', root, function(ob, state, equippedID)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or type(state) ~= 'boolean' then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object' then
        return
    end
    local obName = getElementData(ob, 'obName')
    if obName ~= 'Fogueira' and obName ~= 'Fornalha' then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 4 then
        return
    end

    if state then
        if getElementData(ob, 'fire') then
            return
        end
        if getElementData(player, 'equippedSlotID') ~= equippedID then
            return
        end
        local order = getElementData(player, 'keybarOrder')
        if (not order) or (not order[equippedID]) or (order[equippedID].itemName ~= 'Fosforo') then
            exports['stoneage_notifications']:CreateNotification(player, translate(player, 'Precisa ter %s em mãos', nil, translate(player, 'Fosforo', 'name')), 'error')
            return
        end

        order[equippedID].quantity = order[equippedID].quantity - 1
        if order[equippedID].quantity <= 0 then
            order[equippedID] = nil
            onPlayerDisequipItem(equippedID, player)
            triggerClientEvent(player, 'inv:disequipCurrentKeybarItem', player)
        end
        setElementData(player, 'keybarOrder', order)
    end

    setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false)
    setElementData(ob, 'fire', state)

    if isTimer(fireTimer[ob]) then
        killTimer(fireTimer[ob])
        fireTimer[ob] = nil
    end

    if state then
        fireTimer[ob] = setTimer(function(ob)
            if isElement(ob) then
                removeElementData(ob, 'fire')
            end
            fireTimer[ob] = nil
        end, 30 * 60000, 1, ob)
    end
end)

loadEvent('craft:assarItem', root, function(ob, equippedID, itemName)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') then
        return
    end
    if not isElement(ob) or getElementType(ob) ~= 'object'
        or getElementData(ob, 'obName') ~= 'Fogueira' or not getElementData(ob, 'fire') then
        return
    end
    local px, py, pz = getElementPosition(player)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(player) ~= getElementDimension(ob)
        or getElementInterior(player) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 4 then
        return
    end
    if getElementData(player, 'equippedSlotID') ~= equippedID or itemName ~= 'Meat Cooked' then
        return
    end

    local order = getElementData(player, 'keybarOrder')
    if not order or not order[equippedID] or order[equippedID].itemName ~= 'Raw Meat' then
        return
    end

    order[equippedID].itemName = 'Meat Cooked'
    onPlayerDisequipItem(equippedID, player)
    triggerClientEvent(player, 'inv:disequipCurrentKeybarItem', player)
    setElementData(player, 'keybarOrder', order)
    setPedAnimation(player, 'bomber', 'bom_plant', -1, false, false, false, false)
end)

local takedDamage = {}
addEventHandler('onElementDataChange', resourceRoot, function(key, old, new)
    if key == 'health' and tonumber(new) and tonumber(old) then
        if tonumber(new) < tonumber(old) then
            local owner = getElementData(source, 'owner')
            if owner then
                if takedDamage[owner] then
                    if isTimer(takedDamage[owner]) then
                        killTimer(takedDamage[owner])
                    end
                end
                takedDamage[owner] = setTimer(function(owner)
                    takedDamage[owner] = nil
                end, hours(1), 1, owner)
            end
        end
    end
end)

local resetableObjectTypes = {
    ['baseItems'] = true, ['Wardrobe'] = true, ['Baú Pequeno'] = true, ['Baú Grande'] = true,
    ['Water Barrel'] = true, ['Fornalha'] = true, ['Fogueira'] = true, ['Mesa de pesquisa'] = true,
    ['Poço'] = true, ['Sandbags'] = true, ['Barricade'] = true, ['Placa'] = true, ['Planter'] = true,
    ['Cama'] = true, ['Workbench'] = true, ['Fixed Torch'] = true, ['Sentry'] = true,
}

loadEvent('rust:resetItems', root, function(obType)
    local player = client
    if not isElement(player) or getElementType(player) ~= 'player' or source ~= player
        or getElementData(player, 'isDead') or not resetableObjectTypes[obType] then
        return
    end
    local myAccount = getElementData(player, 'account')
    if not myAccount then
        return
    end
    if takedDamage[myAccount] then
        exports['stoneage_notifications']:CreateNotification(player, translate(player, 'tomou dano em pouco tempo'), 'error')
        return
    end
    local playerName = getPlayerName(player)
    for _, ob in ipairs(getElementsByType('object', resourceRoot)) do
        if isElement(ob) then
            if (getElementData(ob, 'owner') == myAccount) then
                local obName = getElementData(ob, 'obName')
                if obName == obType or (obType == 'baseItems' and isBaseItem(obName)) then
                    local logMessage = ('Um %s de %s ("%s") acabou de ser resetado.'):format(obName, playerName, myAccount)
                    destroyObject(ob, 'reset', logMessage)
                end
            end
        end
    end
    setElementData(player, obType, 0)
end)

RequestObjectInfo = function(ob)
    if not isElement(client) or source ~= client or not isElement(ob) then
        return
    end
    local px, py, pz = getElementPosition(client)
    local ox, oy, oz = getElementPosition(ob)
    if getElementDimension(client) ~= getElementDimension(ob)
        or getElementInterior(client) ~= getElementInterior(ob)
        or getDistanceBetweenPoints3D(px, py, pz, ox, oy, oz) > 6 then
        return
    end
    if isElement(ob) then
        local infos = {{'Data de criação', getElementData(ob, 'creationTime')}}

        local owner = getElementData(ob, 'owner')
        if owner then
            local nick, group, status

            local player = getAccountPlayer(owner)
            if player then
                nick = getPlayerName(player)
                group = getElementData(player, 'Group')
                status = 'Online'
            else
                nick = GetAccountData(owner, 'lastNick')
                group = GetAccountData(owner, 'Group')
                status = 'Offline'
            end

            local str = ('Serial: %s\nNick: %s\nGrupo: %s\nStatus: %s'):format(owner, nick or '*Deconhecido', group or '*Sem grupo', status)
            table.insert(infos, 1, {'Criador', str})
        end

        triggerClientEvent(source, 'receiveObjectInfo', source, ob, infos)
    end
end
loadEvent('requestObjectInfo', root, RequestObjectInfo)

local timerAddWater
addWaterToPocos = function()
    Async:foreach(getElementsByType('object', resourceRoot), function(ob)
        if isElement(ob) then
            if (getElementData(ob, 'obName') == 'Poço') then
                local has = getElementData(ob, 'poço:water') or 0
                setElementData(ob, 'poço:water', math.min(100, has + math.random(10, 20)))
            end
        end
    end, function()
        if isTimer(timerAddWater) then
            killTimer(timerAddWater)
        end
        local time = exports['stoneage_settings']:getConfig('Minutos pra dar agua nos poços', 30) * 60000
        timerAddWater = setTimer(addWaterToPocos, time, 1)
    end)
end
setTimer(addWaterToPocos, 500, 1)

loadEvent('Craft:CraftItem', root, function(itemName, category)
    if (not isElement(client)) then
        return false
    end

    local custo = getPlayerDataSetting(itemName, 'craftingCusto') or getObjectDataSetting(itemName, 'craftingCusto')

    if (type(custo) ~= 'table') then
        return false
    end

    if playerDataTable[('%s:BLUEPRINT'):format(itemName)] and (not isAdmin(client)) then
        local alreadyLearned = getElementData(client, 'learnedBlueprint') or {}
        if (not alreadyLearned[('%s:BLUEPRINT'):format(itemName)]) then
            local str = translate(client, 'voce nao aprendeu a craftar.', nil, itemName)
            exports['stoneage_notifications']:CreateNotification(client, str, 'error')
            return
        end
    end

    if (not isAdmin(client)) then
        for k, v in ipairs(custo) do
            local cost = v[2]
            if (v[1] == 'Level') and isVIP(client) then
                cost = math.floor(cost * 0.75)
            end
            if (getElementData(client, v[1]) or 0) < cost then
                local str = ('Você precisa de mais %s.'):format(translate(client, v[1], 'name'))
                exports['stoneage_notifications']:CreateNotification(client, str, 'error')
                return false
            end
        end
    end

    if (category == 'objects') then
        triggerClientEvent(client, 'startCraftingObject', client, itemName)

    else
        local quantity = getReceiveOnCraftQuant(itemName)
        setElementData(client, itemName, (getElementData(client, itemName) or 0) + quantity)

        local str = ('Você acabou de craftar %s x%i.'):format(translate(client, itemName, 'name'), quantity)
        exports['stoneage_notifications']:CreateNotification(client, str, 'success')

        triggerEvent('onPlayerCraftItem', client, itemName, quantity)

        exports['stoneage_logs']:saveLog('craft-item', ('%s acabou de craftar %s "%s".'):format(getPlayerName(client), quantity, itemName))

        if (not isAdmin(client)) then
            for k, v in ipairs(custo) do
                if (v[1] ~= 'Level') then
                    local cost = v[2]
                    if (v[1] == 'Level') and isVIP(client) then
                        cost = math.floor(cost * 0.75)
                    end
                    setElementData(client, v[1], (getElementData(client, v[1]) or 0) - cost)
                end
            end
        end

    end
end)
