Rem
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 2.0
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is (c) Jeroen P. Broks.
 *
 * The Initial Developer of the Original Code is
 * Jeroen P. Broks.
 * Portions created by the Initial Developer are Copyright (C) 2015
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 * -
 *
 * ***** END LICENSE BLOCK ***** */



Version: 15.02.25

End Rem
Strict
Import tricky_ui.TUI_Core
Import tricky_ui.TUI_PolledInput
Import tricky_units.console
Import tricky_units.MKL_Version
Import tricky_units.HotSpot
Import tricky_units.GetFont

Import "Globals.bmx"
Import "LangGadgets.bmx"
'Import "Aquarium.bmx"

Incbin "incbin/ConsoleBubble.png"

MKL_Version "Aziella's Babling Bubbles - imp/Basis.bmx","15.02.25"
MKL_Lic     "Aziella's Babling Bubbles - imp/Basis.bmx","Mozilla Public License 2.0"


ConsoleBackGroundPicture = LoadImage("incbin::incbin/ConsoleBubble.png")

Type TScreenMap Extends tmap
	
	Method NewScreen(Scr$,Obj:Object)
	If Not AziellaBase(Obj) Error "Invalid type for newscreen" 
	Local A:AziellaBase = AziellaBase(Obj)
	A.OnLoad()
	MapInsert Self,Upper(Scr$),A
	ConsoleWrite "Created screen: "+Scr,255,180,0
	If showconsole ConsoleShow; Flip
	End Method
	
	Method Screen:AziellaBase(scr$)
	Return aziellabase(MapValueForKey(Self,Upper(scr)))
	End Method
	
	End Type
	
Global ScreenMap:TScreenMap = New TScreenmap	
Global CurrentScreen:AziellaBase
Global ShowConsole = True

Type AziellaBase

	Field UIScreen:TUI_Gadget = TUI_CreateScreen()

	Method OnLoad() Abstract
	Method OnCycle() Abstract
	Method OnInput() Abstract
	Method OnSwitch() Abstract
	
	Method OnTerminate() 
	If Confirm("Are you sure you want to quit?") 
		SaveUser
		SecuEnd		
		End
		EndIf
	End Method
	
	Method KeyHit(key)
	Return TUI_CID.KeyHit[key]
	End Method
	
	Method KeyDown(Key)
	Return TUI_CID.KeyDown[key]
	End Method
	
	Method MouseHit(key)
	Return TUI_CID.MouseHit[key]
	End Method
	
	Method Remove()
	For Local K$=EachIn MapKeys(ScreenMap)
		If MapValueForKey(ScreenMap,k)=Self 
			MapRemove ScreenMap,k
			ConsoleWrite "UI "+k+" will have to be removed!"
			End If
		Next
	End Method
	
	Method GoToScreen(Scr$)
	currentscreen = Screen(Scr)
	End Method
	
	Method Delete()
	ConsoleWrite "An UI removed!"
	End Method
	
	End Type
	
Function NewScreen(K$,Obj:Object)
ScreenMap.NewScreen(K,Obj)
'Screen(k).OnLoad()
End Function	

Function ToScreen(scr$) 
Currentscreen = Screen(scr)
currentscreen.OnSwitch
End Function


Function Screen:Aziellabase(k$)
Local ret:Aziellabase = ScreenMap.Screen(k)
If Not ret Error "Unknown Screen (~q"+k+"~q)"
Return ret
End Function


