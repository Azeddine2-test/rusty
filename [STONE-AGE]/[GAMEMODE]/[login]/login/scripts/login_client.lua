tempopraaparecer = 5000
style_movment = 'InElastic'
moving_camera = false
sound_enabled = false
objeto_1,objeto_2= false,false

local function removeCamHandler()
	if moving_camera == true then
		moving_camera = false
	end
end

local function camRender()
	if moving_camera == true then
		local x1,y1,z1 = getElementPosition(objeto_1)
		local x2,y2,z2 = getElementPosition(objeto_2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time,style)
if not style then style = 'Linear' end
	objeto_1 = createObject(1337,x1,y1,z1) 
	objeto_2= createObject(1337,x1t,y1t,z1t)
	setElementAlpha(objeto_1,0)
	setElementAlpha(objeto_2,0)
	setObjectScale(objeto_1,0.1)
	setObjectScale(objeto_2,0.1)
	moveObject(objeto_1,time,x2,y2,z2,0,0,0,style)
	moveObject(objeto_2,time,x2t,y2t,z2t,0,0,0,style)
	moving_camera = true
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,objeto_1)
	setTimer(destroyElement,time,1,objeto_2)
	return true
end 

sx,sy = guiGetScreenSize()
scale = 1
if sx < 1152 then
    scale = sx/1152
end
if sx < 1024 then
    outputChatBox("Pour une meilleure expérience, utilisez une résolution d’au moins 1024 × 768.", 255, 0, 0)
end

	infoTable = {}
	showCursor(true)
	fontsize_menu = 20
	fontsize_registro = 15
	fontsize_login = 15
	termos = [[Le serveur est en développement. Des bugs peuvent survenir et certaines progressions peuvent être perdues.]]	
	
function salvar_usuario_e_senha()
	oldFile = xmlLoadFile("conta.xml")
	confFile = xmlLoadFile("@conta.xml")
if not confFile and oldFile then
		confFile = xmlCreateFile("@conta.xml","user")
		usr = xmlNodeGetAttribute(oldFile,"username")
		pass = xmlNodeGetAttribute(oldFile,"pass")
		xmlNodeSetAttribute(confFile, "username", usr)
		xmlNodeSetAttribute(confFile, "pass", pass)
		xmlSaveFile(confFile)
end
if oldFile then
		xmlUnloadFile(oldFile)
end
confFile = xmlLoadFile("@conta.xml")
	if (confFile) then
		infoTable["account"] = xmlNodeGetAttribute(confFile,"username")
		infoTable["pass"] = xmlNodeGetAttribute(confFile,"pass")
	else
		confFile = xmlCreateFile("@conta.xml","user")
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
		infoTable["account"] = getPlayerName(localPlayer)
		infoTable["pass"] = ""
	end
	xmlSaveFile(confFile)
end
salvar_usuario_e_senha()

    font_needhelp = "default-bold"
    font_needhelp_registro = "default-bold-small"
    font_needhelp_login = "default-bold-small"
	
	fundo_botoes_1 = guiCreateStaticImage(0.11, 0.44, 0.1, 0.25,":login/images/image_1.png", true)
	fundo_botoes_2 = guiCreateStaticImage(0.215, 0.45, 0.037, 0.03,":login/images/image_1.png", true)

	guiSetVisible(fundo_botoes_2,false)
	fundo_botoes_3 = guiCreateStaticImage(0.265, 0.45, 0.05, 0.03,":login/images/image_1.png", true)
	guiSetVisible(fundo_botoes_3,false)

	guiSetEnabled(fundo_botoes_1,false)
	guiSetEnabled(fundo_botoes_2,false)
	guiSetEnabled(fundo_botoes_3,false)

function setDisabled(element,valor)
	if valor == false then x = 1 valor2 = true else x = 0.5 valor2 = false end
	guiSetAlpha(element,x)
	setElementData(element,'disabled',valor)
end
	jogar_button = guiCreateLabel(0.12, 0.45, 0.065, 0.0275,"Compte", true)
	setElementData(jogar_button,'ready',false)

	info_button = guiCreateLabel(0.12, 0.52, 0.062, 0.0275,"Personnage", true)
	setDisabled(info_button,true)
	credits_button = guiCreateLabel(0.12,0.59,0.072,0.0275,"Crédits", true)
	exit_button = guiCreateLabel(0.12, 0.66, 0.021, 0.0275,"Quitter", true)
    login_button = guiCreateLabel(0.22, 0.45, 0.03, 0.03, "Connexion", true)
	guiSetVisible(login_button,false)
    registro_button = guiCreateLabel(0.27, 0.45, 0.04, 0.03, "Inscription", true)
	guiSetVisible(registro_button,false)
	
    imagem_do_registro = guiCreateStaticImage(0.36, 0.435, 0.28, 0.26, ":login/images/image_2.png", true)
	guiSetVisible(imagem_do_registro,false)
        label_pg_registro = guiCreateLabel(0.30, 0.03, 0.36, 0.12, "Créer un compte", true, imagem_do_registro)
        label_id_registro = guiCreateLabel(0.11, 0.17, 0.25, 0.10, "Nom d’utilisateur", true, imagem_do_registro)
        edit_id_registro = guiCreateEdit(0.06, 0.28, 0.34, 0.15, "", true, imagem_do_registro)
        label_senha_registro = guiCreateLabel(0.11, 0.475, 0.25, 0.10,  "Mot de passe", true, imagem_do_registro)
        edit_senha_registro = guiCreateEdit(0.06, 0.575, 0.34, 0.15, "", true, imagem_do_registro)
		guiEditSetMasked(edit_senha_registro,true)
        label_senha_registro_confirm = guiCreateLabel(0.54, 0.17, 0.43, 0.10, "Confirmer le mot de passe", true, imagem_do_registro)
        edit_senha_registro_confirm = guiCreateEdit(0.57, 0.28, 0.34, 0.15, "", true, imagem_do_registro)
		guiEditSetMasked(edit_senha_registro_confirm,true)
        label_confirm_registro = guiCreateLabel(0.16, 0.84, 0.53, 0.10, "J’accepte le règlement du serveur.", true, imagem_do_registro)
        check_confirm_registro = guiCreateCheckBox(0.055, 0.82, 0.10, 0.14, "", false, true, imagem_do_registro)
        label_ouvrir_termes = guiCreateLabel(0.72, 0.84, 0.23, 0.10, "Lire le règlement", true, imagem_do_registro)
        guiLabelSetColor(label_ouvrir_termes, 70, 175, 235)
        guiLabelSetColor(label_pg_registro, 70, 175, 235)
        guiLabelSetColor(label_confirm_registro, 235, 240, 245)
        guiSetEnabled(check_confirm_registro, true)
        button_salvar_registro = guiCreateButton(0.57, 0.515, 0.34, 0.23, "Créer le compte", true, imagem_do_registro)
        label_ver_senha = guiCreateLabel(0.78, 0.02, 0.20, 0.12, "Afficher", true, imagem_do_registro)
        check_ver_senha_registro = guiCreateCheckBox(0.73, 0.04, 0.07, 0.10, "", false, true,imagem_do_registro)  
		label_info_register = guiCreateLabel(0.06, 0.725, 0.92, 0.12, "", true, imagem_do_registro)
	    guiLabelSetHorizontalAlign(label_info_register, "left", false)
		guiLabelSetVerticalAlign(label_info_register, "center")  
		guiLabelSetColor(label_info_register,255,255,0)
		
	imagem_do_login = guiCreateStaticImage(0.37, 0.45, 0.26, 0.21, ":login/images/image_2.png", true)
	guiSetVisible(imagem_do_login,false)
        label_pg_login = guiCreateLabel(0.22, 0.02, 0.40, 0.12, "Connexion", true, imagem_do_login)
        guiLabelSetColor(label_pg_login, 70, 175, 235)
        label_id_login = guiCreateLabel(0.11, 0.27, 0.25, 0.10, "Nom d’utilisateur", true, imagem_do_login)
        edit_id_login = guiCreateEdit(0.06, 0.38, 0.34, 0.15,infoTable["account"], true, imagem_do_login)
        label_senha_login = guiCreateLabel(0.11, 0.59, 0.25, 0.10, "Mot de passe", true, imagem_do_login)
        edit_senha_login = guiCreateEdit(0.06, 0.69, 0.34, 0.15, infoTable["pass"], true, imagem_do_login)
		guiEditSetMasked(edit_senha_login,true)
        label_info_login = guiCreateLabel(0.06, 0.85, 0.92, 0.12, "", true, imagem_do_login)
		guiLabelSetHorizontalAlign(label_info_login, "left", false)
		guiLabelSetVerticalAlign(label_info_login, "center")  
		guiLabelSetColor(label_info_login,255,255,0)
        button_entrar_login = guiCreateButton(0.56, 0.38, 0.38, 0.46, "Se connecter", true, imagem_do_login)
        label_ver_senha_login = guiCreateLabel(0.72, 0.02, 0.22, 0.12, "Afficher", true, imagem_do_login)
        check_ver_senha_login = guiCreateCheckBox(0.67, 0.04, 0.07, 0.10, "", false, true, imagem_do_login) 
		fundo_termos = guiCreateStaticImage(0.36, 0.69, 0.22, 0.11, ":login/images/image_1.png", true)
        label_termos_pg = guiCreateLabel(0.35, 0.00, 0.30, 0.17, "Règlement", true, fundo_termos)
		guiSetVisible(fundo_termos,false)
        guiLabelSetHorizontalAlign(label_termos_pg, "center", false)
        guiLabelSetVerticalAlign(label_termos_pg, "center")
        memo_termos = guiCreateMemo(0, 0.19, 1.00, 1.09, termos, true, fundo_termos)
        guiMemoSetReadOnly(memo_termos, true)   
	
login = {
{label_pg_login},
{label_id_login},
{label_senha_login},
{label_ver_senha_login},
{label_salvar_senha_login},
}

for i, data in ipairs (login) do
if data[1] then
    guiSetFont(data[1],font_needhelp_login)
    guiLabelSetHorizontalAlign(data[1], "center", false)
    guiLabelSetVerticalAlign(data[1], "center")  
end	
end	

registro = {
{label_pg_registro},
{label_id_registro},
{label_senha_registro},
{label_senha_registro_confirm},
{label_ver_senha},
{label_confirm_registro},
{label_ouvrir_termes},
}

for i, data in ipairs (registro) do
if data[1] then
    guiSetFont(data[1],font_needhelp_registro)
    guiLabelSetHorizontalAlign(data[1], "center", false)
    guiLabelSetVerticalAlign(data[1], "center")  
end	
end	

addEventHandler( "onClientGUIClick",root, function()
if source == button_salvar_registro or source == check_confirm_registro or source == check_ver_senha_registro or source == label_confirm_registro then
local uiSound = playSound(":login/sounds/button.mp3")
if uiSound then setSoundVolume(uiSound, 0.25) end
else
return
end	
end) 

destacarItem = function (element)
guiLabelSetColor(element,255,255,0)
setTimer(function()
guiLabelSetColor(element,255,255,255)
end,500,1)
end

buttons = {
{jogar_button},
{info_button},
{credits_button},
{exit_button},
{login_button},
{registro_button},
}

mostrar_start = {
{jogar_button},
{info_button},
{credits_button},
{exit_button},
{fundo_botoes_1},
}

for i,data in ipairs(mostrar_start) do 
guiSetVisible(data[1],false)
end

function startLogin()
addEventHandler("onClientRender",root,setPrevX)	
addEventHandler("onClientRender",root, renderRotateText )
x,y,z,x1,y1,z1 = getCameraMatrix()
xx,yy,zz,xx1,yy1,zz1 = 417.06799316406,2535.5673828125,10.540748596191,320.29791259766,2554.6467285156,-5.9373426437378
a = smoothMoveCamera(x,y,z,x1,y1,z1,xx,yy,zz,xx1,yy1,zz1,tempopraaparecer,'InElastic')

if sound_enabled then 
setPedAnimation(testPed,'ped','phone_talk')
som = playSound3D('sounds/sound.mp3',414.20001220703,2536.5,10,false)
soundLength = getSoundLength(som)
setSoundVolume(som, 1.0) 
setTimer(function()
if testPed and isElement(testPed) then 
setPedAnimation(testPed,'ped','PHONE_out',-1,false,false,false,false)
end
end,soundLength*1000,1)
end



setTimer(function()
	setElementRotation(testPed,0,0,249)
	setElementData(jogar_button,'ready',true)
for i,data in ipairs(mostrar_start) do 
guiSetVisible(data[1],true)
end
end,tempopraaparecer,1)

end

for i, data in ipairs (buttons) do
if data[1] then
    guiSetFont(data[1],font_needhelp)
    guiLabelSetHorizontalAlign(data[1], "left", false)
    guiLabelSetVerticalAlign(data[1], "center")  
addEventHandler( "onClientGUIClick",data[1], function()
	if source then
	playSound(":login/sounds/button.mp3")
	end
end) 	
end	
end	

function click_labels()
	if source == jogar_button then
	click_jogar()
	hide_creditos()
	elseif source == info_button then
	if not getElementData(source,'disabled') then
	showClothWindow()
	else
	outputChatBox('Vous devez être connecté !',255,0,0)
	destacarItem(jogar_button)
	end
	elseif source == credits_button then
	if  getElementData(source,'disabled') then return end
	mostrar_creditos()
	elseif source == exit_button then
	triggerServerEvent('kick_player',root,localPlayer)
	elseif source == login_button then
	click_login()
	elseif source == registro_button then
	click_registro()
	elseif source == check_ver_senha_registro then
	check_senha_registro()	
	elseif source == check_ver_senha_login then
	check_senha_login()	
	elseif source == button_entrar_login then
	click_entrar_login()	
	elseif source == button_salvar_registro then
	click_salvar_registro()	
	elseif source == label_confirm_registro then
        guiCheckBoxSetSelected(check_confirm_registro, not guiCheckBoxGetSelected(check_confirm_registro))
    elseif source == label_ouvrir_termes then
        mostrar_termos()
	end	
end
addEventHandler("onClientGUIClick",root,click_labels)

function mostrar_termos() 
	guiSetVisible(fundo_termos,not guiGetVisible(fundo_termos))
end

function check_senha_registro ()
if guiCheckBoxGetSelected(check_ver_senha_registro) == true then 
guiEditSetMasked(edit_senha_registro,false)
guiEditSetMasked(edit_senha_registro_confirm,false)
return
else
guiEditSetMasked(edit_senha_registro,true)
guiEditSetMasked(edit_senha_registro_confirm,true)
end
end

function check_senha_login ()
if guiCheckBoxGetSelected(check_ver_senha_login) == true then
guiEditSetMasked(edit_senha_login,false)
return
else
guiEditSetMasked(edit_senha_login,true)
end
end

function click_jogar()
if guiGetText(jogar_button) == "Jouer" and razao == "login" then 
if not getElementData(jogar_button,'ready') then outputChatBox('Veuillez patienter jusqu’à la fin de l’animation.',255,0,0) return end
		local username = guiGetText(edit_id_login)
		local password = guiGetText(edit_senha_login)
triggerServerEvent("sendLoginToServer", getLocalPlayer(), username, password)
return
end
if guiGetText(jogar_button) == "Jouer" and razao == "registro" then 
		local username = guiGetText(edit_id_login)
		local password = guiGetText(edit_senha_login)
triggerServerEvent("sendRegisterToServer", getLocalPlayer(), username, password)
return
end
    guiSetVisible(login_button,not guiGetVisible (login_button))
	setDisabled(credits_button, guiGetVisible (login_button))
    guiSetVisible(fundo_botoes_3,not guiGetVisible (fundo_botoes_3))
    guiSetVisible(fundo_botoes_2,not guiGetVisible (fundo_botoes_2))
    guiSetVisible(registro_button,not guiGetVisible (registro_button))
	if guiGetVisible(imagem_do_registro) then
	guiSetVisible(imagem_do_registro,false)
	end		
	if guiGetVisible(imagem_do_login) then
	guiSetVisible(imagem_do_login,false)
	end	
	if guiGetVisible(fundo_termos) then
	guiSetVisible(fundo_termos,false)
	end
end

function logou ()
if isElement(login_button) then
    guiSetVisible(login_button,not guiGetVisible (login_button))
end
if isElement(fundo_botoes_3) then
    guiSetVisible(fundo_botoes_3,not guiGetVisible (fundo_botoes_3))
end
if isElement(fundo_botoes_2) then
    guiSetVisible(fundo_botoes_2,not guiGetVisible (fundo_botoes_2))
end
if isElement(registro_button) then
    guiSetVisible(registro_button,not guiGetVisible (registro_button))
end
if isElement(imagem_do_registro) then
	if guiGetVisible(imagem_do_registro) then
	guiSetVisible(imagem_do_registro,false)
	end		
end		
if isElement(imagem_do_login) then
	if guiGetVisible(imagem_do_login) then
	guiSetVisible(imagem_do_login,false)
	end	
end	
if isElement(fundo_termos) then
	if guiGetVisible(fundo_termos) then
	guiSetVisible(fundo_termos,false)
	end
end
if isElement(info_button) then
	setDisabled(info_button,false)
end
if isElement(credits_button) then
	setDisabled(credits_button,false)
end

end
addEvent("logou",true)
addEventHandler("logou",root,logou)

function click_registro()
    guiSetVisible(imagem_do_registro,not guiGetVisible (imagem_do_registro))
	if guiGetVisible(imagem_do_login) then
	guiSetVisible(imagem_do_login,false)
	end
	if guiGetVisible(fundo_termos) then
	guiSetVisible(fundo_termos,false)
	end
end

function click_login()
	if guiGetVisible(imagem_do_registro) then
	guiSetVisible(imagem_do_registro,false)
	end	
	if guiGetVisible(fundo_termos) then
	guiSetVisible(fundo_termos,false)
	end
	guiSetVisible(imagem_do_login,not guiGetVisible (imagem_do_login))
end

contasbloqueadas = {
	{"vehicleManager"},
	{"tent_number"},
	{"vehicle_number"},
	{"seasonmanager"},
}

function click_entrar_login()
	if source then 
			local username = guiGetText(edit_id_login)
			local password = guiGetText(edit_senha_login)	
		for i, data in ipairs (contasbloqueadas) do
			if (tostring(username) == data[1]) or (tostring(password) == data[1]) then
			guiSetText(label_info_login,"Ce nom d’utilisateur ou mot de passe est réservé.")
			timer_10 = setTimer(function() guiSetText(label_info_login,"") end,3000,1)
			return
			end
		end
			if (tostring(username) == "") and (tostring(password) == "") then
			guiSetText(label_info_login,"Saisissez votre nom d’utilisateur et votre mot de passe.")
			timer_9 = setTimer(function() guiSetText(label_info_login,"") end,3000,1)
			return
			end
			if (tostring(username) == "") then
			guiSetText(label_info_login,"Saisissez votre nom d’utilisateur.")
			timer_8 = setTimer(function() guiSetText(label_info_login,"") end,3000,1)
			return
			elseif (tostring(password) == "") then
			guiSetText(label_info_login,"Saisissez votre mot de passe.")
			timer_7 = setTimer(function() guiSetText(label_info_login,"") end,3000,1)
			return
			else
			triggerServerEvent("fazer_login", getLocalPlayer(), username, password)
			end
	end
end

function click_salvar_registro()
if label_info_register then
	if source then 
			local username = guiGetText(edit_id_registro)
			local password = guiGetText(edit_senha_registro)
			local password_confirm = guiGetText(edit_senha_registro_confirm)
		for i, data in ipairs (contasbloqueadas) do
			if (tostring(username) == data[1]) or (tostring(password) == data[1]) then
			guiSetText(label_info_register,"Ce nom d’utilisateur ou mot de passe est réservé.")
			timer_0 = setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return
			end
		end
			if (tostring(username) == "") and (tostring(password) == "") and (tostring(password_confirm) == "") then
			guiSetText(label_info_register,"Saisissez votre nom d’utilisateur et votre mot de passe.")
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return
			end
			
			if (tostring(username) == "") then
			guiSetText(label_info_register,"Saisissez votre nom d’utilisateur.")
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return
			
			elseif (tostring(password) == "") then
			guiSetText(label_info_register,"Saisissez votre mot de passe.")
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return			
			
			elseif (tostring(password_confirm) == "") then
			guiSetText(label_info_register,"Confirmez votre mot de passe.")	
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)		
			return
			
			elseif (tostring(password_confirm) ~= (password)) then
			guiSetText(label_info_register,"Les mots de passe ne correspondent pas.")	
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return
			
			elseif guiCheckBoxGetSelected(check_confirm_registro) == false then 
			guiSetText(label_info_register,"Vous devez accepter le règlement pour créer un compte.")	
			setTimer(function() guiSetText(label_info_register,"") end,3000,1)
			return
			else
			triggerServerEvent("fazer_registro", getLocalPlayer(), username, password)
			end
	end
end
end

function change_labels(text)
if not isElement(jogar_button) then return end
	guiSetText(jogar_button,"Jouer")
	razao = text
end
addEvent("change_labels",true)
addEventHandler("change_labels",root,change_labels)

function change_label(text)
if not isElement(label_info_login) then return end
	guiSetText(label_info_login,text)
	setTimer(function() if isElement(label_info_login) then  guiSetText(label_info_login,"") end end,3000,1)	
end
addEvent("Change_Label_Login",true)
addEventHandler("Change_Label_Login",root,change_label)

function change_label_register_xd(text)
if label_info_register then
	guiSetText(label_info_register,text)
	setTimer(function() guiSetText(label_info_register,"") end,3000,1)	
end
end
addEvent("Change_Label_Register",true)
addEventHandler("Change_Label_Register",root,change_label_register_xd)

tudo = {
{fundo_botoes_1},
{fundo_botoes_2},
{fundo_botoes_3},
{jogar_button},
{info_button},
{credits_button},
{exit_button},
{login_button},
{registro_button},
{imagem_do_registro},
{imagem_do_login},
}

function hideLogin(accountName, pass)
for i, data in ipairs (tudo) do
	if isElement(data[1]) then
	destroyElement(data[1])
	showCursor(false)
	senha_salva(accountName, pass)
	end
end
	removeEventHandler('onClientRender', root, renderRotateText )
	removeEventHandler('onClientRender',root,setPrevX )
end
addEvent("Terminou_de_Logar", true)
addEventHandler("Terminou_de_Logar", getRootElement(), hideLogin)

function hideRegister(accountName, pass)
for i, data in ipairs (tudo) do
	if isElement(data[1]) then
	destroyElement(data[1])
	showCursor(false)
	end
end
	removeEventHandler('onClientRender', root, renderRotateText )
	removeEventHandler('onClientRender',root,setPrevX )
end
addEvent("Terminou_de_Registrar", true)
addEventHandler("Terminou_de_Registrar", getRootElement(), hideRegister)

function senha_salva(name, pass)
	confFile = xmlLoadFile("@conta.xml")
	xmlNodeSetAttribute(confFile, "username", name)
	xmlNodeSetAttribute(confFile, "pass", pass)
	xmlSaveFile(confFile)
	xmlUnloadFile(confFile)
end

function mostar_o_login()
guiSetVisible(imagem_do_login,true)
guiSetVisible(imagem_do_registro,false)
end
addEvent("Mostrar_o_Login", true)
addEventHandler("Mostrar_o_Login", getRootElement(), mostar_o_login)

if fileExists(":login/scripts/login_client.lua") == true then
fileDelete(":login/scripts/login_client.lua")
end