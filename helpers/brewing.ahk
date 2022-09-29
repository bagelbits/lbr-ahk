#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include utils.ahk

BrewDE() {
  if (!AlchemyWindowOpen()) {
    DelayedSend("d")
  }
  ScrollToTop()
  DelayedClick(1758, 462)
  DelayedSend("d")
}

AlchemyWindowOpen() {
  Delay()
  alchemyWindow := "|<Alchemy Window>FFFFFF-000000$71.0000000000000000000000001zk0000003k03zU0000007U07z0000000D00Dy0000000S07U3kD00TzkzyD07US00zzVzwS0D0w01zz3zsw0S1s03zy7zlzzw3k1s00D03zzs7U3k00S07zzkD07U00w0DzzUS0D001s0S0D0w0S003k0w0S1s0w007U1s0w3k1s00D03k1s7U3k00S07U3kD07U00w0D07UTw0zzVs0S0D0zs1zz3k0w0S1zk3zy7U1s0w3zU7zwD0000000000000000000000001"
  search_options := {x1: 312, y1: 229, x2: 469 , y2: 269}
  return IsImagePresent(alchemyWindow, search_options)
}
