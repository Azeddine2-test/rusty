animals = {
}

function spawnDayZAnimals()
    for i,animal in ipairs(animals) do
        local x,y,z = animal[1],animal[2],animal[3]
local ped = createPed(12,x,y,z)
setElementData(ped,"animal",true)
    end
end    

spawnDayZAnimals()

function destroyDeadAnimalAndRespawn (ped,pedCol,x,y,z)
    destroyElement(ped)
    destroyElement(pedCol)
	ped  = createPed(12,x,y,z)
    setElementData(ped,"animal",true)
end

function createDeadAnimal()
    local x,y,z = getElementPosition(source)
    local skin = getElementModel(source)
ped = createPed(12,x,y,z)
	rx,ry,rz = getElementRotation(ped)
setElementRotation(ped,rx+50,ry,rz)
killPed(ped)
    local pedCol = createColSphere(x,y,z,1.5)
    setElementData(pedCol,"parent",ped)
    setElementData(pedCol,"playername","Animal")
    setElementData(pedCol,"deadman",true)
    setElementData(pedCol,"MAX_Slots",8)

    if getElementModel(source) == 12 then
        setElementData(pedCol,"Raw Meat",8)
    elseif getElementModel(source) == 13 then
        setElementData(pedCol,"Raw Meat",4)
    elseif getElementModel(source) == 14 then
        setElementData(pedCol,"Raw Meat",2)    
    end
    destroyElement(source)
    setTimer(destroyDeadAnimalAndRespawn,5000,1,ped,pedCol,x,y,z)
end
addEvent("createDeadAnimal",true)
addEventHandler ( "createDeadAnimal",getRootElement(),createDeadAnimal)