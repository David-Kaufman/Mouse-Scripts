#SingleInstance Force

F13::
		
	SendInput ^c
	ClipWait, 1
	
	SendInput #r
	WinWait, ahk_class #32770,,1
	
	if(!ErrorLevel){
		SendInput chrome {Space}
		SendInput, ^V
		SendInput, {Enter}
	}
	
return


