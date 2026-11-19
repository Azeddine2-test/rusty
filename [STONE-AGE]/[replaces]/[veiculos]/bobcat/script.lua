-- Generated using GM2MC ( GTA:SA Models To MTA:SA Converter ) by SoRa

addEventHandler('onClientResourceStart',resourceRoot,function () 
txd = engineLoadTXD( 'bobcat.txd' ) 
engineImportTXD( txd, 422 ) 
dff = engineLoadDFF('bobcat.dff', 422) 
engineReplaceModel( dff, 422 )
end)
