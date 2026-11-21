-- //------------------- TOGGLE -------------------\\--
local menu = {
    scene,
    headerHeight = pixels(120),
    toggleTick = getTickCount(),
    showing = false,
}

local authUI = {
    visible = false,
    mode = 'login',
    busy = false,
    message = '',
    edits = {},
    bounds = {},
}

local characterUI = {
    visible = false,
    busy = false,
    message = '',
    skinIndex = 1,
    shirtIndex = 1,
    pantsIndex = 1,
    skins = {0, 7, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25},
    shirts = {},
    pants = {},
    previewPed = nil,
    previewRender = nil,
    bounds = {},
}

local function getValidClothes(slot, fallback)
    local result = {}
    if type(getClothesByTypeIndex) == 'function' then
        for id = 0, 40 do
            local texture, model = getClothesByTypeIndex(slot, id)
            if texture and model then result[#result + 1] = id end
        end
    end
    if #result == 0 then result = fallback end
    return result
end

characterUI.shirts = getValidClothes(0, {1, 2, 4, 5, 10, 11, 17, 19})
characterUI.pants = getValidClothes(2, {7, 8, 9, 10, 11})

local function selectedCharacterClothes()
    return {
        shirt = characterUI.shirts[characterUI.shirtIndex] or 1,
        head = 0,
        pants = characterUI.pants[characterUI.pantsIndex] or 7,
    }
end

local function destroyCharacterPreview()
    if characterUI.previewRender then
        exports['stoneage_object_preview']:destroyObjectPreview(characterUI.previewRender)
    end
    if isElement(characterUI.previewPed) then destroyElement(characterUI.previewPed) end
    characterUI.previewRender, characterUI.previewPed = nil, nil
end

local function refreshCharacterPreview()
    if not characterUI.visible then return end
    local skin = characterUI.skins[characterUI.skinIndex] or 0
    local clothes = selectedCharacterClothes()
    if not isElement(characterUI.previewPed) then
        characterUI.previewPed = createPed(skin, 0, 0, -30)
        if not isElement(characterUI.previewPed) then return end
        setElementData(characterUI.previewPed, 'previewPed', true, false)
    else
        setElementModel(characterUI.previewPed, skin)
    end
    setPedClothes(characterUI.previewPed, 0, clothes.shirt)
    setPedClothes(characterUI.previewPed, 1, clothes.head)
    setPedClothes(characterUI.previewPed, 2, clothes.pants)

    if not characterUI.previewRender then
        local b = characterUI.bounds
        characterUI.previewRender = exports['stoneage_object_preview']:createObjectPreview(
            characterUI.previewPed, 0, 0, 180,
            b.x + 25, b.y + 105, b.w * 0.43, b.h - 145, false, true, true
        )
        if characterUI.previewRender then
            exports['stoneage_object_preview']:setDistanceSpread(characterUI.previewRender, 0)
        end
    end
end

local function closeCharacterCreator()
    characterUI.visible = false
    characterUI.busy = false
    if characterUI.renderHandler then
        removeEventHandler('onClientRender', root, characterUI.renderHandler)
        characterUI.renderHandler = nil
    end
    if characterUI.clickHandler then
        removeEventHandler('onClientClick', root, characterUI.clickHandler)
        characterUI.clickHandler = nil
    end
    destroyCharacterPreview()
    characterUI.bounds = {}
end

local function drawCharacterCreator()
    local b = characterUI.bounds
    if not b or not b.x then return end
    dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 190), false)
    dxDrawRectangle(b.x, b.y, b.w, b.h, predefinedColor('menu:color1'), false)
    dxDrawRectangleBorders(b.x, b.y, b.w, b.h, predefinedColor('menu:color2'), 3, false)
    dxDrawRectangle(b.x, b.y, b.w, 5, predefinedColor('menu:color2'), false)
    dxDrawText('CRÉATION DU PERSONNAGE', b.x + 15, b.y + 18, b.x + b.w - 15, b.y + 62,
        predefinedColor('menu:color2'), 1, font('futura:2'), 'center', 'center', false, false, false)
    dxDrawText('Choisis ton apparence avant de rejoindre le monde.', b.x + 20, b.y + 65, b.x + b.w - 20, b.y + 95,
        predefinedColor('menu:color2'), 1, font('futura'), 'center', 'center', false, false, false)

    local panelX = b.x + b.w * 0.52
    local panelW = b.w * 0.43
    local rows = {
        {label = 'SKIN', value = tostring(characterUI.skins[characterUI.skinIndex] or 0), y = b.y + 145},
        {label = 'HAUT', value = tostring(selectedCharacterClothes().shirt), y = b.y + 225},
        {label = 'PANTALON', value = tostring(selectedCharacterClothes().pants), y = b.y + 305},
    }
    for _, row in ipairs(rows) do
        dxDrawText(row.label, panelX, row.y - 20, panelX + panelW, row.y,
            predefinedColor('menu:color2'), 1, font('futura:2'), 'center', 'center', false, false, false)
        dxDrawRectangle(panelX, row.y, panelW, 42, predefinedColor('menu:color2'), false)
        dxDrawText(row.value, panelX + 42, row.y, panelX + panelW - 42, row.y + 42,
            predefinedColor('menu:color1'), 1, font('futura:2'), 'center', 'center', false, false, false)
        dxDrawText('<', panelX + 5, row.y, panelX + 42, row.y + 42,
            predefinedColor('menu:color1'), 1, font('futura:2'), 'center', 'center', false, false, false)
        dxDrawText('>', panelX + panelW - 42, row.y, panelX + panelW - 5, row.y + 42,
            predefinedColor('menu:color1'), 1, font('futura:2'), 'center', 'center', false, false, false)
    end

    local confirmY = b.y + b.h - 72
    dxDrawRectangle(panelX, confirmY, panelW, 48, predefinedColor('menu:color2'), false)
    dxDrawText(characterUI.busy and 'ENREGISTREMENT...' or 'VALIDER ET JOUER',
        panelX, confirmY, panelX + panelW, confirmY + 48,
        predefinedColor('menu:color1'), 1, font('futura:2'), 'center', 'center', false, false, false)
    if characterUI.message ~= '' then
        dxDrawText(characterUI.message, b.x + 20, b.y + b.h - 112, b.x + b.w - 20, b.y + b.h - 82,
            predefinedColor('menu:color2'), 1, font('futura'), 'center', 'center', true, false, false)
    end
end

local function characterCreatorClick(button, state, cx, cy)
    if not characterUI.visible or button ~= 'left' or state ~= 'down' or characterUI.busy then return end
    local b = characterUI.bounds
    local panelX, panelW = b.x + b.w * 0.52, b.w * 0.43
    local rows = {b.y + 145, b.y + 225, b.y + 305}
    for index, rowY in ipairs(rows) do
        if cx >= panelX and cx <= panelX + panelW and cy >= rowY and cy <= rowY + 42 then
            local direction = cx < panelX + 42 and -1 or (cx > panelX + panelW - 42 and 1 or 0)
            if direction == 0 then return end
            local key = index == 1 and 'skinIndex' or (index == 2 and 'shirtIndex' or 'pantsIndex')
            local list = index == 1 and characterUI.skins or (index == 2 and characterUI.shirts or characterUI.pants)
            characterUI[key] = ((characterUI[key] - 1 + direction) % #list) + 1
            refreshCharacterPreview()
            return
        end
    end

    local confirmY = b.y + b.h - 72
    if cx >= panelX and cx <= panelX + panelW and cy >= confirmY and cy <= confirmY + 48 then
        characterUI.busy = true
        characterUI.message = ''
        triggerServerEvent('rust:character:submit', localPlayer,
            characterUI.skins[characterUI.skinIndex], selectedCharacterClothes())
    end
end

local function openCharacterCreator()
    if characterUI.visible then return end
    closeAuth()
    characterUI.visible = true
    characterUI.busy = false
    characterUI.message = ''
    characterUI.skinIndex = 1
    characterUI.shirtIndex = 1
    characterUI.pantsIndex = 1
    local w, h = math.min(850, sW - 40), math.min(540, sH - 40)
    characterUI.bounds = {x = (sW - w) / 2, y = (sH - h) / 2, w = w, h = h}
    menu.scene = 'character'
    toggleTutorial(false)
    showCursor(true)
    characterUI.renderHandler = drawCharacterCreator
    characterUI.clickHandler = characterCreatorClick
    addEventHandler('onClientRender', root, characterUI.renderHandler)
    addEventHandler('onClientClick', root, characterUI.clickHandler)
    refreshCharacterPreview()
end

addEvent('rust:character:open', true)
addEventHandler('rust:character:open', localPlayer, openCharacterCreator)

addEvent('rust:character:result', true)
addEventHandler('rust:character:result', localPlayer, function(success, message)
    characterUI.busy = false
    characterUI.message = tostring(message or '')
    if success then closeCharacterCreator() end
end)

local function destroyAuthInputs()
    for _, edit in pairs(authUI.edits) do
        if isElement(edit) then destroyElement(edit) end
    end
    authUI.edits = {}
end

local function createAuthInputs()
    destroyAuthInputs()
    local w, h = math.min(520, sW - 40), 410
    local x, y = (sW - w) / 2, (sH - h) / 2
    authUI.bounds = {x = x, y = y, w = w, h = h}
    authUI.edits.username = guiCreateEdit(x + 48, y + 123, w - 96, 34, '', false)
    authUI.edits.password = guiCreateEdit(x + 48, y + 193, w - 96, 34, '', false)
    authUI.edits.confirmPassword = guiCreateEdit(x + 48, y + 263, w - 96, 34, '', false)
    for _, edit in pairs(authUI.edits) do
        guiSetFont(edit, 'default-bold-small')
        guiSetAlpha(edit, 1)
        -- Fond blanc et texte noir dans tous les états du champ.
        guiSetProperty(edit, 'NormalTextColour', 'FF000000')
        guiSetProperty(edit, 'HoverTextColour', 'FF000000')
        guiSetProperty(edit, 'SelectedTextColour', 'FF000000')
        guiSetProperty(edit, 'NormalBackgroundColour', 'FFFFFFFF')
        guiSetProperty(edit, 'HoverBackgroundColour', 'FFFFFFFF')
        guiSetProperty(edit, 'PushedBackgroundColour', 'FFFFFFFF')
        guiSetProperty(edit, 'FocusedBackgroundColour', 'FFFFFFFF')
        guiSetProperty(edit, 'DisabledBackgroundColour', 'FFFFFFFF')
    end
    guiEditSetMaxLength(authUI.edits.username, 20)
    guiEditSetMaxLength(authUI.edits.password, 64)
    guiEditSetMaxLength(authUI.edits.confirmPassword, 64)
    guiEditSetMasked(authUI.edits.password, true)
    guiEditSetMasked(authUI.edits.confirmPassword, true)
    guiSetVisible(authUI.edits.confirmPassword, authUI.mode == 'register')
    guiBringToFront(authUI.edits.username)
    guiSetInputMode('no_binds_when_editing')
end

local function openAuth()
    if authUI.visible then return end
    authUI.visible = true
    authUI.mode = 'login'
    authUI.busy = false
    authUI.message = ''
    menu.scene = 'auth'
    toggleTutorial(false)
    createAuthInputs()
    guiSetInputEnabled(true)
    showCursor(true)
end

local function closeAuth()
    authUI.visible = false
    authUI.busy = false
    destroyAuthInputs()
    guiSetInputEnabled(false)
    guiSetInputMode('allow_binds')
    authUI.bounds = {}
end

local function drawAuth()
    local b = authUI.bounds
    if not b or not b.x then return end
    dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 155), false)
    dxDrawRectangle(b.x, b.y, b.w, b.h, predefinedColor('menu:color1'), false)
    dxDrawRectangleBorders(b.x, b.y, b.w, b.h, predefinedColor('menu:color2'), 3, false)
    dxDrawRectangle(b.x, b.y, b.w, 5, predefinedColor('menu:color2'), false)

    local title = authUI.mode == 'register' and 'CRÉER UN COMPTE' or 'CONNEXION'
    dxDrawText(title, b.x + 20, b.y + 20, b.x + b.w - 20, b.y + 65,
        predefinedColor('menu:color2'), 1, font('futura:2'), 'center', 'center', false, false, false)

    dxDrawText('IDENTIFIANT', b.x + 48, b.y + 92, b.x + b.w - 48, b.y + 120,
        predefinedColor('menu:color2'), 1, font('futura:2'), 'left', 'center', false, false, false)
    dxDrawText('MOT DE PASSE', b.x + 48, b.y + 162, b.x + b.w - 48, b.y + 190,
        predefinedColor('menu:color2'), 1, font('futura:2'), 'left', 'center', false, false, false)
    if authUI.mode == 'register' then
        dxDrawText('CONFIRMER LE MOT DE PASSE', b.x + 48, b.y + 232, b.x + b.w - 48, b.y + 260,
            predefinedColor('menu:color2'), 1, font('futura:2'), 'left', 'center', false, false, false)
    end

    local mainText = authUI.busy and 'VEUILLEZ PATIENTER...' or
        (authUI.mode == 'register' and 'CRÉER MON COMPTE' or 'SE CONNECTER')
    local mainY = b.y + (authUI.mode == 'register' and 335 or 285)
    dxDrawRectangle(b.x + 48, mainY, b.w - 96, 42, predefinedColor('menu:color2'), false)
    dxDrawText(mainText, b.x + 48, mainY, b.x + b.w - 48, mainY + 42,
        predefinedColor('menu:color1'), 1, font('futura:2'), 'center', 'center', false, false, false)

    local switchText = authUI.mode == 'register' and 'Déjà inscrit ? Se connecter' or 'Pas encore de compte ? Créer un compte'
    dxDrawText(switchText, b.x + 35, b.y + 385, b.x + b.w - 35, b.y + 420,
        predefinedColor('menu:color2'), 1, font('futura'), 'center', 'center', false, false, false)
    dxDrawText('FERMER', b.x + b.w - 100, b.y + 12, b.x + b.w - 20, b.y + 42,
        predefinedColor('menu:color2'), 1, font('futura:2'), 'center', 'center', false, false, false)

    if authUI.message and authUI.message ~= '' then
        dxDrawText(authUI.message, b.x + 25, b.y + 430, b.x + b.w - 25, b.y + 465,
            predefinedColor('menu:color2'), 1, font('futura'), 'center', 'center', true, false, false)
    end
end

local function authClick(button, state, cx, cy)
    if not authUI.visible or button ~= 'left' or state ~= 'down' or authUI.busy then return end
    local b = authUI.bounds
    if not b then return end

    if cx >= b.x + b.w - 100 and cx <= b.x + b.w - 20 and cy >= b.y + 12 and cy <= b.y + 42 then
        closeAuth()
        menu.scene = nil
        return
    end

    local mainY = b.y + (authUI.mode == 'register' and 335 or 285)
    if cx >= b.x + 48 and cx <= b.x + b.w - 48 and cy >= mainY and cy <= mainY + 42 then
        local username = guiGetText(authUI.edits.username) or ''
        local password = guiGetText(authUI.edits.password) or ''
        local confirmation = guiGetText(authUI.edits.confirmPassword) or ''
        if username == '' or password == '' then
            authUI.message = 'Remplis les champs obligatoires.'
            return
        end
        if authUI.mode == 'register' and password ~= confirmation then
            authUI.message = 'Les deux mots de passe ne correspondent pas.'
            return
        end
        authUI.busy = true
        authUI.message = ''
        triggerServerEvent('rust:auth:submit', localPlayer, authUI.mode, username, password, confirmation)
        return
    end

    if cy >= b.y + 385 and cy <= b.y + 420 then
        authUI.mode = authUI.mode == 'login' and 'register' or 'login'
        authUI.message = ''
        if isElement(authUI.edits.password) then guiSetText(authUI.edits.password, '') end
        if isElement(authUI.edits.confirmPassword) then
            guiSetText(authUI.edits.confirmPassword, '')
            guiSetVisible(authUI.edits.confirmPassword, authUI.mode == 'register')
        end
    end
end

addEvent('rust:auth:result', true)
addEventHandler('rust:auth:result', localPlayer, function(success, message)
    authUI.busy = false
    authUI.message = tostring(message or '')
    if success then
        closeAuth()
        menu.scene = nil
    end
end)

function toggleLogin(state)
    toggleMenu(true)
    toggleTutorial(true)
end
addEvent('toggleLogin', true)
addEventHandler('toggleLogin', localPlayer, toggleLogin)

function toggleMenu(state)
    if state then
        if activeUI then
            return false
        end
        addEventHandler('onClientRender', root, drawMenu)
        addEventHandler('onClientClick', root, menu.onClick)
        fadeCamera(true)
    else
        if authUI.visible then closeAuth() end
        removeEventHandler('onClientRender', root, drawMenu)
        removeEventHandler('onClientClick', root, menu.onClick)
        toggleTutorial(false)
        if menu.scene == 'config' then
            exports['stoneage_settings']:toggleConfigs(false)
        elseif menu.scene == 'ranking' then
            exports['stoneage_ranking']:toggleRanking(false)
        end
        menu.scene = nil
    end
    if isShowingInventory() then
        toggleInventory(false)
    end
    menu.showing = state
    toggleHUD(not state)
    toggleKeyBar(not state)
    showChat(not state)
    showCursor(state)
end

isMenuShowing = function()
    return menu.showing
end

addEventHandler('onClientResourceStart', resourceRoot, function()
    if not getElementData(localPlayer, 'account') then
        toggleTutorial(true)
    end
end)

addEventHandler('rust:onClientPlayerLogin', localPlayer, function(accName)
    if characterUI.visible then closeCharacterCreator() end
    toggleMenu(false)
end)
-- //------------------- TOGGLE -------------------\\--

-- //------------------- BUTTONS -------------------\\--
local menuItems = {
    ['left'] = {{
        label = 'JOGAR',
        icon = 'ui/play.png',
    }},
    ['right'] = {{
        label = 'QUIT',
        icon = 'ui/quit.png',
    }, {
        label = 'REGRAS',
        icon = 'ui/info.png',
    }, {
        label = 'CONFIG',
        icon = 'ui/settings.png',
    }, {
        label = 'RANKING',
        icon = 'ui/ranking.png',
    }, {label = 'DISCORD',
        icon = 'ui/discord.png',
    }},
}
-- //------------------- BUTTONS -------------------\\--

-- //------------------- DRAW -------------------\\--
function drawMenu()
    menu.headerHeight = pixels(130)
    dxDrawRectangle(0, 0, sW, menu.headerHeight, predefinedColor('menu:color1'), true)
    dxDrawRectangle(0, menu.headerHeight, sW, 5, predefinedColor('menu:color2'), true)

    -- if is playing remove it
    -- local id = table.find(menuItems['left'], 'JOGAR', 'label')
    -- if id then table.remove(menuItems['left'], id) end

    for align, arr in pairs(menuItems) do
        if type(arr) == 'table' then
            menuItems[align].cache = 0
            for k, v in ipairs(arr) do
                menu.drawButton(align, v.label, v.icon)
            end
        end
    end

    local textWidth = dxGetTextWidth('RUST', 1, font('rust:big'))
    local imgX = sW / 2 - menu.headerHeight / 2 - textWidth / 2
    dxDrawImage(imgX, 0, menu.headerHeight, menu.headerHeight, getTexture('logo'), 0, 0, 0, tocolor(255, 255, 255, 255), true)
    dxDrawText('RUST', imgX + menu.headerHeight, 0, sW, menu.headerHeight, predefinedColor('menu:color2'), 1, font('rust:big'), 'left', 'center',
        false, false, true)

    if menu.scene == 'regras' then
        drawRegras()
    end
    if authUI.visible then
        drawAuth()
    end
end

drawRegras = function()
    local x, y = interpolateBetween(sW, 0, 0, sW * 0.6, sH * 0.2, 0, (getTickCount() - menu.toggleTick) / 500, 'OutBack')

    local w, h = sW * 0.35, sH * 0.75

    local padding = 5

    dxDrawRectangle(x, y, w, h, predefinedColor('menu:color1'), true)
    dxDrawRectangleBorders(x, y, w, h, predefinedColor('menu:color2'), 3, true)

    dxDrawText(translate('regras'), x, y, x + w, y + h * 0.05, predefinedColor('menu:color2'), 1, font('franklin:medium'), 'center', 'center', false,
        false, true)

    dxDrawText(translate('Regras'), x + padding, y + h * 0.05, x + w - padding, h * 1.2, predefinedColor('menu:color2'), 1, font('franklin'), 'left',
        'top', true, true, true)
end

function menu.drawButton(align, text, icon, singleIconColor)
    local w, h = menu.headerHeight * 0.75, menu.headerHeight * 0.8

    local y = (menu.headerHeight - h) / 2
    local cache = menuItems[align].cache

    local distanceBetweenButtons = pixels(10)
    local margin = pixels(20)
    local x = align == 'left' and margin + (cache * (w + distanceBetweenButtons)) or sW - margin - (cache + 1) * (w - 1 + distanceBetweenButtons)

    local upperH = h * 0.75
    local bottomH = h - upperH
    local padding = 0

    local hover = isHover(x, y, w, h)
    local fontStyle = font('futura')
    local fontColor = predefinedColor('menu:color2')

    if hover then
        fontColor = predefinedColor('menu:color1')
        fontStyle = font('futura:2')
        padding = 2
        menuItems.hover = text
    else
        if menuItems.hover == text then
            menuItems.hover = nil
        end
    end

    local upperX, upperY = x - padding, y - padding
    local upperW, upperH = w + padding * 2, upperH + padding * 2

    dxDrawRectangleBorders(upperX, upperY, upperW, upperH, predefinedColor('menu:color2'), 1, true)
    dxDrawImage(upperX, upperY, upperW, upperH, getTexture(icon), 0, 0, 0, predefinedColor('menu:color2'), true)

    local bottomX, bottomY = x - padding, (upperY + upperH - padding)
    local bottomW, bottomH = w + padding * 2, bottomH + padding * 2
    if menuItems.hover == text then
        dxDrawRectangle(bottomX, bottomY, bottomW, bottomH, predefinedColor('menu:color2'), true)
    end
    dxDrawRectangleBorders(bottomX, bottomY, bottomW, bottomH, predefinedColor('menu:color2'), 1, true)

    dxDrawText(translate(text), bottomX, bottomY, bottomX + bottomW, bottomY + bottomH, fontColor, 1, fontStyle, 'center', 'center', true, false, true)
    menuItems[align].cache = cache + 1
end
-- //------------------- DRAW -------------------\\--

-- //------------------- ON CLICK -------------------\\--
addEventHandler('onClientClick', root, authClick)

function menu.onClick(btn, state, x, y)
    if authUI.visible then return end
    if btn == 'left' and state == 'down' then
        local selected = menuItems.hover
        if selected == 'QUIT' then
            toggleMenu(false)
            triggerServerEvent('rust:customKick', localPlayer, 'Quit')
            menu.scene = nil
        elseif selected == 'JOGAR' then
            if isTransferBoxActive() then return false end
            if getElementData(localPlayer, 'account') then
                toggleMenu(false)
                setCameraTarget(localPlayer)
            else
                openAuth()
            end
        elseif selected == 'REGRAS' then
            if menu.scene == 'config' then
                exports['stoneage_settings']:toggleConfigs(false)
            end
            if menu.scene == 'regras' then
                menu.scene = nil
            else
                menu.toggleTick = getTickCount()
                menu.scene = 'regras'
            end
        elseif selected == 'CONFIG' then
            if menu.scene == 'config' then
                menu.scene = nil
                exports['stoneage_settings']:toggleConfigs(false)
            else
                exports['stoneage_settings']:toggleConfigs(true)
                menu.scene = 'config'
            end

        elseif selected == 'RANKING' then
            if menu.scene == 'ranking' then
                menu.scene = nil
                exports['stoneage_ranking']:toggleRanking(false)
            else
                exports['stoneage_ranking']:toggleRanking(true)
                menu.scene = 'ranking'
            end
            
        elseif selected == 'DISCORD' then
            setClipboard('YOUR DISCORD INVITE')
            exports['stoneage_notifications']:CreateNotification('The link has been copied to clipboard!', 'success')

        end
    end
end
-- //------------------- ON CLICK -------------------\\--

addEventHandler('onClientKey', root, function(key, state)
    if key == 'escape' and state then
        if getElementData(localPlayer, 'account') then
            cancelEvent()
            toggleMenu(not menu.showing)
        end
    end
end)
