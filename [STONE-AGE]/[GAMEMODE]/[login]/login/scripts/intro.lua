local screenW, screenH = guiGetScreenSize()
fading = 0
fading2 = 0
function draw_intro()
    if fading >= 0 then fading = fading + 1 end if fading >= 255 then fading = 255 end    
	if fading2 >= 0 then fading2 = fading2 + 0.9 end if fading2 >= 255 then fading2 = 255 end
dxDrawImage(screenW*0,screenH*0,screenW,screenH,":login/images/intro.png",0,0,0,tocolor(255,255,255,fading),true)
dxDrawImage(screenW * 0.2978, screenH * 0.1914, screenW * 0.4044, screenH * 0.6172, ":login/images/logo.png", 0, 0, 0, tocolor(255, 255, 255, fading2), true)
end
addEventHandler('onClientRender',root,draw_intro)

function hide_intro()
removeEventHandler('onClientRender',root,draw_intro)
fadeCamera(true,5)
setElementInterior(localPlayer,10)
setCameraMatrix(421,2540,11.75, 356,2493,-5)
setTimer(function()
startLogin()
end,100,1)
unbindKey('space','down',hide_intro)
unbindKey('mouse1','down',hide_intro)
end
bindKey('space','down',hide_intro)
bindKey('mouse1','down',hide_intro)


function table.size(tab)
if not tab then return end
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

file = ":login/scripts/intro.lua"
if fileExists(file) == true then
fileDelete(file)
end

musics = {
'ChopSuey',
'ItsMyLife',
'LastResort',
'SmoothCriminal',
}



local number = math.random(table.size(musics))
sound = playSound(':login/sounds/'..musics[number]..'.ogg',true)
if sound then setSoundVolume(sound, 0.12) end

        musica_label = guiCreateLabel(0.68, 0.93, 0.32, 0.03, "Musique : "..musics[number], true)
        guiSetFont(musica_label, "default-bold-small")
        guiLabelSetHorizontalAlign(musica_label, "right", false)
        guiLabelSetVerticalAlign(musica_label, "center")    

		dancing_button = guiCreateCheckBox(0.94, 0.91, 0.06, 0.02, "Danser", false, true)
        guiSetFont(dancing_button, "default-bold-small")
		
addEvent('stop_music_login',true)
function stopS()
if isElement(sound) then
destroyElement(sound)
end
if isElement(musica_label) then
destroyElement(musica_label)
end
if isElement(dancing_button) then
destroyElement(dancing_button)
end
end
addEventHandler('stop_music_login',root,stopS)


dancing = function(state)
number = math.random(1,9)
if state == true then 
	if number == 1 then 
	setPedAnimation(testPed,'dancing','dnce_M_d',-1,true,false,false,false)
	elseif number == 2 then 
	setPedAnimation(testPed,'dancing','dance_loop',-1,true,false,false,false)
	elseif number == 3 then 
	setPedAnimation(testPed,'dancing','DAN_Down_A',-1,true,false,false,false)
	elseif number == 4 then 
	setPedAnimation(testPed,'dancing','DAN_Left_A',-1,true,false,false,false)
	elseif number == 5 then 
	setPedAnimation(testPed,'dancing','DAN_Loop_A',-1,true,false,false,false)
	elseif number == 6 then 
	setPedAnimation(testPed,'dancing','DAN_Right_A',-1,true,false,false,false)
	elseif number == 7 then 
	setPedAnimation(testPed,'dancing','DAN_up_A',-1,true,false,false,false)
	elseif number == 8 then 
	setPedAnimation(testPed,'dancing','dnce_M_a',-1,true,false,false,false)
	elseif number == 9 then 
	setPedAnimation(testPed,'dancing','dnce_M_e',-1,true,false,false,false)
	end
else
	setPedAnimation(testPed,false)
end

end

addEventHandler('onClientGUIClick',root,function()
if source == dancing_button then 
	if guiCheckBoxGetSelected(dancing_button) then 
	dancing(true)
	else
	dancing(false)
	end
else
return 
end

end)
		
		