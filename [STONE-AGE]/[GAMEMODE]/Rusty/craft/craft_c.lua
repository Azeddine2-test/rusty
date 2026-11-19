pagina = {}
local screenW, screenH = guiGetScreenSize()
        window_craft = guiCreateWindow((screenW - 564) / 2, (screenH - 409) / 2, 564, 409, "Crafting System by iDannz", false)
        guiWindowSetMovable(window_craft, false)
        guiWindowSetSizable(window_craft, false)
		guiSetVisible(window_craft,false)
		
        painel = guiCreateTabPanel(0.02, 0.05, 0.96, 0.92, true, window_craft)

function toggle_craft()
if getElementData(getLocalPlayer(),"logedin") then
if getElementData(getLocalPlayer(),"inRadiation") then return outputChatBox('Você não pode craftar em área radioativa!',255,0,0) end

guiSetVisible(window_craft,not guiGetVisible(window_craft))
if guiGetVisible(window_craft) then 
			triggerEvent('hide_config_window',localPlayer)
			triggerEvent('hide_help_window',localPlayer)
			triggerEvent('hide_inventory_window',localPlayer)
			triggerEvent('hide_admin_window',localPlayer)
			triggerEvent('hide_group_window',localPlayer)
			triggerEvent('hide_confirm_window',localPlayer)
showCursor(true)
else
showCursor(false)
toggle_pov_window(false)
end

if isElement(tempOb[localPlayer]) then
		destroyElement(tempOb[localPlayer])
		removeEventHandler("onClientRender", root, updatePos)
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientClick", root, cancelAction)
		removeEventHandler("onClientKey",root, setRotationOfObject)
		removeEventHandler("onClientRender",root, draw_ajuda)
		tempOb[localPlayer] = nil
		active = false
		guiSetVisible(window_craft,false)
		showCursor(false)
		toggle_pov_window(false)
end
end
end
bindKey('b','down',toggle_craft)

function hide_craft()
guiSetVisible(window_craft,false)
showCursor(false)
toggle_pov_window(false)

if isElement(tempOb[localPlayer]) then
		destroyElement(tempOb[localPlayer])
		removeEventHandler("onClientRender", root, updatePos)
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientClick", root, cancelAction)
		removeEventHandler("onClientKey",root, setRotationOfObject)
		removeEventHandler("onClientRender",root, draw_ajuda)
		tempOb[localPlayer] = nil
		active = false
end
end
addEvent('hide_craft_window',true)
addEventHandler('hide_craft_window',root,hide_craft)

        polvora_quant_window = guiCreateWindow(0.41, 0.41, 0.18, 0.15, "Craft de Pólvora", true)
        guiWindowSetMovable(polvora_quant_window, false)
        guiWindowSetSizable(polvora_quant_window, false)
		guiSetVisible(polvora_quant_window,false)
		guiSetProperty(polvora_quant_window, "AlwaysOnTop", "True") 

        quant_polv_label = guiCreateLabel(0.02, 0.21, 0.93, 0.13, "Digite a quantidade", true, polvora_quant_window)
        guiLabelSetHorizontalAlign(quant_polv_label, "center", false)
        quant_polv_edit = guiCreateEdit(0.04, 0.38, 0.92, 0.21, "", true, polvora_quant_window)
		
        quant_polv_cancel = guiCreateButton(0.19, 0.66, 0.25, 0.26, "Cancelar", true, polvora_quant_window)
        quant_polv_save = guiCreateButton(0.57, 0.66, 0.25, 0.26, "Ok", true, polvora_quant_window)

toggle_pov_window = function(state)
guiSetVisible(polvora_quant_window,state)
end

function click_quant_polv()
if not source then return end
quantidade = guiGetText(quant_polv_edit)
if source == quant_polv_cancel then toggle_pov_window(false) end
if not string.match(quantidade,"%d") then outputChatBox('Quantidade Inválida!',255,0,0) toggle_pov_window(false) return end
if tonumber(quantidade) <= 0 then outputChatBox('Quantidade Inválida!',255,0,0) toggle_pov_window(false) return end

if source == quant_polv_save then
	if isSelected_R(nome_requerimento_0[1]) then
if getElementData(localPlayer,'9mm') < 0 or getElementData(localPlayer,'9mm') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'9mm',getElementData(localPlayer,'9mm') - quantidade )

elseif isSelected_R(nome_requerimento_0[2]) then
if getElementData(localPlayer,'.45 ACP') < 0 or getElementData(localPlayer,'.45 ACP') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'.45 ACP',getElementData(localPlayer,'.45 ACP') - quantidade )

elseif isSelected_R(nome_requerimento_0[3]) then
if getElementData(localPlayer,'7.62mm') < 0 or getElementData(localPlayer,'7.62mm') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'7.62mm',getElementData(localPlayer,'7.62mm') - quantidade )

elseif isSelected_R(nome_requerimento_0[4]) then
if getElementData(localPlayer,'5.56mm') < 0 or getElementData(localPlayer,'5.56mm') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'5.56mm',getElementData(localPlayer,'5.56mm') - quantidade )

elseif isSelected_R(nome_requerimento_0[5]) then
if getElementData(localPlayer,'12 Gauge') < 0 or getElementData(localPlayer,'12 Gauge') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'12 Gauge',getElementData(localPlayer,'12 Gauge') - quantidade )

elseif isSelected_R(nome_requerimento_0[6]) then
if getElementData(localPlayer,'.300 Magnum') < 0 or getElementData(localPlayer,'.300 Magnum') < tonumber(quantidade)  then toggle_pov_window(false) outputChatBox('Você nao tem a quantidade suficiente da munição selecionada',255,0,0) return end
setElementData(localPlayer,'.300 Magnum',getElementData(localPlayer,'.300 Magnum') - quantidade )
end
setElementData(localPlayer,'Pólvora',getElementData(localPlayer,'Pólvora')+quantidade/10)
					outputChatBox('Você craftou ['..(quantidade/10)..'] Pólvora!',255,255,0)
toggle_pov_window(false)
end
end
addEventHandler('onClientGUIClick',quant_polv_save,click_quant_polv,false)
addEventHandler('onClientGUIClick',quant_polv_cancel,click_quant_polv,false)

info_item = {
{"Machado","Quando utilizado para\npegar madeira (recebe-se\nem maior quantidade)."},
{"Picareta","Quando utilizado para\npegar pedra (recebe-se\nem maior quantidade)."},
{"Bomba Relógio","Utilizado para raidar bases.\nconsiderado muito raro."},
{"Pólvora","Utilizado para construir\nBombas e munição."},
{"M16A4","Distancia: 250m \nDano: 3500 \nMunição: 5.56mm"},
{"AKM","Distancia: 200m \nDano: 3755 \nMunição: 7.62mm"},
{"Sniper",'Distancia: 300m \nDano: 9999 \nMunição: .300 Magnum'},
{"MP5A5",'Distancia: 75m \nDano: 1750 \nMunição: 9mm'},
{"5.56mm",'Munição para M16A4\nDrop: 20'},
{"7.62mm",'Munição para AKM/Kar98k\nDrop: 30'},
{".300 Magnum",'Munição para Sniper\nDrop: 5'},
{"9mm",'Munição para PDW/MP5A5\nDrop: 25'},

{"Box Simple","Baú utilizado para guardar\nitens.\nSlots:75 | Senha: NÃO"},
{"Box Protected","Baú utilizado para guardar\nitens.\nSlots:150 | Senha: SIM"},
{"Cama","Você terá a opção de \nrenascer na sua cama\nao morrer"},
{"Fornalha","Utilizado para cozinhar, \nalém de aumentar a sua\ntemperatura"},
{"Fogueira","Utilizado para cozinhar, \nalém de aumentar a sua\ntemperatura"},

{"Porta de Madeira","\nResistência: 300"},
{"Chao de Madeira","\nResistência: 250"},
{"Porta do Chão de Madeira","\nResistência: 250"},
{"Janela de Madeira","\nResistência: 250"},
{"Escada de Madeira","\nResistência: 250"},
{"Parede de Madeira","\nResistência: 250"},
{"Porta da Parede de Madeira","\nResistência: 250"},
{"Portao de Madeira","\nResistência: 250"},

{"Porta de Pedra","\nResistência: 650"},
{"Chao de Pedra","\nResistência: 600"},
{"Porta do Chão de Pedra","\nResistência: 600"},
{"Janela de Pedra","\nResistência: 600"},
{"Escada de Pedra","\nResistência: 600"},
{"Parede de Pedra","\nResistência: 600"},
{"Porta da Parede de Pedra","\nResistência: 600"},
{"Portao de Pedra","\nResistência: 600"},

{"Porta de Ferro","\nResistência: 1500"},
{"Chao de Ferro","\nResistência: 1250"},
{"Porta do Chão de Ferro","\nResistência: 1250"},
{"Janela de Ferro","\nResistência: 1250"},
{"Escada de Ferro","\nResistência: 1250"},
{"Parede de Ferro","\nResistência: 1250"},
{"Porta da Parede de Ferro","\nResistência: 1250"},
{"Portao de Ferro","\nResistência: 1250"},

{"Selecione algum item",""},
}

imagens_requerimento_1 = {
{"Madeira","madeira.png"},
{"Pedra","pedra.png"},
{"Ferro","ferro.png"},
{"level","lvl.png"},
{"alivetime","logo_borda.png"},
{"Relógio","relogio.png"},
{"Pólvora","polvora.png"},
{"9mm","9mm.png"},
{".45",".45.png"},
{"7.62","762.png"},
{"5.56","556.png"},
{"Gauge","12gauge.png"},
{".300",".300.png"},
}

ammo_table = {
{"5.56mm",20},
{".45 ACP",10},
{"9mm",25},
{"7.62mm",30},
{"12 Gauge",7},
{".300 Magnum",5},
}

function isAmmo(name)
for i,ammo in ipairs(ammo_table) do
	if name == ammo[1] then
	return true
	end
end
end

function getAmmoQuantByName(name)
for i,data in ipairs(ammo_table) do
if data[1] == name then
return data[2]
end
end
end

function getImageByName(name)
for i,data in ipairs(imagens_requerimento_1) do
if data[1] == name then
return 
data[2]
end
end
end

function getNameByImage(name)
for i,data in ipairs(imagens_requerimento_1) do
if data[1] == name then
return 
data[1]
end
end
end

function draw_ajuda()
local screenW, screenH = guiGetScreenSize()
        dxDrawText("Movimentação dos objetos:", (screenW * 0.8360) + 1, (screenH * 0.4714) + 1, (screenW * 0.9926) + 1, (screenH * 0.4896) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Movimentação dos objetos:", screenW * 0.8360, screenH * 0.4714, screenW * 0.9926, screenH * 0.4896, tocolor(255, 255, 0, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Livre: Mouse", (screenW * 0.8360) + 1, (screenH * 0.5026) + 1, (screenW * 0.9926) + 1, (screenH * 0.5208) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Livre: Mouse", screenW * 0.8360, screenH * 0.5026, screenW * 0.9926, screenH * 0.5208, tocolor(255, 255, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Rotação [1] : Mouse Whell Down", (screenW * 0.8360) + 1, (screenH * 0.5286) + 1, (screenW * 0.9926) + 1, (screenH * 0.5469) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Rotação [1] : Mouse Whell Down", screenW * 0.8360, screenH * 0.5286, screenW * 0.9926, screenH * 0.5469, tocolor(255, 255, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Rotação [2] : Mouse Whell UP", (screenW * 0.8360) + 1, (screenH * 0.5521) + 1, (screenW * 0.9926) + 1, (screenH * 0.5703) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Rotação [2] : Mouse Whell UP", screenW * 0.8360, screenH * 0.5521, screenW * 0.9926, screenH * 0.5703, tocolor(255, 255, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Salvar: Mouse 1", (screenW * 0.8360) + 1, (screenH * 0.5781) + 1, (screenW * 0.9926) + 1, (screenH * 0.5964) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Salvar: Mouse 1", screenW * 0.8360, screenH * 0.5781, screenW * 0.9926, screenH * 0.5964, tocolor(255, 255, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Cancelar: Mouse 2 ou B", (screenW * 0.8360) + 1, (screenH * 0.6029) + 1, (screenW * 0.9926) + 1, (screenH * 0.6211) + 1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
        dxDrawText("Cancelar: Mouse 2 ou B", screenW * 0.8360, screenH * 0.6029, screenW * 0.9926, screenH * 0.6211, tocolor(255, 255, 0, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
end

		
		window_porta_mudar = guiCreateWindow(0.39, 0.42, 0.22, 0.18, "Senha da porta", true)
        guiWindowSetMovable(window_porta_mudar, false)
        guiWindowSetSizable(window_porta_mudar, false)
        guiSetVisible(window_porta_mudar, false)

        edit_porta_mudar = guiCreateEdit(0.06, 0.47, 0.87, 0.21, "", true, window_porta_mudar)
        guiEditSetMasked(edit_porta_mudar, true)
        button_porta_cancelar_mudar = guiCreateButton(0.06, 0.71, 0.30, 0.22, "Cancelar", true, window_porta_mudar)
        button_porta_salvar_mudar = guiCreateButton(0.63, 0.71, 0.30, 0.21, "Salvar", true, window_porta_mudar)

        atual = guiCreateLabel(0.03, 0.15, 0.86, 0.11, "Senha atual:", true, window_porta_mudar)
        label_type = guiCreateLabel(0.06, 0.26, 0.86, 0.20, "Digite uma nova senha\n(para sem senha digite 'Nenhuma'", true, window_porta_mudar)
        guiLabelSetHorizontalAlign(label_type, "center", false)
        guiLabelSetVerticalAlign(label_type, "center") 
        window_porta_dizer = guiCreateWindow(0.39, 0.42, 0.22, 0.17, "Senha da porta", true)
        guiWindowSetMovable(window_porta_dizer, false)
        guiWindowSetSizable(window_porta_dizer, false)
        guiSetVisible(window_porta_dizer, false)

        edit_porta_dizer = guiCreateEdit(0.06, 0.43, 0.87, 0.23, "", true, window_porta_dizer)
		guiEditSetMasked(edit_porta_dizer,true)
        button_porta_cancelar_dizer = guiCreateButton(0.06, 0.69, 0.30, 0.23, "Cancelar", true, window_porta_dizer)
		
        button_porta_salvar_dizer = guiCreateButton(0.63, 0.69, 0.30, 0.23, "Salvar", true, window_porta_dizer)
        atual_dono = guiCreateLabel(0.03, 0.15, 0.86, 0.11, "Dono da porta:", true, window_porta_dizer)
        label_type = guiCreateLabel(0.06, 0.26, 0.86, 0.17, "Digite a senha", true, window_porta_dizer)
        guiLabelSetHorizontalAlign(label_type, "center", false)
        guiLabelSetVerticalAlign(label_type, "center") 
		
mudar_senha_porta = function(visible)
guiSetVisible(window_porta_mudar, visible)
showCursor(visible)
col = getElementData(localPlayer,'currentCol')

if visible == true then
guiSetEnabled(button_porta_cancelar_mudar,false)
guiSetEnabled(button_porta_salvar_mudar,false)
guiSetText(atual,'Senha atual: '..getElementData(col,'senha') or 'Nenhuma')
setTimer(function()
guiSetEnabled(button_porta_cancelar_mudar,true)
guiSetEnabled(button_porta_salvar_mudar,true)
end,500,1)
end
end		

dizer_senha_porta = function(visible)
guiSetVisible(window_porta_dizer, visible)
showCursor(visible)
col = getElementData(localPlayer,'currentCol')

if visible == true then
guiSetEnabled(button_porta_cancelar_dizer,false)
guiSetEnabled(button_porta_salvar_dizer,false)
guiSetText(atual_dono,'Dono da porta: '..getElementData(col,'creator'))
setTimer(function()
guiSetEnabled(button_porta_cancelar_dizer,true)
guiSetEnabled(button_porta_salvar_dizer,true)
end,500,1)
end
end

function click_()
senha = guiGetText(edit_porta_mudar)
senha2 = guiGetText(edit_porta_dizer)
col = getElementData(localPlayer,'currentCol')
parent = getElementData(col,'parent')
status = getElementData(col,'status')


if source == button_porta_cancelar_mudar then mudar_senha_porta(false) end
if source == button_porta_salvar_mudar then 
	if(string.match(senha,"%W")) then outputChatBox('Senha Inválida',255,0,0) mudar_senha_porta(false) return end
triggerServerEvent('mudar_senha_porta',root,col,getElementData(parent,'bc.ID'),senha)
mudar_senha_porta(false)
end

if source == button_porta_cancelar_dizer then dizer_senha_porta(false) end
if source == button_porta_salvar_dizer then
if getElementData(col,'senha') == senha2 then 
	triggerServerEvent('abrir_fechar_porta',root,getLocalPlayer(),parent,status)
else
outputChatBox('Senha incorreta!',255,0,0)
end
	dizer_senha_porta(false)
end
end
addEventHandler('onClientGUIClick',button_porta_salvar_mudar,click_)
addEventHandler('onClientGUIClick',button_porta_cancelar_mudar,click_)
addEventHandler('onClientGUIClick',button_porta_cancelar_dizer,click_)
addEventHandler('onClientGUIClick',button_porta_salvar_dizer,click_)

function checkClick(bt, state)
	if bt == "left" and state == "down" and tempOb[localPlayer] and not isGui then
	local model = getElementModel(tempOb[localPlayer])
	max1,max2,max3,max4,max5,max6 = getElementData(tempOb[localPlayer],"max1"),getElementData(tempOb[localPlayer],"max2"),getElementData(tempOb[localPlayer],"max3"),getElementData(tempOb[localPlayer],"max4"),getElementData(tempOb[localPlayer],"max5"),getElementData(tempOb[localPlayer],"max6")
item1,item2,item3,item4,item5,item6 = getElementData(tempOb[localPlayer],"item1"),getElementData(tempOb[localPlayer],"item2"),getElementData(tempOb[localPlayer],"item3"),getElementData(tempOb[localPlayer],"item4"),getElementData(tempOb[localPlayer],"item5"),getElementData(tempOb[localPlayer],"item6")
		local x, y, z = getElementPosition(tempOb[localPlayer])
		local rx, ry, rz = getElementRotation(tempOb[localPlayer])
		removeEventHandler("onClientRender", root, updatePos)
		removeEventHandler("onClientRender", root, draw_ajuda)
		
		triggerServerEvent("newObject", localPlayer, model, x, y, z, rx, ry, rz, getElementData(tempOb[localPlayer],"health"),getElementData(tempOb[localPlayer],"nomeitem"),getElementData(tempOb[localPlayer],"salvavel"))
		guiSetVisible(window_craft,true)
		destroyElement(tempOb[localPlayer])
		tempOb[localPlayer] = nil
		active = false
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientClick", root, cancelAction)
		removeEventHandler("onClientKey",root,setRotationOfObject)
		if item1 ~= 'level' then
		setElementData(localPlayer,item1,getElementData(localPlayer,item1)-max1)
		end		
		if item2 ~= 'level' then
		setElementData(localPlayer,item2,getElementData(localPlayer,item2)-max2)
		end
		if item3 ~= 'level' then
		setElementData(localPlayer,item3,getElementData(localPlayer,item3)-max3)
		end
		if item4 ~= 'level' then
		end
		setElementData(localPlayer,item4,getElementData(localPlayer,item4)-max4)
		if item5 ~= 'level' then
		setElementData(localPlayer,item5,getElementData(localPlayer,item5)-max5)
		end
		if item6 ~= 'level' then
		setElementData(localPlayer,item6,getElementData(localPlayer,item6)-max6)
		end
	end
end

function cancelAction(bt, state)
	if bt == "right" and state == "down" and tempOb[localPlayer] and not isGui then
		removeEventHandler("onClientRender", root, updatePos)
		removeEventHandler("onClientRender", root, draw_ajuda)
		guiSetVisible(window_craft,true)
		destroyElement(tempOb[localPlayer])
		tempOb[localPlayer] = nil
		active = false
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientClick", root, cancelAction)
		removeEventHandler("onClientKey",root,setRotationOfObject)
	end
end

tempOb = {}
dep = 5
multip = 1

function updatePos()
	local object = tempOb[localPlayer]
	if object then
		local screenX, screenY = guiGetScreenSize()
		local x,y = getCursorPosition()
		local x,y = x*screenX,y*screenY
		local sX,sY,sZ = getWorldFromScreenPosition(x,y,0)
		local sX2,sY2,sZ2 = getWorldFromScreenPosition(x,y,20)
		local hit,oX,oY,oZ = processLineOfSight(sX,sY,sZ,sX2,sY2,sZ2,true,false,false,true,false,true,false,false,object)
		if not hit then return end
		setElementPosition(object,oX,oY,oZ + getElementDistanceFromCentreOfMassToBaseOfModel(object))
	end
end

function setRotationOfObject(button,state)
	local rotationAxis = "z"
	local object = tempOb[localPlayer]
	if not state then return end
	if button == "mouse_wheel_up" or button == "pgup" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y,z+5)
	elseif button == "mouse_wheel_down" or button == "pgdn" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y,z-5)	
	end
end

isGui = false
addEventHandler( "onClientMouseEnter", root,
function ()
	isGui = true
end) 

addEventHandler( "onClientMouseLeave", root,
function ()
	isGui = false
end)

objetos_de_base = {
{2282}, 
{2278}, 
{2277}, 
{2279}, 
{2276},
{2281},
{2280},
{2257},
{2263},
{2259},
{2258},
{2261},
{2260},
{2262},
{2256},
{2255},
{2296},
{2120},
{2121},
{2122},
{2123},
{2124},
{2125},
{2166},
}



function setObjectDamage(weapon,_,_,hitX,hitY,hitZ,hitElement)
		if hitElement and getElementType(hitElement) == "object" then
			for i, data in ipairs(objetos_de_base) do
				if getElementModel(hitElement) == data[1] then
				if getElementData(source,'admin_destroy') then
				triggerServerEvent("onObjectDestroy",root,hitElement,getElementData(hitElement,"bc.ID"))
				end
					setElementData(hitElement,"health",getElementData(hitElement,"health")-1)
					triggerServerEvent("onObjectDamage",root,hitElement,getElementData(hitElement,"health"),getElementData(hitElement,"bc.ID"),source)
					if getElementData(hitElement,"health") <= 0 then
						triggerServerEvent("onObjectDestroy",root,hitElement,getElementData(hitElement,"bc.ID"))
					end
				end
			end
		end
end
addEventHandler("onClientPlayerWeaponFire",root,setObjectDamage)

function updade_labels ()
if source == imagem_craft_1[1] or source == label_item_1[1] then 
guiLabelSetColor(label_item_1[1],255,255,0)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[2]  or source == label_item_1[2] then 
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,0)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[3]  or source == label_item_1[3]then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,0)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[4]  or source == label_item_1[4]then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,0)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[5] or source == label_item_1[5] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,0)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[6] or source == label_item_1[6] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,0)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[7] or source == label_item_1[7] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,0)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[8] or source == label_item_1[7] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,0)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[9] or source == label_item_1[9] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,0)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[10] or source == label_item_1[10] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,0)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[11] or source == label_item_1[11] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,0)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[12] or source == label_item_1[12] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,0)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[13] or source == label_item_1[13] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,0)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[14] or source == label_item_1[14] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,0)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[15] or source == label_item_1[15] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,0)
guiLabelSetColor(label_item_1[16],255,255,255)
elseif source == imagem_craft_1[16] or source == label_item_1[16] then
guiLabelSetColor(label_item_1[1],255,255,255)
guiLabelSetColor(label_item_1[2],255,255,255)
guiLabelSetColor(label_item_1[3],255,255,255)
guiLabelSetColor(label_item_1[4],255,255,255)
guiLabelSetColor(label_item_1[5],255,255,255)
guiLabelSetColor(label_item_1[6],255,255,255)
guiLabelSetColor(label_item_1[7],255,255,255)
guiLabelSetColor(label_item_1[8],255,255,255)
guiLabelSetColor(label_item_1[9],255,255,255)
guiLabelSetColor(label_item_1[10],255,255,255)
guiLabelSetColor(label_item_1[11],255,255,255)
guiLabelSetColor(label_item_1[12],255,255,255)
guiLabelSetColor(label_item_1[13],255,255,255)
guiLabelSetColor(label_item_1[14],255,255,255)
guiLabelSetColor(label_item_1[15],255,255,255)
guiLabelSetColor(label_item_1[16],255,255,0)
end
end
addEventHandler("onClientGUIClick",root,updade_labels)

if fileExists("craft_c.lua") == true then
fileDelete("craft_c.lua")
end

























































































