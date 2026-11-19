addEvent("kickar_jogador", true)
function kikar(player,kicker)
outputDebugString(getPlayerName(kicker)..' expulsou '..getPlayerName(player)..' pelo painel admin!')
kickPlayer (player,kicker)

end
addEventHandler("kickar_jogador", getRootElement(), kikar)

addEvent("matar_jogador", true)
function matar(player,responsavel)
setElementData(player,'blood',-1)
outputChatBox('Você matou '..getPlayerName(player)..' pelo painel admin!',responsavel,255,255,0)
outputDebugString(getPlayerName(player)..' foi morto por '..getPlayerName(responsavel)..' pelo painel admin!')
end
addEventHandler("matar_jogador", getRootElement(), matar)

addEvent("take_jetpack", true)
function take_jetpack(player)
jetpack = doesPedHaveJetPack(player)
if not jetpack then
outputChatBox('Você pegou um jetpack',player,255,255,0)
givePedJetPack(player)
else
removePedJetPack(player)
outputChatBox('Você tirou seu jetpack',player,255,255,0)
end
end
addEventHandler("take_jetpack", getRootElement(), take_jetpack)

addEvent("tp_nele", true)
function tp_nele(player,teleportador)
veiculo = getPedOccupiedVehicle(player)
if veiculo then warpPedIntoVehicle(teleportador,veiculo,1) return end
x,y,z = getElementPosition(player)
setElementPosition(teleportador,x+math.random(0.5,1),y+math.random(0.5,1),z+3)
outputDebugString(getPlayerName(teleportador)..' se teletransportou até '..getPlayerName(player)..'!')
outputChatBox('Você se teletransportou até '..getPlayerName(player)..' pelo painel admin!',responsavel,255,255,0)

end
addEventHandler("tp_nele", getRootElement(), tp_nele)

addEvent("tp_em_mim", true)
function tp_em_mim(player,teleportador)
veiculo = getPedOccupiedVehicle(teleportador)
if veiculo then warpPedIntoVehicle(teleportador,veiculo,1) return end
x,y,z = getElementPosition(teleportador)
setElementPosition(player,x+math.random(0.5,1),y+math.random(0.5,1),z+3)
outputDebugString(getPlayerName(teleportador)..' teletransportou '..getPlayerName(player)..' até ele!')
outputChatBox('Você teletransportou '..getPlayerName(player)..' até você pelo painel admin!',responsavel,255,255,0)

end
addEventHandler("tp_em_mim", getRootElement(), tp_em_mim)

addEvent("destruir_veiculo", true)
function destruir_veiculo(player,responsavel)
veiculo = getPedOccupiedVehicle(player)
parent = getElementData(veiculo,'parent')
destroyElement(parent)
destroyElement(veiculo)
outputDebugString(getPlayerName(responsavel)..' destruiu o veiculo de '..getPlayerName(player)..'!')
outputChatBox('Você destruiu o veiculo de '..getPlayerName(player)..' pelo painel admin!',responsavel,255,255,0)

end
addEventHandler("destruir_veiculo", getRootElement(), destruir_veiculo)

addEvent("tapinha", true)
function tapinha(player,responsavel)
x,y,z = getElementPosition(player)
setElementPosition(player,x+math.random(0.5,1),y+math.random(0.5,1),z+3)
outputDebugString(getPlayerName(responsavel)..' deu um tapinha em '..getPlayerName(player)..'!')
outputChatBox('Você deu um tapinha em '..getPlayerName(player)..' pelo painel admin!',responsavel,255,255,0)

end
addEventHandler("tapinha", getRootElement(), tapinha)

addEvent("veiculo_pra_mim", true)
function veiculo_pra_mim(player,veiculo,responsavel)
if getPedOccupiedVehicle(player) then outputChatBox('Você já está em um veiculo!',player,255,0,0) return end
x,y,z = getElementPosition(player)
        veh = createVehicle(getVehicleIDfromVehicleName(veiculo),x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements (vehCol,veh,0,0,0)
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",0)
        setElementData(vehCol,"vehicle_ID",getVehicleIDfromVehicleName(veiculo))
        --Engine + Tires
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",tires)
        setElementData(vehCol,"Engine_inVehicle",engine)
        setElementData(vehCol,"Parts_inVehicle",parts)
        setElementData(vehCol,"fuel",getVehicleMaxFuel(vehCol))
		setElementData(vehCol,"spawn",{false,false,false,false})
		warpPedIntoVehicle ( player, veh,0 ) 
		outputDebugString(getPlayerName(player)..' spawnou um(a) '..veiculo..' pra ele!')
		
outputChatBox('Você spawnou um  '..veiculo..' pelo painel admin!',responsavel,255,255,0)

end
addEventHandler("veiculo_pra_mim", getRootElement(), veiculo_pra_mim)

addEvent("veiculo_pra_ele", true)
function veiculo_pra_ele(player,veiculo,responsavel)
if getPedOccupiedVehicle(player) then outputChatBox('Você já está em um veiculo!',player,255,0,0) return end
x,y,z = getElementPosition(player)
        veh = createVehicle(getVehicleIDfromVehicleName(veiculo),x,y,z)
        vehCol = createColSphere(x,y,z,2)
        attachElements (vehCol,veh,0,0,0)
        setElementData(vehCol,"parent",veh)
        setElementData(veh,"parent",vehCol)
        setElementData(vehCol,"vehicle",true)
        setElementData(vehCol,"MAX_Slots",0)
        setElementData(vehCol,"vehicle_ID",getVehicleIDfromVehicleName(veiculo))
        --Engine + Tires
        local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
        setElementData(vehCol,"Tire_inVehicle",tires)
        setElementData(vehCol,"Engine_inVehicle",engine)
        setElementData(vehCol,"Parts_inVehicle",parts)
        setElementData(vehCol,"fuel",getVehicleMaxFuel(vehCol))
		warpPedIntoVehicle ( player, veh,0) 
		setElementData(vehCol,"spawn",{false,false,false,false})
outputChatBox('Você spawnou um(a) '..veiculo..' para '..getPlayerName(player)..' pelo painel admin!',responsavel,255,255,0)
		
	    outputDebugString(getPlayerName(player)..' recebeu um(a) '..veiculo..' de '..getPlayerName(responsavel)..'!')	
end
addEventHandler("veiculo_pra_ele", getRootElement(), veiculo_pra_ele)



vehiclesTable = {
--{'nome', id, tire,engine,tank, maxfuel,fuelspeed} 
{'Picape', 422, 4,1,1, 80,0.15},
{'Alpha', 602, 4,1,1, 65,0.15},
{'Ninja', 522, 2,1,1, 35,0.1},
{'Combi', 483, 4,1,1, 85,0.1},
{'Ambulancia', 416, 4,1,1, 75,0.1},
{'Bike', 481, 0,0,0, 0,0},
{'Family', 400, 4,1,1, 70,0.15},
{'Lamborghini', 411, 4,1,1, 70,0.15},
{'Harley', 463, 2,1,1, 50,0.15},
{'Caminhao', 433, 6,1,1, 100,0.15},
{'Policia', 461, 2,1,1, 50,0.15},
}


function getVehicleIDfromVehicleName(name)
	for i, data in ipairs(vehiclesTable) do
		if name == data[1] then
			return data[2]
		end
	end
end

function getVehicleMaxFuel(loot)
    local modelID = getElementModel(getElementData(loot,"parent"))
    for i,data in ipairs(vehiclesTable) do
        if modelID == data[2] then
             return data[6]
        end
    end
    return false
end

function getVehicleAddonInfos (id)
    for i,data in ipairs(vehiclesTable) do
        if data[2] == id then
            return data[3],data[4], data[5]
        end
    end
end


for id, player in ipairs(getElementsByType("player")) do
bindKey(player,'u','down',function()
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
		triggerClientEvent(player, "request_paniel_admin", player)
	end
end)
end


function openGUI(player)
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
		triggerClientEvent(player, "request_paniel_admin", player)
	end
end

function bindTheKeys ()
  bindKey(source,"u","down",openGUI)
end
addEventHandler("onPlayerLogin", getRootElement(), bindTheKeys)




addCommandHandler('x',function (source)
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
		currentCol = getElementData(source,'currentCol')
		x,y,z = getElementPosition(currentCol)
		--outputChatBox(x..','..y..','..z)
		objeto = getElementData(currentCol,'parent')
		outputChatBox(getElementData(objeto,'creator'),source)
		outputChatBox(getElementData(currentCol,'creator'),source)
	end
end)


addCommandHandler("set",function(arg1,arg2,arg3,arg4)
if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(arg1)), aclGetGroup("Admin")) then
	if not arg2 or not arg3 then
	outputChatBox("index: /set arg1 arg2",arg1)
	return
	end
	setElementData(arg1,arg3,tonumber(arg4))
	outputChatBox('Recebido: '..arg3..' ['..arg4..']',arg1,255,255,0)
end
end)





addCommandHandler('sniper',function(source)
setElementData(source,'Sniper',1)
setElementData(source,'.300 Magnum',100)
end)





addCommandHandler("get",function(arg1,arg2,arg3)
if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(arg1)), aclGetGroup("Admin")) then
	if not arg2 then
	outputChatBox("index: /get arg2",arg1)
	return
	end
	s = tostring(getElementData(arg1,arg3))
	outputChatBox(arg3..': '..s,arg1,255,255,0)
end
end)

addCommandHandler("pos",function(source)
	if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
	local x, y, z = getElementPosition(source)
	rx,ry,rz = getElementRotation(source)
	outputChatBox('{'..x..","..y..","..z..'},',source)
setClipboard(x..","..y..","..z)
end
end)


local count = 0
local db
function onStart()
	if not fileExists("database_vips.db") then
		h = fileCreate("database_vips.db")
		if h then
		fileClose(h)
		outputDebugString("[VIP] Database das contas vips nao encontrada, criando...")
		end
		db = dbConnect( "sqlite", "database_vips.db" )
		outputDebugString("[VIP] Inserindo tabelas na database...")
dbExec(db,"CREATE TABLE IF NOT EXISTS contas_vip(conta VARCHAR, expiracao VARCHAR, ativacao VARCHAR, slots VARCHAR, dado_por VARCHAR)")
		outputDebugString("[VIP] Tabelas inseridas.")
	else
		db = dbConnect( "sqlite", "database_vips.db" )
		local qh = dbQuery( db, "SELECT * FROM contas_vip" )
		local result = dbPoll( qh, 10000 )
			for i, ob in ipairs(result) do
				count = count + 1
			end
			outputDebugString("[VIP] Contas VIP carregadas. TOTAL: "..tostring(count))
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)


function getVipAccounts()
		db = dbConnect( "sqlite", "database_vips.db" )
		local qh = dbQuery( db, "SELECT * FROM contas_vip" )
		local result = dbPoll( qh, 10000 )
	triggerClientEvent('refresh_gridlist_vips_C',source,result)	
end
addEvent("getVipAccounts",true)
addEventHandler("getVipAccounts",root,getVipAccounts)



function getTextForAccount(conta)
acc = getAccount(conta)
expiracao = getAccountData(acc,'expiracao_VIP')
ativacao = getAccountData(acc,'ativacao_VIP')
slots_extra = getAccountData(acc,'slots_extra_VIP')
dado_por = getAccountData(acc,'fornecedor_VIP')
if slots_extra then slots = 'SIM' else slots = 'NÃO' end
triggerClientEvent('setText_C',source,expiracao,ativacao,slots,tostring(dado_por))	
end
addEvent("getTextForAccount",true)
addEventHandler("getTextForAccount",root,getTextForAccount)

function add_VIP(player,ativacao,valido_ate,slots_extra,fornecedor)
	if player and isElement(player) then
	conta_player = getAccountName(getPlayerAccount(player))
	acc_player = getPlayerAccount(player)
	conta_fornecedor = getAccountName(getPlayerAccount(fornecedor))
	aclGroupAddObject(aclGetGroup("VIP"), "user."..conta_player) 
	setElementData(player,'VIP',true)
	setElementData(player,'quant_craft_max',40)
	setElementData(player,'expiracao_VIP',valido_ate)
	if slots_extra == true then 
	setElementData(player,'slots_extra_VIP',slots_extra)
	setAccountData(acc_player,'slots_extra_VIP',slots_extra)
	outputChatBox('slots extra true')
	setAccountData(acc_player,'gangslots',20)
	else
	outputChatBox('slots extra false')
	end
	setElementData(player,'fornecedor_VIP',conta_fornecedor)
	setElementData(player,'ativacao_VIP',ativacao)
	outputChatBox(getPlayerName(fornecedor)..' te deu VIP!',player,255,255,0)
	
	setAccountData(acc_player,'VIP',true)
	setAccountData(acc_player,'quant_craft_max',40)
	setAccountData(acc_player,'expiracao_VIP',valido_ate)
	setAccountData(acc_player,'ativacao_VIP',ativacao)
	setAccountData(acc_player,'fornecedor_VIP',conta_fornecedor)	
	
	outputChatBox('Você deu VIP para '..getPlayerName(player)..'  -  ('..conta_player..')',fornecedor,255,255,0)
	outputDebugString(conta_fornecedor..' deu VIP para '..conta_player)
	dbExec(db, "INSERT INTO contas_vip VALUES(?,?,?,?,?)",conta_player, valido_ate, ativacao, slots_extra, conta_fornecedor)
	else
	outputChatBox('Jogador não encontrado!',fornecedor,255,0,0)
	end
end
addEvent("add_VIP",true)
addEventHandler("add_VIP",root,add_VIP)

function remove_VIP(nome,removedor)
	if nome then
	aclGroupRemoveObject(aclGetGroup("VIP"),"user."..nome)
	dbExec(db,"DELETE FROM contas_vip WHERE conta=?",nome)
	acc = getAccount(nome)
	player = getAccountPlayer(acc)
	if player then 
	setElementData(player,'VIP',false)
	setElementData(player,'quant_craft_max',30)
	setElementData(player,'slots_extra_VIP',false)
	outputChatBox(getPlayerName(removedor)..' removeu seu VIP!',player,255,255,0)
	end
	getAccountData(acc,'quant_craft_max',30)
	setAccountData(acc,'VIP',false)
	if getAccountData(acc,'slots_extra_VIP') then 
	setAccountData(acc,'slots_extra_VIP',false)
	setAccountData(acc,'gangslots',12)
	end
	outputDebugString('o VIP de '..nome..' foi removido por '..getAccountName(getPlayerAccount(removedor)))	
	outputChatBox('Você removeu o vip de ('..nome..')',removedor,255,255,0)
	end
end
addEvent("remove_VIP",true)
addEventHandler("remove_VIP",root,remove_VIP)

function save_accounts()
acc = getPlayerAccount(source)
	if getAccountData(acc,'VIP') then
		setElementData(source,'VIP',getAccountData(acc,'VIP'))
		setElementData(source,'ativacao_VIP',getAccountData(acc,'ativacao_VIP'))
		setElementData(source,'slots_extra_VIP',getAccountData(acc,'slots_extra_VIP'))
		setElementData(source,'fornecedor_VIP',getAccountData(acc,'fornecedor_VIP'))
	end
end
addEventHandler ("onPlayerLogin", root, save_accounts)

addCommandHandler('a',function(source)
acc = getPlayerAccount(source)
item = getAccountData(acc,'slots_extra_VIP')
outputChatBox('Slots Extra: '..tostring(item))
end)


function aumentar_periodo(nome,valido_ate,removedor)
	if nome then
	dbExec(db,'UPDATE contas_vip SET expiracao=? WHERE conta=?',nome,valido_ate)
	acc = getAccount(nome)
	player = getAccountPlayer(acc)
	outputChatBox('Você aumentou VIP de '..nome..' até '..valido_ate,removedor,255,255,0)
	if player then 
	setElementData(player,'expiracao_VIP',valido_ate)
	outputChatBox(getPlayerName(removedor)..' aumentou seu VIP até '..valido_ate,player,255,255,0)
	else
	setAccountData(acc,'expiracao_VIP',valido_ate)
	end
	outputDebugString('Vip de '..nome..' foi aumentado por '..getAccountName(getPlayerAccount(removedor))..' até '..valido_ate)
	end
end
addEvent("aumentar_periodo",true)
addEventHandler("aumentar_periodo",root,aumentar_periodo)









