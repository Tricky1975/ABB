Rem
/*
	Global Variables - Aziella's Babling Bubbles
	
	
	
	
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

Import tricky_units.identify
Import tricky_units.initfile
Import tricky_units.Dirry
Import tricky_units.GameVars
Import tricky_units.jcr6stringmap
Import tricky_units.console
Import tricky_units.numdump

Import "Secu.bmx" 
Import "Error.bmx"
Import "Music.bmx"



MKL_Version "Aziella's Babling Bubbles - imp/Globals.bmx","15.02.28"
MKL_Lic     "Aziella's Babling Bubbles - imp/Globals.bmx","GNU - General Public License ver3"


' Dirs
Const WorkDir$ = "$AppSupport$/Phantasar Productions/Aziella Babling Bubbles/"
Const UserDir$ = Workdir + "Users/"
Const JCREDir$ = WorkDir + "JCRE/"

JCR_EDir = Dirry(JCREDir); 
If Not CreateDir(JCR_EDir,1) Notify "Create dir error: "+JCREDir End
If Not CreateDir(Dirry(UserDir),1)  Notify "Create dir error: "+Dirry(UserDir) End

' Fonts
Const FONT_LANGUAGESELECTOR$ = "FINAL.TTF"
Const FONT_AZIALLASPEAKS$ = "FONTS/CAROLINGIA.TTF"
Const FONT_NEWUSERHEAD$ = "FONTS/ANGELINA.TTF"
Const FONT_INPUT$ = "FONTS/CAVIARDREAMS.TTF"

Global InputFont:Timagefont

' Ini
Global Ini:TIni = New TIni
Global inifile$ = Dirry(Workdir)+"Ini/Init.ini"

' JCR
Global JCR:TJCRDir
Global MJID:TID

' Languages
Global ChosenLanguage$
Global IntLanguage:TID

' In-Game Vars
Global GV:StringMap = New StringMap
VarReg GV

' User
Include "User.bmx" ' Want to functions in this file, but importing this would not work.
Global UserName$
Global UserOnline:TMap = New TMap
Global cfgTutorial = True
Global CfgColorBlind = False
Global cfgSFX = True

Global Score:Long = 0
Global LevelScore:Long = 0
Global Level = 0

' Game
Const FieldX = 40
Const FieldY = 5
Const FieldWidth=16
Const FieldHeight=16
Const tilesize=32
Const tilemovespd=4

Global GameField[fieldwidth,fieldheight]
Global gametiles[fieldwidth,fieldheight]
Global GMFXY[fieldwidth,fieldheight,2]
Global MaxTime,TimeLeft
Global ReqPoints,Points
Global MaxColors
Global dropjoker
Global dropcherry
Global tilecount ' does not need to be saved, as this var is updated realtime!
Global selectedcolors:TCol[11]

Const fieldjoker=1000
Const fieldbomb=1001
Const fieldbonus=1002
Const fieldmakespike=1003
Const fieldhspike=1004
Const fieldvspike=1005

Global NoMove[] = [fieldbomb,fieldbonus,fieldmakespike]

Global CD_Bomb,CDM_Bomb=3000,CDP_Bomb=100


Type TCol
	Field R,G,B
	Field L$
	End Type

Type Tcoord
	Field x,y
	End Type
	
Type BMes
	Field c:Tcoord
	Field M$
	Field timer
	End Type	
	
Global LevelPics:TImage[50]	

' UI
Global UI_LongButton:TImage
Global UI_BackButton:TImage
Global UI_SmallButton:TImage
Global ilogo:TImage
Global Check:TImage,UnCheck:TImage

' Trophies
Type TJustAchieved
	Field ID$
	Field Timer = 500
	End Type
Global TrophyNames:StringMap
Global TrophyDescs:StringMap
Global TrophyEarned:StringMap = New StringMap
Global JustAchieved:TList = New TList
Include "Trophies.bmx"



