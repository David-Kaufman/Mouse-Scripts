#SingleInstance Force
#Include ShellHook - Foreground Change.ahk


F13::	
	Run, notepad.exe						
	
return

F14::	
	num_of_windows := 0
	WinGet, output_var, list, ahk_group notepad			

	Loop % output_var
		num_of_windows := num_of_windows + 1
	
	MsgBox %num_of_windows%
	
return

F15::
	GroupActivate, notepad, R 		; Activates the next window in a window group.
									; R = 	IF NO members of the group are active when the command is given, activate the most recent window.
									; 		useful in cases where you temporarily switch to working on an unrelated task. 
return  




