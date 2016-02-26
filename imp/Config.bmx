Rem
/*
	
	
	
	
	
	(c) , , All rights reserved
	
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


Version: 15.02.26

End Rem
Strict
Import "Basis.bmx"
Import "Aquarium.bmx"
Import "Speak.bmx"

Type aziellaconfig Extends AziellaBase 

	Field Back:TUI_Gadget
	Field glogo:TUI_Gadget
	
	Field bmusic:TUI_Gadget
	Field btut:TUI_Gadget
	Field bsfx:TUI_Gadget
	Field bclb:TUI_Gadget
	Field fields:TUI_Gadget[]

	Method OnLoad() 
	CreateAquarium UIScreen ' Always comes first
	If Not UI_BackButton UI_BackButton = LoadImage(JCR_B(JCR,"GFX/UI/Previous.png"))
	back = TUI_CreateButton("",20,590-ImageHeight(UI_BackButton),UIScreen,UI_BackButton)	
	'Logo
	glogo = New TUI_Gadget
	glogo.idleimage = ilogo
	glogo.x = 400
	glogo.y = 0
	glogo.kind = "AziellaLogo"
	setparent UIScreen,glogo	
	' End logo
	LangTie "Music",TUI_CreateLabel("MSC",200,150,UISCreen,InputFont)
	LangTie "SFX",TUI_CreateLabel("SFX",200,200,UIScreen,InputFont)
	LangTie "Tutorials",TUI_CreateLabel("TUT",200,250,UIScreen,InputFont)
	LangTie "ColorBlind",TUI_CreateLabel("CLB",200,300,UIScreen,InputFont)
	If Not   check   check = LoadImage(JCR_B(JCR,"GFX/UI/Check.png"))
	If Not uncheck uncheck = LoadImage(JCR_B(JCR,"GFX/UI/UnCheck.png"))
	bmusic = tui_Createcheckbox(100,150,UIScreen,uncheck,check)
	bsfx   = tui_Createcheckbox(100,200,UIScreen,uncheck,check)
	btut   = tui_Createcheckbox(100,250,UIScreen,uncheck,check)
	bclb   = tui_Createcheckbox(100,300,UIScreen,uncheck,check)
	fields = [bmusic,bsfx,btut,bclb]
	SupportAziella UIScreen ' This one must ALWAYS be the last gadget
	JCR_E_Clear	
	End Method
	
	Method OnCycle()
	' color blind markings
	Local onoff$[] = [Intlanguage.Get("OFF"),intlanguage.Get("ON")]
	For Local G:TUI_Gadget=EachIn fields
		If bclb.checked
			g.font = inputfont
			g.text = onoff[g.checked]
			Else
			g.text = ""
			EndIf
		Next	
	' end color blind markings		 
	End Method
	
	Method OnInput() 
	If back.action 
		cfgmusic      = bmusic.checked
		cfgtutorial   =   btut.checked
		cfgcolorblind =   bclb.checked
		cfgsfx        =   bsfx.checked
		If Not cfgmusic stopmusic
		ToScreen "MainMenu"
		EndIf
	End Method
	
	Method OnSwitch() 
	If Not VarCall("&CONFIGFIRST") 
		AziellaSpeak("Config/Config")
		VarDef "&CONFIGFIRST","TRUE"
		EndIf
	bmusic.checked = cfgmusic
	bsfx.checked   = cfgsfx
	btut.checked   = cfgtutorial
	bclb.checked   = cfgcolorblind		
	End Method
	
	End Type

