Rem
/*
	Aziella's Babling Bubbles
	A nice puzzle game
	
	
	
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


Version: 15.02.26

End Rem

Strict

Framework jcr6.zlibdriver
Import    brl.pngloader
Import    brl.freetypefont

Import "imp/LanguageSelector.bmx"
Import "imp/JCRError.bmx"
Import "imp/init.bmx"
Import "imp/run.bmx"
Import "imp/startup.bmx"

' Exclusively for the GameJolt.com download.
' This source file is close-sourced in order not to compromise GameJolt's security
' And therefore not distributed with the rest of the stuff
' If you obtained this source from GitHub, please put a "'" before the Import statement (I can't as that hinders my development process)
' And the game should compile normally.
Import "Secu/GameJolt.bmx"


AppTitle = "Aziella's Babling Bubbles "
?MacOS
AppTitle :+ "for Mac"
?Win32
AppTitle :+ "for Windows"
?Linux
AppTitle :+ "for Linux"
?
?Debug
AppTitle :+ "  (Debug Build)"
?

MKL_Version "Aziella's Babling Bubbles - Aziella's Babling Bubbles.bmx","15.02.26"
MKL_Lic     "Aziella's Babling Bubbles - Aziella's Babling Bubbles.bmx","GNU - General Public License ver3"


StartUp
Init
Run
