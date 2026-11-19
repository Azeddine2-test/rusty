invitations = {}

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

addEventHandler("onPlayerLogin", root, function(_, account)
    local gang = getAccountGang(getAccountName(account))
    setElementData(source, "gang", gang)
end)

function showGangPanel(thePlayer)
    local gangName = getElementData(thePlayer, "gang")
    if gangName ~= "None" then
        local memberList = getGangMembers(gangName)
        triggerClientEvent(thePlayer, "gangSystem:openGangPanel", thePlayer, memberList)
    end
end

addCommandHandler(get("gang_list_command"), function(thePlayer)
    local gangList = getGangList()
        if gangList and #gangList > 0 then
        triggerClientEvent(thePlayer, "gangSystem:openGangList", thePlayer, gangList)
    end
end)

addEvent("gangSystem:invitePlayer", true)
addEventHandler("gangSystem:invitePlayer", root, function(playerName)
    local gangName = getElementData(source, "gang")
    local accountName = getAccountName(getPlayerAccount(source))
    local player = getPlayerFromNamePart(playerName)
    if getGangLeader(gangName) == accountName or isGangSubLeader(gangName, accountName) then
        if player and isElement(player) then
            local playerAccountName = getAccountName(getPlayerAccount(player))
            if getAccountGang(gangName, playerAccountName) == "None" then
                invitations[player] = {gangName, source}
                outputChatBox("Você convidou " .. getPlayerName(player) .. " para o grupo.", source, 0, 255, 0)
                outputChatBox("Você foi convidado para entrar no grupo " ..gangName.. ", aperte F1 para aceitar.", player, 0, 255, 0)
            else
                outputChatBox("Este jogador já tem um grupo!", source, 255, 0, 0)
            end
        else
            outputChatBox("o jogador "..playerName.." não foi encontrado", source, 255, 0, 0)
        end
    else
        outputChatBox("Você não tem permissão para usar essa função.", source, 255, 0, 0)
    end
end)


addEvent("gangSystem:kickMember", true)
addEventHandler("gangSystem:kickMember", root, function(memberAccount)
    local gangName = getElementData(source, "gang")
    local accountName = getAccountName(getPlayerAccount(source))
    if gangName ~= "None" then
        if getGangLeader(gangName) == accountName or isGangSubLeader(gangName, accountName) then
            if getGangLeader(gangName) ~= memberAccount then
                if removeGangMember(gangName, memberAccount, getPlayerName(source)) then
                    outputChatBox("Você foi expulso do grupo  por " .. memberAccount .. "!", source, 255, 50, 0)
                end
            else
                outputChatBox("Você não pode expulsar o dono do grupo!", source, 255, 0, 0)
            end
        else
            outputChatBox("Você não tem permissão para usar essa função.", source, 255, 0, 0)
        end
    end
end)




addCommandHandler("accept", function(thePlayer)
    local invited, theGang, inviter = isPlayerGangInvited(thePlayer)
    if invited then
        addGangMember(theGang, getAccountName(getPlayerAccount(thePlayer)), getAccountName(getPlayerAccount(inviter)))
        outputChatBox("Bem vindo ao grupo " .. tostring(theGang) .. "!", thePlayer, 0, 255, 0)
        for index, player in pairs(getPlayersByGang(theGang)) do
            outputChatBox("" .. getPlayerName(thePlayer) .. " entrou no grupo!", player, 0, 255, 0)
        end
        invitations[thePlayer] = false
    end
end)

addEvent("onPlayerJoinGang", true)
addEventHandler("onPlayerJoinGang", root, function(gangName)
    if doesGangExists(gangName) then
        executeSQLUpdate("gangs", "gang_members = '" .. #getGangMembers(gangName) + 1 .. "'", "gang_name = '" .. tostring(gangName) .. "'")
    end
end)

addEvent("onPlayerLeaveGang", true)
addEventHandler("onPlayerLeaveGang", root, function(gangName)
    if doesGangExists(gangName) then
        executeSQLUpdate("gangs", "gang_members = '" .. #getGangMembers(gangName) - 1 .. "'", "gang_name = '" .. tostring(gangName) .. "'")
    end
end)

addEvent("gangSystem:getSubLeaders", true)
addEventHandler("gangSystem:getSubLeaders", root, function()
    local gangName = getElementData(source, "gang")
    if gangName and gangName ~= "None" then
        local subLeaders = getGangSubLeaders(gangName)
        triggerClientEvent(source, "gangSystem:returnSubLeaders", source, subLeaders)
    end
end)

addEvent("gangSystem:addSubLeader", true)
addEventHandler("gangSystem:addSubLeader", root, function(memberAccount)
    local gangName = getElementData(source, "gang")
    local accountName = getAccountName(getPlayerAccount(source))
    if gangName ~= "None" and accountName ~= "Guest" then
        if getGangLeader(gangName) == accountName then
            local isSubLeader, errorMsg = isGangSubLeader(gangName, memberAccount)
            if not isSubLeader then
                if editGangSubLeaders(gangName, memberAccount, true) then
                    outputChatBox("Você adicionou " .. memberAccount .. " à função de alxiliar", source, 255, 255, 0)
                else
                    outputChatBox("Erro: " .. tostring(errorMsg), source, 255, 0, 0)
                end
            else
                outputChatBox("Este membro já é auxiliar", source, 255, 0, 0)
            end
        else
            outputChatBox("Você não tem permissão para usar essa função", source, 255, 0, 0)
        end
    end
end)

addEvent("gangSystem:removeSubLeader", true)
addEventHandler("gangSystem:removeSubLeader", root, function(memberAccount)
  local gangName = getElementData(source, "gang")
  local accountName = getAccountName(getPlayerAccount(source))
  if gangName ~= "None" and accountName ~= "Guest" then
    if getGangLeader(gangName) == accountName then
      local isSubLeader, errorMsg = isGangSubLeader(gangName, memberAccount)
      if isSubLeader then
        if editGangSubLeaders(gangName, memberAccount, false) then
          outputChatBox("Você removeu " .. memberAccount .. " da função auxiliar", source, 255, 50, 0)
        end
      else
        outputChatBox("Erro:: " .. tostring(errorMsg), source, 255, 50, 0)
      end
    else
      outputChatBox("Erro: " .. tostring(errorMsg), source, 255, 50, 0)
    end
  else
    outputChatBox("Você não tem permissão para usar essa função.", source, 255, 0, 0)
  end
end)

