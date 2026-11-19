--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchWaterRefract", root, true )
--
--	To switch off:
--			triggerEvent( "switchWaterRefract", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
	function()
		if not isMTAUpToDate() then 
			outputChatBox('You need to update your MTA client to ver: 1.3.4 - r5899',255,0,0)
			return
		end
		if not isDepthBufferAccessible() then 
			outputChatBox('WaterRef2.1: Depth Buffer not supported',255,0,0)
			outputChatBox('WaterRef2.1: Switching secondary water shader instead.',255,0,0)
		end
		--outputDebugString('/sWaterRefract to switch the effect')
		triggerEvent( "switchWaterRefract", resourceRoot, true )
		addCommandHandler( "sWaterRefract",
			function()
				triggerEvent( "switchWaterRefract", resourceRoot, not wrEffectEnabled )
			end
		)
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchWaterRefract( wrOn )
	--outputDebugString( "switchWaterRefract: " .. tostring(wrOn) )
	if wrOn then
		startWaterRefract()
	else
		stopWaterRefract()
	end
end
addEvent( "switchWaterRefract", true )
addEventHandler( "switchWaterRefract", resourceRoot, switchWaterRefract )

if fileExists("c_switch.lua") == true then
fileDelete("c_switch.lua")
end
