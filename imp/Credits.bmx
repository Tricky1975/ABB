Rem
/*
	Credits - Aziella's Babbing Bubbles
	
	
	
	
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
Import jcr6.jcr6main
Import "Basis.bmx"
Import "Aquarium.bmx"
Import "Speak.bmx"
Private
Type TCred
	Field x,y
	Field align
	Field txt$
	Field timer
	End Type
Public		

Type ScreenCredits Extends AziellaBase
	
	Field Cred:TList = New TList
	Field glogo:TUI_Gadget
	Field back:TUI_Gadget

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
	TUI_CreateLabel "Game design: Jeroen P. Broks (Phantasar Productions)",10,150,uiscreen,inputfont
	TUI_CreateLabel "Written in: BlitzMax (http://www.blitzmax.com)",10,170,uiscreen,inputfont
	TUI_CreateLabel "Additional modules: Bruce A. Henderson",10,190,uiscreen,inputfont
	TUI_CreateLabel "Assets by:",400,230,uiscreen,inputfont,2
	SupportAziella UIScreen ' This one must ALWAYS be the last gadget
	End Method
	
	Method OnCycle() 
	Local c:TCred
	Local x
	For c = EachIn cred
		If c.timer c.timer:-1
		If c.timer<=150
			SetAlpha 1-(c.timer/150)
			SetColor 255,255,255
			SetImageFont inputfont
			Select c.align
				Case 0	x = c.x
				Case 1  x = c.x -  TextWidth(c.txt)
				Case 2  x = c.x - (TextWidth(c.txt)/2)
				End Select
			DrawText c.txt,x,c.y
			EndIf
		Next
	End Method
	
	Method OnInput()
	If back.action toscreen "MainMenu"
	End Method
	
	Method OnSwitch() 
	AwardTrophy "VIEWCREDITS"
	Local wegothim:TList = New TList
	Local C:TCRED
	Local x
	Local y = 250
	Local px[] = [10,400,790]	
	Local pa[] = [0,2,1]
	ClearList cred
	For Local E:TJCREntry = EachIn MapValues(JCR.entries)
		If Not ListContains(WeGotHim,E.Author) And E.Author<>"Tricky"
			C = New TCred
			ListAddLast WeGotHim,E.Author
			ListAddLast Cred,c
			c.x = px[x]
			c.y = y
			c.align = pa[x]
			c.timer = Rand(1,500)
			c.txt = E.Author
			x:+1; If x>=3 x=0; y:+20
			EndIf
		Next
	End Method
	
	End Type

