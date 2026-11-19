textos = {}
tempoDoTexto = {}

function Iniciar_rolagem(text, r, g, b)
	if #textos == 4 then
		destruirItemDeTexto()
	end
	table.insert(textos,{text,r,g,b})
	checar_Timers()
end
addEvent("startRollText", true)
addEventHandler("startRollText", getLocalPlayer(), Iniciar_rolagem)

function destruirItemDeTexto ()
	table.remove(textos,1)
end

function checar_Timers ()
	if isTimer(tempoDoTexto["destroy"]) then
		killTimer(tempoDoTexto["destroy"])
	end
	tempoDoTexto["destroy"] = setTimer(destruirItemDeTexto,1500,4)
end

local screenWidth, screenHeight = guiGetScreenSize()
local boxSpace = dxGetFontHeight(1,"default-bold")+dxGetFontHeight(1,"default-bold")*0.15

addEventHandler("onClientRender", getRootElement(), function()
	for id, value in pairs(textos) do
		if (#textos == 1 or #textos == 2 or #textos == 3 or #textos == 4 or #textos == 5) then
			r2,g2,b2 = 0,0,0
			if id == 1 or id == 3 then
				r2,g2,b2 = 5,5,5
			end
		end
		dxDrawRectangle(screenWidth*0.675, screenHeight-id*boxSpace, screenWidth*0.15, boxSpace, tocolor(r2,g2,b2,205))
		dxDrawingColorText(value[1],screenWidth*1.35, screenHeight-id*boxSpace, screenWidth*0.15, screenHeight-(id-1)*boxSpace, tocolor(value[2],value[3],value[4],225),200, 1, "default-bold", "center", "center")
	end
end)






function fireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	if hitElement then
	blood = getElementData(hitElement,'blood')
	Iniciar_rolagem('Damage: '..blood)
	triggerEvent ("startRollText",getLocalPlayer(),'damage: a',50,205,50)
	end
end
addEventHandler("onClientPlayerDamage",localPlayer, fireFunc)







