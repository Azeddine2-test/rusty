

outputChatBox ( "Pressione M para usar o chat global." , 255, 255, 255, true )
bindKey("m", "down", "chatbox", "GlobalChat")
bindKey("y", "down", "chatbox", "GroupChat")
bindKey("i", "down", "chatbox", "AdminChat")


if fileExists("chat_client.lua") == true then
fileDelete("chat_client.lua")
end

