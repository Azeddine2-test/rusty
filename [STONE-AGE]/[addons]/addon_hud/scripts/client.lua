local screenW, screenH = guiGetScreenSize()
font = dxCreateFont(":addon_hud/fonts/font.ttf",7)
font_nick = dxCreateFont(":addon_hud/fonts/font.ttf",12)

FPSLimit=100
FPSLimit=255/FPSLimit
FPSCalc=0
FPSTime=getTickCount()+1000

local root = getRootElement()
local counter = 0
local starttick
local currenttick
	
function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end





fading = 0
fading2 = "up"

function mostrar_hud()
if getElementData(localPlayer,"isDead") then return end
if getElementData(getLocalPlayer(),"logedin") then
if getElementData(getLocalPlayer(),"HUD_PESSOAL_Render") == true  then

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
	
	blood = getElementData(getLocalPlayer(),"blood") or 0
	experiencia = getElementData(getLocalPlayer(),"experiencia") or 0 
	experiencia_need = getElementData(getLocalPlayer(),"experiencia_need") or 0
	level = getElementData(getLocalPlayer(),"level") or 0
	fome = getElementData(getLocalPlayer(),"food") or 0
	sede = getElementData(getLocalPlayer(),"thirst") or 0
	grupo = getElementData(getLocalPlayer(),"gang") or "None"
	temperature = getElementData(localPlayer,"temperature") or 0
	if blood >= 10000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_100.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <= 9999 and blood >=9000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_90.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	8999 and blood >= 8000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_80.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	7999 and blood >= 7000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_70.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	6999 and blood >= 6000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_60.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	5999 and blood >= 5000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_50.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	4999 and blood >= 4000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_40.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	3999 and blood >= 3000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_30.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	2999 and blood >= 2000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_20.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	1999 and blood >= 1000 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <=	999 and blood >= 1 then
        dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/blood/blood_0.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif blood <= 0 then
		dxDrawImage(screenW * 0.4831, screenH * 0.8542, screenW * 0.1250, screenH * 0.0833, ":addon_hud/images/vida.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if fome == 100 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_100.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 99 and fome >= 90 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_90.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 89 and fome >= 80 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_80.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 79 and fome >= 70 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_70.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 69 and fome >= 60 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_60.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 59 and fome >= 50 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_50.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 49 and fome >= 40 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_40.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 39 and fome >= 30 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_30.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 29 and fome >= 20 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_20.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 19 and fome >= 10 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome/fome_10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	elseif fome <= 9 and fome >= 0 then
        dxDrawImage(screenW * 0.5096, screenH * 0.9375, screenW * 0.0985, screenH * 0.0313, ":addon_hud/images/fome.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if sede == 100 then
	         dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_100.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 99 and sede >= 90 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_90.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 89 and sede >= 80 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_80.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 79 and sede >= 70 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_70.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 69 and sede >= 60 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_60.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 59 and sede >= 50 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_50.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 49 and sede >= 40 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_40.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 39 and sede >= 30 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_30.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 29 and sede >= 20 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_20.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 19 and sede >= 10 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede/sede_10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	elseif sede <= 9 and sede >= 0 then
	        dxDrawImage(screenW * 0.4750, screenH * 0.9688, screenW * 0.1331, screenH * 0.0339, ":addon_hud/images/sede.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)    
	end         
	experience = -(experiencia-experiencia_need)
	if experience == 1000 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif experience <= 999 and experience >=900 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_10.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 899 and experience >=800 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_20.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 799 and experience >=700 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_30.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 699 and experience >=600 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_40.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 599 and experience >=500 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_50.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 499 and experience >=400 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_60.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 399 and experience >=300 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_70.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 299 and experience >=200 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_80.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience <= 199 and experience >=1 then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_90.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
    elseif experience == 0  then
        dxDrawImage(screenW * 0.4206, screenH * 0.8542, screenW * 0.0338, screenH * 0.1484, ":addon_hud/images/exp/exp_100.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)		
	end
	porcento_exp = (experiencia*100)/experiencia_need
        dxDrawText(experiencia_need, screenW * 0.4279, screenH * 0.8581, screenW * 0.4485, screenH * 0.8802, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawText(experiencia.."\n "..math.round((porcento_exp),0).."%", screenW * 0.4279, screenH * 0.9688, screenW * 0.4485, screenH * 0.9909, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		
        dxDrawImage(screenW * 0.4375, screenH * 0.8542, screenW * 0.0824, screenH * 0.1458, ":addon_hud/images/circulo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

		dxDrawText("Alimentação ["..(math.round((fome),0)).."%]", screenW * 0.5199, screenH * 0.9401, screenW * 0.6081, screenH * 0.9688, tocolor(0, 255, 255, 255), 0.885, font, "center", "center", false, false, false, false, false)
        dxDrawText("Hidratação ["..(math.round((sede),0)).."%]",  screenW * 0.5103, screenH * 0.9714, screenW * 0.6081, screenH * 1.0000, tocolor(100, 100, 50, 255), 0.885, font, "center", "center", false, false, false, false, false)
 
		dxDrawText("EXP", screenW * 0.4265, screenH * 0.8372, screenW * 0.4471, screenH * 0.8594, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawText("LVL: "..level, screenW * 0.4588, screenH * 0.9714, screenW * 0.4971, screenH * 0.9896, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		dxDrawText(getPlayerName(localPlayer):gsub('#%x%x%x%x%x%x', '') , screenW * 0.4390, screenH * 0.9115, screenW * 0.5169, screenH * 0.9375, tocolor(255, 255, 255, 255),1.00, font_nick, "center", "center", false, false, false, false, false)
        dxDrawText(math.round((temperature),2).."°C", screenW * 0.4449, screenH * 0.9401, screenW * 0.5132, screenH * 0.9688, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)

	
		blood_division = blood/100
		if blood <= 3000 then
		dxDrawText("Saúde: "..blood.."\n["..(math.round((blood_division),0)).."%]", screenW * 0.5199, screenH * 0.8542, screenW * 0.6081, screenH * 0.9375, tocolor(255,0,0 , 255), 1.00, font, "center", "center", false, false, false, false, false)
		else
			dxDrawText("Saúde: "..blood.."\n["..(math.round((blood_division),0)).."%]", screenW * 0.5199, screenH * 0.8542, screenW * 0.6081, screenH * 0.9375, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		end

        dxDrawImage(screenW * 0.6118, screenH * 0.9557, screenW * 0.0382, screenH * 0.0443, ":addon_hud/images/madeira.png", 0, 0, 0, tocolor(33, 94, 33, 255), false)
        dxDrawText(getElementData(localPlayer,"Madeira"), screenW * 0.62, screenH * 0.9245, screenW * 0.6471, screenH * 0.9544, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawImage(screenW * 0.3824, screenH * 0.9505, screenW * 0.0382, screenH * 0.0443, ":addon_hud/images/pedra.png", 0, 0, 0, tocolor(190, 190, 190, 255), false)
        dxDrawText(getElementData(localPlayer,"Pedra"), screenW * 0.3912, screenH * 0.9245, screenW * 0.4132, screenH * 0.9557, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
		if not starttick then
			starttick = getTickCount()
		end
		counter = counter + 1
		currenttick = getTickCount()
		if counter >= 60 then
		counter = 60
		end
		if currenttick - starttick >= 1000 then
			setElementData(localPlayer,"FPS",counter)
			counter = 0
			starttick = false
			
		end	
		fps = getElementData(getLocalPlayer(),"FPS") or 0
		ping = getPlayerPing(getLocalPlayer())
		dxDrawText("PING ["..ping.."]\n FPS ["..fps.."]",  screenW * 0.4544, screenH * 0.8672, screenW * 0.5022, screenH * 0.9102,  tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, false, false, false, false)
        
		if getElementData(localPlayer,'Colete_used') then
		dxDrawImage(screenW * 0.6169, screenH * 0.8659, screenW * 0.0287, screenH * 0.0508, ":addon_hud/images/colete.png", 0, 0, 0, tocolor(33,94,33, 255), false)
		end
		if getElementData(localPlayer,'Capacete_used') then
        dxDrawImage(screenW * 0.3919, screenH * 0.8659, screenW * 0.0287, screenH * 0.0508, ":addon_hud/images/capacete.png", 0, 0, 0, tocolor(190, 190, 190, 255), false)
		end	

		
		if getElementData(localPlayer,'brokenbone') then
		dxDrawImage(screenW * 0.3500, screenH * 0.9414, screenW * 0.0324, screenH * 0.0586, ":addon_hud/images/brokenbone.png", 0, 0, 0, tocolor(190, 190, 190, fading), false)
		end
		
		if getElementData(localPlayer,'cold') then
        dxDrawImage(screenW * 0.6544, screenH * 0.9414, screenW * 0.0324, screenH * 0.0586, ":addon_hud/images/temperature.png", 0, 0, 0, tocolor(33, 94, 33, fading), false)
		end		
		if getElementData(localPlayer,'bleeding') ~= 0 then
        dxDrawImage(screenW * 0.5147, screenH * 0.8620, screenW * 0.0147, screenH * 0.0260, ":addon_hud/images/bleeding.png", 0, 0, 0, tocolor(255, 255, 255, fading), true)
		end
 
		atual = getElementData(localPlayer,'quant_craft') or 'Error'
		maximo = getElementData(localPlayer,'quant_craft_max') or 'Error'
        dxDrawText("Base itens: "..atual..'/'..maximo, screenW * 0.4853, screenH * 0.8372, screenW * 0.6059, screenH * 0.8529, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)

	end
	end
end
addEventHandler ( "onClientRender", root, mostrar_hud )


if fileExists(":addon_hud/scripts/client.lua") == true then
fileDelete(":addon_hud/scripts/client.lua")
end