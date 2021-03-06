;; ==============================================================
;; =================== VLC Profile ==============================
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

#IfWinActive ahk_class Qt5QWindowIcon ; VLC
	
	F19::
			; Decrease Placyback Speed
			Send [
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	F20::	
			; Increase Placyback Speed
            Send ]
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	F21::
			; Full Screen
			Send f
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F22::
			; Jump -10 Seconds
            Send {Left}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F23::
			; Play/Pause
            Send {Space}
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F24::
			; Jump +10 Seconds
            Send {Right}
	return
		
     
#IfWinActive