; ==================================================================================================================================
; ============================================ Begin Auto-Execute Section ==========================================================
; ==================================================================================================================================

/* Mouse layout
+-----+-----+-----+-----+
| F15 | F18 | F21 | F24 |
+-----+-----+-----+-----+
| F14 | F17 | F20 | F23 |
+-----+-----+-----+-----+
| F13 | F16 | F19 | F22 |
+-----+-----+-----+-----+
*/

#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
#InstallMouseHook

SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.

; Monitor brightness and input commands - see NirSoft ControlMyMonitor
; https://www.nirsoft.net/utils/control_my_monitor.html

Current_Monitor			:= "Right"
ControlMyMonitor 		:= "./Path to ControlMyMonitor"
Right_Brightness_0  	:= "ControlMyMonitor.exe /SetValue BD5DTS2 10 0" 		;Command to change brightness to 0%
Right_Brightness_75 	:= "ControlMyMonitor.exe /SetValue BD5DTS2 10 75"		;Command to change brightness to 75%
Right_Brightness_inc	:= "ControlMyMonitor.exe /ChangeValue BD5DTS2 10 10"	;Command to change increase brightness by 10%
Right_Brightness_dec	:= "ControlMyMonitor.exe /ChangeValue BD5DTS2 10 -10"	;Command to change decrease brightness by 10%

Left_Brightness_0 		:= "ControlMyMonitor.exe /SetValue 3Q53X13 10 0"		;Command to change brightness to 0%
Left_Brightness_75 		:= "ControlMyMonitor.exe /SetValue 3Q53X13 10 75"		;Command to change brightness to 75%
Left_Brightness_inc 	:= "ControlMyMonitor.exe /ChangeValue 3Q53X13 10 10"	;Command to change increase brightness by 10%
Left_Brightness_dec 	:= "ControlMyMonitor.exe /ChangeValue 3Q53X13 10 -10"	;Command to change decrease brightness by 10%

Right_Input_DisplayPort2:= "ControlMyMonitor.exe /SetValue BD5DTS2 60 16"		;Command to change monitor input to displayport2
Right_Input_HDMI		:= "ControlMyMonitor.exe /SetValue BD5DTS2 60 17"		;Command to change monitor input to HDMI

InstallForegroundHook()			; hook to detect a foreground window change

TrayTipNotify()

#Include General_Profile.ahk
#Include Chrome_Profile.ahk
#Include Folders_Profile.ahk
#include VLC_Profile.ahk
#Include PhantomPDF_Profile.ahk

return	;; END of Auto-Execute Section

; ============================================ END Auto-Execute Section ===========================================================

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
		TrayTip, Mouse HotKeys, Script Loaded Successfully,,1	; info icon
		Sleep 2000
		HideTrayTip()
	}
	
	else if(message = "reload")
	{
		TrayTip, Mouse HotKeys, Reloading...,,17				; info icon + no sound
		Sleep 2000
		HideTrayTip() 
	}
	
	else if(message = "fail")
	{
		TrayTip, Mouse HotKeys, Failed Reloading Script!!!,,3	; error icon
		Sleep 2000
		HideTrayTip() 
	}
	
	else if(message = "hookinstallfail")
	{
		TrayTip, Foreground Window Hook, Failed to install hook!!!,,3	; error icon
		Sleep 3000
		HideTrayTip() 
	}
	
	else if(message = "hookremovefail")
	{
		TrayTip, Foreground Window Hook, Failed to remove hook!!!,,3	; error icon
		Sleep 3000
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

InstallForegroundHook(request_install := true){
	/*  
		Installs the EVENT_SYSTEM_FOREGROUND hook to detect a foreground window change
		request_install = True  -> install
		request_install = False -> uninstall   
	*/
		
	callback_function_addr 			:= RegisterCallback(Func("onForegroundChange"))	; adress of callback function
	static hook, isHookInstalled 	:= false

    if (!isHookInstalled and request_install)
    {   
        /*  https://docs.microsoft.com/en-us/windows/desktop/api/winuser/nf-winuser-setwineventhook
        
            HWINEVENTHOOK SetWinEventHook(
              DWORD        eventMin,            = 3     EVENT_SYSTEM_FOREGROUND
              DWORD        eventMax,            = 3     EVENT_SYSTEM_FOREGROUND
              HMODULE      hmodWinEventProc,    = 0
              WINEVENTPROC pfnWinEventProc,     =       Pointer to the event hook function
              DWORD        idProcess,           = 0     Specify zero to receive events from all processes on the current desktop.
              DWORD        idThread,            = 0     If zero, the hook function is associated with all existing threads on the current desktop.
              DWORD        dwFlags              = 0     WINEVENT_OUTOFCONTEXT
            );
            
            WINEVENT_OUTOFCONTEXT   = The callback function is not mapped into the address space of the process that generates the event.
            EVENT_SYSTEM_FOREGROUND = The foreground window has changed.
        */
                              
        hook := DllCall("SetWinEventHook", "UInt", 3, "UInt", 3, "Ptr", 0, "Ptr", callback_function_addr, "Int", 0, "Int", 0, "UInt", 0, "Ptr")
        
        if (!hook)
        {
            ;; MsgBox, 16, Foreground Window Hook, Failed to install hook!
			TrayTipNotify("hookinstallfail")
            return false
        }
        
        ;; MsgBox, 64, Foreground Window Hook, Success! Hook installed!
        isHookInstalled := true
    }
    
    else if (isHookInstalled and !request_install) {
        if (!DllCall("UnhookWinEvent", "Ptr", hook))
        {
            ;; MsgBox, 16, Foreground Window Hook, Failed to remove hook!
			TrayTipNotify("hookremovefail")
            return false
        }
        ;; MsgBox, 64, Foreground Window Hook, Hook removed!
        isHookInstalled := false
    }

    return true
}

onForegroundChange(hWinEventHook, event, hWnd, idObject, idChild, dwEventThread, dwmsEventTime){
	
	; Callback function   
	; The foreground window has been changed
		
    WinGetClass window_class, ahk_id %hWnd% 	; get the class of the changed window
   	
	; chrome group
    if(window_class = "Chrome_WidgetWin_1"){
        ;ToolTip added to chrome
        GroupAdd, chrome, ahk_class Chrome_WidgetWin_1
		Sleep 150
		;ToolTip
    }
	
	; Folders group
    else if(window_class = "CabinetWClass"){
        ;ToolTip added to folders
        GroupAdd, folders, ahk_class CabinetWClass
		Sleep 150
		;ToolTip
    }
	
	; PDF group
    else if(window_class = "classFoxitPhantom"){
        ;ToolTip added to PDF
        GroupAdd, PDF, ahk_class classFoxitPhantom ; PhantomPDF
		Sleep 150
		;ToolTip
    }
	
	return
}

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

