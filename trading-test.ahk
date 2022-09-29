#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk
#Include %A_ScriptDir%\utils.ahk

#IfWinActive Leaf Blower Revolution
Numpad2::
  DelayedSend("a")
  GemTradeLoop()
  DelayedSend("a")
  Loop {
    if (TradesReady()) {
      DelayedSend("a")
      CollectTrades()
      GemTradeLoop()
      DelayedSend("a")
    }
  }
  return

Numpad0::
  gemTrades := GetGemTrades()
  for index, trade in gemTrades {
    searchOptions := {x1: 2005, y1: trade.y - 23, x2: 2142, y2: trade.y + 22}

    if (TradeBuyable(searchOptions)) {
      BuyGemTrade(trade)
    }
  }
  return

GemTradeLoop() {
  ScrollToTop()
  Loop {
    DelayedSend("``")
    if(NoMoreTrades()) {
      BoostAll()
      break
    }
    gemTrades := GetGemTrades()
    for index, trade in gemTrades {
      searchOptions := {x1: 2005, y1: trade.y - 23, x2: 2142, y2: trade.y + 22}
      if (TradeBuyable(searchOptions)) {
        BuyGemTrade(trade)
      }
    }
  }
  return
}

NoMoreTrades() {
  options := {x1: 2005, y1: 394, x2: 2142, y2: 453}
  if (!TradeBuyable(options)) {
    return true
  }
  return false
}

GetGemTrades() {
  Delay()
  graphicsearch_query := "|<Gem Trade>FA3A6D-000000$2.zzzzzU"
  resultObj := graphicsearch.search(GraphicSearch_query)
  return resultObj
}

TradeBuyable(options) {
  Delay()
  ; To make my life easier
  graphicsearch_query := "|<Trade Button>FFF1D2-000000$71.000000000000000000000000000000000001zzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzyTzzzzzzzzzzwzzzzzzzzzzztzzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzyTzzzzzzzzzzwzzzzzzzzzzztzzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzz"
  buyButtons := graphicsearch.search(graphicsearch_query, options)
  if (buyButtons) {
    return true
  }
  return false
}

BuyGemTrade(trade) {
  X := trade.x, Y := trade.y
  DelayedClick(2080, Y + 15)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
}

TradesReady() {
  ; Check for notification
  graphicsearch_query := "|<Trade ready>FF0000-000000$17.zzzzzzzzzzzzzzzzzzzzzXzz7zyDzwTzszzlzzXzz7zzzzzzzszzlzzXzzzzzzzzzk"
  options := {x1: 1430, y1: 1288, x2: 1466, y2: 1327}
  resultObj := graphicsearch.search(graphicsearch_query, options )
  if (resultObj) {
    return true
  }
  return false
}

CollectTrades() {
  DelayedClick(2020, 1138)
}

BoostAll() {
  DelayedClick(1691, 1125)
}

#IfWinActive
Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
