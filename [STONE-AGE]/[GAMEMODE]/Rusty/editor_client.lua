gameplayVariables = {}
    gameplayVariables["ping"] = 600 
    gameplayVariables["zombiedamage"] = math.random(400,900) 

damageTable = {
{"AKM",3755},
{"M16A4",3500},
{"Sniper",99999},
{"S1897",4500},
{"S686",3000},
{"Kar98k",9000},
{"P1911",1200},
{"P92",1350},
{"PDW",1500},
{"MP5A5",1750},
{"Facão",1000},
{"Machado",1000},
{"Pá",1000},
{"Picareta",1000},
{"Granada",100000},
}

vehiclesTable = {
--{'nome', id, tire,engine,tank, maxfuel} 
{'Picape', 422, 4,1,1, 80},
{'Alpha', 602, 4,1,1, 65},
{'Ninja', 522, 2,1,1, 35},
{'Combi', 483, 4,1,1, 85},
{'Ambulancia', 416, 4,1,1, 75},
{'Bike', 481, 0,0,0, 0},
{'Family', 400, 4,1,1, 70},
{'Lamborghini', 411, 4,1,1, 70},
{'Harley', 463, 2,1,1, 50},
{'Caminhao', 433, 6,1,1, 100},
{'Policia', 461, 2,1,1, 50},
}

function getVehicleNameStoneAge(id)
	for i, data in ipairs(vehiclesTable) do
		if id == data[2] then
			return data[1]
		end
	end
end

function getVehicleMaxFuel(loot)
    local modelID = getElementModel(getElementData(loot,"parent"))
    for i,data in ipairs(vehiclesTable) do
        if modelID == data[2] then
             return data[6]
        end
    end
    return false
end

function getVehicleAddonInfos (id)
    for i,data in ipairs(vehiclesTable) do
        if data[2] == id then
            return data[3],data[4], data[5]
        end
    end
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
     if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
          local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
          if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
               for i, v in ipairs( aAttachedFunctions ) do
                    if v == func then
        	         return true
        	    end
	       end
	  end
     end
     return false
end

if fileExists("editor_client.lua") == true then
fileDelete("editor_client.lua")
end
