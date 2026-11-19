
function toggleWeaponSounds_f ( )
setAmbientSoundEnabled( "gunfire", false )
    setWorldSoundEnabled ( 5, true ) -- And here the toggling happens.
end
addEventHandler('onClientResourceStart',root,toggleWeaponSounds_f)
table = {
{30,"Sounds/primary/akm.wav"},
{31,"Sounds/primary/m16a4.wav"},
{34,"Sounds/primary/awm.wav"},
{25,"Sounds/primary/s1897.wav"},
{27,"Sounds/primary/s686.wav"},
{33,"Sounds/primary/kar98k.wav"},
{22,"Sounds/pistols/p1911.wav"},
{23,"Sounds/pistols/p92.wav"},
{28,"Sounds/pistols/pdw.wav"},
{29,"Sounds/pistols/mp5.wav"},
}


--[[
CH = {} 
cross = false
function render_crosshair()
  screenw,screenh = guiGetScreenSize()
  s = screenw * 0.5 
  u,v =(screenw - s)*0.5,(screenh - s)*0.5
  black = tocolor(0,0,0,255)
  dxDrawRectangle(0,0,screenw,v,black)
  dxDrawRectangle(0,0,u,screenh,black)
  dxDrawRectangle(0,screenh,screenw,-v,black)
  dxDrawRectangle(screenw,screenh,-u,-screenh,black)
  dxDrawImage(u,v,screenw-2*u,screenh-2*v,CHBackground)
  dxDrawImage(u,v,screenw-2*u,screenh-2*v,cross)
end

function on_weapon_aimed(key,state)
  if getPedWeapon(getLocalPlayer())== 34 then
	if state == "down" then
		  cross = CH['awm']
	  setPlayerHudComponentVisible("crosshair",false)
	  addEventHandler("onClientHUDRender",getRootElement(),render_crosshair)
	else 
	  cross = false
	  removeEventHandler("onClientHUDRender",getRootElement(),render_crosshair)
	end
  end
end 

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),function()
  CHBackground = dxCreateTexture("fundo.png","argb",true,"wrap")
  CH["awm"] = dxCreateTexture("mira.png","argb",true,"wrap")
  bindKey("aim_weapon","both",on_weapon_aimed)
  addEventHandler("onClientPlayerWeaponSwitch",getRootElement(),function(previousWeaponSlot)
	if previousWeaponSlot == 6 then
	  if not isPlayerHudComponentVisible("crosshair")then
		setPlayerHudComponentVisible("crosshair",true)
	  end
	end 
  end)
end)
	
addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),function()
  unbindKey("aim_weapon","both",on_weapon_aimed)
  if not isPlayerHudComponentVisible("crosshair")then
	setPlayerHudComponentVisible("crosshair",true)
  end
end)



]]








function PlaySound()
  x,y,z = getPedWeaponMuzzlePosition(source)
for i, data in ipairs(table) do
	if getPedWeapon(source) == data[1] then 
		sound = playSound3D(data[2],x,y,z, false)
		setSoundMaxDistance(sound,200)
	end
end
end
addEventHandler("onClientPlayerWeaponFire",root,PlaySound)

function shakeCamera(weapon) 
x,y,z = getPedBonePosition ( getLocalPlayer(), 26 ) 
if weapon == 22 then 
createExplosion ( x,y,z +700,12,false,0.1,false) 
elseif weapon == 24 then 
createExplosion ( x,y,z +700,12,false,0.2,false) 
elseif weapon == 25 then 
createExplosion ( x,y,z +700,12,false,0.4,false) 
elseif weapon == 26 then 
createExplosion ( x,y,z +700,12,false,0.5,false) 
elseif weapon == 27 then 
createExplosion ( x,y,z +700,12,false,0.4,false) 
elseif weapon == 28 then 
createExplosion ( x,y,z +700,12,false,0.1,false) 
elseif weapon == 29 then 
createExplosion ( x,y,z +1000,12,false,5000,false) 
elseif weapon == 30 then 
a = createExplosion (x,y,z-1,12,false,0.1,false) 
elseif weapon == 31 then 
createExplosion ( x,y,z +700,12,false,0.1,false) 
elseif weapon == 32 then 
createExplosion ( x,y,z +700,12,false,0.1,false) 
elseif weapon == 33 then 
createExplosion ( x,y,z +700,12,false,0.1,false) 
elseif weapon == 38 then 
createExplosion ( x,y,z +700,12,false,0.5,false) 
end 
end 
--addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), shakeCamera ) 

--[[
function shakeCamera()

end
addEventHandler("onClientPlayerWeaponFire",root,shakeCamera)
]]