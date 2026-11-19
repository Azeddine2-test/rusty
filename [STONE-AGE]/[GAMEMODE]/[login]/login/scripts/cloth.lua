		
function showClothWindow()
if not isElement ( window ) then
x,y,z,x1,y1,z1 =  getCameraMatrix() 
xx,yy,zz,xx1,yy1,zz1 = 417.06799316406,2535.5673828125,10.540748596191,320.29791259766,2554.6467285156,-5.9373426437378
smoothMoveCamera(x,y,z,x1,y1,z1,xx,yy,zz,xx1,yy1,zz1,500)
        window = guiCreateStaticImage(0.25, 0.36, 0.10, 0.34, ":StoneAge/images/box.png", true)
        x = guiCreateLabel(-0.02, 0.07, 1.02, 0.07, "Estilo do personagem", true, window)
        guiSetFont(x, "default-bold-small")
        guiLabelSetHorizontalAlign(x, "center", false)
        guiLabelSetVerticalAlign(x, "center")
        label_cabeca = guiCreateLabel(0.08, 0.15, 0.84, 0.05, 'Face', true, window)
        guiLabelSetHorizontalAlign(label_cabeca, "center", false)
    box_cabeca = guiCreateComboBox(0.08, 0.21, 0.84, 0.34,getNameFromID(getElementData(localPlayer,'cloth1'),'face') or 'Error', true, window)
        guiComboBoxAddItem(box_cabeca, "Carl")
        guiComboBoxAddItem(box_cabeca, "Eddie")
        guiComboBoxAddItem(box_cabeca, "Jhow")
        guiComboBoxAddItem(box_cabeca, "Matusalém")
		torso = guiCreateLabel(0.08, 0.29, 0.84, 0.08, "Torso", true, window)
        guiLabelSetHorizontalAlign(torso, "center", false)
    box_camisa = guiCreateComboBox(0.08, 0.35, 0.84, 0.52, getNameFromID(getElementData(localPlayer,'cloth0'),'torso') or 'Error', true, window)
        guiComboBoxAddItem(box_camisa, "Sem Camisa")
        guiComboBoxAddItem(box_camisa, "Blusa Preta")
        guiComboBoxAddItem(box_camisa, "Blusa Branca")
        guiComboBoxAddItem(box_camisa, "Camisa Listrada")
        guiComboBoxAddItem(box_camisa, "Camisa Branca")
        guiComboBoxAddItem(box_camisa, "I <3 StoneAge")
        guiComboBoxAddItem(box_camisa, "Homies")
        guiComboBoxAddItem(box_camisa, "Camisa Verde")
        guiComboBoxAddItem(box_camisa, "Terno")
        guiComboBoxAddItem(box_camisa, "Camisa Azul")
        guiComboBoxAddItem(box_camisa, "80")
        guiComboBoxAddItem(box_camisa, "5")
    perna = guiCreateLabel(0.08, 0.44, 0.84, 0.08, "Pernas", true, window)
        guiLabelSetHorizontalAlign(perna, "center", false)
        box_pernas = guiCreateComboBox(0.08, 0.50, 0.84, 0.29, getNameFromID(getElementData(localPlayer,'cloth2'),'perna') or 'Error', true, window)
        guiComboBoxAddItem(box_pernas, "Cueca")
        guiComboBoxAddItem(box_pernas, "Short Branco")
        guiComboBoxAddItem(box_pernas, "Short Vermelho")
        guiComboBoxAddItem(box_pernas, "Short Estrela")
        guiComboBoxAddItem(box_pernas, "Bermuda Jeans")		
    acessorios = guiCreateLabel(0.08, 0.585, 0.84, 0.08, 'Acessorios', true, window)
        guiLabelSetHorizontalAlign(acessorios, "center", false)
        box_acessorios = guiCreateComboBox(0.08, 0.64, 0.84, 0.47, getNameFromID(getElementData(localPlayer,'cloth15'),'acessorios') or 'Error', true, window)
        guiComboBoxAddItem(box_acessorios, "Sem Uso")
        guiComboBoxAddItem(box_acessorios, "Oculos Preto")
        guiComboBoxAddItem(box_acessorios, "Oculos Verde")
        guiComboBoxAddItem(box_acessorios, "Oculos de Sol")
        guiComboBoxAddItem(box_acessorios, "Bandana Verde")
        chapeu = guiCreateLabel(0.08, 0.72, 0.84, 0.08, "Chapéu", true, window)
        guiLabelSetHorizontalAlign(chapeu, "center", false)
    box_chapeu = guiCreateComboBox(0.08, 0.78, 0.84, 0.31, getNameFromID(getElementData(localPlayer,'cloth16'),'chapeu') or 'Error', true, window)
        guiComboBoxAddItem(box_chapeu, "Sem Uso")
        guiComboBoxAddItem(box_chapeu, "Branco e Cinza")
        guiComboBoxAddItem(box_chapeu, "Cowboy")
        guiComboBoxAddItem(box_chapeu, "Tigre")
        guiComboBoxAddItem(box_chapeu, "Verde Pra Trás")
        guiComboBoxAddItem(box_chapeu, "Vermelho Pra Trás")
        guiComboBoxAddItem(box_chapeu, "Azul Pra Trás")
        guiComboBoxAddItem(box_chapeu, "Preto Pra Trás")
    sair = guiCreateLabel(0.08, 0.865, 0.84, 0.08, "Sair", true, window)
        guiLabelSetHorizontalAlign(sair, "right", false)        
	rest_cam = guiCreateLabel(0.08, 0.865, 0.6, 0.08, "Rest. Camera", true, window)
        guiLabelSetHorizontalAlign(rest_cam, "left", false)
		
	setElementRotation(testPed,0,0,249)
	setDisabled(credits_button,guiGetVisible(window))
	addEventHandler("onClientGUIClick", root, click )

end
end

table_itens = {
['face'] = {
{'Carl',0},
{'Eddie',1},
{'Jhow',2},
{'Matusalém',3},
},
['torso'] = {
{'Sem Camisa',0},
{'Blusa Preta',1},
{'Blusa Branca',2},
{'Camisa Listrada',3},
{'Camisa Branca',4},
{'I <3 StoneAge',5},
{'Homies',6},
{'Camisa Verde',10},
{'Terno',64},
{'Camisa Azul',17},
{'80',27},
{'5',28},
},
['perna'] = {
{'Cueca',0},
{'Short Branco',15},
{'Short Estrela',16},
{'Short Vermelho',17},
{'Bermuda Jeans',38},
},
['acessorios'] = {
{'Sem Uso',-1},
{'Oculos Preto',3},
{'Oculos Verde',4},
{'Bandana Verde',7},
{'Oculos de Sol',10},
},
['chapeu'] = {
{'Sem Uso',-1},
{'Branco e Cinza',9},
{'Cowboy',10},
{'Tigre',11},
{'Verde Pra Trás',17},
{'Vermelho Pra Trás',23},
{'Azul Pra Trás',28},
{'Preto Pra Trás',44},
},
}

function click()
x,y,z,x1,y1,z1 = getCameraMatrix()
setElementInterior(localPlayer,10)
if source == box_cabeca then
local item = guiComboBoxGetSelected(source)
local text = guiComboBoxGetItemText(source,item)
smoothMoveCamera(x,y,z,x1,y1,z1,415.02075195313,2536.115234375,10.675506591797,324.0149230957,2577.3784179688,6.7654910087585,1500)
setData('1',text,'face')
elseif source == box_camisa then
local item = guiComboBoxGetSelected(source)
local text = guiComboBoxGetItemText(source,item)
setData('0',text,'torso')
smoothMoveCamera(x,y,z,x1,y1,z1,415.42239379883,2535.8293457031,10.471800804138,325.83111572266,2578.6325683594,-1.414972782135,1500)
elseif source == box_pernas then
local item = guiComboBoxGetSelected(source)
local text = guiComboBoxGetItemText(source,item)
setData('2',text,'perna')
smoothMoveCamera(x,y,z,x1,y1,z1,415.65542602539,2535.5705566406,10.034302711487,336.43478393555,2590.0173339844,-17.527070999146,1500)
elseif source == box_acessorios then
local item = guiComboBoxGetSelected(source)
local text = guiComboBoxGetItemText(source,item)
setData('15',text,'acessorios')
smoothMoveCamera(x,y,z,x1,y1,z1,414.87658691406,2536.1589355469,10.651657104492,325.01947021484,2579.99609375,12.652506828308,1500)
elseif source == box_chapeu then
local item = guiComboBoxGetSelected(source)
local text = guiComboBoxGetItemText(source,item)
setData('16',text,'chapeu')
smoothMoveCamera(x,y,z,x1,y1,z1,414.82775878906,2535.8671875,10.982478141785,348.09356689453,2602.0588378906,-23.152540206909,1500)
elseif source == sair then
closeClothWindow()
elseif source == rest_cam then
smoothMoveCamera(x,y,z,x1,y1,z1,417.06799316406,2535.5673828125,10.540748596191,320.29791259766,2554.6467285156,-5.9373426437378,500)
end
end

function getIDFromName(name,id)
for i ,data in ipairs(table_itens[id]) do
if name == data[1] then
return tonumber(data[2])
end
end
end

function getNameFromID(id,tablez)
for i ,data in ipairs(table_itens[tablez]) do
if id == data[2] then
return data[1]
end
end
end

function setData(id,text,id2)
setElementData(localPlayer,"cloth"..id,getIDFromName(text,id2))
updatePedClothes()
end

function renderRotateText()
local screenW, screenH = guiGetScreenSize()
        dxDrawText("Mouse2 para girar o personagem.", (screenW * 0.4279) - 1, (screenH * 0.9740) - 1, (screenW * 0.5721) - 1, (screenH * 0.9935) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Mouse2 para girar o personagem.", (screenW * 0.4279) + 1, (screenH * 0.9740) - 1, (screenW * 0.5721) + 1, (screenH * 0.9935) - 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Mouse2 para girar o personagem.", (screenW * 0.4279) - 1, (screenH * 0.9740) + 1, (screenW * 0.5721) - 1, (screenH * 0.9935) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Mouse2 para girar o personagem.", (screenW * 0.4279) + 1, (screenH * 0.9740) + 1, (screenW * 0.5721) + 1, (screenH * 0.9935) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Mouse2 para girar o personagem.", screenW * 0.4279, screenH * 0.9740, screenW * 0.5721, screenH * 0.9935, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
end	

function closeClothWindow ()
if isElement(window) then
	destroyElement ( window )
end
	removeEventHandler('onClientGUIClick',root,click )
x,y,z,x1,y1,z1 = getCameraMatrix()
xx,yy,zz,xx1,yy1,zz1 = 421,2540,11.75, 356,2493,-5
    smoothMoveCamera(x,y,z,x1,y1,z1,xx,yy,zz,xx1,yy1,zz1,500)
  	setElementRotation(testPed,0,0,-70)
	setDisabled(credits_button,false)
end

addEvent('fechar_cloth',true)
function fechar_cloth()
if isElement(window) then
	destroyElement ( window )
	removeEventHandler('onClientGUIClick',root,click )
end
end
addEventHandler('fechar_cloth',root,fechar_cloth)



	
function setPedClothes(thePed, clothingSlot, clothingID)
	if not isElement(thePed) then
		error("Invalid arguments to setPedClothes()!", 2)
	end
	if type(clothingSlot) ~= "number" then
		error("type(clothingSlot) ~= number",2)
	end
	if not clothingID or clothingID == -1 then
		return removePedClothes(thePed, clothingSlot)
	end
	local hasClothes = getPedClothes(thePed, clothingSlot) 
	if hasClothes then
		removePedClothes(thePed, clothingSlot)
	end
	local texture, model = getClothesByTypeIndex(clothingSlot, clothingID)
	return addPedClothes(thePed, texture, model, clothingSlot)
end

x,y,z = 414.20001220703,2536.5,10
testPed = createPed(0,x,y,z,-70,0,0)
setElementInterior(testPed,10)
setElementFrozen(testPed,true)
setPedClothes(testPed,0,0) 
setPedClothes(testPed,1,0)
setPedClothes(testPed,2,0)
setPedClothes(testPed,3,7)
setPedClothes(testPed,15,-1)
setPedClothes(testPed,16,-1)

setPedClothes(testPed,6,-1)
setPedClothes(testPed,7,-1)
setPedClothes(testPed,8,-1)
setPedClothes(testPed,9,-1)
setPedClothes(testPed,10,-1)
setPedClothes(testPed,11,-1)
setPedClothes(testPed,12,-1)
setPedClothes(testPed,13,-1)
setPedClothes(testPed,14,-1)
setPedClothes(testPed,17,-1)

addEvent("updatePedClothes", true)
updatePedClothes = function()
if isElement (testPed) then
	cur_cloth_0 = getElementData ( localPlayer, "cloth0")
	cur_cloth_1 = getElementData ( localPlayer, "cloth1")
	cur_cloth_2 = getElementData ( localPlayer, "cloth2")
	cur_cloth_3 = getElementData ( localPlayer, "cloth3")
	cur_cloth_15 = getElementData ( localPlayer, "cloth15")
	cur_cloth_16 = getElementData ( localPlayer, "cloth16")
	setPedClothes (testPed,0,cur_cloth_0)
	setPedClothes (testPed,1,cur_cloth_1)
	setPedClothes (testPed,2,cur_cloth_2)
	setPedClothes (testPed,3,cur_cloth_3)
	setPedClothes (testPed,15,cur_cloth_15)
	setPedClothes (testPed,16,cur_cloth_16)
end
end
addEventHandler("updatePedClothes", getRootElement(), updatePedClothes)


teste,y,z = getElementRotation(testPed)
function setPrevX(key)
if isElement(testPed) then
		if getKeyState('mouse2')then
		if z > 360 then z = 0 return else z = z+3 end
			setElementRotation  ( testPed, 0, 0, z)
		end
end
end


addEvent("delete_ped", true)
delete_ped = function()
if isElement ( testPed ) then
destroyElement(testPed)
end
end
addEventHandler("delete_ped", getRootElement(), delete_ped)

file = ":login/scripts/cloth.lua"
if fileExists(file) == true then
fileDelete(file)
end