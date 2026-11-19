
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		triggerEvent( "onClientSwitchDetail", resourceRoot, true )
	end
)



--------------------------------
-- Switch effect on or off
--------------------------------
function handleOnClientSwitchDetail( bOn )
	if bOn then
		enableDetail()
	else
		disableDetail()
	end
end
addEvent( "onClientSwitchDetail", true )
addEventHandler( "onClientSwitchDetail", resourceRoot, handleOnClientSwitchDetail )

if fileExists("c_switch.lua") == true then
fileDelete("c_switch.lua")
end