Rem
/*
	Aquarium - Aziella's Babling Bubbles
	
	
	
	
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
Import tricky_units.watereffect
Import "Basis.bmx"

Type TUI_GDrvAquarium Extends TUI_Gadgetdriver

	Method Run(G:TUI_Gadget,Enabled)
		Local F:TFish,w:TWeed
		'Print "Aquarun!"
		Cls
		SetColor 0,0,60
		DrawRect 0,0,800,600
		' Generate new fish
		If Rand(1,500)=1
			F = New TFish
			Select Rand(1,2)
				Case 1
					F.Spd=Rand(-5,-1)
					F.X = 1000
					F.scale = 1
				Case 2
					F.Spd = Rand(1,5)
					F.X=-1000
					F.Scale=-1
				End Select
			F.Y = Rand(50,500)				
			f.image = TImage(fishpics.valueatindex(Rand(0,CountList(fishpics)-1)))
			ListAddLast fish,f
			EndIf
		' Show all the fishes and let them swim
		SetColor 255,255,255
		For f=EachIn fish
			SetScale F.scale,1
			DrawImage f.image,f.x,f.y
			f.x:+f.spd
			If f.x>1000 Or f.x<-1000 ListRemove fish,f
			Next
		' Show all weed
		For w = EachIn weed
			watereffect w.img,w.x,w.y,1,50,1,.25
			Next	
		SetScale 1,1
		End Method

End Type

regtuidriver "Aquarium",New TUI_GDrvAquarium


Type TWeed
	Field Img:TImage
	Field X,Y
	End Type

Type TFish
	Field X,Y
	Field Spd
	Field scale
	Field Image:TImage
	End Type

Global Fish:TList = New TList
Global FishPics:TList 
Global Weed:TList = New TList

Function CreateAquarium:TUI_Gadget(Parent:TUI_Gadget)
Local ret:TUI_Gadget = New TUI_Gadget
'Local WeedPics:TList
Local Pix:TPixmap,Img:TImage,W:TWeed
Local ak
ret.kind = "Aquarium"
setparent parent,ret
' Load the fish pics and sea weed if they were not loaded before.
If Not FishPics
	SeedRnd MilliSecs()
	fishpics = New TList
	For Local fishfile$=EachIn MapKeys(JCR.Entries)
		' Load all fishes
		If ExtractDir(FishFile)="GFX/AQUARIUM/FISH" And ExtractExt(FishFile)="PNG" 
			ListAddLast FishPics,LoadImage(JCR_B(JCR,FishFIle))
			ConsoleWrite "Loaded fish: "+StripAll(fishfile)
			EndIf
		' All fishes have their hotspot in the center	
		For Local myfish:TImage=EachIn FishPics
			HotCenter myfish
			Next
		' Load all weed	
		If ExtractDir(fishfile)="GFX/AQUARIUM/SEAWEED" And ExtractExt(FishFile)="PNG" 
			Pix = LoadPixmap(JCR_B(JCR,FishFile))
			Img = LoadAnimImage(pix,PixmapWidth(pix),1,0,PixmapHeight(pix))
			ConsoleWrite "Loaded Seaweed: "+FishFile
			HotCenter img
			For ak=1 To Rand(1,3)
				W = New TWeed
				W.X = Rand(0,800)
				W.Y = 600-PixmapHeight(pix)
				w.Img = Img
				ListAddLast weed,w
				Next
			EndIf
		Next
	EndIf	
End Function




MKL_Version "Aziella's Babling Bubbles - imp/Aquarium.bmx","15.02.24"
MKL_Lic     "Aziella's Babling Bubbles - imp/Aquarium.bmx","GNU - General Public License ver3"
