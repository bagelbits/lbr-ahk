global teleportX := 1761
global bosses := Yaml("config\bosses.yaml")

WitchCycle(cycleMax := 0) {
  static witchCycleCount := 0
  if (HasWitchSpawned()) {
    ; Put on WEM/WCM set
    DelayedSend(hotKeys.loadout.wem)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(teleportX, bosses.witch.teleportY)
    witchCycleCount++

    if (cycleMax != 0 and witchCycleCount >= cycleMax) {
      HitTheCounter()
      witchCycleCount := 0
      ; Put on reroll set (Brew/MBrew)
      DelayedSend(hotKeys.loadout.reroll)
    }

    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
  }
}

BossCycle(cycleMax := 2) {
  static bossCycleCount := 0
  WitchCycle()
  if (HasCentaurSpawned()) {
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()

    ; Cycle other timer bosses
    scrolls := [9, -1]
    lastY := 0
    for k, v in bosses.cycleBosses[""] {
      if lastY >= bosses[v].teleportY {
        ScrollDown(scrolls.RemoveAt())
      }
      if (bosses[v].loadout) {
        DelayedSend(hotKeys.loadout[bosses[v].loadout])
      }
      ClickAndWaitForBoss(teleportX, bosses[v].teleportY)
      lastY := bosses[v].teleportY
    }

    HitTheCounter()
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
    bossCycleCount++

    if (bossCycleCount >= cycleMax) {
      AttemptTranscendAll()
      bossCycleCount := 0
    }
  }
}

HasWitchSpawned() {
  return IsImagePresent(bosses.witch.search.query, bosses.witch.search.options)
}

HasCentaurSpawned() {
  return IsImagePresent(bosses.centaur.search.query, bosses.centaur.search.options)
}

ClickAndWaitForBoss(x, y) {
  DelayedClick(x, y)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
  Delay(900)
}

HitTheCounter() {
  ; TODO: Open Area if not open
  ScrollToBottom()
  DelayedClick(teleportX, bosses.counter.teleportY)
  DelayedSend("{Esc}")
  DelayedClick(1491, 531)
  DelayedClick(914, 470)
  DelayedSend("{Esc}")
  DelayedSend(hotKeys.loadout.wem)
  DelayedSend(hotKeys.menu.areas)
}

AttemptTranscendAll() {
  DelayedSend(topMenuHotKeys.cards)
  ; Hit Transcend tab
  DelayedClick(661, 1202)
  ; Attempt to transcend all
  DelayedClick(482, 399)
  DelayedClick(1253, 539)
  DelayedClick(952, 399)
  DelayedClick(1253, 539)
  DelayedSend("{Esc}")
}
