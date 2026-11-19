local glitches = {"fastfire","hitanim","fastsprint"}
function enableGlitches ()
   for _,glitch in ipairs(glitches) do
      setGlitchEnabled (glitch, true )
   end 
end
addEventHandler ( "onResourceStart", getResourceRootElement ( ),enableGlitches)

backpacks = {
{"Improvised Survivor",12,2275},
{"Survivor",17,2274},
{"Student Survivor",22,2273},
{"Experienced Survivor",27,2272},
{"Alone Survivor",32,2271},
{"Traveler Survivor",37,2270},
{"Hunter Survivor",42,2269},
{"Warrior Survivor",47,2268},
{"Warrior_C Survivor",52,2267},
}

weaponAmmoTable = {
["9mm"] = {{"PDW",28},{"MP5A5",29},},
[".45 ACP"] = {{"P1911",22},{"P92",23},},
["7.62mm"] = {{"AKM",30},{"Kar98k",33},},
["5.56mm"] = {{"M16A4",31},},
["12 Gauge"] = {{"S1897",25},{"S686",27},},
[".300 Magnum"] = {{"Sniper",34},},
["others"] = {{"Granada",16},{"Facão",4},{"Machado",8},{"Pá",6},{"Picareta",2},},}

function getWeaponAmmoType (weaponName,notOthers)
    if not notOthers then
        for i,weaponData in ipairs(weaponAmmoTable["others"]) do
            if weaponName == weaponData[1] then
                return weaponData[1],weaponData[2]
            end
        end
    end    
    for i,weaponData in ipairs(weaponAmmoTable["9mm"]) do
        if weaponName == weaponData[1] then
            return "9mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".45 ACP"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["7.62mm"]) do
        if weaponName == weaponData[1] then
            return "7.62mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56mm"]) do
        if weaponName == weaponData[1] then
            return "5.56mm",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".300 Magnum"]) do
        if weaponName == weaponData[1] then
            return ".300 Magnum",weaponData[2]
        end
    end
    return false
end



Armas = {
['Primarias'] = {
{"AKM"},
{"M16A4"},
{"Sniper"},
{"S1897"},
{"S686"},
{"Kar98k"},
},
['Secundarias'] = {
{"P1911"},
{"P92"},
{"PDW"},
{"MP5A5"},
{"Facão"},
{"Machado"},
{"Pá"},
{"Picareta"},
},
['Especiais'] = {
{"Granada"},
{"Binoculars"},
},
}

function soundHeartBeating()
	x,y,z = getElementPosition(source)
	triggerClientEvent('sound_heart_beatin_C',source,source,x,y,z)
end
addEvent("soundHeartBeating",true)
addEventHandler("soundHeartBeating",getRootElement(),soundHeartBeating)

function soundBackpack()
	x,y,z = getElementPosition(source)
	triggerClientEvent('sound_Backpack',source,x,y,z)
end
addEvent("soundBackpack",true)
addEventHandler("soundBackpack",getRootElement(),soundBackpack)

function SoundCozinhar()
	x,y,z = getElementPosition(source)
	triggerClientEvent('sound_Cozinhar',source,x,y,z)
end
addEvent("SoundCozinhar",true)
addEventHandler("SoundCozinhar",getRootElement(),SoundCozinhar)

function soundBebendo(slot)
	x,y,z = getElementPosition(source)
	triggerClientEvent('sound_Bebendo',source,slot,x,y,z)
end
addEvent("soundBebendo",true)
addEventHandler("soundBebendo",getRootElement(),soundBebendo)

function soundComendo(slot)
	x,y,z = getElementPosition(source)
	triggerClientEvent('sound_Comendo',source,slot,x,y,z)
end
addEvent("soundComendo",true)
addEventHandler("soundComendo",getRootElement(),soundComendo)

function SoundEquipWeapon(slot)
	x,y,z = getElementPosition(source)
	triggerClientEvent('equipWeaponSound',source,slot,x,y,z)
end
addEvent("SoundEquipWeapon",true)
addEventHandler("SoundEquipWeapon",getRootElement(),SoundEquipWeapon)


function rearmPlayerWeapon(weaponName,slot)
  takeAllWeapons(source)
  x,y,z = getElementPosition(source)
  local ammoData,weapID = getWeaponAmmoType(weaponName)
  if getElementData(source,ammoData)<= 0 then
	triggerClientEvent(source,"displayClientInfo",source,"Rearm","Sem munição!",255,22,0)
	return
  end
  setElementData(source,"currentweapon_"..slot,weaponName)
  local weapon = getElementData(source,"currentweapon_1")
  if weapon then
	for id,item in pairs(Armas['Primarias'])do
	  if weapon == item[1] and getElementData(source,item[1])>= 1 then
		local ammoData,weapID = getWeaponAmmoType(weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData),true)
	  end
	end
  end
  local weapon = getElementData(source,"currentweapon_2")
  if weapon then
	for id,item in pairs(Armas['Secundarias'])do
	  if weapon == item[1] and getElementData(source,item[1])>= 1 then
		local ammoData,weapID = getWeaponAmmoType(weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData),true)
	  end
	end
  end
  local weapon = getElementData(source,"currentweapon_3")
  if weapon then
	for id,item in pairs(Armas['Especiais'])do
	  if weapon == item[1] and getElementData(source,item[1])>= 1 then
		local ammoData,weapID = getWeaponAmmoType(weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData),true)
	  end
	end
  end
  if elementWeaponBack[source] then
	detachElementFromBone(elementWeaponBack[source])
	destroyElement(elementWeaponBack[source])
	elementWeaponBack[source] = false
  end  
  if elementWeapon_2Back[source] then
	detachElementFromBone(elementWeapon_2Back[source])
	destroyElement(elementWeapon_2Back[source])
	elementWeapon_2Back[source] = false
  end
  triggerClientEvent(source,"refreshInventoryManual",source)
end
addEvent("onPlayerRearmWeapon",true)
addEventHandler("onPlayerRearmWeapon",getRootElement(),rearmPlayerWeapon)

weaponIDtoObjectID = {
{29,353},
{30,355},
{31,356},
{25,349},
{26,350},
{27,351},
{33,357},
{34,358},
{36,360},
{35,359},
{2,333},
{5,336},
{6,337},
{2,333},
{8,339},
{22,346},
{23,347},
{28,352},
{4,335},
{6,337},
}

function getWeaponObjectID (weaponID)
    for i,weaponData in ipairs(weaponIDtoObjectID) do
        if weaponID == weaponData[1] then
            return weaponData[2]
        end
    end
end    

local elementBackpack = {}
function backPackBack (dataName,oldValue)
    if getElementType(source) == "player" and dataName == "MAX_Slots" then
        local newValue = getElementData(source,dataName)
        if isElement(elementBackpack[source]) then
            destroyElement(elementBackpack[source])
            detachElementFromBone(elementBackpack[source])
            elementBackpack[source] = false
        end
        local x,y,z = getElementPosition(source)
        local rx,ry,rz = getElementRotation(source)
		for i, data in ipairs(backpacks) do
        if newValue == data[2] then
            elementBackpack[source] = createObject(data[3],x,y,z)
        elseif newValue == 8 then
            return
        end
        end
		if newValue == 12 then
            attachElementToBone(elementBackpack[source],source,3,0,0.05,-0.285,0,0,180)
		elseif newValue == 17 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.285,0,0,180)
		elseif newValue == 22 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.27,0,0,180)
		elseif newValue == 27 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 32 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 37 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 42 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 44 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 47 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)
		elseif newValue == 52 then
            attachElementToBone(elementBackpack[source],source,3,0,0.09,-0.275,0,0,180)		
		end
    end
end
addEventHandler ("onElementDataChange", getRootElement(), backPackBack )

local element_helmet = {}
function HelmetChange (dataName,oldValue)
    if getElementType(source) == "player" and dataName == "Capacete_used" then
        local newValue = getElementData(source,'Capacete_used')
        if isElement(element_helmet[source]) then
            destroyElement(element_helmet[source])
            detachElementFromBone(element_helmet[source])
            element_helmet[source] = false
        end
        local x,y,z = getElementPosition(source)
        local rx,ry,rz = getElementRotation(source)
        if newValue == true then
            element_helmet[source] = createObject(2254,x,y,z)  
        end
            attachElementToBone(element_helmet[source],source,1,0.025,-0.125,-0.575,0,11,99)
    end
end
addEventHandler("onElementDataChange",getRootElement(),HelmetChange)

local element_mask = {}
function MaskChange (dataName,oldValue)
    if getElementType(source) == "player" and dataName == "Mask_used" then
        local newValue = getElementData(source,'Mask_used')
        if isElement(element_mask[source]) then
            destroyElement(element_mask[source])
            detachElementFromBone(element_mask[source])
            element_mask[source] = false
        end
        local x,y,z = getElementPosition(source)
        local rx,ry,rz = getElementRotation(source)
        if newValue == true then
            element_mask[source] = createObject(1604,x,y,z)  
		setObjectScale(element_mask[source],1)
        end
            --attachElementToBone(element_mask[source],source,1, 0.002, 0.0585, -0.455, -1, 0, 90)
            attachElementToBone(element_mask[source],source,1, 0.0607, -0.14, -0.575, -5, 12, 90)
    end
end
addEventHandler("onElementDataChange",getRootElement(),MaskChange)

local element_vest = {}
function VestChange (dataName,oldValue)
    if getElementType(source) == "player" and dataName == "Colete_used" then
        local newValue = getElementData(source,'Colete_used')
        if isElement(element_vest[source]) then
            destroyElement(element_vest[source])
            detachElementFromBone(element_vest[source])
            element_vest[source] = false
        end
        local x,y,z = getElementPosition(source)
        local rx,ry,rz = getElementRotation(source)
        if newValue == true then
            element_vest[source] = createObject(1922,x,y,z)
        end
            attachElementToBone(element_vest[source],source,3,0.01,-0.01,-0.175,6.8,0,180)
    end
end
addEventHandler("onElementDataChange",getRootElement(),VestChange)


backpackGround = {}
function backpackOpen ()
if backpackGround[source] and isElement(backpackGround[source]) then
destroyElement(backpackGround[source])
end
if isPedInVehicle(source) then return end
if isElementInWater(source) then return end
local backpackSlots = getElementData(source,"MAX_Slots")
if (backpackSlots == 8) then return end
setPedAnimation (source,"BOMBER","bom_plant_loop",-1,true, false, false, false)
local x,y,z = getElementPosition(source)
local prot = getPedRotation(source)
local offsetRot = math.rad(prot+90)
local vx = x + 0.75 * math.cos(offsetRot)
local vy = y + 0.75 * math.sin(offsetRot)
local vrot = prot+180
for i,data in ipairs (backpacks) do
if backpackSlots == data[2] then
backpackGround[source] = createObject(data[3],vx,vy,z-0.8,100,180,vrot)
end
end
attachElementToBone(backpackGround[source],source,3,0,0.7,0,0.5,0,180)

if elementBackpack[source] and isElement(elementBackpack[source]) then
setElementAlpha(elementBackpack[source],0)
end
end
addEvent("backpackGroundOpen",true)
addEventHandler("backpackGroundOpen",getRootElement(),backpackOpen)


addEvent("backpackGroundClose",true)
addEventHandler("backpackGroundClose",getRootElement(),function()
slots = getElementData(source,"MAX_Slots")

if backpackGround[source] and isElement(backpackGround[source]) then
destroyElement(backpackGround[source])
end
if elementBackpack[source] and isElement(elementBackpack[source]) then
setElementAlpha(elementBackpack[source],255)
end
setPedAnimation(source,false)
end)

function backpackRemoveQuit ()
if backpackGround[source] and isElement(backpackGround[source]) then
destroyElement(backpackGround[source])
end
    if elementBackpack[source] and isElement(elementBackpack[source]) then
        detachElementFromBone(elementBackpack[source])
        destroyElement(elementBackpack[source])
    end    
	if element_helmet[source] and isElement(element_helmet[source]) then
        detachElementFromBone(element_helmet[source])
        destroyElement(element_helmet[source])
    end		
	if element_mask[source] and isElement(element_mask[source]) then
        detachElementFromBone(element_mask[source])
        destroyElement(element_mask[source])
    end	
	if element_vest[source] and isElement(element_vest[source]) then
        detachElementFromBone(element_vest[source])
        destroyElement(element_vest[source])
    end
    if elementWeaponBack[source] then
        detachElementFromBone(elementWeaponBack[source])
        destroyElement(elementWeaponBack[source])    
        elementWeaponBack[source] = false
    end        
	if elementWeapon_2Back[source] then
        detachElementFromBone(elementWeapon_2Back[source])
        destroyElement(elementWeapon_2Back[source])    
        elementWeapon_2Back[source] = false
    end    
end
addEventHandler ( "onPlayerQuit", getRootElement(), backpackRemoveQuit )

elementWeaponBack = {}
function weaponSwitchBack ( previousWeaponID, currentWeaponID )
    local weapon1 = getElementData(source,"currentweapon_1")
    if not weapon1 then return end
    local ammoData1,weapID1 = getWeaponAmmoType(weapon1)
    local x,y,z = getElementPosition(source)
    local rx,ry,rz = getElementRotation(source)
    if previousWeaponID == weapID1 then
        if elementWeaponBack[source] then
            detachElementFromBone(elementWeaponBack[source])
            destroyElement(elementWeaponBack[source])
            elementWeaponBack[source] = false
        end
        elementWeaponBack[source] = createObject(getWeaponObjectID(weapID1),x,y,z)
        setObjectScale(elementWeaponBack[source],0.95)
		slots = getElementData(source,'MAX_Slots')
        if slots == 8 then
            attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.092,0.25,0,55,-180)
        elseif slots == 12 then
            attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.092,0.25,0,55,-180)        
		elseif slots == 17 then
            attachElementToBone(elementWeaponBack[source],source,3,-0.19,-0.092,0.25,180,-70,180)
 		elseif slots == 22 then
            attachElementToBone(elementWeaponBack[source],source,3,0.1,-0.075,0.25,0,65,-180)
		elseif slots == 32 or slots == 37 or slots == 42 or slots == 27 then
            attachElementToBone(elementWeaponBack[source],source,3,0.15,-0.31,-0.1,0,270,-90)		
		elseif slots == 47 then
            attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.092,0.25,0,55,-180)
        else
            attachElementToBone(elementWeaponBack[source],source,3,0.25,-0.31,-0.1,0,270,-90)
        end
    elseif currentWeaponID == weapID1 then
	if isElement(elementWeaponBack[source]) then
        destroyElement(elementWeaponBack[source])
        detachElementFromBone(elementWeaponBack[source])
        elementWeaponBack[source] = false
    end
    end
end
addEventHandler ("onPlayerWeaponSwitch", getRootElement(), weaponSwitchBack )

elementWeapon_2Back = {}
function weaponSwitchBack ( previousWeaponID, currentWeaponID )
    local weapon2 = getElementData(source,"currentweapon_2")
    if not weapon2 then return end
    local ammoData1,weapID1 = getWeaponAmmoType(weapon2)
    local x,y,z = getElementPosition(source)
    local rx,ry,rz = getElementRotation(source)
    if previousWeaponID == weapID1 then
        if elementWeapon_2Back[source] then
            detachElementFromBone(elementWeapon_2Back[source])
            destroyElement(elementWeapon_2Back[source])
            elementWeapon_2Back[source] = false
        end
		if weapID1 == 6  then  -- pá 
        return
		end
        elementWeapon_2Back[source] = createObject(getWeaponObjectID(weapID1),x,y,z)
        setObjectScale(elementWeapon_2Back[source],0.85)
		if weapID1 == 29 then
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.04,0,0.1,-5,285,90) -- mp5
		elseif weapID1 == 2 or weapID1 == 8 then 
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.04,0,0.55,2,180,90) -- machado e picareta
		elseif weapID1 == 4 then 
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.09,0,-0.135,180,-180,90) --Facão
		elseif weapID1 == 28 then  
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.04,0,0.02,2,-90,90) -- pdw
		elseif weapID1 == 22 then  
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.04,0,0.02,2,-90,90) -- p1911
		elseif weapID1 == 23  then 
        attachElementToBone(elementWeapon_2Back[source],source,13,-0.04,0,-0.05,2,-90,90) -- p92
		end
    elseif currentWeaponID == weapID1 then
	if isElement(elementWeapon_2Back[source]) then
        destroyElement(elementWeapon_2Back[source])
        detachElementFromBone(elementWeapon_2Back[source])
        elementWeapon_2Back[source] = false
    end
    end
end
addEventHandler ("onPlayerWeaponSwitch", getRootElement(), weaponSwitchBack )

function removeBackWeaponOnDrop ()
if backpackGround[source] and isElement(backpackGround[source]) then
destroyElement(backpackGround[source])
end
    if elementWeaponBack[source] then
        detachElementFromBone(elementWeaponBack[source])
        destroyElement(elementWeaponBack[source])    
        elementWeaponBack[source] = false
    end    
	if elementWeapon_2Back[source] then
        detachElementFromBone(elementWeapon_2Back[source])
        destroyElement(elementWeapon_2Back[source])    
        elementWeapon_2Back[source] = false
    end
end
addEvent("removeBackWeaponOnDrop",true)
addEventHandler("removeBackWeaponOnDrop",getRootElement(),removeBackWeaponOnDrop)

function removeAttachedOnDeath ()
if backpackGround[source] and isElement(backpackGround[source]) then
destroyElement(backpackGround[source])
end
    if elementBackpack[source] and isElement(elementBackpack[source]) then
        detachElementFromBone(elementBackpack[source])
        destroyElement(elementBackpack[source])
    end    
	if element_vest[source] and isElement(element_vest[source]) then
        detachElementFromBone(element_vest[source])
        destroyElement(element_vest[source])
    end
    if elementWeaponBack[source] then
        detachElementFromBone(elementWeaponBack[source])
        destroyElement(elementWeaponBack[source])    
        elementWeaponBack[source] = false
    end     
	if elementWeapon_2Back[source] then
        detachElementFromBone(elementWeapon_2Back[source])
        destroyElement(elementWeapon_2Back[source])    
        elementWeapon_2Back[source] = false
    end    
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),removeAttachedOnDeath)

function weaponDelete(dataName,oldValue)
    if getElementType(source) == "player" then -- check if the element is a player
        local weapon1 = getElementData(source,"currentweapon_1")
        local weapon2 = getElementData(source,"currentweapon_2")
        local weapon3 = getElementData(source,"currentweapon_3")
        if dataName == weapon1 or dataName == weapon2 or dataName == weapon3 then
            if getElementData (source,dataName) == 0 then
                local ammoData,weapID = getWeaponAmmoType(dataName)
                takeWeapon (source,weapID)
            end
        end
        local weapon1 = getElementData(source,"currentweapon_1")
        local weapon2 = getElementData(source,"currentweapon_2")
        local weapon3 = getElementData(source,"currentweapon_3")
        local ammoData1,weapID1 = getWeaponAmmoType(weapon1)
        local ammoData2,weapID2 = getWeaponAmmoType(weapon2)
        local ammoData3,weapID3 = getWeaponAmmoType(weapon3)
        if dataName == ammoData1 then
            if not oldValue then return end
            local newammo = oldValue - getElementData (source,dataName)
            if newammo == 1 then return end
            if getElementData (source,dataName) < oldValue then
                takeWeapon (source,weapID1,newammo) 
                if elementWeaponBack[source] then
                    detachElementFromBone(elementWeaponBack[source])
                    destroyElement(elementWeaponBack[source])    
                    elementWeaponBack[source] = false
                end                 
				if elementWeapon_2Back[source] then
                    detachElementFromBone(elementWeapon_2Back[source])
                    destroyElement(elementWeapon_2Back[source])    
                    elementWeapon_2Back[source] = false
                end    
            elseif getElementData (source,dataName) > oldValue then
                giveWeapon(source,weapID1,getElementData (source,dataName)-oldValue,true)
            end
        end    
        if dataName == ammoData2 then
            if not oldValue then return end
            local newammo = oldValue - getElementData (source,dataName)
            if newammo == 1 then return end
            if getElementData (source,dataName) < oldValue then
                takeWeapon (source,weapID2,newammo) 
            elseif getElementData (source,dataName) > oldValue then
                giveWeapon(source,weapID2,getElementData (source,dataName)-oldValue,false)
            end
        end    
        if dataName == ammoData3 then
            if not oldValue then return end
            local newammo = oldValue - getElementData (source,dataName)
            if newammo == 1 then return end
            if getElementData (source,dataName) < oldValue then
                takeWeapon (source,weapID3,newammo) 
            elseif getElementData (source,dataName) > oldValue then
                giveWeapon(source,weapID3,getElementData (source,dataName)-oldValue,false)
            end    
        end
    end
end
addEventHandler("onElementDataChange",getRootElement(),weaponDelete)

function addPlayerStats (player,data,value)
    if data == "food" then
        local current = getElementData(player,data)
        if current + value > 100 then
            setElementData(player,data,100)
        elseif     current + value < 1 then
            setElementData(player,data,0)
            setElementData(player,"blood",getElementData(player,"blood")-math.random(50,120))
        else
            setElementData(player,data,current+value)
        end
    elseif data == "thirst" then
        local current = getElementData(player,data)
        if current + value > 100 then
            setElementData(player,data,100)
        elseif     current + value < 1 then
            setElementData(player,data,0)
            setElementData(player,"blood",getElementData(player,"blood")-math.random(50,120))
        else
            setElementData(player,data,current+value)
        end
    elseif data == "blood" then
        local current = getElementData(player,data)
        if current + value > 10000 then
            setElementData(player,data,10000)
        elseif     current + value < 1 then
            setElementData(player,data,0)
        else
            setElementData(player,data,current+value)
        end
    elseif data == "temperature" then
        local current = getElementData(player,data)
        if current + value > 41 then
            setElementData(player,data,41)
        elseif     current + value <= 31 then
            setElementData(player,data,31)
        else
            setElementData(player,data,current+value)
        end
    elseif data == "humanity" then
        local current = getElementData(player,data)
        if current + value > 5000 then
            setElementData(player,data,5000)
        else
            setElementData(player,data,current+value)
        end        
    end
end

function check_level()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
				lvl = getElementData(player,"level")
				experiencia = getElementData(player,"experiencia") 
				experiencia_need = getElementData(player,"experiencia_need")
				if not lvl then outputDebugString(getPlayerName(player)..' levelup com argumentos inválidos (LEVEL) ' ) return end
				if not experiencia then outputDebugString(getPlayerName(player)..' levelup com argumentos inválidos (EXPERIENCIA) ' ) return end
				if not experiencia_need then outputDebugString(getPlayerName(player)..' levelup com argumentos inválidos (EXP_NEED) ' ) return end
				diferenca = -(experiencia_need - experiencia)
				if experiencia >= experiencia_need then
				setElementData(player,"level",lvl+1)
				setElementData(player,"experiencia",diferenca)
				outputChatBox ("Parabéns, "..getPlayerName(player).." por atingir o level: "..lvl+1,root,27, 89, 224,true)    
				end
		end
	end
end
setTimer(check_level,4000,0)

function checkTemperature()
    for i,player in ipairs(getElementsByType("player")) do
        if getElementData(player,"logedin") then
            value = 0
            if getWeather == 7 then 
                value = 0
            elseif getWeather == 12 then
                value = 0
            elseif getWeather == 16 then
                value =0
            elseif getWeather == 4 then
                value = 0
            end
            addPlayerStats (player,"temperature",value)
        end
    end    
end
setTimer(checkTemperature,60000,0)

function checkTemperature2()
    for i,player in ipairs(getElementsByType("player")) do
        if getElementData(player,"logedin") then
            value = 0
            if isElementInWater(player) then
                value = gameplayVariables["temperaturewater"]
            end    
            if getControlState (player,"sprint") then
                value = value+gameplayVariables["temperaturesprint"]
            end
            addPlayerStats (player,"temperature",value)
        end    
    end
end
setTimer(checkTemperature2,10000,0)

function checkThirsty()
for i,player in ipairs(getElementsByType("player")) do
if getElementData(player,"logedin") then
value = 0
	if getControlState (player,"sprint") then
		value = gameplayVariables["sprintthirst"] 
	end	
		addPlayerStats (player,"thirst",value)
end
end
end
setTimer(checkThirsty,10000,0)

function setHunger()
    for i,player in ipairs(getElementsByType("player")) do
        if getElementData(player,"logedin") then
            value = gameplayVariables["loseHunger"]
            addPlayerStats (player,"food",value)
        end    
    end
end
setTimer(setHunger,60000 ,0)

function setThirsty()
    for i,player in ipairs(getElementsByType("player")) do
        if getElementData(player,"logedin") then
            value = gameplayVariables["loseThirst"]
            addPlayerStats (player,"thirst",value)
        end
    end
end
setTimer(setThirsty,60000 ,0)



function onPlayerRequestChangingStats(itemName,itemInfo,data)
    if data == "food" then
        if itemName == "Carne Cozida" then
            blood = 800        
		elseif itemName == "Carne Crua" then
            blood = -800		
		elseif itemName == "Maçã" then
            blood = 500
        end
		playersource = source
		setTimer(function()
        setPedAnimation (playersource,"FOOD","EAT_Burger",-1, false, false, false, false)
		setElementData(playersource,'cant_open_inventory',true)
		end,50,1)
		setTimer(function()
		setElementData(playersource,'cant_open_inventory',false)
		end,3000,1)
        setElementData(source,itemName,getElementData(source,itemName)-1)
        addPlayerStats (source,"blood",blood)
        addPlayerStats (source,data,gameplayVariables["foodrestore"])
    elseif data == "thirst" then
        setElementData(source,itemName,getElementData(source,itemName)-1)
        addPlayerStats (source,data,gameplayVariables["thirstrestore"])
		playersource = source
		setTimer(function()
        setPedAnimation (playersource,"VENDING","VEND_Drink2_P",-1, false, false, false, false) 
		setElementData(playersource,'cant_open_inventory',true)
		end,50,1)
		setTimer(function()
		setElementData(playersource,'cant_open_inventory',false)
		end,3000,1)       
		if itemName == "Garrafa de Água" or itemName == 'Leite' then
            setElementData(source,"Garrafa Vazia",(getElementData(source,"Garrafa Vazia") or 0)+1)
        end
    end
    triggerClientEvent (source, "displayClientInfo", source,"Food","Voce consumiu ["..itemName.."]",22,255,0)
    triggerClientEvent(source,"refreshInventoryManual",source)
end
addEvent("onPlayerRequestChangingStats",true)
addEventHandler("onPlayerRequestChangingStats",getRootElement(),onPlayerRequestChangingStats)

function onPlayerUseMedicObject(itemName)
    local playersource = source
	x,y,z = getElementPosition(playersource)
    setTimer( function ()
	triggerClientEvent('sound_Medic',playersource,x,y,z)
    setPedAnimation (playersource,"BOMBER","BOM_Plant",-1, false, false, false, false)
        if itemName == "Bandagem" then
            setElementData(playersource,"bleeding",0)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        elseif itemName == "Kit Médico" then
            setElementData(playersource,"blood",10000)
            setElementData(playersource,"bleeding",0)
            setElementData(playersource,"brokenbone",false)
            setElementData(playersource,"pain",false)
            setElementData(playersource,"cold",false)
            setElementData(playersource,"temperature",37)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        elseif itemName == "Bolsa Térmica" then
            setElementData(playersource,"cold",false)
            setElementData(playersource,"temperature",37)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        elseif itemName == "Antibiótico" then
            setElementData(playersource,"pain",false)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        elseif itemName == "Morfina" then
            setElementData(playersource,"brokenbone",false)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        elseif itemName == "Primeiros Socorros" then
            addPlayerStats (playersource,"blood",5000)
            setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
        end
    end,50,1)    
    triggerClientEvent(playersource,"refreshInventoryManual",playersource)
end
addEvent("onPlayerUseMedicObject",true)
addEventHandler("onPlayerUseMedicObject",getRootElement(),onPlayerUseMedicObject)

function onPlayerGiveMedicObject(itemName,player)
	playersource = source
    setPedAnimation (playersource,"BOMBER","BOM_Plant",-1, false, false, false, false)
    setTimer(function ()
        if itemName == "Bandagem" then
            setElementData(player,"bleeding",0)
            setElementData(playersource,"Bandagem",getElementData(playersource,"Bandagem")-1)
        elseif itemName == "Primeiros Socorros" then
            addPlayerStats (player,"blood",5000)
            setElementData(playersource,"Primeiros Socorros",getElementData(playersource,"Primeiros Socorros")-1)
        end
    end,1500,1)    
end
addEvent("onPlayerGiveMedicObject",true)
addEventHandler("onPlayerGiveMedicObject",getRootElement(),onPlayerGiveMedicObject)

function onPlayerRefillWaterBottle (itemName)
    if isElementInWater(source) then
        setElementData(source,"Garrafa de Água",getElementData(source,"Garrafa de Água")+1)
        setElementData(source,itemName,getElementData(source,itemName)-1)
        triggerClientEvent(source,"refreshInventoryManual",source)
        triggerClientEvent (source, "displayClientInfo", source,"Garrafa de Água","Voce encheu a garrafa",22,255,0)
    else
        triggerClientEvent (source, "displayClientInfo", source,"Garrafa de Água","Voce precisa estar nadando",255,22,0)
    end    
end
addEvent("onPlayerRefillWaterBottle",true)
addEventHandler("onPlayerRefillWaterBottle",getRootElement(),onPlayerRefillWaterBottle)

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy; 
end

function RemoveObject (object)
blip = getElementData(object,"blip")
	if blip then
			destroyElement(blip)
	end
    destroyElement(getElementData(object,"parent"))
    destroyElement(object)
end
addEvent("RemoveObject",true)
addEventHandler("RemoveObject",getRootElement(),RemoveObject)

function onPlayerPlaceRoadflare (itemName)
    setElementData(source,itemName,getElementData(source,itemName)-1)
    local x,y,z = getElementPosition(source)
    local object = createObject(354,x,y,z-0.6)
    setTimer(destroyElement,300000,1,object)
    triggerClientEvent(source,"refreshInventoryManual",source)
end
addEvent("onPlayerPlaceRoadflare",true)
addEventHandler("onPlayerPlaceRoadflare",getRootElement(),onPlayerPlaceRoadflare)

function onPlayerUseDefenseObject (itemName)
if itemName == 'Capacete' then
    setElementData(source,'Capacete_used',not getElementData(source,'Capacete_used'))
end
if itemName == 'Máscara de Gás' then
    setElementData(source,'Mask_used',not getElementData(source,'Mask_used'))
end
if itemName == 'Colete' then
    setElementData(source,'Colete_used',not getElementData(source,'Colete_used'))
end
    triggerClientEvent(source,"refreshInventoryManual",source)
end
addEvent("onPlayerUseDefenseObject",true)
addEventHandler("onPlayerUseDefenseObject",getRootElement(),onPlayerUseDefenseObject)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

local chatRadius = 15 
function sendMessageToNearbyPlayers( message, messageType )
cancelEvent()
    if (messageType == 0) then
        local posX, posY, posZ = getElementPosition( source )
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
            outputChatBox("[LOCAL]"..string.gsub((getPlayerName(source).." : "..message), '#%x%x%x%x%x%x', ''),nearbyPlayer, 255,255,255,true ) -- Color changed from 60,200,40 to 211,211,211
        end
    end    
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )


local infoTimer = 60000

function outputInfo1 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info","O botao 'TAB' abre o Inventario.",200,200,22)
    end
    setTimer(outputInfo2,infoTimer,1)
end
setTimer(outputInfo1,infoTimer,1)

function outputInfo2 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info","O botao 'B' abre o menu de Craft.",200,200,22)
    end
    setTimer(outputInfo3,infoTimer,1)
end

function outputInfo3 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info","Visite: http://fb.com/StoneAgeMTA",200,200,22)
    end
    setTimer(outputInfo4,infoTimer,1)
end

function outputInfo4 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info","O botão 'F1' abre as Configurações.",200,200,22)
    end
    setTimer(outputInfo5,infoTimer,1)
end

function outputInfo5 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info",'Leia as regras. (F4)',200,200,22)
    end
    setTimer(outputInfo6,infoTimer,1)
end

function outputInfo6 ()
    for i, player in ipairs(getElementsByType("player")) do
        triggerClientEvent (player, "displayClientInfo", player,"Info",'incluindo a cama.',200,200,22)
        triggerClientEvent (player, "displayClientInfo", player,"Info",'destroi todos os seus itens de base',200,200,22)
        triggerClientEvent (player, "displayClientInfo", player,"Info",'O comando /resetbase',200,200,22)
    end
    setTimer(outputInfo1,infoTimer,1)
end


--player Wildcard
function getPlayerWildcard(namePart)
    namePart = string.lower(namePart)
 
    local bestaccuracy = 0
    local foundPlayer, b, e
    for _,player in ipairs(getElementsByType("player")) do
        b,e = string.find(string.lower(string.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "")), namePart)
        if b and e then
            if e-b > bestaccuracy then
                bestaccuracy = e-b
                foundPlayer = player
            end
        end
    end
    
    if (foundPlayer) then
        return foundPlayer
    else
        return false
    end
end

function setGroup (playersource,command,teamName,targetString)
    if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
        local foundTargetPlayer = getPlayerWildcard(targetString)
        if (foundTargetPlayer) then
            if teamName == "admin" or teamName == "supporter" or teamName == "remove" then 
            else
                outputChatBox ("#FFFFFFsyntax = /add (admin/supporter/remove) nome",playersource,27, 89, 224,true)    
                return
            end
            if teamName == "remove" then
                value = false
                account = getPlayerAccount(foundTargetPlayer)
                setAccountData(account,"admin",value)
                setAccountData(account,"supporter",value)
                setElementData(foundTargetPlayer,"admin",value)
                setElementData(foundTargetPlayer,"supporter",value)
            else
                value = true
            end
            account = getPlayerAccount(foundTargetPlayer)
            accountname = getAccountName(account)
            setAccountData(account,teamName,value)
            setElementData(foundTargetPlayer,teamName,value)
        else
            outputChatBox ("#FFFFFFJogador nao encontrado!",playersource,255, 0, 0,true)        
        end
    else
        outputChatBox ("#FFFFFFVocê não é admin!",playersource,255, 0, 0,true)        
    end
end
addCommandHandler("add",setGroup)

function banPLayer (playersource,command,targetString,banTime,reason)
    if getAccountData(getPlayerAccount(playersource),"admin") == true  then
        local foundTargetPlayer = getPlayerWildcard(targetString)
        local banTime = banTime or 0
        local reason = reason or "Unknown"
        if (foundTargetPlayer) then
            local account = getPlayerAccount()
            local ip = getPlayerIP(foundTargetPlayer)
            local serial = getPlayerSerial(foundTargetPlayer)
            local name = getPlayerName(foundTargetPlayer)
            kickPlayer(foundTargetPlayer,playersource,reason)
            addBan (ip,name,serial,playersource,reason,banTime*86400)
            outputChatBox ("#FFFFFF"..name.." #FF0000 foi banido por  "..banTime.." ",getRootElement(),27, 89, 224,true)
        else
            outputChatBox ("FFFFFFJogador nao encontrado!",playersource,27, 89, 224,true)        
        end
    else
        outputChatBox ("#FFFFFFVocê não é admin!",playersource,27, 89, 224,true)        
    end
end
addCommandHandler("playerban",banPLayer)

function pmsgAdmin (playersource,command,...)
    local msg = table.concat({...}, " ")
    if getAccountData(getPlayerAccount(playersource),"admin") == true  then
        outputChatBox ("[ADMIN]: "..getPlayerName(playersource)..": "..msg,getRootElement(),60,200,40,true)    
    else
        outputChatBox ("#FFFFFFVocê não é admin! ",playersource,27, 89, 224,true)        
    end
end
addCommandHandler("pmsg",pmsgAdmin)

function kickAll (playersource,command,reason)
    if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
        for i, player in ipairs(getElementsByType("player")) do
            if player == playersource then break end 
			if not reason then reason = 'Restart para hotfix no servidor' end
            kickPlayer(player,reason)
        end
    else
        outputChatBox ("#FFFFFFVocê não é admin!!",playersource,255, 0, 0,true)        
    end
end
addCommandHandler("kickall",kickAll)

--Pingkick
function kickPlayerOnHighPing ()
    outputChatBox (getPlayerName(source).." foi expulso por ter ping muito alto!",getRootElement(),27, 89, 224,true)    
    kickPlayer(source,"Perca de conexão.")
end
addEvent("kickPlayerOnHighPing",true)
addEventHandler("kickPlayerOnHighPing", getRootElement(),kickPlayerOnHighPing)

local handsUp = false
local siting = false
local lying = false
local apontando = false
local bye = false

function funcBye ( player, key, keyState )
    if lying or siting or handsUp or apontando or bye  then
        setPedAnimation (player,false)
        lying = false
        siting = false
        handsUp = false
        apontando = false
        bye = false
    else
	if getElementData(player,'inAnimation') then return end
        if isPedInVehicle (player) then return end
        apontando = true
		setPedAnimation(player, "ped", "endchat_03", -1, true, false, false, false)
		
    end    
end

function funcApontar ( player, key, keyState )
    if lying or siting or handsUp or apontando or bye  then
        setPedAnimation (player,false)
        lying = false
        siting = false
        handsUp = false
        apontando = false
        bye = false
    else
	if getElementData(player,'inAnimation') then return end
        if isPedInVehicle (player) then return end
        apontando = true
		setPedAnimation(player, "ped", "gang_gunstand", -1, true, false, false, false)
    end    
end

function funcBindHandsup ( player, key, keyState )
    if lying or siting or handsUp or apontando or bye  then
        setPedAnimation (player,false)
        lying = false
        siting = false
        handsUp = false
		apontando = false
		bye = false
    else
	if getElementData(player,'inAnimation') then return end
        if isPedInVehicle (player) then return end
        handsUp = true
		setPedAnimation(player, "BEACH", "ParkSit_M_loop", -1, true, false, false, false)

    end    
end

function funcBindSit ( player, key, keyState )
    if lying or siting or handsUp or apontando or bye  then
        setPedAnimation (player,false)
        lying = false
        siting = false
        handsUp = false
		apontando = false
		bye = false
    else
        if isPedInVehicle (player) then return end
		if getElementData(player,'inAnimation') then return end
        setPedAnimation (player,"SHOP","SHP_Rob_HandsUp",-1,true,false,false,false)
        siting = true
    end    
end

function funcBindLie ( player, key, keyState )
    if lying or siting or handsUp or apontando or bye  then
        setPedAnimation (player,false)
        lying = false
        siting = false
        handsUp = false
		apontando = false
		bye = false
    else
    if isPedInVehicle (player) then return end
	if getElementData(player,'inAnimation') then return end
        setPedAnimation (player,"ped","FLOOR_hit_f", -1,false,false,false,true)
        lying = true
    end
end
 
function bindTheKeys ()
  bindKey(source,",","down",funcBindHandsup)
  bindKey(source,".","down",funcBindSit)
  bindKey(source,"l","down",funcBindLie)
  bindKey(source,";","down",funcApontar)
  bindKey(source,"/","down",funcBye)
end
addEventHandler("onPlayerLogin", getRootElement(), bindTheKeys)

for id, player in ipairs(getElementsByType("player")) do
  bindKey(player,",","down",funcBindHandsup)
  bindKey(player,".","down",funcBindSit)
  bindKey(player,"l","down",funcBindLie)
  bindKey(player,";","down",funcApontar)
  bindKey(player,"/","down",funcBye)
end

function makeRadioStayOff()
    setRadioChannel(0)
    cancelEvent()
end
addEventHandler("onClientPlayerVehicleEnter",getRootElement(),makeRadioStayOff)
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)

function onPlayerPlaceTimeBomb (player,hitElement)
local col = getElementData(player,"currentCol")
if getElementData(player,'Bomba Relógio') and getElementData(player,'Bomba Relógio') >=1 then
setElementData(player,'Bomba Relógio',getElementData(player,'Bomba Relógio')-1)
setElementData(player,'experiencia',getElementData(player,'experiencia')+math.random(40,50))
setPedAnimation (player,"BOMBER","BOM_Plant",-1, false, false, false, false)
local x,y,z = getElementPosition(hitElement)
 outputChatBox("Bomba plantada.",player,255,255,0)
 outputChatBox("Você tem 5 segundos para sair de perto.",player,255,255,0)
setTimer( function ()
createExplosion(x,y,z,11)
damage = math.random(200,300)
setElementData(col,'health',getElementData(col,'health')-damage)
setElementData(hitElement,'health',getElementData(hitElement,'health')-damage)
if getElementData(col,'health') <= 0 then
triggerEvent("onObjectDestroy",root,hitElement,getElementData(hitElement,"bc.ID"))
end
end,5000,1)
else
outputChatBox('Você não tem Bomba Relógio.',player,255,0,0)
end
end
addEvent("onPlayerPlaceTimeBomb",true)
addEventHandler("onPlayerPlaceTimeBomb",getRootElement(),onPlayerPlaceTimeBomb)

weaponProperty = { -- testar distancias depois
{28,'maximum_clip_ammo',25},--pdw
{28,'accuracy',0.15},--pdw
{28,'weapon_range',75},--pdw

{29,'maximum_clip_ammo',25},--mp5
{29,'accuracy',0.15},--mp5
{29,'weapon_range',100},--mp5

{31,'maximum_clip_ammo',20},--m16a4
{31,'accuracy',0.15},--m16a4
{31,'weapon_range',250},--m16a4

{30,'maximum_clip_ammo',30},--akm
{30,'accuracy',0.1},--akm
{30,'weapon_range',200},--akm
{30,'flags',0x000010},--akm
{30,'flags',0x000020},--akm

{25,'maximum_clip_ammo',7},--S1897
{25,'weapon_range',50},--S1897
{25,'accuracy',0.5},--akm

{34,'weapon_range',300},--Sniper
{33,'weapon_range',300},--kar98k

{27,'maximum_clip_ammo',7},--S686
{27,'weapon_range',50},--S686
{27,'accuracy',0.5},--S686

{22,'maximum_clip_ammo',10},--P1911
{22,'weapon_range',75},--P1911
{22,'accuracy',0.25},--P1911

{23,'maximum_clip_ammo',10},--P92
{23,'weapon_range',75},--P92
{23,'accuracy',0.25},--P92
}

for i, data in ipairs(weaponProperty) do
setWeaponProperty(data[1],"poor",data[2],data[3])
setWeaponProperty(data[1],"std",data[2],data[3])
setWeaponProperty(data[1],"pro",data[2],data[3])
end

function anim_brokenbone(player)
if getElementData(player,'inAnimation') then return end
setPedAnimation(player,'ped','getup',-1,false,false,false,false)
end
addEvent('anim_brokenbone',true)
addEventHandler('anim_brokenbone',root,anim_brokenbone)