function tryToLoginPlayer (username, password)
	local account = getAccount(username, password)
	if not account then
		triggerClientEvent("Change_Label_Login",source,"Ce compte n’existe pas.")
		return
	elseif account then
		local accountName = getAccountName(account)
		logIn(source, account, password)
		setClothesOnSpawn()
		triggerClientEvent(source,"Terminou_de_Logar", source, accountName, password) 	
		triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)  
		triggerClientEvent(source,"stop_music_login", source) 	
		triggerClientEvent(source,"delete_ped", source) 	
		triggerClientEvent(source,"fechar_cloth", source) 	
	end
end
addEvent("sendLoginToServer", true)
addEventHandler("sendLoginToServer", root, tryToLoginPlayer)

function kick_player (player)
		kickPlayer ( player, 'Button Quit StoneAge', 'Até breve!' )
end
addEvent("kick_player", true)
addEventHandler("kick_player", root, kick_player)

function fazer_login (username, password)
	local account = getAccount(username, password)
	if not account then
		triggerClientEvent("Change_Label_Login",source,"Nom d’utilisateur ou mot de passe incorrect.")
	else
		local accountName = getAccountName(account)
		logIn(source, account, password)
		triggerClientEvent("change_labels",source,"login")
		triggerClientEvent("logou",source)
		acc = getPlayerAccount(source)
		local cloth0 = getAccountData(acc,"cloth0")
		local cloth1 = getAccountData(acc,"cloth1")
		local cloth2 = getAccountData(acc,"cloth2")
		local cloth3 = getAccountData(acc,"cloth3") or 7
		local cloth15 = getAccountData(acc,"cloth15")
		local cloth16 = getAccountData(acc,"cloth16")
		setElementData(source,"cloth0",cloth0)
		setElementData(source,"cloth1",cloth1)
		setElementData(source,"cloth2",cloth2)
		setElementData(source,"cloth3",cloth3)
		setElementData(source,"cloth15",cloth15)
		setElementData(source,"cloth16",cloth16)
		triggerClientEvent("updatePedClothes",source)
	end
end
addEvent("fazer_login", true)
addEventHandler("fazer_login", root, fazer_login)

function fazer_registro (username, password)
	if not getAccount(username) then
		local theAccount = addAccount(username,password)
		acc = getPlayerAccount(source)
		logIn(source, theAccount, password)
		outputChatBox("Votre compte « "..username.." » a été créé avec succès.",source,80,200,120)
		triggerClientEvent("change_labels",source,"registro")
		triggerClientEvent("logou",source)
		setElementData ( source, "cloth0",0)
		setElementData ( source, "cloth1",0)
		setElementData ( source, "cloth2",0)
		setElementData ( source, "cloth3",7)
		setElementData ( source, "cloth15",-1)
		setElementData ( source, "cloth16",-1)
		triggerClientEvent("updatePedClothes",source)
	else
	outputChatBox("Ce compte existe déjà.",source,255,0,0)
	end
end
addEvent("fazer_registro", true)
addEventHandler("fazer_registro", root, fazer_registro)

function tryToRegisterPlayer(username, pass)
		local account = getAccount(username,password)
		setClothesOnSpawn()
		triggerEvent("onPlayerDayZRegister", getRootElement(),username,pass,source)
		triggerClientEvent(source,"delete_ped", source) 
		triggerClientEvent(source,"stop_music_login", source) 		
		triggerClientEvent(source,"Terminou_de_Registrar", source, accountName, password) 
		triggerClientEvent(source,"fechar_cloth", source) 	
		return true
end
addEvent("sendRegisterToServer", true)
addEventHandler("sendRegisterToServer", root, tryToRegisterPlayer)

function setPedClothes(thePed,clothingSlot,clothingID)
  if not isElement(thePed) then
	error("Invalid arguments to setPedClothes()!",2)
  end
  if type(clothingSlot) ~= "number" then
		error("type(clothingSlot) ~= number")
  end
  if not clothingID or clothingID == -1 then
	return removePedClothes(thePed,clothingSlot)
  end
  local hasClothes = getPedClothes(thePed,clothingSlot)
  if hasClothes then
	removePedClothes(thePed,clothingSlot)
  end
  local texture,model = getClothesByTypeIndex(clothingSlot,clothingID)
  return addPedClothes(thePed,texture,model,clothingSlot)
end

function setClothesOnSpawn()
	setPedClothes(source,0,getElementData(source,"cloth0"))
	setPedClothes(source,1,getElementData(source,"cloth1"))
	setPedClothes(source,2,getElementData(source,"cloth2"))
	setPedClothes(source,3,getElementData(source,"cloth3"))
	setPedClothes(source,15,getElementData(source,"cloth15"))
	setPedClothes(source,16,getElementData(source,"cloth16"))
end







