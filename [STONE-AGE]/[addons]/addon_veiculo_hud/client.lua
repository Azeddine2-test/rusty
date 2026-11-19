local screenWidth,screenHeight = guiGetScreenSize()

local drawDetails = {
	{"Motor","Engine_inVehicle","needengines"},
	{"Pneu","Tire_inVehicle","needtires"},
	{"Tank","Parts_inVehicle","needparts"},
}

local colorEmpty = tocolor ( 255, 0, 0 )
local colorFull = tocolor ( 255, 255, 255 )
local colorFuel = tocolor ( 92, 141, 71 )

local baseX, baseY = 40,screenHeight/2

local baseWidth, baseHeight = 15,115
local betweenBars = 1
local smallBarsWidth = 2
local barBaseX = baseX-baseWidth-5-smallBarsWidth-betweenBars
local topBotBarsWidthAddit = 2
local topBotBarsWidth, topBotBarsHeight = baseWidth+smallBarsWidth*2+betweenBars*2+topBotBarsWidthAddit*2,2
local additBarsQuant = 2
--local additBarsPosition = (baseHeight-additBarsQuant*topBotBarsWidthAddit)/additBarsQuant
local additBarsPosition = (baseHeight+topBotBarsWidthAddit)/additBarsQuant
local oneTextHeight = baseHeight/(#drawDetails+2.5)
local textPos = barBaseX+betweenBars+baseWidth+smallBarsWidth+2


--add um icone de ligado/desligado
addEventHandler( "onClientRender", root,
    function()
		local veh = getPedOccupiedVehicle (getLocalPlayer())
        if veh then
		if not getElementData(localPlayer,'HUD_VEH_Render') then return end
		if getElementModel(veh) == 481 then return end -- bike
			local parent = getElementData ( veh, "parent" ) 
			if isElement ( parent ) then
				local maxfuel = (getElementData(veh,"maxfuel") or 0)
				local fuel = getElementData(getElementData(veh,"parent"),"fuel")
				
				dxDrawImage ( barBaseX+2, baseY-5-baseWidth, baseWidth, baseWidth, "fuel.png",0,0,0,colorFuel)
				if getVehicleEngineState(veh) == true then
				dxDrawImage ( barBaseX-3, baseY+5+baseHeight, baseWidth+5, baseWidth+5, "ligado.png",0,0,0,colorFull)
				else
				dxDrawImage ( barBaseX-3, baseY+5+baseHeight, baseWidth+5, baseWidth+5, "desligado.png",0,0,0,colorEmpty)
				end
				dxDrawRectangle(barBaseX, baseY, baseWidth, baseHeight, tocolor(0, 0, 0, 255), true)
				dxDrawRectangle(barBaseX-smallBarsWidth-betweenBars, baseY, smallBarsWidth, baseHeight, tocolor(255, 255, 255, 255), true)
				dxDrawRectangle(barBaseX+betweenBars+baseWidth, baseY, smallBarsWidth, baseHeight, tocolor(255, 255, 255, 255), true)
				dxDrawRectangle(barBaseX-smallBarsWidth-betweenBars-topBotBarsWidthAddit, baseY-topBotBarsHeight, topBotBarsWidth, topBotBarsHeight, tocolor(255, 255, 255, 255), true)
				dxDrawRectangle(barBaseX-smallBarsWidth-betweenBars-topBotBarsWidthAddit, baseY+baseHeight, topBotBarsWidth, topBotBarsHeight, tocolor(255, 255, 255, 255), true)
				for i = 1, additBarsQuant do
					dxDrawRectangle(barBaseX-smallBarsWidth-betweenBars-topBotBarsWidthAddit, baseY-topBotBarsHeight+additBarsPosition*i, topBotBarsWidthAddit, topBotBarsWidthAddit, tocolor(255, 255, 255, 255), true)
					dxDrawRectangle(barBaseX+betweenBars+baseWidth+smallBarsWidth, baseY-topBotBarsHeight+additBarsPosition*i, topBotBarsWidthAddit, topBotBarsWidthAddit, tocolor(255, 255, 255, 255), true)
				end		
				for i, v in ipairs ( drawDetails ) do
					local need = getElementData(veh,v[3]) or 0
					local quant = getElementData(parent,v[2]) or 0
					if need > quant then
						dxDrawText (v[1].." ("..quant.."/"..need..")",textPos,baseY+(i-1.5)*oneTextHeight,baseX+screenWidth,baseY+i*oneTextHeight,colorEmpty, 1, "default-bold","left","center" )
					else
						dxDrawText (v[1].." ("..quant.."/"..need..")",textPos,baseY+(i-1.5)*oneTextHeight,baseX+screenWidth,baseY+i*oneTextHeight,colorFull, 1, "default-bold","left","center" )
					end
				end
				dxDrawText ("Condição: "..math.floor(getElementHealth(veh)/10).."%",textPos,baseY+#drawDetails*oneTextHeight,baseX+screenWidth,baseY+(#drawDetails+0.5)*oneTextHeight,colorFull, 1, "default-bold","left","center" )
				dxDrawText ("Velocidade: "..math.floor(getVehicleSpeed(veh)).." km/h.",textPos,baseY+(#drawDetails+1)*oneTextHeight,baseX+screenWidth,baseY+(#drawDetails+1.5)*oneTextHeight,colorFull, 1, "default-bold","left","center" )
				vehicleName = getVehicleNameStoneAge(getElementModel(veh))
				dxDrawText (vehicleName,textPos,baseY+(#drawDetails+2)*oneTextHeight,baseX+screenWidth,baseY+(#drawDetails+2.5)*oneTextHeight,colorFull, 1, "default-bold","left","center" )
				local id = getElementModel(veh)
				if id == 481 then return end
				local _,_,size = interpolateBetween ( 0, 0, 0, 0, 0, baseHeight, fuel/maxfuel, "Linear" )
				if size > 0 then
					dxDrawRectangle(barBaseX, baseY+baseHeight-size, baseWidth, size, colorFuel, true)
				end				
			end
		end
end)
	
function getVehicleSpeed(vehicle)   
    if isElement(vehicle) then
        local vx, vy, vz = getElementVelocity(vehicle)
        
        if (vx) and (vy)and (vz) then
            return math.sqrt(vx^2 + vy^2 + vz^2) * 180 -- km/h
        else
            return 0
        end
    else
        return 0
    end
end

vehiclesTable = {
--{'nome', id, tire,engine,tank, maxfuel} 
{'Picape', 422, 4,1,1, 80},
{'Alpha', 602, 4,1,1, 65},
{'Ninja', 522, 2,1,1, 35},
{'Combi', 483, 4,1,1, 85},
{'Ambulancia', 416, 4,1,1, 75},
{'Bike', 481, 0,0,0, 0},
{'Family', 400, 4,1,1, 70},
{'Lamborghini', 411, 4,1,1, 70},
{'Harley', 463, 2,1,1, 50},
{'Caminhao', 433, 6,1,1, 100},
{'Policia', 461, 2,1,1, 50},
}

function getVehicleNameStoneAge(id)
	for i, data in ipairs(vehiclesTable) do
		if id == data[2] then
			return data[1]
		end
	end
end