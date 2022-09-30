RestockLeaves(seedBagsToUse := -1) {
  if (seedBagsToUse > 0) {
    DelayedSend(hotKeys.artifacts.seedBag)
    seedBagsToUse--
    if (seedBagsToUse == 0) {
      TimeSkip()
    }
  }
  return seedBagsToUse
}

Leafscend() {
  DelayedSend(hotKeys.menu.leafscend)
  ; Click L1 tab
  ; Turn on L1
  ; Turn off L1
  DelayedSend("{Esc}")
}

TimeSkip() {
  DelayedSend(hotKeys.menu.gem)
  ; Click Time travel tab
  ; Buy 30m skip
  ; Use 30m skip
  DelayedSend("{Esc}")
}
