function globalMessage(thePlayer, cmd, ...)
    local message = table.concat ( { ... }, " " )
	local name = getPlayerName(thePlayer)
	if isPlayerMuted ( thePlayer ) then
		outputChatBox ("Você está mutado!!", thePlayer, 255, 128, 22, true)
		return
	end
	outputChatBox("#A52A2A"..name..": #FFF5EE"..message, getRootElement(), 255, 255, 255, true)
	outputServerLog("[Global]"..getPlayerName(thePlayer)..": "..message)
end
addCommandHandler("GlobalChat", globalMessage)

function pmsgAdmin(playersource, command, ...)
	local msg = table.concat({...}, " ")
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")) then
		outputChatBox("#FFF5EE[ADMIN] "..getPlayerName(playersource) .. ": " .. msg, getRootElement(), 60, 200, 40, true)
	else
		outputChatBox ("Você não é admin!", playersource, 255, 128, 22, true)
	end
end
addCommandHandler("AdminChat", pmsgAdmin)

function GroupChat(playersource, command, ...)
	local msg = table.concat({...}, " ")
	for i, player in ipairs(getElementsByType('player')) do 
		if getElementData(playersource,'gang') == 'None' then return end
			if getElementData(playersource,'gang') == getElementData(player,'gang') then
			outputChatBox("#A52A2A[Grupo] #FFF5EE"..getPlayerName(playersource) .. ":#A52A2A " .. msg, player, 60, 200, 40, true)
			outputServerLog("[Grupo ("..getElementData(playersource,'gang')..")] "..getPlayerName(playersource)..": "..msg)
		end
	end
end
addCommandHandler("GroupChat", GroupChat)