﻿#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
;#Warn  ; Enable warnings to assist with detecting common errors.
Layer := 1
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
;#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ; Monitoring Windows
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
	{
		WinClose Event Tester
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
		WinWait, Event Tester
		SetKeyDelay 0, 32
		Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
		Sleep 32
		MouseClick, left, 1952, 71
		MouseClick, left, 2016, 96
		BlockInput, Off	
		return
	}
	#IfWinExist
}

{ ; AutoHotKey Script option.
	#F2::Suspend, Toggle
	#F4::ExitApp
	;^SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
	/*^!f:: ; FullScreen Window. Control+Alt+F
		{
			WinGetTitle, currentWindow, A
			IfWinExist %currentWindow%
			{
				WinSet, Style, ^0xC00000 ; toggle title bar
				WinMove, , , 0, 0, 1920, 1080
			}
			return
		}
	*/
} ; AutoHotKey Script option.

{ ; Testing
	
	/* ; If prior key ""
		$m::
		If (A_PriorKey = "space")
		{
			SendInput {p Down}
			KeyWait m
			Send {p Up}
		}
		Else
		{
			Send {m Down}
			KeyWait m
			Send {m Up}
		}
		return
		
	*/
	
	/* ; Pixel color as as condition
		{
			!#z::
			MouseGetPos, xpos, ypos 	
		;PixelGetColor, color, xpos, xpos
			PixelGetColor, color, 1889, 95
		;MsgBox The color at X%xpos% Y%ypos% is %color%.
			MsgBox The color is %color%.
			return
			
			{ ; Numpad1
				Numpad1::
				PixelGetColor, color, 1889, 95
				if color = 0x213A70
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					MouseClick, left, 1732, 171
					MouseMove, xpos, ypos 
					BlockInput, Off
					return
				}
				Else
				{
					MouseGetPos, xpos, ypos 
					BlockInput, On
					SetKeyDelay 32, 32
					Send {NumpadEnter}
					MouseClick, left, 1732, 171
					MouseMove, xpos, ypos 
					BlockInput, Off
				}
				Return
			}
		}
	*/
	
	/* ; On press != on double press != on long press.
		$a::
		KeyWait, a, T0.1
		If (ErrorLevel)
		{
			Send {b down}
			KeyWait a
			Send {b up}
		}
		Else 
		{
			KeyWait, a, D T0.1
			If (ErrorLevel)
			{
				Send {a down}
				KeyWait a
				Send {a up}
			}
			Else
			{
				Send {c down}
				KeyWait a
				Send {c up}
			}
		}
		KeyWait, a
		Return
	*/
	
	/* ; Multi-Tap
		
		{ 
			$f1::
			{
				count++
				settimer, actions, 333
			}
			return
			
			actions:
			{
				if (count = 1)
				{
					send {F1}
				}
				else if (count = 2)
				{
					send {F2}
				}
				else if (count = 3)
				{
					send {F3}
				}
				count := 0
			}
			return
		}
	*/
	
	/* ; Watch axis
		
		SetTimer, WatchAxis, 5
		return
		
		WatchAxis:
		GetKeyState, 6JoyX, 6JoyX  ; Get position of X axis.
		GetKeyState, 6JoyY, 6JoyY  ; Get position of Y axis.
		KeyToHoldDownPrev = %KeyToHoldDown%  ; Prev now holds the key that was down before (if any).
		
		if 6JoyX > 70
			KeyToHoldDown = Right
		else if 6JoyX < 30
			KeyToHoldDown = Left
		else if 6JoyY > 70
			KeyToHoldDown = Down
		else if 6JoyY < 30
			KeyToHoldDown = Up
		else
			KeyToHoldDown =
		
		if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
			return  ; Do nothing.
		
	; Otherwise, release the previous key and press down the new key:
		SetKeyDelay -1  ; Avoid delays between keystrokes.
		if KeyToHoldDownPrev   ; There is a previous key to release.
			Send, {%KeyToHoldDownPrev% up}  ; Release it.
		if KeyToHoldDown   ; There is a key to press down.
			Send, {%KeyToHoldDown% down}  ; Press it down.
		return
	*/	
	
	/* ; Joystick layer, shift
		
		6Joy1::
		If GetKeyState("6Joy2", "P")=1
		{
			send {d Down}
			keywait 6Joy1
			send, {d Up}
		}
		else 
			if GetKeyState("6joy3", "p")=1
			{
				send {v Down}
				keywait 6Joy1
				send, {v Up}
			}
		Else 
		{
			send {c Down}
			keywait 6Joy1
			send, {c Up}
		}
		Return
	*/	
	
	/* ; Multi-Tap
		$f8::
		{
			count++
			settimer, actionsF8, 200
		}
		return
		
		actionsF8:
		{
			if (count = 1)
			{
				send {F8}
			}
			else if (count = 2)
			{
				send {F9}
			}
			else if (count = 3)
			{
				send {F10}
			}
			count := 0
		}
		return
		}
	*/	
	
}

{ ; Layer checker
	/*
		#z::
		ToolTip %Layer%
		SetTimer, RemoveToolTip, 2000
		return
		
		RemoveToolTip:
		SetTimer, RemoveToolTip, Off
		ToolTip
		return
	*/
}

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1.
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	;if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 333)
	;	Layer := 3
	KeyWait, CapsLock
	Layer := 1
	Return
}

#IfWinActive Deep Rock Galactic
	
*WheelUp::
{
	If GetKeyState("Tab")
	{
		WheelUp
		Return
	}
	Else
	{
		SetkeyDelay, 0, 32
		Send {SC002}
		Sleep 100
		Return
	}
	
}

*WheelDown::
{
	SetkeyDelay, 0, 32
	Send {SC004}
	Sleep 100
	Return
	
}

#IfWinActive
	
$SC029::
{
	If (Layer=2)
	{
		Send {SC029 Down}
		KeyWait, SC029
		Send {SC029 Up}
	}
	Else
	{
		Send {esc Down}
		KeyWait, SC029
		Send {esc Up}
	}
	Return
}

$Tab::
{
	If (Layer=1)
	{
		Send {Tab Down}
		KeyWait, Tab
		Send {Tab Up}
	}
	Else If (Layer=2)
	{
		Send {esc Down}
		KeyWait, Tab
		Send {esc Up}
	}
	Else
	{
		Send {Tab Down}
		KeyWait, Tab
		Send {Tab Up}
	}
	Return
}

$w::
{
	If (Layer=1)
	{
		Send {w Down}
		KeyWait, w
		Send {w Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {b Down}
		KeyWait, w
		Send {b Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad1 Down}
		KeyWait, w
		Send {Numpad1 Up}
		Return
	}
}

$x::
{
	If (Layer=1)
	{
		Send {x Down}
		KeyWait, x
		Send {x Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {n Down}
		KeyWait, x
		Send {n Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad2 Down}
		KeyWait, x
		Send {Numpad2 Up}
		Return
	}
}

$c::
{
	If (Layer=1)
	{
		Send {c Down}
		KeyWait, c
		Send {c Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {, Down}
		KeyWait, c
		Send {, Up}
		Return
	}
	Else if (Layer=3)
	{
		Send {Numpad3 Down}
		KeyWait, c
		Send {Numpad3 Up}
		Return
	}
}

$r::
{
	If (Layer=1)
	{
		Send {r Down}
		KeyWait, r
		Send {r Up}
		Return
	}
	Else If (Layer=2)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {y down}
			Sleep 32
			SendInput {y up}
			KeyWait, r
		}
		else
		{
			SendInput {t down}
			sleep 32
			SendInput {t up}
			KeyWait, r
		}
		return
	}
	Else if (Layer=3)
	{
		KeyWait r, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {i down}
			sleep 32
			SendInput {i up}
			KeyWait, r
		}
		else
		{
			SendInput {u down}
			sleep 32
			SendInput {u up}
			KeyWait, r			
		}
		return
	}
	Else
	{
		Send {r Down}
		KeyWait, r
		Send {r Up}
		Return
	}
	Return
}

$f::
{
	If (Layer=1)
	{
		Send {f Down}
		KeyWait, f
		Send {f Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {g Down}
		KeyWait, f
		Send {g Up}
		Return
	}
	Return
}

$v::
{
	If (Layer=1)
	{
		Send {v Down}
		KeyWait, v
		Send {v Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {; Down}
		KeyWait, v
		Send {; Up}
		Return
	}
}

$a::
{
	If (Layer=1)
	{
		Send {a Down}
		KeyWait, a
		Send {a Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {F5 Down}
		KeyWait, a
		Send {F5 Up}
		Return
	}
	Return
}

$e::
{
	If (Layer=1)
	{
		Send {e Down}
		KeyWait, e
		Send {e Up}
		Return
	}
	Else If (Layer=2)
	{
		Send {F8 Down}
		KeyWait, e
		Send {F8 Up}
		Return
	}
	Return
}

$XButton2::
{
	If (Layer=1) and WinActive("Discord")
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
			KeyWait, XButton2
		}
	}
	Else
	{
		Send {XButton2 Down}
		KeyWait XButton2
		Send {XButton2 Up}
	}
	Return
}

$F13::
{
	If (Layer=1) and WinActive("Discord")
	{
		KeyWait F13, t0.333
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			;SetKeyDelay 10, 32
			SendInput, {LControl Down}{LAlt Down}{Right}{LAlt Up}{LControl Up}
			KeyWait, F13
		}
		Else
		{
			;SetKeyDelay 10, 32
			SendInput, {LControl Down}{k}{LControl Up}
			Sleep 5		
			Send {Enter}
			KeyWait, F13
		}
	}
	Else If (Layer=1) and WinActive("Deep Rock Galactic")
	{
		Send {g Down}
		KeyWait F13
		Send {g Up}
	}
	Else
	{
		Send {F13 Down}
		KeyWait F13
		Send {F13 Up}
	}
	Return
}

F13 UP::
Send {F13 Up}{g Up}
Return

$XButton1::
{
	If (Layer=1) and WinActive("Discord")
	{
		KeyWait XButton1, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Down}{LShift Up}{LAlt Up}
			KeyWait, XButton1
		}
	}
	Else
	{
		Send {XButton1 Down}
		KeyWait XButton1
		Send {XButton1 Up}
	}
	Return
}