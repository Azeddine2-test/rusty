function add_Gang(nome_do_grupo,lider,slots)
    if not doesGangExists(nome_do_grupo) then
        if executeSQLInsert("gangs", "'" .. tostring(nome_do_grupo) .. "','" .. tostring(lider) .. "','0','[ ]'") then
            outputDebugString("Gang system: Gang created name: " .. tostring(nome_do_grupo) .. ", leader: " .. tostring(lider))
            addGangMember(nome_do_grupo, lider, "System")
            return true
        else
            return false, "An error has occurred."
        end
    else
        return false, "Gang already exists."
    end
end

function getAccountGang(memberAccount)
    local check = executeSQLSelect("gang_members", "*", "member_account = '" .. tostring(memberAccount) .. "'")
    if type(check) == "table" and #check == 0 or not check then
        return "None"
    else
        return tostring(check[1].gang_name)
    end
end

function getGangLeader(gangName)
    if doesGangExists(gangName) then
        local data = executeSQLQuery("SELECT gang_leader FROM gangs WHERE gang_name='" .. tostring(gangName) .. "'")
        return tostring(data[1].gang_leader)
    else
        return false, "The gang doesn't exists."
    end
end

function doesGangExists(nome_do_grupo)
    local check = executeSQLSelect("gangs", "*", "gang_name = '" .. tostring(nome_do_grupo) .. "'")
    if type(check) == "table" and #check == 0 or not check then
        return false
    else
        return true
    end
end

function getGangMembers(gangName)
    if doesGangExists(gangName) then
        local data = executeSQLQuery("SELECT * FROM gang_members WHERE gang_name = '" .. tostring(gangName) .. "'")
        return data
    else
        return false, "The gang doesn't exists."
    end
end

function removeGang(gangName)
    if executeSQLDelete("gangs", "gang_name = '" .. tostring(gangName) .. "'") then
        for index, member in ipairs(executeSQLQuery("SELECT * FROM gang_members WHERE gang_name = '" .. tostring(gangName) .. "'")) do
            removeGangMember(gangName, member.member_account)
			outputChatBox('jogadores removidos!')
        end
			outputChatBox('grupo removido!')
        return true
    else
			outputChatBox('ERRO')
        return false, "An error has occurred."
    end
end

function refreshClientGangList()
    triggerClientEvent(source, "refreshGangListToClient", source, gangtable)
end
addEvent("refreshClientGangList",true)
addEventHandler("refreshClientGangList",getRootElement(),refreshClientGangList)


invitations = {}
function isPlayerGangInvited(thePlayer)
    if invitations[thePlayer] then
        return true, invitations[thePlayer][1], invitations[thePlayer][2]
    else
        return false
    end
end

function acceptGroupInvite ()
    invited,gangName,inviter = isPlayerGangInvited(source)
    if invited then
        if #getGangMembers(getElementData(inviter,"gang"))+1 > getGangSlots(getElementData(inviter,"gang")) then outputChatBox(getPlayerName(source)..", #22ff22This group is full!",source,22,255,22,true) return end
        addGangMember(gangName,getAccountName(getPlayerAccount(source)),getElementData(inviter,"accountName"))
        outputChatBox(getPlayerName(source).." #22ff22 entrou no grupo ["..gangName.."]!",getRootElement(),22,255,22,true)
    end
end
addEvent("acceptGroupInvite",true)
addEventHandler("acceptGroupInvite",getRootElement(),acceptGroupInvite)


function refreshPlayerInvite ()
	--if getElementData(source,'gang') ~= 'None' then return end
    invited,gangName,inviter = isPlayerGangInvited(source)
    if invited  then
        if not getElementData(source,"gang") == "None" then return end
        local gangmember = #getGangMembers(gangName)
        local gangvip = getGangSlots (gangName)
        triggerClientEvent(source,"refresh_invited",source,gangName)
    end
end
addEvent("refreshPlayerInvite",true)
addEventHandler("refreshPlayerInvite",getRootElement(),refreshPlayerInvite)

function addGangMember(gangName, memberAccount, addedBy)
    if not doesGangExists(gangName) then
        return false, "The gang doesn't exists."
    end
    if isGangMember(gangName, memberAccount) then
        return false, "This member already exists."
    end
    if executeSQLInsert("gang_members", "'" .. tostring(gangName) .. "','" .. tostring(memberAccount) .. "','" .. tostring(addedBy) .. "'") then
        local account = getAccount(memberAccount)
        if account and getAccountPlayer(account) then
            setElementData(getAccountPlayer(account), "gang", gangName)
            setTimer(triggerEvent, 200, 1, "onPlayerJoinGang", getAccountPlayer(account), gangName)
        end
        outputDebugString("Gang system: Member added to: " .. tostring(gangName) .. ", account: " .. tostring(memberAccount))
        return true
    else
        return false, "An error has occurred."
    end
end
function getGangSlots (gangname)
    local account = getAccount(getGangLeader(gangname))
    if account then
        return (getAccountData(account,"gangslots") or 0)
    else
        return 12
    end
end
function getGangList()
    local data = executeSQLQuery("SELECT * FROM gangs")
    return data
end
addEvent('getGangList',true)
addEventHandler('getGangList',root,getGangList)

function isGangMember(gangName, memberAccount)
    if doesGangExists(gangName) then
        local check = executeSQLSelect("gang_members", "*", "gang_name = '" .. tostring(gangName) .. "' AND member_account = '" .. tostring(memberAccount) .. "'")
        if type(check) == "table" and #check == 0 or not check then
            return false, "The member doesn't exists."
        else
            return true
        end
    else
        return false, "The gang doesn't exists."
    end
end
function removeGang(gangName)
    if executeSQLDelete("gangs", "gang_name = '" .. tostring(gangName) .. "'") then
        for index, member in ipairs(executeSQLQuery("SELECT * FROM gang_members WHERE gang_name = '" .. tostring(gangName) .. "'")) do
            removeGangMember(gangName, member.member_account)
        end
        return true
    else
        return false, "An error has occurred."
    end
end

function removeGangMember(gangName, memberAccount, kickerName)
    if executeSQLDelete("gang_members", "member_account = '" .. tostring(memberAccount) .. "' AND gang_name = '" .. tostring(gangName) .. "'") then
        local account = getAccount(memberAccount)
        if account and not isGuestAccount(account) then
            local player = getAccountPlayer(account)
            if player then
                if player and kickerName then
                    outputChatBox("Gang system: You have been kicked from " .. tostring(gangName) .. " by " .. tostring(kickerName) .. ".", player, 255, 0, 0)
                end
                setTimer(triggerEvent, 200, 1, "onPlayerLeaveGang", player, gangName)
                setElementData(player, "gang", "None")
            else
                triggerEvent("onPlayerLeaveGang", memberAccount, gangName)
            end
        end
        return true
    else
        return false, "An error has occurred."
    end

end
function isGangExisting (gangname)
    for i,group in pairs(getGangList()) do
        if group["gang_name"] == gangname then 
            return true
        end
    end
    return false
end

function checkPlayerGroupDetails ()
    gangtable = {}
    local gangtablename = getGangList()
    for i,group in pairs(gangtablename) do
        local gangtablemembers = #getGangMembers(group["gang_name"])
        local groupleader = getGangLeader(group["gang_name"])
        local gangvip = getGangSlots (group["gang_name"])
        table.insert(gangtable,{group["gang_name"],groupleader,gangtablemembers,gangvip})    
    end    
    setElementData(getRootElement(),"ganglist",gangtable)
end
setTimer(checkPlayerGroupDetails,500,0)


