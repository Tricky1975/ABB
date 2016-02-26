Rem
/*
	Trophies - Aziella's Babbling Bubbles
	
	
	
	
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
' This file is included by Globals.bmx

Function AwardTrophy(ID$)
Local s:secu
If trophyearned.Value(ID) Return
For s=EachIn seculist
	s.awardtrophy ID
	Next
Local ja:tjustachieved = New tjustachieved
ja.id = id
ListAddLast justachieved,ja
MapInsert TrophyEarned,ID,"TRUE"
score:+1000
End Function


MKL_Version "Aziella's Babling Bubbles - imp/Trophies.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/Trophies.bmx","GNU - General Public License ver3"
