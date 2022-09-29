#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

GemTradeLoop(tradesCollected := 0) {
  DelayedSend("a")
  CollectTrades()
  ScrollToTop()
  Loop {
    if(TradesReady()) {
      CollectTrades()
    }
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
        tradesCollected++
      } else {
        break
      }
    }
  }
  DelayedSend("{Esc}")
  return tradesCollected
}

NoMoreTrades() {
  options := {x1: 2005, y1: 394, x2: 2142, y2: 453}
  return !TradeBuyable(options)
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
  return IsImagePresent(graphicsearch_query, options)
}

BuyGemTrade(trade) {
  X := trade.x, Y := trade.y
  DelayedClick(2080, Y + 15)
  DelayedClick(2020, 1138, 0)
}

TradesReady() {
  ; Check for notification
  withoutMenuQuery := "|<Trade ready>FF0000-000000$17.zzzzzzzzzzzzzzzzzzzzzXzz7zyDzwTzszzlzzXzz7zzzzzzzszzlzzXzzzzzzzzzk"
  withMenuQuery := "|<Trade ready With Menu>830000-000000$17.zzzzzzzzzzzzzzzzzzzzzzzz7zyDzwTzszzlzzXzz7zyDzzzzzzzlzzXzz7zzzzzzzzzzzz"
  options := {x1: 1430, y1: 1288, x2: 1466, y2: 1327}
  return IsImagePresent(withoutMenuQuery, options) or IsImagePresent(withMenuQuery, options)
}

CollectTrades() {
  DelayedClick(2020, 1138)
}

BoostAll() {
  DelayedClick(1691, 1125)
}