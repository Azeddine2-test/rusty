tempo_respawn_padrao = math.random(300000,900000)
--tempo_respawn_padrao = 2000

function spawn_arvore_1()
	for i,data in ipairs (table_positions["Arvore_1"]) do 
		x,y,z = data[1],data[2],data[3],data[4],data[5],data[6]
	        object = createObject(669,x,y,z-1)
			blip = createBlip ( x,y,z, 0, 1, 33,94,33, 255, 0, 170,getRootElement() ) --33,94,33 = verde
			colisao = createColSphere(x,y,z,1)
            attachElements (colisao, object, 0, 0, 1 )
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
			setElementData(colisao,"Maçã",math.random(1,5))
            setElementData(colisao,"Madeira",math.random(1,10))
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z)
            setElementData(colisao,"arvore_1",true)	
			end	
end
spawn_arvore_1()

function remover_arvore_1 (object,colisao)
    col = getElementData(source,"currentCol")
	x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
    destroyElement(getElementData(object,"parent"))
    destroyElement(object)
	morto_arvore = createObject(848,x,y,z+0.5)
	setTimer(function ()
	destroyElement(morto_arvore)
	respawn_arvore_1(x,y,z)
	end,tempo_respawn_padrao,1)	
end
addEvent("remover_arvore_1",true)
addEventHandler("remover_arvore_1",getRootElement(),remover_arvore_1)

function respawn_arvore_1(x,y,z)		
			object = createObject(669,x,y,z-1)
			colisao = createColSphere(x,y,z,1)
            attachElements (colisao, object, 0, 0, 1 )
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
			setElementData(colisao,"Maçã",math.random(1,5))
            setElementData(colisao,"Madeira",math.random(1,15))
            setElementData(colisao,"hit_atual",0)
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z)
            setElementData(colisao,"arvore_1",true)	
end

function spawn_pedra()
	for i,data in ipairs (table_positions["Pedra_1"]) do 
		x,y,z = data[1],data[2],data[3]
	        object = createObject(868,x,y,z-0.5)
            setObjectScale(object,1)
            colisao = createColSphere(x,y,z,1)
			blip = createBlip ( x,y,z, 0, 1, 190,190,190, 255, 0, 200,getRootElement() ) --190,190,190 = cinza
            attachElements (colisao, object, 0, 0,0)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Pedra",math.random(5,15))
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z-0.5)
            setElementData(colisao,"pedra",true)
	end
end
spawn_pedra()

function spawn_ferro()
	for i,data in ipairs (table_positions["Ferro_1"]) do 
		x,y,z = data[1],data[2],data[3]
	        object = createObject(2936,x,y,z-0.5)
            setObjectScale(object,1)
			setElementFrozen(object,true)
            colisao = createColSphere(x,y,z,1.25)
			blip = createBlip ( x,y,z, 0, 1, 255,255,255, 255, 0, 200,getRootElement() ) --255,255,255, branco
            attachElements (colisao, object, 0, 0,0.75)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Ferro",math.random(2,10))
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z-0.5)
            setElementData(colisao,"ferro",true)
	end
end
spawn_ferro()

function remover_objeto_ferro (object)
	col = getElementData(source,"currentCol")
	x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
    destroyElement(getElementData(object,"parent"))
    destroyElement(object)
	morto_ferro = createObject(867,x,y,z-0.5)
	setObjectScale(morto_ferro,0.25)
	setTimer(function ()
	destroyElement(morto_ferro)
	respawn_ferro(x,y,z)
	end,tempo_respawn_padrao,1)	
end
addEvent("remover_objeto_ferro",true)
addEventHandler("remover_objeto_ferro",getRootElement(),remover_objeto_ferro)

function remover_objeto_pedra (object)
	col = getElementData(source,"currentCol")
	x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
    destroyElement(getElementData(object,"parent"))
    destroyElement(object)
	morto = createObject(867,x,y,z-0.5)
	setObjectScale(morto,0.25)
	setTimer(function ()
	destroyElement(morto)
	respawn_pedra(x,y,z)
	end,tempo_respawn_padrao,1)	
end
addEvent("remover_objeto_pedra",true)
addEventHandler("remover_objeto_pedra",getRootElement(),remover_objeto_pedra)

function respawn_ferro(x,y,z)		
	        object = createObject(2936,x,y,z)
			setElementFrozen(object,true)
            colisao = createColSphere(x,y,z,1.25)
            attachElements (colisao, object, 0, 0,0.75)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Ferro",math.random(5,15))
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z)
            setElementData(colisao,"ferro",true)
end
function respawn_pedra(x,y,z)		
	        object = createObject(868,x,y,z)
            colisao = createColSphere(x,y,z,1)
            attachElements (colisao, object, 0, 0,0)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Pedra",math.random(5,15))
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z)
            setElementData(colisao,"pedra",true)
end

function spawn_planta_1()
	for i,data in ipairs (table_positions["Planta_1"]) do 
		x,y,z = data[1],data[2],data[3]
	        object = createObject(801,x,y,z-1)
            setObjectScale(object,0.5)
			blip = createBlip ( x,y,z, 0, 1, 50,205,50, 255, 0, 200,getRootElement() ) 
            colisao = createColSphere(x,y,z,0.5)
            attachElements (colisao, object, 0, 0,1)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Sementes",1)
            setElementData(colisao,"Maçã",1)
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z-1)
            setElementData(colisao,"planta",true)
	end
end
spawn_planta_1()


function remover_planta (object)
	col = getElementData(source,"currentCol")
	if getElementData(col,"Maçã") == 0 and getElementData(col,"Sementes") == 0 then
	x,y,z = getElementData(col,"x"),getElementData(col,"y"),getElementData(col,"z")
    destroyElement(getElementData(object,"parent"))
    destroyElement(object)
	morto = createObject(815,x,y,z)
	setObjectScale(morto,0.3)
	setTimer(function ()
	destroyElement(morto)
	respawn_planta(x,y,z)
	end,tempo_respawn_padrao,1)	
	end
end
addEvent("remover_planta",true)
addEventHandler("remover_planta",getRootElement(),remover_planta)

function respawn_planta(x,y,z)		
	        object = createObject(801,x,y,z)
			blip = createBlip ( x,y,z, 0, 1, 50,205,50, 255, 0, 200,getRootElement() ) 
            setObjectScale(object,0.5)
            colisao = createColSphere(x,y,z,0.5)
            attachElements (colisao, object, 0, 0,1)
            setElementData(colisao,"parent",object)
            setElementData(object,"parent",colisao)
            setElementData(colisao,"Sementes",1)
            setElementData(colisao,"Maçã",1)
            setElementData(colisao,"object_id",801)
            setElementData(colisao,"x",x)
            setElementData(colisao,"y",y)
            setElementData(colisao,"z",z)
            setElementData(colisao,"planta",true)
end

function picaretada_sound(col)
x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
triggerClientEvent('picareta',root,x,y,z)
--[[
for i,player in ipairs (getElementsByType("player")) do
xp,yp,zp = getElementPosition(player)
if player == source then return end
	if getDistanceBetweenPoints3D(x,y,z,xp,yp,zp) < 20 then
	triggerClientEvent('picareta',root,x,y,z)
	end
end]]
end
addEvent("pick", true)
addEventHandler("pick", root, picaretada_sound)

function planta(col)
x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
triggerClientEvent('plantas',root,x,y,z)
end
addEvent("planta", true)
addEventHandler("planta", root, planta)

function machadada(col)
x,y,z = getElementData(col,"x"), getElementData(col,"y"), getElementData(col,"z")
triggerClientEvent('machadada',root,x,y,z)
end
addEvent("machadada", true)
addEventHandler("machadada", root, machadada)

function anim_player_planta()
setElementFrozen(source,true)
    setTimer( function(source)
        if isElement(source) then
            setElementFrozen(source, false)
        end
    end,2000,1,source)
	number = math.random (1,2)
	if number == 1 then
	setPedAnimation ( source, "bd_fire", "wash_up", -1, false, false,false, false, nil )
	elseif number == 2 then
	setPedAnimation ( source, "bomber", "bom_plant", -1, false, false,false, false, nil )
	end
end
addEvent("anim_player_planta",true)
addEventHandler("anim_player_planta",getRootElement(),anim_player_planta)
