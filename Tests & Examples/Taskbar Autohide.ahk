#SingleInstance Force

VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)	; APP_BAR_DATA

^Space::

	/*
	NumPut(	Number 				= DllCall result,
			, VarOrAddress 		= APPBARDATA
			, Offset 			= A_PtrSize=4 ? 32:40
			, Type := "UPtr")	= Omitted
	*/
	NumPut(DllCall("Shell32\SHAppBarMessage"
					, "UInt", 4 			; ABM_GETSTATE
                    , "Ptr", &APPBARDATA
                    , "Int") ? 2:1			
			
			, APPBARDATA					; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
			, A_PtrSize=4 ? 32:40) 			
 
	DllCall("Shell32\SHAppBarMessage"
				, "UInt", 10 ; ABM_SETSTATE
				, "Ptr", &APPBARDATA)
				
KeyWait, % A_ThisHotkey
Return