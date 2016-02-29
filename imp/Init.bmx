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

Import "Basis.bmx" 
Import "Globals.bmx" 


Import "UI.bmx"

Import tricky_units.identify


MKL_Version "Aziella's Babling Bubbles - imp/Init.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/Init.bmx","GNU - General Public License ver3"

Function Init_VersionOverview() 
Local Lines$[] = MKL_GetAllversions(False).split("~n") 
For Local Line$=EachIn Lines 
	ConsoleWrite Line,255,180,0 
	ConsoleShow 
	Flip 
	Next
ConsoleWrite ""	
End Function

Function Init_CheckOriginal()
DebugLog "Checking original version"
For Local S:Secu = EachIn SecuList
	S.Run
	Next
End Function

Function Init_JCR()
Local PJID:TID
Local PJCR:TJCRDir
ConsoleWrite "Init Main JCR: Bubbeltjes.JCR"
JCR = JCR_Dir("Bubbeltjes.JCR")
MJID = LoadID(JCR)
If Not MJID error "No Identify Data Appears To Be Present in Bubbeltjes.JCR"
If MJID.Get("Engine")<>"Aziella's Babling Bubbles" error "This JCR file is for the "+MJID.Get("Engine")+" engine!"
If Ini.List("Patch")
	For Local P$=EachIn Ini.List("Patch")
		ConsoleWrite("  = Adding patch file: "+P)
		ModifiedGame = True
		PJCR = JCR_Dir(P)
		PJID = LoadID(JCR,"Patch/Identify")
		If Not PJID Error "Patch/Identify not found in patch!",True
		If PJID.Get("Engine")<>"Aziella's Bubbling Bubbles" error "This patch JCR file is for the "+MJID.Get("Engine")+" engine!"
		MapRemove PJCR.Entries,"Patch/Identify"
		MapRemove PJCR.Entries,"PATCH/IDENTIFY"
		JCR_AddPatch JCR,PJCR
		Next
	EndIf
ConsoleWrite ""	
End Function

Function Init_Trophies()
ConsoleWrite "Loading trophies"
ConsoleShow
Flip
TrophyNames = LoadStringMap(JCR,"Data/Achievements/Names")
TrophyDescs = LoadStringMap(JCR,"Data/Achievements/Descriptions")
End Function

Function Init()
ConsoleWrite "Aziella's Babling Bubbles",0,255,255
ConsoleWrite "Build: "+MKL_NewestVersion(),0,255,255
ConsoleWrite "Coded by: Jeroen P. Broks",0,255,255
ConsoleWrite "(c) Jeroen P. Broks, 2015",0,255,255
ConsoleWrite ""
Init_VersionOverView()
Init_CheckOriginal
Init_JCR
Init_Trophies
Init_UI
'ConsoleShow; Flip; WaitKey ' Debug Init Only!
End Function

