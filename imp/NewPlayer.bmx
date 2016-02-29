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


Version: 15.02.25

End Rem
Strict
Import "Basis.bmx"
Import "Speak.bmx"
Import "Aquarium.bmx"


MKL_Version "Aziella's Babling Bubbles - imp/NewPlayer.bmx","15.02.25"
MKL_Lic     "Aziella's Babling Bubbles - imp/NewPlayer.bmx","GNU - General Public License ver3"


Type Aziella_NewPlayer Extends aziellabase
	Field Aziella:TUI_Gadget
	Field Position
	Field NU_Screen:TUI_Gadget
	Field Font:TImagefont
	Field G_UserName:TUI_Gadget
	Field G_Next:TUI_Gadget
	Field SD:Secu
	Field SDLD:TMap = New TMap
	Field Sdy
	Field TG:TUI_Gadget

	Method OnLoad() 
	loadAziellaPics
	UIScreen.TiledImage=True
	UISCreen.idleimage = ConsoleBackGroundPicture
	CreateAquarium UIScreen
	NU_Screen = TUI_CreateScreen(Null,UIScreen)
	font = LoadImageFont(JCR_E(JCR,FONT_NEWUSERHEAD),25)	
	langtie "EnterName",TUI_CreateLabel("--",400,25,NU_Screen,font,2)
	GetFont inputfont,JCR_E(JCR,FONT_INPUT),20
	G_UserName = TUI_CreateUserInput:TUI_Gadget(200,100,400,NU_SCREEN)
	G_UserName.Font = InputFont
	TUI_ActivateGadget G_UserName
	G_Next = TUI_CreateButton("",790-ImageWidth(Imgnextbutton),580-ImageHeight(Imgnextbutton),NU_Screen,imgnextbutton,imgnextbutton)
	G_Next.AltKey = KEY_ENTER
	SDY = 200
	If Not ModifiedGame Then
		DebugLog "Getting login data for on-line shit!"
		For sd=EachIn SecuList
			DebugLog "Site: "+sd.Name
			For Local Key$=EachIn sd.logindata
				TUI_CreateLabel SD.Name+": "+Key+"  (optional)",400,sdy,NU_Screen,font,2
				TG = TUI_CreateUserInput(200,sdy+25,400,NU_Screen)
				TG.Font = inputfont
				MapInsert SDLD,"Secu:"+SD.Name+":"+Key,TG
				SDY:+50
				Next
			Next
		EndIf
	Aziella = SupportAziella(UIScreen) ' This one must ALWAYS be last!			
	JCR_E_Clear
	EndMethod
	
	Method OnCycle() 
	NU_Screen.visible = Not ShowAziella
	G_Next.Enabled = Trim(G_UserName.Text)<>""
	EndMethod
	
	Method OnInput() 
	Local okcont = True
	Local ou:StringMap
	Local ti:TUI_Gadget
	If G_Next.Action
		If Not ModifiedGame
			For sd=EachIn SecuList
				MapInsert UserOnline,sd.name,New StringMap
				For Local key$=EachIn sd.logindata
					ou = onlineuser(sd.name)
					ti = TUI_Gadget(MapValueForKey(SDLD,"Secu:"+SD.Name+":"+Key))
					If Not ti error "No data on: "+"Secu:"+SD.Name+":"+Key
					MapInsert ou,key,ti.Text
					Next
				okcont = okcont And sd.login(onlineuser(sd.name))
				Next
			EndIf
		If okcont
			UserName = G_UserName.Text
			VarDef "$NAME",username
			SaveUser
			ToScreen("MainMenu")
			AziellaSpeak("NewUser/Hello")
			ConsoleWrite "To the main menu"
			Ini.D("DefaultPlayer",UserName)				
			SaveIni inifile,ini 'Ini.Save(IniFile)
			EndIf
		EndIf
	EndMethod
	
	Method OnSwitch() 
	Position = 0
	AziellaSpeak("NewUser/Intro")
	EndMethod

	Method OnTerminate()
	Notify "Closing this application is not possible right now. Please continue the sequence until you reached the main menu!"
	End Method

	End Type
	
Type Aziella_ChangePlayer Extends AziellaBase

	Field NU_Screen:TUI_Gadget
	Field Back:TUI_Gadget
	Field NewUser:TUI_Gadget
	Field Ok:TUI_Gadget
	Field UserList:TUI_Gadget

      Method OnLoad()
	loadAziellaPics
	UIScreen.TiledImage=True
	UISCreen.idleimage = ConsoleBackGroundPicture
	CreateAquarium UIScreen
	If Not UI_SmallButton Then UI_SmallButton = LoadImage(JCR_B(JCR,"GFX/UI/SmallButton.png"))
	NU_Screen = TUI_CreateScreen(Null,UIScreen)
	back = TUI_CreateButton("",20,590-ImageHeight(UI_BackButton),UIScreen,UI_BackButton)	
      NewUser = TUI_CreateButton("NU",400-(ImageWidth(UI_SmallButton)/2),590-ImageHeight(UI_smallbutton),UIScreen,UI_SmallButton)
      langtie "NewUser",NewUser
      Ok = TUI_CreateButton("OK",780-(ImageWidth(UI_SmallButton)),590-ImageHeight(UI_smallbutton),UIScreen,UI_SmallButton)
      langtie "Okay",Ok
	Ok.Font = inputfont
	NewUser.Font = inputfont
	UserList = tui_createlistbox(20,100,760,300,UIScreen)
	userlist.font = inputfont
	End Method

	Method OnCycle()
	Ok.Enabled = UserList.SelectedItem()>=0
	End Method
	
	Method OnInput()
	If back.action ToScreen "MainMenu"
	If ok.action Then
		saveuser
		loaduser userlist.itemtext()
		toscreen "MainMenu"
		EndIf
	If NewUser.Action 
		saveuser
		ToScreen "NewPlayer"		
		EndIf
	End Method

	Method OnSwitch() 
	UserList.Items = GetUserList()	
	EndMethod


	Method OnTerminate()
	If Proceed("Quitting now might destroy any unsaved data. You can best do this from the main menu.~n~nDo yo still wish to continue?")=1 Bye	
	End Method

End Type	
