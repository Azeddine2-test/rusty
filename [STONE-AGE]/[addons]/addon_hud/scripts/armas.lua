local screenW, screenH = guiGetScreenSize()

table_weapons = {
['Armas'] = {
{'P1911','.45 ACP',10,22},
{'P92','.45 ACP',10,23},
{'PDW','9mm',25,28},
{'MP5A5','9mm',25,29},
{'M16A4','5.56mm',20,31},
{'AKM','7.62mm',30,30},
{'S1897','12 Gauge',7,25},
{'S686','12 Gauge',7,27},
{'Sniper','.300 Magnum',1,34},
{'Kar98k','7.62mm',1,33},
{'Granada','','',16},
{'Machete','','',4},
{'Machado','','',8},
{'Pá','','',6},
{'Picareta','','',2},
{'','','',0},
},
}

function getWeaponNameFromID()
for i, data in ipairs(table_weapons['Armas']) do 
	if getPedWeapon(localPlayer) == data[4] then 
		return data[1]
	end
end
end

function getAmmoNameFromWeaponName()
for i, data in ipairs(table_weapons['Armas']) do 
	if getPedWeapon(localPlayer) == data[4] then 
		return data[2]
	end
end
end

function getMAXAmmoFromWeaponName()
for i, data in ipairs(table_weapons['Armas']) do 
	if getPedWeapon(localPlayer) == data[4] then 
		return data[3]
	end
end
end

addEventHandler("onClientRender", root,
function()
	if not getElementData(localPlayer,'logedin') then return end
	if getElementData(localPlayer,'HUD_ARMAS_Render') then
	
		local hour, minutes = getTime()
	if minutes < 10 then add0 = "0" else add0 = "" end
	local time = hour..":"..add0..""..minutes
		dxDrawText(time, screenW * 0.9191, screenH * 0.1237, screenW * 0.9838, screenH * 0.1497, tocolor(255, 255, 50, 255), 1.25, "default-bold", "right", "center", false, false, false, false, false)
		local ammo = getElementData(localPlayer,getAmmoNameFromWeaponName()) or ''
		local clip = getPedAmmoInClip(getLocalPlayer())

        dxDrawText(getWeaponNameFromID(), screenW * 0.8449, screenH * 0.1497, screenW * 0.9831, screenH * 0.1758, tocolor(255, 255, 50, 255), 1.25, "default-bold", "right", "center", false, false, false, false, false)
		if ammo ~= '' then barra = ' / ' else barra = '' clip = '' end
		dxDrawText(ammo..barra..clip..barra..getMAXAmmoFromWeaponName(), screenW * 0.9191, screenH * 0.1758, screenW * 0.9838, screenH * 0.2018, tocolor(255, 255, 50, 255), 1.25, "default-bold", "right", "center", false, false, false, false, false)

if isPedReloadingWeapon ( localPlayer) then
        dxDrawImage(screenW * 0.9397, screenH * 0.2044, screenW * 0.0272, screenH * 0.0482, ":StoneAge/images/reload.png", 0, 0, 0, tocolor(255, 255, 50, 255), false)
end
		end
end)

if fileExists(":addon_hud/scripts/armas.lua") == true then
fileDelete(":addon_hud/scripts/armas.lua")
end