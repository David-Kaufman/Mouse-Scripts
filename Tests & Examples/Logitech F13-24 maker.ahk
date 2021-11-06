#NoEnv
#Singleinstance, Force
CoordMode, Mouse, Screen
SetKeyDelay, 50, 50

OKLocated := 0

;~ Open a profile in LGS, position the mouse cursor over the + by "Commands" on the left and hit F1.
;~ It Sends F13, and then waits for you to click OK. 
;~ It remembers where you clicked OK, then adds the other 11 bindings automatically 


F1::
	MouseGetPos, x1, y1
	Loop 12 {
		MouseMove, x1, y1
		Click
		num := A_Index + 12
		Sleep 250
		Send % "{F" num "}"
		if (OKLocated){
			MouseClick, Left, x2, y2
		} else {
			; Wait for user to click OK
			KeyWait, LButton, D
			KeyWait, LButton
			; Record coords
			MouseGetPos, x2, y2
			OKLocated := 1
		}
	}
	return