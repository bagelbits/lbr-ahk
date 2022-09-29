#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk
#Include %A_ScriptDir%\utils.ahk

#IfWinActive Leaf Blower Revolution
Numpad2::
  DelayedSend('a')
  GemTradeLoop()
  DelayedSend('a')
  Loop {
    if (TradesReady()) {
      DelayedSend('a')
      CollectTrades()
      GemTradeLoop()
      DelayedSend('a')
    }
  }

Numpad0::
  ;

GemTradeLoop() {
  Loop {
    ScrollToTop()
    if(NoMoreTrades()) {
      break
    }
    gemTrades := GetGemTrades()
    for index, element in gemTrades {
      BuyGemTrade(element)
    }
    DelayedSend("`")
  }
  return
}

NoMoreTrades() {
  ; if first trade has no buy button
  ;   return true
  ; return false
}

GetGemTrades() {
  ; search for gem trades
  ; return gem trades
}

BuyGemTrade(element) {
  ; buy gem trade
}

TradesReady() {
  ; Check for notification
}

CollectTrades() {
  ; Collect trades
}

#IfWinActive
Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
