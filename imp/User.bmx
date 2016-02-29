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
' This file must be INCLUDED by Globals.bmx and it must NOT be called ny any other method

Rem
Import jcr6.jcr6Main
Import tricky_units.gamevars
Import tricky_units.jcr6stringmap
End Rem


Function SaveUser()
ConsoleWrite "Saving: "+Dirry(userdir)+UserName
Local bt:TJCRCreate = JCR_Create(Dirry(userdir)+UserName) Assert bt Else "Saving this JCR file doesn't work"
Local bte:TJCRCreateStream = bt.createentry("Identify","zlib")
Local wstr$
secuclearhashes
WriteLine bte.stream,"Engine=Aziella's Babling Bubbles"
WriteLine bte.Stream,"Type=User"
WriteLine bte.stream,"User="+UserName
bte.close
bte = bt.createentry("Config","zlib")
WriteLine bte.stream,"Music="+cfgmusic
WriteLine bte.stream,"Tutorial="+cfgtutorial
WriteLine bte.stream,"ColorBlind="+cfgcolorblind
WriteLine bte.stream,"SFX="+cfgsfx
?bigendian
WriteLine bte.stream,"LevelStorage=bigendian"
?littleendian
WriteLine bte.stream,"LevelStorage=littleendian"
?
bte.close
bte = bt.createentry("Data","zlib")
Wstr  = "Score="+score+"~n"
Wstr :+ "LevelScore="+levelscore+"~n"
Wstr :+ "Level="+level+"~n"
WStr :+ "ReqPoints="+ReqPoints+"~n"
WStr :+ "Points="+Points+"~n"
Wstr :+ "MaxTime="+MaxTime+"~n"
WStr :+ "MaxColors="+MaxColors+"~n"
WStr :+ "DropJoker="+DropJoker+"~n"
WStr :+ "DropCherry="+DropCherry+"~n"
WStr :+ "CD_Bomb="+CD_Bomb+"~n"
WSTR :+ "CDM_Bomb="+CDM_Bomb+"~n"
WStr :+ "CDP_Bomb="+CDP_Bomb+"~n"
WStr :+ "Time="+TimeLeft+"~n"
WStr :+ "FW="+FieldWidth+"~n"
WStr :+ "FH="+FieldHeight+"~n"
WriteString bte.stream,WStr
Local site$
For  site=EachIn MapKeys(UserOnline)
	secuhash "Data",WStr,onlineuser(site)
	Next
bte.close
WStr = ""
For Local ay=0 Until fieldheight For Local ax=0 Until fieldwidth wstr:+IntDump(gamefield[ax,ay]) Next Next
For site=EachIn MapKeys(UserOnline)
	secuhash "Field",WStr,onlineuser(site)
	Next
bte = bt.createentry("Field","zlib")
WriteString bte.stream,wstr
bte.close
WStr = ""
For Local ay=0 Until fieldheight For Local ax=0 Until fieldwidth wstr:+IntDump(gametiles[ax,ay]) Next Next
For site=EachIn MapKeys(UserOnline)
	secuhash "Tiles",WStr,onlineuser(site)
	Next
bte = bt.createentry("Tiles","zlib")
WriteString bte.stream,wstr
bte.close
SaveStringMap bt,"GameVars",GV,"zlib"
SaveStringMap bt,"Achievements",TrophyEarned,"zlib"
'Local site$
For site=EachIn MapKeys(UserOnline)
	SaveStringMap bt,"OnLine/"+site,onlineuser(site)
	Next
secusavehash bt	
bt.close
ConsoleWrite "Saving succesful!"
Local s:secu
For s=EachIn seculist
	s.SubmitScore("GENERAL",Score,Level)
	Next	
End Function

Function LoadUser(user$)
ConsoleWrite "Loading: "+Dirry(userdir)+User
Local LUJ:TJCRDir = JCR_Dir(Dirry(userdir)+User)
Local LUI:TID = LoadID(LUJ,"IDENTIFY")
Local LUC:TID = LoadID(LUJ,"CONFIG")
Local levelstorage$
If LUI.Get("Engine")<>"Aziella's Babling Bubbles" error "The user file "+user+" appears not to be made for this game!"
If LUI.GET("Type")<>"User" error "The userfile "+user+" appears NOT to be a user!"
If LUI.Get("User")<>User error "Username mismatch!"
cfgmusic = LUC.Get("Music").ToInt()
cfgtutorial = LUC.Get("Tutorial").toInt()
cfgcolorblind = LUC.Get("ColorBlind").toInt()
cfgsfx = LUC.Get("SFX").toint()
levelstorage = LUC.Get("LevelStorage")
GV = LoadStringMap(LUJ,"GameVars")
VarReg GV
Local site$
Local E:TJCREntry
Local F$
For f=EachIn MapKeys(LUJ.Entries)
	'Print ExtractDir(F)+" >> "+F
	If ExtractDir(F)="ONLINE"
		E = TJCREntry(MapValueForKey(luj.entries,F))
		site = StripDir(e.filename)
		ConsoleWrite "Login data found for site: "+site
		MapInsert useronline,site,LoadStringMap(luj,F)
		EndIf
	Next
If JCR_Exists(LUJ,"Achievements") TrophyEarned = LoadStringMap(LUJ,"Achievements")	
score=0
levelscore=0
level=0
dropjoker = 0
reqpoints = 0
points = 0
timeleft = 0
dropjoker = 0
maxtime = 0
maxcolors = 3
Local LUD:TID
LUD = LoadID(LUJ,"DATA")
score = LUD.Get("Score").tolong()
levelscore = LUD.Get("LevelScore").Tolong()
level = LUD.Get("Level").ToInt()
reqpoints = LUD.Get("ReqPoints").toInt()
points = LUD.Get("Points").ToInt()
timeleft = LUD.Get("Time").toint()
maxtime = LUD.Get("MaxTime").toInt()
maxcolors = LUD.Get("MaxColors").toint()
dropjoker = LUD.Get("DropJoker").ToInt()
dropcherry = LUD.GEt("DropCherry").toint()
cd_bomb = LUD.Get("CD_Bomb").toint()
cdm_bomb = LUD.Get("CDM_Bomb").toint()
cdp_Bomb = LUD.Get("CDP_Bomb").Toint()
UserName = User
Local BT:TStream = JCR_ReadFile(LUJ,"Field") If levelstorage.tolower() = ("bigendian") BT = BigEndianStream(BT) Else BT = LittleEndianStream(BT)
Local x,y
For y=0 Until fieldheight
	For x=0 Until Fieldwidth
		gamefield[x,y] = ReadInt(BT)
		gmfxy[x,y,0] = x*tilesize
		gmfxy[x,y,1] = (-((tilesize+8)*fieldheight))+(y*tilesize)
		Next
	Next		
BT = JCR_ReadFile(LUJ,"Tiles") If levelstorage.tolower() = ("bigendian") BT = BigEndianStream(BT) Else BT = LittleEndianStream(BT)
For y=0 Until fieldheight
	For x=0 Until Fieldwidth
		gametiles[x,y] = ReadInt(BT)
		Next
	Next		
	
Local s:secu
For s=EachIn seculist
	If onlineuser(s.name) 
		s.checkhash LUJ,["Data","Field"],onlineuser(s.name)
		s.login(onlineuser(s.name))
		EndIf
	Next	
End Function

Function GetUserList:TList()
Return ListDir(Dirry(userdir),LISTDIR_FILEONLY)
End Function

Function OnLineUser:StringMap(site$)
If Not MapContains(UserOnline,site) ConsoleWrite "Requested an unknown site: "+site,255,180,0
Return StringMap(MapValueForKey(UserOnline,site))
End Function



MKL_Version "Aziella's Babling Bubbles - imp/User.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/User.bmx","GNU - General Public License ver3"
