#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk
#Include utils.ahk

#IfWinActive Leaf Blower Revolution
Numpad0::
  GemTradeLoop()
  ; loop
  ;   if trades ready
  ;     open trade window
  ;     collect trades
  ;     GemTradeLoop()
  ;     close trade window
  ;   do something else

GemTradeLoop() {
  Loop {

  }
  ; loop
  ;   scroll to the top of the page
  ;   if first trade has no buy button
  ;     break loop
  ;   search for gem trades
  ;   for each gem trade
  ;     if buyable
  ;       buy
  ;   refresh trades
}

#IfWinActive
Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
