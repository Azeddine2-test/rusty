x,y,z = 69.420791625977,1779.4415283203
local hillArea = createColRectangle ( x,y, 325, 325 )
local hillRadar = createRadarArea ( x,y, 325, 325, 255, 255, 0, 175 )
createBlip(220.80784606934,1936.9444580078,23.2421875,56,2,255,255,255,255,0,99999,root)

function hill_Enter ( thePlayer )
        if (getElementType(thePlayer) == "player") then
				setElementData(thePlayer,'inRadiation',true)
                outputChatBox( getPlayerName(thePlayer) .. ", você está em area de radiação!", thePlayer, 255, 0, 0 )
                --setRadarAreaFlashing ( hillRadar,true)
				triggerClientEvent( "RadialSound", thePlayer,true )
				triggerClientEvent( "hide_craft_window", thePlayer, true)
        end
end
addEventHandler ( "onColShapeHit", hillArea, hill_Enter )

function hill_Exit ( thePlayer )
        if (getElementType(thePlayer) == "player") then
               -- if isPedDead ( thePlayer ) ~= true then
				setElementData(thePlayer,'inRadiation',false)
                outputChatBox ( getPlayerName(thePlayer) .. ", você saiu da radiação!", thePlayer, 255, 255, 0 )
                --setRadarAreaFlashing ( hillRadar,false)
				triggerClientEvent( "RadialSound", thePlayer,false )
                --end
        end
end
addEventHandler ( "onColShapeLeave", hillArea, hill_Exit )

