local spalteGuiText = {}
local spalteGuiImage = {}

		window_confirm_Remove = guiCreateWindow(0.40, 0.42, 0.19, 0.09, "Tem certeza que deseja remover [] ", true)
        guiWindowSetMovable(window_confirm_Remove, false)
        guiWindowSetSizable(window_confirm_Remove, false)
        guiSetVisible(window_confirm_Remove, false)
        guiSetProperty(window_confirm_Remove, "AlwaysOnTop", "True") 
		
        button_cancel_confirm = guiCreateButton(0.04, 0.4, 0.39, 0.5, "Cancelar", true, window_confirm_Remove)
        button_OK_confirm = guiCreateButton(0.58, 0.4, 0.39, 0.5, "Sim",true, window_confirm_Remove)


		
function showConfirm(text,state)
showCursor(state)
guiSetVisible(window_confirm_Remove,state)
guiSetText(window_confirm_Remove,'Tem certeza que deseja remover ['..text..'] ?')
lock_unlock(window_confirm_Remove)
end	

function hide_confirm_window()
showCursor(false)
guiSetVisible(window_confirm_Remove,false)
end
addEvent('hide_confirm_window',true)
addEventHandler('hide_confirm_window',root,hide_confirm_window)
	

clicking = function ()

col = getElementData(getLocalPlayer(),"currentCol")
if source == button_cancel_confirm then showConfirm('fechar',false) end

if source == button_OK_confirm then 
	if getElementData(col,'tent') then 
		triggerServerEvent("RemoveObject",getLocalPlayer(),getElementData(col,"parent"))
		triggerEvent ("displayClientInfo",getLocalPlayer(),"cama","Você destruiu esta box.",255,255,0,255)
	elseif getElementData(col,'cama') then
		triggerServerEvent("onCamaDestroy",getLocalPlayer(),getElementData(col,"parent"))
		triggerEvent ("displayClientInfo",getLocalPlayer(),"cama","Você destruiu esta cama.",255,255,0,255)
	end
showConfirm('fechar',false)
end

end
	
addEventHandler('onClientGUIClick',button_cancel_confirm,clicking,false)
addEventHandler('onClientGUIClick',button_OK_confirm,clicking,false)

	
		
		

local optionsTable = {
["player"] = {
{"Give Painkillers"},
{"Give Bandagem"},
{"Give Morphine"},
},
}

armas_lock = {
{23},
{22},
{24},
{28},
{29},
{30},
{31},
{25},
{26},
{27},
{34},
{33},
{35},
{46},
{17},
{16},
{43},
}

objeto_de_base = {
{"Porta de Madeira", 2282},
{"Chao de Madeira", 2278},
{"Porta do Chão de Madeira", 2277},
{"Janela de Madeira", 2279},
{"Escada de Madeira", 2276},
{"Parede de Madeira", 2281},
{"Porta da Parede de Madeira", 2280},
{"Portao de Madeira", 2257},

{"Porta de Pedra", 2263},
{"Chao de Pedra", 2259},
{"Porta do Chão de Pedra", 2258},
{"Janela de Pedra", 2261},
{"Escada de Pedra", 2260},
{"Parede de Pedra", 2262},
{"Porta da Parede de Pedra", 2256},
{"Portao de Pedra", 2255},

{"Porta de Ferro", 2096},
{"Chao de Ferro", 2120},
{"Porta do Chão de Ferro", 2121},
{"Janela de Ferro", 2122},
{"Escada de Ferro", 2123},
{"Parede de Ferro", 2124},
{"Porta da Parede de Ferro", 2125},
{"Portao de Ferro", 2166},
}

fonte = guiCreateFont( ":Rusty/fonts/font.ttf", 8 )



spalteGuiImage[1] = guiCreateStaticImage(0.005, 0.45, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[1] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[1])
spalteGuiImage[2] = guiCreateStaticImage(0.005, 0.472, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[2] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[2])
spalteGuiImage[3] = guiCreateStaticImage(0.005, 0.492, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[3] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[3])
spalteGuiImage[4] = guiCreateStaticImage(0.005, 0.513, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[4] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[4])
spalteGuiImage[5] = guiCreateStaticImage(0.005, 0.534, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[5] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[5])
spalteGuiImage[6] = guiCreateStaticImage(0.005, 0.555, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[6] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[6])
spalteGuiImage[7] = guiCreateStaticImage(0.005, 0.576, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[7] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[7])
spalteGuiImage[8] = guiCreateStaticImage(0.005, 0.597, 0.105, 0.02, ":Rusty/images/itens/logo.png", true)
spalteGuiText[8] = guiCreateLabel(0.03, 0.00, 0.97, 1.00, "", true,spalteGuiImage[8])

for i = 1,8 do 
   guiSetFont(spalteGuiText[i],fonte)
   guiSetVisible(spalteGuiImage[i],false)
end

function showClientMenuItem(arg1,arg2,arg3,arg4)
    number = 0
    if arg1 == "Take" then
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Pegar "..arg2
        guiSetText(spalteGuiText[number],texto)
        if number == 1 then
            guiLabelSetColor (spalteGuiText[number],255,255,0)
            setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
        setElementData(spalteGuiText[number],"usedItem",arg2)
    end
    if arg1 == "stop" then
        disableMenu()
        refreshLoot(false)
    end
    if arg1 == "Helicrashsite" then
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Checar (Helicrash)"
        guiSetText(spalteGuiText[number],texto)
        if number == 1 then
            guiLabelSetColor (spalteGuiText[number],255,255,0)
            setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
        setElementData(spalteGuiText[number],"usedItem","helicrashsite")
    end
    if arg1 == "Hospitalbox" then --
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Checar (Caixa Médica)"
        guiSetText(spalteGuiText[number],texto)
        if number == 1 then
            guiLabelSetColor (spalteGuiText[number],255,255,0)
            setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
        setElementData(spalteGuiText[number],"usedItem","hospitalbox")
    end
    if arg1 == "Vehicle" then
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Checar ("..arg2..")"
        guiSetText(spalteGuiText[number],texto)
        setElementData(spalteGuiText[number],"markedMenuItem",true)
        setElementData(spalteGuiText[number],"usedItem","vehicle")
        if getElementData(getElementData(arg3,"parent"),"tent") then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
			texto = "Remover Box"
            guiSetText(spalteGuiText[number],texto)
            setElementData(spalteGuiText[number],"usedItem","tent")
            return
        end
		fuel = getElementData(getElementData(arg3,"parent"),"fuel")
		if fuel < getVehicleMaxFuel(getElementData(arg3,"parent")) then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
			texto = "Abastecer ("..math.floor(fuel).."/"..getVehicleMaxFuel(getElementData(arg3,"parent"))..")"
            guiSetText(spalteGuiText[number],texto)
            setElementData(spalteGuiText[number],"usedItem","add_fuel")
        end		
		if getElementHealth(arg3) < 1000 and getElementHealth(arg3) >= 50 then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
			vida = (getElementHealth(arg3)/10)
			texto = "Reparar ("..math.floor(vida).."%)"
            guiSetText(spalteGuiText[number],texto)
            setElementData(spalteGuiText[number],"usedItem","repairvehicle")
        end
		max_tire,max_engine,max_parts = getVehicleAddonInfos(getElementModel(arg3))
		tire = getElementData(getElementData(arg3,"parent"),"Tire_inVehicle")
		if tire > 0 then
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Remover Pneu ["..tire.."/"..max_tire.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","remove_tire")
		end		
		engine = getElementData(getElementData(arg3,"parent"),"Engine_inVehicle")
		if engine > 0 then
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Remover Motor ["..engine.."/"..max_engine.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","remove_engine")
		end		
		parts = getElementData(getElementData(arg3,"parent"),"Parts_inVehicle")
		if parts > 0 then
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Remover Tank ["..parts.."/"..max_parts.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","remove_tank")
		end
		if tire < max_tire then -- <max_tire
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Adicionar Pneu ["..tire.."/"..max_tire.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","add_tire")
		end		
		if engine < max_engine then -- <max_engine
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Adicionar Motor ["..engine.."/"..max_engine.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","add_engine")
		end		
		if parts < max_parts then -- <max_parts
			number = number+1
			guiSetVisible(spalteGuiImage[number],true)
			texto = "Adicionar Tank ["..parts.."/"..max_parts.."]"
			guiSetText(spalteGuiText[number],texto)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
			setElementData(spalteGuiText[number],"usedItem","add_tank")
		end
		if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
    end
    if arg1 == "Player" then
	if not arg2 or not isElement(arg2) then return end
        if getElementData(arg2,"bleeding") and getElementData(arg2,"bleeding") > 0 and getElementData(getLocalPlayer(),"Bandagem") >= 1 then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
			texto = "Usar Bandagem"
            guiSetText(spalteGuiText[number],texto)
            guiLabelSetColor (spalteGuiText[1],255,255,0)
            setElementData(spalteGuiText[1],"markedMenuItem",true)
            setElementData(spalteGuiText[number],"usedItem","give_bandagem")
        end    
        if getElementData(arg2,"blood") and getElementData(arg2,"blood") < 9900 and getElementData(getLocalPlayer(),"Primeiros Socorros") and getElementData(getLocalPlayer(),"Primeiros Socorros") >= 1 then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
				texto = "Usar Primeiros Socorros"
            guiSetText(spalteGuiText[number],texto)    
            setElementData(spalteGuiText[number],"usedItem","giveblood")
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
        end
    end
    if arg1 == "Dead" then
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Checar ("..arg2..")"
        guiSetText(spalteGuiText[number],texto)
        if number == 1 then
            guiLabelSetColor (spalteGuiText[number],255,255,0)
            setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
        setElementData(spalteGuiText[number],"usedItem","dead")
        number = number+1
		texto = "Checar Corpo"
        guiSetText(spalteGuiText[number],texto)
        setElementData(spalteGuiText[number],"usedItem","deadreason")
        guiSetVisible(spalteGuiImage[number],true)        
		number = number+1
		texto = "Queimar Corpo"
        guiSetText(spalteGuiText[number],texto)
        setElementData(spalteGuiText[number],"usedItem","queimar_corpo")
        guiSetVisible(spalteGuiImage[number],true)

    end
    if arg1 == "fornalha" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		if getElementData(arg2,'fire') then
		texto = "Apagar Fornalha"
		setElementData(spalteGuiText[number],"usedItem","apagar_fornalha")
		else
		texto = "Acender Fornalha"
		setElementData(spalteGuiText[number],"usedItem","acender_fornalha")
		end
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
				number = number+1
				guiSetVisible(spalteGuiImage[number],true)
				texto = "Destruir Fornalha"
				guiSetText(spalteGuiText[number],texto)
                setElementData(spalteGuiText[number],"usedItem","destroyFornalha")
		if getElementData(arg2,'fire') then
			if getElementData(getLocalPlayer(),"Carne Crua") >= 1 then
				number = number+1
				guiSetVisible(spalteGuiImage[number],true)
				texto = "Cozinhar Carne"
				guiSetText(spalteGuiText[number],texto)
                setElementData(spalteGuiText[number],"usedItem","cozinhar_carne")
			end
		end    
    end      
	if arg1 == "fogueira" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		if getElementData(arg2,'fire') then
		texto = "Apagar Fogueira"
		setElementData(spalteGuiText[number],"usedItem","apagar_fornalha")
		else
		texto = "Acender Fogueira"
		setElementData(spalteGuiText[number],"usedItem","acender_fornalha")
		end
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
				number = number+1
				guiSetVisible(spalteGuiImage[number],true)
				texto = "Destruir Fogueira"
				guiSetText(spalteGuiText[number],texto)
                setElementData(spalteGuiText[number],"usedItem","destroyFornalha")
		if getElementData(arg2,'fire') then
			if getElementData(getLocalPlayer(),"Carne Crua") >= 1 then
				number = number+1
				guiSetVisible(spalteGuiImage[number],true)
				texto = "Cozinhar Carne"
				guiSetText(spalteGuiText[number],texto)
                setElementData(spalteGuiText[number],"usedItem","cozinhar_carne")
			end
		end    
    end    
	if arg1 == "patrol" then
        if getElementData(getLocalPlayer(),"Galão Vazio") >= 1 then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Encher (Galão)"
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","patrolstation")
        end    
    end
    if arg1 == "Wirefence" then
        if getElementData(getLocalPlayer(),"Caixa de Ferramentas") >= 1 then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Remover Barricada"
            guiSetText(spalteGuiText[number],texto)		
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","wirefence")
        end    
    end    
	if arg1 == "arvore_1" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Derrubar Arvore"
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","arvore_1")
		number = number+1
		texto = "Pegar Frutos"
        guiSetText(spalteGuiText[number],texto)
        guiSetVisible(spalteGuiImage[number],true)
        setElementData(spalteGuiText[number],"usedItem","fruto_arvore_1")
    end	
	if arg1 == "pedra" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Quebrar Pedra"
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","pedra")
    end		
	if arg1 == "ferro" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Quebrar Ferro"
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","ferro")
    end		
	if arg1 == "cama" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Destruir"
            guiSetText(spalteGuiText[number],texto)
	
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
                setElementData(spalteGuiText[number],"usedItem","destruir_cama")    
    end		
	if arg1 == "planta" then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
			texto = "Pegar Frutos"
            guiSetText(spalteGuiText[number],texto)
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
        setElementData(spalteGuiText[number],"usedItem","frutos")
		number = number+1
		texto = "Pegar Sementes"
        guiSetText(spalteGuiText[number],texto)		
        guiSetVisible(spalteGuiImage[number],true)
        setElementData(spalteGuiText[number],"usedItem","Sementes") 
    end	
	if arg1 == "objeto_de_base" then
		if arg2 == 'Porta' then
		if getElementData(arg3,'status') == 'fechada' then
            number = number+1
            guiSetVisible(spalteGuiImage[number],true)
		texto = "Abrir"
            guiSetText(spalteGuiText[number],texto)	
            if number == 1 then
                guiLabelSetColor (spalteGuiText[number],255,255,0)
                setElementData(spalteGuiText[number],"markedMenuItem",true)
            end
        setElementData(spalteGuiText[number],"usedItem","abrir_fechar_porta")	
		end
		number = number+1
		texto = "Destruir"
        guiSetText(spalteGuiText[number],texto)
        guiSetVisible(spalteGuiImage[number],true)
        setElementData(spalteGuiText[number],"usedItem","destruir_item_base")
		
		dono = getElementData(arg3,"creator")
		if dono == getElementData(localPlayer,'accountName') then
		number = number+1
		texto = "Mudar Senha"
        guiSetText(spalteGuiText[number],texto)
        guiSetVisible(spalteGuiImage[number],true)
        setElementData(spalteGuiText[number],"usedItem","mudar_senha_porta")
		end
		
		
		else
		number = number+1
		texto = "Destruir"
        guiSetText(spalteGuiText[number],texto)		
        guiSetVisible(spalteGuiImage[number],true)
        setElementData(spalteGuiText[number],"usedItem","destruir_item_base")	
		end
		
		end	
    if arg1 == "Checar" then
        number = number+1
        guiSetVisible(spalteGuiImage[number],true)
		texto = "Checar"
        guiSetText(spalteGuiText[number],texto)	
        if number == 1 then
            guiLabelSetColor (spalteGuiText[number],255,255,0)
            setElementData(spalteGuiText[number],"markedMenuItem",true)
        end
        setElementData(spalteGuiText[number],"usedItem","itemloot")
    end
end
addEvent("showClientMenuItem",true)
addEventHandler("showClientMenuItem",getLocalPlayer(),showClientMenuItem)




function DestacarItem(id)
for i = 1,8 do 
--guiStaticImageLoadImage(spalteGuiImage[i],':Rusty/images/itens/logo.png')
    guiLabelSetColor (spalteGuiText[i],255,255,255)
	setElementData(spalteGuiText[i],"markedMenuItem",false)
end
setElementData(spalteGuiText[id],"markedMenuItem",true)
guiLabelSetColor(spalteGuiText[id],255,255,0)
--guiStaticImageLoadImage(spalteGuiImage[id],':Rusty/images/itens/logo_borda.png')
end

function PlayerScrollMenu (key,keyState,arg)
    if ( keyState == "down" ) then
        if not guiGetVisible(spalteGuiText[2]) then
            return
        end
        if arg == "up" then
            if getElementData(spalteGuiText[1],"markedMenuItem") then
			return
            elseif getElementData(spalteGuiText[2],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[1]) then DestacarItem(1) else return end
			elseif getElementData(spalteGuiText[3],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[2]) then DestacarItem(2) else return end
			elseif getElementData(spalteGuiText[4],"markedMenuItem") then	
			if guiGetVisible(spalteGuiText[3]) then DestacarItem(3) else return end
			elseif getElementData(spalteGuiText[5],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[4]) then DestacarItem(4) else return end
			elseif getElementData(spalteGuiText[6],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[5]) then DestacarItem(5) else return end
			elseif getElementData(spalteGuiText[7],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[6]) then DestacarItem(6) else return end
			elseif getElementData(spalteGuiText[8],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[7]) then DestacarItem(7) else return end
            end
        elseif arg == "down" then
            if getElementData(spalteGuiText[1],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[2]) then DestacarItem(2) else return end
            elseif getElementData(spalteGuiText[2],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[3]) then DestacarItem(3) else return end
			elseif getElementData(spalteGuiText[3],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[4]) then DestacarItem(4) else return end
			elseif getElementData(spalteGuiText[4],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[5]) then DestacarItem(5) else return end
			elseif getElementData(spalteGuiText[5],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[6]) then DestacarItem(6) else return end
			elseif getElementData(spalteGuiText[6],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[7]) then DestacarItem(7) else return end
			elseif getElementData(spalteGuiText[7],"markedMenuItem") then
			if guiGetVisible(spalteGuiText[8]) then DestacarItem(8) else return end
			elseif getElementData(spalteGuiText[8],"markedMenuItem") then
			return
            end
        end
    end
end
bindKey ( "mouse_wheel_up", "down", PlayerScrollMenu, "up" )
bindKey ( "mouse_wheel_down", "down", PlayerScrollMenu, "down" )

function disableMenu()
for i = 1,8 do 
    guiSetVisible(spalteGuiImage[i],false)
    guiLabelSetColor (spalteGuiText[i],255,255,255)
	setElementData(spalteGuiText[i],"markedMenuItem",false)
end
    setNewbieInfo (false,"","")
end
addEvent("disableMenu",true)
addEventHandler("disableMenu",getLocalPlayer(),disableMenu)

function sound_fogo(x,y,z,state)
if state == true then
uSound = playSound3D( ':Rusty/sounds/fire.mp3', x,y,z,true ) 
setSoundMaxDistance( uSound, 100 )
else
if isElement(uSound) then stopSound(uSound) end
end
end
addEvent('sound_fogo',true)
addEventHandler('sound_fogo',root,sound_fogo)

function corpo_sound(x,y,z,state)
if state == true then
dead_s = playSound3D( ':Rusty/sounds/corpo.ogg', x,y,z ,true) 
setSoundMaxDistance( dead_s, 100 )
else
if isElement(dead_s) then stopSound(dead_s) end
end
end
addEvent('corpo_sound',true)
addEventHandler('corpo_sound',root,corpo_sound)

function sound_Backpack(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/backpack.wav', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('sound_Backpack',true)
addEventHandler('sound_Backpack',root,sound_Backpack)

function sound_Medic(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/bandagem.ogg', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('sound_Medic',true)
addEventHandler('sound_Medic',root,sound_Medic)

function sound_Comendo(stat,x,y,z)
local uSound = playSound3D( ':Rusty/sounds/comendo.ogg', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('sound_Comendo',true)
addEventHandler('sound_Comendo',root,sound_Comendo)

function sound_Cozinhar(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/cozinhando.ogg', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('sound_Cozinhar',true)
addEventHandler('sound_Cozinhar',root,sound_Cozinhar)

function sound_Bebendo(stat,x,y,z)
local uSound = playSound3D( ':Rusty/sounds/bebendo.ogg', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('sound_Bebendo',true)
addEventHandler('sound_Bebendo',root,sound_Bebendo)

function equipWeaponSound(stat,x,y,z)
local uSound = playSound3D( ':Rusty/sounds/equip'..stat..'.wav', x,y,z ) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('equipWeaponSound',true)
addEventHandler('equipWeaponSound',root,equipWeaponSound)


function motor_carro_som(stat,x,y,z)
if isElement(carro_sound) then destroyElement(carro_sound) end
carro_sound = playSound3D( ':Rusty/sounds/'..stat..'.mp3', x,y,z ) 
setSoundMaxDistance( carro_sound, 100 )
end
addEvent('motor_carro_som',true)
addEventHandler('motor_carro_som',root,motor_carro_som)

function dead_sound(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/dead.ogg', x,y,z) 
setSoundMaxDistance( uSound, 100 )
end
addEvent('dead_sound',true)
addEventHandler('dead_sound',root,dead_sound)

function picareta(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/picaretada.mp3', x,y,z ) 
setSoundMaxDistance( uSound, 100)
end
addEvent('picareta',true)
addEventHandler('picareta',root,picareta)

function plantas(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/plantas.mp3', x,y,z ) 
setSoundMaxDistance( uSound, 100)
end
addEvent('plantas',true)
addEventHandler('plantas',root,plantas)

function machadada(x,y,z)
local uSound = playSound3D( ':Rusty/sounds/machadada.mp3', x,y,z ) 
setSoundMaxDistance( uSound, 100)
end
addEvent('machadada',true)
addEventHandler('machadada',root,machadada)

function getPlayerInCol(tab)
    for theKey,thePlayer in ipairs(tab) do
        if thePlayer ~= getLocalPlayer() then
            return true
        end
    end
    return false
end

isInFirePlace = false
function onPlayerTargetPickup (theElement)
    if theElement == getLocalPlayer() then
    if getElementData(source,"parent") == getLocalPlayer() then return end
            local player = getPlayerInCol(getElementsWithinColShape ( source, "player" ))
            if getPedOccupiedVehicle(getLocalPlayer()) then
                return
            end
            isInFirePlace = false
            setElementData(spalteGuiText[2],"markedMenuItem",false)
            setElementData(spalteGuiText[1],"markedMenuItem",true)
            guiLabelSetColor(spalteGuiText[1],255,255,0)
            guiLabelSetColor(spalteGuiText[2],255,255,255)
            if getElementData(source,"player") then
                showClientMenuItem("Player",getElementData(source,"parent"))
                setElementData(getLocalPlayer(),"currentCol",source)
                setElementData(getLocalPlayer(),"inCol",false)
                setElementData(getLocalPlayer(),"loot",false)
                setElementData(getLocalPlayer(),"box",false)
                return
            end
            if player then
                return
            end
            if getElementData(source,"fornalha") then
                setElementData(getLocalPlayer(),"currentCol",source)
                showClientMenuItem("fornalha",getElementData(localPlayer,'currentCol'))
                setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
                setNewbieInfo (true,"Fornalha","",source)
				if getElementData(source,'fire') then
				isInFirePlace = true
				end
                return
            end           
			if getElementData(source,"fogueira") then
                setElementData(getLocalPlayer(),"currentCol",source)
                showClientMenuItem("fogueira",getElementData(localPlayer,'currentCol'))
                setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
                setNewbieInfo (true,"Fogueira","",source)
				if getElementData(source,'fire') then
				isInFirePlace = true
				end
                return
            end            
			if getElementData(source,"patrolstation") then
                showClientMenuItem("patrol")
                setElementData(getLocalPlayer(),"currentCol",source)
                setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
                setNewbieInfo (true,"patrolstation","Press. 'mouse3' para encher!\n REQUER: Galão Vazio",source)
                return
            end
            if getElementData(source,"wirefence") then
                showClientMenuItem("Wirefence")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
                setNewbieInfo (true,"Barricada","Press. 'mouse3' para remover!",source)
                return
            end            
			if getElementData(source,"arvore_1") then
                showClientMenuItem("arvore_1")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				Frutos = getElementData(source,"Maçã")
				madeira = getElementData(source,"Madeira")	
				setNewbieInfo (true,"Arvore","Madeiras: ["..madeira.."]\n   Frutos: ["..Frutos.."]",source)
				setarBind ('mouse1')
				return
            end				
			if getElementData(source,"pedra") then
                showClientMenuItem("pedra")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				pedras = getElementData(source,"Pedra")
                setNewbieInfo (true,"Pedra","Pedras: ["..pedras.."]",source)
				setarBind ('mouse1')
                return
            end			
			if getElementData(source,"ferro") then
                showClientMenuItem("ferro")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				ferros = getElementData(source,"Ferro")
                setNewbieInfo (true,"Ferro","Ferros: ["..ferros.."]",source)
				setarBind ('mouse1')
                return
            end				
			if getElementData(source,"planta") then
                showClientMenuItem("planta")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				Sementes = getElementData(source,"Sementes")
				Frutos = getElementData(source,"Maçã")
                setNewbieInfo (true,"Planta","   Frutos: ["..Frutos.."]\nSementes: ["..Sementes.."]",source)
				setarBind ('mouse1')
                return
            end				
			if getElementData(source,"cama") then
                showClientMenuItem("cama")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				dono = getElementData(source,"creator")
                setNewbieInfo (true,"Cama","   Dono: ["..dono.."]",source)
                return
            end							
			if getElementData(source,"objeto_de_base") then
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
				model = getElementData(source,"id_objeto")
					xd = getElementData(source,"parent")
					for i, data in ipairs (objeto_de_base) do 
						if data[2] == model then
						if data[2] == 2282 or 
						data[2] == 2257 or 
						data[2] == 2255 or 
						data[2] == 2096 or 
						data[2] == 2166 or 
						data[2] == 2263 then
						showClientMenuItem("objeto_de_base",'Porta',getElementData(localPlayer,'currentCol'))						
						else
						showClientMenuItem("objeto_de_base")
						end
						object_health = getElementData(xd,"health")
						setNewbieInfo (true,data[1],"Vida: "..object_health,source)
						end
					end
				return
            end								
            if getElementData(source,"deadman") then
                showClientMenuItem("Dead",getElementData(source,"playername"))
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",true)
                setElementData(getLocalPlayer(),"lootname","Checar ("..getElementData(source,"playername")..")")
                setNewbieInfo (true,"Checar","Press. 'TAB' para abrir o inventario!",source)
                return
            end
            if getElementData(source,"item") then
                showClientMenuItem("Take",getElementData(source,"item"))
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",false)
                setNewbieInfo (true,getElementData(source,"item"),"Press. 'mouse3' para pegar!",source)
                return
            end
            if getElementData(source,"helicrash") then
                showClientMenuItem("Helicrashsite","helicrash")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",true)
                setElementData(getLocalPlayer(),"lootname","Checar (Helicrash)")
                setNewbieInfo (true,"Checar","Press. 'TAB' para abrir o inventario!",source)
                return
            end
            if getElementData(source,"hospitalbox") then
                showClientMenuItem("Hospitalbox","hospitalbox")
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
                setElementData(getLocalPlayer(),"loot",true)
                setElementData(getLocalPlayer(),"lootname","Checar (Hospitalbox)")
                setNewbieInfo (true,"Checar","Press. 'TAB' para abrir o inventario!",source)
                return
            end
	  if getElementData(source,"vehicle") and not getElementData(source,"deadVehicle") then
	  if not getElementData(source,"tent") then
		name = getVehicleNameStoneAge(getElementData(source,"vehicle_ID"))
	  else
		name = "Box"
	  end
	  showClientMenuItem("Vehicle",name,getElementData(source,"parent"),source)
                setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"inCol",true)
				if name == "Box" then 
                setElementData(getLocalPlayer(),"box",true)
				end
                setElementData(getLocalPlayer(),"loot",true)
                setElementData(getLocalPlayer(),"lootname","Checar ("..name..")")
                setNewbieInfo (true,"Checar","Press. 'TAB' para abrir o inventario!",source)
                return
                end
            if getElementData(source,"itemloot") then
                showClientMenuItem("Checar")
                setElementData(getLocalPlayer(),"loot",true)
                setElementData(getLocalPlayer(),"lootname","Checar")
                setElementData(getLocalPlayer(),"currentCol",source)
                setNewbieInfo (true,"Checar","Press. 'TAB' para abrir o inventario!",source)
                return
            end
        showClientMenuItem("stop")
    end  
	
end
addEventHandler("onClientColShapeHit",getRootElement(),onPlayerTargetPickup)

function onPlayerTargetPickup (theElement)
    if theElement == getLocalPlayer() then
        local players = getElementsWithinColShape (source,"player")
        if players == getLocalPlayer() then --[[return ]] end
        showClientMenuItem("stop")
        setElementData(getLocalPlayer(),"loot",false)
        setElementData(getLocalPlayer(),"craft",false)
        setElementData(getLocalPlayer(),"box",false)
        setElementData(getLocalPlayer(),"currentCol",false)
        setNewbieInfo (false,"","")
        isInFirePlace = false
		triggerEvent("hideLootManual",localPlayer)
			triggerEvent("hide_craft_window",localPlayer)
			triggerEvent('hide_config_window',localPlayer)
			triggerEvent('hide_help_window',localPlayer)
			triggerEvent('hide_inventory_window',localPlayer)
			triggerEvent('hide_admin_window',localPlayer)
			triggerEvent('hide_group_window',localPlayer)
			triggerEvent('hide_confirm_window',localPlayer)
		setElementData(getLocalPlayer(),"inCol",false)
		setarBind ('mouse3')
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onPlayerTargetPickup)

local screenWidth, screenHeight = guiGetScreenSize()
local newbieShow = false
local newbieHead = "-"
local newbieText = "-"
local newbiePosition = 0,0,0

function setNewbieInfo (show,head,text,element)
    newbieShow = show
    newbieHead = head
    newbieText = text
    newbiePosition = element
end

font = dxCreateFont(":Rusty/fonts/font.ttf",11)
font_2 = dxCreateFont(":Rusty/fonts/font.ttf",8)

function mostrar_newbie()
    if not newbieShow or newbieShow == false then return end
	if not newbiePosition or not isElement(newbiePosition) then 
        showClientMenuItem("stop")	
	return end
	if newbieShow and newbieHead and newbieText and newbiePosition then
    local x,y,z = getElementPosition(newbiePosition)
    local x,y = getScreenFromWorldPosition (x,y,z)
    local length = dxGetTextWidth(newbieText,1,"default-bold")
	if x and y and z and length then
    --dxDrawRectangle ( x-length/2-screenWidth*0.05,y, screenWidth*0.1+length, screenHeight*0.1, tocolor (255,255,0,100) )
    dxDrawingColorText(newbieHead,x-length/2-screenWidth*0.01,y, x+length/2+screenWidth*0.01, y+screenHeight*0.03, tocolor(255,255,50,255),1, 1, font, "center", "center")
    dxDrawingColorText(newbieText,x-length/2-screenWidth*0.01,y+screenHeight*0.03, x+length/2+screenWidth*0.01, y+screenHeight*0.07, tocolor(255,255,255,255),0.5, 1, font_2, "center", "center")
	end
	end
end
addEventHandler("onClientRender", getRootElement(),mostrar_newbie)

function hide_menu()
newbieShow = false
    showClientMenuItem("stop")
    setNewbieInfo (false,"","")		
	for i = 1,4 do 
		if guiGetVisible(spalteGuiText[i]) then
			guiSetVisible(spalteGuiText[i],false)
		end
	end
end
addEvent("hide_menu",true)
addEventHandler("hide_menu",getRootElement(),hide_menu)

function update_menu()
newbieShow = false
    showClientMenuItem("stop")
    setNewbieInfo (false,"","")		
end
addEvent("update_menu",true)
addEventHandler("update_menu",getRootElement(),update_menu)

function fireRaiseTemperature ()
currentCol = getElementData(localPlayer,'currentCol')
if not currentCol then return end
    if isInFirePlace then
		if getElementData(currentCol,'fire') then
		triggerEvent('interacao',localPlayer,localPlayer,'Merda, me queimei!')
				setElementData(getLocalPlayer(),"bleeding",math.random(30,50))
				setElementData(getLocalPlayer(),"temperature",getElementData(getLocalPlayer(),"temperature")+0.01)
		end
    end
end
setTimer(fireRaiseTemperature,10000,0)

function onPlayerPressMiddleMouse (key,keyState)
    if ( keyState == "down" ) then
        if not guiGetVisible(spalteGuiText[1]) then return end
        local itemName = getMenuMarkedItem()
        if itemName == "helicrashsite" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local ChecarName = "Checar (Helicrash)"
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end
        if itemName == "itemloot" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local ChecarName = "Checar"
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end        
		if itemName == "menu_craft" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end
        if itemName == "wirefence" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local ChecarName = "Remove Wirefence"
            triggerServerEvent("removeWirefence",getLocalPlayer(),getElementData(col,"parent"))
            disableMenu()
            return
        end       
		if itemName == "arvore_1" then

		    if getPlayerCurrentSlots() + getItemSlots("Madeira") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"arvore_1","Voce precisa de mais "..getItemSlots("Madeira").." slot livre",255,0,0,255) disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			madeira,frutos,weapon = getElementData(col,"Madeira"),getElementData(col,"Maçã"),getPedWeapon(localPlayer)
				if weapon == 8 then -- machado
					if madeira == 3 then 
					numberxx,quantidade = math.random(30,50),3 else numberxx,quantidade = math.random(3,5),2
					end
				triggerServerEvent('machadada',root,col)
				elseif weapon == 0 then
				numberxx,quantidade = math.random(1,3),1
				else
				return
				end
			if madeira <= quantidade then
            triggerServerEvent("remover_arvore_1",getLocalPlayer(),getElementData(col,"parent"),col)
			setElementData(col,"Madeira",getElementData(col,"Madeira")-quantidade)
			setElementData(localPlayer,"Madeira", getElementData(localPlayer,"Madeira")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			else
			setElementData(col,"Madeira",getElementData(col,"Madeira")-quantidade)
			setElementData(localPlayer,"Madeira", getElementData(localPlayer,"Madeira")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			setTimer(function()
			if getElementData(getLocalPlayer(),"inCol") then 
			showClientMenuItem("arvore_1")
				setNewbieInfo (true,"Arvore","Madeiras: ["..madeira-quantidade.."]\n   Frutos: ["..Frutos.."]",col)
			return end
			end,1500,1)
			end
            return
        end		
		if itemName == "fruto_arvore_1" then
		    if getPlayerCurrentSlots() + getItemSlots("Maçã") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"arvore_1","Voce precisa de mais "..getItemSlots("Maçã").." slot livre",255,0,0,255)disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			frutos,weapon = getElementData(col,"Maçã"),getPedWeapon(localPlayer)
			numberxx,quantidade = math.random(3,5),1
			if frutos > 0 then
			setElementData(col,"Maçã",getElementData(col,"Maçã")-quantidade)
			setElementData(localPlayer,"Maçã", getElementData(localPlayer,"Maçã")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			setTimer(function()
			if getElementData(getLocalPlayer(),"inCol") then 
			showClientMenuItem("arvore_1")
				setNewbieInfo (true,"Arvore","Madeiras: ["..madeira-quantidade.."]\n   Frutos: ["..Frutos.."]",col)
			return end
			end,1500,1)
			else
            disableMenu()
			end
            return
        end
			if itemName == "pedra" then
		if getPlayerCurrentSlots() + getItemSlots("Pedra") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"pedra","Voce precisa de mais "..getItemSlots("Pedra").." slot livre",255,0,0,255)disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			pedra,weapon = getElementData(col,"Pedra"),getPedWeapon(localPlayer)
				if weapon == 2 then -- Picareta
					if pedra == 3 then 
					numberxx,quantidade = math.random(3,5),3 else numberxx,quantidade = math.random(3,5),2
					end
				triggerServerEvent('pick',root,col)
				elseif weapon == 0 then
				numberxx,quantidade = math.random(1,3),1
				else
				return
				end
			if pedra <= quantidade then
            triggerServerEvent("remover_objeto_pedra",getLocalPlayer(),getElementData(col,"parent"),col)
			setElementData(col,"Pedra",getElementData(col,"Pedra")-quantidade)
			setElementData(localPlayer,"Pedra", getElementData(localPlayer,"Pedra")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			else
			setElementData(col,"Pedra",getElementData(col,"Pedra")-quantidade)
			setElementData(localPlayer,"Pedra", getElementData(localPlayer,"Pedra")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			setTimer(function()
			if getElementData(getLocalPlayer(),"inCol") then 
			showClientMenuItem("pedra")
			    setNewbieInfo (true,"Pedra","Pedras: ["..pedra-quantidade.."]",col)
			return end
			end,1500,1)
			end
            return
		end	
		if itemName == "ferro" then
		if getPlayerCurrentSlots() + getItemSlots("Ferro") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"ferro","Voce precisa de mais "..getItemSlots("Ferro").." slot livre",255,0,0,255)disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			ferro,weapon = getElementData(col,"Ferro"),getPedWeapon(localPlayer)
				if weapon == 2 then -- Picareta
					if ferro == 3 then 
					numberxx,quantidade = math.random(5,10),3 else numberxx,quantidade = math.random(5,10),2
					end
				triggerServerEvent('pick',root,col)
				elseif weapon == 0 then
				numberxx,quantidade = math.random(3,5),1
				else
				return
				end
			if ferro <= quantidade then
            triggerServerEvent("remover_objeto_ferro",getLocalPlayer(),getElementData(col,"parent"),col)
			setElementData(col,"Ferro",getElementData(col,"Ferro")-quantidade)
			setElementData(localPlayer,"Ferro", getElementData(localPlayer,"Ferro")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			else
			setElementData(col,"Ferro",getElementData(col,"Ferro")-quantidade)
			setElementData(localPlayer,"Ferro", getElementData(localPlayer,"Ferro")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
			setTimer(function()
			if getElementData(getLocalPlayer(),"inCol") then 
			showClientMenuItem("ferro")
			    setNewbieInfo (true,"Ferro","Ferros: ["..ferro-quantidade.."]",col)
			return end
			end,1500,1)
			end
            return
		end	
		if itemName == "Sementes" then		
		    if getPlayerCurrentSlots() + getItemSlots("Sementes") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"Sementes","Voce precisa de mais "..getItemSlots("Sementes").." slot livre",255,0,0,255)disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			sementes,frutos,weapon = getElementData(col,"Sementes"),getElementData(col,"Maçã"),getPedWeapon(localPlayer)
			if sementes == 0 then
			disableMenu()
			return end
			for i, data in ipairs(armas_lock) do
			  if weapon == data[1] then return end
			end
					numberxx,quantidade = math.random(3,5),1
			if sementes <= quantidade then
			triggerServerEvent("anim_player_planta",getLocalPlayer())
			setElementData(col,"Sementes",getElementData(col,"Sementes")-quantidade)
			setElementData(localPlayer,"Sementes", getElementData(localPlayer,"Sementes")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
				triggerServerEvent('planta',root,col)
			end
				if getElementData(col,"Sementes") == 0 and getElementData(col,"Maçã") == 0 then
					triggerServerEvent("remover_planta",getLocalPlayer(),getElementData(col,"parent"))
				end
            return			
        end				
		if itemName == "frutos" then
			if getPlayerCurrentSlots()+ getItemSlots("Maçã") > getElementData(getLocalPlayer(),"MAX_Slots") then triggerEvent ("displayClientInfo",localPlayer,"Maçã","Voce precisa de mais "..getItemSlots("Maçã").." slot livre",255,0,0,255)disableMenu()return	end
            local col = getElementData(getLocalPlayer(),"currentCol")
			sementes,frutos,weapon = getElementData(col,"Sementes"),getElementData(col,"Maçã"),getPedWeapon(localPlayer)
			if frutos == 0 then
			disableMenu()
			return end
			for i, data in ipairs(armas_lock) do
			  if weapon == data[1] then return end
			end
			numberxx,quantidade = math.random(3,5),1
			if frutos <= quantidade then
			triggerServerEvent("anim_player_planta",getLocalPlayer())
			setElementData(col,"Maçã",frutos-quantidade)
			setElementData(localPlayer,"Maçã", getElementData(localPlayer,"Maçã")+quantidade)
			setElementData(localPlayer,"experiencia", getElementData(localPlayer,"experiencia")+numberxx)
            disableMenu()
				triggerServerEvent('planta',root,col)
			end
				if getElementData(col,"Maçã") == 0 and getElementData(col,"Sementes") == 0 then
					triggerServerEvent("remover_planta",getLocalPlayer(),getElementData(col,"parent"))
				end
            return
        end			
		if itemName == "destruir_cama" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				disableMenu()
				showConfirm('Cama',true)
            return
        end						
		if itemName == "destruir_item_base" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				dono = tostring(getElementData(col,"creator"))
				conta = tostring(getElementData(localPlayer,'accountName'))
				hitElement = getElementData(col,"parent")
				if conta == dono then
				triggerServerEvent("onObjectDestroy",root,hitElement,getElementData(hitElement,"bc.ID"))
				else
				triggerServerEvent('onPlayerPlaceTimeBomb',root,getLocalPlayer(),hitElement)
				end
				disableMenu()
            return
        end			
		if itemName == "mudar_senha_porta" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				mudar_senha_porta(true)
				disableMenu()
            return
        end		
		if itemName == "abrir_fechar_porta" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				hitElement = getElementData(col,"parent")
				senha = tostring(getElementData(col,"senha"))
				status = tostring(getElementData(col,"status"))
				model = getElementModel(hitElement)
				if senha ~= 'Nenhuma' then
				dizer_senha_porta(true)
				else
					if model == 2282 or model == 2263 or model == 2096 then  -- > portas
					triggerServerEvent('abrir_fechar_porta',root,getLocalPlayer(),hitElement,status)
					else -- > portoes
					triggerServerEvent('abrir_fechar_portao',root,getLocalPlayer(),hitElement,status)
					end
				end
				disableMenu()
            return
        end				
        if itemName == "hospitalbox" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local ChecarName = "Checar (Hospitalbox)"
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end        
        if itemName == "vehicle" then
            local col = getElementData(getLocalPlayer(),"currentCol")
			if not getElementData(col,"tent") then
			name = getVehicleNameStoneAge(getElementData(col,"vehicle_ID"))
			else
			name = "Tent"
			end
            local ChecarName = "Checar ("..name..")"
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end
        if itemName == "add_fuel" then
            local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("add_fuel",getLocalPlayer(),col,"add",'fuel','Galão Cheio')
            disableMenu()
            return
        end          
		if itemName == "repairvehicle" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("repairVehicle",getLocalPlayer(),getElementData(col,"parent"))
            disableMenu()
            return
        end        
		if itemName == "remove_tire" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"remove",'Tire_inVehicle','Pneu')
            disableMenu()
            return
        end		
		if itemName == "remove_engine" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"remove",'Engine_inVehicle','Motor')
            disableMenu()
            return
        end		
		if itemName == "remove_tank" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"remove",'Parts_inVehicle','Tank')
            disableMenu()
            return
        end		
		if itemName == "add_tire" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"add",'Tire_inVehicle','Pneu')
            disableMenu()
            return
        end		
		if itemName == "add_engine" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"add",'Engine_inVehicle','Motor')
            disableMenu()
            return
        end		
		if itemName == "add_tank" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("change_veh_status",getLocalPlayer(),col,"add",'Parts_inVehicle','Tank')
            disableMenu()
            return
        end
        if itemName == "tent" then
            disableMenu()
			showConfirm('Box',true)
            return
        end
        if itemName == "fireplace" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("addPlayerCookMeat",getLocalPlayer())
            disableMenu()
            return
        end
        if itemName == "give_bandagem" then
            local col = getElementData(getLocalPlayer(),"currentCol")
                triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),'Bandagem',getElementData(col,"parent"))
                disableMenu()
            return
        end
        if itemName == "giveblood" then
            local col = getElementData(getLocalPlayer(),"currentCol")
                triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),'Primeiros Socorros',getElementData(col,"parent"))
                disableMenu()
            return
        end
        if itemName == "dead" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local ChecarName = "Checar ("..getElementData(col,"playername")..")"
            refreshLoot(col,ChecarName)
            showInventoryManual()
            return
        end
        if itemName == "deadreason" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            outputChatBox(getElementData(col,"deadreason"),255,255,255,true)
			disableMenu()
            return
        end       
		if itemName == "queimar_corpo" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            local dead = getElementData(col,"parent")
			triggerServerEvent('queimarDeadPlayer',root,dead,col,localPlayer)
			disableMenu()
            return
        end
        if itemName == "patrolstation" then
            local col = getElementData(getLocalPlayer(),"currentCol")
                setElementData(getLocalPlayer(),"Galão Vazio",getElementData(getLocalPlayer(),"Galão Vazio")-1)
                setElementData(getLocalPlayer(),"Galão Cheio",(getElementData(getLocalPlayer(),"Galão Cheio") or 0)+1)
                triggerEvent ("displayClientInfo",getLocalPlayer(),"patrolstation","Você encheu um galão!!",22,255,0)
                disableMenu()
            return
        end        
		if itemName == "cozinhar_carne" then
            local col = getElementData(getLocalPlayer(),"currentCol")
                setElementData(getLocalPlayer(),"Carne Crua",getElementData(getLocalPlayer(),"Carne Crua")-1)
                setElementData(getLocalPlayer(),"Carne Cozida",(getElementData(getLocalPlayer(),"Carne Cozida") or 0)+1)
				triggerServerEvent("SoundCozinhar",getLocalPlayer())
                triggerEvent ("displayClientInfo",getLocalPlayer(),"cozinhar_carne","Carne Cozida!",22,255,0)                
				disableMenu()
            return
        end			
		if itemName == "acender_fornalha" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				triggerServerEvent('acender_fornalha',root,col,localPlayer)
                disableMenu()
            return
        end				
		if itemName == "destroyFornalha" then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("destroyFornalha",getLocalPlayer(),col)
                disableMenu()
            return
        end		
		if itemName == "apagar_fornalha" then
            local col = getElementData(getLocalPlayer(),"currentCol")
				triggerServerEvent('apagar_fornalha',root,col)
                disableMenu()
            return
        end
        if isToolbeltItem(itemName) then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
            disableMenu()
            return
        end    
        if itemName == "Improvised Survivor" or 
		itemName == "Survivor" or 
		itemName == "Experienced Survivor" or 
		itemName == "Student Survivor" or  
		itemName == "Traveler Survivor" or 
		itemName == "Hunter Survivor" or 
		itemName == "Warrior Survivor" or 
		itemName == "Warrior_C Survivor" or 
		itemName == "Alone Survivor"  then
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
            disableMenu()
            return
        end 
		if getPlayerCurrentSlots() and getItemSlots(itemName) and getPlayerMaxAviableSlots() then
        if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then    
            local col = getElementData(getLocalPlayer(),"currentCol")
            triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
            disableMenu()
        else
            startRollMessage2("Inventory", "Inventario cheio!", 255, 0, 0 )
        end
    end
    end
end

function setarBind (bind)
unbindKey("mouse1","both")
unbindKey("mouse3","both")
bindKey(tostring(bind),"down",onPlayerPressMiddleMouse)
end
setarBind('mouse3')

function getMenuMarkedItem() 
    for i,guiItem in ipairs(spalteGuiText) do
        if getElementData(guiItem,"markedMenuItem") then
            return getElementData(guiItem,"usedItem") 
        end
    end
end


function playerPressedKey(button, press)
    if (press) then
        if button == "w" or button == "a" or button == "s" or button == "d" then
            local anim,anim2 = getPedAnimation (getLocalPlayer())
            if anim and anim == "SCRATCHING" and anim2 == "sclng_r" then
                triggerServerEvent("onClientMovesWhileAnimation",getLocalPlayer())
            end    
        end
    end
end
addEventHandler("onClientKey", root, playerPressedKey)


if fileExists("menu_client.lua") == true then
fileDelete("menu_client.lua")
end