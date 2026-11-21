-- //------------------- TOGGLE -------------------\\--
local menu = {
    scene,
    headerHeight = pixels(120),
    toggleTick = getTickCount(),
    showing = false,
}

local clothesUI = {
    slots = {
        { id = 0, key = "shirt", label = "HAUT" },
        { id = 1, key = "hairBeard", label = "CHEVEUX / BARBES" },
        { id = 2, key = "pants", label = "PANTALON" },
        { id = 3, key = "shoes", label = "CHAUSSURES" },
        { id = 15, key = "glasses", label = "LUNETTES" },
        { id = 16, key = "hat", label = "CHAPEAU" },
    },
    choices = {},
    selected = {},
    bounds = {},
    original = nil,
    saving = false,
}

local function selectedClothes()
    local result = {}
    for _, slot in ipairs(clothesUI.slots) do
        local choices = clothesUI.choices[slot.key] or {}
        result[slot.key] = choices[clothesUI.selected[slot.key] or 1]
    end
    return result
end

local function applyClothesPreview(clothes)
    if getElementModel(localPlayer) ~= 0 then setElementModel(localPlayer, 0) end
    clothes = clothes or selectedClothes()
    for _, slot in ipairs(clothesUI.slots) do
        local value = clothes[slot.key]
        if value == nil then value = false end
        setPedClothes(localPlayer, slot.id, value)
    end
end

local function restoreClothesPreview()
    if type(clothesUI.original) == "table" then
        applyClothesPreview(clothesUI.original)
    end
    clothesUI.saving = false
end

local function openClothesSelector()
    local saved = getElementData(localPlayer, "Clothes") or {
        shirt = 1, hairBeard = 0, pants = 7, shoes = 0, glasses = 0, hat = 0
    }
    saved = table.copy and table.copy(saved) or {
        shirt = saved.shirt, hairBeard = saved.hairBeard or saved.head,
        pants = saved.pants, shoes = saved.shoes, glasses = saved.glasses, hat = saved.hat
    }
    if saved.hairBeard == nil then saved.hairBeard = saved.head or 0 end
    clothesUI.original = {
        shirt = saved.shirt, hairBeard = saved.hairBeard,
        pants = saved.pants, shoes = saved.shoes, glasses = saved.glasses, hat = saved.hat
    }
    clothesUI.saving = false

    for _, slot in ipairs(clothesUI.slots) do
        local choices = { false } -- "SANS" is always before model 0.
        if type(getClothesByTypeIndex) == "function" then
            for index = 0, 300 do
                local texture, model = getClothesByTypeIndex(slot.id, index)
                if texture and model then choices[#choices + 1] = index end
            end
        end
        clothesUI.choices[slot.key] = choices
        clothesUI.selected[slot.key] = 1
        local current = saved[slot.key]
        if current == nil then current = false end
        for i, value in ipairs(choices) do
            if value == current then clothesUI.selected[slot.key] = i break end
        end
    end

    applyClothesPreview(selectedClothes())
    local w, h = math.min(560, sW - 40), 430
    clothesUI.bounds = { x = (sW - w) / 2, y = menu.headerHeight + 35, w = w, h = h }
    menu.scene = "clothes"
end

local function drawClothesSelector()
    local b = clothesUI.bounds
    if not b or not b.x then return end
    dxDrawRectangle(b.x, b.y, b.w, b.h, predefinedColor("menu:color1"), true)
    dxDrawRectangleBorders(b.x, b.y, b.w, b.h, predefinedColor("menu:color2"), 3, true)
    dxDrawRectangle(b.x, b.y, b.w, 5, predefinedColor("menu:color2"), true)
    dxDrawText("PERSONNALISER LE PERSONNAGE", b.x + 12, b.y + 12, b.x + b.w - 12, b.y + 48,
        predefinedColor("menu:color2"), 1, font("futura:2"), "center", "center", false, false, true)
    for row, slot in ipairs(clothesUI.slots) do
        local y = b.y + 65 + (row - 1) * 47
        local choices = clothesUI.choices[slot.key] or { false }
        local selected = clothesUI.selected[slot.key] or 1
        local value = choices[selected]
        local display = value == false and "SANS" or ("Modèle : " .. tostring(value))
        dxDrawText(slot.label, b.x + 20, y, b.x + 155, y + 38, predefinedColor("menu:color2"), 0.9, font("futura:2"), "left", "center", false, false, true)
        dxDrawText("<", b.x + 155, y, b.x + 205, y + 38, predefinedColor("menu:color2"), 1.5, font("futura:2"), "center", "center", false, false, true)
        dxDrawText(display, b.x + 205, y, b.x + b.w - 205, y + 38, predefinedColor("menu:color2"), 1, font("futura"), "center", "center", false, false, true)
        dxDrawText(">", b.x + b.w - 205, y, b.x + b.w - 155, y + 38, predefinedColor("menu:color2"), 1.5, font("futura:2"), "center", "center", false, false, true)
    end
    local saveText = clothesUI.saving and "ENREGISTREMENT..." or "ENREGISTRER"
    dxDrawRectangle(b.x + 25, b.y + b.h - 55, b.w * 0.43, 36, predefinedColor("menu:color2"), true)
    dxDrawText(saveText, b.x + 25, b.y + b.h - 55, b.x + 25 + b.w * 0.43, b.y + b.h - 19, predefinedColor("menu:color1"), 1, font("futura:2"), "center", "center", false, false, true)
    dxDrawRectangle(b.x + b.w * 0.55, b.y + b.h - 55, b.w * 0.4, 36, predefinedColor("menu:color2"), true)
    dxDrawText("ANNULER", b.x + b.w * 0.55, b.y + b.h - 55, b.x + b.w * 0.95, b.y + b.h - 19, predefinedColor("menu:color1"), 1, font("futura:2"), "center", "center", false, false, true)
end

local function handleClothesSelectorClick(x, y)
    local b = clothesUI.bounds
    if not b or not b.x then return true end
    if clothesUI.saving then return true end

    for row, slot in ipairs(clothesUI.slots) do
        local rowY = b.y + 65 + (row - 1) * 47
        if y >= rowY and y <= rowY + 38 then
            local choices = clothesUI.choices[slot.key] or { false }
            local selected = clothesUI.selected[slot.key] or 1
            local changed = false
            if x >= b.x + 155 and x <= b.x + 205 then
                clothesUI.selected[slot.key] = ((selected - 2) % #choices) + 1
                changed = true
            elseif x >= b.x + b.w - 205 and x <= b.x + b.w - 155 then
                clothesUI.selected[slot.key] = (selected % #choices) + 1
                changed = true
            end
            if changed then
                local value = choices[clothesUI.selected[slot.key]]
                setPedClothes(localPlayer, slot.id, value)
            end
            return true
        end
    end

    if y >= b.y + b.h - 55 and y <= b.y + b.h - 19 then
        if x >= b.x + 25 and x <= b.x + 25 + b.w * 0.43 then
            clothesUI.saving = true
            triggerServerEvent("rust:clothes:save", localPlayer, selectedClothes())
        elseif x >= b.x + b.w * 0.55 and x <= b.x + b.w * 0.95 then
            restoreClothesPreview()
            menu.scene = nil
        end
        return true
    end
    if x < b.x or x > b.x + b.w or y < b.y or y > b.y + b.h then
        restoreClothesPreview()
        menu.scene = nil
    end
    return true
end

local authUI = {
    visible = false,
    mode = 'login',
    busy = false,
    message = '',
    edits = {},
    bounds = {},
}

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
        triggerServerEvent('rust:player:ensureSpawn', localPlayer)
        toggleMenu(false)
    end
end)

addEvent('rust:skin:result', true)
addEventHandler('rust:skin:result', localPlayer, function(success, message)
    if message and message ~= '' then outputChatBox(tostring(message), 235, 190, 80) end
end)

addEvent('rust:clothes:result', true)
addEventHandler('rust:clothes:result', localPlayer, function(success, message)
    clothesUI.saving = false
    if success then
        clothesUI.original = selectedClothes()
        menu.scene = nil
    else
        restoreClothesPreview()
        menu.scene = nil
    end
    if message and message ~= '' then outputChatBox(tostring(message), 235, 190, 80) end
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
        if menu.scene == 'clothes' then restoreClothesPreview() end
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
    toggleMenu(false)
end)
-- //------------------- TOGGLE -------------------\\--

-- //------------------- BUTTONS -------------------\\--
local menuItems = {
    ['left'] = {{
        label = 'JOGAR',
        icon = 'ui/play.png',
    }, {
        label = 'VÊTEMENTS',
        icon = 'ui/settings.png',
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
                if v.label ~= 'VÊTEMENTS' or getElementData(localPlayer, 'account') then
                    menu.drawButton(align, v.label, v.icon)
                end
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
    elseif menu.scene == 'clothes' then
        drawClothesSelector()
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
    if btn == 'left' and state == 'down' and menu.scene == 'clothes' then
        handleClothesSelectorClick(x, y)
        return
    end
    if btn == 'left' and state == 'down' then
        local selected = menuItems.hover
        if selected == 'QUIT' then
            toggleMenu(false)
            triggerServerEvent('rust:customKick', localPlayer, 'Quit')
            menu.scene = nil
        elseif selected == 'JOGAR' then
            if isTransferBoxActive() then return false end
            if getElementData(localPlayer, 'account') then
                triggerServerEvent('rust:player:ensureSpawn', localPlayer)
                toggleMenu(false)
                setCameraTarget(localPlayer)
            else
                openAuth()
            end
        elseif selected == 'VÊTEMENTS' then
            if getElementData(localPlayer, 'account') then openClothesSelector() end
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
