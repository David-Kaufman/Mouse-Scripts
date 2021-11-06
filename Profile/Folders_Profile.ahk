;; ==============================================================
;; =================== Folders Profile ==========================
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

Folder_Modifier := false

; Folders Profile 	=> 	Folder_Modifier = False (Default)
; Task Switcher		=>	Folder_Modifier = True

;-------------------------------------------------------
;-------------------------------------------------------

MButton::
	/* !! Notice !!
		
		Allows "MButton & F13-24" hotkeys to work while preserving the original functionality of the middle click.
		
		This makes sure that the middle click can still be sent if MButton is clicked by itslef (without any other key combination)
		
		The tilde "~" key will cause "MButton & F13-24" hotkeys to trigger AND send middle click, which is very uncomfortable in certain situations.
	*/
	
	Send {MButton}
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F13::
	
	if(Folder_Modifier){
		GroupActivate, chrome, R 	; Activates the next window in a window group.
									; R = IF NO members of the group are active when the command is given, activate the most recent window.
									; useful in cases where you temporarily switch to working on an unrelated task. 
		return
	}
	
	Run, "./Path to Folder"
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F14::

	if(Folder_Modifier){
		GroupActivate, folders, R 	; Activates the next window in a window group.
									; R = IF NO members of the group are active when the command is given, activate the most recent window.
									; useful in cases where you temporarily switch to working on an unrelated task. 
		return
	}
	Run, "./Path to Folder"
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F15::
	
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	Run, %A_MyDocuments%
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F16::
	
	if(Folder_Modifier){
		GroupActivate, PDF, R 	; Activates the next window in a window group.
									; R = IF NO members of the group are active when the command is given, activate the most recent window.
									; useful in cases where you temporarily switch to working on an unrelated task. 
		return
		return
	}
	
	Run, "./Path to Folder"
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F17::
	
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	Run, "./Path to Folder"
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F18::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F19::

	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	Run, "./Path to Folder"
	
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F20::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F21::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F22::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F23::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

MButton & F24::
	if(Folder_Modifier){
		NotImplemented()
		return
	}
	
	NotImplemented()
return

;-------------------------------------------------------
;-------------------------------------------------------

^#F10::

	Folder_Modifier := !Folder_Modifier
		
	if (!Folder_Modifier){
		ShowToolTip("Folders")
	}
	else{
		ShowToolTip("Task Switcher")
	}
return
























