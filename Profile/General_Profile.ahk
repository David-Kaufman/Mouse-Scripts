;; ==============================================================
;; =================== General Profile ==========================
;; ==============================================================

/* Mouse layout
+-----+-----+-----+-----+
| F15 | F18 | F21 | F24 |
+-----+-----+-----+-----+
| F14 | F17 | F20 | F23 |
+-----+-----+-----+-----+
| F13 | F16 | F19 | F22 |
+-----+-----+-----+-----+
*/

#SingleInstance Force

openFileInChrome(){
	SendInput, ^c
	ClipWait, 1
	
	SendInput, #r
	WinWait, ahk_class #32770,,1 ; wait for the Run window
	
	if(!ErrorLevel){
		SendInput, chrome {Space}
		SendInput, ^V
		SendInput, {Enter}
	}
}

toggleTaskBar(){
	VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)	; APP_BAR_DATA
	
	NumPut(DllCall("Shell32\SHAppBarMessage"
					, "UInt", 4 			; ABM_GETSTATE
                    , "Ptr", &APPBARDATA
                    , "Int") ? 2:1			
			
			, APPBARDATA					; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
			, A_PtrSize=4 ? 32:40) 			
 
	DllCall("Shell32\SHAppBarMessage"
				, "UInt", 10 				; ABM_SETSTATE
				, "Ptr", &APPBARDATA)
}


F13::	
	Send !{Left}
return

;-------------------------------------------------------
;-------------------------------------------------------

F14::	
	Send  !{Right}
return

;-------------------------------------------------------
;-------------------------------------------------------

F15::	
	;Run, chrome.exe
	Run MicrosoftEdge.exe
return
	
;-------------------------------------------------------
;-------------------------------------------------------

F16::	
	Run outlook.exe
return

;-------------------------------------------------------
;-------------------------------------------------------

F17::
	; One Calendar
	;Run "./Path to One Calendar"
	
	;Google Calendar
	Run "./Path to Google Calendar"
return

;-------------------------------------------------------
;-------------------------------------------------------

F18::
	; openFileInChrome()
	
	; Google Keep
	 Run "./Path to Google Keep"
return

;-------------------------------------------------------
;-------------------------------------------------------

F19::	
	Send ^c ; Copy
	ShowToolTip("Copy")
return

;-------------------------------------------------------
;-------------------------------------------------------

F20::	
	Send ^v	; Paste
	ShowToolTip("Paste")
return

;-------------------------------------------------------
;-------------------------------------------------------

F21::	
	Send ^x	; Cut
	ShowToolTip("Cut")
return

;-------------------------------------------------------
;-------------------------------------------------------

F22::
	toggleTaskBar()
	KeyWait, % A_ThisHotkey
return

;-------------------------------------------------------
;-------------------------------------------------------

F23::
	Run Notepad.exe
return

;-------------------------------------------------------
;-------------------------------------------------------

F24::
	Send, ^!{Tab}
return

;-------------------------------------------------------
;-------------------------------------------------------

;; ========================== Monitors ========================
;; ============================================================

!Numpad1::
	Run cmd /c %Right_Input_DisplayPort2%, %ControlMyMonitor%, Hide
	return
	
;-------------------------------------------------------
;-------------------------------------------------------

!Numpad2::
	Run cmd /c %Right_Input_HDMI%, %ControlMyMonitor%, Hide
	return

;-------------------------------------------------------
;-------------------------------------------------------

!NumpadMult::
	if(Current_Monitor == "Left"){
		Current_Monitor := "Right"
		ShowToolTip("Right")
	}
	else if(Current_Monitor == "Right"){
		Current_Monitor := "Left"
		ShowToolTip("Left")
	}
	return

;-------------------------------------------------------
;-------------------------------------------------------

!NumpadAdd::
	if(Current_Monitor == "Left"){
		Run cmd /c %Left_Brightness_inc%, %ControlMyMonitor%, Hide
		Sleep 250
	}
	else {
		Run cmd /c %Right_Brightness_inc%, %ControlMyMonitor%, Hide
		Sleep 250
	}
	return
	
;-------------------------------------------------------
;-------------------------------------------------------

!NumpadSub::
	if(Current_Monitor == "Left"){
		Run cmd /c %Left_Brightness_dec%, %ControlMyMonitor%, Hide
		Sleep 250
	}
	else {
		Run cmd /c %Right_Brightness_dec%, %ControlMyMonitor%, Hide
		Sleep 250
	}
	return	
	
;-------------------------------------------------------
;-------------------------------------------------------

!F9::
	Run cmd /c %Left_Brightness_0%, %ControlMyMonitor%, Hide
	return
	
;-------------------------------------------------------
;-------------------------------------------------------

!F10::
	Run cmd /c %Right_Brightness_0%, %ControlMyMonitor%, Hide
	return
	
;-------------------------------------------------------
;-------------------------------------------------------

!F11::
	Run cmd /c %Left_Brightness_75%, %ControlMyMonitor%, Hide
	return
	
;-------------------------------------------------------
;-------------------------------------------------------

!F12::
	Run cmd /c %Right_Brightness_75%, %ControlMyMonitor%, Hide
	return

