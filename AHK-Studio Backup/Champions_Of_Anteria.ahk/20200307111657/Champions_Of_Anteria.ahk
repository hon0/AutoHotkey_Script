﻿#SingleInstance force
#Persistent 
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
;#InstallKeybdHook
;#InstallMouseHook
CoordMode, mouse, Screen

{ ; Monitoring Windows
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 10, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
	{
		WinClose Event Tester
		
		Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
		WinWait, Event Tester
		SetKeyDelay 10, 32
		Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
		Sleep 100
		MouseClick, left, 1950, 70
		MouseClick, left, 2016, 95
		BlockInput, Off	
		return
	}
	#IfWinExist
}

{ ; AutoHotKey Script option.
	#F3::Suspend, Toggle
	#F4::ExitApp
	;^SPACE::  Winset, Alwaysontop, , A ; Toggle Active Windows Always on Top.	
	
	/* ; Lock mouse to Window. LControl+LAlt+A. LControl+LAlt+S.
		{ ; Lock mouse to Window. LControl+LAlt+A. LControl+LAlt+S.
			^!a::
			LockMouseToWindow("Settlers 7 Window")
			Return
			
			^!s::
			LockMouseToWindow()
			Return
			
			
			LockMouseToWindow(llwindowname="")
			{
				VarSetCapacity(llrectA, 16)
				WinGetPos, llX, llY, llWidth, llHeight, %llwindowname%
				If (!llWidth AND !llHeight) {
					DllCall("ClipCursor")
					Return, False
				}
				Loop, 4 { 
					DllCall("RtlFillMemory", UInt,&llrectA+0+A_Index-1, UInt,1, UChar,llX >> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+4+A_Index-1, UInt,1, UChar,llY >> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+8+A_Index-1, UInt,1, UChar,(llWidth + llX)>> 8*A_Index-8) 
					DllCall("RtlFillMemory", UInt,&llrectA+12+A_Index-1, UInt,1, UChar,(llHeight + llY) >> 8*A_Index-8) 
				} 
				DllCall("ClipCursor", "UInt", &llrectA)
				Return, True
			}
		}
	*/
	
	{ ; FullScreen Window.	
		^!f::
		WinGetTitle, currentWindow, A
		IfWinExist %currentWindow%
		{
			WinSet, Style, ^0xC00000 ; toggle title bar
			WinMove, , , 0, 0, 1920, 1080
		}
		return
	}
} ; End of AutoHotKey Script option.

{ ;Testing	
	/*; Pixel color as as condition
		{ ; Pixel color as as condition
			!#z::	
			PixelGetColor, color, 1889, 95
			MsgBox The color at X1889 Y95 is %color%.
			Clipboard = %color%
			return
			
			{ ; Numpad1
				Numpad9::
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

Down::
{
	SetkeyDelay 32
	Loop
	{
		Send {Down}
		Sleep 32	
		If (GetKeyState("Down","P")=0)
			Break
	}
	Return
}

LAlt::
{
	Send {Space}
	KeyWait, LAlt
	Send {Space}
	Return
}

XButton2::
{
	If (Layer=1) ;and WinActive(Champions of Anteria)
	{
		/*
			KeyWait XButton2, t0.100
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				Send {r Down}
				KeyWait, XButton2
				Send {r Up}
			}
			else
		*/
		/*
			{
				Send {F3 Down}
				Sleep 32
				Send {F3 Up}
			}
		*/
		Return
	}
}

XButton1::
{
	If (Layer=1) ;and WinActive(Settlers 7 Window)
	{
		/*
			KeyWait XButton1, t0.100
			t:= A_TimeSinceThisHotkey
			If ErrorLevel
			{
				Send {f Down}
				KeyWait, XButton2
				Send {f Up}
			}
			else
		*/
		/*
			{
				Send {t Down}
				KeyWait, XButton1
				Send {t Up}
			}
		*/
		Return
	}
}

WheelUp::
{
	If (Layer=1) and GetKeyState("MButton")
	{
		SetkeyDelay, 0, 32
		Send {Home}
		Return
	}
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {PgUp}
		Return
	}
	Else
	{
		Send {WheelUp}
		Return
	}
}

WheelDown::
{
	If (Layer=1) and GetKeyState("MButton")
	{
		SetkeyDelay, 0, 32
		Send {End}
		Return
	}
	Else if (Layer=2)
	{
		SetkeyDelay, 0, 32
		Send {PgDn}
		Return
	}
	Else
	{
		Send {WheelDown}
		Return
	}
}

$a::
{
	If (Layer=2)
	{
		Send {& Down}
		KeyWait, a
		Send {& Up}
	}
	Else
	{
		Send {a Down}
		KeyWait, a
		Send {a Up}
	}
	Return
}

$SC029::
{
	If (Layer=2)
	{
		Send {esc Down}
		KeyWait, SC029
		Send {esc Up}
	}
	Else
	{
		Send {SC029 Down}
		KeyWait, SC029
		Send {SC029 Up}
	}
	Return
}

$e::
{
	If (Layer=2)
	{
		Send {SC004 Down}
		KeyWait, e
		Send {SC004 Up}
	}
	Else
	{
		Send {e Down}
		KeyWait, e
		Send {e Up}
	}
	Return
}

$z::
{
	If (Layer=2)
	{
		Send {é Down}
		KeyWait, z
		Send {é Up}
	}
	Else
	{
		Send {z Down}
		KeyWait, z
		Send {z Up}
	}
	Return
}

$Tab::
{
	If (Layer=2)
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