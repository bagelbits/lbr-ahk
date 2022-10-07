global teleportX := 1761
global bossConfig := Yaml("config\bosses.yaml")

WitchCycle(cycleMax := 1) {
  static witchCycleCount := 0
  timeToTrade := false
  if (HasWitchSpawned()) {
    ; Put on WEM/WCM set
    DelayedSend(hotKeys.loadout.wem)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(teleportX, bossConfig.witch.teleportY)
    witchCycleCount++

    if (witchCycleCount >= cycleMax) {
      HitTheCounter()
      witchCycleCount := 0
      timeToTrade := true
    }

    if (cycleMax > 1) {
      ; Put on reroll set (Brew/MBrew)
      DelayedSend(hotKeys.loadout.reroll)
    } else {
      ; Put on WEM/WCM set
      DelayedSend(hotKeys.loadout.wem)
    }

    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
  }
  return timeToTrade
}

BossCycle(cycleMax := 2) {
  static bossCycleCount := 0
  if (HasCentaurSpawned()) {
    DelayedSend(hotKeys.loadout.wem)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()

    ; Cycle other timer bosses
    scrolls := [9, -1]
    lastY := A_ScreenHeight
    for k, v in bossConfig.cycleBosses[""] {
      if (lastY >= bossConfig[v].teleportY) {
        ScrollDown(scrolls.RemoveAt(1))
      }
      if (bossConfig[v].loadout) {
        DelayedSend(hotKeys.loadout[bossConfig[v].loadout])
      }
      ClickAndWaitForBoss(teleportX, bossConfig[v].teleportY)
      lastY := bossConfig[v].teleportY
    }
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
    bossCycleCount++

    if (cycleMax > 2) {
      ; Put on reroll set (Brew/MBrew)
      DelayedSend(hotKeys.loadout.reroll)
    } else {
      ; Put on WEM/WCM set
      DelayedSend(hotKeys.loadout.wem)
    }

    if (bossCycleCount >= cycleMax) {
      AttemptTranscendAll()
      bossCycleCount := 0
    }
  }
}

HasWitchSpawned() {
  return IsImagePresent(bossConfig.witch.search.query, bossConfig.witch.search.options)
}

HasCentaurSpawned() {
  return IsImagePresent(bossConfig.centaur.search.query, bossConfig.centaur.search.options)
}

ClickAndWaitForBoss(x, y) {
  DelayedClick(x, y)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
  Delay(900)
}

HitTheCounter() {
  if (!MenuOpen("areas")) {
    DelayedSend(hotKeys.menu.areas)
  }
  ScrollToBottom()
  DelayedClick(teleportX, bossConfig.counter.teleportY)
  DelayedSend("{Esc}")
  DelayedSend(hotKeys.loadout.damage)
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
  DelayedSend("{Space}")
  DelayedClick(952, 399)
  DelayedSend("{Space}")
  DelayedSend("{Esc}")
}
