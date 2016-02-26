Rem
/* 
  Secu

  Copyright (C) 2015 Jeroen P. Broks

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/



Version: 15.02.28

End Rem
Import tricky_units.MKL_Version
Import tricky_Units.StringMap
Import jcr6.jcr6main

Type Secu
	Method Run() Abstract
	Method NoPatch() Abstract
	Method AwardTrophy(ID$) Abstract
	Method SubmitScore(ID$,Score,Level) Abstract
	Method Login(Data:StringMap) Abstract
	Method ClearHashes() Abstract
	Method Hash(f$,t$,d:StringMap) Abstract
	Method savehash(bt:TJCRCreate) Abstract
	Method Logout() Abstract
	Method checkhash(J:TJCRDir,A$[],l:StringMap) Abstract
	Field LoginData$[]
	Field Name$	
	
	Method Modified(v=True)
	ModifiedGame=modifiedgame Or v
	DebugLog "Modified = "+Modifiedgame
	End Method
	End Type
	
Global SecuList:TList = New TList

Global ModifiedGame=False

Function SecuClearHashes()
For Local s:secu = EachIn seculist
	s.clearhashes
	Next
End Function

Function SecuHash(F$,T$,d:StringMap)
For Local s:secu = EachIn seculist
	s.hash f,T,d
	Next
End Function

Function SecuSaveHash(bte:TJCRCreate)
For Local s:secu = EachIn seculist
	s.savehash bte
	Next
End Function	

Function SecuCheckHash(J:TJCRDir,A$[],L:StringMap)
For Local s:secu = EachIn seculist
	s.checkhash K,a,L
	Next
End Function

	

Function SecuEnd()
For Local s:secu = EachIn seculist
	s.logout
	Next
End Function

MKL_Version "Aziella's Babling Bubbles - imp/Secu.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/Secu.bmx","zLIB License"
