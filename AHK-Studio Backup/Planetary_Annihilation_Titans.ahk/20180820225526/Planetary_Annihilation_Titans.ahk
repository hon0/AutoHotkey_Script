#SingleInstance force
#Persistent  ; Keep this script running until the user explicitly exits it
;#Warn  ; Enable warnings to assist with detecting common errors
Layer := 1 ; Layer initialization.
InChat := 0 ; If InChat = 1 then keyboard operate normally
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff
Process, Priority, , A
SetTitleMatchMode, 2
;#HotkeyInterval 2000  ; This is  the default value (milliseconds)
;#MaxHotkeysPerInterval 500
;#InstallKeybdHook
;#InstallMouseHook
;CoordMode, mouse, Screen

{ ; Monitoring Windows
	BlockInput, On
	KeyHistory
	WinGetActiveTitle, Title
	WinWait, %Title%
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Right}{Right}{Lwin up}{LControl down}{k}{LControl Up}
	
	#IfWinExist Event Tester
		WinClose Event Tester
	
	Run, C:\Program Files (x86)\Thrustmaster\TARGET\Tools\EventTester.exe
	WinWait, Event Tester
	SetKeyDelay 0, 32
	Send {Lwin down}{Right}{Right}{Lwin up}{esc}{esc}{esc}{esc}
	MouseClick, left, 36, 40
	MouseClick, left, 104, 62
	BlockInput, Off	
	return
	#IfWinExist
}

{ ; AutoHotKey Script option
	#F1::Suspend, Toggle
	#F4::ExitApp
} ; AutoHotKey Script option

{ ; Testing
	
	/* ; If prior key ""
		{ ; If prior key ""
			m::
			Send o
			if (A_PriorKey = "space")
				SendInput {p}
			return
		}
		
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
		
		if (ErrorLevel)
		{
			Send {b down}
			keywait a
			Send {b up}
		}
		else {
			KeyWait, a, D T0.1
			
			if (ErrorLevel)
			{
				Send {a down}
				keywait a
				Send {a up}
			}
			
			else
			{
				Send {c down}
				keywait a
				Send {c up}
			}
			
		}
		
		KeyWait, a
		return
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
}

{ ; Layer modifier. Press and hold to get into Layer 2, double press and hold to get into Layer 3. Release to come back to Layer 1
	CapsLock:: ;Key disabled by "SetCapsLockState, AlwaysOff".
	Layer := 2
	if (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey < 200)
		Layer := 3
	KeyWait, CapsLock
	Layer := 1
	keyEnter = 0
	Return
}

XButton1:: ; XButton1, Fire mode selector
{
	KeyWait, XButton1, T0.2
	
	if (ErrorLevel)
	{
		Send {RAlt Down}{F11}{RAlt Up}
	}
	else {
		KeyWait, XButton1, D T0.2
		
		if (ErrorLevel)
		{
			Send {RAlt Down}{F9}{RAlt Up}
		}
		
		else
		{
			Send {RAlt Down}{F10}{RAlt Up}
		}
		
	}
	KeyWait, XButton1
	return
}

XButton2:: ; XButton2, Move mode selector
{
	KeyWait, XButton2, T0.2
	
	if (ErrorLevel)
	{
		Send {LControl Down}{F11}{LControl Up}
	}
	else {
		KeyWait, XButton2, D T0.2
		
		if (ErrorLevel)
		{
			Send {LControl Down}{F9}{LControl Up}
		}
		
		else
		{
			Send {LControl Down}{F10}{LControl Up}
		}
		
	}
	
	KeyWait, XButton2
	return
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
		Send {PgDn}
		Return
	}
	Else
	{
		Send {WheelUp}
		Return
	}
	Return
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
		Send {PGUP}
		Return
	}
	Else
	{
		Send {WheelDown}
		Return
	}
	Return
}

F1::
{
	KeyWait, F1, T0.1
	if (ErrorLevel)
	{
		Send {LControl Down}{F1}{Numpad1}{f}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}
		keywait F1
	}
	else {
		KeyWait, F1, D T0.1
		
		if (ErrorLevel)
		{
			Send {LControl Down}{F1}{Numpad1}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}
			keywait F1
		}
		
		else
		{
			Send {LControl Down}{F1}{Numpad1}{LAlt Down}{Numpad4}{f}{LAlt Up}{Numpad5}{LControl Up}
			keywait F1
		}
		
	}
	KeyWait, F1
	Return
}

LAlt & F1:: ; Select Unit cqnon
{
	If GetKeyState("MButton", "P")=1
	{
		Send {MButton Up}{LControl Down}{F1}{LAlt Down}{f}{Numpad1}{LAlt Up}{LControl Up}{MButton Down}
		keywait F1
		Return
	}
	Else
	{
		Send {LControl Down}{F1}{LAlt Down}{f}{Numpad1}{LAlt Up}{LControl Up}
		keywait F1
		Return
	}
}

F2:: ; Short press to select non normal Air factories, Long press to select advanced Air factories
{
	KeyWait F2, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		If GetKeyState("MButton", "P")=1
		{
			Send {MButton Up}{LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}{MButton Down}
			keywait F2
		}
		Else
		{
			Send {LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}
			keywait F2
		}
	}
	else
	{
		If GetKeyState("MButton", "P")=1
		{
			Sendinput {MButton Up}{LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}{MButton Down}
			keywait F2
		}
		Else
		{
			Sendinput {LControl Down}{F1}{Numpad2}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}
			keywait F2
		}
	}
	return
}

F3:: ; Short press to select non normal Naval factories, Long press to select advanced Naval factories
{
	KeyWait F3, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		Send {LControl Down}{F1}{Numpad3}{LAlt Down}{Numpad4}{LAlt Up}{Numpad5}{LControl Up}
		keywait F3
	}
	else
	{
		Send {LControl Down}{F1}{Numpad3}{LAlt Down}{Numpad4}{Numpad5}{LAlt Up}{LControl Up}
	}
	return
}

F4:: ; Short press to select non normal Orbital factories, Long press to select advanced Orbital factories
{
	KeyWait F4, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		Send {LControl Down}{F1}{Numpad4}{LAlt Down}{LAlt Up}{Numpad5}{LControl Up}
		keywait F4
	}
	else
	{
		Send {LControl Down}{F1}{Numpad4}{LAlt Down}{Numpad5}{LAlt Up}{LControl Up}
	}
	return
}

$&:: ; Cycle unit one by one, long press to center on selection
{
	KeyWait SC002, t0.100
	t:= A_TimeSinceThisHotkey
	If ErrorLevel
	{
		Send {F11}
		sleep 333
		keywait &
	}
	else
	{
		Send {SC002}
	}
	return
}

$SC004:: ; " Scout selection
{
	KeyWait, SC004, T0.1
	
	if (ErrorLevel)
	{
		Send {SC004}{LControl Down}{Numpad1}{LControl Up} ; Select Land Scout
	}
	else {
		KeyWait, SC004, D T0.1
		
		if (ErrorLevel)
		{
			Send {SC004}{LControl Down}{Numpad2}{LControl Up} ; Select Air Scout
		}
		
		else
		{
			Send {SC004}{LControl Down}{Numpad4}{LControl Up} ; Select Orbital Scout
		}
		
	}
	KeyWait, SC004
	Return
}

LControl & z:: ; Select all matching unit on screen then on planet.
{
	Sendinput {LControl down}{LAlt Down}{z}{LAlt Up}{LControl up}
	Return
}

LAlt & RButton:: ; Modeless Attack
{
	Sendinput {a}
	Return
}

Tab:: ; Cycle unit in selection and center on it
{
	Send {&}{F11}
	Return
}

~LButton Up:: ; Selection filter ?
{
	If GetKeyState("F13") 
		Send {LControl Down}{LAlt Down}{Numpad1}{LAlt Up}{LControl Up} ; Remove Land from Selection
	Else
		If GetKeyState("F14")
			Send {u} ; Selection filter ?
	Return
}