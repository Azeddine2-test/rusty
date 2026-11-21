function addObjectToDatabase(_ARG_0_, _ARG_1_)
  if _ARG_0_ and isElement(_ARG_0_) then
    if SQL then
      SQL:Exec("INSERT INTO `Objects` (\"ObjectID\", \"Position\", \"Name\", \"Owner\", \"Type\", \"Health\", \"creationTime\") VALUES (?,?,?,?,?,?,?)", getNewObjectQuantity(), toJSON({
        getElementPosition(_ARG_0_)
      }), _ARG_1_, getElementData(_ARG_0_, "owner") or nil, getElementData(_ARG_0_, "obType") or nil, getElementData(_ARG_0_, "health") or nil, getElementData(_ARG_0_, "creationTime") or nil)
      setElementData(_ARG_0_, "objID", (getNewObjectQuantity()))
      addEventHandler("onElementDataChange", _ARG_0_, updateObjectDataToDB)
    else
      outputServerLog(("ERRO NA CONEX\195\131O COM A DATABASE. (N\195\131O FOI POSSIVEL SALVAR [\"%s\"]."):format(_ARG_1_))
    end
  end
end
function removeObjectFromDatabase(_ARG_0_)
  if isElement(_ARG_0_) and SQL and getElementData(_ARG_0_, "objID") then
    SQL:Exec("DELETE FROM `Objects` WHERE `ObjectID` = ?", (getElementData(_ARG_0_, "objID")))
  end
end
function updateObjectDataToDB(_ARG_0_, _ARG_1_, _ARG_2_)
  if getPlayerDataSetting(_ARG_0_, "savableInDB") and getPlayerDataSetting(_ARG_0_, "savableInDB").Objects and getElementData(source, "objID") then
    if type(_ARG_2_) == "table" then
      _ARG_2_ = toJSON(_ARG_2_)
    end
    SQL:Exec("UPDATE `Objects` SET ?=? WHERE `ObjectID`=?", _ARG_0_, _ARG_2_ or nil, (getElementData(source, "objID")))
  end
end
function setObjectDataToDB(_ARG_0_, _ARG_1_, _ARG_2_)
  if SQL then
    if type(_ARG_2_) == "table" then
      _ARG_2_ = toJSON(_ARG_2_)
    end
    if objectDataHasAlreadyKey(_ARG_0_, _ARG_1_) then
      if _ARG_2_ == nil then
        return SQL:Exec("DELETE FROM objects_data WHERE `ID` = ? AND `key` = ?", _ARG_0_, _ARG_1_)
      else
        return SQL:Exec("UPDATE objects_data SET `value` = ?, `type` = ? WHERE `ID` = ? AND `key` = ?", _ARG_2_, type(_ARG_2_), _ARG_0_, _ARG_1_)
      end
    elseif _ARG_2_ ~= nil then
      return SQL:Exec("INSERT INTO objects_data VALUES (?, ?, ?, ?)", _ARG_0_, _ARG_1_, _ARG_2_, (type(_ARG_2_)))
    end
  end
  return false
end
function getNewObjectQuantity()
  _UPVALUE0_ = _UPVALUE0_ + 1
  return _UPVALUE0_
end
addEventHandler("onResourceStart", resourceRoot, function()
  _UPVALUE0_ = 0
  if SQL and SQL:Query("SELECT `ObjectID` FROM `Objects` ORDER BY (SELECT CAST(`ObjectID` as integer)) DESC LIMIT 1")[1] then
    _UPVALUE0_ = SQL:Query("SELECT `ObjectID` FROM `Objects` ORDER BY (SELECT CAST(`ObjectID` as integer)) DESC LIMIT 1")[1].ObjectID
  end
end)
IS_STILL_LOADING = {}
function loadObjectsFromDB()
  if SQL then
    Async:setPriority("high")
    Async:foreach(SQL:Query("SELECT * FROM `Objects`"), function(_ARG_0_, _ARG_1_)
      if type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position) and _ARG_0_.Name and getObModel(_ARG_0_.Name) then
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "obName", _ARG_0_.Name)
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "obType", _ARG_0_.Type)
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "owner", _ARG_0_.Owner)
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "health", _ARG_0_.health)
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "objID", _ARG_0_.ObjectID)
        setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "maxSlots", getObjectDataSetting(_ARG_0_.Name, "maxSlots") or nil)
        setElementFrozen(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), true)
        IS_STILL_LOADING[createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))] = true
        if _ARG_0_.Name == "Planter" then
          loadPlants((createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))))
        elseif _ARG_0_.Name == "Wardrobe" then
          setElementID(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), ("wardrobe:%s"):format(_ARG_0_.Owner))
        elseif _ARG_0_.Name == "Cama" then
          setElementID(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), ("cama:%s"):format(_ARG_0_.Owner))
        elseif _ARG_0_.Name == "Sentry" then
          setElementParent(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), Dummys.Sentry)
          exports.stoneage_sentrys:InitSentry((createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))))
        elseif _ARG_0_.Name == "Fornalha" then
          initFurnance((createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))))
        elseif _ARG_0_.Name == "Espetos" then
          initEspeto((createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))))
        elseif _ARG_0_.Name == "Fogueira" then
          setTimer(function(_ARG_0_)
            if isElement(_ARG_0_) then
              destroyObject(_ARG_0_)
            end
          end, 3600000, 1, (createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))))
        end
        if isBaseItem(_ARG_0_.Name) then
          setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), "baseObject", true)
        end
        for _FORV_15_ in pairs({
          ["sentry:ammo"] = true,
          ["po\195\167o:water"] = true,
          ["wardrobe:password"] = true,
          ["wardrobe:permissions"] = true,
          ["placa:text"] = true,
          ["planter:plants"] = true,
          creationTime = true,
          invOrder = true
        }) do
          if _ARG_0_[_FORV_15_] then
            if type(_ARG_0_[_FORV_15_]) == "string" and fromJSON(_ARG_0_[_FORV_15_]) then
            elseif fixJSONTable(type(_ARG_0_[_FORV_15_]) == "string" and fromJSON(_ARG_0_[_FORV_15_])) == "true" then
            elseif true == "false" then
            end
            if _FORV_15_ == "invOrder" then
              for _FORV_21_, _FORV_22_ in pairs(false) do
                setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), _FORV_22_.itemName, (getElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), _FORV_22_.itemName) or 0) + _FORV_22_.quantity)
              end
            else
            end
            setElementData(createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), _FORV_15_, (tostring(false)))
          end
        end
        addEventHandler("onElementDataChange", createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position))), updateObjectDataToDB)
        IS_STILL_LOADING[createObject(_ARG_0_.Name and getObModel(_ARG_0_.Name), unpack(type(_ARG_0_.Position) == "string" and fromJSON(_ARG_0_.Position)))] = nil
        _UPVALUE0_ = _UPVALUE0_ + 1
      end
    end, function()
      setTimer(function()
        LOGS:saveLog("db", ("%i objetos foram carregados em %s segundos"):format(_UPVALUE0_, (getTickCount() - _UPVALUE1_) / 1000))
      end, 3000, 1)
    end)
  end
end
addEventHandler("onResourceStart", resourceRoot, function()
  setTimer(loadObjectsFromDB, 100, 1)
end)
