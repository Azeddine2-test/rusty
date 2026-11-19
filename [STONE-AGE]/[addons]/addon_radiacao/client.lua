local screenW, screenH = guiGetScreenSize()
fading = 0
fading2 = "up"

function loseLife()
	if getElementData(localPlayer,'inRadiation') then
		if getElementData(localPlayer,'Mask_used') == true then
			bloodLoss = math.random(50,100)
		else
			bloodLoss = math.random(200,250)
		end
		setElementData(localPlayer,'blood',getElementData(localPlayer,'blood')-bloodLoss)
	end
end
setTimer(loseLife,1000,0)

if fileExists("client.lua") == true then
fileDelete("client.lua")
end

function sound(state)
if state == true then 
uSound = playSound('radial.mp3',true ) 
setSoundVolume(uSound, 0.5) 
else
if isElement(uSound) then stopSound(uSound) end
end
end
addEvent('RadialSound',true)
addEventHandler('RadialSound',root,sound)

addEventHandler("onClientRender", root,
    function()
	if fading >= 0 and fading2 == "up" then
      fading = fading + 3.5
    elseif fading <= 255 and fading2 == "down" then
      fading = fading - 3.5
    end
    if fading == 0 then
      fading2 = "up"
    elseif fading == 255 then
      fading2 = "down"
    end
	if getElementData(localPlayer,'inRadiation') then
        dxDrawImage(screenW * 0.9574, screenH * 0.7930, screenW * 0.0353, screenH * 0.0625, ":addon_radiacao/radiacao.png", 0, 0, 0, tocolor(255, 255, 255, fading), false)
    end
    end
)