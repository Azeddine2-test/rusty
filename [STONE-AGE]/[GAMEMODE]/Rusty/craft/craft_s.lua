local db
local count = 0
local DoorsTable = {}

BoxSimple = {
{"tent",true},
{"vehicle",true},
{"password",false},
{"MAX_Slots",75},
}
BoxProtected = {
{"tent",true},
{"vehicle",true},
{"password",0},
{"MAX_Slots",150},
}
Cama = {
{"cama",true},
}

Fornalha = {
{"fornalha",true},
}

Fogueira = {
{"fogueira",true},
}
base_object = {
{"objeto_de_base",true},
}
		
function newObject(model,x,y,z,rx,ry,rz,health,nomeitem,salvavel)
gang = getElementData(source,'gang')
conta = getElementData(source,'accountName')
	if model and x and y and z and rx and ry and rz then
		local ob = createObject(model, x, y, z, rx, ry, rz)
		setElementData(ob, "creator", conta)
		setElementData(ob,"health",health)
		local col = createColSphere(x,y,z,1.25)
		setElementData(ob,"parent",col)
		setElementData(col,"creator",conta)
		setElementData(col,"parent",ob)
		
		
if nomeitem == "Box Simple" then
        attachElements ( col, ob, 0, 0, 1)
		setElementData(col,"attach_pos",1)

for i, data in ipairs(BoxSimple) do setElementData(col,data[1],data[2]) end
elseif nomeitem == "Box Protected" then
        attachElements ( col, ob, 0, 0, 1)
		setElementData(col,"attach_pos",1)

for i, data in ipairs(BoxProtected) do setElementData(col,data[1],data[2]) end	

elseif nomeitem == "Porta de Madeira" or 
nomeitem == "Chao de Madeira" or  
nomeitem == "Porta de Madeira" or  
nomeitem == "Portao de Madeira" or  
nomeitem == "Janela de Madeira" or  
nomeitem == "Escada de Madeira" or  
nomeitem == "Parede de Madeira" or 
nomeitem == "Porta da Parede de Madeira" or 
nomeitem == "Porta do Chão de Madeira" or  
nomeitem == "Chao de Pedra" or  
nomeitem == "Porta do Chão de Pedra" or  
nomeitem == "Porta de Pedra" or  
nomeitem == "Portao de Pedra" or  
nomeitem == "Janela de Pedra" or  
nomeitem == "Escada de Pedra" or  
nomeitem == "Parede de Pedra" or  
nomeitem == "Porta da Parede de Pedra"  or
nomeitem == "Chao de Ferro" or  
nomeitem == "Porta do Chão de Ferro" or  
nomeitem == "Porta de Ferro" or  
nomeitem == "Portao de Ferro" or  
nomeitem == "Janela de Ferro" or  
nomeitem == "Escada de Ferro" or  
nomeitem == "Parede de Ferro" or  
nomeitem == "Porta da Parede de Ferro"  then

if nomeitem == 'Porta de Madeira' or nomeitem == 'Porta de Pedra' or nomeitem == 'Porta de Ferro'  then
        attachElements ( col, ob, 0, 0, 1)
		setElementData(col,"attach_pos",1)
		setElementData(col,"status",'fechada')
elseif nomeitem == 'Portao de Madeira' or nomeitem == 'Portao de Pedra'or nomeitem == 'Portao de Ferro' then
        attachElements ( col, ob, 0, 0, 1)
		setElementData(col,"attach_pos",1)
		setElementData(col,"status",'fechada')
elseif nomeitem == 'Chao de Madeira' or
 nomeitem == 'Chao de Ferro' or
 nomeitem == 'Chao de Pedra' or
 nomeitem == 'Porta do Chão de Madeira' or
 nomeitem == 'Porta do Chão de Ferro' or
 nomeitem == 'Porta do Chão de Pedra' then
		setElementData(col,"attach_pos",0.5)
        attachElements ( col, ob, 0, 0, 0.5)
elseif nomeitem == 'Escada de Madeira' or nomeitem == 'Escada de Pedra'or nomeitem == 'Escada de Ferro' then
		setElementData(col,"attach_pos",0.25)
        attachElements ( col, ob, 0, 0, 0.25)		
else
		setElementData(col,"attach_pos",-0.5)
        attachElements ( col, ob, 0, 0, -0.5)
end
setElementData(col,'health',health)
setElementData(col,'health_b',health_b)
for i, data in ipairs(base_object) do setElementData(col,data[1],data[2]) end	

elseif nomeitem == "Cama" then
        attachElements ( col, ob, 0, 0,1)
		setElementData(col,"attach_pos",1)
		createBlipCama(ob,source)
for i, data in ipairs(Cama) do setElementData(col,data[1],data[2]) end	
		setElementData(source,"cama",true)
		setElementData(source,"camaX",x)
		setElementData(source,"camaY",y)
		setElementData(source,"camaZ",z)
elseif nomeitem == "Barricada" then
        attachElements ( col, ob, 0, 0, 1)
		setElementData(col,"attach_pos",1)
		setElementData(col,"wirefence",true)
		
elseif nomeitem == "Fogueira" then
        attachElements ( col, ob, 0, 0, 0)
		setElementData(col,"attach_pos",0)

for i, data in ipairs(Fogueira) do setElementData(col,data[1],data[2]) end	

elseif nomeitem == "Fornalha" then
        attachElements ( col, ob, 0, 0, 0)
		setElementData(col,"attach_pos",0)

for i, data in ipairs(Fornalha) do setElementData(col,data[1],data[2]) end	

end
		local modelo = getElementModel(ob)
		setElementData(col,"id_objeto",modelo)
		setElementData(col,"senha",'Nenhuma')
		if ob and salvavel == true then
			local x,y,z = getElementPosition(ob)
			local rx,ry,rz = getElementRotation(ob)
			local model = getElementModel(ob)
			local senha = 'Nenhuma'
			local status = 'fechada'
			count = count+1
			setElementData(ob, "bc.ID", count)
			setElementData(source,'quant_craft',getElementData(source,'quant_craft')+1)
	dbExec(db, "INSERT INTO base_objects VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)", count, model, conta, x, y, z, rx, ry, rz, health, tostring(encampment),getElementData(col,'attach_pos'),senha,status)
		end
	end
end
addEvent("newObject", true)
addEventHandler("newObject", root, newObject)

function acender_fornalha(col,player)
if getElementData(player,'Caixa de Fósforo') and getElementData(player,'Caixa de Fósforo') >= 1 then 


parent = getElementData(col,'parent')
x,y,z = getElementPosition(parent)
fire = createObject(3525,x,y,z)
setElementData(col,'fire',true)
setElementData(col,'fire_element',fire)
setObjectScale(fire,0)
triggerClientEvent('sound_fogo',root,x,y,z,true)
else
triggerClientEvent (player, "displayClientInfo", player,"acender_f","Você precisa de Caixa de Fósforo",255,0,0) 
end

end
addEvent("acender_fornalha", true)
addEventHandler("acender_fornalha", root, acender_fornalha)

function apagar_fornalha(col)
fire_element = getElementData(col,'fire_element')
destroyElement(fire_element) setElementData(col,'fire',false)
triggerClientEvent('sound_fogo',root,x,y,z,false)
end
addEvent("apagar_fornalha", true)
addEventHandler("apagar_fornalha", root, apagar_fornalha)

function destroyFornalha(col)
parent = getElementData(col,'parent')
fire_element = getElementData(col,'fire_element')
if col and isElement(col) then 
destroyElement(col)
end
if fire_element and isElement(fire_element) then 
destroyElement(fire_element)
end
destroyElement(parent) 
triggerClientEvent('sound_fogo',root,x,y,z,false)
setElementData(source,'currentCol',false)
end
addEvent("destroyFornalha", true)
addEventHandler("destroyFornalha", root, destroyFornalha)

function mudar_senha_porta(col,id,senha)
if col and id and senha then
		dbExec(db,'UPDATE base_objects SET senha=? WHERE id=?',senha,id)
		setElementData(col,'senha',senha)
end
end
addEvent("mudar_senha_porta",true)
addEventHandler("mudar_senha_porta",root,mudar_senha_porta)

function onObjectDamage(object,health,id,elemento)
	if object then
		dbExec(db,'UPDATE base_objects SET health=? WHERE id=?',health,id)
		outputChatBox("Vida restante: ["..getElementData(object,"health")..']',elemento,255,255,0)
	end
end
addEvent("onObjectDamage",true)
addEventHandler("onObjectDamage",root,onObjectDamage)

function onObjectDestroy(object,id)
	if isElement(object) then
		dbExec(db,"DELETE FROM base_objects WHERE id=?",id)
		if getElementData(object,"parent") then
			destroyElement(getElementData(object,"parent"))
		end
		local acc_dono = getElementData(object,'creator')
		local acc = getAccount(acc_dono)
		dono = getPlayerFromAccountName(acc_dono)
		if dono then
			setElementData(dono,'quant_craft',getElementData(dono,'quant_craft') -1)
			if getElementData(dono,'quant_craft') == 0 then 
			outputChatBox('Todos os seus itens de base foram removidos!',dono,255,255,0)
			end
		else
		setAccountData(acc,'quant_craft',getAccountData(acc,'quant_craft') -1)
		end
		destroyElement(object)
		count = count-1
	return
	end
end
addEvent("onObjectDestroy",true)
addEventHandler("onObjectDestroy",root,onObjectDestroy)

function onCamaDestroy(object)
	if isElement(object) then
		if getElementData(object,"parent") then
			destroyElement(getElementData(object,"parent"))
		end
		local acc_dono = getElementData(object,'creator')
		local acc = getAccount(acc_dono)
		dono = getPlayerFromAccountName(acc_dono)
		if dono then
			setElementData(dono,'cama',false)
			outputChatBox('A sua cama foi destruida!',dono,255,0,0)
		else
		setAccountData(acc,'cama',false)
		end
		blip = getElementData(object,'blip')
		if blip then
			destroyElement(blip)
		end	
		destroyElement(object)
	return
	end
end
addEvent("onCamaDestroy",true)
addEventHandler("onCamaDestroy",root,onCamaDestroy)

function resetBase(source)
		if getElementData(source,'quant_craft') == 0 then outputChatBox('Você não tem nenhum item de base!',source,255,255,0) end
object = getElementsByType('object')
for i,data in ipairs(object) do
	if getElementData(data,'creator') == getElementData(source,'accountName') then
		id = getElementData(data,'bc.ID')
		if id then
		onObjectDestroy(data,id)
		end
	end
end
end
addEvent('resetbase',true)
addEventHandler('resetbase',root,resetBase)
addCommandHandler('resetbase',resetBase)

addCommandHandler('resetbed',function(source)
		if getElementData(source,'cama') == false then outputChatBox('Você não tem cama!',source,255,255,0) end
object = getElementsByType('object')
for i,data in ipairs(object) do
	if getElementData(data,'creator') == getElementData(source,'accountName') then
		parent = getElementData(data,'parent')
		blip_cama = getElementData(data,'blip')
		if getElementData(parent,'cama') then
		destroyElement(data)
		destroyElement(parent)
			if blip_cama and isElement(blip_cama) then
			destroyElement(blip_cama)
			end
		setElementData(source,'cama',false)
		outputChatBox('Você destruiu sua cama!',source,255,255,0)
		end
	end
end
end)

function createBlipCama(object,visibleTo)
	if object then
		if isElement(blip_cama) then 
			destroyElement(blip_cama)
		end
		blip_cama = createBlipAttachedTo(object,31,2,255,0,0,255,0,99999.0,visibleTo)
		setElementData(object,"blip",blip_cama)
	end
end
addEvent("createBlipCama",true)
addEventHandler("createBlipCama",root,createBlipCama)

function onStart()
	if not fileExists("db/bases.db") then
		h = fileCreate("db/bases.db")
		if h then
		fileClose(h)
		outputDebugString("[StoneAge] Database das bases nao encontrada, criando...")
		end
		db = dbConnect( "sqlite", "db/bases.db" )
		outputDebugString("[StoneAge] Inserindo tabelas na database...")
dbExec(db,"CREATE TABLE IF NOT EXISTS base_objects(id INT AUTO_INCREMENT, model INT, creator VARCHAR, x FLOAT, y FLOAT, z FLOAT, rx FLOAT, ry FLOAT, rz FLOAT, health FLOAT, encampment VARCHAR, attach_pos FLOAT, senha VARCHAR, status VARCHAR)")
		outputDebugString("[StoneAge] Tabelas inseridas.")
	else
		db = dbConnect( "sqlite", "db/bases.db" )
		local qh = dbQuery( db, "SELECT * FROM base_objects" )
		local result = dbPoll( qh, 10000 )
			for i, ob in ipairs(result) do
				local tOb = createObject(ob['model'], ob['x'], ob['y'], ob['z'], ob['rx'], ob['ry'], ob['rz'])
				local col = createColSphere(ob['x'], ob['y'], ob['z'],1)
				attachElements ( col, tOb, 0, 0, ob['attach_pos'])	
				setElementData(tOb,"parent",col)
				setElementData(col,"parent",tOb)
				setElementData(tOb,"health",ob['health'])
				setElementData(col,"senha",ob['senha'])
				setElementData(col,"status",ob['status'])
				setElementData(col,"health",ob['health'])
				setElementData(col,"id_objeto",ob['model'])
				setElementData(col,"objeto_de_base",true)
				setElementData(col, "creator", ob['creator'])
				setElementData(tOb, "creator", ob['creator'])
				setElementData(tOb, "bc.ID", ob['id'])
				setElementData(tOb,"health",ob['health'])
				if getElementData(tOb,"health") <= 0 then
					if getElementData(tOb,"parent") then
						destroyElement(getElementData(tOb,"parent"))
					end
					destroyElement(tOb)
				end
				count = count + 1
			end
			outputDebugString("[StoneAge] Objetos de base carregados. TOTAL: "..tostring(count))
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function Movimentar_portao(object,status)
local col = getElementData(object,"parent")
local dono = getPlayerFromAccountName(getElementData(col,'creator'))
local x,y,z = getElementPosition(object)
if object and isElement(object) then
	if status == 'fechada' then
	moveObject(object,2000,x,y,z,0,0,0-90,"OutBounce")
	setElementData(col,'status','aberta')
	setTimer(function()
	if isElement(object) then 
	moveObject(object,2000,x,y,z,0,0,0+90,"OutBounce")
	setElementData(col,'status','fechada')
	end
	end,11000,1)
	end
setElementCollisionsEnabled(object, false)
setTimer(function()
setElementCollisionsEnabled(object, true)
end,2000,1)
end
end

function Movimentar_porta(object,status)
local col = getElementData(object,"parent")
local dono = getPlayerFromAccountName(getElementData(col,'creator'))
local x,y,z = getElementPosition(object)
if object and isElement(object) then
	if status == 'fechada' then
	moveObject(object,2000,x,y,z,0,0,0-90,"OutBounce")
	setElementData(col,'status','aberta')
	setTimer(function()
	if isElement(object) then 
	moveObject(object,2000,x,y,z,0,0,0+90,"OutBounce")
	setElementData(col,'status','fechada')
	end
	end,3000,1)
	end
setElementCollisionsEnabled(object, false)
setTimer(function()
setElementCollisionsEnabled(object, true)
end,2000,1)
end
end

openDoor = function (player,object,status)
	Movimentar_porta(object,status)
	setPedAnimation (player,"BUS","BUS_open_RHS",-1, false, false, false, false)
end
addEvent("abrir_fechar_porta",true)
addEventHandler("abrir_fechar_porta",root,openDoor)

openBigDoor = function (player,object,status)
	Movimentar_portao(object,status)
	setPedAnimation (player,"BUS","BUS_open_RHS",-1, false, false, false, false)
end
addEvent("abrir_fechar_portao",true)
addEventHandler("abrir_fechar_portao",root,openBigDoor)

function getPlayerFromAccountName(name) 
    local acc = getAccount (name)
    if name and acc and not isGuestAccount (acc) then
        return getAccountPlayer (acc)
    else
        return false
    end
end