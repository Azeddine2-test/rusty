
playerGroupWindow = {}


local screenW, screenH = guiGetScreenSize()
        playerGroupWindow.window = guiCreateWindow((screenW - 544) / 2, (screenH - 408) / 2, 544, 408, "Todos os grupos", false)
		guiSetVisible(playerGroupWindow.window,false)
        guiWindowSetMovable(playerGroupWindow.window, false)
        guiWindowSetSizable(playerGroupWindow.window, false)
        guiSetAlpha(playerGroupWindow.window, 1.00)

        playerGroupWindow.grouplist = guiCreateGridList(0.04, 0.12, 0.91, 0.61, true, playerGroupWindow.window)
        playerGroupWindow["grouplist_groupname"] = guiGridListAddColumn(playerGroupWindow.grouplist, "Grupo", 0.3)
        playerGroupWindow["grouplist_groupleader"] = guiGridListAddColumn(playerGroupWindow.grouplist, "Líder", 0.3)
        playerGroupWindow["grouplist_groupmember"] = guiGridListAddColumn(playerGroupWindow.grouplist, "Membros", 0.3)
        playerGroupWindow.groupinvitelist = guiCreateGridList(0.06, 0.79, 0.65, 0.18, true, playerGroupWindow.window)
		playerGroupWindow["groupinvitelist_groupname"] = guiGridListAddColumn(playerGroupWindow.groupinvitelist, "Grupos", 0.4)
        playerGroupWindow["groupinvitelist_groupinviter"] = guiGridListAddColumn(playerGroupWindow.groupinvitelist, "Convidado", 0.2)
        playerGroupWindow["groupinvitelist_groupmember"] = guiGridListAddColumn(playerGroupWindow.groupinvitelist, "Membros", 0.2)
        playerGroupWindow["groupinvitelist_groupvip"] = guiGridListAddColumn(playerGroupWindow.groupinvitelist, "VIP", 0.15)
        playerGroupWindow.groupinvite_accept = guiCreateButton(0.74, 0.80, 0.20, 0.08, "Aceitar", true, playerGroupWindow.window)
        playerGroupWindow.label_todos_os_grupos = guiCreateLabel(26, 20, 495, 28, "Todos os Grupos", false, playerGroupWindow.window)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_todos_os_grupos, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_todos_os_grupos, "center")
        playerGroupWindow.label_ultimos_convites = guiCreateLabel(34, 295, 355, 28, "Ultimos convites", false, playerGroupWindow.window)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_ultimos_convites, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_ultimos_convites, "center")
        playerGroupWindow.button_criar_grupo = guiCreateButton(0.74, 0.89, 0.20, 0.08, "Criar Grupo", true, playerGroupWindow.window)

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


        playerGroupWindow.member_window = guiCreateWindow((screenW - 483) / 2, (screenH - 382) / 2, 483, 382,'', false)
 		guiSetVisible(playerGroupWindow.member_window,false)
		guiWindowSetMovable(playerGroupWindow.member_window, false)
        guiWindowSetSizable(playerGroupWindow.member_window, false)
        guiSetAlpha(playerGroupWindow.member_window, 1.00)

        playerGroupWindow.member_list = guiCreateGridList(0.04, 0.12, 0.54, 0.79, true, playerGroupWindow.member_window)
        playerGroupWindow["member_list_name"] =guiGridListAddColumn(playerGroupWindow.member_list, "Name", 0.7)
        playerGroupWindow["member_list_level"] = guiGridListAddColumn(playerGroupWindow.member_list, "Level", 0.2)
        playerGroupWindow.member_list_destroygroup = guiCreateButton(0.81, 0.60, 0.17, 0.09, "Destruir\nGrupo", true, playerGroupWindow.member_window)
        playerGroupWindow.member_list_leavegang = guiCreateButton(0.63, 0.60, 0.17, 0.09, "Sair do\nGrupo", true, playerGroupWindow.member_window)
        playerGroupWindow.member_list_inviteplayer = guiCreateButton(0.04, 0.91, 0.54, 0.05, "Invite Player", true, playerGroupWindow.member_window)
		
        playerGroupWindow.label_todos_membros = guiCreateLabel(0.04, 0.06, 0.54, 0.06, "Todos os membros", true, playerGroupWindow.member_window)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_todos_membros, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_todos_membros, "center")
        playerGroupWindow.button_adm_player = guiCreateButton(0.63, 0.38, 0.35, 0.09, "Administrar jogador", true, playerGroupWindow.member_window)
        playerGroupWindow.label_selected_player = guiCreateLabel(0.63, 0.12, 0.35, 0.06, "", true, playerGroupWindow.member_window)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_selected_player, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_selected_player, "center")
        playerGroupWindow.label_status = guiCreateLabel(0.63, 0.23, 0.35, 0.04, "", true, playerGroupWindow.member_window)
        guiLabelSetVerticalAlign(playerGroupWindow.label_status, "center")
        playerGroupWindow.label_movestate = guiCreateLabel(0.63, 0.27, 0.35, 0.04, "", true, playerGroupWindow.member_window)
        guiLabelSetVerticalAlign(playerGroupWindow.label_movestate, "center")
        playerGroupWindow.label_lvl = guiCreateLabel(0.63, 0.31, 0.35, 0.04, "", true, playerGroupWindow.member_window)
        guiLabelSetVerticalAlign(playerGroupWindow.label_lvl, "center")


        playerGroupWindow.member_list_destroygroup_reclick_window = guiCreateWindow((screenW - 215) / 2, (screenH - 106) / 2, 215, 106, "Destruir Grupo", false)
        guiWindowSetSizable(playerGroupWindow.member_list_destroygroup_reclick_window, false)
 		guiSetVisible(playerGroupWindow.member_list_destroygroup_reclick_window,false)
		
        playerGroupWindow.member_list_destroygroup_reclick_yes = guiCreateButton(0.09, 0.60, 0.38, 0.33, "Sim", true, playerGroupWindow.member_list_destroygroup_reclick_window)
        playerGroupWindow.member_list_destroygroup_reclick_cancel = guiCreateButton(0.52, 0.60, 0.39, 0.33, "Cancelar", true, playerGroupWindow.member_list_destroygroup_reclick_window)
        playerGroupWindow.member_list_destroygroup_reclick_text = guiCreateLabel(0.05, 0.24, 0.88, 0.27, "Voce tem certeza de que\nquer destruir este grupo?", true, playerGroupWindow.member_list_destroygroup_reclick_window)
        guiSetFont(playerGroupWindow.member_list_destroygroup_reclick_text, "default-bold-small")
        guiLabelSetHorizontalAlign(playerGroupWindow.member_list_destroygroup_reclick_text, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.member_list_destroygroup_reclick_text, "center")


        playerGroupWindow.invite_member_list_window = guiCreateWindow((screenW - 323) / 2, (screenH - 363) / 2, 323, 363, "Selecionar Convidado", false)
        guiWindowSetMovable(playerGroupWindow.invite_member_list_window, false)
        guiWindowSetSizable(playerGroupWindow.invite_member_list_window, false)
 		guiSetVisible(playerGroupWindow.invite_member_list_window,false)
		
        playerGroupWindow.invite_member_list = guiCreateGridList(0.05, 0.06, 0.88, 0.80, true, playerGroupWindow.invite_member_list_window)
        playerGroupWindow["invite_member_list_name"] = guiGridListAddColumn(playerGroupWindow.invite_member_list, "Nome", 0.7)
        playerGroupWindow["invite_member_list_lvl"] = guiGridListAddColumn(playerGroupWindow.invite_member_list, "Level", 0.2)
        playerGroupWindow.invite_member_list_invite = guiCreateButton(0.05, 0.86, 0.88, 0.10, "Convidar", true, playerGroupWindow.invite_member_list_window)


        playerGroupWindow.adm_players = guiCreateWindow((screenW - 269) / 2, (screenH - 119) / 2, 269, 119, "Administração de jogador.", false)
        guiWindowSetMovable(playerGroupWindow.adm_players, false)
        guiWindowSetSizable(playerGroupWindow.adm_players, false)
 		guiSetVisible(playerGroupWindow.adm_players,false)
		
        playerGroupWindow.member_list_kickplayer = guiCreateButton(144, 56, 115, 47, "Expulsar\nJogador", false, playerGroupWindow.adm_players)
        playerGroupWindow.member_list_removesubleader = guiCreateButton(0.04, 0.68, 0.42, 0.18, "Remover Auxiliar", true, playerGroupWindow.adm_players)
        playerGroupWindow.member_list_addsubleader = guiCreateButton(0.04, 0.47, 0.42, 0.18, "Adicionar Auxiliar", true, playerGroupWindow.adm_players)
        playerGroupWindow.label_cargos = guiCreateLabel(0.04, 0.32, 0.42, 0.15, "Cargos", true, playerGroupWindow.adm_players)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_cargos, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_cargos, "center")
        playerGroupWindow.label_geral = guiCreateLabel(0.54, 0.32, 0.42, 0.15, "Geral", true, playerGroupWindow.adm_players)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_geral, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_geral, "center")
        playerGroupWindow.label_selectedName = guiCreateLabel(0.04, 0.17, 0.93, 0.15, "Player Selected Name", true, playerGroupWindow.adm_players)
        guiLabelSetHorizontalAlign(playerGroupWindow.label_selectedName, "center", false)
        guiLabelSetVerticalAlign(playerGroupWindow.label_selectedName, "center")    


function openPlayerGroupWindow ()

			triggerEvent('hide_config_window',localPlayer)
			triggerEvent('hide_help_window',localPlayer)
			triggerEvent('hide_inventory_window',localPlayer)
			triggerEvent('hide_admin_window',localPlayer)
			triggerEvent('hide_craft_window',localPlayer)
			triggerEvent('hide_confirm_window',localPlayer)
			
if getElementData(localPlayer,'gang') == 'None' then
triggerServerEvent("refreshClientGangList", localPlayer)
guiSetVisible(playerGroupWindow.window,not guiGetVisible(playerGroupWindow.window))
	if guiGetVisible(playerGroupWindow.window) then 
		showCursor(true)	
	else
		showCursor(false)
		if guiGetVisible(window_criar_grupo) then guiSetVisible(window_criar_grupo,false) end
	end
	
elseif getElementData(localPlayer,'gang') ~= 'None' then
refreshGangMemberTable()
triggerServerEvent("setTextInWindow", localPlayer,getElementData(localPlayer,'gang'))
guiSetVisible(playerGroupWindow.member_window,not guiGetVisible(playerGroupWindow.member_window))
	if guiGetVisible(playerGroupWindow.member_window) then 
		showCursor(true)	
	else
		showCursor(false)
		if guiGetVisible(playerGroupWindow.invite_member_list_window) then guiSetVisible(playerGroupWindow.invite_member_list_window,false) end
		if guiGetVisible(playerGroupWindow.adm_players) then guiSetVisible(playerGroupWindow.adm_players,false) end
		if guiGetVisible(playerGroupWindow.member_list_destroygroup_reclick_window) then guiSetVisible(playerGroupWindow.member_list_destroygroup_reclick_window,false) end
	end	

end
end
bindKey("f2","down",openPlayerGroupWindow)
addCommandHandler('group',openPlayerGroupWindow)


function hide_group_window ()
if guiGetVisible(playerGroupWindow.window) then 
    guiSetVisible(playerGroupWindow.window,false)
end
if guiGetVisible(window_criar_grupo) then 
    guiSetVisible(window_criar_grupo,false)
end
if guiGetVisible(playerGroupWindow.invite_member_list_window) then guiSetVisible(playerGroupWindow.invite_member_list_window,false) end
if guiGetVisible(playerGroupWindow.adm_players) then guiSetVisible(playerGroupWindow.adm_players,false) end
if guiGetVisible(playerGroupWindow.member_list_destroygroup_reclick_window) then guiSetVisible(playerGroupWindow.member_list_destroygroup_reclick_window,false) end
if guiGetVisible(playerGroupWindow.member_window) then guiSetVisible(playerGroupWindow.member_window,false) end
	
end
addEvent("hide_group_window",true)
addEventHandler("hide_group_window",getLocalPlayer(),hide_group_window)

function typeQuantInWindow (atual,maxima)
gang = getElementData(localPlayer,'gang')
guiSetText(playerGroupWindow.member_window,gang..' ('..atual..'/'..maxima..')') 
end
addEvent("typeQuantInWindow", true)
addEventHandler("typeQuantInWindow", root, typeQuantInWindow)

function refreshGangList (ganglist)
    guiGridListClear(playerGroupWindow["grouplist"])
    for i, group in ipairs(ganglist) do
        local row = guiGridListAddRow ( playerGroupWindow["grouplist"] )
        guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupname"], group[1], false, false )
        guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupleader"],group[2] , false, false )
        guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupmember"],group[3].."/"..group[4] , false, false )
        if group[4] > 12 then
            guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupname"], 22, 255, 22 )
            guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupleader"], 22, 255, 22 )
            guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupmember"], 22, 255, 22 )
        end
    end    
    refreshPlayerInvites()
end
addEvent("refreshGangListToClient", true)
addEventHandler("refreshGangListToClient", root, refreshGangList)

--Actions
function refreshGangMemberTable()
    triggerServerEvent("refreshPlayerGangMemberList",getLocalPlayer())
end

function refreshGangMemberTable2 (gangtable)    
    guiGridListClear(playerGroupWindow["member_list"])
    for i, gangmember in ipairs(gangtable) do
        local row = guiGridListAddRow ( playerGroupWindow["member_list"] )
        local player = gangmember[4]
        if gangmember[2] then
            gangmember[1] = gangmember[1]
        else
            gangmember[1] = gangmember[1]
        end
        if gangmember[3] then
            guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_level"], getElementData(player,"level"), false, false )
			--guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_movestate"],isPedInVehicle (player) and "Vehicle" or "Walking" , false, false )
		else
            guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_level"], "-", false, false )
        end
        r,g,b = 255,22,22
        if gangmember[3] then
            r,g,b = 22,255,22
        end
        guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_name"], gangmember[1], false, false )
        guiGridListSetItemColor ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_name"], r, g, b )
        guiGridListSetItemColor ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_level"], r, g, b )
    end    
end
addEvent("refreshGangMemberTableToClient", true)
addEventHandler("refreshGangMemberTableToClient", root, refreshGangMemberTable2)

function refreshPlayerInvites()
    triggerServerEvent("refreshPlayerInvite",getLocalPlayer())
end

function updatePlayerInvites(name,inviter,member,vip)
    guiGridListClear(playerGroupWindow["groupinvitelist"])
    local row = guiGridListAddRow ( playerGroupWindow["groupinvitelist"])
    guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupname"],name, false, false )
    guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupinviter"],inviter, false, false )
    guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupmember"],member, false, false )
    if vip > 12 then
        guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupvip"],"Sim", false, false )
    else
        guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupvip"],"Não", false, false )
    end    
end
addEvent("updatePlayerInvites",true)
addEventHandler("updatePlayerInvites",getRootElement(),updatePlayerInvites)

function removePlayerInvites()
    guiGridListClear(playerGroupWindow["groupinvitelist"])
end
addEvent("removePlayerInvites",true)
addEventHandler("removePlayerInvites",getRootElement(),removePlayerInvites)

function refreshPlayerInviteList ()
    guiGridListClear(playerGroupWindow["invite_member_list"])
    for i, player in ipairs(getElementsByType("player")) do
        if getElementData(player,"gang") == "None" then
            local row = guiGridListAddRow ( playerGroupWindow["invite_member_list"] )
            guiGridListSetItemText ( playerGroupWindow["invite_member_list"], row, playerGroupWindow["invite_member_list_name"],getPlayerName(player), false, false )
            guiGridListSetItemText ( playerGroupWindow["invite_member_list"], row, playerGroupWindow["invite_member_list_lvl"],getElementData(player,'level'), false, false )
        end
    end
end

function playerGroupSystemButton (button,state)
if not button == "mouse1" and not state == "down" then return end
if source == playerGroupWindow["groupinvite_accept"] then
    triggerServerEvent("acceptGroupInvite",getLocalPlayer())
    guiGridListClear(playerGroupWindow["groupinvitelist"])
    guiSetVisible(playerGroupWindow["window"],false)
    showCursor(false)
elseif source == playerGroupWindow["member_list_destroygroup"] then
    guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],true)
    guiBringToFront(playerGroupWindow["member_list_destroygroup_reclick_window"])
elseif source == playerGroupWindow["member_list_destroygroup_reclick_yes"] then
    triggerServerEvent("destroyGroup",getLocalPlayer())
    guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],false)
    guiSetVisible(playerGroupWindow["member_window"],false)
    showCursor(false)
elseif source == playerGroupWindow["member_list_destroygroup_reclick_cancel"] then
    guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],false)
elseif source == playerGroupWindow["member_list_leavegang"] then
    triggerServerEvent("leaveGroup",getLocalPlayer())
    guiSetVisible(playerGroupWindow["member_window"],false)
    showCursor(false)
elseif source == playerGroupWindow["member_list_inviteplayer"] then
    guiSetVisible(playerGroupWindow["invite_member_list_window"],true)
    guiBringToFront(playerGroupWindow["invite_member_list_window"])
    refreshPlayerInviteList()
elseif source == playerGroupWindow["invite_member_list_invite"] then
    local playerName = guiGridListGetItemText ( playerGroupWindow["invite_member_list"], guiGridListGetSelectedItem ( playerGroupWindow["invite_member_list"] ), 1 )
    triggerServerEvent("invitePlayerToGroup",getLocalPlayer(),playerName)
    guiSetVisible(playerGroupWindow["invite_member_list_window"],false)
elseif source == playerGroupWindow["member_list_kickplayer"] then
    local playerName = guiGridListGetItemText ( playerGroupWindow["member_list"], guiGridListGetSelectedItem ( playerGroupWindow["member_list"] ), 1 )
    triggerServerEvent("kickGroupMember",getLocalPlayer(),playerName)
elseif source == playerGroupWindow["member_list_removesubleader"] then
    local playerName = guiGridListGetItemText ( playerGroupWindow["member_list"], guiGridListGetSelectedItem ( playerGroupWindow["member_list"] ), 1 )
    triggerServerEvent("removeGroupSubLeader",getLocalPlayer(),playerName)
elseif source == playerGroupWindow["member_list_addsubleader"] then
    local playerName = guiGridListGetItemText ( playerGroupWindow["member_list"], guiGridListGetSelectedItem ( playerGroupWindow["member_list"] ), 1 )
    triggerServerEvent("addGroupSubLeader",getLocalPlayer(),playerName)
	
elseif source == playerGroupWindow["button_criar_grupo"] then
guiSetVisible(window_criar_grupo,true)	

elseif source == button_criar_cancelar then
guiSetVisible(window_criar_grupo,false)
elseif source == button_criar_salvar then
createGroupClient()
end
end
addEventHandler("onClientGUIClick",playerGroupWindow["groupinvite_accept"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_leavegang"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_inviteplayer"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_kickplayer"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_removesubleader"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_addsubleader"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup_reclick_cancel"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup_reclick_yes"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",button_criar_cancelar,playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",button_criar_salvar,playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["button_criar_grupo"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["invite_member_list_invite"],playerGroupSystemButton,false)

function createGroupClient()
nome = guiGetText(edit_criar_grupo)
if (string.match(nome,"%W")) or nome == '' then outputChatBox('Insira um nome válido.',255,0,0) return end
triggerServerEvent('createGroup',root,localPlayer,nome)
executeCommandHandler('group')
end

function setStatus(nome,status,in_veh,level)
if not nome or not status or not in_veh or not level then
guiSetText(playerGroupWindow.label_selected_player,'')
guiSetText(playerGroupWindow.label_status,'')
guiSetText(playerGroupWindow.label_movestate,'')
guiSetText(playerGroupWindow.label_lvl,'')
return 
end
guiSetText(playerGroupWindow.label_selected_player,'Nick: '..nome)
guiSetText(playerGroupWindow.label_status,'Status: '..status)
guiSetText(playerGroupWindow.label_movestate,'Movimentação: '..in_veh)
guiSetText(playerGroupWindow.label_lvl,'Level: '..level)
end
addEvent("setStatus", true)
addEventHandler("setStatus", root,setStatus)

function LoadStatusOfSelected()
local nome = guiGridListGetItemText (playerGroupWindow.member_list,guiGridListGetSelectedItem(playerGroupWindow.member_list),1)
local cargo = guiGridListGetItemText (playerGroupWindow.member_list,guiGridListGetSelectedItem(playerGroupWindow.member_list),2)
triggerServerEvent('getSelectedPlayerFromAccount',localPlayer,nome)
end
addEventHandler("onClientGUIClick",playerGroupWindow.member_list,LoadStatusOfSelected)

function openAdminWindow()
if source ~= playerGroupWindow.button_adm_player then return end
local playerName = guiGridListGetItemText ( playerGroupWindow["member_list"], guiGridListGetSelectedItem ( playerGroupWindow["member_list"] ), 1 )
if not playerName or playerName == '' then outputChatBox('Selecione um jogador!',255,255,0) return end
guiSetVisible(playerGroupWindow.adm_players,true)
guiBringToFront(playerGroupWindow.adm_players)
guiSetText(playerGroupWindow.label_selectedName,playerName)
end
addEventHandler("onClientGUIClick",playerGroupWindow.button_adm_player,openAdminWindow,false)

local openGangTick = getTickCount()
function isPlayerKeySpamming()
    local passed = getTickCount() - openGangTick
    if passed < 3000 then
        outputChatBox("You have to wait "..math.floor((3000-passed)/1000+1).." more seconds before you can open the group panel!", 255, 255, 0,true)
        return true
    else
        openGangTick = getTickCount()
        return false
    end
end

playerBlibs = {}
amouunt = 0
function updateGPS ()
    amouunt = 0
    local gangname = getElementData(getLocalPlayer(),"gang")
    for i, blip in ipairs(playerBlibs) do
        if isElement(blip) then
            destroyElement(blip)
        end
    end
    if getElementData(getLocalPlayer(),"gang") == "None" then return end    
    playerBlibs = {}    
    for i, player in ipairs(getElementsByType("player")) do
        if gangname == getElementData(player,"gang") and player ~= localPlayer then
            amouunt = amouunt+1
            playerBlibs[amouunt] = createBlipAttachedTo(player,0,2,22,255,22)
            setBlipVisibleDistance(playerBlibs[amouunt],1000)
        end
    end
end
setTimer(updateGPS,1000,0)


if fileExists("groupsystem_client.lua") == true then
fileDelete("groupsystem_client.lua")
end
