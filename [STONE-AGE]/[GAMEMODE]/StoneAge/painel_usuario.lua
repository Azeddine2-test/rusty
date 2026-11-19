local screenW, screenH = guiGetScreenSize()
        window = guiCreateWindow((screenW - 272) / 2, (screenH - 188) / 2, 272, 188, "Painel do usuário", false)
        guiWindowSetMovable(window, false)
        guiWindowSetSizable(window, false)

        tab_painel = guiCreateTabPanel(0.03, 0.13, 0.93, 0.82, true, window)
        tab_configs = guiCreateTab("Configuracoes", tab_painel)

        label_client = guiCreateLabel(0.00, 0.01, 1.00, 0.12, "Client", true, tab_configs)
        guiSetFont(label_client, "default-bold-small")
        guiLabelSetHorizontalAlign(label_client, "center", false)
        guiLabelSetVerticalAlign(label_client, "center")
        hud_todos = guiCreateCheckBox(0.05, 0.12, 0.21, 0.12, "Todos", false, true, tab_configs)

		
        hud_pessoal = guiCreateCheckBox(0.05, 0.24, 0.35, 0.12, "HUD Pessoal", getElementData(localPlayer,"HUD_PESSOAL_Render"), true, tab_configs)
        hud_armas = guiCreateCheckBox(0.05, 0.36, 0.35, 0.12, "HUD Armas", getElementData(localPlayer,"HUD_ARMAS_Render"), true, tab_configs)
        hud_veiculo = guiCreateCheckBox(0.05, 0.49, 0.35, 0.13, "HUD Veiculo", getElementData(localPlayer,"HUD_VEH_Render"), true, tab_configs)
        show_chat = guiCreateCheckBox(0.05, 0.74, 0.19, 0.12, "Chat", isChatVisible(), true, tab_configs)

        box_linguagem = guiCreateComboBox(0.57, 0.24, 0.43, 0.68, "Padrão", true, tab_configs)
        guiComboBoxAddItem(box_linguagem, "Padrão")
        guiComboBoxAddItem(box_linguagem, "Tipo 2")
		guiSetEnabled(box_linguagem,false)
        label_linguagem = guiCreateLabel(0.57, 0.09, 0.39, 0.15, "HUD Style", true, tab_configs)
        guiSetFont(label_linguagem, "default-bold-small")
        guiLabelSetHorizontalAlign(label_linguagem, "center", false)
        guiLabelSetVerticalAlign(label_linguagem, "center")

guiSetVisible(window,false)

tempo_block = 500
function block()
if source == (hud_todos) or source == hud_pessoal or source == hud_armas or source == hud_veiculo or source == show_chat then
 guiSetEnabled (hud_todos,false)
 guiSetEnabled (hud_pessoal,false)
 guiSetEnabled (hud_armas,false)
 guiSetEnabled (hud_veiculo,false)
 guiSetEnabled (show_chat,false)
setTimer(function ()
 guiSetEnabled (hud_todos,true)
 guiSetEnabled (hud_pessoal,true)
 guiSetEnabled (hud_armas,true)
 guiSetEnabled (hud_veiculo,true)
 guiSetEnabled (show_chat,true)
end, tempo_block,1)

--[[elseif source == (hud_pessoal) then
 guiSetEnabled (hud_pessoal,false)
setTimer(function ()
 guiSetEnabled (hud_pessoal,true)
end, tempo_block,1)
elseif source == (hud_armas) then
 guiSetEnabled (hud_armas,false)
setTimer(function ()
 guiSetEnabled (hud_armas,true)
end, tempo_block,1)
elseif source == (hud_veiculo) then
 guiSetEnabled (hud_veiculo,false)
setTimer(function ()
 guiSetEnabled (hud_veiculo,true)
end, tempo_block,1)
elseif source == (show_chat) then
 guiSetEnabled (show_chat,false)
setTimer(function ()
 guiSetEnabled (show_chat,true)
end, tempo_block,1)
elseif source == (volume_geral) then
 guiSetEnabled (volume_geral,false)
setTimer(function ()
 guiSetEnabled (volume_geral,true)
end, tempo_block,1)]]--

end
end
addEventHandler("onClientGUIClick",root,block)

bindKey('f1','down', function()
if getElementData(getLocalPlayer(),"logedin") then
if guiGetVisible(window) then
		guiSetVisible(window,false)
		showCursor (false)	
else

			triggerEvent('hide_group_window',localPlayer)
			triggerEvent('hide_help_window',localPlayer)
			triggerEvent('hide_inventory_window',localPlayer)
			triggerEvent('hide_admin_window',localPlayer)
			triggerEvent('hide_craft_window',localPlayer)
			triggerEvent('hide_confirm_window',localPlayer)
			
		guiSetVisible(window,true)
		showCursor (true)
		
		if getElementData(localPlayer,"HUD_PESSOAL_Render") and getElementData(localPlayer,"HUD_ARMAS_Render") and getElementData(localPlayer,"HUD_VEH_Render") and isChatVisible() then 
		guiCheckBoxSetSelected(hud_todos,true)
		end	
		
		guiCheckBoxSetSelected(hud_pessoal, getElementData(localPlayer,"HUD_PESSOAL_Render"))
		guiCheckBoxSetSelected(hud_armas, getElementData(localPlayer,"HUD_ARMAS_Render"))
		guiCheckBoxSetSelected(hud_veiculo, getElementData(localPlayer,"HUD_VEH_Render"))

end
end
end)

addEvent('hide_config_window',true)
function hide_config_window()
		guiSetVisible(window,false)
end
addEventHandler('hide_config_window',root,hide_config_window)

function cliques ()
if source == (hud_todos) then
	if guiCheckBoxGetSelected(hud_todos) then
		guiCheckBoxSetSelected(hud_pessoal,true)
		guiCheckBoxSetSelected(hud_armas,true)
		guiCheckBoxSetSelected(hud_veiculo,true)
		guiCheckBoxSetSelected(show_chat,true)
		mostrar_chat()
		if guiCheckBoxGetSelected(hud_pessoal) then setElementData(localPlayer,"HUD_PESSOAL_Render",true) else setElementData(localPlayer,"HUD_PESSOAL_Render",false)end
		if guiCheckBoxGetSelected(hud_armas) then setElementData(localPlayer,"HUD_ARMAS_Render",true) else setElementData(localPlayer,"HUD_ARMAS_Render",false)end
		if guiCheckBoxGetSelected(hud_veiculo) then setElementData(localPlayer,"HUD_VEH_Render",true) else setElementData(localPlayer,"HUD_VEH_Render",false)end
	else
		guiCheckBoxSetSelected(hud_pessoal,false)
		guiCheckBoxSetSelected(hud_armas,false)
		guiCheckBoxSetSelected(hud_veiculo,false)
		guiCheckBoxSetSelected(show_chat,false)
		mostrar_chat()
		if guiCheckBoxGetSelected(hud_pessoal) then setElementData(localPlayer,"HUD_PESSOAL_Render",true)else setElementData(localPlayer,"HUD_PESSOAL_Render",false)end
		if guiCheckBoxGetSelected(hud_armas) then setElementData(localPlayer,"HUD_ARMAS_Render",true)else setElementData(localPlayer,"HUD_ARMAS_Render",false)end
		if guiCheckBoxGetSelected(hud_veiculo) then setElementData(localPlayer,"HUD_VEH_Render",true)else setElementData(localPlayer,"HUD_VEH_Render",false)end
		return
	end
elseif source == (hud_pessoal) then
		if guiCheckBoxGetSelected(hud_pessoal) then setElementData(localPlayer,"HUD_PESSOAL_Render",true)else setElementData(localPlayer,"HUD_PESSOAL_Render",false)end
guiCheckBoxSetSelected(hud_todos,false)
elseif source == (hud_veiculo) then
if guiCheckBoxGetSelected(hud_veiculo) then setElementData(localPlayer,"HUD_VEH_Render",true)else setElementData(localPlayer,"HUD_VEH_Render",false)end
guiCheckBoxSetSelected(hud_todos,false)
elseif source == (hud_armas) then
if guiCheckBoxGetSelected(hud_armas) then setElementData(localPlayer,"HUD_ARMAS_Render",true)else setElementData(localPlayer,"HUD_ARMAS_Render",false)end
guiCheckBoxSetSelected(hud_todos,false)
elseif source == (show_chat) then
mostrar_chat()
guiCheckBoxSetSelected(hud_todos,false)
else
return
end

if guiCheckBoxGetSelected(hud_pessoal) and guiCheckBoxGetSelected(hud_armas) and guiCheckBoxGetSelected(hud_veiculo) and guiCheckBoxGetSelected(show_chat) then
	guiCheckBoxSetSelected(hud_todos,true)
	else
	guiCheckBoxSetSelected(hud_todos,false)
return
end

end
addEventHandler("onClientGUIClick",root,cliques)

function mostrar_chat()
if guiCheckBoxGetSelected(show_chat) then
        showChat(true) 
    else
        showChat(false) 
    end
end



if fileExists("painel_usuario.lua") == true then
fileDelete("painel_usuario.lua")
end