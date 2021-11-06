;; ==============================================================
;; =================== Chrome Profile ===========================
;; ==============================================================

/*
+-----+-----+-----+-----+
| F15 | F18 | F21 | F24 |
+-----+-----+-----+-----+
| F14 | F17 | F20 | F23 |
+-----+-----+-----+-----+
| F13 | F16 | F19 | F22 |
+-----+-----+-----+-----+
*/

#SingleInstance Force

Chrome_Modifier := false

; Media Keys 	=> 	Chrome_Modifier = False (Default)
; Interface		=>	Chrome_Modifier = True

GetBrowserURL_ACC(sClass){
	global nWindow, accAddressBar
	If (nWindow != WinExist("ahk_class " sClass)) ; reuses accAddressBar if it's the same window
	{
		nWindow := WinExist("ahk_class " sClass)
		accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindow))
	}
	Try sURL := accAddressBar.accValue(0)
	If (sURL == "") {
		WinGet, nWindows, List, % "ahk_class " sClass ; In case of a nested browser window as in the old CoolNovo (TO DO: check if still needed)
		If (nWindows > 1) {
			accAddressBar := GetAddressBar(Acc_ObjectFromWindow(nWindows2))
			Try sURL := accAddressBar.accValue(0)
		}
	}
	If ((sURL != "") and (SubStr(sURL, 1, 4) != "http")) ; Modern browsers omit "http://"
		sURL := "http://" sURL
	If (sURL == "")
		nWindow := -1 ; Don't remember the window if there is no URL
	Return sURL
}

; "GetAddressBar" based in code by uname
; Found at http://autohotkey.com/board/topic/103178-/?p=637687

GetAddressBar(accObj){
	Try If ((accObj.accRole(0) == 42) and IsURL(accObj.accValue(0)))
		Return accObj
	Try If ((accObj.accRole(0) == 42) and IsURL("http://" accObj.accValue(0))) ; Modern browsers omit "http://"
		Return accObj
	For nChild, accChild in Acc_Children(accObj)
		If IsObject(accAddressBar := GetAddressBar(accChild))
			Return accAddressBar
}


IsURL(sURL){
	Return RegExMatch(sURL, "^(?<Protocol>https?|ftp)://(?<Domain>(?:[\w-]+\.)+\w\w+)(?::(?<Port>\d+))?/?(?<Path>(?:[^:/?# ]*/?)+)(?:\?(?<Query>[^#]+)?)?(?:\#(?<Hash>.+)?)?$")
}

; The code below is part of the Acc.ahk Standard Library by Sean (updated by jethrow)
; Found at http://autohotkey.com/board/topic/77303-/?p=491516

Acc_Init(){
	static h
	If Not h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}


Acc_ObjectFromWindow(hWnd, idObject = 0){
	Acc_Init()
	If DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return ComObjEnwrap(9,pacc,1)
}


Acc_Query(Acc) {
	Try Return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}


Acc_Children(Acc){
	If ComObjType(Acc,"Name") != "IAccessible"
		ErrorLevel := "Invalid IAccessible Object"
	Else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		If DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren%
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
			Return Children.MaxIndex()?Children:
		} Else
			ErrorLevel := "AccessibleChildren DllCall Failed"
	}
}


#IfWinActive ahk_class Chrome_WidgetWin_1 
	
	F18::
		Send {F5}

	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------	
	
	F19::
		if(Chrome_Modifier){
			Send ^c ; Copy
			ShowToolTip("Copy")
			return
		}
		
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			
			; Decrease Placyback Speed
			Send {Shift}<
			return
        }    

	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	F20::	
		if(Chrome_Modifier){
				Send ^v	; Paste
				ShowToolTip("Paste")
				return
		}
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			
			; Increase Placyback Speed
            Send {Shift}>
			return
        }    

	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------

	F21::
		if(Chrome_Modifier){
				Send ^x	; Cut
				ShowToolTip("Cut")
				return
		}
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			; Full Screen
            Send F
			return
        }    

	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F22::
		
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			; Jump -10 Seconds
            Send J
			return
        }    
       
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F23::
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			
			; Play/Pause
            Send K
			return
        }    
       
	return

	;-------------------------------------------------------
	;-------------------------------------------------------

	F24::
		sURL := GetBrowserURL_ACC("Chrome_WidgetWin_1")
		
		; Added controls to video player on google drive - can be removed
		if(InStr(sURL, "youtube.com") || InStr(sURL, "drive.google.com")){
			
			; Jump +10 Seconds
            Send L
			return
        }    
        
	return
	
	;-------------------------------------------------------
	;-------------------------------------------------------
	
	^#F10::

		Chrome_Modifier := !Chrome_Modifier
			
		if (!Chrome_Modifier){
			ShowToolTip("Media keys")
		}
		else{
			ShowToolTip("Interface")
		}
	return

	
#IfWinActive

