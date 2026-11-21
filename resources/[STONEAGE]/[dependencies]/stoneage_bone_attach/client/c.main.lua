addEventHandler('onClientResourceStart', resourceRoot, function()
    addEvent('attachElementToBone', true)
    addEvent('detachElementFromBone', true)
    addEvent('receiveAttachmentData', true)
    addEventHandler('attachElementToBone', root, attachElementToBone)
    addEventHandler('detachElementFromBone', root, detachElementFromBone)
    addEventHandler('receiveAttachmentData', localPlayer, receiveAttachmentData)

    triggerServerEvent('requestAttachmentData', localPlayer)
end)

receiveAttachmentData = function(info)
    attachments = info
end
