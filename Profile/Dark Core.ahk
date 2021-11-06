; ==================================================================================================================================
; ============================================ Begin Auto-Execute Section ==========================================================
; ==================================================================================================================================


/* Mouse layout
	  +-----+
 	  | F17 | 
+-----+-----+
| F15 | F16 |  
+-----+-----+
| F13 | F14 | 
+-----+-----+

*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#InstallMouseHook

SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.


; Monitor brightness and input commands - see NirSoft ControlMyMonitor
; https://www.nirsoft.net/utils/control_my_monitor.html

Current_Monitor			:= "Right"
Toggle_Right_Brightness	:= true
Toggle_Left_Brightness	:= true

ControlMyMonitor 		:= "D:\Program Files\ControlMyMonitor\"
Right_Brightness_0  	:= "ControlMyMonitor.exe /SetValue BD5DTS2 10 0"		;Command to change brightness to 0%
Right_Brightness_75 	:= "ControlMyMonitor.exe /SetValue BD5DTS2 10 75"		;Command to change brightness to 75%
Right_Brightness_inc	:= "ControlMyMonitor.exe /ChangeValue BD5DTS2 10 10"	;Command to change increase brightness by 10%
Right_Brightness_dec	:= "ControlMyMonitor.exe /ChangeValue BD5DTS2 10 -10"	;Command to change decrease brightness by 10%

Left_Brightness_0 		:= "ControlMyMonitor.exe /SetValue 3Q53X13 10 0"		;Command to change brightness to 0%
Left_Brightness_75 		:= "ControlMyMonitor.exe /SetValue 3Q53X13 10 75"		;Command to change brightness to 75%
Left_Brightness_inc 	:= "ControlMyMonitor.exe /ChangeValue 3Q53X13 10 10"	;Command to change increase brightness by 10%
Left_Brightness_dec 	:= "ControlMyMonitor.exe /ChangeValue 3Q53X13 10 -10"	;Command to change decrease brightness by 10%

Right_Input_DisplayPort2:= "ControlMyMonitor.exe /SetValue BD5DTS2 60 16"		;Command to change monitor input to displayport2
Right_Input_HDMI		:= "ControlMyMonitor.exe /SetValue BD5DTS2 60 17"		;Command to change monitor input to HDMI

TrayTipNotify()

return	;; END of Auto-Execute Section

; ============================================ END Auto-Execute Section ===========================================================


; ================================================= Helper Functions ==============================================================
; =================================================================================================================================

ReloadScript(){
		
    TrayTipNotify("reload")	
	
	Reload
	
	;;This will execute if reloading failed
	Sleep 1000
	TrayTipNotify("fail")	
	
}

HideTrayTip() {

	Menu Tray, NoIcon
	Sleep 250 
	Menu Tray, Icon
	return
}

TrayTipNotify(message := "start"){
	
	/*
		+-----------------------+---------------+
		|       Function        | Decimal Value |
		+-----------------------+---------------+
		| info icon             |             1 |
		| warning icon          |             2 |
		| Error icon            |             3 |
		| no notification sound |            16 |
		+-----------------------+---------------+
	*/
	
	if(message = "start")
	{
		TrayTip, Dark Core, Script Loaded Successfully,,1	; info icon
		Sleep 2000
		HideTrayTip()
	}
	
	else if(message = "reload")
	{
		TrayTip, Dark Core, Reloading...,,17				; info icon + no sound
		Sleep 2000
		HideTrayTip() 
	}
	
	else if(message = "fail")
	{
		TrayTip, Dark Core, Failed Reloading Script!!!,,3	; error icon
		Sleep 2000
		HideTrayTip() 
	}
		
	return
}

NotImplemented(){
	
	; notify not implemented
	
	ToolTip Not implemented
	Sleep 500
	ToolTip
	return
}

ShowToolTip(message, duration := 250){
	
	; Shows a tooltip with the given message, for the given duration (msec)
	
	ToolTip,%message%
	Sleep %duration%
	ToolTip
	return
}

;; ============================================ Monitors ===========================================================
;; =================================================================================================================

	!Numpad1::
		Run cmd /c %Right_Input_DisplayPort2%, %ControlMyMonitor%, Hide 	;change monitor input to displayport
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	!Numpad2::
		Run cmd /c %Right_Input_HDMI%, %ControlMyMonitor%, Hide			;change monitor input to HDMI
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	!NumpadMult::
		if(Current_Monitor == "Left")
		{
			Current_Monitor := "Right"
			ShowToolTip("Right")
		}
		else if(Current_Monitor == "Right")
		{
			Current_Monitor := "Left"
			ShowToolTip("Left")
		}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	!NumpadAdd::
		if(Current_Monitor == "Left")
		{
			; increase left monitor brightness
			Run cmd /c %Left_Brightness_inc%, %ControlMyMonitor%, Hide
			Sleep 250
		}
		else
		{
			; increase right monitor brightness
			Run cmd /c %Right_Brightness_inc%, %ControlMyMonitor%, Hide
			Sleep 250
		}
	return
		
	;-------------------------------------------------------
	;-------------------------------------------------------

	!NumpadSub::
		if(Current_Monitor == "Left")
		{	
			; decrease left monitor brightness
			Run cmd /c %Left_Brightness_dec%, %ControlMyMonitor%, Hide
			Sleep 250
		}
		else
		{
			; decrease right monitor brightness
			Run cmd /c %Right_Brightness_dec%, %ControlMyMonitor%, Hide
			Sleep 250
		}
	return	
		
	;-------------------------------------------------------
	;-------------------------------------------------------

	!F11::
		if(!Toggle_Left_Brightness)
		{
			; turn left monitor brightness ON
			Run cmd /c %Left_Brightness_75%, %ControlMyMonitor%, Hide
			
			Toggle_Left_Brightness := !Toggle_Left_Brightness
		}
		
		else
		{	
			; turn left monitor brightness OFF
			Run cmd /c %Left_Brightness_0%, %ControlMyMonitor%, Hide
			
			Toggle_Left_Brightness := !Toggle_Left_Brightness
		}
		
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	!F12::
		if(!Toggle_Right_Brightness)
		{
			; turn right monitor brightness ON
			Run cmd /c %Right_Brightness_75%, %ControlMyMonitor%, Hide
			
			Toggle_Right_Brightness := !Toggle_Right_Brightness
		}
		
		else
		{	
			; turn left monitor brightness OFF
			Run cmd /c %Right_Brightness_0%, %ControlMyMonitor%, Hide
			
			Toggle_Right_Brightness := !Toggle_Right_Brightness
		}
		
	return
	
	
; ============================================ General Bindings =======================================================
; =====================================================================================================================

	^!r::
		ReloadScript()
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	^!e::
		Edit
	return

	;-------------------------------------------------------
	;-------------------------------------------------------
		
	~Pause::
		Suspend
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F13::	
		Send !{Right}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F14::	
		Send !{Left}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F15::	
		Run MicrosoftEdge.exe
	return
		
	;-------------------------------------------------------
	;-------------------------------------------------------

	F16::	
		; Google Calendar
		Run "./Path to Google Calendar"
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F17::
		Run outlook.exe
	return

	;-------------------------------------------------------
	;-------------------------------------------------------


; ============================================ Browser Bendings =======================================================
; =====================================================================================================================

#IfWinActive ahk_class Chrome_WidgetWin_1 

	F13::
			Send !{Right}
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F14::
			Send !{Left}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F15::	
			; Increase Placyback Speed
            Send {Shift}>
			return
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F16::
			; Decrease Placyback Speed
			Send {Shift}<
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F17::
			; Full Screen
            Send F
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

#IfWinActive


; ============================================== VLC Bendings =========================================================
; =====================================================================================================================

#IfWinActive ahk_class Qt5QWindowIcon ; VLC
	
	F13::
			; Jump +10 Seconds
            Send {Right}
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F14::
			; Jump -10 Seconds
            Send {Left}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F15::	
			; Increase Placyback Speed
            Send ]
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F16::
			; Decrease Placyback Speed
			Send [
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F17::
			; Play/Pause
            Send {Space}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------
     
#IfWinActive