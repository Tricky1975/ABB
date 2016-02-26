Rem
/*
	Language Selector - Aziella's Babling Bubbles
	
	
	
	
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

MKL_Version "Aziella's Babling Bubbles - imp/LanguageSelector.bmx","15.02.25"
MKL_Lic     "Aziella's Babling Bubbles - imp/LanguageSelector.bmx","GNU - General Public License ver3"


Type Aziella_Language Extends aziellabase

	Rem ' Needed?
	Field LangPic:TMap = New TMap
	
	Method LangTImage:TImage(k$)
	Return TImage(MapValueForKey(LangPic,K))
	End Method
	End Rem
	
	Field LangButtons:Tmap = CreateMap()
	
	Method LangButton:TUI_Gadget(k$)
	Return TUI_Gadget(MapValueForKey(Langbuttons,k$))
	End Method

	Method OnLoad()
	Local cl$
	Local l$="LANGUAGE/"
	Local ll=Len(l)
	Local font:timagefont = LoadImageFont(JCR_E(JCR,"FONTS/"+FONT_LANGUAGESELECTOR),40); JCR_E_Clear
	Local x=10,y=50
	Local ti:TImage
	UIScreen.TiledImage=True
	UISCreen.idleimage = ConsoleBackGroundPicture
	TUI_CreateLabel("Please select your language:",400,10,UIScreen,font,2)
	For Local F$=EachIn MapKeys(JCR.Entries)
		'Print F
		If Left(F,ll)=l And StripDir(F)="FLAG.PNG" 
			cl=StripDir(ExtractDir(F))
			ConsoleWrite "Found Language: "+Cl
			If Not MapContains(JCR.Entries,ExtractDir(F)+"/INTERFACE") error "Language "+cl+" has no interface"
			MapInsert LangButtons,cl,TUI_CreateButton("",x,y,UIScreen,LoadImage(JCR_B(JCR,F)))
			x:+100
			If x>800 x=10; y:+60
			EndIf
		Next
	End Method

	Method OnCycle()
	End Method
	
	Method NextStep()
	If Ini.C("DefaultPlayer") And FileType(Dirry(Userdir)+Ini.C("DefaultPlayer"))
		loaduser Ini.C("DefaultPlayer")
		ToScreen("MainMenu")
		'error "The next step after the language selection is not yet implemented"
	Else
		ToScreen("NewPlayer")
		EndIf
	Remove
	End Method
	
	Method OnInput()
	Local G:TUI_Gadget
	For Local K$=EachIn MapKeys(LangButtons)
		G = langbutton(K)
		If G.Action 
			chosenlanguage = K
			ConsoleWrite "User chose language: "+K
			IntLanguage = LoadID(JCR,"LANGUAGE/"+K+"/INTERFACE")
			If Not intlanguage error "Error in the language's interface!"
			SubLangGadgets
			EndIf
		Next
	If intLanguage NextStep
	End Method

	Method OnSwitch()
	End Method
	
	Method OnTerminate()
	Print "User wanted the app to be terminated so here we go!"
	End
	End Method

	End Type
