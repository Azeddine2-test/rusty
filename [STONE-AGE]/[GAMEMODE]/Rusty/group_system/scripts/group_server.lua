
--criar grupo
function createGroupForPlayer (playersource,nome_do_grupo,slots)
    if not isGuestAccount(getPlayerAccount(playersource)) and getElementData(playersource,"gang") == "None" then
        if nome_do_grupo and nome_do_grupo ~= "" then
            if not isGangExisting (nome_do_grupo) then
            add_Gang(nome_do_grupo,getAccountName(getPlayerAccount(playersource)),slots)
			setElementData(playersource,'cargo','Lider')
			setElementData(playersource,'gangslots',slots)
			local acName = getPlayerAccount(playersource)
			setAccountData(acName,'cargo','Lider')
			setAccountData(acName,'gangslots',slots)
            outputChatBox ("#FFFFFFVocê Criou o grupo "..nome_do_grupo.." com sucesso.",playersource,27, 89, 224,true)
            else
                outputChatBox ("#FFFFFFJá existe um grupo com este nome.",playersource,27, 89, 224,true)    
            end
        else
            outputChatBox ("#FFFFFFSyntax is /creategroup <name>!",playersource,27, 89, 224,true)    
        end
    else
        outputChatBox ("#FFFFFFYou are in a group already!",playersource,27, 89, 224,true)        
    end
end
addEvent('criar_grupo',true)
addEventHandler('criar_grupo',root,createGroupForPlayer)

-- sair
function sair_do_grupo (player)
    outputChatBox(getPlayerName(player).." saiu do grupo "..getElementData(player,"gang").."!" ,getRootElement(),22,255,22,true)
    removeGangMember(getAccountGang(getAccountName(getPlayerAccount(player))),getAccountName(getPlayerAccount(player)))
	triggerClientEvent('close_group_window',root)
end
addEvent("sair_do_grupo",true)
addEventHandler("sair_do_grupo",getRootElement(),sair_do_grupo)

-- destroy
function destroy_grupo (player)
        outputChatBox(getPlayerName(player).." destruiu o grupo ["..getElementData(player,"gang").."] !",getRootElement(),22,255,22,true)
        for i,gangmember in pairs(getGangMembers(getElementData(player,"gang"))) do
            removeGangMember(getAccountGang(getAccount(gangmember["member_account"])),gangmember["member_account"])
        end
        removeGang(getAccountGang(getAccountName(getPlayerAccount(player))))
		triggerClientEvent('close_group_window',root)
end
addEvent("destroy_grupo",true)
addEventHandler("destroy_grupo",getRootElement(),destroy_grupo)

addEventHandler("onResourceStart", resourceRoot, function()
    local columnName = get("column_name")
    executeSQLCreateTable("gangs", "gang_name STRING, gang_leader STRING, gang_members, gang_subleaders STRING")
    executeSQLCreateTable("gang_members", "gang_name STRING, member_account STRING, added_by STRING")
    checkPlayerGroupDetails()    
    for index, player in ipairs(getElementsByType("player")) do
        local gang = getAccountGang(getAccountName(getPlayerAccount(player)))
        setElementData(player, "gang", gang)
    end
end)









function gang_slots(player,gangName)
if not gangName or not #getGangMembers(gangName) then return end
atual =  #getGangMembers(gangName)
triggerClientEvent('refresh_slots',source,atual,getGangSlots(gangName)) -- trocar esse 1 pelos slots usados no momento #getGangMembers(gangName)
end
addEvent('gang_slots',true)
addEventHandler('gang_slots',root,gang_slots)



function aceitar_pedido(player,gangName)
triggerClientEvent('close_group_window',root)
if #getGangMembers(gangName) +1 > getGangSlots(gangName) then outputChatBox("#22ff22Este grupo já está cheio.",source,22,255,22,true) return end
player_aceito = getPlayerFromName(player)
player_aceito_Name = getPlayerName(player_aceito)
outputChatBox("Você aceitou o pedido de  "..player_aceito_Name,source)
outputChatBox("Você acaba de ter seu pedido para entrar no grupo "..getElementData(player_aceito,'ultimo_pedido').." aceito.",player_aceito)
setElementData(player_aceito,'cargo','Normal')
setElementData(player_aceito,'ultimo_pedido',false)
addGangMember(gangName,getAccountName(getPlayerAccount(player_aceito)),getElementData(source,"accountName"))
outputChatBox(player_aceito_Name.." #22ff22 entrou no grupo ["..gangName.."]!",getRootElement(),22,255,22,true)

end
addEvent('aceitar_pedido',true)
addEventHandler('aceitar_pedido',root,aceitar_pedido)

function aceitarInvite(player,gangName)
triggerClientEvent('close_group_window',root) -- esses root trocar pra player e source
if #getGangMembers(gangName) +1 > getGangSlots(gangName) then outputChatBox("#22ff22Este grupo já está cheio.",player,22,255,22,true) return end
player_aceito = player
player_aceito_Name = getPlayerName(player_aceito)
outputChatBox("Você aceitou o pedido de  "..player_aceito_Name,source)
outputChatBox("Você acaba de ter seu pedido para entrar no grupo "..getElementData(player_aceito,'ultimo_pedido').." aceito.",player_aceito)
setElementData(player_aceito,'ultimo_pedido',false)
addGangMember(gangName,getAccountName(getPlayerAccount(player_aceito)),getElementData(source,"accountName"))
outputChatBox(player_aceito_Name.." #22ff22 entrou no grupo ["..gangName.."]!",getRootElement(),22,255,22,true)
end
addEvent('aceitarInvite',true)
addEventHandler('aceitarInvite',root,aceitarInvite)

function negar_pedido(player)
player_negado = getPlayerFromName(player)
player_negado_Name = getPlayerName(player_negado)
outputChatBox("Você negou o pedido de  "..player_negado_Name,source)
outputChatBox("Você acaba de ter seu pedido para entrar no grupo "..getElementData(player_negado,'ultimo_pedido').." negado.",player_negado)
setElementData(player_negado,'ultimo_pedido',false)
triggerClientEvent('close_group_window',root)
end
addEvent('negar_pedido',true)
addEventHandler('negar_pedido',root,negar_pedido)

function invitePlayer(player,gang)
player_convidado = getPlayerFromName(player)
player_convidado_Name = getPlayerName(player_convidado)
outputChatBox("Voce convidou "..player_convidado_Name,source)
setElementData(player_convidado,'ultimo_pedido',gang)
outputChatBox("Você foi convidado entrar no grupo "..gang..".",player_convidado)
triggerClientEvent('close_group_window',player_convidado)
triggerClientEvent('close_group_window',source)
invitations[player_convidado] = {gang, source}

end
addEvent('invitePlayer',true)
addEventHandler('invitePlayer',root,invitePlayer)
