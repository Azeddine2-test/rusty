--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchRadialBlur", root, true )
--
--	To switch off:
--			triggerEvent( "switchRadialBlur", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start


--------------------------------
-- Command handler
--		Toggle via command
--------------------------------
addCommandHandler( "radialblur",
	function()
		triggerEvent( "switchRadialBlur", localPlayer, not bEffectEnabled )
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchRadialBlur( bOn )
	--outputDebugString( "switchRadialBlur: " .. tostring(bOn) )
	if bOn then
		enableRadialBlur()
	else
		disableRadialBlur()
	end
end
addEvent( "switchRadialBlur", true )
addEventHandler( "switchRadialBlur", root, switchRadialBlur )

