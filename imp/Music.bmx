Rem
/*
	
	Music - Aziella's Babbling Bubbles
	
	
	
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
Import brl.oggloader
Import brl.freeaudioaudio
Import brl.audio
Import brl.max2d
Import jcr6.jcr6Main 
Import tricky_units.console
Import tricky_units.HotSpot

Import "error.bmx"

Const musicchat = True

Global musicchecked 
Global musicavailable 

Global CfgMusic = True


Global MusicSound:TSound
Global MusicChannel:TChannel
Global MusicLast$

Global Loading:TImage

Function MusicCheck(JCR:TJCRDir)
For Local F$=EachIn MapKeys(JCR.Entries)
	musicavailable = musicavailable Or Left(F,6)="MUSIC/"
	'Print Left(F,6)+" >> "+F
	Next
musicchecked = True	
ConsoleWrite "Music availability is "+musicavailable
End Function


Function Music(JCR:TJCRDir,f$)
If Not musicchecked musiccheck JCR
If Not musicavailable MCHat("No music available") Return
If Upper(f)=musiclast MChat("Same as last!") Return
If Not cfgmusic MChat("Configured against music") Return
If Not loading 
	loading = LoadImage(JCR_B(JCR,"GFX/General/Loading.png")); 
	HotCenter Loading
	EndIf
Cls
DrawImage loading,400,300
Flip
musicsound = LoadSound(JCR_B(JCR,"Music/"+f),true)
If Not musicsound error "Music could not be loaded: Music/"+f
stopmusic
musicchannel = PlaySound(musicsound)
musiclast = Upper(f)
End Function

Function stopmusic()
If musicchannel 
   If ChannelPlaying(musicchannel) StopChannel musicchannel
   EndIf
musiclast = ""
End Function



Private
Function MChat(A$)
If musicchat ConsoleWrite("MUSIC> "+A,0,255,255)
End Function
