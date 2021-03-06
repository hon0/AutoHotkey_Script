﻿#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it.
{
	Layer := 1
	CapsLock_pressed := 0
	
	SC029_pressed := 0
	Tab_pressed := 0
	
	XButton2_pressed := 0
	XButton1_pressed := 0
	
	F13_pressed := 0
	
	a_pressed := 0
	e_pressed := 0
	
	r_pressed := 0
	f_pressed := 0
	
	w_pressed := 0
	x_pressed := 0
	c_pressed := 0
	v_pressed := 0
}
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds).
#MaxHotkeysPerInterval 500
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
	^!f:: ; FullScreen Window. Control+Alt+F
	{
		WinGetTitle, currentWindow, A
		IfWinExist %currentWindow%
		{
			WinSet, Style, ^0xC00000 ; toggle title bar
			WinMove, , , 0, 0, 1920, 1080
		}
		return
	}
} ; AutoHotKey Script option.

{ ; Joystick ID (Use JoyID Program)
	;4Joy = T16000L (See JoyID)
	;Joy = Vjoy
}

{ ; Layer modifier. Press and hold to get into Layer 2. Release to come back to Layer 1.
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	{
		If (CapsLock_pressed)
			Return
		CapsLock_pressed := 1
		Layer := 2
		Return
	}
	
	CapsLock Up::
	{
		CapsLock_pressed := 0
		Layer := 1
		Return
	}
}

#IfWinActive Deep Rock Galactic

XButton2::
{
	If GetKeyState("LButton")
	{
		Return
	}
	Else
	{
		Send {XButton2 Down}
		KeyWait, XButton2
		Send {XButton2 Up}
		Return
	}
	Return
}

$XButton2::
{
	If (XButton2_pressed)
		Return
	XButton2_pressed := 1
	If GetKeyState("LButton")
	{
		Return
	}
	If WinActive("Discord")
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
		}
	}
	Else
	{
		Send {XButton2 Down}
	}
	Return
}

$XButton2 Up::
{
	XButton2_pressed := 0
	SendInput {XButton2 Up}
	Return
}

*WheelUp::
{
	If (Layer=1)
	{
		If GetKeyState("Tab")
		{
			Send {WheelUp}
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
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {WheelUp}
		Return
	}
	/*
		Else if (Layer=3)
		{
			SetkeyDelay, 0, 32
			Send {Right}
			Return
		}
	*/
	/*
		Else
		{
			Send {WheelUp}
			Return
		}
	*/
	Return
}

*WheelDown::
{
	If (Layer=1)
	{
		If GetKeyState("Tab")
		{
			Send {WheelDown}
			Return
		}
		Else
		{
			SetkeyDelay, 0, 32
			Send {SC004}
			Sleep 100
			Return
		}
	}
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {WheelDown}
		Return
	}
	/*
		Else if (Layer=3)
		{
			SetkeyDelay, 0, 32
			Send {Left}
			Return
		}
	*/
	/*
		Else
		{
			Send {WheelDown}
			Return
		}
	*/
	Return
}

#IfWinActive

$XButton2::
{
	If (XButton2_pressed)
		Return
	XButton2_pressed := 1
	If WinActive("Discord")
	{
		KeyWait XButton2, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Up}{LShift Up}{LAlt Up}
		}
	}
	Else
	{
		Send {XButton2 Down}
	}
	Return
}

$XButton2 Up::
{
	XButton2_pressed := 0
	SendInput {XButton2 Up}
	Return
}

$XButton1::
{
	If (XButton1_pressed)
		Return
	XButton1_pressed := 1
	If WinActive("Discord")
	{
		KeyWait XButton1, t0.100
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SetKeyDelay 10, 32
			Send, {LShift Down}{LAlt Down}{Down}{LShift Up}{LAlt Up}
		}
	}
	Else
	{
		Send {XButton1 Down}
	}
	Return
}

$XButton1 Up::
{
	XButton1_pressed := 0
	SendInput {XButton1 Up}
	Return
}

$F13::
{
	If (F13_pressed)
		Return
	F13_pressed := 1
	If WinActive("Discord")
	{
		KeyWait F13, t0.200
		t:= A_TimeSinceThisHotkey
		If ErrorLevel
		{
			SendInput {LControl Down}{LAlt Down}{Right}{LAlt Up}{LControl Up}
		}
		Else
		{
			SendInput {LControl Down}{k}{LControl Up}
			;Sleep 32		
			Send {Enter}
		}
	}
	Else
	{
		SendInput {F13 Down}
	}
	Return
}

$F13 Up::
{
	F13_pressed := 0
	SendInput {F13 Up}
	Return
}

$SC029::
{
	If (SC029_pressed)
		Return
	SC029_pressed := 1
	If (Layer=1)
	{
		SendInput { Down}
	}
	If (Layer=2)
	{
		SendInput {SC029 Down}
	}
	Return
}

$SC029 Up::
{
	SC029_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("SC029"))
		{
			SendInput {SC029 Up}
		}
		Else
			SendInput {esc Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("esc"))
		{
			SendInput {esc Up}
		}
		Else
			SendInput {SC029 Up}
	}
	Return
}

$Tab::
{
	If (Tab_pressed)
		Return
	Tab_pressed := 1
	If (Layer=1)
	{
		SendInput {Tab Down}
	}
	If (Layer=2)
	{
		SendInput {esc Down}
	}
	Return
}

$Tab Up::
{
	Tab_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("esc"))
		{
			SendInput {esc Up}
		}
		Else
			SendInput {Tab Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("Tab"))
		{
			SendInput {Tab Up}
		}
		Else
			SendInput {esc Up}
	}
	Return
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


$w::
{
	If (w_pressed)
		Return
	w_pressed := 1
	If (Layer=1)
	{
		SendInput {w Down}
	}
	If (Layer=2)
	{
		SendInput {b Down}
	}
	Return
}

$w Up::
{
	w_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("b"))
		{
			SendInput {b Up}
		}
		Else
			SendInput {w Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("w"))
		{
			SendInput {w Up}
		}
		Else
			SendInput {b Up}
	}
	Return
}

$x::
{
	If (x_pressed)
		Return
	x_pressed := 1
	If (Layer=1)
	{
		SendInput {x Down}
	}
	If (Layer=2)
	{
		SendInput {n Down}
	}
	Return
}

$x Up::
{
	x_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState("n"))
		{
			SendInput {n Up}
		}
		Else
			SendInput {x Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("x"))
		{
			SendInput {x Up}
		}
		Else
			SendInput {n Up}
	}
	Return
}

$c::
{
	If (c_pressed)
		Return
	c_pressed := 1
	If (Layer=1)
	{
		SendInput {c Down}
	}
	If (Layer=2)
	{
		SendInput {, Down}
	}
	Return
}

$c Up::
{
	c_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState(","))
		{
			SendInput {, Up}
		}
		Else
			SendInput {c Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("c"))
		{
			SendInput {c Up}
		}
		Else
			SendInput {, Up}
	}
	Return
}

$v::
{
	If (v_pressed)
		Return
	v_pressed := 1
	If (Layer=1)
	{
		SendInput {v Down}
	}
	If (Layer=2)
	{
		SendInput {; Down}
	}
	Return
}

$v Up::
{
	v_pressed := 0
	If (Layer=1)
	{
		If (GetKeyState(";"))
		{
			SendInput {; Up}
		}
		Else
			SendInput {v Up}
	}
	If (Layer=2)
	{
		If (GetKeyState("v"))
		{
			SendInput {v Up}
		}
		Else
			SendInput {; Up}
	}
	Return
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
