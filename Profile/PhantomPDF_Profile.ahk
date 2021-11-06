;; =====================================================================
;; ===========================	PhantomPDF Profile =====================
;; =====================================================================

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

#IfWinActive ahk_class classFoxitPhantom ; PhantomPDF
	
	
	F13::
			; Select hand tool
			ShowToolTip("Hand")
			Send !3
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F14::
			; Highlight
			ShowToolTip("Highlight")
			Send ^+L
			
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	F15::	
			/* 	In order for this to work
				"Edit Object" has to be the third item
				on the Quick Access Toolbar
			*/
			
			; Edit Object -> All
			
			ShowToolTip("Edit All")
            Send {Alt}
			Sleep, 200
			Send 08		; choose third item on quick access toolbar
			Sleep, 200
			Send A
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	
	F18::
			/* 	In order for this to work
				"Edit Object" has to be the third item
				on the Quick Access Toolbar
			*/
			
			; Edit Object -> Text
			
			ShowToolTip("Edit Text")
            Send {Alt}
			Sleep, 200
			Send 08		; choose third item on quick access toolbar
			Sleep, 200
			Send T
			
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	F21::
			; Bookmark the current view
			ShowToolTip("Bookmark")
			Send ^b
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
    F23::
		Run Calc.exe
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F24::
		Run Notepad.exe
	return

	;-------------------------------------------------------
	;-------------------------------------------------------


#IfWinActive