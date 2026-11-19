txd = engineLoadTXD("huntley.txd")
engineImportTXD(txd, 400)
dff = engineLoadDFF("huntley.dff", 400)
engineReplaceModel(dff, 400)