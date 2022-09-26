﻿#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk


; TODO: Memoize boss data
#IfWinActive Leaf Blower Revolution
Numpad0::
  Loop {
    DelayedSend("4")
    DelayedSend("5")
    if (HasWitchSpawned()) {
      DelayedSend("v")
      ScrollToTop()
      ; Cycle Witch
      ClickAndWaitForBoss(1781, 785)
      ; Teleport home
      DelayedSend("{Space}")
      DelayedSend("v")
    }
    Delay()
    if (HasCentaurSpawned()) {
      DelayedSend("v")
      ScrollToTop()
      ; Cycle other timer bosses
      Loop, 9 {
        DelayedSend("{WheelDown}")
      }
      ; Centaur
      ClickAndWaitForBoss(1761, 336)
      ; Vile Creature
      ClickAndWaitForBoss(1761, 476)
      ; Air Elemental
      ClickAndWaitForBoss(1761, 626)
      ; Spark Bubble v
      ClickAndWaitForBoss(1761, 766)
      ; Terror Blue
      ClickAndWaitForBoss(1761, 906)
      ; Terror Green
      ClickAndWaitForBoss(1761, 1046)
      ; Scroll again
      ScrollToBottom()
      ; Terror Red
      ClickAndWaitForBoss(1761, 346)
      ; Terror Purple
      ClickAndWaitForBoss(1761, 486)
      ; Super Terror
      DelayedSend("2")
      ClickAndWaitForBoss(1761, 636)
      ; Hit the counter
      ScrollToBottom()
      DelayedSendEvent("{Click 1742 910 2}")
      DelayedSend("v")
      DelayedSendEvent("{Click 1491 531 2}")
      DelayedSendEvent("{Click 914 470 2}")
      DelayedSend("1")
      DelayedSend("v")
      ; Teleport home
      DelayedSend("{Space}")
      DelayedSend("v")
    }
  }
  return

HasWitchSpawned() {
  withMenuQuery := "|<Menu Witch Spawned>909090-000000$68.0000000000000000000000M000000000067yCQMzk3s1zVzXb6Dw0y0TsTstlXz0DU7yM6CQMsCQT61a1Xb6C3b7lUNUMtlXUtlwM6M6CQMsCTU61a1Xb6C3bs1UMTszy3UsDU7y7yDzUsC3s1zVzXzsC3Uy0Ts00000000000U"
  withoutMenuQuery := "|<Witch Spawned>FFFFFF-000000$71.0000000000000000000000A00000000000M3z7CATs1w0zk7yCQMzk3s1zUDwQslzU7k3z0UMtlXUtlwM610lnX71nXskA21Xb6C3b7lUM437CAQ7Dk30k86CQMsCTU61UDwTz1kQ7k3z0Tszy3UsDU7y0zlzw71kT0Dw0000000000004"
  search_options := {x1: 2274, y1: 167, x2: 2450 , y2: 213}
  return BossSpawnedSearch(withMenuQuery, search_options) or BossSpawnedSearch(withoutMenuQuery, search_options)
}

HasCentaurSpawned() {
  withMenuQuery := "|<Menu Centaur Spawned>909090-000000$68.0000000000000000000000M0000000000600000000001VzXb6Dw0y0TsTstlXz0DU7yM6CQMsCQT61a1Xb6C3b7lUNUMtlXUtlwM6M6CQMsCTU61a1Xb6C3bs1UMTszy3UsDU7y7yDzUsC3s1zVzXzsC3Uy0Ts00000000000U"
  withoutMenuQuery := "|<Centaur Spawned>FFFFFF-000000$71.0000000000000000000000000000000000000000000000000000000000000000000001U000000000030000000000060zlnX7y0T0Dw1zXb6Dw0y0TsA37CAQ7CDX0kM6CQMsCQT61UkAQslkQsyA31UMtlXUty0M630lnX71nw0kA1zXzsC3Uy0Ts3z7zkQ71w0zk7yDzUsC3s1zU00000000000000000000000000000000000000000000000000000000000000000000000000000000001"
  search_options := {x1: 2274, y1: 234, x2: 2450 , y2: 273}
  return BossSpawnedSearch(withMenuQuery, search_options) or BossSpawnedSearch(withoutMenuQuery, search_options)
}

ClickAndWaitForBoss(x, y, clickCount := 2) {
  DelayedSendEvent("{Click " x " " y " " clickCount "}")
  Delay(1500)
}

BossSpawnedSearch(searchQuery, options) {
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

#IfWinActive
Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
