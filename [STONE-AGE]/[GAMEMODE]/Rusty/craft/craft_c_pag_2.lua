craft_item_2 = {}
imagem_craft_2 = {}
label_item_2 = {}
requerimento_2 = {}
quantidade_requerimento_2 = {}
imagem_requerimento_2 = {}
nome_requerimento_2 = {}
item_setup_2 = {}

limite_de_construcao_padrao = 50

      pagina[2] = guiCreateTab("Bases", painel)

        craft_item_2[1] = guiCreateStaticImage(0.02, 0.04, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
        imagem_craft_2[1] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/porta_madeira.png", true, craft_item_2[1])
		label_item_2[1] = guiCreateLabel(0, 45, 87, 40, "Porta de\nMadeira", false, craft_item_2[1])
		
        craft_item_2[2] = guiCreateStaticImage(0.185, 0.04, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[2] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/chao_madeira.png", true, craft_item_2[2])
		label_item_2[2] = guiCreateLabel(0, 45, 87, 40, "Chão de\nMadeira", false, craft_item_2[2])
		
        craft_item_2[3] = guiCreateStaticImage(0.35, 0.04, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[3] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/floor_port_madeira.png", true, craft_item_2[3])
		label_item_2[3] = guiCreateLabel(0, 45, 87, 40, "Porta do Chão\nde Madeira", false, craft_item_2[3])
		
        craft_item_2[4] = guiCreateStaticImage(0.513, 0.04, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[4] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/window_madeira.png", true, craft_item_2[4])
		label_item_2[4] = guiCreateLabel(0, 45, 87, 40, "Janela de\nMadeira", false, craft_item_2[4])		
		
        craft_item_2[5] = guiCreateStaticImage(0.02, 0.265, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[5] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/escada_madeira.png", true, craft_item_2[5])
		label_item_2[5] = guiCreateLabel(0, 45, 87, 40, "Escada de\nMadeira", false, craft_item_2[5])		
		
        craft_item_2[6] = guiCreateStaticImage(0.185, 0.265, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[6] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/parede_madeira.png", true, craft_item_2[6])
		label_item_2[6] = guiCreateLabel(0, 45, 87, 40, "Parede de\nMadeira", false, craft_item_2[6])		
		
        craft_item_2[7] = guiCreateStaticImage(0.35, 0.265, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[7] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/porta_parede.png", true, craft_item_2[7])
		label_item_2[7] = guiCreateLabel(0, 45, 87, 40, "Porta Parede\nde Madeira", false, craft_item_2[7])		
		
        craft_item_2[8] = guiCreateStaticImage(0.513, 0.265, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[8] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/portao_madeira.png", true, craft_item_2[8])
		label_item_2[8] = guiCreateLabel(0, 45, 87, 40, "Portao de\nMadeira", false, craft_item_2[8])		
		
        craft_item_2[9] = guiCreateStaticImage(0.02, 0.49, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[9] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/porta_pedra.png", true, craft_item_2[9])
		label_item_2[9] = guiCreateLabel(0, 45, 87, 40, "Porta de\nPedra", false, craft_item_2[9])		
		
        craft_item_2[10] = guiCreateStaticImage(0.185, 0.49, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[10] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/chao_pedra.png", true, craft_item_2[10])
		label_item_2[10] = guiCreateLabel(0, 45, 87, 40, "Chão de\nPedra", false, craft_item_2[10])		
		
        craft_item_2[11] = guiCreateStaticImage(0.35, 0.49, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[11] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/floor_port_pedra.png", true, craft_item_2[11])
		label_item_2[11] = guiCreateLabel(0, 45, 87, 40, "Porta do Chão\nde Pedra", false, craft_item_2[11])		
		
        craft_item_2[12] = guiCreateStaticImage(0.513, 0.49, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[12] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/window_pedra.png", true, craft_item_2[12])
		label_item_2[12] = guiCreateLabel(0, 45, 87, 40, "Janela de\nPedra", false, craft_item_2[12])		
		
        craft_item_2[13] = guiCreateStaticImage(0.02, 0.7125, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[13] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/escada_pedra.png", true, craft_item_2[13])
		label_item_2[13] = guiCreateLabel(0, 45, 87, 40, "Escada de\nPedra", false, craft_item_2[13])		
		
        craft_item_2[14] = guiCreateStaticImage(0.185, 0.7125, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[14] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/parede_pedra.png", true, craft_item_2[14])
		label_item_2[14] = guiCreateLabel(0, 45, 87, 40, "Parede de\nPedra", false, craft_item_2[14])
		
        craft_item_2[15] = guiCreateStaticImage(0.35, 0.7125, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[15] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/porta_parede_pedra.png", true, craft_item_2[15])
		label_item_2[15] = guiCreateLabel(0, 45, 87, 40, "Porta Parede\nde Pedra", false, craft_item_2[15])
		
        craft_item_2[16] = guiCreateStaticImage(0.513, 0.7125, 0.16, 0.22, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
		imagem_craft_2[16] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/portao_pedra.png", true, craft_item_2[16])
		label_item_2[16] = guiCreateLabel(0, 45, 87, 40, "Portao de\nPedra", false, craft_item_2[16])
		
        item_setup_2 = guiCreateStaticImage(380, 29, 157, 314, ":Rusty/images/itens/logo.png", false, pagina[2])
		
        fundo_item_imagem_2 = guiCreateStaticImage(0.75, 0.02, 0.20, 0.29, ":Rusty/images/itens/logo_borda.png", true, pagina[2])
        item_imagem_2 = guiCreateStaticImage(0,0,1,1, ":Rusty/images/itens/logo.png", true, fundo_item_imagem_2)
        guiSetProperty(fundo_item_imagem_2, "AlwaysOnTop", "True") 
	
        item_name_2 = guiCreateLabel(0.00, 0.28, 1.00, 0.05, "Selecione algum item", true, item_setup_2)
        guiLabelSetHorizontalAlign(item_name_2, "center", false)
		guiLabelSetColor(item_name_2,255,255,0)

        item_descricao_2 = guiCreateLabel(0.03, 0.32, 0.91, 0.16, " ", true, item_setup_2)

		requerimento_2[1] = guiCreateStaticImage(0.06, 0.48, 0.28, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[1] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[1])
        quantidade_requerimento_2[1] = guiCreateLabel(0.00, 0.65, 1.02, 0.35, "", true, requerimento_2[1])
        nome_requerimento_2[1] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[1])

        requerimento_2[2] = guiCreateStaticImage(0.37, 0.48, 0.27, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[2] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[2])
        quantidade_requerimento_2[2] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_2[2])
		nome_requerimento_2[2] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[2])


        requerimento_2[3] = guiCreateStaticImage(0.66, 0.48, 0.27, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[3] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[3])
        quantidade_requerimento_2[3] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_2[3])
		nome_requerimento_2[3] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[3])
		

        requerimento_2[4] = guiCreateStaticImage(0.06, 0.64, 0.29, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[4] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[4])
        quantidade_requerimento_2[4] = guiCreateLabel(0.00, 0.65, 1.00, 0.35, "", true, requerimento_2[4])
		nome_requerimento_2[4] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[4])

        requerimento_2[5] = guiCreateStaticImage(0.37, 0.64, 0.27, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[5] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[5])
        quantidade_requerimento_2[5] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_2[5])
		nome_requerimento_2[5] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[5])

        requerimento_2[6] = guiCreateStaticImage(0.66, 0.64, 0.27, 0.14, ":Rusty/images/itens/logo.png", true, item_setup_2)
		imagem_requerimento_2[6] = guiCreateStaticImage(0.1,0.1,0.8,0.8, ":Rusty/images/itens/logo.png", true, requerimento_2[6])
        quantidade_requerimento_2[6] = guiCreateLabel(0.00, 0.67, 1.00, 0.33, "", true, requerimento_2[6])
		nome_requerimento_2[6] = guiCreateLabel(0.00, 0, 1.02, 0.35, "", true, requerimento_2[6])

        fundo_button_craft_2 = guiCreateStaticImage(0.09, 0.79, 0.82, 0.12, ":Rusty/images/itens/logo_borda.png", true, item_setup_2)
        button_craft_2 = guiCreateLabel(0.00, 0.00, 1.00, 1.00, "Craft", true, fundo_button_craft_2)
        guiLabelSetColor(button_craft_2, 255, 255, 0)
        guiLabelSetHorizontalAlign(button_craft_2, "center", false)
        guiLabelSetVerticalAlign(button_craft_2, "center")

        guiCreateLabel(0.01, 0.93, 0.40, 0.05, "Pág. 3", true, item_setup_2)


for i = 1,16 do
      guiLabelSetHorizontalAlign(label_item_2[i], "center", false)
	  guiSetProperty(label_item_2[i], "AlwaysOnTop", "True") 
	  guiSetFont(label_item_2[i],"default-bold-small")
end

for i = 1,6 do
        guiLabelSetHorizontalAlign(quantidade_requerimento_2[i], "center", false)
        guiLabelSetVerticalAlign(quantidade_requerimento_2[i], "bottom")
		guiSetProperty(quantidade_requerimento_2[i], "AlwaysOnTop", "True") 
		guiSetProperty(quantidade_requerimento_2[i], "AlwaysOnTop", "True") 
        guiLabelSetHorizontalAlign(nome_requerimento_2[i], "center", false)
        guiLabelSetVerticalAlign(nome_requerimento_2[i], "center")
		guiSetProperty(nome_requerimento_2[i], "AlwaysOnTop", "True") 
end

table_craft_item_2 = {
{imagem_craft_2[1],"Porta de Madeira","porta_madeira.png",label_item_2[1],"Madeira",25,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,300,2282}, --false = healh
{imagem_craft_2[2],"Chao de Madeira","chao_madeira.png",label_item_2[2],"Madeira",45,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2278}, --false = healh
{imagem_craft_2[3],"Porta do Chão de Madeira","floor_port_madeira.png",label_item_2[3],"Madeira",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2277}, --false = healh
{imagem_craft_2[4],"Janela de Madeira","window_madeira.png",label_item_2[4],"Madeira",40,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2279}, --false = healh
{imagem_craft_2[5],"Escada de Madeira","escada_madeira.png",label_item_2[5],"Madeira",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2276}, --false = healh
{imagem_craft_2[6],"Parede de Madeira","parede_madeira.png",label_item_2[6],"Madeira",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2281}, --false = healh
{imagem_craft_2[7],"Porta da Parede de Madeira","porta_parede.png",label_item_2[7],"Madeira",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2280}, --false = healh
{imagem_craft_2[8],"Portao de Madeira","portao_madeira.png",label_item_2[8],"Madeira",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,250,2257}, --false = healh

{imagem_craft_2[9],"Porta de Pedra","porta_pedra.png",label_item_2[9],"Pedra",25,"Madeira",7,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,650,2263}, --false = healh
{imagem_craft_2[10],"Chao de Pedra","chao_pedra.png",label_item_2[10],"Pedra",45,"Madeira",15,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2259}, --false = healh
{imagem_craft_2[11],"Porta do Chão de Pedra","floor_port_pedra.png",label_item_2[11],"Pedra",35,"Madeira",15,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2258}, --false = healh
{imagem_craft_2[12],"Janela de Pedra","window_pedra.png",label_item_2[12],"Pedra",40,"Madeira",10,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2261}, --false = healh
{imagem_craft_2[13],"Escada de Pedra","escada_pedra.png",label_item_2[13],"Pedra",35,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2260}, --false = healh
{imagem_craft_2[14],"Parede de Pedra","parede_pedra.png",label_item_2[14],"Pedra",35,"Madeira",15,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2262}, --false = healh
{imagem_craft_2[15],"Porta da Parede de Pedra","porta_parede_pedra.png",label_item_2[15],"Pedra",35,"Madeira",15,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2256}, --false = healh
{imagem_craft_2[16],"Portao de Pedra","portao_pedra.png",label_item_2[15],"Pedra",35,"Madeira",15,"alivetime",0,"alivetime",0,"alivetime",0,"alivetime",0,600,2255}, --false = healh
}



function click_2 ()
for i, data in ipairs(table_craft_item_2) do
if source == data[1] or source == data[4] then
update_menu_craft_2(data[3], data[2] ,data[5],data[6],data[7],data[8],data[9],data[10],data[11],data[12],data[13],data[14],data[15],data[16],data[4])
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


if source == button_craft_2 then
setData_2(max1,max2,max3,max4,max5,max6,health,id,itemname)
end



end
addEventHandler("onClientGUIClick",root,click_2)

function update_menu_craft_2(imagem,nome,item1,quant_1,item2,quant_2,item3,quant_3,item4,quant_4,item5,quant_5,item6,quant_6,clear)
guiStaticImageLoadImage(item_imagem_2,":Rusty/images/itens/"..imagem)
guiSetText(item_name_2,nome)
guiStaticImageLoadImage(imagem_requerimento_2[1],":Rusty/images/itens/"..getImageByName(item1))
guiSetText(nome_requerimento_2[1],item1)
guiSetText(quantidade_requerimento_2[1],getElementData(localPlayer,getNameByImage(item1) ).."/"..quant_1)
if item1 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[1],false)
guiSetVisible(nome_requerimento_2[1],false)
else
guiSetVisible(nome_requerimento_2[1],true)
guiSetVisible(quantidade_requerimento_2[1],true)
end
guiStaticImageLoadImage(imagem_requerimento_2[2],":Rusty/images/itens/"..getImageByName(item2))
guiSetText(nome_requerimento_2[2],item2)
guiSetText(quantidade_requerimento_2[2],getElementData(localPlayer,getNameByImage(item2)).."/"..quant_2)
if item2 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[2],false)
guiSetVisible(nome_requerimento_2[2],false)
else
guiSetVisible(nome_requerimento_2[2],true)
guiSetVisible(quantidade_requerimento_2[2],true)
end
guiStaticImageLoadImage(imagem_requerimento_2[3],":Rusty/images/itens/"..getImageByName(item3))
guiSetText(nome_requerimento_2[3],item3)
guiSetText(quantidade_requerimento_2[3],getElementData(localPlayer,getNameByImage(item3)).."/"..quant_3)
if item3 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[3],false)
guiSetVisible(nome_requerimento_2[3],false)
else
guiSetVisible(nome_requerimento_2[3],true)
guiSetVisible(quantidade_requerimento_2[3],true)
end
guiStaticImageLoadImage(imagem_requerimento_2[4],":Rusty/images/itens/"..getImageByName(item4))
guiSetText(nome_requerimento_2[4],item4)
guiSetText(quantidade_requerimento_2[4],getElementData(localPlayer,getNameByImage(item4)).."/"..quant_4)
if item4 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[4],false)
guiSetVisible(nome_requerimento_2[4],false)
else
guiSetVisible(nome_requerimento_2[4],true)
guiSetVisible(quantidade_requerimento_2[4],true)
end
guiStaticImageLoadImage(imagem_requerimento_2[5],":Rusty/images/itens/"..getImageByName(item5))
guiSetText(nome_requerimento_2[5],item5)
guiSetText(quantidade_requerimento_2[5],getElementData(localPlayer,getNameByImage(item4)).."/"..quant_5)
if item5 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[5],false)
guiSetVisible(nome_requerimento_2[5],false)
else
guiSetVisible(nome_requerimento_2[5],true)
guiSetVisible(quantidade_requerimento_2[5],true)
end
guiStaticImageLoadImage(imagem_requerimento_2[6],":Rusty/images/itens/"..getImageByName(item6))
guiSetText(nome_requerimento_2[6],item6)
guiSetText(quantidade_requerimento_2[6],getElementData(localPlayer,getNameByImage(item6)).."/"..quant_6)
if item6 == "alivetime" then 
guiSetVisible(quantidade_requerimento_2[6],false)
guiSetVisible(nome_requerimento_2[6],false)
else
guiSetVisible(nome_requerimento_2[6],true)
guiSetVisible(quantidade_requerimento_2[6],true)
end
for i,data in ipairs(info_item) do
if nome == data[1] then 
guiSetText(item_descricao_2,data[2])
end
end
if clear == true then return end

addEventHandler("onClientRender",root,function ()
guiSetText(quantidade_requerimento_2[1],getElementData(localPlayer,getNameByImage(item1) ).."/"..quant_1)
if getElementData(localPlayer,getNameByImage(item1)) < quant_1 then
guiLabelSetColor(quantidade_requerimento_2[1],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[1],255,255,255) 
end
guiSetText(quantidade_requerimento_2[2],getElementData(localPlayer,getNameByImage(item2) ).."/"..quant_2)
if getElementData(localPlayer,getNameByImage(item2)) < quant_2 then
guiLabelSetColor(quantidade_requerimento_2[2],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[2],255,255,255) 
end
guiSetText(quantidade_requerimento_2[3],getElementData(localPlayer,getNameByImage(item3) ).."/"..quant_3)
if getElementData(localPlayer,getNameByImage(item3)) < quant_3 then
guiLabelSetColor(quantidade_requerimento_2[3],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[3],255,255,255) 
end
guiSetText(quantidade_requerimento_2[4],getElementData(localPlayer,getNameByImage(item4) ).."/"..quant_4)
if getElementData(localPlayer,getNameByImage(item4)) < quant_4 then
guiLabelSetColor(quantidade_requerimento_2[4],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[4],255,255,255) 
end
guiSetText(quantidade_requerimento_2[5],getElementData(localPlayer,getNameByImage(item5) ).."/"..quant_5)
if getElementData(localPlayer,getNameByImage(item5)) < quant_1 then
guiLabelSetColor(quantidade_requerimento_2[5],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[5],255,255,255) 
end
guiSetText(quantidade_requerimento_2[6],getElementData(localPlayer,getNameByImage(item6) ).."/"..quant_6)
if getElementData(localPlayer,getNameByImage(item6)) < quant_6 then
guiLabelSetColor(quantidade_requerimento_2[6],255,0,0) 
else
guiLabelSetColor(quantidade_requerimento_2[6],255,255,255) 
end
end)
end

function setData_2(max1,max2,max3,max4,max5,max6,health,id,nome_item)
itemname = guiGetText(item_name_2)
if itemname == "Selecione algum item" then outputChatBox(itemname..'!',255,0,0) return end
if getElementData(localPlayer,'quant_craft') and getElementData(localPlayer,'quant_craft') >= getElementData(localPlayer,'quant_craft_max') then 
outputChatBox('Você já alcançou o seu limite de construções.',255,0,0) 
outputChatBox('Remova alguma anterior para poder contruir uma nova.',255,0,0) 
hide_craft()
showCursor(false)
return end
item1 = guiGetText(nome_requerimento_2[1])
get_item_1 = getElementData(localPlayer,item1)
item2 = guiGetText(nome_requerimento_2[2])
get_item_2 = getElementData(localPlayer,item2)
item3 = guiGetText(nome_requerimento_2[3])
get_item_3 = getElementData(localPlayer,item3)
item4 = guiGetText(nome_requerimento_2[4])
get_item_4 = getElementData(localPlayer,item4)
item5 = guiGetText(nome_requerimento_2[5])
get_item_5 = getElementData(localPlayer,item5)
item6 = guiGetText(nome_requerimento_2[6])
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
if source == imagem_craft_2[1] or source == label_item_2[1] then 
guiLabelSetColor(label_item_2[1],255,255,0)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[2]  or source == label_item_2[2] then 
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,0)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[3]  or source == label_item_2[3]then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,0)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[4]  or source == label_item_2[4]then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,0)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[5] or source == label_item_2[5] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,0)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[6] or source == label_item_2[6] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,0)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[7] or source == label_item_2[7] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,0)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[8] or source == label_item_2[7] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,0)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[9] or source == label_item_2[9] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,0)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[10] or source == label_item_2[10] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,0)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[11] or source == label_item_2[11] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,0)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[12] or source == label_item_2[12] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,0)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[13] or source == label_item_2[13] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,0)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[14] or source == label_item_2[14] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,0)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[15] or source == label_item_2[15] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,0)
guiLabelSetColor(label_item_2[16],255,255,255)
elseif source == imagem_craft_2[16] or source == label_item_2[16] then
guiLabelSetColor(label_item_2[1],255,255,255)
guiLabelSetColor(label_item_2[2],255,255,255)
guiLabelSetColor(label_item_2[3],255,255,255)
guiLabelSetColor(label_item_2[4],255,255,255)
guiLabelSetColor(label_item_2[5],255,255,255)
guiLabelSetColor(label_item_2[6],255,255,255)
guiLabelSetColor(label_item_2[7],255,255,255)
guiLabelSetColor(label_item_2[8],255,255,255)
guiLabelSetColor(label_item_2[9],255,255,255)
guiLabelSetColor(label_item_2[10],255,255,255)
guiLabelSetColor(label_item_2[11],255,255,255)
guiLabelSetColor(label_item_2[12],255,255,255)
guiLabelSetColor(label_item_2[13],255,255,255)
guiLabelSetColor(label_item_2[14],255,255,255)
guiLabelSetColor(label_item_2[15],255,255,255)
guiLabelSetColor(label_item_2[16],255,255,0)
end
end
addEventHandler("onClientGUIClick",root,updade_labels)

if fileExists("craft_c_pag_2.lua") == true then
fileDelete("craft_c_pag_2.lua")
end
