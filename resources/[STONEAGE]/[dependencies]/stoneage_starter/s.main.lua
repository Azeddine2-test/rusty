--[[
    stoneage_starter
    Demarre, dans l'ordre, les ressources du gamemode STONEAGE.

    Reecriture lisible de l'ancien s.main.luac (le code source d'origine est perdu).
    C'est un script serveur ordinaire : modifie librement la liste ci-dessous.

    - Pour desactiver une ressource : retire (ou commente) son nom dans RESOURCES.
    - Les ressources 'stoneage_bike' et 'replaces' sont deja lancees par mtaserver.conf.
    - Droit necessaire (une seule fois, dans la console du serveur) :
          aclrequest allow stoneage_starter all
]]

-- Delai entre deux demarrages (ms). Laisse le serveur respirer et garde les logs lisibles.
local DELAY_BETWEEN_MS = 100

-- Attente avant de commencer (ms), pour laisser finir les ressources lancees par mtaserver.conf.
local INITIAL_DELAY_MS = 500

-- Ordre de demarrage. Chaque ressource n'utilise que celles placees AVANT elle
-- (deduit des appels exports[...] entre ressources), le gamemode est lance en dernier.
local RESOURCES = {
    -- 1. Services de base : utilises par presque toutes les autres ressources
    'stoneage_utils',
    'stoneage_logs',                -- utilise stoneage_utils
    'stoneage_sql',                 -- utilise stoneage_logs des son demarrage
    'stoneage_ui',
    'stoneage_settings',
    'stoneage_translations',
    'stoneage_notifications',
    'stoneage_ac',                  -- anti-triche : utilise logs et settings

    -- 2. Bibliotheques, affichage et outils
    'stoneage_loadscreen',
    'stoneage_sound3D',
    'stoneage_highlight',
    'stoneage_bone_attach',
    'stoneage_object_preview',
    'stoneage_world_textures',
    'texNames',
    'dep-npc',
    'ob-quantity',
    'stoneage_weapon_properties',
    'stoneage_zoom',
    'stoneage_nametag',
    'stoneage_scoreboard',
    'stoneage_voice',
    'stoneage_skins',
    'stoneage_iron-fix',
    'stoneage_placas',

    -- 3. Fonctionnalites de jeu
    'stoneage_economy',
    'stoneage_pickups',             -- utilise stoneage_economy
    'stoneage_base_building',
    'stoneage_farms',
    'stoneage_groupsystem',
    'stoneage_faint',
    'stoneage_hospitals',
    'stoneage_radiation_zones',
    'stoneage_enter_vehicle',
    'stoneage_vehicles',            -- utilise pickups, sound3D et sql
    'stoneage_gas_stations',
    'stoneage_helicopter',
    'stoneage_airdrop',
    'stoneage_compass',
    'stoneage_map',
    'stoneage_recycler',
    'stoneage_sentrys',
    'stoneage_ranking',             -- utilise ui et sql
    'stoneage_interaction',
    'stoneage_admin',
    'richpresence-id',              -- anti-evade (verifie les bans)

    -- 4. Cartes (le gamemode ne les nomme pas : elles doivent exister avant lui)
    'stoneage_island',
    'stoneage_island2',
    'stoneage_muros',
    'stoneage_patrol',
    'loot-points',
    'map-spawn',
    'stoneage_military',

    -- 5. Gamemode, toujours en dernier
    'gamemode',

    -- Desactivees (prefixe _ ou - dans leur nom d'origine) : decommente pour les activer
    -- '_stoneage_ship',
    -- '-stoneage_muros',
}

local function log(message)
    outputServerLog('[stoneage_starter] ' .. message)
end

local function startOne(name)
    local res = getResourceFromName(name)
    if not res then
        log(('Ressource introuvable : %s'):format(name))
        return false
    end

    local state = getResourceState(res)
    if state == 'running' or state == 'starting' then
        return true -- deja lancee (ex. par mtaserver.conf)
    end

    if state == 'failed to load' then
        log(('%s ne peut pas demarrer (echec au chargement : %s)'):format(name, tostring(getResourceLoadFailureReason(res))))
        return false
    end

    -- persistent = true : la ressource reste active meme si le starter est arrete
    if not startResource(res, true) then
        log(('Echec du demarrage de %s (etat : %s)'):format(name, tostring(state)))
        return false
    end
    return true
end

local function startFrom(index, started, failed)
    local name = RESOURCES[index]
    if not name then
        log(('Termine : %d ressource(s) demarree(s), %d en echec.'):format(started, #failed))
        if #failed > 0 then
            log('En echec : ' .. table.concat(failed, ', '))
        end
        return
    end

    if startOne(name) then
        started = started + 1
    else
        failed[#failed + 1] = name
    end

    setTimer(startFrom, DELAY_BETWEEN_MS, 1, index + 1, started, failed)
end

addEventHandler('onResourceStart', resourceRoot, function()
    if not hasObjectPermissionTo(resource, 'function.startResource', false) then
        log("Droit 'function.startResource' refuse : aucune ressource ne sera lancee.")
        log("Tape dans la console du serveur : aclrequest allow stoneage_starter all")
        return
    end

    log(('Demarrage de %d ressources...'):format(#RESOURCES))
    setTimer(startFrom, INITIAL_DELAY_MS, 1, 1, 0, {})
end)
