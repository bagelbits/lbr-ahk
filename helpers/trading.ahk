global leafscendConfig := Yaml("config\leafscend.yaml")

GemTradeLoop(shouldLeafscend := false) {
  static firstRun := true
  static tradesCollected := 0
  static timeToSkip := 0

  if((TradesReady() or firstRun) and timeToSkip == 0) {
    DelayedSend(hotKeys.menu.trading)
    ScrollToTop()
    Loop {
      if(TradesReady()) {
        CollectTrades()
      }
      DelayedSend(hotKeys.trade.refresh)
      if(NoMoreTrades()) {
        BoostAll()
        break
      }
      gemTrades := GetGemTrades()
      for index, trade in gemTrades {
        searchOptions := {x1: 2005, y1: trade.y - 23, x2: 2142, y2: trade.y + 22}
        if (TradeBuyable(searchOptions)) {
          BuyGemTrade(trade)
          tradesCollected++
        } else {
          break
        }
      }
      DelayedClick(2020, 1138, 0)
    }
    DelayedSend("{Esc}")
  }

  if (shouldLeafscend) {
    ; Only leafscend when we hit max trades and we're not already
    ; to time skip
    if (timeToSkip == 0 and tradesCollected >= leafscendConfig.maxTrades) {
      Leafscend()
      timeToSkip := A_TickCount + 1000 * 15 ; 15 seconds in the future
      tradesCollected -= leafscendConfig.maxTrades
    }

    if (timeToSkip > 0 and timeToSkip < A_TickCount) {
      TimeSkip()
      timeToSkip := 0
    }
  }
  firstRun := false
  return timeToSkip
}

NoMoreTrades() {
  options := {x1: 2005, y1: 394, x2: 2142, y2: 453}
  return !TradeBuyable(options)
}

GetGemTrades() {
  Delay()
  gemQuery := "|<Gem Trade>0x9C1539@1.00$2.zzzzzz2"
  options := {x1: 285, y1: 204, x2: 2199, y2: 1173}
  resultObj := graphicsearch.search(gemQuery, options)
  return resultObj
}

TradeBuyable(options) {
  Delay()
  ; To make my life easier
  graphicsearch_query := "|<Trade Button>FFF1D2-000000$71.000000000000000000000000000000000001zzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzyTzzzzzzzzzzwzzzzzzzzzzztzzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzyTzzzzzzzzzzwzzzzzzzzzzztzzzzzzzzzzznzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzz"
  return IsImagePresent(graphicsearch_query, options)
}

BuyGemTrade(trade) {
  X := trade.x, Y := trade.y
  DelayedClick(2080, Y + 15)
}

TradesReady() {
  ; Check for notification
  searchQuery := "|<Trade ready>FF0000-000000$17.zzzzzzzzzzzzzzzzzzzzzXzz7zyDzwTzszzlzzXzz7zzzzzzzszzlzzXzzzzzzzzzk"
  options := {x1: 1430, y1: 1288, x2: 1466, y2: 1327}
  return IsImagePresent(searchQuery, options)
}

CollectTrades() {
  DelayedClick(2020, 1138)
}

BoostAll() {
  DelayedClick(1691, 1125)
}

Leafscend() {
  DelayedSend(hotKeys.menu.leafscend)
  ; L1 tab
  DelayedClick(434, 1211)
  ; Turn on L1
  DelayedClick(827, 1129)
  Delay(1000)
  ; Turn off L1
  DelayedClick(1075, 1134)
  DelayedSend("{Esc}")
}

TimeSkip() {
  DelayedSend(topMenuHotKeys.gem)
  ; Click Time travel tab
  DelayedClick(972, 1211)
  ; Buy 30m skip
  DelayedClick(1637, 335)
  ; Use 30m skip
  DelayedClick(1804, 335)
  DelayedSend("{Esc}")
}
