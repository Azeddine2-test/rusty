addEvent("farm:onHitObject", true)
function spawnFarms()
  for _FORV_4_, _FORV_5_ in ipairs(_UPVALUE0_) do
    farms[_FORV_5_].limit = math.floor(#farmSpawns * _UPVALUE1_[_FORV_5_])
    farms[_FORV_5_].spawnedQuantity = 0
    _UPVALUE2_ = _UPVALUE2_ + math.floor(#farmSpawns / #_UPVALUE0_)
  end
  Async:foreach(randomizeTable(farmSpawns), function(_ARG_0_, _ARG_1_)
    createRandomObject(unpack(_ARG_0_))
  end)
end
addEventHandler("onResourceStart", resourceRoot, spawnFarms)
function randomizeTable(_ARG_0_)
  for _FORV_5_, _FORV_6_ in ipairs(_ARG_0_) do
    table.insert({}, math.random(1, #{} + 1), _FORV_6_)
  end
  return {}
end
function createRandomObject(_ARG_0_, _ARG_1_, _ARG_2_, _ARG_3_)
  _ARG_3_ = _ARG_3_ or _UPVALUE0_[math.random(#_UPVALUE0_)]
  if farms[_ARG_3_].spawnedQuantity >= farms[_ARG_3_].limit and _UPVALUE1_ <= _UPVALUE2_ then
    return createRandomObject(_ARG_0_, _ARG_1_, _ARG_2_, _UPVALUE0_[(UTILS:findValueInTable(_UPVALUE0_, _ARG_3_) or 1) + 1] or _UPVALUE0_[1])
  end
  setElementFrozen(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), true)
  setObjectScale(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), UTILS:randomValueInTable(farms[_ARG_3_].variants).scale or 1)
  setElementData(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), "obName", "farmObject")
  setElementData(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), "farmType", _ARG_3_)
  setElementData(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), "zOffset", UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0, false)
  for _FORV_9_, _FORV_10_ in ipairs(UTILS:randomValueInTable(farms[_ARG_3_].variants).items) do
    if 0 < math.random(_FORV_10_[2][1], _FORV_10_[2][2]) then
      setElementData(createObject(UTILS:randomValueInTable(farms[_ARG_3_].variants).model, _ARG_0_, _ARG_1_, _ARG_2_ + (UTILS:randomValueInTable(farms[_ARG_3_].variants).zOffset or 0)), _FORV_10_[1], (math.random(_FORV_10_[2][1], _FORV_10_[2][2])))
    end
  end
  farms[_ARG_3_].spawnedQuantity = farms[_ARG_3_].spawnedQuantity + 1
  _UPVALUE1_ = _UPVALUE1_ + 1
end
function destroyFarmObject(_ARG_0_, _ARG_1_)
  if not isElement(_ARG_0_) then
    return
  end
  farms[getElementData(_ARG_0_, "farmType")].spawnedQuantity = farms[getElementData(_ARG_0_, "farmType")].spawnedQuantity - 1
  _UPVALUE0_ = _UPVALUE0_ - 1
  if farms[getElementData(_ARG_0_, "farmType")].destroySound then
    exports.stoneage_sound3D:play3DSound((":stoneage_farms/files/%s"):format(farms[getElementData(_ARG_0_, "farmType")].destroySound), {
      getElementPosition(_ARG_0_)
    }, 1, 200)
  end
  if getElementData(_ARG_0_, "farmType") == "Tree" and isElement(_ARG_1_) then
    moveObject(_ARG_0_, 2000, getElementPosition(_ARG_0_))
    _UPVALUE1_(_ARG_0_)
  else
    setTimer(function(_ARG_0_, _ARG_1_, _ARG_2_)
      createRandomObject(_ARG_0_, _ARG_1_, _ARG_2_)
    end, getTimeToRespawnFarms(), 1, getElementPosition(_ARG_0_))
    destroyElement(_ARG_0_)
  end
end
function getTimeToRespawnFarms()
  return exports.stoneage_settings:getConfig("Minutos para respawnar farm", 30) * 60000
end
addEventHandler("farm:onHitObject", root, function(_ARG_0_, _ARG_1_)
  if not isElement(_ARG_0_) then
    return
  end
  if (getElementData(_ARG_0_, _ARG_1_) or 0) <= 0 then
    return
  end
  if not getElementData(_ARG_0_, "farmType") or not farms[getElementData(_ARG_0_, "farmType")] then
    return
  end
  if farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")] then
    if farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].sound then
      exports.stoneage_sound3D:play3DSound((":stoneage_farms/files/%s"):format(farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].sound), {
        getElementPosition(_ARG_0_)
      }, 1, 200)
    end
  end
  setElementData(_ARG_0_, _ARG_1_, (getElementData(_ARG_0_, _ARG_1_) or 0) - math.min(math.random(farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[1], farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[2]), getElementData(_ARG_0_, _ARG_1_)))
  setElementData(source, _ARG_1_, (getElementData(source, _ARG_1_) or 0) + math.min(math.random(farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[1], farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[2]), getElementData(_ARG_0_, _ARG_1_)))
  exports.stoneage_economy:giveExp(client, math.max(math.floor(math.min(math.random(farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[1], farms[getElementData(_ARG_0_, "farmType")].hitSettings[getElementData(source, "equippedItem")].removeQuantity[2]), getElementData(_ARG_0_, _ARG_1_)) * (math.random(10, 20) / 100)), 1))
  for _FORV_12_, _FORV_13_ in ipairs(FarmConfigs.possibleFarmDrops) do
    if (getElementData(_ARG_0_, _FORV_13_) or 0) >= 1 then
      break
    end
  end
  if getElementData(_ARG_0_, "farmType") == "Tree" and _ARG_1_ == "Wood" and (getElementData(_ARG_0_, _ARG_1_) or 0) <= 0 then
  end
  if true then
    destroyFarmObject(_ARG_0_, source)
  end
end)
function wipeFarms()
  Async:foreach(getElementsByType("object", resourceRoot), function(_ARG_0_)
    if getElementData(_ARG_0_, "farmType") and isElement(_ARG_0_) then
      destroyElement(_ARG_0_)
    end
  end, function()
    spawnFarms()
  end)
end
