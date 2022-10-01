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
