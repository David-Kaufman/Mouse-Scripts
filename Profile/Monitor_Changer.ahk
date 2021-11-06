#SingleInstance Force
SendMode Input 

R_Monitor 		:= " #### "											;Serial number of the Right Monitor
L_Monitor 		:= " #### "											;Serial number of the Left Monitor
ClickMonitorDDC := "ClickMonitorDDC"								;Name of the software
Path 			:= "./Path to software"								;Path to the software

Brightness_Down 				= b 0				;Command to change brightness to 0%
Brightness_Up 					= b 75				;Command to change brightness to 75%
Change_input_to_hdmi1 			= "s hdmi1"			;Command to change Input to HDMI1
Change_input_to_displayport2 	= "s displayport2"	;Command to change Input to displayport2

; Beacause ClickMonitorDDC doesnt have a way to detect the current brightness
; I'm assuming the monitor starts at a brightness of 75%
; if it isnt, the first try will fail and only the second try will work.

R_Brightness := 75				;Holds the Current Brightness of the Right monitor 	- assume default is 75%
L_Brightness := 75				;Holds the Current Brightness of the Left monitor 	- assume default is 75%

Monitor_Input := "displayport2"	;Holds the current Monitor Input mode {displayport2, HDMI1} - Xbox is connected to the Left Monitor

+F11::
	if(R_Brightness)
	{	
		;open cmd.exe and run the command
		
		Run cmd /k %Path%
		WinWait, ahk_exe cmd.exe
		Send %ClickMonitorDDC% %R_Monitor% %Brightness_Down%{Enter}
			
		Sleep 100
			
		R_Brightness := 0		;Change the Current Brightness
		Process, Close, cmd.exe
		
		return
	}
	
	Run cmd /k %Path%
	WinWait, ahk_exe cmd.exe
	Send %ClickMonitorDDC% %R_Monitor% %Brightness_Up%{Enter}
	
	Sleep 100
	
	R_Brightness := 75		;Change the Current Brightness
	Process, Close, cmd.exe
	
	return

+F12::
	if(L_Brightness)
	{	
		;open cmd.exe and run the command
		Run cmd /k %Path%
		WinWait, ahk_exe cmd.exe
		Send %ClickMonitorDDC% %L_Monitor% %Brightness_Down%{Enter}
			
		Sleep 100	
			
		L_Brightness := 0		;Change the Current Brightness
		Process, Close, cmd.exe
		
		return
	}
	
	Run cmd /k %Path%
	WinWait, ahk_exe cmd.exe
	Send %ClickMonitorDDC% %L_Monitor% %Brightness_Up%{Enter}

	Sleep 100
	
	L_Brightness := 75		;Change the Current Brightness
	Process, Close, cmd.exe
		
	return

+F10::
	if (Monitor_Input = "displayport2")
	{	
		;open cmd.exe and run the command
		Run cmd /k %Path%
		WinWait, ahk_exe cmd.exe
		Send %ClickMonitorDDC% %L_Monitor% s hdmi1{Enter}
		
		Sleep 100
		
		Monitor_Input := "hdmi1"	;Change the Current Input mode
		Process, Close, cmd.exe
	}
	else
	{
		Run cmd /k %Path%
		WinWait, ahk_exe cmd.exe
		Send %ClickMonitorDDC% %L_Monitor% s displayport2{Enter}
		
		Sleep 100

		Monitor_Input := "displayport2" 	;Change the Current Input mode
		Process, Close, cmd.exe
	}
	return			
