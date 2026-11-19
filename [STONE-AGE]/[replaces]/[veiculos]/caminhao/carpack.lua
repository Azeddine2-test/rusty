function replaceModel()                  
                   txd = engineLoadTXD("barracks.txd",433 ) 
                   engineImportTXD(txd, 433 ) 
                   dff = engineLoadDFF("barracks.dff", 433 ) 
                   engineReplaceModel(dff, 433 ) 
end 
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel) 

addCommandHandler ( "reloadcar", replaceModel )