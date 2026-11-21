local lastDamageRequest = {}

addEventHandler('onPlayerQuit', root, function()
    lastDamageRequest[source] = nil
end)

loadEvent('Damage:Apply', root, function(victim, bodypart, clientDamage, usedWeapon, hitx, hity, hitz)
    -- Never trust damage, weapon name, or hit position supplied by the client.
    if not isElement(client) or getElementType(client) ~= 'player' or source ~= client then
        return false
    end

    if not isElement(victim) or getElementType(victim) ~= 'player' or victim == client then
        return false
    end

    if getElementData(client, 'isDead') or getElementData(victim, 'isDead') then
        return false
    end

    if getElementData(client, 'antiSpawnKill') or getElementData(victim, 'antiSpawnKill') then
        return false
    end

    local now = getTickCount()
    if lastDamageRequest[client] and now - lastDamageRequest[client] < 70 then
        return false
    end
    lastDamageRequest[client] = now

    if getElementDimension(client) ~= getElementDimension(victim)
        or getElementInterior(client) ~= getElementInterior(victim) then
        return false
    end

    if bodypart ~= nil and bodypart ~= 'head' and bodypart ~= 'peito' then
        return false
    end

    if type(usedWeapon) ~= 'string' or getElementData(client, 'equippedItem') ~= usedWeapon then
        return false
    end

    local weaponSettings = getPlayerDataSetting(usedWeapon, 'weaponSettings')
    if type(weaponSettings) ~= 'table' or type(weaponSettings.weapID) ~= 'number'
        or type(weaponSettings.damage) ~= 'number' or weaponSettings.damage <= 0 then
        return false
    end

    -- The server verifies the actual weapon currently held by the player.
    if getPedWeapon(client) ~= weaponSettings.weapID then
        return false
    end

    local cx, cy, cz = getElementPosition(client)
    local vx, vy, vz = getElementPosition(victim)
    local distance = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz)
    local maxDistance = tonumber(weaponSettings.distance) or 0
    if maxDistance <= 0 or distance > maxDistance then
        return false
    end

    -- Hit coordinates are used only for the hit marker, but must be plausible.
    if type(hitx) ~= 'number' or type(hity) ~= 'number' or type(hitz) ~= 'number' then
        hitx, hity, hitz = getElementPosition(victim)
    else
        if getDistanceBetweenPoints3D(hitx, hity, hitz, vx, vy, vz) > 4 then
            return false
        end
    end

    -- Damage is calculated on the server; clientDamage is intentionally ignored.
    local damage = math.max(1, math.floor(weaponSettings.damage + math.random(-100, 100)))

    if bodypart == 'head' then
        if getElementData(victim, 'Helmet_used') then
            triggerEvent('removeDefenseItemOnDestroy', client, victim, 'Helmet')
            triggerClientEvent(client, 'AddHitMarker', client, 'headshot.png', nil, hitx, hity, hitz)
            return
        end

        damage = math.floor(damage * math.random(50, 100) / 100)

    elseif bodypart == 'peito' then
        if getElementData(victim, 'Vest_used') then
            local vestHealth = getElementData(victim, 'vest_health') or 6500
            setElementData(victim, 'vest_health', vestHealth - damage)
            if vestHealth - damage <= 0 then
                triggerEvent('removeDefenseItemOnDestroy', client, victim, 'Vest')
            else
                return
            end
        end
    end

    damage = math.max(1, math.floor(damage))

    setElementData(victim, 'bleeding', (getElementData(victim, 'bleeding') or 0) + damage / 100)
    setElementData(victim, 'blood', (getElementData(victim, 'blood') or 0) - damage)

    if (getElementData(victim, 'blood') or 0) <= 0 then
        triggerEvent('player:onDie', victim, {
            headshot = bodypart == 'head',
            weapon = usedWeapon,
            reason = getPlayerName(client),
        })

        triggerEvent('player:onKill', client, victim, {
            weap = usedWeapon,
            headshot = bodypart == 'head',
        })

        if bodypart == 'head' then
            triggerClientEvent(client, 'AddHitMarker', client, 'fodase', damage, hitx, hity, hitz)
        else
            triggerClientEvent(client, 'AddHitMarker', client, 'die.png', damage, hitx, hity, hitz)
        end
    else
        if bodypart == 'head' then
            triggerClientEvent(client, 'AddHitMarker', client, 'headshot.png', damage, hitx, hity, hitz)
        else
            triggerClientEvent(client, 'AddHitMarker', client, 'health.png', damage, hitx, hity, hitz)
        end
    end

    return true
end)
