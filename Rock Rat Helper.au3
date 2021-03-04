#include <WinAPIGdiDC.au3>
HotKeySet("{f4}", "Terminate")
HotKeySet("{f3}", "Pause")


$handle = WinGetHandle("Diablo III")
#Mages :: PUT ON LMB
$x = 1382
$y = 923
$x2 = 140
$y2 = 65
#LOTD :: PUT ON 2
$x3 = 723
$y3 = 1002
#Bone Armor :: PUT ON 3
$x4 = 790
$y4 = 1008
#Simulacrum :: PUT ON 4
$x5 = 885
$y5 = 1004
$iterations = 0
While 1
	WinActivate("Diablo III")
	$iterations += 1
	$pixColor = Memgetpxl($x, $y, $handle)
	$pixMageCount = Memgetpxl($x2,$y2,$handle)
	$lotdCooldown = Memgetpxl($x3, $y3, $handle)
	$boneArmorCooldown = Memgetpxl($x4, $y4, $handle)
	$simuDeActive = Memgetpxl($x5, $y5, $handle)
	If ($simuDeActive = "002E2E26") Then
		Send(4)
	EndIf
	If ($boneArmorCooldown = "00DEF6F1") Then
		Send(3)
	EndIf
	If ($lotdCooldown = "006B6952") Then
		Send(2)
	EndIf
	#ConsoleWrite($pixMageCount & @LF)
	Global $arr[134] = ["00019333","00182C30","00182D2F","00182D30","00182D31","00182D32","00182E30","00182E31","00182E32","00182E33","00182E34","00182F31","00182F32","00182F33","00182F34","00182F35","00183032","00183033","00183034","00183035","00183134","00183135","00183136","00183234","00183235","00183236","00183335","00183336","00183337","00183437","00183439","00183537","00183538","00183539","00183639","0018363A","0018383A","0018393B","0018393C","00183A3C","00183A3D","00183B3E","00193034","00193035","00193134","00193135","00193136","00193137","00193234","00193235","00193236","00193237","00193238","00193335","00193336","00193337","00193338","00193339","00193435","00193436","00193437","00193438","00193439","00193535","00193536","00193537","00193538","00193539","0019353A","0019353B","00193638","00193639","0019363A","0019363B","00193739","0019373A","0019373B","00193839","0019383B","0019383C","0019383D","0019393C","00193A3E","00193B3D","00193C3E","00193C40","00193D3F","00193D42","00193E40","00193E41","00193F41","001A3539","001A353A","001A353B","001A3639","001A363A","001A363B","001A363C","001A373A","001A373B","001A373C","001A383B","001A383C","001A383D","001A383E","001A393C","001A393D","001A393E","001A393E","0019383B","001A3A3B","001A3A3C","001A3A3D","001A3A3E","001A3A3F","001A3B3F","001A3B40","001A3C3E","001A3C3F","001A3C40","001A3C41","001A3D40","001A3D42","001A3E41","001A3E42","001A3F41","001A3F42","001A3F43","001A4043","001A4245","001A4347","001A4446","001A4447","001A4448"]
	For $i = 0 To 133 Step 1
		#ConsoleWrite($arr[$i] & @LF)
		if ($pixColor = $arr[$i] And Not ($pixMageCount = "0000FF00")) Then
			WinActivate("Diablo III")
			send("{SPACE Down}")
			MouseClick("left")
			send("{SPACE Up}")
			ConsoleWrite("Finished" & @LF)
			$iterations = 0
			ExitLoop
		EndIf
	Next
	ConsoleWrite($iterations & @LF)
	Sleep(50)
WEnd
#comments-start
	if ($pixColor = "00193336" Or $pixColor = "00182F32" Or $pixCOlor = "001A3539" Or $pixColor = "0019363B" Or $pixColor = "00193F42") Then
		WinActivate("Diablo III")
		Send(1)
		ConsoleWrite("Finished" & @LF)
		ExitLoop
	EndIf
#comments-end


Func Memgetpxl($x, $y, $handle)
   Local $hDC
   Local $iColor
   Local $sColor

   $hDC = _WinAPI_GetWindowDC($handle)
   $iColor = DllCall("gdi32.dll", "int", "GetPixel", "int", $hDC, "int", $x, "int", $y)
   $sColor = Hex($iColor[0], 6)
   _WinAPI_ReleaseDC($handle, $hDC)

   Return Hex("0x" & StringRight($sColor, 2) & StringMid($sColor, 3, 2) & StringLeft($sColor, 2))
EndFunc

Func Pause()
    If MsgBox(1,'Paused', 'Press ok to resume, or cancel to exit') = 2 Then Exit
EndFunc   ;==>_Pause

Func Terminate()
    Exit
EndFunc   ;==>Terminate