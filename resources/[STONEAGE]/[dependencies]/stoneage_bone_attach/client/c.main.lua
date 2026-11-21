addEvent('attachElementToBone', true)
addEvent('detachElementFromBone', true)
addEvent('receiveAttachmentData', true)

receiveAttachmentData = function(info)
    attachments = info
end

-- Register client handlers immediately, before the resource-start callback.
addEventHandler('attachElementToBone', root, attachElementToBone)
addEventHandler('detachElementFromBone', root, detachElementFromBone)
addEventHandler('receiveAttachmentData', localPlayer, receiveAttachmentData)

addEventHandler('onClientResourceStart', resourceRoot, function()
    triggerServerEvent('requestAttachmentData', localPlayer)
end)
