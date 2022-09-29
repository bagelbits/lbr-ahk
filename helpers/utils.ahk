#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

IsImagePresent(searchQuery, options) {
  ; #Include graphicsearch.ahk\export.ahk

  ; t1 := A_TickCount, X := Y := ""
  resultObj := graphicsearch.search(searchQuery, options)

  ; For Debug purposes:
  ; if (resultObj) {
  ;   X := resultObj.1.x, Y := resultObj.1.y, Comment := resultObj.1.id
  ;   ; Click, %X%, %Y%
  ; }

  ; MsgBox, 4096, Tip, % "Found :`t" Round(resultObj.MaxIndex())
  ;   . "`n`nTime  :`t" (A_TickCount-t1) " ms"
  ;   . "`n`nPos   :`t" X ", " Y
  ;   . "`n`nResult:`t" (resultObj ? "Success !" : "Failed !")

  ; for i,v in resultObj
  ;   if (i<=2)
  ;     graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)

  if (resultObj) {
    resultObj := ""
    return true
  } else {
    resultObj := ""
    return false
  }
}

DelayedSend(key:="v") {
  Delay()
  SendInput, %key%
}

DelayedSendEvent(key:="{Click}") {
  Delay()
  SendEvent, %key%
}

DelayedClick(x, y, clickCount := 1, button := "Left") {
  if (clickCount == 0) {
    DelayedSendEvent("{Click " x " " y " " clickCount " " button "}")
    return
  }
  DelayedSendEvent("{Click " x " " y " " clickCount " D " button "}")
  Delay(175)
  DelayedSendEvent("{Click " x " " y " " clickCount " U " button "}")
}

Delay(Ms:=75) {
  Sleep Ms
}

ScrollToTop(){
  DelayedSend("{Ctrl Down}")
  DelayedSend("{WheelUp}")
  DelayedSend("{Ctrl Up}")
}

ScrollToBottom(){
  DelayedSend("{Ctrl Down}")
  DelayedSend("{WheelDown}")
  DelayedSend("{Ctrl Up}")
}
