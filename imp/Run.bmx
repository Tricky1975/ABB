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


Version: 15.02.24

End Rem
Strict

Import "Basis.bmx"

Function Run()
Repeat
Cls
TUI_Run CurrentScreen.UIScreen
currentscreen.oncycle
currentscreen.oninput
If AppTerminate() currentscreen.onterminate
Flip
Forever
End Function

MKL_Version "Aziella's Babling Bubbles - imp/Run.bmx","15.02.24"
MKL_Lic     "Aziella's Babling Bubbles - imp/Run.bmx","GNU - General Public License ver3"
