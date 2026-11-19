local antirelog_time = 10 --Время антирелога (В секундах)
local xs, ys = guiGetScreenSize ()
local sess_id = 0
local going_timer = nil
local going_time = 10

addEventHandler( "onClientRender", root,
function()
drawAntirelogTimer()
end
)
local screenW, screenH = guiGetScreenSize()
function drawAntirelogTimer ()
if isTimer ( going_timer ) and getElementData ( localPlayer, "antiRelogWork" ) then
--dxDrawText ( "Anti-Relog: "..going_time, 0, ys-ys/1+250, xs, ys, tocolor ( 250, 10, 10 ), 1.5, "default-bold", "center", "top" )
        dxDrawText("ANTI-RELOG: "..going_time, (screenW * 0.0074) - 1, (screenH * 0.4948) - 1, (screenW * 0.1728) - 1, (screenH * 0.5313) - 1, tocolor(0, 0, 0, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("ANTI-RELOG: "..going_time, (screenW * 0.0074) + 1, (screenH * 0.4948) - 1, (screenW * 0.1728) + 1, (screenH * 0.5313) - 1, tocolor(0, 0, 0, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("ANTI-RELOG: "..going_time, (screenW * 0.0074) - 1, (screenH * 0.4948) + 1, (screenW * 0.1728) - 1, (screenH * 0.5313) + 1, tocolor(0, 0, 0, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("ANTI-RELOG: "..going_time, (screenW * 0.0074) + 1, (screenH * 0.4948) + 1, (screenW * 0.1728) + 1, (screenH * 0.5313) + 1, tocolor(0, 0, 0, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("ANTI-RELOG: "..going_time, screenW * 0.0074, screenH * 0.4948, screenW * 0.1728, screenH * 0.5313, tocolor(254, 0, 6, 255), 1.5, "default-bold", "left", "center", false, false, false, false, false)

--dxDrawText ( "Не покидайте сервер!", 0, ys-ys/4+15, xs, ys, tocolor ( 250, 10, 10 ), 1.5, "default-bold", "center", "top" )
end
end

function cancelPedDamage ( attacker, weapon )
if isElement ( attacker ) and getElementType ( attacker ) == "player" and weapon > 0 then
if source == localPlayer then
going_time = antirelog_time
if not isTimer ( going_timer ) then
going_timer = setTimer ( checkAntiRelogTime, 1000, 0 )
end
setElementData ( source, "antiRelogWork", true )
end
end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, cancelPedDamage )


function wastedMessage ( killer, weapon, bodypart )
if isTimer ( going_timer ) then
killTimer ( going_timer )
end 
going_timer = nil
setElementData ( localPlayer, "antiRelogWork", false )
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wastedMessage )

function checkAntiRelogTime ()
local vx,vy,vz = getElementVelocity (localPlayer)
if vx == 0 and vy == 0 and vz == 0 then
going_time = going_time-1
if going_time == 0 then
setElementData ( localPlayer, "antiRelogWork", false )
killTimer ( going_timer )
going_timer = nil
end
else
going_time = 10
end
end

addEventHandler('onClientPlayerWeaponFire',root,function()
going_time = 10
end)