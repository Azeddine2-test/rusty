





addEvent("onPlayerDeleteSpawnPoints", true)
function deleteSpawnPoint(player, nome)
    if fileExists("spawns/"..tostring(nome)..".txt") then
       if fileDelete("spawns/"..tostring(nome)..".txt") then
       outputChatBox("#00a5ff* Item [#ff0000"..tostring(nome)..".txt#00a5ff] Deletado com Sucesso !", player, 0, 0, 0, true)
       end
    else
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
    end
end
addEventHandler("onPlayerDeleteSpawnPoints", getRootElement(), deleteSpawnPoint)

addEvent("onPlayerCreateSpawnPointPlantas", true)
function spawnPoint_Plantas(player, x, y, z)
    if fileExists("spawns/Plantas.txt") then
        hFile = fileOpen("spawns/Plantas.txt")
    else
        hFile = fileCreate("spawns/Plantas.txt")     
    end
    
    fileSetPos(hFile, fileGetSize(hFile))   
    
    if fileWrite(hFile, "{"..tostring(x)..","..tostring(y)..","..tostring(z).."},\r\n") then
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
	    blip = createBlip ( x,y,z, 0, 1, 255,255,0, 255, 0, 170,getRootElement() ) --33,94,33 = verde		
    end
    
    fileClose(hFile)
end
addEventHandler("onPlayerCreateSpawnPointPlantas", getRootElement(), spawnPoint_Plantas)

addEvent("onPlayerCreateSpawnPointRAROS", true)
function spawnPoint_RAROS(player, x, y, z)
    if fileExists("spawns/RAROS.txt") then
        hFile = fileOpen("spawns/RAROS.txt")
    else
        hFile = fileCreate("spawns/RAROS.txt")     
    end
    fileSetPos(hFile, fileGetSize(hFile))  
    if fileWrite(hFile, "{"..tostring(x)..","..tostring(y)..","..tostring(z).."},\r\n") then
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
	   -- blip = createBlip ( x,y,z, 0, 1, 255,255,255, 255, 0, 255,getRootElement() ) --33,94,33 = verde
	theMarker = createMarker ( x, y, z-1, "cylinder", 1.5, 0, 0, 0, 255)

	blip = createBlip ( x,y,z, 0, 1, 0,0,0, 255, 0, 170,getRootElement() ) --33,94,33 = verde		

    end 
    
     fileClose(hFile)    
end
addEventHandler("onPlayerCreateSpawnPointRAROS", getRootElement(), spawnPoint_RAROS)

addEvent("onPlayerCreateSpawnPointMilitary", true)
function spawnPoint_Military(player, x, y, z)
    if fileExists("spawns/military.txt") then
        hFile = fileOpen("spawns/military.txt")
    else
        hFile = fileCreate("spawns/military.txt")     
    end
    
    fileSetPos(hFile, fileGetSize(hFile))  
    
    if fileWrite(hFile, "{"..tostring(x)..","..tostring(y)..","..tostring(z).."},\r\n") then
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
    end
  
     fileClose(hFile)  
end
addEventHandler("onPlayerCreateSpawnPointMilitary", getRootElement(), spawnPoint_Military)

addEvent("onPlayerCreateSpawnPointPedras", true)
function spawnPoint_Pedras(player, x, y, z)
    if fileExists("spawns/Pedras.txt") then
        hFile = fileOpen("spawns/Pedras.txt")
    else
        hFile = fileCreate("spawns/Pedras.txt")     
    end
    
    fileSetPos(hFile, fileGetSize(hFile))  
    	    blip = createBlip ( x,y,z, 0, 1, 255,255,33, 255, 0, 170,getRootElement() ) --33,94,33 = verde

    if fileWrite(hFile, "{"..tostring(x)..","..tostring(y)..","..tostring(z).."},\r\n") then
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
    end
 
     fileClose(hFile)     
end
addEventHandler("onPlayerCreateSpawnPointPedras", getRootElement(), spawnPoint_Pedras)

addEvent("onPlayerCreateSpawnPointSupermarket", true)
function spawnPoint_Supermarket(player, x, y, z)
    if fileExists("spawns/supermarket.txt") then
        hFile = fileOpen("spawns/supermarket.txt")
    else
        hFile = fileCreate("spawns/supermarket.txt")     
    end
    
    fileSetPos(hFile, fileGetSize(hFile))  
    
    if fileWrite(hFile, "{"..tostring(x)..","..tostring(y)..","..tostring(z).."},\r\n") then
		outputChatBox("{"..tostring(x)..","..tostring(y)..","..tostring(z).."},",player)
    end
    
     fileClose(hFile)      
end
addEventHandler("onPlayerCreateSpawnPointSupermarket", getRootElement(), spawnPoint_Supermarket)