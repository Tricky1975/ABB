Rem
/*
	Game - Aziella's Babbling Bubbles
	The main game can be found here!
	
	
	
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
Import "Aquarium.bmx"
Import "Speak.bmx"
Import tricky_units.Listfile
Import tricky_units.swapper
Import tricky_units.pythagoras



' The game field driver
Type TUI_GDrvGame Extends TUI_Gadgetdriver

	Field Bubble:TImage
	Field Tile:TImage

	Method Run(G:TUI_Gadget,Enabled)
		Tilecount=0
		If Not bubble bubble = LoadImage(JCR_B(JCR,"GFX/Levels/Bubbles/Bubble.png"))
		If Not bubble error "Bubble image not properly loaded"
		If Not tile tile = LoadImage(JCR_B(JCR,"GFX/Levels/Tiles/Tile.png"))
		If Not tile error "Tile image not properly loaded"
		Local th=ImageHeight(Game.Tube)
		Local tw=ImageWidth (Game.Tube)
		Local LMouseX=MouseX()-fieldx
		Local LmouseY=MouseY()-fieldy
		Local lmx = Floor(LMousex/tilesize)
		Local lmy = Floor(Lmousey/tilesize)
		'tubes
		' Time Tube
		SetColor 0,255,255
		DrawRect 3,5+th,tw,-((Double(timeleft)/maxtime)*th)
		SetColor 255,255,255
		DrawImage Game.Tube,3,5 
		' Requirement (if set) tube
		If reqpoints
			SetColor 255,180,0
			DrawRect 20,5+th,tw,-((Double(points)/reqpoints)*th)
			If points>=reqpoints points=reqpoints
			SetColor 255,255,255
			DrawImage Game.Tube,20,5 
			EndIf
		' field
		SetViewport fieldx,fieldy,fieldwidth*tilesize,fieldheight*tilesize
		SetOrigin fieldx,fieldy
		SetColor 0,0,0
		SetAlpha .5
		DrawRect 0,0,fieldwidth*tilesize,fieldheight*tilesize
		SetAlpha 1
		SetColor 255,255,255
		' Bubbles
		Local b
		Local t
		Local tilecolr[] = [0,255,255,255,255]
		Local tilecolg[] = [0,180,255,255,255]
		Local tilecolb[] = [0,  0,  0,180,255]
		Local shx,shy,goodspot,goodaction,goodcancel
		For Local ay=0 Until fieldheight
			For Local ax=0 Until fieldwidth
				b = gamefield[ax,ay]
				shx = ax*tilesize
				shy = ay*tilesize
				t = gametiles[ax,ay]
				If t
					SetColor tilecolr[t],tilecolg[t],tilecolb[t]
					DrawImage tile,shx,shy
					tilecount:+t
					EndIf
				If b=0
					If ay
						GMFXY[ax,ay,0]=GMFXY[ax,ay-1,0]
						GMFXY[ax,ay,1]=GMFXY[ax,ay-1,1]
						GameField[ax,ay]=Gamefield[ax,ay-1]
						GameField[ax,ay-1]=0
						Else
						Game.GenNew ax,ay
						EndIf
				ElseIf b<1000
					If b>Len(game.Bubblecolor) error "Bubble color overflow in drawing!"
					SetColor selectedcolors[b].R,selectedcolors[b].G,selectedcolors[b].B
					DrawImage bubble,GMFXY[ax,ay,0],GMFXY[ax,ay,1]
					If cfgColorBlind
						SetImageFont inputfont
						SetColor 0,0,0
						DrawText selectedcolors[b].L,GMFXY[ax,ay,0]+5,GMFXY[ax,ay,1]+5
						EndIf
					'SetColor 255,255,255; DrawText ax+","+ay,GMFXY[ax,ay,0],GMFXY[ax,ay,1]
				Else
					SetColor 255,255,255
					DrawImage LevelPics[b-1000],GMFXY[ax,ay,0],GMFXY[ax,ay,1]
					EndIf										
				If GMFXY[ax,ay,0]<shx
					GMFXY[ax,ay,0]:+tilemovespd
					If GMFXY[ax,ay,0]>shx GMFXY[ax,ay,0]=shx
					EndIf
				If GMFXY[ax,ay,1]<shy
					GMFXY[ax,ay,1]:+tilemovespd
					If GMFXY[ax,ay,1]>shy GMFXY[ax,ay,1]=shy
					EndIf
				If GMFXY[ax,ay,0]>shx
					GMFXY[ax,ay,0]:-tilemovespd
					If GMFXY[ax,ay,0]<shx GMFXY[ax,ay,0]=shx
					EndIf
				If GMFXY[ax,ay,1]>shy
					GMFXY[ax,ay,1]:-tilemovespd
					If GMFXY[ax,ay,1]<shy GMFXY[ax,ay,1]=shy
					EndIf	
				goodspot = LMouseX>=shx And LMouseX<shx+tilesize And LMouseY>=shy And LMouseY<shy+tilesize 
				goodaction = goodspot And Game.MouseHit(1)
				goodcancel = goodspot And game.MouseHit(2)
				If goodspot
					SetColor Rand(0,255),Rand(0,255),Rand(0,255)
					DrawLine shx         ,shy         ,shx+tilesize,shy            ' U
					DrawLine shx+tilesize,shy         ,shx+tilesize,shy+tilesize   ' R
					DrawLine shx+tilesize,shy+tilesize,shx         ,shy+tilesize   ' D
					DrawLine shx         ,shy+tilesize,shx         ,shy            ' L
					EndIf
				Select Game.WhatWeDo
					Case "Bomb"
						If Distance2D(LMX,LMY,ax,ay)<5
							SetAlpha .4
							SetColor 255,0,0
							DrawRect shx,shy,tilesize,tilesize
							SetAlpha 1
							EndIf
						If goodaction Game.Bomb ax,ay
						If Goodcancel Game.WhatWeDo=""	
					Default	
						If goodaction
							Game.Pop ax,ay
							EndIf
					End Select		
				Next
			Next
		
		' big screen
		SetViewport 0,0,800,600
		SetOrigin 0,0
		' Update tilegadgets
		Game.G_Tilelabel.visible = tilecount
		Game.G_tiles.visible = tilecount
		Game.g_tiles.text = tilecount
		End Method

End Type

regtuidriver "Game",New TUI_GDrvGame






' The Game Itself
Type TGame Extends AziellaBase

	Field ShowScore
	Field GameGadget:TUI_Gadget
	Field BMessages:TList = New TList
	
	Field Tube:TImage
	
	Field G_ShowScore:TUI_Gadget
	Field G_Level:TUI_Gadget
	Field G_HFlip:TUI_Gadget
	Field G_VFlip:TUI_Gadget
	Field G_ROT_R:TUI_Gadget
	Field G_ROT_L:TUI_Gadget
	Field G_TileLabel:TUI_Gadget
	Field G_Tiles:TUI_Gadget
	Field Tool_Bomb:TUI_Gadget
	Field Back2Main:TUI_Gadget
	Field PauseGame:TUI_Gadget
	Field RestartLvl:TUI_Gadget
	
	Field BubbleColor:tCol[6] 
	'Field BubbleColorBlind$[] = ["R","G","B","Y","C","M"]
	
	Field RandomTunes:String[]
	Field CountRandomTunes
	
	Field WhatWeDo$
	
	
	Method LoadLevel()
	Local x,y,yt
	Local L$
	Local RdSet=0
	Local SL$[]
	' Reset all data before loading
	For x=0 Until fieldwidth For y=0 Until fieldheight 
		gamefield[x,y]=0 
		gametiles[x,y]=0
		GMFXY[x,y,0] = x*tilesize
		GMFXY[x,y,1] = (-(fieldheight*80))+(y*tilesize*2)
		Next Next ' 2x for = 2x next
	MaxTime = 10000
	ReqPoints = 0
	Points = 0
	maxcolors=3
	dropjoker=0
	dropcherry=0
	x=0
	y=0
	yt = 0
	For Local RL$=EachIn Listfile(JCR_B(JCR,"Data/Levels/"+Right("00"+level,3)))
		L=Trim(RL)
		?Debug
		Print "Read: "+L
		?
		If L
			If L = "[data]"  
				rdset=1
			ElseIf L = "[level]" 
				rdset=2
			ElseIf L = "[rem]"   
				rdset=0
			ElseIf L = "[tiles]"
				rdset=3
			Else
				Select rdset
					Case 1
						sl = l.split("=")
						If Len(sl)<2 error "Incorrect definition in level file: "+L
						sl[0] = Lower(Trim(sl[0]))
						sl[1] = Trim(SL[1])
						Select sl[0]
							Case "tut","tutorial","tutor"
								?debug
								ConsoleWrite "Tutorial requested - CFG = "+cfgtutorial+"; &TUT = " + VarCall("&TUTLEVEL"+Level)
								?
								If (Not VarCall("&TUTLEVEL"+Level)) And cfgtutorial And SL[1].tolower()="yes"
									AziellaSpeak "Levels/"+Right("00"+level,3)
									VarDef "&TUTLEVEL"+Level,"TRUE"
									EndIf
							Case "maxtime"	MaxTime=SL[1].ToInt(); TimeLeft = MaxTime		
							Case "reqpoints","fillreq" ReqPoints=SL[1].ToInt()
							Case "maxcolor","maxcolors" maxcolors=SL[1].ToInt()
							Case "joker","jokers" dropjoker=sl[1].toint()
							Case "cherry","cherries" dropcherry=sl[1].toint()
							End Select	
						Case 2
							If Len(L)<fieldwidth error "Field line too short    "+Len(L)+" < "+Fieldwidth
							?debug
							If Len(L)>fieldwidth ConsoleWrite "WARNING! Field line too long! "+Len(L)+" > "+Fieldwidth; ConsoleWrite Int(Len(L)-fieldwidth)+" characters removed!"
							?
							If Y<fieldheight
								For x=0 Until fieldwidth
									Select L[x]
										Case 49,50,51,52,53,54,55,56,57
											gamefield[x,y] = L[x]-48
											If L[x]-48>Len(bubblecolor) error "Bubble color overflow!"
										Case 48
											gamefield[x,y] = 10	
										Case "J"[0]
											gamefield[x,y] = fieldjoker	
										Case "C"[0]
											gamefield[x,y] = fieldbonus
										Case "R"[0]
											gamefield[x,y] = Rand(1,maxcolors)	
										Default
											error "Unknown field character "+Right(Hex(l[x]),2)+"/"+L[x]+"/"+Chr(L[x])+" >> "+L
										End Select
									Next
								Y:+1	
								?debug
							Else
								ConsoleWrite "WARNING! Too many field lines!! Line "+L+" is ignored!"
								?
								EndIf
						Case 3
							If Len(L)<fieldwidth error "Tile line too short    "+Len(L)+" < "+Fieldwidth
							?debug
							If Len(L)>fieldwidth ConsoleWrite "WARNING! Tile line too long! "+Len(L)+" > "+Fieldwidth; ConsoleWrite Int(Len(L)-fieldwidth)+" characters removed!"
							?
							If YT<fieldheight
								For x=0 Until fieldwidth
									Select L[x]
										Case 49,50,51,52
											gametiles[x,yT] = L[x]-48
											tilecount:+1
										End Select
									Next
								YT:+1	
								?debug
							Else
								ConsoleWrite "WARNING! Too many tile lines!! Line "+L+" is ignored!"
								?
								EndIf
								
					End Select
				EndIf
			EndIf
		Next
	getrandomcolors()
	End Method
	
	Method GetRandomColors()	
	' Determine the colors
	Local r1ak,r2ak,timer,ok,r
	For r1ak=1 To Len(bubblecolor)
		timer=0
		Repeat
		ok=True		
		r=Rand(0,Len(bubblecolor)-1)
		?debug
		ConsoleWrite "value "+r1ak+" will have color #"+r
		?
		selectedcolors[r1ak]=bubblecolor[r]
		If r1ak>1
			For r2ak=1 Until r1ak
				ok = ok And selectedcolors[r1ak]<>selectedcolors[r2ak]
				Next
			timer:+1	
			EndIf
		If timer>20000 error "Bubble color selection timeout!"
		Until ok
		Next			
	End Method
	
	Method GenNew(x,y)
	Local thing
	' New Coordinates
	Local py = -40
	Local ak
	For ak=0 Until fieldheight
		If py+40>=GMFXY[x,ak,1] py:-40
		Next
	GMFXY[x,y,0]=x*32
	GMFXY[x,y,1]=py
	' New extra
	If DropJoker And Rand(1,DropJoker)=1 thing = fieldjoker
	If dropcherry And Rand(1,DropCherry)=1 thing = fieldbonus
	' new bubble
	If Not thing
		thing = Rand(1,MaxColors)
		EndIf
	Gamefield[x,y]=thing	
	End Method
	
	Method coord:Tcoord(x,y)
	Local ret:Tcoord = New tcoord
	ret.x = x
	ret.y = y
	Return ret
	End Method
	
	Method BMessage(t$,x,y,x32=32)
	Local r:Bmes = New BMes
	r.c = coord(x*x32,y*x32)
	r.timer=1000
	r.m = t
	ListAddLast Bmessages,r
	?debug
	ConsoleWrite "B-Message ~q"+t+"~q  ("+r.c.x+","+r.c.y+")"
	?	
	End Method	
	
	Function Destroyable(x,y)
	Return True
	End Function
	
	Method Bomb(x,y)
	For Local ax=0 Until fieldwidth
		For Local ay=0 Until fieldheight
			If Distance2D(x,y,ax,ay)<5 And destroyable(ax,ay) Gamefield[ax,ay]=0
			Next
		Next
	CD_Bomb  =  CDM_Bomb
	CDM_Bomb :+	CDP_Bomb
	If Rand(1,4)=1 CDP_Bomb:+1
	WhatWeDo = ""
	End Method
	
	
	Method Pop(x,y)
	Local count
	Local scorepoints,total
	Local mul = Int(Double((Double(timeleft)/maxtime)*Double(2))) + (timeleft<>0)
	Local mustpop:TList = New TList
	Local Fil1:TList = New TList
	Local Fil2:TList = New TList
	Local C:Tcoord,pop:Tcoord
	Local ak	
	Local b = gamefield[x,y]	
	Local popfield[fieldwidth,fieldheight]
	ListAddLast fil2, coord(x,y)
	ListAddLast mustpop, coord(x,y)
	popfield[x,y]=True
	While CountList(fil2)
		fil1 = fil2
		fil2 = New TList
		For c=EachIn fil1
			For ak=-1 To 1 Step 2
				If c.x+ak>=0 And c.x+ak<fieldwidth And (Not popfield[c.x+ak,c.y])
					If gamefield[c.x+ak,c.y] = b Or gamefield[c.x+ak,c.y]=fieldjoker
						pop=coord(c.x+ak,c.y)
						ListAddLast fil2,pop
						ListAddLast mustpop,pop
						popfield[pop.x,pop.y]=True
						EndIf
					EndIf
				If c.y+ak>=0 And c.y+ak<fieldheight And (Not popfield[c.x,c.y+ak])
					If gamefield[c.x,c.y+ak] = b Or gamefield[c.x,c.y+ak]=fieldjoker
						pop=coord(c.x,c.y+ak)
						ListAddLast fil2,pop
						popfield[pop.x,pop.y]=True
						ListAddLast mustpop,pop
						EndIf
					EndIf
				Next
			Next
		Wend
	count=CountList(mustpop)
	If count<3 Return ' There must be 3 or more of a color otherwisse, get outta here! 
	For ak=1 Until count ' calculate the points
		scorepoints:+ak
		Next
	For c=EachIn mustpop
		Gamefield[c.x,c.y]=0
		If GameTiles[c.x,c.y] GameTiles[c.x,c.y]:-1
		Next
	total = scorepoints * mul
	points:+scorepoints
	levelscore:+total
	cd_bomb:-points; vmin cd_bomb
	?debug
	ConsoleWrite "Popping "+count+" bubbles awarding "+total+" points"
	?
	If total BMessage(total,x,y)		
	End Method
	
	Method vmin(a Var,m=0)
	If a<m a=m
	End Method
		
	
	Method truescore()
	Return Score + LevelScore
	End Method	
	
	Method GetRandomTunes()
	Countrandomtunes = 0
	Local l:TList = New TList
	Local F$
	For F$=EachIn MapKeys(JCR.Entries)
		If ExtractDir(F)="MUSIC/TRUE" 
			ListAddLast L,F
			?Debug
			ConsoleWrite "Added ingame tune: "+F
			?
			EndIf
		Next
	randomtunes = New String[CountList(L)]
	For Local ak=0 Until CountList(L)
		randomtunes[ak] = Replace(String(L.valueatindex(ak)),"MUSIC/","")
		Next
	End Method
	
	Method RandomTune()
	If Not Len(randomtunes) Return
	Local R=Rand(0,Len(randomtunes)-1)
	Music JCR,RandomTunes[r]
	End Method
	
	Method LIX_Load(idx,img$)
	Local i=idx-1000
	If i<0 error "Too low index number ("+idx+")"
	If i>Len(LevelPics) error "Too high index number ("+idx+")"
	LevelPics[i] = LoadImage(JCR_B(JCR,"GFX/Levels/Xtra/"+Img+".png"))
	If Not levelpics[i] error "Xtra pic "+IMG+".png not found!"
	End Method


	Method OnLoad() 
	Tube:TImage = LoadImage(JCR_B(JCR,"GFX/Game/Tube.png"))
	LIX_Load FieldJoker,"Joker Hat"	
	LIX_Load FieldBonus,"Cherry"
	CreateAquarium UIScreen ' Always comes first
	'Game Gadget
	GameGadget = New TUI_Gadget
	GameGadget.Kind = "Game"
	setparent uiscreen,GameGadget
	'End Game Gadget
	'Score & level
	TUI_CreateLabel "Score:",795,5,uiscreen,inputfont,1
	G_ShowScore = TUI_CreateLabel("0",795,25,uiscreen,inputfont,1); G_ShowScore.textenabledcolor(255,180,0)
	TUI_CreateLabel "Level:",795,50,uiscreen,inputfont,1
	G_Level = TUI_CreateLabel("0",795,70,uiscreen,inputfont,1); G_Level.textenabledcolor(255,180,0)
	G_TileLabel = TUI_CreateLabel("Tiles:",795,95,uiscreen,inputfont,1)
	G_Tiles = TUI_CreateLabel("0",795,115,uiscreen,inputfont,1) G_Tiles.textenabledcolor(255,180,0)
	'Flip
	If Not UI_SmallButton UI_SmallButton=LoadImage(JCR_B(JCR,"GFX/UI/SmallButton.png"))
	G_VFLIP    = TUI_CreateButton(   "",650,150,uiscreen,LoadImage(JCR_B(JCR,"GFX/GAME/VFLIP.PNG")))
	G_HFLIP    = TUI_CreateButton(   "",700,150,uiscreen,LoadImage(JCR_B(JCR,"GFX/GAME/HFLIP.PNG")))
	G_ROT_L    = TUI_CreateButton(   "",620,250,uiscreen,LoadImage(JCR_B(JCR,"GFX/GAME/RotateCounterClockwise.png")))
	G_ROT_R    = TUI_CreateButton(   "",730,250,uiscreen,LoadImage(JCR_B(JCR,"GFX/GAME/RotateClockwise.png")))
	Back2Main  = TUI_CreateButton("B2M",690,560,uiscreen,UI_SmallButton)  Back2Main.Font = InputFont
	RestartLvl = TUI_CreateButton("RST",690,510,uiscreen,UI_SmallButton) RestartLvl.Font = InputFont	
	PauseGame  = TUI_CreateButton("PAU",690,460,uiscreen,UI_SmallButton)  PauseGame.Font = InputFont
	Tool_Bomb  = TUI_CreateButton(   "", 10,530,uiscreen,LoadImage(JCR_B(JCR,"GFX/TOOLS/Bomb.png")))
	langtie "Back2Main",Back2Main
	langtie "Pause"    ,PauseGame
	langtie "Restart"  ,RestartLvl
	SupportAziella UIScreen ' This one must ALWAYS be the last gadget
	GetRandomTunes
	BubbleColor[0] = New TCol
	BubbleColor[0].R=255
	BubbleColor[0].L="R"
	BubbleColor[1] = New TCol
	BubbleColor[1].G=255
	BubbleColor[1].L="G"
	BubbleColor[2] = New TCol
	BubbleColor[2].B=255
	BubbleColor[2].L="B"
	BubbleColor[3] = New TCol
	BubbleColor[3].R=255
	BubbleColor[3].G=255
	BubbleColor[3].L="Y"
	BubbleColor[4] = New TCol
	BubbleColor[4].G=255
	BubbleColor[4].B=255
	BubbleColor[4].L="C"
	BubbleColor[5] = New TCol
	BubbleColor[5].R=255
	BubbleColor[5].B=255	
	BubbleColor[5].L="M"
	?debug
	For Local ak=0 Until 5
		ConsoleWrite ak+" >> "+bubblecolor[ak].R+","+bubblecolor[ak].G+","+bubblecolor[ak].B+" >> "+bubblecolor[ak].L
		Next
	?
	End Method
	
	Method RowCheck(rc,hzvt,v)
	Local x
	Local y
	Local dx
	Local dy
	Local ret
	Select hzvt
		Case 0
			x  = rc
			y  = 0
			dx = 0
			dy = 1
		Case 1
			x = 0
			y = rc
			dx = 1
			dy = 0
		Default
			error "INTERNAL ERROR: HZVT error!"			
		End Select
	Repeat
	ret = ret Or gamefield[x,y]=v
	x:+dx
	y:+dy
	Until x>=fieldwidth Or y>=fieldheight
	Return ret
	End Method
	
	Method RowCheckEnable(rc,hzvt,gadget:TUI_Gadget)
	Local f
	Local a = False
	For f = EachIn nomove
		a = a Or rowcheck(rc,hzvt,f)
		Next
	gadget.enabled = Not a	
	End Method
	
	Method bottomrow()
	Local x
	Local y=fieldheight-1
	Local mul = Int(Double((Double(timeleft)/maxtime)*Double(1000)))
	Local total
	For x=0 Until fieldwidth
		Select gamefield[x,y]
			Case Fieldbonus
				gamefield[x,y]=0
				If mul BMessage(mul,x,y)
				levelscore:+mul
			End Select
		Next
	End Method
	
	Method OnCycle() 
	' May we flip or rotate?
	RowCheckEnable            0,0,G_ROT_L
	rowcheckenable            0,1,G_VFLIP
	rowcheckenable fieldwidth-1,0,G_ROT_R
	' Hit da floor?
	bottomrow
	' Doordraaien van de score
	Local ts = truescore()
	Local B:Bmes
	Local ax,ay
	Local lc1$,lc2$,bonus
	If showscore<ts
		If Abs(ts-showscore) > 500 showscore:+Rand(1,(ts-showscore/2000))+1 Else showscore:+1
	ElseIf showscore>ts
		showscore = ts
		EndIf
	G_ShowScore.text=showscore
	G_Level.text=Level
	If timeleft And (Not showaziella) timeleft:-1	
	SetImageFont InputFont
	For B=EachIn BMessages
		SetColor 0,0,0
		For ax=-1 To 1 For ay=-1 To 1 DrawText b.m,b.c.x+ax,b.c.y+ay Next Next
		SetColor Rand(1,255),Rand(1,255),Rand(255)
		DrawText b.m,b.c.x,b.c.y
		b.c.y:-1
		b.timer:-1
		If b.timer<=0 ListRemove Bmessages,b
		Next
	' Show Tools
	Tool_Bomb.Visible = Level >= 10	
	' Cooldown tools
	Tool_Bomb.Enabled = Not CD_Bomb
	' Next level
	If points>=reqpoints And tilecount=0 Then
		bonus = (Double(timeleft)/maxtime)*Double(10000)
		SetImageFont inputfont
		awardtrophy "LEVEL"+Right("00"+Level,3)
		lc1 = "Level Complete!"
		bmessage lc1,400-(TextWidth(lc1)/2),300,1
		If bonus 
			lc2 = "Bonus: "+bonus
			bmessage lc2,400-(TextWidth(lc2)/2),360,1
			EndIf		
		score:+levelscore
		levelscore=0
		score:+bonus
		level:+1
		loadlevel
		EndIf			
	End Method
	
	Method DoHFlip()
	Local ak,al
	Local fw = fieldwidth-1
	For ak=0 Until fieldwidth/2
		For al=0 Until fieldheight
			SwapInt GameField[ak,al],GameField[fw-ak,al]
			SwapInt GMFXY[ak,al,0],GMFXY[Fw-ak,al,0]
			SwapInt GMFXY[ak,al,1],GMFXY[Fw-ak,al,1]
			Next
		Next
	End Method	

	Method DoVFlip()
	Local ak,al
	Local fw = fieldheight-1
	For al=0 Until fieldheight/2
		For ak=0 Until fieldwidth
			SwapInt GameField[ak,al],GameField[ak,fw-al]
			SwapInt GMFXY[ak,al,0],GMFXY[ak,fw-al,0]
			SwapInt GMFXY[ak,al,1],GMFXY[ak,fw-al,1]
			Next
		Next
	End Method	
	
	Method DoRotateL()
	Local tempfield[fieldwidth,fieldheight]
	Local tempgmfxy[fieldwidth,fieldheight,2]
	Local tw = fieldwidth-1
	Local th = fieldheight-1
	Local ax,ay
	For ax=0 Until fieldwidth
		For ay=0 Until fieldheight
			tempfield[ay,tw-ax]   = gamefield[ax,ay]
			tempgmfxy[ay,tw-ax,0] =     gmfxy[ax,ay,0]
			tempgmfxy[ay,tw-ax,1] =     gmfxy[ax,ay,1]
			Next
		Next
	gamefield = tempfield
	gmfxy     = tempgmfxy	
	End Method
	
	Method DoRotateR()
	Local tempfield[fieldwidth,fieldheight]
	Local tempgmfxy[fieldwidth,fieldheight,2]
	Local tw = fieldwidth-1
	Local th = fieldheight-1
	Local ax,ay
	For ax=0 Until fieldwidth
		For ay=0 Until fieldheight
			tempfield[th-ay,ax]   = gamefield[ax,ay]
			tempgmfxy[th-ay,ax,0] =     gmfxy[ax,ay,0]
			tempgmfxy[th-ay,ax,1] =     gmfxy[ax,ay,1]
			Next
		Next
	gamefield = tempfield
	gmfxy     = tempgmfxy	
	End Method
	
	Method OnInput() 
	If back2main.action TOScreen("MainMenu")
	If G_HFLIP.action   DoHFlip
	If G_VFLIP.action   DovFlip
	If G_ROT_L.action   DoRotateL
	If G_ROT_R.action   DoRotateR
	If Tool_bomb.action WhatWeDo = "Bomb"
	End Method
	
	Method OnSwitch() 
	If Not selectedcolors[0] getrandomcolors
	RandomTune
	If level=0 Or (Not Gamefield[0,0])
		level=1
		LoadLevel
		End If
	End Method
	
	
	End Type


Global Game:TGame = New TGame ' This must be inside this var as some other routines must be able to access the game routines.


MKL_Version "GAME","15.02.28"
MKL_Lic     "GAME","GNU"