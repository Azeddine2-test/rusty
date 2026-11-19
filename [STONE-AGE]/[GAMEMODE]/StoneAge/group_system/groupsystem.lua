--[[
addGang - Arguments: gangName, gangLeader. Returns: true or false.
removeGang - Arguments: gangName. Returns: true or false.
doesGangExists - Arguments: gangName. Returns: true or false.
getGangList - Arguments: None. Returns: A table with gang list.
getGangMembers - Arguments: gangName. Returns: A table with gang members.
addGangMember - Arguments: gangName, accountName, addedBy. Returns: true or false (if false, it'll return a second argument with the error.).
removeGangMember - Arguments: gangName, accountName, kickerName (if used it'll output who kicked the member, else it'll output that you left).
isGangMember - Arguments: gangName, accountName. Returns: true or false.
getAccountGang - Arguments: accountName. Returns: The gang name, 'None' otherwise.
getGangLeader - Arguments: gangName. Returns: The gang leader.
getGangSubLeaders - Arguments: gangName. Returns: A JSON string with gang sub leaders.
isPlayerGangInvited - Arguments: thePlayer. Returns: 3 arguments: invited, gangName, inviter.
getPlayersByGang - Arguments: gangName. Returns: A table with gang players.
isGangSubLeader - Arguments: gangName, accountName. Returns: true or false.
]]

function getGangSlots (gangname)
    local account = getAccount(getGangLeader(gangname))
    if account then
        return (getAccountData(account,"gangslots") or 0)
    else
        return 12
    end
end

function setTextInWindow(gang)
maxima = getGangSlots(gang)
atual = #getGangMembers(gang)
    triggerClientEvent(source, "typeQuantInWindow", source, atual,maxima)
end
addEvent("setTextInWindow",true)
addEventHandler("setTextInWindow",getRootElement(),setTextInWindow)

function checkPlayerGroupDetails ()
    gangtable = {}
    local gangtablename = getGangList()
    for i,group in pairs(gangtablename) do
        local gangtablemembers = #getGangMembers(group["gang_name"])
        local groupleader = getGangLeader(group["gang_name"])
        local gangvip = getGangSlots (group["gang_name"])
        table.insert(gangtable,{group["gang_name"],groupleader,gangtablemembers,gangvip})    
    end    
end
setTimer(checkPlayerGroupDetails,500,0)

playerTeam = createTeam ("Player")
function updateGangTable()
    setPlayerTeam(source,playerTeam)
end
addEventHandler("onPlayerJoin",getRootElement(),updateGangTable)

function refreshClientGangList()
    triggerClientEvent(source, "refreshGangListToClient", source, gangtable)
end
addEvent("refreshClientGangList",true)
addEventHandler("refreshClientGangList",getRootElement(),refreshClientGangList)

function refreshPlayerGangMemberList ()
    local gangmembertable = {}
    local account = getPlayerAccount(source)
    local gang = getAccountGang(getAccountName(account))
    if gang == "None" then return end
    for i,gangmember in pairs(getGangMembers(gang)) do
        local groupleader = getGangLeader(gang)
        gangleader = false
        if gangmember["member_account"] == groupleader then
            gangleader = true
        end
        logedin = false
        if getAccountPlayer(getAccount(gangmember["member_account"])) then
            logedin = true
            player = getAccountPlayer(getAccount(gangmember["member_account"]))
        end
        table.insert(gangmembertable,{gangmember["member_account"],gangleader,logedin,player})    
    end    
    triggerClientEvent(source, "refreshGangMemberTableToClient", source, gangmembertable)
end
addEvent("refreshPlayerGangMemberList",true)
addEventHandler("refreshPlayerGangMemberList",getRootElement(),refreshPlayerGangMemberList)

function refreshPlayerInvite ()
    invited,gangName,inviter = isPlayerGangInvited(source)
    if invited then
        if not getElementData(source,"gang") == "None" then return end
        local gangmember = #getGangMembers(gangName)
        local gangvip = getGangSlots (gangName)
        triggerClientEvent(source,"updatePlayerInvites",source,gangName,getPlayerName(inviter),gangmember,gangvip)
    end
end
addEvent("refreshPlayerInvite",true)
addEventHandler("refreshPlayerInvite",getRootElement(),refreshPlayerInvite)

function acceptGroupInvite ()
    invited,gangName,inviter = isPlayerGangInvited(source)
    if invited then
        if #getGangMembers(getElementData(inviter,"gang"))+1 > getGangSlots(getElementData(inviter,"gang")) then outputChatBox(getPlayerName(source)..", Este grupo está lotado!",source,255,255,0,true) return end
        addGangMember(gangName,getAccountName(getPlayerAccount(source)),"Leader")
        outputChatBox(getPlayerName(source).." entrou no grupo ["..gangName.."]!",getRootElement(),255,255,0,true)
	else
        outputChatBox(getPlayerName(source)..", você nao tem nenhum convite!",source,255,255,0,true)
	end
end
addEvent("acceptGroupInvite",true)
addEventHandler("acceptGroupInvite",getRootElement(),acceptGroupInvite)

addEvent("getSelectedPlayerFromAccount", true)
addEventHandler("getSelectedPlayerFromAccount", root,function(player)
selected_player = getPlayerFromAccountName(player)
--ppp= getAccountPlayer(getAccount(playerName))
if not selected_player then return triggerClientEvent('setStatus',source)end
status = getElementData(selected_player,'isDead')
in_vehicle = isPedInVehicle(selected_player)
level = getElementData(selected_player,'level')
nome = getPlayerName(selected_player)
if status == false then isDead = 'Vivo' else isDead = 'Morto' end
if in_vehicle == true then in_veh = 'Em Veiculo' else in_veh = 'A pé' end
triggerClientEvent('setStatus',source,nome,isDead,in_veh,level)
end)

function getPlayerFromAccountName(name) 
    local acc = getAccount (name)
    if name and acc and not isGuestAccount (acc) then
        return getAccountPlayer (acc)
    else
        return false
    end
end

function destroyGroup ()
    local groupleader = getGangLeader(getElementData(source,"gang"))
    if getAccountName(getPlayerAccount(source)) == groupleader then
        outputChatBox(getPlayerName(source).." fechou o grupo ["..getElementData(source,"gang").."]!",getRootElement(),255,255,0,true)
        for i,gangmember in pairs(getGangMembers(getElementData(source,"gang"))) do
            removeGangMember(getAccountGang(getAccount(gangmember["member_account"])),gangmember["member_account"])
        end
        removeGang(getAccountGang(getAccountName(getPlayerAccount(source))))
    else
        outputChatBox(getPlayerName(source)..", penas o líder pode fechar o grupo!",source,255,255,0,true)
    end
end
addEvent("destroyGroup",true)
addEventHandler("destroyGroup",getRootElement(),destroyGroup)

function leaveGroup ()
    if getElementData(source,"gang") == "None" then return end
    local groupleader = getGangLeader(getElementData(source,"gang"))
    if getAccountName(getPlayerAccount(source)) == groupleader then outputChatBox(getPlayerName(source)..", você não pode deixar seu próprio grupo!",source,255,255,0,true) return end
    outputChatBox(getPlayerName(source).." saiu do grupo: "..getElementData(source,"gang").."!" ,getRootElement(),255,255,0,true)
    removeGangMember(getAccountGang(getAccountName(getPlayerAccount(source))),getAccountName(getPlayerAccount(source)))
end
addEvent("leaveGroup",true)
addEventHandler("leaveGroup",getRootElement(),leaveGroup)

function kickGroupMember (playerName)
    if getElementData(source,"gang") == "None" then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
    if playerName == groupleader then outputChatBox("O líder do grupo não pode ser expulso.",source,255,255,0,true) return end

    if getAccountName(getPlayerAccount(source)) == groupleader or isGangSubLeader(getElementData(source,"gang"),getAccountName(getPlayerAccount(source))) then
        outputChatBox(playerName.."  foi expulso do grupo ["..getElementData(source,"gang").."]!",getRootElement(),255,255,0,true)
        removeGangMember(getElementData(source,"gang"),playerName,getPlayerName(source))
    else
        outputChatBox(getPlayerName(source)..", você não tem permissão para expulsar jogadores!",source,255,255,0,true)
    end
end
addEvent("kickGroupMember",true)
addEventHandler("kickGroupMember",getRootElement(),kickGroupMember)

function addGroupSubLeader (playerName)
    if getElementData(source,"gang") == "None" then return end
    local groupleader = getGangLeader(getElementData(source,"gang"))
	if playerName == groupleader then outputChatBox("O líder do grupo não pode ser adicionado como Auxiliar.",source,255,255,0,true) return end

    if getAccountName(getPlayerAccount(source)) == groupleader then
        if not getAccountPlayer(getAccount(playerName)) then outputChatBox(playerName.." precisa estar online!",source,255,255,0,true) return end
        triggerEvent ( "gangSystem:addSubLeader", source, getPlayerName(getAccountPlayer(getAccount(playerName))))
        outputChatBox(playerName.." agora é auxiliar!",source,255,255,0,true)
        outputChatBox("Você agora é auxiliar do groupo ["..getElementData(getAccountPlayer(getAccount(playerName)),'gang')..']!',getAccountPlayer(getAccount(playerName)),255,255,0,true) 
	else
        outputChatBox(getPlayerName(source)..", você não tem permissão para adicionar jogadores como auxiliares!",source,255,255,0,true)
    end
end
addEvent("addGroupSubLeader",true)
addEventHandler("addGroupSubLeader",getRootElement(),addGroupSubLeader)

function removeGroupSubLeader (playerName)
    if getElementData(source,"gang") == "None" then return end
    local groupleader = getGangLeader(getElementData(source,"gang"))
	if playerName == groupleader then outputChatBox("O líder do grupo não pode ser adicionado como Auxiliar.",source,255,255,0,true) return end
    if getAccountName(getPlayerAccount(source)) == groupleader then
        if not getAccountPlayer(getAccount(playerName)) then outputChatBox(playerName..",  precisa estar online!",source,255,255,0,true) return end
            triggerEvent ( "gangSystem:removeSubLeader", source, getPlayerName(getAccountPlayer(getAccount(playerName))))
        if isGangSubLeader(getElementData(source,"gang"),playerName) then
            outputChatBox("Você removeu o auxiliar de "..playerName..'!',source,255,255,0,true)
            outputChatBox(playerName..", Você não é mais auxiliar do grupo ["..getElementData(player,'gang')..']!',player,255,255,0,true)
        else
            outputChatBox(playerName.." não é auxiliar!",source,255,255,0,true)			
        end    
    else
        outputChatBox(getPlayerName(source)..", você não tem permissão para remover jogadores como auxiliares!",source,255,255,0,true)
    end
end
addEvent("removeGroupSubLeader",true)
addEventHandler("removeGroupSubLeader",getRootElement(),removeGroupSubLeader)

function invitePlayerToGroup (playerName)
    if getElementData(source,"gang") == "None" then return end
	if not playerName or playerName == '' then outputChatBox('Selecione algum jogador!',source,255,255,0) return end
    local groupleader = getGangLeader(getElementData(source,"gang"))
    if getAccountName(getPlayerAccount(source)) == groupleader then
        if #getGangMembers(getElementData(source,"gang"))+1 < getGangSlots(getElementData(source,"gang")) then
        if not getPlayerFromName(playerName) == false then
            if getElementData(getPlayerFromName(playerName),"gang") == "None" then
                triggerEvent ( "gangSystem:invitePlayer", source, playerName )
            else
                outputChatBox(playerName.." já está em algum grupo!",source,255,255,0,true)
            end    
        else
            outputChatBox(playerName.." não está online!",source,255,255,0,true)
        end
        else
            outputChatBox(getPlayerName(source)..", seu groupo está cheio!",source,255,255,0,true)
        end
    else
        outputChatBox(getPlayerName(source)..", você precisa ser o líder do grupo!",source,255,255,0,true)
    end
end
addEvent("invitePlayerToGroup",true)
addEventHandler("invitePlayerToGroup",getRootElement(),invitePlayerToGroup)

function isGangExisting (gangname)
    for i,group in pairs(getGangList()) do
        if group["gang_name"] == gangname then 
            return true
        end
    end
    return false
end

addEvent('createGroup',true)
function createGroupForPlayer (playersource,teamName)
    if not isGuestAccount(getPlayerAccount(playersource)) and getElementData(playersource,"gang") == "None" then
        if teamName then
            if not isGangExisting (teamName) then
            addGang (teamName,getAccountName(getPlayerAccount(playersource)))
            setAccountData(getPlayerAccount(playersource),"gangslots",12)
            outputChatBox ("Você criou o grupo: ["..teamName.."] com sucesso!",playersource,255, 255, 0,true)    
            else
                outputChatBox ("Já existe um grupo com este nome!",playersource,255, 0, 0,true)    
            end
        else
            outputChatBox ("Nome inválido!",playersource,255, 0, 0,true)    
        end
    else
        outputChatBox ("Você já está em um grupo!",playersource,255, 0, 0,true)        
    end
end
addEventHandler('createGroup',root,createGroupForPlayer)

function setGroupVIP (playersource,command,targetString,moreSlots)
    if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
	  if not moreSlots then outputChatBox('syntax: /givevip [Conta] [QuantidadeADD]',playersource,255,0,0) return end
        if getAccount(targetString) then
            local oldData = getAccountData(getAccount(targetString),"gangslots") or 0
            setAccountData(getAccount(targetString),"gangslots",oldData+moreSlots)
            outputChatBox('O grupo de '..targetString.." agora é VIP - Nova quantidade de slots: "..getAccountData(getAccount(targetString),"gangslots").."!",getRootElement(),255,255,0,true)
        end
    else
        outputChatBox ("Você não é admin!",playersource,27, 89, 224,true)        
    end
end
addCommandHandler("givevip",setGroupVIP)

function uNsetGroupVIP (playersource,command,targetString)
    if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
	  if not targetString then outputChatBox('syntax: /takevip [Conta]',playersource,255,0,0) return end
        if getAccount(targetString) then
            local oldData = getAccountData(getAccount(targetString),"gangslots") or 0
            setAccountData(getAccount(targetString),"gangslots",12)
            outputChatBox('O grupo de '..targetString.." não é mais VIP - Nova quantidade de slots: "..getAccountData(getAccount(targetString),"gangslots").."!",getRootElement(),255,255,0,true)
        end
    else
        outputChatBox ("Você não é admin!",playersource,27, 89, 224,true)        
    end
end
addCommandHandler("takevip",uNsetGroupVIP)
