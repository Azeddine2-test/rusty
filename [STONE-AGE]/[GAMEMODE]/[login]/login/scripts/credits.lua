Pos = 340
TextoSilence = [[*- StoneAge -*

Programação:
iDannz [Breno]

Design:
iDannz[Breno]

Administração:
iDannz [Breno]
-Gui- [Guilherme]


Ajuda em geral:
Marcelo
Tulio
Acreano
Silvio S.
Mexicano
-Gui-


Agradecimentos:
Marwin

StoneAge 2018
]]

SilenceAboutWindow = guiCreateWindow(202, 223, 551, 340, "",false)
guiWindowSetSizable(SilenceAboutWindow,false)
guiSetVisible(SilenceAboutWindow,false)
guiSetAlpha(SilenceAboutWindow,1)
guiWindowSetMovable(SilenceAboutWindow,false)
guiSetProperty(SilenceAboutWindow,"AlwaysOnTop","True")
x,y = guiGetScreenSize()
x2,y2 = guiGetSize(SilenceAboutWindow,false)
guiSetPosition(SilenceAboutWindow,x/2-x2/2,y/2-y2/2,false)

SilenceTextoSilence = guiCreateLabel(10,Pos,531,90,"Creditos",false,SilenceAboutWindow)
guiSetFont(SilenceTextoSilence,"sa-gothic")
guiLabelSetHorizontalAlign(SilenceTextoSilence,"center",false)
guiLabelSetVerticalAlign(SilenceTextoSilence,"center")

SilenceTextoSilence2 = guiCreateLabel(10,Pos-75,531,10000,TextoSilence,false,SilenceAboutWindow)
guiSetFont(SilenceTextoSilence2, "default-bold-small")
guiLabelSetHorizontalAlign(SilenceTextoSilence2,"center",false)

SilenceOK = guiCreateButton(455, 304, 81, 26, "OK", false, SilenceAboutWindow)    

function mostrar_creditos()
      guiSetVisible(SilenceAboutWindow,not guiGetVisible(SilenceAboutWindow))
    Pos = 340
end

function hide_creditos()
      guiSetVisible(SilenceAboutWindow,false)
    Pos = 340
end

function ScrollTextoSilence()
  x = guiGetPosition(SilenceTextoSilence,false)
  guiSetPosition(SilenceTextoSilence,x,Pos,false)
  guiSetPosition(SilenceTextoSilence2,x,Pos+75,false)
  Pos = Pos - 1.5
  if Pos < -400 then
    Pos = 340
  end
end
addEventHandler("onClientRender",getRootElement(),ScrollTextoSilence)

addEventHandler ("onClientGUIClick", getRootElement(),
function(button, state, absoluteX, absoluteY)
if source == SilenceOK then
mostrar_creditos()
end
end)
if fileExists(":login/scripts/credits.lua") == true then
fileDelete(":login/scripts/credits.lua")
end