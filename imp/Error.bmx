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


Version: 15.02.25

End Rem
Import tricky_units.console

Function Error(Err$,Patch=False)
ConsoleWrite "OOPS!",255,0,0
If patch
	ConsoleWrite "Something appears to be wrong with this patch file!"
	ConsoleWrite "Please contact the author of this patch file!"
	Else
	ConsoleWrite "You tried something I didn't think of!",255,180,0
	ConsoleWrite ""
	ConsoleWrite "Whatever it was, it's pretty likely caused by a bug!",0,255,255
	ConsoleWrite "Please contact Jeroen P. Broks aka Tricky or",0,255,255
	ConsoleWrite "Phantasar Productions and report this bug to him",0,255,255
	ConsoleWrite ""
	ConsoleWrite "Below is the error message. Please tell him the EXACT error message!",0,255,255
	EndIf
ConsoleWrite Err$,255,0,255
ConsoleWrite ""
ConsoleWrite "Please press any key to quit this program!",255,255,0
ConsoleShow
Flip
WaitKey
End
End Function

