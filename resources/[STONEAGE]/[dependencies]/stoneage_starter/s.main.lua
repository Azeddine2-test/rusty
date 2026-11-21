AutoStarter = {
  priority = {
    "stoneage_bike",
    "richpresence-id",
    "stoneage_utils",
    "stoneage_notifications",
    "stoneage_logs",
    "stoneage_sql",
    "stoneage_ui",
    "stoneage_object_preview",
    "stoneage_bone_attach",
    "stoneage_translations",
    "stoneage_highlight",
    "stoneage_world_textures",
    "stoneage_farms",
    "stoneage_compass",
    "stoneage_settings",
    "gamemode"
  },
  _tag = "stoneage_",
  resourcesToInit = {}
}
function AutoStarter.Init()
  for _FORV_4_, _FORV_5_ in ipairs(AutoStarter.priority) do
    if getResourceFromName(_FORV_5_) then
      table.insert(AutoStarter.resourcesToInit, (getResourceFromName(_FORV_5_)))
    end
  end
  for _FORV_4_, _FORV_5_ in ipairs(getResources()) do
    if not ({
      [_FORV_5_] = true
    })[getResourceName(_FORV_5_)] and getResourceName(_FORV_5_):sub(1, utf8.len(AutoStarter._tag)) == AutoStarter._tag then
      table.insert(AutoStarter.resourcesToInit, _FORV_5_)
    end
  end
end
function AutoStarter.toggeResourceState()
  addEventHandler("onPlayerConnect", resourceRoot, AutoStarter.cancelConnectWhenStartingResource)
  for _FORV_3_, _FORV_4_ in ipairs(getElementsByType("player")) do
    toggleAllControls(_FORV_4_, false)
  end
  if eventName == "onResourceStart" then
    for _FORV_3_, _FORV_4_ in ipairs(getResourceACLRequests(resource)) do
      if not _FORV_4_.access or _FORV_4_.pending then
        cancelEvent(true)
        return
      end
    end
    AutoStarter.Init()
    for _FORV_3_ = 1, #AutoStarter.resourcesToInit do
      if getResourceState(AutoStarter.resourcesToInit[_FORV_3_]) == "loaded" then
        startResource(AutoStarter.resourcesToInit[_FORV_3_])
      end
    end
  else
    for _FORV_3_ = #AutoStarter.resourcesToInit, 1, -1 do
      if getResourceState(AutoStarter.resourcesToInit[_FORV_3_]) == "running" then
        stopResource(AutoStarter.resourcesToInit[_FORV_3_])
      end
    end
  end
  removeEventHandler("onPlayerConnect", resourceRoot, AutoStarter.cancelConnectWhenStartingResource)
  for _FORV_3_, _FORV_4_ in ipairs(getElementsByType("player")) do
    toggleAllControls(_FORV_4_, true)
  end
end
addEventHandler("onResourceStart", resourceRoot, AutoStarter.toggeResourceState)
addEventHandler("onResourceStop", resourceRoot, AutoStarter.toggeResourceState)
function AutoStarter.cancelConnectWhenStartingResource()
  cancelEvent(true, "Wait.")
end
