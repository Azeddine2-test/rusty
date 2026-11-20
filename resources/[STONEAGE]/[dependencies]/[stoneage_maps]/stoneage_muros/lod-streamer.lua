STREAMER = {}
STREAMER_OBJECTS = {}

CHECK_DIST = 1000

local settingsReady = false

addEventHandler('onClientResourceStart', root, function(res)
    local resourceName = getResourceName(res)
    if resourceName == 'stoneage_settings' then
        settingsReady = true
        CheckForLODS()
        return
    end

    if res == resourceRoot then
        local settings = getResourceFromName('stoneage_settings')
        settingsReady = settings and getResourceState(settings) == 'running' or false
        if not STREAMER.Timer then
            STREAMER.Timer = setTimer(CheckForLODS, 500, 0)
        end
        CheckForLODS()
    end
end)

CheckForLODS = function(forced)
    local px, py, pz = getElementPosition(localPlayer)

    if (not forced) then
        if STREAMER.LastPos and (getDistanceBetweenPoints3D(px, py, pz, unpack(STREAMER.LastPos)) <= CHECK_DIST / 2) then
            return false
        end
    end

    STREAMER.LastPos = {px, py, pz}

    for ob, lod in pairs(STREAMER_OBJECTS) do
        if isElement(ob) then
            local x, y, z = getElementPosition(ob)
            if (getDistanceBetweenPoints3D(x, y, z, px, py, pz) > CHECK_DIST) or forced then
                if isElement(lod) then
                    destroyElement(lod)
                    STREAMER_OBJECTS[ob] = nil
                end
            end
        else
            STREAMER_OBJECTS[ob] = nil
        end
    end

    -- Do not call a server export until its resource has started on the client.
    if not settingsReady then
        return false
    end
    local fpsBoost = exports['stoneage_settings']:getConfig('FPSBoost', true)
    if fpsBoost then
        return false
    end

    for k, v in pairs(getElementsByType('object', resourceRoot)) do
        if (getElementModel(v) == 3330) and (not isElementLowLOD(v)) and (not getLowLODElement(v)) then
            if (not STREAMER_OBJECTS[v]) then
                local x, y, z = getElementPosition(v)
                if (getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= CHECK_DIST) then
                    local rx, ry, rz = getElementRotation(v)
                    local ob = createObject(getElementModel(v), x, y, z, rx, ry, rz, true)
                    setElementCollisionsEnabled(ob, false)
                    setLowLODElement(v, ob)
                    setElementParent(ob, v)

                    STREAMER_OBJECTS[v] = ob
                end
            end
        end
    end
end
