-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter )

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function () 
txd = engineLoadTXD ( 'camper.txd' ) 
engineImportTXD ( txd, 483 ) 
dff = engineLoadDFF('camper.dff', 483) 
engineReplaceModel ( dff, 483 )
end)
