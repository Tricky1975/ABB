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
Strict
Import "Basis.bmx"

Type TUI_GDrvAziella Extends TUI_Gadgetdriver

	Method Run(G:TUI_Gadget,Enabled)
		Local th,bh,y,trw
		SetColor 255,255,255
		NextButton(G).Visible = ShowAziella And AziellaX=0
		For Local GK:TUI_Gadget = EachIn G.Parent.Children
			If GK<>G GK.Enabled = Not ShowAziella
			Next
		DrawImage AziellaPic,AziellaX,0
		ShowAziella = AziellaTextindex < Len(aziellatext)
		If Not ShowAziella
			If AziellaX>-ImageWidth(AziellaPic) AziellaX:-2
		Else
			If AziellaX<0 AziellaX:+2		
			If AziellaX>0 AziellaX=0
			If AziellaX<0 Return		
			SetImageFont AziellaFont
			th = TextHeight("TEST")
			bh = (th*CountList(aziellatext[AziellaTextindex]))+20
			SetAlpha .5
			SetColor 0,0,0
			DrawRect 10,590-bh,780,bh
			SetColor 255,255,255
			SetAlpha 1
			 y=(595-bh)
			For Local T$=EachIn AziellaText[AziellaTextIndex]
				DrawText VarStr(T),15,y
				y:+TextHeight(T)
				Next
			EndIf
		y = 5
		SetImageFont inputfont
		For Local ja:tjustachieved = EachIn justachieved
			trw=200
			If TextWidth(TrophyNames.Value(ja.id))>trw-20 trw = TextWidth(TrophyNames.Value(ja.id))+20
			SetAlpha .5
			SetColor 0,0,0
			DrawRect 5,y,trw,60
			SetAlpha 1	
			SetColor 255,180,0
			DrawText "Trophy earned:",10,y+3
			SetColor 255,255,180
			DrawText TrophyNames.Value(ja.id),10,y+3+25
			y:+65
			ja.timer:-1
			If ja.timer<=0 ListRemove justachieved,ja
			Next
		End Method

End Type

regtuidriver "Aziella",New TUI_GDrvAziella

Type Aziella_Callback_Next Extends TUI_CallBack

	Method CallFunc(Source:TUI_Gadget,x=0,y=0,Extra:Object=Null)
	AziellaTextIndex:+1
	End Method
	
	End Type


Global NextButtons:TMap = New TMap
Global ShowAziella = False
Global ImgNextButton:TImage
Global AziellaX = -1000
Global AziellaPic:TImage
Global AziellaText:TList[]
Global AziellaTextIndex
Global AziellaFont:TImageFOnt

Function NextButton:TUI_Gadget(G:TUI_Gadget)
Return TUI_Gadget(MapValueForKey(Nextbuttons,G))
End Function

Function LoadAziellaPics()
If Not imgnextbutton imgnextbutton=LoadImage(JCR_B(JCR,"GFX/UI/Next.png"))
If Not imgnextbutton error "Next button not properly loaded"
If Not aziellapic aziellapic = LoadImage(JCR_B(JCR,"GFX/General/Aziella.png")); aziellax=-ImageWidth(aziellapic)
If Not aziellapic error "Aziella picture not properly loaded"
If Not AziellaFont AziellaFont = LoadImageFont(JCR_E(JCR,FONT_AZIALLASPEAKS),18); JCR_E_Clear
End Function

Function SupportAziella:TUI_Gadget(Parent:TUI_Gadget)
Local ret:TUI_Gadget = New TUI_Gadget
ret.kind = "Aziella"
setparent parent,ret
loadAziellaPics
MapInsert nextbuttons,ret,TUI_CreateButton("",790-ImageWidth(Imgnextbutton),580-ImageHeight(Imgnextbutton),ret,imgnextbutton,imgnextbutton)
nextbutton(ret).TB_Action = New Aziella_callback_next
nextbutton(ret).altkey = KEY_ENTER
Return ret
End Function

Function AziellaSpeak(File$)
Local BT:TStream = JCR_ReadFile(JCR,"LANGUAGE/"+ChosenLanguage+"/Speak/"+File)
Local L$
Local CL:TList
Local BigList:TList = New TList
If Not BT Error "Language file ~q"+File+"~q not found!"
While Not Eof(BT)
	L = Trim(ReadLine(BT))
	If L="TEXT:"
		CL = New TList
		ListAddLast biglist,CL
	ElseIf L="END"
		CL = Null
	ElseIf CL
		ListAddLast CL,L
		EndIf
	Wend	
CloseFile BT
AziellaText = TList[](ListToArray(BigList))
AziellaTextIndex = 0
ShowAziella = True
End Function
