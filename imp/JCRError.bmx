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
Import tricky_units.console
Import jcr6.jcr6main
Type AZIELLAJCRERRORDRIVER Extends JCR_JAMERR_Driver
	Method DumpError(Dump$,ERR:TJCR_Error)
	Local R,G,B
	For Local L$=EachIn Dump.split("~n")
		If Left(L,5)="==== " R=255 G=0 B=0 Else R=255 G=255 B=0 
		ConsoleWrite L,R,G,B
		Next	
	'If GALEJCRCRASH GALECON.GaleErrorClosureRequest
	ConsoleWrite "Hit any key to exit this program!"
	ConsoleShow
	Flip
	WaitKey
	end
	End Method
	End Type
	
New AziellaJCRERRORDRIVER	

