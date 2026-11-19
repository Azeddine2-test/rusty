function subString(str,chunkSize)
	if not str or type(str) ~= "string" or not chunkSize or type(chunkSize) ~= "number" then return false end
	local returnTable = {}
	while #str >= chunkSize do
		table.insert(returnTable,str:sub(1,chunkSize))
		str = str:sub(chunkSize+1)
		if #str < chunkSize then
			table.insert(returnTable,str)
		end
	end
	return returnTable
end

function getTextColorAtEnd(text)
	local text = text:reverse()
	if text:find("%x%x%x%x%x%x#") then
		local sp, ep = text:find("%x%x%x%x%x%x#")
		return text:sub(sp, ep):reverse() or false
	end
end

function adminSay(pla, cmd, ...)
	local message = {...}
	local messageText = table.concat(message, " ")
	while messageText:find("#%x%x%x%x%x%x") do
		messageText = messageText:gsub("#%x%x%x%x%x%x", "")
	end
	local message2 = subString(messageText,1)
	for k, v in ipairs(message2) do
		if v == "~" then
			local messageText = table.concat(message2, "")
			local color = getTextColorAtEnd(messageText)
			if color and color == "#ffffff" then
				message2[k] = "#ffffff"
			else
				message2[k] = "#ffffff"
			end
		end
	end
	local messageText = table.concat(message2, "")
	if messageText and #messageText > 0 then else return end
	local name = getPlayerName(pla)
	repeat name = name:gsub("#%x%x%x%x%x%x", "")
	until not name:find("#%x%x%x%x%x%x")
end

function outputAdminString(source,command,...)
	local message = {...}
	local messageText = table.concat(message, " ")
	while messageText:find("#%x%x%x%x%x%x") do
		messageText = messageText:gsub("#%x%x%x%x%x%x", "")
	end
	
player = getElementsByType('player')
	for i, players in ipairs(player) do 
		triggerClientEvent (players, "onRollMessageStart", players,'ADMIN: '..messageText,255,0,0)
	end
end
addCommandHandler('anunciar',outputAdminString)



ignorar = {
'FPS',
'inRadiation',
'can_go_cama',
'cloth0',
'cloth1',
'cloth3',
'cloth15',
'cloth16',
'Colete_used',
'Colete_used',
'Capacete_used',
'Capacete_used',
'cama',
'camaX',
'camaY',
'camaZ',
'cargo',
'gang',
'accountName',
'volume_som_geral',
'HUD_PESSOAL_Render',
'HUD_ARMAS_Render',
'HUD_VEH_Render',
'currentweapon_1',
'currentweapon_2',
'currentweapon_3',
'bleeding',
'brokenbone',
'brokenbone',
'pain',
'cold',
'temperature',
'humanity',
'tempo_respawn',
'expiracao_VIP',
'slots_extra_VIP',
'fornecedor_VIP',
}

aparecer = {
{'Colete_vida',' Colete_Life'},
{'experiencia',' Experiência'},
{'experiencia_need',' Experiência necessária'},
{'level',' Level'},
{'alivetime',' Tempo vivo'},
{'MAX_Slots',' Slot Máximo'},
{'blood',' Vida'},
{'food',' Alimentação'},
{'thirst',' Hidratação'},
{'Madeira',' Madeira'},
{'Ferro',' Ferro'},
{'Maçã',' Maçã'},
{'GPS',' GPS'},
{'quant_craft_max',' Maximo de itens de base'},
{'quant_craft',' Item de base'},
}

getTranslate = function (dataName)
	for i, data in ipairs(aparecer) do
		if dataName == data[1] then 
			return data[2]
		end 
	end
end

function outputChange(dataName, oldValue)
	if (getElementType(source) == "player") then 
	for i, data in ipairs(ignorar) do if dataName == data then return end end
		local newValue = tonumber(getElementData(source, dataName)) 
		local oldValue = tonumber(oldValue) 
		if newValue == nil or oldValue == nil then return end
		if tonumber(newValue) > tonumber(oldValue) then
			if getTranslate(dataName) then 
			triggerClientEvent (source, "startRollText", source,'[+'..math.floor(newValue-oldValue)..'] '..getTranslate(dataName),200,200,22)
			else
			triggerClientEvent (source, "startRollText", source,'[+'..math.floor(newValue-oldValue)..'] '..dataName,200,200,22)
			end
		else
			if getTranslate(dataName) then 
			triggerClientEvent (source, "startRollText", source,'['..math.floor(newValue-oldValue)..'] '..getTranslate(dataName),255,0,0)
			else
			triggerClientEvent (source, "startRollText", source,'['..math.floor(newValue-oldValue)..'] '..dataName,255,0,0)
			end
		end
	end
end
addEventHandler("onElementDataChange", root, outputChange)