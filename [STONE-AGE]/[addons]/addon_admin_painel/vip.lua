
        window_vip = guiCreateWindow(0.34, 0.24, 0.31, 0.52, "VIP Manager v0.1 by iDannz", true)
        guiWindowSetMovable(window_vip, false)
        guiWindowSetSizable(window_vip, false)
        guiSetAlpha(window_vip, 1.00)
		guiSetVisible(window_vip,false)
		guiSetProperty(window_vip,'AlwaysOnTop','true')
		
		label_contas_vips = guiCreateLabel(0.04, 0.05, 0.47, 0.06, "Contas VIPS", true, window_vip)
        guiSetFont(label_contas_vips, "default-bold-small")
        guiLabelSetHorizontalAlign(label_contas_vips, "center", false)
        guiLabelSetVerticalAlign(label_contas_vips, "center")
        gridlist_vips = guiCreateGridList(0.04, 0.11, 0.48, 0.78, true, window_vip)
        acc = guiGridListAddColumn(gridlist_vips, "Contas", 0.9)
        guiGridListSetItemText(gridlist_vips, 0, 1, "teste", false, false)
		
        label_data_expiracao = guiCreateLabel(0.54, 0.10, 0.43, 0.04, "", true, window_vip)
        guiSetFont(label_data_expiracao, "default-bold-small")
        guiLabelSetVerticalAlign(label_data_expiracao, "center")
        label_data_ativacao = guiCreateLabel(0.54, 0.14, 0.43, 0.04, "", true, window_vip)
        guiSetFont(label_data_ativacao, "default-bold-small")
        guiLabelSetVerticalAlign(label_data_ativacao, "center")
        label_data_slots_extra = guiCreateLabel(0.54, 0.18, 0.43, 0.04, "", true, window_vip)
        guiSetFont(label_data_slots_extra, "default-bold-small")
        guiLabelSetVerticalAlign(label_data_slots_extra, "center")
		label_dado_por = guiCreateLabel(0.54, 0.22, 0.43, 0.04, "", true, window_vip)
        guiSetFont(label_dado_por, "default-bold-small")
        guiLabelSetVerticalAlign(label_dado_por, "center")
		
        button_remove_vip = guiCreateButton(0.54, 0.27, 0.20, 0.08, "Remover VIP", true, window_vip)
		guiSetEnabled(button_remove_vip,false)
        button_aumentar_periodo = guiCreateButton(0.77, 0.27, 0.20, 0.08, "Aumentar Periodo", true, window_vip)
		guiSetEnabled(button_aumentar_periodo,false)
		label_todos_jogadores = guiCreateLabel(0.54, 0.36, 0.43, 0.04, "Todos os Jogadores", true, window_vip)
        guiSetFont(label_todos_jogadores, "default-bold-small")
        guiLabelSetHorizontalAlign(label_todos_jogadores, "center", false)
        guiLabelSetVerticalAlign(label_todos_jogadores, "center")
        gridlist_jogadores = guiCreateGridList(0.54, 0.40, 0.43, 0.34, true, window_vip)
        p_vips = guiGridListAddColumn(gridlist_jogadores, "Jogadores", 0.9)
				
        button_adicionar_vip = guiCreateButton(0.54, 0.832, 0.25, 0.08, "Adicionar VIP", true, window_vip)
        check_slots_extra = guiCreateCheckBox(0.79, 0.79, 0.18, 0.04, "Slots extra", false, true, window_vip)

        label_tempo_total = guiCreateLabel(0.54, 0.74, 0.26, 0.04, "Data desejada", true, window_vip)
        guiSetFont(label_tempo_total, "default-bold-small")
        guiLabelSetHorizontalAlign(label_tempo_total, "center", false)
        guiLabelSetVerticalAlign(label_tempo_total, "center")
		
        edit_tempo = guiCreateEdit(0.54, 0.78, 0.25, 0.05, "", true, window_vip)    
        button_close = guiCreateButton(0.79, 0.832, 0.18, 0.08, "Cancelar", true, window_vip)    
	


function refresh_gridlist_players_VIP()
	guiGridListClear(gridlist_jogadores)
	for id, player in ipairs(getElementsByType("player")) do
	if not getElementData(player,'logedin') then return end
		local row = guiGridListAddRow (gridlist_jogadores)		
		guiGridListSetItemText(gridlist_jogadores,row,p_vips,getPlayerName(player),false,false)
	end
end	

function toggle_vip_window(bool)
guiSetVisible(window_vip,bool)
triggerServerEvent('getVipAccounts',localPlayer)
refresh_gridlist_players_VIP()
guiSetText(label_data_expiracao,'')
guiSetText(label_data_ativacao,'')
guiSetText(label_data_slots_extra,'')
guiSetText(label_dado_por,'') 
guiSetEnabled(button_remove_vip,false)
guiSetEnabled(button_aumentar_periodo,false)
end


function refresh_gridlist_vips(vips)
	guiGridListClear(gridlist_vips)
	for id, player in ipairs(vips) do
		local row = guiGridListAddRow (gridlist_vips)		
		guiGridListSetItemText(gridlist_vips,row,acc,player['conta'],false,false)
	end
end
addEvent("refresh_gridlist_vips_C",true)
addEventHandler("refresh_gridlist_vips_C",root,refresh_gridlist_vips)

function setText(expiracao,ativacao,slots,dado_por)
guiSetText(label_data_expiracao,'Data de expiração: '..expiracao..'/2018')
guiSetText(label_data_ativacao,'Data de ativação: '..ativacao)
guiSetText(label_data_slots_extra,'Slots Extra(grupos): '..slots)
guiSetText(label_dado_por,'Vip dado por: '..dado_por)
end
addEvent("setText_C",true)
addEventHandler("setText_C",root,setText)

function clicking ()
if source == button_adicionar_vip then

slots = guiCheckBoxGetSelected(check_slots_extra)
local p_Name = guiGridListGetItemText (gridlist_jogadores,guiGridListGetSelectedItem(gridlist_jogadores),1)
local valido_ate = guiGetText(edit_tempo)
if not p_Name or p_Name == '' then return outputChatBox('Selecione algum jogador!',255,0,0) end
if not valido_ate or valido_ate == '' then outputChatBox('Data inválida!',255,0,0) return end
player = getPlayerFromName(p_Name)
if getElementData(player,'VIP') then outputChatBox('Este jogador já é VIP',255,0,0) return end
time = getRealTime()
day = time.monthday
mes = time.month
ativacao = day..'/'..(mes+1)..'/2018' -- +1 pq tava retornando mes anterior
triggerServerEvent('add_VIP',root,player,tostring(ativacao),valido_ate,slots,localPlayer)
toggle_vip_window(false)
elseif source == button_remove_vip then

local nome = guiGridListGetItemText (gridlist_vips,guiGridListGetSelectedItem(gridlist_vips),1)
if not nome or nome == '' then return outputChatBox('Selecione algum jogador!',255,0,0) end
triggerServerEvent('remove_VIP',root,nome,localPlayer)
toggle_vip_window(false)


elseif source == button_aumentar_periodo then

local nome = guiGridListGetItemText (gridlist_vips,guiGridListGetSelectedItem(gridlist_vips),1)
if not nome or nome == '' then return outputChatBox('Selecione algum jogador!',255,0,0) end
local valido_ate = guiGetText(edit_tempo)
if not valido_ate or valido_ate == '' then outputChatBox('Data inválida!',255,0,0) return end

triggerServerEvent('aumentar_periodo',root,nome,valido_ate,localPlayer)
toggle_vip_window(false)

elseif source == button_close then
toggle_vip_window(false)

end
end
addEventHandler('onClientGUIClick',button_adicionar_vip,clicking,false)
addEventHandler('onClientGUIClick',button_remove_vip,clicking,false)
addEventHandler('onClientGUIClick',button_aumentar_periodo,clicking,false)
addEventHandler('onClientGUIClick',button_close,clicking,false)



function text()
local nome = guiGridListGetItemText (gridlist_vips,guiGridListGetSelectedItem(gridlist_vips),1)
if not nome or nome == '' then 
guiSetText(label_data_expiracao,'')
guiSetText(label_data_ativacao,'')
guiSetText(label_data_slots_extra,'')
guiSetText(label_dado_por,'') 
guiSetEnabled(button_remove_vip,false)
guiSetEnabled(button_aumentar_periodo,false)
return 
end
triggerServerEvent('getTextForAccount',localPlayer,nome)
guiSetEnabled(button_remove_vip,true)
guiSetEnabled(button_aumentar_periodo,true)

end	
addEventHandler('onClientGUIClick',gridlist_vips,text,false)
