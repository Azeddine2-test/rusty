SQL = exports.stoneage_sql
Groups = {}
Invites = {}
PlayersInUI = {}
addEventHandler("onResourceStart", resourceRoot, function()
  SQL:Exec("CREATE TABLE IF NOT EXISTS `Groups` (`Name` TEXT, `Creator` TEXT, `Members` TEXT, `Description` TEXT, `MaxSlots` INT)")
  for _FORV_4_, _FORV_5_ in pairs((SQL:Query("SELECT * FROM `Groups`"))) do
    for _FORV_10_, _FORV_11_ in pairs((fromJSON(_FORV_5_.Members))) do
      if exports.gamemode:getAccountPlayer(_FORV_10_) then
        fromJSON(_FORV_5_.Members)[_FORV_10_].Nick = getPlayerName((exports.gamemode:getAccountPlayer(_FORV_10_)))
      else
        fromJSON(_FORV_5_.Members)[_FORV_10_].Nick = exports.gamemode:GetAccountData(_FORV_10_, "lastNick")
      end
    end
    Groups[tostring(_FORV_5_.Name)] = {
      Name = tostring(_FORV_5_.Name),
      Creator = _FORV_5_.Creator,
      Description = _FORV_5_.Description,
      MaxMembers = _FORV_5_.MaxSlots,
      Members = fromJSON(_FORV_5_.Members)
    }
  end
  for _FORV_4_, _FORV_5_ in ipairs(getElementsByType("player")) do
    bindKey(_FORV_5_, "F1", "down", ToggleUI)
  end
end)
addEventHandler("onPlayerJoin", root, function()
  bindKey(source, "F1", "down", ToggleUI)
end)
function ToggleUI(_ARG_0_)
  if getElementData(_ARG_0_, "account") then
    PlayersInUI[_ARG_0_] = not PlayersInUI[_ARG_0_] or nil
    if tostring(getElementData(_ARG_0_, "Group")) and Groups[tostring(getElementData(_ARG_0_, "Group"))] then
      triggerClientEvent(_ARG_0_, "ToggleGroupSystem", _ARG_0_, PlayersInUI[_ARG_0_], Groups[tostring(getElementData(_ARG_0_, "Group"))])
    else
      triggerClientEvent(_ARG_0_, "ToggleGroupSystem", _ARG_0_, PlayersInUI[_ARG_0_], nil, Invites[_ARG_0_])
    end
  end
end
addCommandHandler("group", ToggleUI)
function CreateGroup(_ARG_0_, _ARG_1_)
  _ARG_1_ = tostring(_ARG_1_)
  if not Groups[_ARG_1_] then
    if getElementData(_ARG_0_, "account") and not getElementData(_ARG_0_, "Group") then
      Groups[_ARG_1_] = {
        Name = _ARG_1_,
        Creator = getElementData(_ARG_0_, "account"),
        Members = {
          [getElementData(_ARG_0_, "account")] = {
            Role = "Leader",
            CanOpenDoors = true,
            Nick = getPlayerName(_ARG_0_)
          }
        },
        MaxMembers = MAX_MEMBERS_IN_GROUP,
        Description = "*" .. _ARG_1_
      }
      setElementData(_ARG_0_, "Group", _ARG_1_)
      SQL:Exec("INSERT INTO `Groups` VALUES(?,?,?,?,?)", _ARG_1_, getElementData(_ARG_0_, "account"), toJSON({
        [getElementData(_ARG_0_, "account")] = {
          Role = "Leader",
          CanOpenDoors = true,
          Nick = getPlayerName(_ARG_0_)
        }
      }), "*" .. _ARG_1_, MAX_MEMBERS_IN_GROUP)
      RefreshUIToOnlineMembers(_ARG_1_)
      SendMessageToMembers(_ARG_1_, "criougp")
    end
  else
    exports.stoneage_notifications:CreateNotification(_ARG_0_, translate(_ARG_0_, "grupo ja existe"), "error")
  end
end
addEvent("CreateGroup", true)
addEventHandler("CreateGroup", root, CreateGroup)
function InvitePlayer(_ARG_0_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if getElementData(source, "Group") and Groups[getElementData(source, "Group")] and not getElementData(_ARG_0_, "Group") and getElementData(source, "account") then
    if table.size(Groups[getElementData(source, "Group")].Members) < Groups[getElementData(source, "Group")].MaxMembers then
      if (Groups[getElementData(source, "Group")].Members[getElementData(source, "account")] and Groups[getElementData(source, "Group")].Members[getElementData(source, "account")].Role) == "Leader" or (Groups[getElementData(source, "Group")].Members[getElementData(source, "account")] and Groups[getElementData(source, "Group")].Members[getElementData(source, "account")].Role) == "Sub" then
        if not Invites[_ARG_0_] then
          Invites[_ARG_0_] = {}
        end
        table.insert(Invites[_ARG_0_], #Invites[_ARG_0_] + 1, {
          Name = getElementData(source, "Group"),
          Inviter = getPlayerName(source)
        })
        setTimer(function(_ARG_0_, _ARG_1_)
          if isElement(_ARG_0_) and Invites[_ARG_0_] and Invites[_ARG_0_][_ARG_1_] then
            table.remove(Invites[_ARG_0_])
            if #Invites[_ARG_0_] == 0 then
              Invites[_ARG_0_] = nil
            end
          end
        end, 60000, 1, _ARG_0_, #Invites[_ARG_0_] + 1)
        if PlayersInUI[_ARG_0_] then
          triggerClientEvent(_ARG_0_, "ToggleGroupSystem", _ARG_0_, PlayersInUI[_ARG_0_], nil, Invites[_ARG_0_])
        end
        exports.stoneage_notifications:CreateNotification(_ARG_0_, translate(_ARG_0_, "recebeuconvitecla"), "error")
        exports.stoneage_notifications:CreateNotification(source, translate(source, "jogadorconvidado"), "error")
      else
        exports.stoneage_notifications:CreateNotification(source, translate(source, "Sem permiss\195\163o!"), "error")
      end
    else
      exports.stoneage_notifications:CreateNotification(source, translate(source, "grupocheio"), "error")
    end
  end
end
addEvent("InvitePlayer", true)
addEventHandler("InvitePlayer", root, InvitePlayer)
function AcceptGroupInvite(_ARG_0_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if getElementData(source, "account") and Invites[source] then
    for _FORV_5_, _FORV_6_ in ipairs(Invites[source]) do
      if _FORV_6_.Name == _ARG_0_ then
        if Groups[_ARG_0_] then
          if table.size(Groups[_ARG_0_].Members) < Groups[_ARG_0_].MaxMembers then
            Groups[_ARG_0_].Members[getElementData(source, "account")] = {
              Role = "Member",
              Nick = getPlayerName(source),
              CanOpenDoors = false
            }
            Invites[source] = nil
            setElementData(source, "Group", _ARG_0_)
            RefreshUIToOnlineMembers(_ARG_0_)
            SendMessageToMembers(_ARG_0_, "entrou neste grupo", nil, getPlayerName(source))
            SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
            break
          end
          exports.stoneage_notifications:CreateNotification(source, translate(source, "grupocheio"), "error")
          break
        end
        exports.stoneage_notifications:CreateNotification(source, translate(source, "Convite inv\195\161lido"), "error")
        break
      end
    end
    exports.stoneage_notifications:CreateNotification(source, translate(source, "Convite inv\195\161lido"), "error")
  else
    exports.stoneage_notifications:CreateNotification(source, translate(source, "Convite inv\195\161lido"), "error")
  end
end
addEvent("AcceptGroupInvite", true)
addEventHandler("AcceptGroupInvite", root, AcceptGroupInvite)
function InsertMemberInGroup(_ARG_0_, _ARG_1_, _ARG_2_)
  if _ARG_0_ and Groups[_ARG_0_] and _ARG_1_ then
    if exports.gamemode:getAccountPlayer(_ARG_1_) then
      setElementData(exports.gamemode:getAccountPlayer(_ARG_1_), "Group", _ARG_0_)
    else
    end
    Groups[_ARG_0_].Members[_ARG_1_] = {
      Role = _ARG_2_ or "Member",
      Nick = exports.gamemode:GetAccountData(_ARG_1_, "lastNick"),
      CanOpenDoors = true
    }
    RefreshUIToOnlineMembers(_ARG_0_)
    SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
    return true
  end
  return false
end
function KickPlayer(_ARG_0_, _ARG_1_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if _ARG_0_ and Groups[_ARG_0_] and getElementData(source, "account") then
    if Groups[_ARG_0_].Members and Groups[_ARG_0_].Members[_ARG_1_] then
      if (Groups[_ARG_0_].Members[getElementData(source, "account")] and Groups[_ARG_0_].Members[getElementData(source, "account")].Role) == "Leader" or (Groups[_ARG_0_].Members[getElementData(source, "account")] and Groups[_ARG_0_].Members[getElementData(source, "account")].Role) == "Sub" or (Groups[_ARG_0_].Members[getElementData(source, "account")] and Groups[_ARG_0_].Members[getElementData(source, "account")].Role) == "Staff" then
        if (Groups[_ARG_0_].Members and Groups[_ARG_0_].Members[_ARG_1_]).Role ~= "Leader" then
          if (Groups[_ARG_0_].Members[getElementData(source, "account")] and Groups[_ARG_0_].Members[getElementData(source, "account")].Role) == "Sub" and (Groups[_ARG_0_].Members and Groups[_ARG_0_].Members[_ARG_1_]).Role == "Sub" then
            exports.stoneage_notifications:CreateNotification(source, translate(source, "Apenas o lider pode expulsar este membro"), "error")
          else
            Groups[_ARG_0_].Members[_ARG_1_] = nil
            if exports.gamemode:getAccountPlayer(_ARG_1_) then
              exports.stoneage_notifications:CreateNotification(exports.gamemode:getAccountPlayer(_ARG_1_), translate(exports.gamemode:getAccountPlayer(_ARG_1_), "foikickado"), "error")
              removeElementData(exports.gamemode:getAccountPlayer(_ARG_1_), "Group")
              if PlayersInUI[exports.gamemode:getAccountPlayer(_ARG_1_)] then
                triggerClientEvent(exports.gamemode:getAccountPlayer(_ARG_1_), "ToggleGroupSystem", exports.gamemode:getAccountPlayer(_ARG_1_), PlayersInUI[exports.gamemode:getAccountPlayer(_ARG_1_)], nil, Invites[exports.gamemode:getAccountPlayer(_ARG_1_)])
              end
            else
              SQL:Exec("UPDATE `Accounts` SET `Group`=? WHERE `Owner`=?", nil, _ARG_1_)
              exports.gamemode:ClearAccountDataCache(_ARG_1_)
            end
            RefreshUIToOnlineMembers(_ARG_0_)
            SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
          end
        else
          exports.stoneage_notifications:CreateNotification(source, translate(source, "N\195\163o pode expulsar lider"), "error")
        end
      else
        exports.stoneage_notifications:CreateNotification(source, translate(source, "Sem permiss\195\163o!"), "error")
      end
    else
      exports.stoneage_notifications:CreateNotification(source, translate(source, "Este jogador j\195\161 n\195\163o est\195\161 mais neste grupo."), "error")
    end
  end
end
addEvent("KickPlayer", true)
addEventHandler("KickPlayer", root, KickPlayer)
function RemoveSerialFromGroup(_ARG_0_, _ARG_1_)
  if Groups[_ARG_0_] then
    Groups[_ARG_0_].Members[_ARG_1_] = nil
    if exports.gamemode:getAccountPlayer(_ARG_1_) then
      exports.stoneage_notifications:CreateNotification(exports.gamemode:getAccountPlayer(_ARG_1_), translate(exports.gamemode:getAccountPlayer(_ARG_1_), "foikickado"), "error")
      removeElementData(exports.gamemode:getAccountPlayer(_ARG_1_), "Group")
      if PlayersInUI[exports.gamemode:getAccountPlayer(_ARG_1_)] then
        triggerClientEvent(exports.gamemode:getAccountPlayer(_ARG_1_), "ToggleGroupSystem", exports.gamemode:getAccountPlayer(_ARG_1_), PlayersInUI[exports.gamemode:getAccountPlayer(_ARG_1_)], nil, Invites[exports.gamemode:getAccountPlayer(_ARG_1_)])
      end
    else
      SQL:Exec("UPDATE `Accounts` SET `Group`=? WHERE `Owner`=?", nil, _ARG_1_)
      exports.gamemode:ClearAccountDataCache(_ARG_1_)
    end
    RefreshUIToOnlineMembers(_ARG_0_)
  end
end
function LeaveGroup(_ARG_0_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if Groups[_ARG_0_] then
    if getElementData(source, "account") and Groups[_ARG_0_].Members and Groups[_ARG_0_].Members[getElementData(source, "account")] then
      Groups[_ARG_0_].Members[getElementData(source, "account")] = nil
      removeElementData(source, "Group")
      if PlayersInUI[source] then
        triggerClientEvent(source, "ToggleGroupSystem", source, PlayersInUI[source], nil, Invites[source])
      end
      RefreshUIToOnlineMembers(_ARG_0_)
      SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
      exports.stoneage_notifications:CreateNotification(source, translate(source, "saiugp"), "error")
    else
      exports.stoneage_notifications:CreateNotification(source, translate(source, "Este jogador j\195\161 n\195\163o est\195\161 mais neste grupo."), "error")
    end
  end
end
addEvent("LeaveGroup", true)
addEventHandler("LeaveGroup", root, LeaveGroup)
function DestroyGroup(_ARG_0_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if Groups[_ARG_0_] then
    for _FORV_4_ in pairs(Groups[_ARG_0_].Members) do
      if exports.gamemode:getAccountPlayer(_FORV_4_) then
        exports.stoneage_notifications:CreateNotification(exports.gamemode:getAccountPlayer(_FORV_4_), translate(exports.gamemode:getAccountPlayer(_FORV_4_), "foikickado"), "error")
        removeElementData(exports.gamemode:getAccountPlayer(_FORV_4_), "Group")
        if PlayersInUI[exports.gamemode:getAccountPlayer(_FORV_4_)] then
          triggerClientEvent(exports.gamemode:getAccountPlayer(_FORV_4_), "ToggleGroupSystem", exports.gamemode:getAccountPlayer(_FORV_4_), PlayersInUI[exports.gamemode:getAccountPlayer(_FORV_4_)], nil, Invites[exports.gamemode:getAccountPlayer(_FORV_4_)])
        end
      else
        SQL:Exec("UPDATE `Accounts` SET `Group`=? WHERE `Owner`=?", nil, _FORV_4_)
        exports.gamemode:ClearAccountDataCache(_FORV_4_)
      end
    end
    Groups[_ARG_0_] = nil
    SQL:Exec("DELETE FROM `Groups` WHERE `Name`=?", _ARG_0_)
    return true
  end
  return false
end
addEvent("DestroyGroup", true)
addEventHandler("DestroyGroup", root, DestroyGroup)
function AllowMemberToOpenDoor(_ARG_0_, _ARG_1_, _ARG_2_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if Groups[_ARG_0_] then
    if Groups[_ARG_0_].Members[_ARG_1_] then
      Groups[_ARG_0_].Members[_ARG_1_].CanOpenDoors = _ARG_2_
      SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
    else
      exports.stoneage_notifications:CreateNotification(source, translate(source, "Este jogador j\195\161 n\195\163o est\195\161 mais neste grupo."), "error")
    end
    RefreshUIToOnlineMembers(_ARG_0_)
  end
end
addEvent("AllowMemberToOpenDoor", true)
addEventHandler("AllowMemberToOpenDoor", root, AllowMemberToOpenDoor)
function SetMemberRole(_ARG_0_, _ARG_1_, _ARG_2_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if Groups[_ARG_0_] then
    if Groups[_ARG_0_].Members[_ARG_1_] then
      Groups[_ARG_0_].Members[_ARG_1_].Role = _ARG_2_
      SQL:Exec("UPDATE `Groups` SET `Members`=? WHERE `Name`=?", toJSON(Groups[_ARG_0_].Members), _ARG_0_)
    else
      exports.stoneage_notifications:CreateNotification(source, translate(source, "Este jogador j\195\161 n\195\163o est\195\161 mais neste grupo."), "error")
    end
    RefreshUIToOnlineMembers(_ARG_0_)
  end
end
addEvent("SetMemberRole", true)
addEventHandler("SetMemberRole", root, SetMemberRole)
function SetGroupDescription(_ARG_0_, _ARG_1_)
  if client ~= source and source ~= resourceRoot then
    exports.stoneage_ac:KickForCallingUnauthorizedEvent(client, eventName)
    return
  end
  if Groups[_ARG_0_] then
    Groups[_ARG_0_].Description = _ARG_1_
    SQL:Exec("UPDATE `Groups` SET `Description`=? WHERE `Name`=?", _ARG_1_, _ARG_0_)
    RefreshUIToOnlineMembers(_ARG_0_)
    return true
  end
  return false
end
addEvent("SetGroupDescription", true)
addEventHandler("SetGroupDescription", root, SetGroupDescription)
function SetGroupLimit(_ARG_0_, _ARG_1_)
  if Groups[_ARG_0_] then
    Groups[_ARG_0_].MaxMembers = _ARG_1_
    SQL:Exec("UPDATE `Groups` SET `MaxSlots`=? WHERE `Name`=?", _ARG_1_, _ARG_0_)
    RefreshUIToOnlineMembers(_ARG_0_)
    return true
  end
  return false
end
function RefreshUIToOnlineMembers(_ARG_0_)
  for _FORV_4_ in pairs(Groups[_ARG_0_].Members) do
    if exports.gamemode:getAccountPlayer(_FORV_4_) and PlayersInUI[exports.gamemode:getAccountPlayer(_FORV_4_)] then
      triggerClientEvent(exports.gamemode:getAccountPlayer(_FORV_4_), "ToggleGroupSystem", exports.gamemode:getAccountPlayer(_FORV_4_), true, Groups[_ARG_0_])
    end
  end
end
function SendMessageToMembers(_ARG_0_, ...)
  if Groups[_ARG_0_] then
    for _FORV_5_ in pairs(Groups[_ARG_0_].Members) do
      if exports.gamemode:getAccountPlayer(_FORV_5_) then
        exports.stoneage_notifications:CreateNotification(exports.gamemode:getAccountPlayer(_FORV_5_), translate(exports.gamemode:getAccountPlayer(_FORV_5_), ...), "info")
      end
    end
  end
end
function HasPermissionToOpenGroupDoor(_ARG_0_, _ARG_1_)
  return Groups[_ARG_0_] and Groups[_ARG_0_].Members[_ARG_1_] and Groups[_ARG_0_].Members[_ARG_1_].CanOpenDoors or false
end
function GetGroup(_ARG_0_)
  return Groups[_ARG_0_]
end
function GetAllGroups()
  return Groups
end
addEventHandler("onPlayerQuit", root, function()
  if Invites[source] then
    Invites[source] = nil
  end
  if PlayersInUI[source] then
    PlayersInUI[source] = nil
  end
end)
function translate(...)
  return exports.stoneage_translations:translate(...)
end
function GChat(_ARG_0_, _ARG_1_, ...)
  if not getElementData(_ARG_0_, "Group") then
    return
  end
  if table.concat({
    ...
  }, " ") ~= "" and not _UPVALUE0_[_ARG_0_] then
    for _FORV_10_, _FORV_11_ in ipairs(getElementsByType("player")) do
      if getElementData(_FORV_11_, "Group") == getElementData(_ARG_0_, "Group") then
        outputChatBox(string.format("#FFFF00[GRUPO] %s:#FFFFFF %s", getPlayerName(_ARG_0_), (table.concat({
          ...
        }, " "))), _FORV_11_, 255, 0, 0, true)
      end
    end
    triggerEvent("saveLog", _ARG_0_, "chat", (string.format("[GRUPO] (%s) %s: %s", getElementData(_ARG_0_, "Group"), getPlayerName(_ARG_0_), table.concat({
      ...
    }, " "))))
    _UPVALUE0_[_ARG_0_] = true
    setTimer(function(_ARG_0_)
      _UPVALUE0_[_ARG_0_] = nil
    end, 1000, 1, _ARG_0_)
    print((string.format("[GRUPO] (%s) %s: %s", getElementData(_ARG_0_, "Group"), getPlayerName(_ARG_0_), table.concat({
      ...
    }, " "))))
  end
end
addCommandHandler("ChatGrupo", GChat, false, true)
for _FORV_6_, _FORV_7_ in ipairs(getElementsByType("player")) do
  bindKey(_FORV_7_, "y", "down", "chatbox", "ChatGrupo")
end
addEventHandler("onPlayerJoin", root, function()
  bindKey(source, "y", "down", "chatbox", "ChatGrupo")
end)
function removeHex(_ARG_0_)
  return string.gsub(_ARG_0_, "#%x%x%x%x%x%x", "")
end
