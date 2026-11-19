-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter )

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),function () 
txd = engineLoadTXD ( 'ambulan.txd' ) 
engineImportTXD ( txd, 416 ) 
dff = engineLoadDFF('ambulan.dff', 416) 
engineReplaceModel ( dff, 416 )
end)
