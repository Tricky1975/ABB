Rem
/*
	UI - Aziella's Babling Bubbles
	
	
	
	
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
Import "LanguageSelector.bmx" 
Import "NewPlayer.bmx" 
Import "MainMenu.bmx"
Import "Config.bmx"
Import "Credits.bmx"
Import "ModTrophies.bmx"
Import "Game.bmx"

Function Init_UI() 
ConsoleWrite "Init and load interfaces" 
newscreen "Language",New Aziella_Language 
newscreen "NewPlayer",New Aziella_newPlayer
newscreen "MainMenu",New MainMenu
NewScreen "Config",New AziellaConfig
newscreen "Credits",New ScreenCredits
NewScreen "Trophies",New TrophyOverview
NewScreen "Game",Game
currentscreen = Screen("Language") ' The game always starts with the language selector 
End Function 



MKL_Version "Aziella's Babling Bubbles - imp/UI.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/UI.bmx","GNU - General Public License ver3"
