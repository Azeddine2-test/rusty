		--Interface normal
        window_interface = guiCreateWindow(0.35, 0.24, 0.30, 0.53, "Primeiro teste sistema de grupo 04/03/2018", true)
        guiWindowSetMovable(window_interface, false)
        guiWindowSetSizable(window_interface, false)
		guiSetVisible(window_interface,false)

        gridlist_grupos = guiCreateGridList(0.02, 0.14, 0.69, 0.74, true, window_interface)
        nome = guiGridListAddColumn(gridlist_grupos, "Nome ", 0.3)
        criador = guiGridListAddColumn(gridlist_grupos, "Criador", 0.3)
        slots = guiGridListAddColumn(gridlist_grupos, "Slots", 0.3)
        label_lista = guiCreateLabel(0.02, 0.05, 0.69, 0.09, "Lista de Grupos", true, window_interface)
        guiLabelSetHorizontalAlign(label_lista, "center", false)
        guiLabelSetVerticalAlign(label_lista, "center")
        button_enviar_pedido = guiCreateButton(0.02, 0.88, 0.69, 0.07, "Enviar Pedido", true, window_interface)
        button_criar_grupo = guiCreateButton(0.75, 0.44, 0.22, 0.11, "Criar Grupo", true, window_interface)
		
        gridlist_invited = guiCreateGridList(0.75, 0.14, 0.23, 0.20, true, window_interface)
		nome = guiGridListAddColumn(gridlist_invited, "Nome ", 1)
        label_ultimos_invites = guiCreateLabel(0.75, 0.04, 0.23, 0.10, "Ultimos Convites", true, window_interface)
        guiLabelSetHorizontalAlign(label_ultimos_invites, "center", false)
        guiLabelSetVerticalAlign(label_ultimos_invites, "center")
        button_aceitar = guiCreateButton(0.75, 0.34, 0.23, 0.05, "Aceitar Convite", true, window_interface)
        button_desabilitar_invite = guiCreateButton(0.75, 0.58, 0.22, 0.11, "Desabilitar Convites", true, window_interface)

		-- Criar
        window_criar_grupo = guiCreateWindow(0.41, 0.42, 0.19, 0.17, "Criação de grupo", true)
        guiWindowSetMovable(window_criar_grupo, false)
        guiWindowSetSizable(window_criar_grupo, false)
		guiSetProperty(window_criar_grupo,'AlwaysOnTop','true')
		guiSetVisible(window_criar_grupo,false)

        edit_criar_grupo = guiCreateEdit(0.09, 0.37, 0.83, 0.19, "", true, window_criar_grupo)
        guiEditSetMaxLength(edit_criar_grupo, 20)
        label_criar_nome_grupo = guiCreateLabel(0.04, 0.16, 0.92, 0.21, "Nome do grupo", true, window_criar_grupo)
        guiLabelSetHorizontalAlign(label_criar_nome_grupo, "center", false)
        guiLabelSetVerticalAlign(label_criar_nome_grupo, "center")
        button_criar_cancelar = guiCreateButton(0.18, 0.60, 0.27, 0.25, "Cancelar", true, window_criar_grupo)
        button_criar_salvar = guiCreateButton(0.55, 0.60, 0.27, 0.25, "Salvar", true, window_criar_grupo)

		-- inGroup
        window_inGroup_interface = guiCreateWindow(0.35, 0.24, 0.30, 0.53, "Primeiro teste sistema de grupo 04/03/2018", true)
        guiWindowSetMovable(window_inGroup_interface, false)
        guiWindowSetSizable(window_inGroup_interface, false)
		guiSetVisible(window_inGroup_interface,false)

        gridlist_inGroup_jogadores = guiCreateGridList(0.02, 0.14, 0.57, 0.74, true, window_inGroup_interface)
        nome_inGroup_player = guiGridListAddColumn(gridlist_inGroup_jogadores, "Nome", 0.6)
        cargo_inGroup_player = guiGridListAddColumn(gridlist_inGroup_jogadores, "Cargo", 0.3)
        label_inGroup_lista = guiCreateLabel(0.02, 0.05, 0.57, 0.09, "Lista de Jogadores", true, window_inGroup_interface)
        guiLabelSetHorizontalAlign(label_inGroup_lista, "center", false)
        guiLabelSetVerticalAlign(label_inGroup_lista, "center")
        label_inGroup_Status = guiCreateLabel(0.62, 0.06, 0.34, 0.08, "", true, window_inGroup_interface)
        guiLabelSetHorizontalAlign(label_inGroup_Status, "center", false)
        guiLabelSetVerticalAlign(label_inGroup_Status, "center")
        button_inGroup_convidar = guiCreateButton(0.02, 0.89, 0.57, 0.09, "Convidar jogador", true, window_inGroup_interface)
        label_inGroup_mobilidade = guiCreateLabel(0.63, 0.14, 0.33, 0.04, "", true, window_inGroup_interface)
        label_inGroup_cargo = guiCreateLabel(0.63, 0.19, 0.33, 0.04, "", true, window_inGroup_interface)
        label_inGroup_level = guiCreateLabel(0.63, 0.24, 0.33, 0.04, "", true, window_inGroup_interface)
        label_inGroup_convidado = guiCreateLabel(0.63, 0.29, 0.33, 0.04, "", true, window_inGroup_interface)
        button_inGroup_cargo = guiCreateButton(0.81, 0.36, 0.15, 0.07, "Cargo", true, window_inGroup_interface)
		guiSetProperty(button_inGroup_cargo,'Disabled','true')
		button_inGroup_mute = guiCreateButton(0.63, 0.36, 0.15, 0.07, "Mutar", true, window_inGroup_interface)
		guiSetProperty(button_inGroup_mute,'Disabled','true')
        button_expulsar = guiCreateButton(0.63, 0.45, 0.15, 0.07, "Expulsar", true, window_inGroup_interface)
		guiSetProperty(button_expulsar,'Disabled','true')
        button_inGroup_sair = guiCreateButton(0.65, 0.89, 0.29, 0.09, "Sair do grupo", true, window_inGroup_interface)
		guiSetVisible(button_inGroup_sair,false)
        button_inGroup_destroy = guiCreateButton(0.65, 0.89, 0.29, 0.09, "Destruir do grupo", true, window_inGroup_interface)
		guiSetVisible(button_inGroup_destroy,false)
		
        gridlist_inGroup_pedidos = guiCreateGridList(0.63, 0.59, 0.33, 0.21, true, window_inGroup_interface)
        nome_inGroup_pedido = guiGridListAddColumn(gridlist_inGroup_pedidos, "Nome", 0.5)
        level_inGroup_pedido = guiGridListAddColumn(gridlist_inGroup_pedidos, "Level", 0.3)
		
        label_inGoup_pedidos = guiCreateLabel(0.63, 0.54, 0.32, 0.04, "Ultimos pedidos", true, window_inGroup_interface)
        guiLabelSetHorizontalAlign(label_inGoup_pedidos, "center", false)
        guiLabelSetVerticalAlign(label_inGoup_pedidos, "center")
		
        button_inGroup_Negar = guiCreateButton(0.63, 0.8, 0.14, 0.04, "Negar", true, window_inGroup_interface)
		guiSetProperty(button_inGroup_Negar,'Disabled','true')
        button_inGroup_Aceitar = guiCreateButton(0.82, 0.8, 0.14, 0.04, "Aceitar", true, window_inGroup_interface)
		guiSetProperty(button_inGroup_Aceitar,'Disabled','true')
		--Convidar
        window_convidar = guiCreateWindow(0.42, 0.32, 0.17, 0.37, "Convidar Jogador", true)
        guiWindowSetMovable(window_convidar,false)
        guiWindowSetSizable(window_convidar,false)
		guiSetProperty(window_convidar,'AlwaysOnTop','true')
		guiSetVisible(window_convidar,false)

        gridlist_convidar = guiCreateGridList(0.10, 0.08, 0.80, 0.77, true, window_convidar)
		nome_invite = guiGridListAddColumn(gridlist_convidar, "Nome", 0.6)
		level_invite = guiGridListAddColumn(gridlist_convidar, "Level", 0.2)
        button_convite_cancelar = guiCreateButton(0.10, 0.87, 0.35, 0.10, "Cancelar", true, window_convidar)
        button_convidar = guiCreateButton(0.55, 0.87, 0.35, 0.10, "Convidar", true, window_convidar)

		--Confirmação sair
		window_certeza_sair = guiCreateWindow(0.41, 0.44, 0.17, 0.12, "Destruir grupo", true)
        guiWindowSetMovable(window_certeza_sair, false)
        guiWindowSetSizable(window_certeza_sair, false)
		guiSetProperty(window_certeza_sair,'AlwaysOnTop','true')
		guiSetVisible(window_certeza_sair,false)
		
        label_certeza_sair = guiCreateLabel(0.04, 0.22, 0.91, 0.31, "Voce tem certeza?", true, window_certeza_sair)
        guiLabelSetHorizontalAlign(label_certeza_sair, "center", false)
        guiLabelSetVerticalAlign(label_certeza_sair, "center")
        button_certeza_sair_NAO = guiCreateButton(0.09, 0.53, 0.34, 0.37, "Não", true, window_certeza_sair)
        button_certeza_sair_SIM = guiCreateButton(0.58, 0.53, 0.34, 0.37, "Sim", true, window_certeza_sair)
		
		--Confirmação destroy		
		window_certeza_destroy = guiCreateWindow(0.41, 0.44, 0.17, 0.12, "Destruir grupo", true)
        guiWindowSetMovable(window_certeza_destroy, false)
        guiWindowSetSizable(window_certeza_destroy, false)
		guiSetProperty(window_certeza_destroy,'AlwaysOnTop','true')
		guiSetVisible(window_certeza_destroy,false)
			
        label_certeza_destroy = guiCreateLabel(0.04, 0.22, 0.91, 0.31, "Voce tem certeza?", true, window_certeza_destroy)
        guiLabelSetHorizontalAlign(label_certeza_destroy, "center", false)
        guiLabelSetVerticalAlign(label_certeza_destroy, "center")
        button_certeza_destroy_NAO = guiCreateButton(0.09, 0.53, 0.34, 0.37, "Não", true, window_certeza_destroy)
        button_certeza_destroy_SIM = guiCreateButton(0.58, 0.53, 0.34, 0.37, "Sim", true, window_certeza_destroy)
	
		guiSetInputMode("no_binds_when_editing")
slot_maximo = 50		
function cliques()
if source == button_criar_grupo then
	guiSetVisible(window_criar_grupo,true)
	guiSetProperty(window_interface,'Disabled','true')
elseif source == button_criar_cancelar then
	fechar_criacao()
elseif source == button_criar_salvar then
	nome_do_grupo = guiGetText(edit_criar_grupo)
	triggerServerEvent('criar_grupo',root,getLocalPlayer(),nome_do_grupo,slot_maximo)
	toggle()
elseif source == button_inGroup_convidar then 
	guiSetVisible(window_convidar,true)
	guiSetProperty(window_inGroup_interface,'Disabled','true')
	refresh_gridlist_invite()	
elseif source == button_convite_cancelar then
	fechar_convite()
elseif source == button_inGroup_sair then 
	guiSetVisible(window_certeza_sair,true)
	guiSetProperty(window_inGroup_interface,'Disabled','true')	
elseif source == button_certeza_sair_NAO then 
	fechar_confirmacao_sair()
elseif source == button_certeza_sair_SIM then 
	triggerServerEvent('sair_do_grupo',root,getLocalPlayer())
elseif source == button_inGroup_destroy then 
	guiSetVisible(window_certeza_destroy,true)
	guiSetProperty(window_inGroup_interface,'Disabled','true')	
elseif source == button_certeza_destroy_NAO then 
	fechar_confirmacao_destroy()
elseif source == button_certeza_destroy_SIM then 
	triggerServerEvent('destroy_grupo',root,getLocalPlayer())
elseif source == button_enviar_pedido then
	enviar_pedido()
elseif source == button_inGroup_Negar then
	negar_pedido()
elseif source == button_inGroup_Aceitar then
	aceitar_pedido()
elseif source == button_desabilitar_invite then
	toggle_convites()
elseif source == button_convidar then
	enviar_convite()
elseif source == button_aceitar then
	aceitarInvite()

	
	
end
end
addEventHandler('onClientGUIClick',root,cliques)

function enviar_convite() -- quando clica em convidar [inGroup]
local player = guiGridListGetItemText (gridlist_convidar,guiGridListGetSelectedItem(gridlist_convidar),1)
if player == "" then return end
gangName = getElementData(localPlayer,'gang')
triggerServerEvent('invitePlayer',root,player,gangName)
end

tempo_ate_esgotar_pedido = 60000*5
function enviar_pedido() -- quando clica pra pedir pra entrar no grupo [outGroup]
local nome_grupo = guiGridListGetItemText (gridlist_grupos,guiGridListGetSelectedItem(gridlist_grupos),1)
local criador = guiGridListGetItemText (gridlist_grupos,guiGridListGetSelectedItem(gridlist_grupos),2)
local slots = guiGridListGetItemText (gridlist_grupos,guiGridListGetSelectedItem(gridlist_grupos),3)
if nome_grupo == "" then return end
setElementData(localPlayer,'ultimo_pedido',nome_grupo)
setTimer(function ()
setElementData(localPlayer,'ultimo_pedido',false)
end,tempo_ate_esgotar_pedido,1)
outputChatBox("Você enviou uma solicitação para entrar no grupo ["..nome_grupo.."]",255,255,0)
fechar_tudo()
end

function aceitar_pedido() --quando aceita pedido [inGroup]
local player = guiGridListGetItemText (gridlist_inGroup_pedidos,guiGridListGetSelectedItem(gridlist_inGroup_pedidos),1)
if player == "" then return end
gangName = getElementData(localPlayer,'gang')
triggerServerEvent("aceitar_pedido",root,player,gangName)
end

function negar_pedido() -- quanto nega pedido [inGroup]
local player = guiGridListGetItemText (gridlist_inGroup_pedidos,guiGridListGetSelectedItem(gridlist_inGroup_pedidos),1)
if player == "" then return end
triggerServerEvent("negar_pedido",root,player)
end

function toggle_convites() --quando clica em habilitar/desabilitar convites [outGroup]
setElementData(localPlayer,'block_invites', not getElementData(localPlayer,'block_invites'))
	if getElementData(localPlayer,'block_invites') == false then 
	guiSetText(button_desabilitar_invite,'Desabilitar Convites')
	else
	guiSetText(button_desabilitar_invite,'Habilitar\nConvites')
	end
end

function refresh_pedidos() -- refresh na gridlist de pedidos [inGroup]
	guiGridListClear(gridlist_inGroup_pedidos)
	for id, player in ipairs(getElementsByType("player")) do
	if getElementData(player,'ultimo_pedido') ~= getElementData(localPlayer,'gang') then return end
	local row = guiGridListAddRow ( gridlist_inGroup_pedidos )		
		guiGridListSetItemText ( gridlist_inGroup_pedidos, row, nome_inGroup_pedido, getPlayerName ( player ), false, false )
		guiGridListSetItemText ( gridlist_inGroup_pedidos, row, level_inGroup_pedido, getElementData(player,"level") or "sem level", false, false )
	end
end

function refresh_gridlist_invite() -- refresh na gridlist dos jogadores que da pra invitar [inGroup]
	guiGridListClear(gridlist_convidar)
	for id, player in ipairs(getElementsByType("player")) do
	if not getElementData(player,'logedin') then return end
	--if player == localPlayer then outputChatBox('player e vc') return end
	--if getElementData(player,'gang') ~= 'None' then outputChatBox("O jogador "..getPlayerName(player).. " Já tem grupo!")return end  
	if getElementData(player,'block_invites') then outputChatBox(getPlayerName(player).. " block_invites = true") return end	
		local row = guiGridListAddRow ( gridlist_convidar )		
		guiGridListSetItemText ( gridlist_convidar, row, nome_invite, getPlayerName ( player ), false, false )
		guiGridListSetItemText ( gridlist_convidar, row, level_invite, getElementData(player,"level") or "sem level", false, false )
		
	end
end

function refresh_gridlist_inGroup_players() -- refresh na gridlist dos jogadores do seu grupo [inGroup]
	guiGridListClear(gridlist_inGroup_jogadores)
	for id, player in ipairs(getElementsByType("player")) do
	if not getElementData(player,'logedin') then return end
	if getElementData(player,'gang') == 'None' and getElementData(player,'gang') ~= getElementData(localPlayer,'gang') then return end  
		local row = guiGridListAddRow ( gridlist_inGroup_jogadores )
		guiGridListSetItemText ( gridlist_inGroup_jogadores, row, nome_inGroup_player, getPlayerName ( player ), false, false )
		guiGridListSetItemText ( gridlist_inGroup_jogadores, row, cargo_inGroup_player, getElementData(player,"cargo") or "sem cargo", false, false )
			if player == localPlayer then 
				guiGridListSetItemColor (gridlist_inGroup_jogadores, row, nome_inGroup_player, 255, 255, 0 )
				guiGridListSetItemColor (gridlist_inGroup_jogadores, row, cargo_inGroup_player, 255, 255, 0 )
			end
	end
end

function refreshGangList (ganglist) --refresh na lista de grupos [outGroup]
    guiGridListClear(gridlist_grupos)
    for i, group in ipairs(ganglist) do
        local row = guiGridListAddRow ( gridlist_grupos )
        guiGridListSetItemText ( gridlist_grupos, row, nome, group[1], false, false )
        guiGridListSetItemText ( gridlist_grupos, row, criador,group[2] , false, false )
        guiGridListSetItemText ( gridlist_grupos, row, slots,group[3].."/"..group[4] , false, false )
    end    
end
addEvent("refreshGangListToClient", true)
addEventHandler("refreshGangListToClient", root, refreshGangList)
function refresh_1 ()
    triggerServerEvent("refreshClientGangList",getLocalPlayer())
end

function refreshInvited (ganglist) --refresh na lista de ultimos pedidos [outGroup]
    guiGridListClear(gridlist_invited)
        local row = guiGridListAddRow ( gridlist_invited )
        guiGridListSetItemText ( gridlist_invited, row, 1, ganglist, false, false )
end
addEvent("refresh_invited", true)
addEventHandler("refresh_invited", root, refreshInvited)

function refresh_2 ()
    triggerServerEvent("refreshPlayerInvite",getLocalPlayer())
end


function refresh_slots(slot_atual,slot_maximo)
guiSetText(window_inGroup_interface,getElementData(localPlayer,'gang').." ["..slot_atual.."/"..slot_maximo.."]")
end
addEvent("refresh_slots", true)
addEventHandler("refresh_slots", root, refresh_slots)


function aceitarInvite() --quando aceita pedido [outGroup]
local gangName = guiGridListGetItemText (gridlist_invited,guiGridListGetSelectedItem(gridlist_invited),1)
if gangName == "" then return end
triggerServerEvent("aceitarInvite",root,localPlayer,gangName)
end











function toggle()
if getElementData(localPlayer,'gang') ~= 'None' then
triggerServerEvent('gang_slots',root,localPlayer,getElementData(localPlayer,'gang'))

guiSetVisible(window_inGroup_interface,not guiGetVisible(window_inGroup_interface))
if guiGetVisible(window_inGroup_interface) then 
triggerEvent('hide_inventory_window',localPlayer)
triggerEvent('hide_config_window',localPlayer)
triggerEvent('hide_craft_window',localPlayer)
showCursor(true)
else
showCursor(false)
end

refresh_gridlist_inGroup_players()
refresh_pedidos()

if getElementData(localPlayer,'cargo') == 'Lider' then
guiSetVisible(button_inGroup_destroy,true)
else
guiSetVisible(button_inGroup_sair,true)
end
if guiGetVisible(window_criar_grupo) then fechar_criacao() end
if guiGetVisible(window_convidar) then fechar_convite() end
if guiGetVisible(window_certeza_sair) then fechar_confirmacao_sair() end
if guiGetVisible(window_certeza_destroy) then fechar_confirmacao_destroy() end
return
end
guiSetVisible(window_interface,not guiGetVisible(window_interface))
if guiGetVisible(window_interface) then 
triggerEvent('hide_inventory_window',localPlayer)
triggerEvent('hide_config_window',localPlayer)
triggerEvent('hide_craft_window',localPlayer)
showCursor(true)
else
showCursor(false)
end
refresh_1()
refresh_2()
if getElementData(localPlayer,'cargo') == 'Lider' then
guiSetVisible(button_inGroup_destroy,true)
else
guiSetVisible(button_inGroup_sair,true)
end
if guiGetVisible(window_criar_grupo) then fechar_criacao() end
if guiGetVisible(window_convidar) then fechar_convite() end
if guiGetVisible(window_certeza_sair) then fechar_confirmacao_sair() end
if guiGetVisible(window_certeza_destroy) then fechar_confirmacao_destroy() end
end
--bindKey('f2','down',toggle)



addEvent('close_group_window',true)
function fechar_tudo()
fechar_confirmacao_sair()
fechar_confirmacao_destroy()
fechar_criacao()
fechar_convite()
guiSetVisible(window_inGroup_interface,false)
guiSetVisible(window_interface,false)
showCursor(false)
end
addEventHandler('close_group_window',root,fechar_tudo)

addEvent('hide_group_window',true)
function hide_group_window()
fechar_confirmacao_sair()
fechar_confirmacao_destroy()
fechar_criacao()
fechar_convite()
guiSetVisible(window_inGroup_interface,false)
guiSetVisible(window_interface,false)
end
addEventHandler('hide_group_window',root,hide_group_window)





function fechar_confirmacao_sair()
	guiSetProperty(window_inGroup_interface,'Disabled','false')
	guiSetVisible(window_certeza_sair,false)
end
function fechar_confirmacao_destroy()
	guiSetProperty(window_inGroup_interface,'Disabled','false')
	guiSetVisible(window_certeza_destroy,false)
end
function fechar_criacao()
	guiSetProperty(window_interface,'Disabled','false')
	guiSetVisible(window_criar_grupo,false)
end
function fechar_convite()
	guiSetProperty(window_inGroup_interface,'Disabled','false')
	guiSetVisible(window_convidar,false)
end





function refresh_info_inGroup() -- refresh das informaçoes dos jogadores [inGroup]
if source == gridlist_inGroup_jogadores then
local player = guiGridListGetItemText (gridlist_inGroup_jogadores,guiGridListGetSelectedItem(gridlist_inGroup_jogadores),1)
local cargo = guiGridListGetItemText (gridlist_inGroup_jogadores,guiGridListGetSelectedItem(gridlist_inGroup_jogadores),2)
if not player or player == "" then 
guiSetProperty(button_inGroup_cargo,'Disabled','true')
guiSetProperty(button_inGroup_mute,'Disabled','true')
guiSetProperty(button_expulsar,'Disabled','true')
guiSetText(label_inGroup_Status,"")
guiSetText(label_inGroup_cargo,"")
guiSetText(label_inGroup_level,"")
guiSetText(label_inGroup_convidado,"")
return 
end
guiSetProperty(button_inGroup_cargo,'Disabled','false')
guiSetProperty(button_inGroup_mute,'Disabled','false')
guiSetProperty(button_expulsar,'Disabled','false')

guiSetText(label_inGroup_Status,"Status de "..player)
guiSetText(label_inGroup_cargo,"Cargo: "..getElementData(getPlayerFromName(player),'cargo'))
guiSetText(label_inGroup_level,"Level: "..getElementData(getPlayerFromName(player),'level'))
if cargo == 'Lider' then 
guiSetText(label_inGroup_convidado,"Fundador")
guiSetProperty(button_inGroup_cargo,'Disabled','true')
guiSetProperty(button_inGroup_mute,'Disabled','true')
guiSetProperty(button_expulsar,'Disabled','true')
else
guiSetText(label_inGroup_convidado,"Membro") -- falta isso
end
end
end
addEventHandler('onClientGUIClick',root,refresh_info_inGroup)

function select_pedido() -- desabilitar botoes de aceitar convite se nao houver nenhum [inGroup]
if source == gridlist_inGroup_pedidos then
local player = guiGridListGetItemText (gridlist_inGroup_pedidos,guiGridListGetSelectedItem(gridlist_inGroup_pedidos),1)
local level = guiGridListGetItemText (gridlist_inGroup_pedidos,guiGridListGetSelectedItem(gridlist_inGroup_pedidos),2)
if not player or player == "" then 
guiSetProperty(button_inGroup_Negar,'Disabled','true')
guiSetProperty(button_inGroup_Aceitar,'Disabled','true')
return
end
guiSetProperty(button_inGroup_Negar,'Disabled','false')
guiSetProperty(button_inGroup_Aceitar,'Disabled','false')
end
end
addEventHandler('onClientGUIClick',root,select_pedido)


