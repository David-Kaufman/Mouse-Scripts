#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance
F2::
    Send ^s
    Reload
    ToolTip, Reloaded
       
return

;#InstallMouseHook
;~ MouseGetPos, xpos, ypos 
;~ MsgBox, The cursor is at X%xpos% Y%ypos%. 

;;----------------------------------------------------------------------------------------------------

; This example allows you to move the mouse around to see
; the title of the window currently under the cursor:
;~ #Persistent
;~ SetTimer, WatchCursor, 100
;~ return

;~ WatchCursor:
;~ MouseGetPos, , , id, control
;~ WinGetTitle, title, ahk_id %id%
;~ WinGetClass, class, ahk_id %id%
;~ ToolTip, ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
;~ return

;;--------------------------------------------------------------------------------------------------

; This example allows you to move the mouse around to see
; the text of a control currently under the cursor:

;~ #Persistent
;~ DetectHiddenText, On
;~ SetTimer, WatchCursor, 100
;~ return

;~ WatchCursor:
;~ MouseGetPos, , , WindowId, ControlId, 
;~ ControlGetText, text, %ControlId%, ahk_id %WindowId%
;~ ToolTip, text = %text%`nControl = %ControlId%
;~ return




;;----------------------------------------------------------------------------------------------------

; As the user drags the left mouse button, a ToolTip displays the size of the region inside the drag-area.

;~ CoordMode, Mouse, Screen
  
  ;~ ~LButton::
      ;~ MouseGetPos, begin_x, begin_y
      ;~ while GetKeyState("LButton")
      ;~ {
          ;~ MouseGetPos, x, y
          ;~ ToolTip, % begin_x ", " begin_y "`n" Abs(begin_x-x) " x " Abs(begin_y-y)
          ;~ Sleep, 10
      ;~ }
     ;~ ToolTip
  ;~ return
;;----------------------------------------------------------------------------------------------------

;~ #Persistent
;~ SetTimer, WatchCursor, 100
;~ return

;~ WatchCursor:
;~ MouseGetPos, , , id, control
;~ WinGetTitle, title, ahk_id %id%
;~ WinGetClass, class, ahk_id %id%

;~ #if class = "Chrome_WidgetWin_1"
    ;~ XButton1::
        ;~ MsgBox Chrome
    ;~ return
;~ #if

;~ XButton1::
        ;~ MsgBox %class%
;~ return

;;----------------------------------------------------------------------------------------------------

;~ XButton1::
    ;~ MouseGetPos, , , id, control
    ;~ WinGetTitle, title, ahk_id %id%
    ;~ WinGetClass, class, ahk_id %id%
    ;~ if(class = "Chrome_WidgetWin_1")
        ;~ MsgBox ON
    ;~ else
        ;~ MsgBox off
;~ return

;;----------------------------------------------------------------------------------------------------
;~ #IfWinActive ahk_class Notepad
;~ space::Send You pressed Win+Spacebar in Notepad.

;;----------------------------------------------------------------------------------------------------

;SetTitleMatchMode, 2   ; A window's title can contain WinTitle anywhere inside it to be a match

;~ #IfWinActive YouTube ahk_class Chrome_WidgetWin_1 ; if(WinTitle == YouTube && ahk_class == chrome)
    ;~ XButton1::
        ;~ if(GetKeyState("MButton")){
            ;~ Msgbox Tube Middle
        ;~ }
        ;~ else{
            ;~ ControlFocus, Chrome_OmniboxView1
        ;~ }
    ;~ return
    
   ;~ :*:qwe::youtube.com{Enter}
   
;~ #IfWinActive

#IfWinActive ahk_class Chrome_WidgetWin_1 
    Xbutton1::
        if(GetKeyState("MButton")){
            Msgbox Middle
            return
        }
        
        site := GetSite()   ;; GetSite() adds a 1 second delay to execution time. use it sparsely.
        
        if(InStr(site, "youtube")){
            MsgBox YouTube
        }    
        else if(InStr(site, "ynet")){
            MsgBox Ynet
        }  
        else{
            MsgBox Nothing here
        }
        
    return  ;; Xbutton1  

    :*:qwe::youtube.com{Enter}

#IfWinActive


GetSite()
{
        Send !d
        Sleep 50
        clipboard =  	; Start off empty to allow ClipWait to detect when the text has arrived.
        Send ^c
        ClipWait 1 		; Wait 1 Second for the clipboard to contain text.
        return %clipboard%
}
;;-----------------------------------------------------------------------------------------
;; Notification example
;~ XButton1::
    ;~ TrayTip #1, This is TrayTip #1,,17
    ;~ Sleep 1000   ; Let it display for 3 seconds.
    ;~ HideTrayTip()
    ;~ TrayTip #2, This is the second notification.,,17
    ;~ Sleep 1000
    ;~ HideTrayTip()
    ;~ ; Copy this function into your script to use it.
    ;~ HideTrayTip() {
        ;~ TrayTip  ; Attempt to hide it the normal way.
        ;~ if SubStr(A_OSVersion,1,3) = "10." {
            ;~ Menu Tray, NoIcon
            ;~ Sleep 200  ; It may be necessary to adjust this sleep.
            ;~ Menu Tray, Icon
        ;~ }
    ;~ }
;~ return

;;--------------------------------------------------------------------------------
;; Close a program
;~ Xbutton1::
    ;~ Process, Exist, Lcore.exe ;Logitech Gaming Software
    ;~ If (ErrorLevel != 0){
        ;~ Process, Close, Lcore.exe
        ;~ If (ErrorLevel != 0){
            ;~ MsgBox %ErrorLevel% Closed!
        ;~ }
    ;~ }    
;~ return



