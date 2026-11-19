function loadAddons( res )
	for resourceKey, resourceValue in ipairs(getResources()) do
	local name = getResourceName(resourceValue)
	if string.find(name,"addon_Npc") then
		setTimer(startResource,50,1,resourceValue)
	end
end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadAddons )

function unloadAddons ( res )
	for resourceKey, resourceValue in ipairs(getResources()) do
	local name = getResourceName(resourceValue)
	if string.find(name,"addon_Npc") then
		stopResource(resourceValue)
	end
end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), unloadAddons )



function checkSetTime()
    local realtime = getRealTime()
    setMinuteDuration(60000)
	setTrafficLightState(9)
end
setTimer(checkSetTime,60000,0)
checkSetTime()


function Weather (hour,minutes)
	local hour, minutes = getTime()
	--setFarClipDistance(400)        
	setFarClipDistance(400)        
	setFogDistance(-10)
	setSkyGradient( 88,101,105, 88,101,105 )
	setWeather(4)
end
addCommandHandler ( "unbugtime", Weather )
setTimer(Weather,3500000,0)
Weather()
addEventHandler("onPlayerLogin", getRootElement(), Weather)
addEventHandler("onPlayerJoin", getRootElement(), Weather)