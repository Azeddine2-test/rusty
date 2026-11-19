carft_item_VIP = {}
imagem_craft_VIP = {}
label_craft_VIP = {}
requerimento_VIP = {}
quantidade_requerimento_VIP = {}
imagem_requerimento_VIP = {}
nome_requerimento_VIP = {}
item_setup_VIP = {}

limite_de_construcao_padrao = 50

      pagina[3] = guiCreateTab("Vip Base", painel)

        carft_item_VIP[1] = guiCreateStaticImage(0.02, 0.04, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
        imagem_craft_VIP[1] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/porta_ferro.png", true, carft_item_VIP[1])
		label_craft_VIP[1] = guiCreateLabel(0, 45, 87, 40, "Porta de\nFerro", false, carft_item_VIP[1])
		
        carft_item_VIP[2] = guiCreateStaticImage(0.185, 0.04, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[2] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/chao_ferro.png", true, carft_item_VIP[2])
		label_craft_VIP[2] = guiCreateLabel(0, 45, 87, 40, "Chão de\nFerro", false, carft_item_VIP[2])
		
        carft_item_VIP[3] = guiCreateStaticImage(0.35, 0.04, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[3] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/floor_port_ferro.png", true, carft_item_VIP[3])
		label_craft_VIP[3] = guiCreateLabel(0, 45, 87, 40, "Porta do Chão\nde Ferro", false, carft_item_VIP[3])
		
        carft_item_VIP[4] = guiCreateStaticImage(0.513, 0.04, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[4] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/window_ferro.png", true, carft_item_VIP[4])
		label_craft_VIP[4] = guiCreateLabel(0, 45, 87, 40, "Janela de\nFerro", false, carft_item_VIP[4])		
		
        carft_item_VIP[5] = guiCreateStaticImage(0.02, 0.265, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[5] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/escada_ferro.png", true, carft_item_VIP[5])
		label_craft_VIP[5] = guiCreateLabel(0, 45, 87, 40, "Escada de\nFerro", false, carft_item_VIP[5])		
		
        carft_item_VIP[6] = guiCreateStaticImage(0.185, 0.265, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[6] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/parede_ferro.png", true, carft_item_VIP[6])
		label_craft_VIP[6] = guiCreateLabel(0, 45, 87, 40, "Parede de\nFerro", false, carft_item_VIP[6])		
		
        carft_item_VIP[7] = guiCreateStaticImage(0.35, 0.265, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[7] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/porta_parede_ferro.png", true, carft_item_VIP[7])
		label_craft_VIP[7] = guiCreateLabel(0, 45, 87, 40, "Porta Parede\nde Ferro", false, carft_item_VIP[7])		
		
        carft_item_VIP[8] = guiCreateStaticImage(0.513, 0.265, 0.16, 0.22, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
		imagem_craft_VIP[8] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/portao_ferro.png", true, carft_item_VIP[8])
		label_craft_VIP[8] = guiCreateLabel(0, 45, 87, 40, "Portao de\nFerro", false, carft_item_VIP[8])		
		
        carft_item_VIP[9] = guiCreateStaticImage(0.02, 0.49, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[9] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[9])
		label_craft_VIP[9] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[9])		
		
        carft_item_VIP[10] = guiCreateStaticImage(0.185, 0.49, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[10] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[10])
		label_craft_VIP[10] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[10])		
		
        carft_item_VIP[11] = guiCreateStaticImage(0.35, 0.49, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[11] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[11])
		label_craft_VIP[11] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[11])		
		
        carft_item_VIP[12] = guiCreateStaticImage(0.513, 0.49, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[12] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[12])
		label_craft_VIP[12] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[12])		
		
        carft_item_VIP[13] = guiCreateStaticImage(0.02, 0.7125, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[13] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[13])
		label_craft_VIP[13] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[13])		
		
        carft_item_VIP[14] = guiCreateStaticImage(0.185, 0.7125, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[14] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[14])
		label_craft_VIP[14] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[14])
		
        carft_item_VIP[15] = guiCreateStaticImage(0.35, 0.7125, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[15] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[15])
		label_craft_VIP[15] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[15])
		
        carft_item_VIP[16] = guiCreateStaticImage(0.513, 0.7125, 0.16, 0.22, ":stoneage/images/itens/logo.png", true, pagina[3])
		imagem_craft_VIP[16] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, carft_item_VIP[16])
		label_craft_VIP[16] = guiCreateLabel(0, 45, 87, 40, "", false, carft_item_VIP[16])
		
        item_setup_VIP = guiCreateStaticImage(380, 29, 157, 314, ":stoneage/images/itens/logo.png", false, pagina[3])
		
        fundo_item_imagem_VIP = guiCreateStaticImage(0.75, 0.02, 0.20, 0.29, ":stoneage/images/itens/logo_borda.png", true, pagina[3])
        item_imagem_VIP = guiCreateStaticImage(0,0,1,1, ":stoneage/images/itens/logo.png", true, fundo_item_imagem_VIP)
        guiSetProperty(fundo_item_imagem_VIP, "AlwaysOnTop", "True") 
	
        item_name_VIP = guiCreateLabel(0.00, 0.28, 1.00, 0.05, "Selecione algum item", true, item_setup_VIP)
        guiLabelSetHorizontalAlign(item_name_VIP, "center", false)
		guiLabelSetColor(item_name_VIP,255,255,0)

        item_descricao_VIP = guiCreateLabel(0.03, 0.32, 0.91, 0.16, " ", true, item_setup_VIP)

		requerimento_VIP[1] = guiCreateStaticImage(0.06, 0.48, 0.28, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[1] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[1])
        quantidade_requerimento_VIP[1] = guiCreateLabel(0.00, 0.65, 1.02, 0.35, "", true, requerimento_VIP[1])
        nome_requerimento_VIP[1] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[1])

        requerimento_VIP[2] = guiCreateStaticImage(0.37, 0.48, 0.27, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[2] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[2])
        quantidade_requerimento_VIP[2] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_VIP[2])
		nome_requerimento_VIP[2] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[2])


        requerimento_VIP[3] = guiCreateStaticImage(0.66, 0.48, 0.27, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[3] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[3])
        quantidade_requerimento_VIP[3] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_VIP[3])
		nome_requerimento_VIP[3] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[3])
		

        requerimento_VIP[4] = guiCreateStaticImage(0.06, 0.64, 0.29, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[4] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[4])
        quantidade_requerimento_VIP[4] = guiCreateLabel(0.00, 0.65, 1.00, 0.35, "", true, requerimento_VIP[4])
		nome_requerimento_VIP[4] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[4])

        requerimento_VIP[5] = guiCreateStaticImage(0.37, 0.64, 0.27, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[5] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[5])
        quantidade_requerimento_VIP[5] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_VIP[5])
		nome_requerimento_VIP[5] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[5])

        requerimento_VIP[6] = guiCreateStaticImage(0.66, 0.64, 0.27, 0.14, ":stoneage/images/itens/logo.png", true, item_setup_VIP)
		imagem_requerimento_VIP[6] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":stoneage/images/itens/logo.png", true, requerimento_VIP[6])
        quantidade_requerimento_VIP[6] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_VIP[6])
		nome_requerimento_VIP[6] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_VIP[6])

        fundo_button_craft_VIP = guiCreateStaticImage(0.09, 0.79, 0.82, 0.12, ":stoneage/images/itens/logo_borda.png", true, item_setup_VIP)
        button_craft_VIP = guiCreateLabel(0.00, 0.00, 1.00, 1.00, "Craft", true, fundo_button_craft_VIP)
        guiLabelSetColor(button_craft_VIP, 255, 255, 0)
        guiLabelSetHorizontalAlign(button_craft_VIP, "center", false)
        guiLabelSetVerticalAlign(button_craft_VIP, "center")

        guiCreateLabel(0.01, 0.93, 0.45, 0.05, "Pág. 4 (VIP)", true, item_setup_VIP)


for i = 1,16 do
      guiLabelSetHorizontalAlign(label_craft_VIP[i], "center", false)
	  guiSetProperty(label_craft_VIP[i], "AlwaysOnTop", "True") 
	  guiSetFont(label_craft_VIP[i],"default-bold-small")
end

for i = 1,6 do
        guiLabelSetHorizontalAlign(quantidade_requerimento_VIP[i], "center", false)
        guiLabelSetVerticalAlign(quantidade_requerimento_VIP[i], "bottom")
		guiSetProperty(quantidade_requerimento_VIP[i], "AlwaysOnTop", "True") 
		guiSetProperty(quantidade_requerimento_VIP[i], "AlwaysOnTop", "True") 
        guiLabelSetHorizontalAlign(nome_requerimento_VIP[i], "center", false)
        guiLabelSetVerticalAlign(nome_requerimento_VIP[i], "center")
		guiSetProperty(nome_requerimento_VIP[i], "AlwaysOnTop", "True") 
end

table_carft_item_VIP = {
{imagem_craft_VIP[1],"Porta de Ferro","porta_ferro.png",label_craft_VIP[1],"Ferro",25,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1500,2096},
{imagem_craft_VIP[2],"Chao de Ferro","chao_ferro.png",label_craft_VIP[2],"Ferro",45,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2120}, 
{imagem_craft_VIP[3],"Porta do Chão de Ferro","floor_port_ferro.png",label_craft_VIP[3],"Ferro",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2121},
{imagem_craft_VIP[4],"Janela de Ferro","window_ferro.png",label_craft_VIP[4],"Ferro",40,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2122},
{imagem_craft_VIP[5],"Escada de Ferro","escada_ferro.png",label_craft_VIP[5],"Ferro",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2123}, 
{imagem_craft_VIP[6],"Parede de Ferro","parede_ferro.png",label_craft_VIP[6],"Ferro",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2124},
{imagem_craft_VIP[7],"Porta da Parede de Ferro","porta_parede_ferro.png",label_craft_VIP[7],"Ferro",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2125}, 
{imagem_craft_VIP[8],"Portao de Ferro","portao_ferro.png",label_craft_VIP[8],"Ferro",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,1250,2166}, 
}


function click_VIP ()
for i, data in ipairs(table_carft_item_VIP) do
if source == data[1] or source == data[4] then
update_menu_craft_VIP(data[3], data[2] ,data[5],data[6],data[7],data[8],data[9],data[10],data[11],data[12],data[13],data[14],data[15],data[16],data[4])
		      --  img      nome     item1  quant1   item2  quant2   item3   quant3   item4    quant4   item5    quant5   item6   quant 6
max1 = data[6]
max2 = data[8]
max3 = data[10]
max4 = data[12]
max5 = data[14]
max6 = data[16]
health = data[17]
id = data[18]
itemname = data[2]
end
end

for i = 9,16 do  -- estao faltando
if source == imagem_craft_VIP[i] then
update_menu_craft_VIP("logo.png", "Selecione algum item","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime","alivetime",true)
end
end

if source == button_craft_VIP then
setData_VIP(max1,max2,max3,max4,max5,max6,health,id,itemname,true) -- true é o setVip
end
end
addEventHandler("onClientGUIClick",root,click_VIP)

function update_menu_craft_VIP(imagem,nome,item1,quant_1,item2,quant_2,item3,quant_3,item4,quant_4,item5,quant_5,item6,quant_6,clear)
guiStaticImageLoadImage(item_imagem_VIP,":stoneage/images/itens/"..imagem)
guiSetText(item_name_VIP,nome)
guiStaticImageLoadImage(imagem_requerimento_VIP[1],":stoneage/images/itens/"..getImageByName(item1))
guiSetText(nome_requerimento_VIP[1],item1)
guiSetText(quantidade_requerimento_VIP[1],getElementData(localPlayer,getNameByImage(item1) ).."/"..quant_1)
if item1 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[1],false)
guiSetVisible(nome_requerimento_VIP[1],false)
else
guiSetVisible(nome_requerimento_VIP[1],true)
guiSetVisible(quantidade_requerimento_VIP[1],true)
end
guiStaticImageLoadImage(imagem_requerimento_VIP[2],":stoneage/images/itens/"..getImageByName(item2))
guiSetText(nome_requerimento_VIP[2],item2)
guiSetText(quantidade_requerimento_VIP[2],getElementData(localPlayer,getNameByImage(item2)).."/"..quant_2)
if item2 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[2],false)
guiSetVisible(nome_requerimento_VIP[2],false)
else
guiSetVisible(nome_requerimento_VIP[2],true)
guiSetVisible(quantidade_requerimento_VIP[2],true)
end
guiStaticImageLoadImage(imagem_requerimento_VIP[3],":stoneage/images/itens/"..getImageByName(item3))
guiSetText(nome_requerimento_VIP[3],item3)
guiSetText(quantidade_requerimento_VIP[3],getElementData(localPlayer,getNameByImage(item3)).."/"..quant_3)
if item3 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[3],false)
guiSetVisible(nome_requerimento_VIP[3],false)
else
guiSetVisible(nome_requerimento_VIP[3],true)
guiSetVisible(quantidade_requerimento_VIP[3],true)
end
guiStaticImageLoadImage(imagem_requerimento_VIP[4],":stoneage/images/itens/"..getImageByName(item4))
guiSetText(nome_requerimento_VIP[4],item4)
guiSetText(quantidade_requerimento_VIP[4],getElementData(localPlayer,getNameByImage(item4)).."/"..quant_4)
if item4 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[4],false)
guiSetVisible(nome_requerimento_VIP[4],false)
else
guiSetVisible(nome_requerimento_VIP[4],true)
guiSetVisible(quantidade_requerimento_VIP[4],true)
end
guiStaticImageLoadImage(imagem_requerimento_VIP[5],":stoneage/images/itens/"..getImageByName(item5))
guiSetText(nome_requerimento_VIP[5],item5)
guiSetText(quantidade_requerimento_VIP[5],getElementData(localPlayer,getNameByImage(item4)).."/"..quant_5)
if item5 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[5],false)
guiSetVisible(nome_requerimento_VIP[5],false)
else
guiSetVisible(nome_requerimento_VIP[5],true)
guiSetVisible(quantidade_requerimento_VIP[5],true)
end
guiStaticImageLoadImage(imagem_requerimento_VIP[6],":stoneage/images/itens/"..getImageByName(item6))
guiSetText(nome_requerimento_VIP[6],item6)
guiSetText(quantidade_requerimento_VIP[6],getElementData(localPlayer,getNameByImage(item6)).."/"..quant_6)
if item6 == "alivetime" then 
guiSetVisible(quantidade_requerimento_VIP[6],false)
guiSetVisible(nome_requerimento_VIP[6],false)
else
guiSetVisible(nome_requerimento_VIP[6],true)
guiSetVisible(quantidade_requerimento_VIP[6],true)
end
for i,data in ipairs(info_item) do
if nome == data[1] then 
guiSetText(item_descricao_VIP,data[2])
end
end
if clear == true then return end

addEventHandler("onClientRender",root,function ()
guiSetText(quantidade_requerimento_VIP[1],getElementData(localPlayer,getNameByImage(item1) ).."/"..quant_1)
if getElementData(localPlayer,getNameByImage(item1)) < quant_1 then
guiLabelSetColor(quantidade_requerimento_VIP[1],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[1],255,255,255) 
end
guiSetText(quantidade_requerimento_VIP[2],getElementData(localPlayer,getNameByImage(item2) ).."/"..quant_2)
if getElementData(localPlayer,getNameByImage(item2)) < quant_2 then
guiLabelSetColor(quantidade_requerimento_VIP[2],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[2],255,255,255) 
end
guiSetText(quantidade_requerimento_VIP[3],getElementData(localPlayer,getNameByImage(item3) ).."/"..quant_3)
if getElementData(localPlayer,getNameByImage(item3)) < quant_3 then
guiLabelSetColor(quantidade_requerimento_VIP[3],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[3],255,255,255) 
end
guiSetText(quantidade_requerimento_VIP[4],getElementData(localPlayer,getNameByImage(item4) ).."/"..quant_4)
if getElementData(localPlayer,getNameByImage(item4)) < quant_4 then
guiLabelSetColor(quantidade_requerimento_VIP[4],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[4],255,255,255) 
end
guiSetText(quantidade_requerimento_VIP[5],getElementData(localPlayer,getNameByImage(item5) ).."/"..quant_5)
if getElementData(localPlayer,getNameByImage(item5)) < quant_1 then
guiLabelSetColor(quantidade_requerimento_VIP[5],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[5],255,255,255) 
end
guiSetText(quantidade_requerimento_VIP[6],getElementData(localPlayer,getNameByImage(item6) ).."/"..quant_6)
if getElementData(localPlayer,getNameByImage(item6)) < quant_6 then
guiLabelSetColor(quantidade_requerimento_VIP[6],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_VIP[6],255,255,255) 
end
end)
end

function setData_VIP(max1,max2,max3,max4,max5,max6,health,id,nome_item,VIP)
if not getElementData(localPlayer,'VIP') then outputChatBox('Você não é vip!',255,0,0) return end

itemname = guiGetText(item_name_VIP)
if itemname == "Selecione algum item" then outputChatBox(itemname..'!',255,0,0) return end
if getElementData(localPlayer,'quant_craft') and getElementData(localPlayer,'quant_craft') >= getElementData(localPlayer,'quant_craft_max') then 
outputChatBox('Você já alcançou o seu limite de construções.',255,0,0) 
outputChatBox('Remova alguma anterior para poder contruir uma nova.',255,0,0) 
hide_craft()
showCursor(false)
return end
item1 = guiGetText(nome_requerimento_VIP[1])
get_item_1 = getElementData(localPlayer,item1)
item2 = guiGetText(nome_requerimento_VIP[2])
get_item_2 = getElementData(localPlayer,item2)
item3 = guiGetText(nome_requerimento_VIP[3])
get_item_3 = getElementData(localPlayer,item3)
item4 = guiGetText(nome_requerimento_VIP[4])
get_item_4 = getElementData(localPlayer,item4)
item5 = guiGetText(nome_requerimento_VIP[5])
get_item_5 = getElementData(localPlayer,item5)
item6 = guiGetText(nome_requerimento_VIP[6])
get_item_6 = getElementData(localPlayer,item6)
	if get_item_1 and get_item_1 >= max1 then
		if get_item_2 and get_item_2 >= max2 then 
			if get_item_3 and get_item_3 >= max3 then 
			if get_item_4 and get_item_4 >= max4 then 
			if get_item_5 and get_item_5 >= max5 then 
			if get_item_6 and get_item_6 >= max6 then 
addEventHandler("onClientRender",root,draw_ajuda)
									local pX,pY,pZ = getElementPosition(localPlayer)
									tempOb[localPlayer] = createObject(id, pX+2, pY+2, pZ, 0, 0, 0)
									if tempOb[localPlayer] then
										addEventHandler("onClientRender", root, updatePos)
										addEventHandler("onClientClick", root, checkClick)
										addEventHandler("onClientClick", root, cancelAction)
										addEventHandler("onClientKey",root,setRotationOfObject)
										active = true
										setElementCollisionsEnabled(tempOb[localPlayer], false)
										setElementAlpha(tempOb[localPlayer],200)
										setElementData(tempOb[localPlayer],"salvavel",true)
										setElementData(tempOb[localPlayer],"health",health)
										setElementData(tempOb[localPlayer],"nomeitem",nome_item)
										setElementData(tempOb[localPlayer],"max1",max1)
										setElementData(tempOb[localPlayer],"max2",max2)
										setElementData(tempOb[localPlayer],"max3",max3)
										setElementData(tempOb[localPlayer],"max4",max4)
										setElementData(tempOb[localPlayer],"max5",max5)
										setElementData(tempOb[localPlayer],"max6",max6)
										setElementData(tempOb[localPlayer],"item1",item1)
										setElementData(tempOb[localPlayer],"item2",item2)
										setElementData(tempOb[localPlayer],"item3",item3)
										setElementData(tempOb[localPlayer],"item4",item4)
										setElementData(tempOb[localPlayer],"item5",item5)
										setElementData(tempOb[localPlayer],"item6",item6)
										guiSetVisible(window_craft,false)
									end
			else
			outputChatBox("Você precisa de mais ["..item6.."] para craftar ["..itemname.."]",255,0,0)
			return
			end					
			else
			outputChatBox("Você precisa de mais ["..item5.."] para craftar ["..itemname.."]",255,0,0)
			return
			end				
			else
			outputChatBox("Você precisa de mais ["..item4.."] para craftar ["..itemname.."]",255,0,0)
			return
			end		
			else
			outputChatBox("Você precisa de mais ["..item3.."] para craftar ["..itemname.."]",255,0,0)
			return
			end
		else
		outputChatBox("Você precisa de mais ["..item2.."] para craftar ["..itemname.."]",255,0,0)
		return
		end
	else
	outputChatBox("Você precisa de mais ["..item1.."] para craftar ["..itemname.."]",255,0,0)
	return
	end
end


function updade_labels ()
if source == label_craft_VIP[1] or source == imagem_craft_VIP[1] then 
guiLabelSetColor(label_craft_VIP[1],255,255,0)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[2]  or source == imagem_craft_VIP[2] then 
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,0)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[3]  or source == imagem_craft_VIP[3]then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,0)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[4]  or source == imagem_craft_VIP[4]then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,0)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[5] or source == imagem_craft_VIP[5] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,0)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[6] or source == imagem_craft_VIP[6] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,0)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[7] or source == imagem_craft_VIP[7] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,0)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[8] or source == imagem_craft_VIP[8] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,0)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[9] or source == imagem_craft_VIP[9] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,0)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[10] or source == imagem_craft_VIP[10] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,0)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[11] or source == imagem_craft_VIP[11] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,0)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[12] or source == imagem_craft_VIP[12] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,0)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[13] or source == imagem_craft_VIP[13] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,0)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[14] or source == imagem_craft_VIP[14] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,0)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[15] or source == imagem_craft_VIP[15] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,0)
guiLabelSetColor(label_craft_VIP[16],255,255,255)
elseif source == label_craft_VIP[16] or source == imagem_craft_VIP[16] then
guiLabelSetColor(label_craft_VIP[1],255,255,255)
guiLabelSetColor(label_craft_VIP[2],255,255,255)
guiLabelSetColor(label_craft_VIP[3],255,255,255)
guiLabelSetColor(label_craft_VIP[4],255,255,255)
guiLabelSetColor(label_craft_VIP[5],255,255,255)
guiLabelSetColor(label_craft_VIP[6],255,255,255)
guiLabelSetColor(label_craft_VIP[7],255,255,255)
guiLabelSetColor(label_craft_VIP[8],255,255,255)
guiLabelSetColor(label_craft_VIP[9],255,255,255)
guiLabelSetColor(label_craft_VIP[10],255,255,255)
guiLabelSetColor(label_craft_VIP[11],255,255,255)
guiLabelSetColor(label_craft_VIP[12],255,255,255)
guiLabelSetColor(label_craft_VIP[13],255,255,255)
guiLabelSetColor(label_craft_VIP[14],255,255,255)
guiLabelSetColor(label_craft_VIP[15],255,255,255)
guiLabelSetColor(label_craft_VIP[16],255,255,0)
end
end
addEventHandler("onClientGUIClick",root,updade_labels)

if fileExists("craft_c_pag_VIP.lua") == true then
fileDelete("craft_c_pag_VIP.lua")
end
