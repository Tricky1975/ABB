Rem
/*
	"Module" Trophies - Aziella's Babling Bubbles
	
	
	
	
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
' This is the imported UI file, the other is only the routines that award stuff
Strict
Import "Basis.bmx"
Import "Speak.bmx"
Import "Aquarium.bmx"

Type TrophyOverview Extends AziellaBase

	Field Check:TImage = LoadImage(JCR_B(JCR,"GFX/Achievements/Check.png"))
	Field Back:TUI_Gadget

	Method OnLoad() 
	CreateAquarium UIScreen ' Always comes first
	If Not UI_BackButton UI_BackButton = LoadImage(JCR_B(JCR,"GFX/UI/Previous.png"))
	back = TUI_CreateButton("",20,590-ImageHeight(UI_BackButton),UIScreen,UI_BackButton)	
	SupportAziella UIScreen ' This one must ALWAYS be the last gadget	
	EndMethod
	
	Method X()
	Local ret = 10
	Local AX = AziellaX+ImageWidth(AziellaPic)
	If AX>ret ret=AX
	Return ret
	End Method
	
	Method OnCycle() 
	Local tx = X()
	Local tw = 790-X()
	Local th = 50
	Local ty = 5
	Local K$
	For K=EachIn MapKeys(trophynames)
		SetViewport tx,ty,tw,th
		SetOrigin tx,ty
		SetAlpha .5
		SetColor 0,0,0		
		DrawRect 0,0,tw,th
		SetColor 255,255,255
		SetAlpha 1
		If trophyearned.Value(k) DrawImage check,0,0
		SetColor 255,180,0
		SetImageFont inputfont
		DrawText TrophyNames.Value(k),100,3
		SetColor 180,255,0
		DrawText TrophyDescs.Value(k),100,26
		ty:+55
		Next
	SetViewport 0,0,800,600
	SetOrigin 0,0	
	EndMethod
	
	Method OnInput() 
	If Back.action ToScreen "MainMenu"
	EndMethod
	
	Method OnSwitch() 
	If Not VarCall("&TROPHYFIRST") 
		AziellaSpeak("Trophies/Trophy")
		VarDef "&TROPHYFIRST","TRUE"
		EndIf	
	EndMethod
	
	End Type

