xasdhasuh = dxCreateFont(":stoneage/fonts/12.ttf",10)
theTexts = {}
theTextTimer = {}
function startRollMessage(text, r, g, b)
	if #theTexts == 3 then
		destroyTextItem()
	end
	table.insert(theTexts,{text,r,g,b})
	checkTimers()
end
addEvent("onRollMessageStart", true)
addEventHandler("onRollMessageStart", getLocalPlayer(), startRollMessage)


function startRollMessage2(head,text, r, g, b)
	if #theTexts == 3 then
		destroyTextItem()
	end
	table.insert(theTexts,{text,r,g,b})
	checkTimers()
end
addEvent("displayClientInfo", true)
addEventHandler("displayClientInfo", getLocalPlayer(), startRollMessage2)

function addDayZInfoBox(text,r,g,b)
	startRollMessage(text, r, g, b)
end

function destroyTextItem ()
	table.remove(theTexts,1)
end
function checkTimers ()
	if isTimer(theTextTimer["destroy"]) then
		killTimer(theTextTimer["destroy"])
	end
	theTextTimer["destroy"] = setTimer(destroyTextItem,4000,3)
end

--Draw Part
local screenWidth, screenHeight = guiGetScreenSize()
local boxSpace = dxGetFontHeight(1,xasdhasuh)+dxGetFontHeight(1,xasdhasuh)*0.3

addEventHandler("onClientRender", getRootElement(), 
	function()
		for id, value in pairs(theTexts) do
				dxDrawingColorText(value[1],screenWidth*-0.425, screenHeight-id*boxSpace, screenWidth*0.7, screenHeight-(id-1)*boxSpace, tocolor(255,255,0,255),255, 1, xasdhasuh, "center", "center")
		end
	end
)



local fonte = dxCreateFont(":stoneage/fonts/12.ttf",10)
table_texto = {}
tempo_proximo_texto = {}
function interacao(elemento,text)
	if #table_texto == 2 then
		destroy_texto()
	end
	table.insert(table_texto,{elemento,text})
	checando()
end
addEvent("interacao", true)
addEventHandler("interacao", getLocalPlayer(), interacao)

function destroy_texto ()
	table.remove(table_texto,1)
end

function checando()
	if isTimer(tempo_proximo_texto["destroy"]) then
		killTimer(tempo_proximo_texto["destroy"])
	end
	tempo_proximo_texto["destroy"] = setTimer(destroy_texto,2000,2)
end

local screenWidth, screenHeight = guiGetScreenSize()
local boxSpace = dxGetFontHeight(1,fonte)+dxGetFontHeight(1,fonte)*0.3

addEventHandler("onClientRender", getRootElement(), 
	function()
		for id, value in pairs(table_texto) do	
			local x,y,z = getElementPosition(value[1])
			local x,y,distance = getScreenFromWorldPosition (x,y,z+0.75)
			distance = 30
			local w = dxGetTextWidth(value[2],distance*0.033,fonte)
			if x and y and z then
			dxDrawText (value[2],x-(w/2),y-id*boxSpace,x-(w/2), y, tocolor ( 255, 255, 0, 255 ), distance*0.033, fonte )
			end
			end
	end
)



if fileExists("jq_client.lua") == true then
fileDelete("jq_client.lua")
end
