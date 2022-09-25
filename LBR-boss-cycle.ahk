#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

#IfWinActive Leaf Blower Revolution
Numpad0::
  ; Send, 4
  ; Send, 5
  ; TODO: Play with minimizing Sleep
  ; if (HasWitchSpawned()) {
  ;   Send, v
  ;   ; Cycle Witch
  ;   DelayedSendEvent("{Click 1781 785}")
  ;   Delay(1500)
  ;   ; Teleport home
  ;   DelayedSend("{Space}")
  ;   DelayedSend("v")
  ; }
  if (HasCentaurSpawned()) {
    Send, v
    ; Cycle other timer bosses
    Loop, 9 {
      DelayedSend("{WheelDown}")
    }
    ; Centaur
    DelayedSendEvent("{Click 1761 336 0}")
    Delay(1500)
    ; Vile Creature
    DelayedSendEvent("{Click 1761 476 0}")
    Delay(1500)
    ; Air Elemental
    DelayedSendEvent("{Click 1761 626 0}")
    Delay(1500)
    ; Spark Bubble v
    DelayedSendEvent("{Click 1761 766 0}")
    Delay(1500)
    ; Terror Blue
    DelayedSendEvent("{Click 1761 906 0}")
    Delay(1500)
    ; Terror Green
    DelayedSendEvent("{Click 1761 1046 0}")
    Delay(1500)
    ; Scroll again
    Loop, 5 {
      DelayedSend("{WheelDown}")
    }
    ; Terror Red
    DelayedSendEvent("{Click 1761 786 0}")
    Delay(1500)
    ; Terror Purple
    DelayedSendEvent("{Click 1761 936 0}")
    Delay(1500)
    ; Super Terror
    DelayedSendEvent("{Click 1761 1086 0}")
    Delay(1500)
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Ctrl Down}")
    DelayedSend("{WheelUp}")
    DelayedSend("{Ctrl Up}")
    DelayedSend("v")
  }
  return

HasWitchSpawned() {
  ; #Include graphicsearch.ahk\export.ahk

  t1 := A_TickCount, X := Y := ""
  ; TODO: Also search when menu open
  graphicsearch_query := "|<Witch Spawned>FFFFFF-000000$71.0000000000000000000000A00000000000M3z7CATs1w0zk7yCQMzk3s1zUDwQslzU7k3z0UMtlXUtlwM610lnX71nXskA21Xb6C3b7lUM437CAQ7Dk30k86CQMsCTU61UDwTz1kQ7k3z0Tszy3UsDU7y0zlzw71kT0Dw0000000000004"
  resultObj := graphicsearch.search(GraphicSearch_query)

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
    return true
  } else {
    return false
  }
}

HasCentaurSpawned() {
  ; #Include graphicsearch.ahk\export.ahk

  t1 := A_TickCount, X := Y := ""
  ; TODO: Also search when menu open
  graphicsearch_query := "|<Centaur Spawned>FFFFFF-000000$71.0000000000000000000000000000000000000000000000000000000000000000000001U000000000030000000000060zlnX7y0T0Dw1zXb6Dw0y0TsA37CAQ7CDX0kM6CQMsCQT61UkAQslkQsyA31UMtlXUty0M630lnX71nw0kA1zXzsC3Uy0Ts3z7zkQ71w0zk7yDzUsC3s1zU00000000000000000000000000000000000000000000000000000000000000000000000000000000001"
  resultObj := graphicsearch.search(GraphicSearch_query)

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
    return true
  } else {
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





Delay(Ms:=100) {
  Sleep Ms
  return
}

Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
