addEventHandler("onClientResourceStart", getResourceRootElement(),
    function()
        dayzVersion = "StoneAge Closed Beta"
        versionLabel  = guiCreateLabel(1,1,0.3,0.3,dayzVersion,true)
        guiSetSize ( versionLabel, guiLabelGetTextExtent ( versionLabel ), guiLabelGetFontHeight ( versionLabel ), false )
        x,y = guiGetSize(versionLabel,true)
        guiSetPosition( versionLabel, 1-x, 1-y*1.8, true )
        guiSetAlpha(versionLabel,0.5)
    end
)
setPedTargetingMarkerEnabled(false)


addEventHandler("onClientRender", root,
    function()
	if not getElementData(localPlayer,'logedin') then return end
	local screenW, screenH = guiGetScreenSize()
	if isMainMenuActive() then
        dxDrawImage(screenW * 0.7794, screenH * 0.6914, screenW * 0.1522, screenH * 0.2747, ":Rusty/images/logotipo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)	
	else
		if getElementData(localPlayer,'HUD_PESSOAL_Render') then 
		dxDrawImage(screenW * 0.9338, screenH * 0.8659, screenW * 0.0588, screenH * 0.1029, ":Rusty/images/logotipo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
	end
end)

        setPlayerHudComponentVisible ("area_name",false) 
        setPlayerHudComponentVisible ("vehicle_name",false) 
function playerStatsClientSite()
    if getElementData(getLocalPlayer(),"logedin") then
        toggleControl ("radar",true)
        setPlayerHudComponentVisible ("clock",false) 
        setPlayerHudComponentVisible ("radar",false)
        setPlayerHudComponentVisible ("money",false) 
        setPlayerHudComponentVisible ("health",false) 
        setPlayerHudComponentVisible ("weapon",false) 
        setPlayerHudComponentVisible ("ammo",false) 
        setPlayerHudComponentVisible ("breath",false) 
        setPlayerHudComponentVisible ("radio",false) 
        setPlayerHudComponentVisible ("area_name",false) 
        setPlayerHudComponentVisible ("vehicle_name",false) 
        setPlayerHudComponentVisible ("radar",true) 
	else
	setPlayerHudComponentVisible ("radar",false) 
    end
end
setTimer(playerStatsClientSite,50,0)

function setClientNight (hour,minutes)
    if hour == 21 then
        setSkyGradient(0, 100/minutes, 196/minutes, 136/minutes, 170/minutes, 212/minutes)
        setFarClipDistance(120+(880-minutes*14.6))
        setFogDistance(-150+(250-minutes*4.16))
    elseif hour == 7 then
        setSkyGradient( 0, 1.6*minutes, 196*3.26, 136*2.26, 170*2.83, 212*3.53 )
        setFarClipDistance(120+(minutes*14.6))
        setFogDistance(-150+(minutes*4.16))
    elseif hour == 22 or hour == 23 then
        setSkyGradient( 0, 0, 0, 0, 0, 0 )
        setFarClipDistance(120)
        setFogDistance(-150)
    elseif hour >= 0 and hour <= 7 then
        setSkyGradient( 0, 0, 0, 0, 0, 0 )
        setFarClipDistance(120)
        setFogDistance(-150)
    else
        setSkyGradient(0, 100, 196, 136, 170, 212)
        setFarClipDistance(1000)
        setFogDistance(100)
    end
end

function getGroundMaterial(x, y, z)
    local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z-10, true, false, false, true, false, false, false, false, nil)
    return material
end

function isInBuilding(x, y, z)
    local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z+10, true, false, false, true, false, false, false, false, nil)
    if hit then return true end
    return false
end

function isObjectAroundPlayer2 ( thePlayer, distance, height )
    material_value = 0
    local x, y, z = getElementPosition( thePlayer )
    for i = math.random(0,360), 360, 1 do
        local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
        local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height,true,false,false,false,false,false,false,false )
        if material == 0 then
            material_value = material_value+1
        end
        if material_value > 40 then
            return 0,hitX, hitY, hitZ
        end
    end
    return false
end

function isObjectAroundPlayer ( thePlayer, distance, height )
    local x, y, z = getElementPosition( thePlayer )
    for i = math.random(0,360), 360, 1 do
        local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
        local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height)
        if material == 0 then
            return material,hitX, hitY, hitZ
        end
    end
    return false
end

function getPointFromDistanceRotation ( x, y, dist, angle )
    local a = math.rad( 90 - angle )
    local dx = math.cos( a ) * dist
    local dy = math.sin( a ) * dist
    return x + dx, y + dy
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

weaponAmmoTable = {
["9mm"] = {{"PDW",28},{"MP5A5",29},},
[".45 ACP"] = {{"P1911",22},{"P92",23},},
["7.62mm"] = {{"AKM",30},{"Kar98k",33},},
["5.56mm"] = {{"M16A4",31},},
["12 Gauge"] = {{"S1897",25},{"S686",27},},
[".300 Magnum"] = {{"Sniper",34},},
["others"] = {{"Granada",16},{"Facão",4},{"Machado",8},{"Pá",6},{"Picareta",2},},}

function getWeaponAmmoType (weaponName)
    for i,weaponData in ipairs(weaponAmmoTable["others"]) do
        if weaponName == weaponData[1] then
            return weaponData[1],weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9mm"]) do
        if weaponName == weaponData[1] then
            return "9mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".45 ACP"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["7.62mm"]) do
        if weaponName == weaponData[1] then
            return "7.62mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56mm"]) do
        if weaponName == weaponData[1] then
            return "5.56mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".300 Magnum"]) do
        if weaponName == weaponData[1] then
            return ".300 Magnum",weaponData[2]
        end
    end
end

function getWeaponDamage (weapon)
    for i,weapon2 in ipairs(damageTable) do
        local t,weapon1 = getWeaponAmmoType(weapon2[1])
        if weapon1 == weapon then
            return weapon2[2]
        end
    end
end

function playerGetDamageDayZ ( attacker, weapon, bodypart, loss )
if getPlayerName(localPlayer) == "iDannz" then cancelEvent() return end
    cancelEvent()
    damage = 100
    headshot = false
    if weapon == 37 then
        return
    end
	    if weapon ==0 and loss >= 1 then
		dano = math.floor(loss*70)
    setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-dano)
        end
    if attacker and getElementData(attacker,"zombie") then
        setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-gameplayVariables["zombiedamage"])
        local number = math.random(1,7)
        if number == 4 then
            setElementData(getLocalPlayer(),"bleeding",getElementData(getLocalPlayer(),"bleeding") + math.floor(loss*10))
        end
    end

    if weapon == 49 then
        if loss > 30 then
            setElementData(getLocalPlayer(),"brokenbone",true)
            setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.floor(loss*10))
        end
    setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.floor(loss*5))
    elseif weapon == 63 or weapon == 51 or weapon == 19 then
        setElementData(getLocalPlayer(),"blood",0)
        if getElementData(getLocalPlayer(),"blood") <= 0 then
            if not getElementData(getLocalPlayer(),"isDead") == true then
                triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot,weapon)
            end
        end
    elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
        local number = math.random(1,8)
        if number >= 6 or number <= 8 then
            setElementData(getLocalPlayer(),"bleeding",getElementData(getLocalPlayer(),"bleeding") + math.floor(loss*10))
        end
        local number = math.random(1,7)
        if number >= 5 or number <= 7 then
            setElementData(getLocalPlayer(),"pain",true)
        end
        damage = getWeaponDamage (weapon)
        if bodypart == 9 then
		if getElementData(source,'Capacete_used') then
		setElementData(source,'Capacete_used',false)
		return
		end
            damage = damage*50
            headshot = true
			setPedHeadless(source,true)
			triggerServerEvent('kilLDayZPlayer',getLocalPlayer(),attacker,headshot,weapon)
			return
        end
	if bodypart == 3 then
		if getElementData(localPlayer,'Colete_used') then
		setElementData(localPlayer,'Colete_vida',getElementData(localPlayer,'Colete_vida') -damage)
		if getElementData(localPlayer,'Colete_vida') <= 0 then
		setElementData(localPlayer,'Colete_used',false)
		end
		return
		end
	end
        if bodypart == 7 or bodypart == 8 then
            setElementData(getLocalPlayer(),"brokenbone",true)
        end
		if not damage then damage = 3500 end
        setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.random(damage*0.75,damage*1.25)) 
        if getElementData(getLocalPlayer(),"blood") <= 0 then
            if not getElementData(getLocalPlayer(),"isDead") then
                triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot,weapon)
                setElementData(getLocalPlayer(),"isDead",true)
            end
        end
    elseif weapon == 54 or weapon == 63 or weapon == 49 or weapon == 51 then
        setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.random(100,1000))
        local number = math.random(1,5)
        if loss > 30 then
            setElementData(getLocalPlayer(),"brokenbone",true)
			setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.random(1000,3000))
        end
        if loss >= 100 then
            setElementData(getLocalPlayer(),"blood",49)
            setElementData(getLocalPlayer(),"bleeding",50)
        end
        local number = math.random(0,2)
        if number == 1 then
            setElementData(getLocalPlayer(),"pain",true)
        end
        if getElementData(getLocalPlayer(),"blood") <= 0 then
            if not getElementData(getLocalPlayer(),"isDead") == true then
                triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot,weapon)
                setElementData(getLocalPlayer(),"isDead",true)
            end
        end
    end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer (), playerGetDamageDayZ )

function pedGetDamageDayZ ( attacker, weapon, bodypart, loss )
        if getElementData(source,"animal") then return end

    cancelEvent()
    if attacker and attacker == getLocalPlayer() then
        damage = 100
        if weapon == 37 then
            return
        end
        if weapon == 63 or weapon == 51 or weapon == 19 then
            setElementData(source,"blood",0)
            if getElementData(source,"blood") <= 0 then
                triggerServerEvent("onZombieGetsKilled",source,attacker)
            end
        elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
            damage = getWeaponDamage (weapon)
            if bodypart == 9 then
                damage = damage*1.5
                headshot = true
            end
            setElementData(source,"blood",getElementData(source,"blood")-math.random(damage*0.75,damage*1.25))
            if getElementData(source,"blood") <= 0 then
                triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
            end
        end
    end    
end
addEventHandler ( "onClientPedDamage", getRootElement(), pedGetDamageDayZ )


function checkStats()
    if getElementData(getLocalPlayer(),"logedin") then
        if getElementData(getLocalPlayer(),"bleeding") > 20 then
            setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-getElementData(getLocalPlayer(),"bleeding"))
        else
            setElementData(getLocalPlayer(),"bleeding",0)
        end
        if getElementData(getLocalPlayer(),"blood") < 0 then
            if not getElementData(getLocalPlayer(),"isDead") then
                triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),false,false)
            end
        end
    end    
end
setTimer(checkStats,3000,0)

function createBloodForBleedingPlayers ()
    if getElementData(getLocalPlayer(),"logedin") then
    local x,y,z = getElementPosition(getLocalPlayer())
        for i,player in ipairs(getElementsByType("player")) do
            local bleeding = getElementData(player,"bleeding") or 0
            if bleeding > 0 then
                local px,py,pz = getPedBonePosition (player,3)
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if bleeding > 1 then
                    number = 5
                else
                    number = 0
                end
                if pdistance <= 120 then
                    fxAddBlood ( px,py,pz,0,0,0,number, 1 )
                end
            end    
        end
    end    
end
setTimer(createBloodForBleedingPlayers,300,0)

tempo = math.random(10000,15000)
function anim_broken_b()
if getElementData(getLocalPlayer(),"logedin") then
    if getElementData(getLocalPlayer(),"brokenbone") then
		triggerServerEvent('anim_brokenbone',root,localPlayer)
	end    
end    
tempo = math.random(10000,15000)
end    
setTimer(anim_broken_b,tempo,0)

function setPain()
    if getElementData(getLocalPlayer(),"logedin") then
        if getElementData(getLocalPlayer(),"pain") then
            local x,y,z = getElementPosition(getLocalPlayer())
            createExplosion (x,y,z+15,8,false,0.5,false)
        end
    end    
end
setTimer(setPain,1500,0)

function checkCold()
    if getElementData(getLocalPlayer(),"logedin") then
        if getElementData(getLocalPlayer(),"temperature") <= 31 then
            setElementData(getLocalPlayer(),"cold",true)
			else
            setElementData(getLocalPlayer(),"cold",false)
        end
    end    
end
setTimer(checkCold,3000,0)

function setCold()
    if getElementData(getLocalPlayer(),"logedin") then
        if getElementData(getLocalPlayer(),"cold") then
            local x,y,z = getElementPosition(getLocalPlayer())
            createExplosion (x,y,z+15,8,false,0.5,false)
			
            local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
        end    
    end    
end
setTimer(setCold,1500,0)

fading = 0
fading2 = "up"
local screenWidth,screenHeight = guiGetScreenSize()
function updateIcons ()
    if getElementData(getLocalPlayer(),"logedin") then
        --Nametags
        local x,y,z = getElementPosition(getLocalPlayer())
        for i,player in ipairs(getElementsByType("player")) do
            setPlayerNametagShowing ( player, false )
            if player ~= getLocalPlayer() then
            local vehicle = getPedOccupiedVehicle(player)
                local px,py,pz = getElementPosition (player)
                local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                if pdistance <= 2 then
                    local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
                    if sx and sy then
                        text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' )
                    local w = dxGetTextWidth(text,1.02,"default-bold")
                    dxDrawText (text, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )
                    end
                end
            end        
        end
        --Vehicletags
        local x,y,z = getElementPosition(getLocalPlayer())
        for i,veh in ipairs(getElementsByType("vehicle")) do
            local px,py,pz = getElementPosition (veh)
            local vehID = getElementModel(veh)
            local vehicle = getPedOccupiedVehicle(getLocalPlayer())
            if veh ~= vehicle then
                if vehID ~= 548 then
                    local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
                    if pdistance <= 6 then
                        --Get screenposition
                        local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
                        if sx and sy then
                            --Draw Vehicle
							text = getVehicleNameStoneAge(vehID)
                            local w = dxGetTextWidth(text,1.25,"default-bold")
                            dxDrawText ( text, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 255 ), 1.25, "default-bold" )    
                        end
                    end
                end
            end
        end
        if not playerTarget then return end
        local x,y,z = getElementPosition(playerTarget)
        local x,y,distance = getScreenFromWorldPosition (x,y,z+0.5)
        distance = 20
        text = string.gsub(getPlayerName(playerTarget), '#%x%x%x%x%x%x', '') or 'ped'
        local w = dxGetTextWidth(text,distance*0.033,"default-bold")
		if not x or not y then return end
		x1,y1,z1 = getElementPosition(localPlayer)
		x2,y2,z2 = getElementPosition(playerTarget)
		dist = math.floor(getDistanceBetweenPoints3D(x2,y2,z2,x1,y1,z1))
        dxDrawText (dist..'m\n'..text,x-(w/2),y,x-(w/1.8), y, tocolor ( 0, 0, 0, 255 ), distance*0.045, "default-bold" )
        dxDrawText (dist..'m\n'..text,x-(w/1.8),y,x-(w/2), y, tocolor ( 255, 255,0, 255 ), distance*0.045, "default-bold" )
    end    
end
addEventHandler ( "onClientRender", getRootElement(), updateIcons )

playerTarget = false
function targetingActivated ( target )
    if ( target ) and getElementType(target) == "player" then
        playerTarget = target
    else
        playerTarget = false
    end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function dayZDeathInfo ()
    fadeCamera (false, 1.0, 0, 0, 0 ) 
    setTimer(showDayZDeathScreen,2000,1)
	number = math.random(0,1)
	if number == 1 then 
	sound_death = playSound(':Rusty/sounds/death1.ogg',false)
	else
	sound_death = playSound(':Rusty/sounds/death.mp3',false)
	end
end
addEvent("onClientPlayerDeathInfo",true)
addEventHandler("onClientPlayerDeathInfo",getRootElement(),dayZDeathInfo)

function showDayZDeathScreen()
guiSetEnabled(button_spawn_cama,true)
addEventHandler("onClientRender", root, tudo_morte)
	tempo = 20
setElementData(localPlayer,'tempo_respawn',tempo)
setTimer (function() 
	tempo = tempo-1 	
setElementData(localPlayer,'tempo_respawn',tempo)
end,100,20)	
setTimer (function() 
removeEventHandler("onClientRender", root, tudo_morte)
selecao()
end,100*20,1)
end
local screenW, screenH = guiGetScreenSize()

        window_selecao_spawn = guiCreateWindow(0.29, 0.26, 0.43, 0.49, "Respawn", true)
        background = guiCreateStaticImage(0, 0, 1, 1, ":Rusty/images/dead.png", true, window_selecao_spawn)
        if isElement(background) then
            guiSetVisible(background, false)
            guiSetEnabled(background, false)
        end
        guiWindowSetMovable(window_selecao_spawn, false)
        guiWindowSetSizable(window_selecao_spawn, false)
		guiSetAlpha(window_selecao_spawn,1)
		guiSetVisible(window_selecao_spawn,false)
		
        mapa_selecao_spawn = guiCreateStaticImage(0.02, 0.07, 0.60, 0.90, ":Rusty/images/radar.png", true, window_selecao_spawn)
spawn = {}
        spawn[1] = guiCreateStaticImage(0.10, 0, 0.5, 0.5, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn)
        spawn[2] = guiCreateStaticImage(0.55, 0.3, 0.5, 0.5, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn)
        spawn[3] = guiCreateStaticImage(-0.1, 0.55, 0.5, 0.5, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn)
        spawn[4] = guiCreateStaticImage(0.3, 0.25, 0.5, 0.5, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn)
        spawn[5] = guiCreateStaticImage(0.1, 0.45, 0.5, 0.5, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn)
        spawn[6] = guiCreateStaticImage(0.0, 0.0, 0.0, 0.0, ":Rusty/images/radio_button.png", true, mapa_selecao_spawn) 
		
        gridlist_selecao_spawn = guiCreateGridList(0.63, 0.06, 0.35, 0.53, true, window_selecao_spawn)
        coluna = guiGridListAddColumn(gridlist_selecao_spawn, "Lugares", 0.9)
        row = guiGridListAddRow(gridlist_selecao_spawn)
        guiGridListSetItemText(gridlist_selecao_spawn, row,coluna, "Aleatorio", false, false)
		row = guiGridListAddRow(gridlist_selecao_spawn)
		guiGridListSetItemText(gridlist_selecao_spawn, row,coluna, "Bone County", false, false)
		row = guiGridListAddRow(gridlist_selecao_spawn)
        guiGridListSetItemText(gridlist_selecao_spawn, row, coluna, "Red County", false, false)
		row = guiGridListAddRow(gridlist_selecao_spawn)
        guiGridListSetItemText(gridlist_selecao_spawn, row, coluna, "Mount Chilliad", false, false)
		row = guiGridListAddRow(gridlist_selecao_spawn)
        guiGridListSetItemText(gridlist_selecao_spawn, row, coluna, "The Farm", false, false)
		
		row = guiGridListAddRow(gridlist_selecao_spawn)
        guiGridListSetItemText(gridlist_selecao_spawn, row, coluna, "Flint County", false, false)
		
        fundo_cama = guiCreateStaticImage(0.63, 0.77, 0.12, 0.19, ":Rusty/images/itens/logo_borda.png", true, window_selecao_spawn)

        cama = guiCreateStaticImage(0.01, 0.01, 0.99, 0.99, ":Rusty/images/itens/cama.png", true, fundo_cama)

        button_spawn_mapa = guiCreateButton(0.63, 0.59, 0.35, 0.13, "Spawn pelo mapa", true, window_selecao_spawn)
        button_spawn_cama = guiCreateButton(0.76, 0.81, 0.22, 0.13, "Voltar pra cama", true, window_selecao_spawn)

	    alivetime_label = guiCreateLabel(0.76, 0.72, 0.22, 0.10, "", true, window_selecao_spawn)
        guiLabelSetHorizontalAlign(alivetime_label, "center", false)
        guiLabelSetVerticalAlign(alivetime_label, "center")
		
function hide()
guiSetVisible(spawn[1],false)
guiSetVisible(spawn[2],false)
guiSetVisible(spawn[3],false)
guiSetVisible(spawn[4],false)
guiSetVisible(spawn[5],false)
guiSetVisible(spawn[6],false)
end
hide()

stopDeathSound = function ()
if isElement(sound_death) then 
stopSound(sound_death)
end
end


tabela_spawn = {
{"Bone County",spawn[1]},
{"Red County",spawn[2]},
{"Mount Chilliad",spawn[3]},
{"The Farm",spawn[4]},
{"Flint County",spawn[5]},
{"Aleatorio",spawn[6]},
}

selecao = function ()
guiSetVisible(window_selecao_spawn,true)
guiSetVisible(background,true)
guiSetText(alivetime_label,'Tempo vivo: '..getElementData(localPlayer,'alivetime'))
showCursor(true)
end

addEventHandler('onClientGUIClick',root,function()
local itemName = guiGridListGetItemText ( gridlist_selecao_spawn, guiGridListGetSelectedItem ( gridlist_selecao_spawn ), 1 )
if source == gridlist_selecao_spawn then
if not itemName or itemName == "" then hide() end
	for i, data in ipairs (tabela_spawn) do
		if itemName == data[1] then
		hide()
		guiSetVisible(data[2],true)
		end
	end
end
if source == button_spawn_mapa then
	if not itemName or itemName == "" then 
	guiSetText(alivetime_label,'Você precisa selecionar\num da lista.') 
outputChatBox("Você precisa selecionar um da lista.",255,255,0) return end
	for i, data in ipairs (tabela_spawn) do
	if guiGetVisible(data[2]) then
	triggerServerEvent("requestSpawn",getLocalPlayer(),data[1])
	guiSetVisible(window_selecao_spawn,false)
	guiSetVisible(background,false)
	stopDeathSound()
	showCursor(false)
	end
	end
end
if source == button_spawn_cama then
if not getElementData(localPlayer,"cama") then guiSetText(alivetime_label,'Você não tem\numa cama.') return end
if not getElementData(localPlayer,'can_go_cama') then
guiSetText(alivetime_label,getElementData(localPlayer,'alivetime')..' < 30 minutos ') 
outputChatBox('Você só poderá voltar pra cama se tiver passado mais de 30 minutos vivo na rodada anterior',255,0,0) guiSetEnabled(button_spawn_cama,false) return end
	triggerServerEvent("requestSpawn",getLocalPlayer(),"Cama")
	guiSetVisible(window_selecao_spawn,false)
	guiSetVisible(background,false)
	showCursor(false)
stopDeathSound()	
end
end)


function tudo_morte()

local screenW, screenH = guiGetScreenSize()
		dxDrawImage(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, ":Rusty/images/dead.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawRectangle((screenW - 1360) / 2, (screenH - 768) / 2, 1360, 768, tocolor(0, 0, 0, 255), false)
        dxDrawLine((screenW * 0.3206) - 1, (screenH * 0.4245) - 1, (screenW * 0.3206) - 1, screenH * 0.5768, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(screenW * 0.6794, (screenH * 0.4245) - 1, (screenW * 0.3206) - 1, (screenH * 0.4245) - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine((screenW * 0.3206) - 1, screenH * 0.5768, screenW * 0.6794, screenH * 0.5768, tocolor(255, 255, 255, 255), 1, false)
        dxDrawLine(screenW * 0.6794, screenH * 0.5768, screenW * 0.6794, (screenH * 0.4245) - 1, tocolor(255, 255, 255, 255), 1, false)
        dxDrawRectangle(screenW * 0.3206, screenH * 0.4245, screenW * 0.3588, screenH * 0.1523, tocolor(0, 0, 0, 255), false)
number = getElementData(localPlayer,"tempo_respawn") or 0
if number == 20 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 19 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 18 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 17 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 16 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 15 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number ==14 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 13 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 12 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 11 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 10 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 9 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 8 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 7 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 6 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 5 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5699, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 4 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5699, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5875, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6044, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 3 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5699, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5875, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6044, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6221, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 2 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5699, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5875, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6044, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6221, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6397, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
elseif number == 1 then
        dxDrawRectangle(screenW * 0.3279, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3449, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.3625, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3794, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.3963, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4132, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4309, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4478, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4647, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4816, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4985, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5154, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5331, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5515, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5699, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.5875, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
		dxDrawRectangle(screenW * 0.6044, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6221, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6397, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.6581, screenH * 0.4375, screenW * 0.0140, screenH * 0.1263, tocolor(255, 255, 255, 255), false)
end
        dxDrawText("Você morreu", 434 - 1, 306 - 1, 924 - 1, 326 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Você morreu", 434 + 1, 306 - 1, 924 + 1, 326 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Você morreu", 434 - 1, 306 + 1, 924 - 1, 326 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Você morreu", 434 + 1, 306 + 1, 924 + 1, 326 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Você morreu", 434, 306, 924, 326, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("e voltará em "..math.round((number/2),0).." segundos", 436 - 1, 443 - 1, 926 - 1, 463 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("e voltará em "..math.round((number/2),0).." segundos", 436 + 1, 443 - 1, 926 + 1, 463 - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("e voltará em "..math.round((number/2),0).." segundos", 436 - 1, 443 + 1, 926 - 1, 463 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("e voltará em "..math.round((number/2),0).." segundos", 436 + 1, 443 + 1, 926 + 1, 463 + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("e voltará em "..math.round((number/2),0).." segundos", 436, 443, 926, 463, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end


whiteWindow = guiCreateStaticImage(0,0,1,1,"images/white.png",true)
guiSetVisible(whiteWindow,false)
function showPlayerDamageScreen (visibly2,stateControle2)
    guiSetVisible(whiteWindow,true)
    visibly = visibly2 or visibly
    stateControle = stateControle2 or stateControle
    if visibly >= 6*0.025 and stateControle == "up" then
        stateControle = "down"
    end
    if visibly < 0 then
        guiSetVisible(whiteWindow,false)
        return
    end
    if stateControle == "up" then
        visibly = visibly + 0.025
    elseif stateControle == "down" then
        visibly = visibly - 0.025
    end
    guiSetAlpha(whiteWindow,visibly)
    setTimer(showPlayerDamageScreen,50,1)
end

function showWhiteScreen ( attacker, weapon, bodypart )
    --if weapon then
        showPlayerDamageScreen (0,"up")
    --end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), showWhiteScreen )

function checkVehicleInWaterClient ()
    vehiclesInWater = {}
    for i,veh in ipairs(getElementsByType("vehicle")) do
        if isElementInWater(veh) then
                table.insert(vehiclesInWater,veh)
        end
    end
    triggerServerEvent("respawnVehiclesInWater",getLocalPlayer(),vehiclesInWater)
end
addEvent("checkVehicleInWaterClient",true)
addEventHandler("checkVehicleInWaterClient",getRootElement(),checkVehicleInWaterClient)


function updatePlayTime()
        if getElementData(getLocalPlayer(),"logedin") then
            local playtime = getElementData(getLocalPlayer(),"alivetime")
            setElementData(getLocalPlayer(),"alivetime",playtime+1)    
        end    
end
setTimer(updatePlayTime, 60000, 0)

local pingFails = 0
function playerPingCheck ()
    if getPlayerPing(getLocalPlayer()) > gameplayVariables["ping"] then
        pingFails = pingFails +1
        if pingFails == 5 then
            triggerServerEvent("kickPlayerOnHighPing",getLocalPlayer())
            return
        end
            startRollMessage2("Ping", "Ping maior que "..gameplayVariables["ping"].."! ("..pingFails.."/5)", 255, 22, 0 )
        if isTimer(pingTimer) then return end
        pingTimer = setTimer(function()
            pingFails = 0
        end,30000,1)
    end
end    
setTimer(playerPingCheck,2000,0)

function setBlipCama()
    for i, object in ipairs(getElementsByType("object")) do
	col = getElementData(object,'parent')
	if getElementData(col,'dono') == getElementData(localPlayer,'accName') and getElementData(col,'cama') then
            createBlipAttachedTo(object,0,2,22,255,22)
    end
    end
end	

if fileExists("survivorSystem_client.lua") == true then
fileDelete("survivorSystem_client.lua")
end

addEventHandler("onClientResourceStart", getResourceRootElement(),
function()
	guiSetInputMode("no_binds_when_editing")
end)
	
local alpha = 255
bindKey ( "aim_weapon", "both",
  function ( _, state )
   if getPedWeaponSlot ( localPlayer ) == 6 then
    if ( state == "down" ) then
     alpha = 0
    elseif ( state == "up" ) then
     alpha = 255
    end
    for _, v in ipairs ( getElementsByType ( "object", root, true ) ) do
     if isElementAttachedToBone ( v ) and getPedThatIsElementAttached(v) == localPlayer then
      local id = getElementModel ( v )
      if id == 2254 or 
	  id == 1604 or 
	  id == 2269 or 
	  id == 2273 or 
	  id == 2272 or 
	  id == 2274 or 
	  id == 2275 or 
	  id == 2271 or 
	  id == 2270 or 
	  id == 2267 or 
	  id == 2268 then 
       setElementAlpha ( v, alpha )
      end
     end
    end
   end
  end
)
	
function check_animation()
		Block, Anim = getPedAnimation(localPlayer)
		if Block then 
		setElementData(localPlayer,'inAnimation',true) 
		else
		setElementData(localPlayer,'inAnimation',false) 
		end
end
addEventHandler('onClientPreRender',root,check_animation)

function sound_heart_beatin_C (player,x,y,z)
    if not isElement(player) or getElementType(player) ~= "player" then
        return
    end

    local blood = tonumber(getElementData(player, "blood"))
    if blood and blood <= 3000 then
        local beating = playSound3D(":Rusty/sounds/coracao.wav", x, y, z)
        if isElement(beating) then
            setSoundMaxDistance(beating, 25)
            setSoundVolume(beating, 0.5)
        end
    end
end
addEvent('sound_heart_beatin_C',true)
addEventHandler('sound_heart_beatin_C',root,sound_heart_beatin_C)

setTimer(function()
if getElementData(getLocalPlayer(),"blood") <= 3000 then
	triggerServerEvent("soundHeartBeating",getLocalPlayer())
end
end,1500,0)



