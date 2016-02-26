Rem
/*
	
	
	
	
	
	(c) Jeroen P. Broks, 2015, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
*/


Version: 15.02.28

End Rem
Strict
Import "basis.bmx"
Import "Aquarium.bmx"
Import "Speak.bmx"
Type MainMenu Extends AziellaBase

	Field GLogo:TUI_Gadget
	Field StartGame:TUI_Gadget
	Field Trophies:TUI_Gadget
	Field ChangePlayer:TUI_Gadget
	Field Config:TUI_Gadget
	Field Credits:TUI_Gadget
	Field Leave:TUI_Gadget
	Field Copyright:TUI_Gadget
	Field ShowUserName:TUI_Gadget
	Field ButList:TList = New TList

	Method OnLoad() 
	Local Pix:TPixmap = LoadPixmap(JCR_B(JCR,"GFX/GENERAL/LOGO.PNG"))
	getfont inputfont,JCR_E(JCR,FONT_INPUT),20
	CreateAquarium UIScreen
	' Start Logo
	If Not pix error "Logo not loaded"
	ilogo = LoadAnimImage(pix,PixmapWidth(pix),1,0,PixmapHeight(pix)); 
	If Not ilogo error "Could not chop logo"
	HotCenter ilogo
	ConsoleWrite "Logo loaded"
	glogo = New TUI_Gadget
	glogo.idleimage = ilogo
	glogo.kind = "AziellaLogo"
	setparent UIScreen,glogo
	glogo.x = 400
	glogo.Y = PixmapHeight(pix)*-2
	'end logo
	If Not ui_longbutton ui_longbutton = LoadImage(JCR_B(JCR,"GFX/UI/LongButton.png"))
	StartGame = TUI_CreateButton("NG",1000,150,UIScreen,ui_longbutton)
	langtie "StartGame",StartGame	
	ListAddLast ButList,StartGame
	Trophies = TUI_CreateButton("TR",1200,200,UIScreen,ui_longbutton)
	langtie "Trophies",Trophies
	ListAddLast ButList,Trophies
	changeplayer = TUI_CreateButton("CP",1400,250,UIScreen,UI_longbutton)
	langtie "OtherPlayer",changeplayer
	ListAddLast butlist,changeplayer
	config = TUI_CreateButton("CFG",1600,300,UIScreen,UI_longbutton)
	langtie "Config",config
	ListAddLast butlist,Config
	Credits = TUI_CreateButton("Credits",1800,350,UIScreen,UI_longbutton) 
	ListAddLast butlist,Credits
	Leave = TUI_CreateButton("EXIT",2000,400,UIScreen,UI_longbutton)
	langtie "Exit",Leave
	ListAddLast butlist,Leave
	For Local G:TUI_Gadget=EachIn Butlist
		G.font = inputfont
		Next
	Copyright = TUI_CreateLabel("(c) Copyright 2015, Jeroen P. Broks",400,575,UIScreen,inputfont,2)
	ShowUserName = TUI_CreateLabel("<No User>",400,115,UISCREEN,INPUTFONT,2)
	SupportAziella(UIScreen) ' This one must ALWAYS be the last gadget
	JCR_E_Clear
	End Method
	
	Method OnCycle() 
	If glogo.y<0 glogo.y:+1
	For Local G:TUI_Gadget = EachIn butlist
		If G.x>100 g.x:-4
		Next
	showusername.text = "< "+UserName+" >"
	End Method
	
	Method OnInput() 
	If Leave.Action
		SaveUser
		SecuEnd
		End
		EndIf
	If credits.action toscreen "Credits"
	If config.action ToScreen "Config"	
	If Trophies.action ToScreen "Trophies"
	If StartGame.action ToScreen "Game"
	End Method
	
	Method OnSwitch() 
	music JCR,"General/MainMenu.ogg"
	End Method
	
	End Type

Type TUI_GDrvLogo Extends TUI_Gadgetdriver

	Method Run(G:TUI_Gadget,Enabled)
		Assert g.idleimage Else "No image for a logo?"
		'Print "Before logo"
		watereffect(g.idleimage,g.x,g.y,1,20,1,.05)	
		'Print "After Logo"
		End Method

End Type

regtuidriver "AziellaLogo",New TUI_GDrvLogo




MKL_Version "Aziella's Babling Bubbles - imp/MainMenu.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/MainMenu.bmx","GNU - General Public License ver3"
