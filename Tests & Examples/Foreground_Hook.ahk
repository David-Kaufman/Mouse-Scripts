#SingleInstance Force

callback_function_addr := RegisterCallback(Func("onForegroundChange"))

;InstallHook(true)

/*  
    Installs the Hook
    True - install
    False - uninstall   
*/
InstallHook(state)
{
    global callback_function_addr
    static hook, isHookInstalled := false

    if (!isHookInstalled and state)
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
            MsgBox, 16, Foreground Window Hook, Failed to install hook!
            return false
        }
        
        MsgBox, 64, Foreground Window Hook, Success! Hook installed!
        isHookInstalled := true
    }
    
    else if (isHookInstalled and !state) {
        if (!DllCall("UnhookWinEvent", "Ptr", hook))
        {
            MsgBox, 16, Foreground Window Hook, Failed to remove hook!
            return false
        }
        MsgBox, 64, Foreground Window Hook, Hook removed!
        isHookInstalled := false
    }

    return true
}

;Callback function   
onForegroundChange(hWinEventHook, event, hWnd, idObject, idChild, dwEventThread, dwmsEventTime) {
    
    addWindowToGroup(hWnd)
}

addWindowToGroup(hWindow)
{
    WinGetClass window_class, ahk_id %hWindow% ; get the class of the current window
       
    if(window_class = "Notepad"){
        ToolTip added to notepad
        GroupAdd, notepad, ahk_class Notepad
		Sleep 150
		ToolTip
    }
    
    if(window_class = "Chrome_WidgetWin_1"){
        ToolTip added to chrome
        GroupAdd, notepad, ahk_class Chrome_WidgetWin_1
		Sleep 150
		ToolTip
    }
	
}
