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
Import tricky_units.Dirry
Import tricky_units.Initfile2

Import "Globals.bmx"


Function StartUp()
Local bits[]=[64,32,24,16]
Local bit=0
Local ak
?PPC
Notify "WARNING! You are about to play a build for PPC.~nThis CPU type is no longer supported. I'll let you play on, but expect some undesirable behavior!"
?
DebugLog "Loading: "+Inifile
If FileType(inifile) 
	Print "Reading: "+inifile
	LoadIni inifile,ini,True 'Ini.Load(inifile$)
	EndIf
If Not Ini.C("FullScreen.Asked").ToInt()
	For Local ak=EachIn bits
		If GraphicsModeExists(800,600,ak) And bit=0 bit=ak
		Next
	If bit
		Select Proceed("You computer appears to be able to run this game in a "+bit+"bit full screen mode.~n~nDo you wish to do so? (if you say ~qNo~q the game will be run windowed)")
			Case -1 End
			Case 0 Ini.D("FullScreen.Bit",0)
			Case 1 Ini.D("FullScreen.Bit",bit)
			End Select
		Ini.D("FullScreen.Asked",1)
		EndIf
	EndIf
CreateDir ExtractDir(Inifile),1	
SaveIni inifile,ini 'Ini.Save(Inifile)
Print "Changing to "+Ini.C("FullScreen.Bit")+"bit graphics mode!"
?debug
Graphics 800,600 ' In debug mode always windowed by default
Print "Because we are debugging now, always the windowed mode"
?Not debug
Graphics 800,600,Ini.C("FullScreen.Bit").ToInt()
?
Print "Going to alphablend"
SetBlend alphablend
End Function	
	

MKL_Version "Aziella's Babling Bubbles - imp/StartUp.bmx","15.02.25"
MKL_Lic     "Aziella's Babling Bubbles - imp/StartUp.bmx","GNU - General Public License ver3"
