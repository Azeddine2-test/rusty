        window = guiCreateWindow(0.29, 0.20, 0.43, 0.59, "Admin Painel by iDannz", true)
        guiWindowSetMovable(window, false)
        guiWindowSetSizable(window, false)
        guiSetVisible(window, false)

        gridlist_players = guiCreateGridList(0.04, 0.09, 0.41, 0.79, true, window)
		nome = guiGridListAddColumn(gridlist_players, "Nome ", 0.9)
		
        label_jogadores = guiCreateLabel(0.04, 0.04, 0.41, 0.05, "Jogadores", true, window)
        guiSetFont(label_jogadores, "default-bold-small")
        guiLabelSetHorizontalAlign(label_jogadores, "center", false)
        guiLabelSetVerticalAlign(label_jogadores, "center")
		
        button_set_element = guiCreateButton(0.04, 0.88, 0.41, 0.09, "Setar Elemento", true, window)
		guiSetEnabled(button_set_element,false)
		
        button_kick = guiCreateButton(0.48, 0.10, 0.14, 0.07, "Expulsar", true, window)
		guiSetEnabled(button_kick,false)
		
        button_matar = guiCreateButton(0.48, 0.18, 0.14, 0.07, "Matar", true, window)
        guiSetEnabled(button_matar,false)

        button_tp_nele = guiCreateButton(0.48, 0.26, 0.14, 0.07, "Ir até ele", true, window)
		guiSetEnabled(button_tp_nele,false)
		
        button_tapinha = guiCreateButton(0.48, 0.34, 0.14, 0.07, "Tapinha", true, window)
		guiSetEnabled(button_tapinha,false)
		
        button_trazer_player = guiCreateButton(0.48, 0.42, 0.14, 0.07, "Trazer até mim", true, window)
		guiSetEnabled(button_trazer_player,false)

        button_destroy_veh = guiCreateButton(0.48, 0.50, 0.14, 0.07, "Destruir Veiculo", true, window)
		guiSetEnabled(button_destroy_veh,false)
		
        gridlist_veiculos = guiCreateGridList(0.64, 0.09, 0.33, 0.42, true, window)
		veiculo = guiGridListAddColumn(gridlist_veiculos, "Nome ", 0.9)
		
        label_veiculos = guiCreateLabel(0.64, 0.04, 0.33, 0.05, "Veiculos", true, window)
        guiSetFont(label_veiculos, "default-bold-small")
        guiLabelSetHorizontalAlign(label_veiculos, "center", false)
        guiLabelSetVerticalAlign(label_veiculos, "center")

        button_spawn_veiculo_em_mim = guiCreateButton(0.65, 0.51, 0.14, 0.07, "Spawnar em mim", true, window)

        button_spawn_veiculo_no_player = guiCreateButton(0.82, 0.51, 0.14, 0.07, "Spawnar no player", true, window)
        guiSetEnabled(button_spawn_veiculo_no_player,false)
		
		button_jetpack = guiCreateButton(0.48, 0.58, 0.14, 0.07, "Pegar Jetpack", true, window)

        button_administrar_vips = guiCreateButton(0.82, 0.59, 0.14, 0.07, "Administrar VIPS", true, window)

        button_admin_destroy = guiCreateButton(0.65, 0.59, 0.14, 0.07, "Destruir Base\nON/OFF", true, window)
		
		
        label_player_nick = guiCreateLabel(0.45, 0.04, 0.20, 0.05, "", true, window)
        guiSetFont(label_player_nick, "default-bold-small")
        guiLabelSetHorizontalAlign(label_player_nick, "center", false)
        guiLabelSetVerticalAlign(label_player_nick, "center")
		
        label_blood = guiCreateLabel(0.48, 0.65, 0.41, 0.05, "", true, window)
        guiSetFont(label_blood, "default-bold-small")
        guiLabelSetVerticalAlign(label_blood, "center")
		
        label_cla = guiCreateLabel(0.48, 0.70, 0.41, 0.05, "", true, window)
        guiSetFont(label_cla, "default-bold-small")
        guiLabelSetVerticalAlign(label_cla, "center")
		
        label_veiculo = guiCreateLabel(0.48, 0.75, 0.41, 0.05, "", true, window)
        guiSetFont(label_veiculo, "default-bold-small")
        guiLabelSetVerticalAlign(label_veiculo, "center")
		
        label_account = guiCreateLabel(0.48, 0.80, 0.41, 0.05, "", true, window)
        guiSetFont(label_account, "default-bold-small")
        guiLabelSetVerticalAlign(label_account, "center")    
		
        label_area = guiCreateLabel(0.48, 0.85, 0.41, 0.05, "", true, window)
        guiSetFont(label_area, "default-bold-small")
        guiLabelSetVerticalAlign(label_area, "center")    

        window_set_data = guiCreateWindow(0.39, 0.42, 0.23, 0.17, "PlayerNick", true)
        guiWindowSetMovable(window_set_data, false)
        guiWindowSetSizable(window_set_data, false)
		guiSetVisible(window_set_data,false)
		guiSetProperty(window_set_data,'AlwaysOnTop','true')
		guiSetAlpha(window_set_data, 1.00)

        edit_item = guiCreateEdit(0.03, 0.31, 0.61, 0.22, "", true, window_set_data)
		edit_quant = guiCreateEdit(0.03, 0.69, 0.61, 0.22, "", true, window_set_data)

        number_ = guiCreateRadioButton(0.68, 0.16, 0.28, 0.11, "number", true, window_set_data)
        guiRadioButtonSetSelected(number_, true)
        string_ = guiCreateRadioButton(0.68, 0.31, 0.28, 0.11, "string", true, window_set_data)
		
        label_valor = guiCreateLabel(0.03, 0.16, 0.61, 0.15, "Valor", true, window_set_data)
        guiSetFont(label_valor, "default-bold-small")
        guiLabelSetHorizontalAlign(label_valor, "center", false)
        guiLabelSetVerticalAlign(label_valor, "center")
		
        label_quantidade = guiCreateLabel(0.03, 0.53, 0.61, 0.15, "Quantidade", true, window_set_data)
        guiSetFont(label_quantidade, "default-bold-small")
        guiLabelSetHorizontalAlign(label_quantidade, "center", false)
        guiLabelSetVerticalAlign(label_quantidade, "center")
		
        button_set_data = guiCreateButton(0.68, 0.48, 0.29, 0.25, "Dar", true, window_set_data)
        button_set_cancelar = guiCreateButton(0.68, 0.75, 0.29, 0.34, "Cancelar", true, window_set_data)
		
addEventHandler ( "onClientRender", root,
	function ()
		guiSetInputMode ( "no_binds_when_editing" )
	end
)
		
	
	
vehiclesTable = {
--{'nome', id, tire,engine,tank, maxfuel} 
{'Picape', 422, 4,1,1, 80},
{'Alpha', 602, 4,1,1, 65},
{'Ninja', 522, 2,1,1, 35},
{'Combi', 483, 4,1,1, 85},
{'Ambulancia', 416, 4,1,1, 75},
{'Bike', 481, 0,0,0, 0},
{'Family', 400, 4,1,1, 70},
{'Lamborghini', 411, 4,1,1, 70},
{'Harley', 463, 2,1,1, 50},
{'Caminhao', 433, 6,1,1, 100},
{'Policia', 461, 2,1,1, 50},
}

function toggle_admin(status)
guiSetVisible(window,status)
showCursor(status)
refresh_gridlist_players()
refresh_gridlist_veiculos()
toggle_give(false)
toggle_vip_window(false)
			triggerEvent('hide_group_window',localPlayer)
			triggerEvent('hide_config_window',localPlayer)
			triggerEvent('hide_inventory_window',localPlayer)
			triggerEvent('hide_help_window',localPlayer)
			triggerEvent('hide_craft_window',localPlayer)
			triggerEvent('hide_confirm_window',localPlayer)
end

function toggle_give(status)
guiSetVisible(window_set_data,status)
end

function hide_admin_window()
guiSetVisible(window,false)
showCursor(false)
toggle_give(false)
toggle_vip_window(false)
end
addEvent('hide_admin_window',true)
addEventHandler('hide_admin_window',root,hide_admin_window)


addEvent('request_paniel_admin',true)
function request_paniel_admin()
toggle_admin(not guiGetVisible(window))
if getElementData(localPlayer,'admin_destroy') then
guiSetText(button_admin_destroy,'Destruir Base\nOFF')
else
guiSetText(button_admin_destroy,'Destruir Base\nON')
end

if doesPedHaveJetPack(localPlayer) then
guiSetText(button_jetpack,'Remover Jetpack')
else
guiSetText(button_jetpack,'Pegar Jetpack')
end
end
addEventHandler('request_paniel_admin',root,request_paniel_admin)

function setAllLabelsEmpty()
guiSetText(window_set_data,'') guiSetText(label_player_nick,'Selecione jogador!') guiSetText(label_blood,'') guiSetText(label_cla,'') guiSetText(label_veiculo,'') guiSetText(label_account,'') guiSetText(label_area,'')
guiSetEnabled(button_set_element,false)
guiSetEnabled(button_kick,false)
guiSetEnabled(button_matar,false)
guiSetEnabled(button_tp_nele,false)
guiSetEnabled(button_tapinha,false)
guiSetEnabled(button_trazer_player,false)
guiSetEnabled(button_destroy_veh,false)
guiSetEnabled(button_spawn_veiculo_no_player,false)
toggle_give(false)
end

function refresh_gridlist_players()
	setAllLabelsEmpty()
	guiGridListClear(gridlist_players)
	for id, player in ipairs(getElementsByType("player")) do
	if not getElementData(player,'logedin') then return end
	if player == localPlayer then --[[return]] end
		local row = guiGridListAddRow (gridlist_players)		
		guiGridListSetItemText(gridlist_players,row,nome,getPlayerName(player),false,false)
	end
end

function refresh_gridlist_veiculos()
	guiGridListClear(gridlist_veiculos)
	for id, data in ipairs(vehiclesTable) do
		local row = guiGridListAddRow (gridlist_veiculos)		
		guiGridListSetItemText(gridlist_veiculos,row,veiculo,data[1],false,false)
	end
end


function refresh_labels()
local playerName = guiGridListGetItemText (gridlist_players,guiGridListGetSelectedItem(gridlist_players),1)
if not playerName or playerName == '' then setAllLabelsEmpty() return end

local player = getPlayerFromName(playerName)
local x,y,z = getElementPosition(player)
local blood = getElementData(player,'blood')
guiSetText(label_blood,'Vida: '..getElementData(player,'blood'))
gang = getElementData(player,'gang') if gang == 'None' then gang = 'Nenhum' end
guiSetText(label_cla,'Grupo: '..gang)
guiSetText(label_account,'Nome da conta: '..getElementData(player,'accountName'))
guiSetText(label_area,'Localização: '..getZoneName(x,y,z)..' ('..getZoneName(x,y,z,true)..')')

guiSetEnabled(button_set_element,true)
guiSetEnabled(button_kick,true)
guiSetEnabled(button_matar,true)
guiSetEnabled(button_tp_nele,true)
guiSetEnabled(button_tapinha,true)
guiSetEnabled(button_trazer_player,true)
guiSetEnabled(button_destroy_veh,true)
guiSetEnabled(button_spawn_veiculo_no_player,true)





vehicle = getPedOccupiedVehicle(player)
if vehicle then
name = getVehicleNameStoneAge(getElementModel(vehicle))
guiSetText(label_veiculo,'Veiculo: '..name..' ('..(getElementHealth(vehicle)/10)..'%)')
guiSetEnabled(button_destroy_veh,true)
else
guiSetEnabled(button_destroy_veh,false)
guiSetText(label_veiculo,'Veiculo: Nenhum')
end
guiSetText(label_player_nick,playerName)
guiSetText(window_set_data,playerName)
end
addEventHandler('onClientRender',root,refresh_labels)


function clicks_player()
local playerName = guiGridListGetItemText (gridlist_players,guiGridListGetSelectedItem(gridlist_players),1)
local vehicleName = guiGridListGetItemText (gridlist_veiculos,guiGridListGetSelectedItem(gridlist_veiculos),1)
if not playerName or playerName == '' then outputChatBox('Selecione algum jogador!',255,0,0)return end
local player = getPlayerFromName(playerName)
local x,y,z = getElementPosition(player)
local blood = getElementData(player,'blood')
if source == button_kick then 
triggerServerEvent("kickar_jogador",root,player,localPlayer)
end
if source == button_matar then 
triggerServerEvent("matar_jogador",root,player,localPlayer)
end
if source == button_tp_nele then 
triggerServerEvent("tp_nele",root,player,localPlayer)
end
if source == button_trazer_player then 
triggerServerEvent("tp_em_mim",root,player,localPlayer)
end
if source == button_tapinha then 
triggerServerEvent("tapinha",root,player,localPlayer)
end
if source == button_destroy_veh then 
triggerServerEvent("destruir_veiculo",root,player,localPlayer)
end
if source == button_set_element then
toggle_give(true)
else
toggle_admin(false)
end
end
addEventHandler('onClientGUIClick',button_tapinha,clicks_player,false)
addEventHandler('onClientGUIClick',button_trazer_player,clicks_player,false)
addEventHandler('onClientGUIClick',button_tp_nele,clicks_player,false)
addEventHandler('onClientGUIClick',button_matar,clicks_player,false)
addEventHandler('onClientGUIClick',button_kick,clicks_player,false)
addEventHandler('onClientGUIClick',button_destroy_veh,clicks_player,false)
addEventHandler('onClientGUIClick',button_set_element,clicks_player,false)

function clicks_veiculos()
local playerName = guiGridListGetItemText (gridlist_players,guiGridListGetSelectedItem(gridlist_players),1)
local vehicleName = guiGridListGetItemText (gridlist_veiculos,guiGridListGetSelectedItem(gridlist_veiculos),1)
local player = getPlayerFromName(playerName)

if source == button_spawn_veiculo_em_mim then 
if not vehicleName or vehicleName == '' then outputChatBox('Selecione um veiculo da lista!',255,0,0) return end
triggerServerEvent("veiculo_pra_mim",root,localPlayer,vehicleName)
toggle_admin(false)
return
end

if source == button_spawn_veiculo_no_player then 
if not playerName or playerName == '' then outputChatBox('Selecione um jogador da lista!',255,0,0)  return end
triggerServerEvent("veiculo_pra_ele",root,player,vehicleName,localPlayer)
toggle_admin(false)
end

if source == button_administrar_vips then
toggle_vip_window(not guiGetVisible(window_vip))
end

if source == window then
toggle_vip_window(false)
toggle_give(false)
end

if source == button_jetpack then
triggerServerEvent("take_jetpack",root,localPlayer)
toggle_admin(false)
end

if source == button_admin_destroy then
setElementData(localPlayer,'admin_destroy', not getElementData(localPlayer,'admin_destroy'))
toggle_admin(false)
end


end
addEventHandler('onClientGUIClick',button_spawn_veiculo_em_mim,clicks_veiculos,false)
addEventHandler('onClientGUIClick',button_spawn_veiculo_no_player,clicks_veiculos,false)
addEventHandler('onClientGUIClick',button_administrar_vips,clicks_veiculos,false)
addEventHandler('onClientGUIClick',button_admin_destroy,clicks_veiculos,false)
addEventHandler('onClientGUIClick',window,clicks_veiculos,false)
addEventHandler('onClientGUIClick',button_jetpack,clicks_veiculos,false)


function setData()
local playerName = guiGridListGetItemText (gridlist_players,guiGridListGetSelectedItem(gridlist_players),1)
item = guiGetText(edit_item)
quant = guiGetText(edit_quant)
isNumber = guiRadioButtonGetSelected(number_)
isString = guiRadioButtonGetSelected(string_)
local player = getPlayerFromName(playerName)
if not player then outputChatBox('Digite o nome do item!',255,0,0) return end

if source == button_set_cancelar then toggle_give(false) end
if source == button_set_data then 
if not item or item == '' then outputChatBox('Digite o nome do item!',255,0,0) return end
if not quant or quant == '' then outputChatBox('Digite a quantidade!',255,0,0) return end
if isNumber then
setElementData(player,item,tonumber(quant))
elseif isString then
setElementData(player,item,tostring(quant))
end
toggle_give(false) 
end


end
addEventHandler('onClientGUIClick',button_set_data,setData,false)
addEventHandler('onClientGUIClick',button_set_cancelar,setData,false)

function getVehicleNameStoneAge(id)
	for i, data in ipairs(vehiclesTable) do
		if id == data[2] then
			return data[1]
		end
	end
end

if fileExists("ComandosTemporarios.lua") == true then
fileDelete("ComandosTemporarios.lua")
end

if fileExists("client.lua") == true then
fileDelete("client.lua")
end