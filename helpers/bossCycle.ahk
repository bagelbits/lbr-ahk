global teleportX := 1761
global bossConfig := Yaml("config\bosses.yaml")

WitchCycle(cycleMax := 0) {
  static witchCycleCount := 0
  if (HasWitchSpawned()) {
    ; Put on WEM/WCM set
    DelayedSend(hotKeys.loadout.wem)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(teleportX, bossConfig.witch.teleportY)
    witchCycleCount++

    if (cycleMax != 0) {
      if (witchCycleCount >= cycleMax) {
        HitTheCounter()
        witchCycleCount := 0
      }
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
  if (!AreasWindowOpen()) {
    DelayedSend(hotKeys.menu.areas)
  }
  ScrollToBottom()
  DelayedClick(teleportX, bossConfig.counter.teleportY)
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

AreasWindowOpen() {
  areasWindow := "|<Areas Window>0xFFFFFF@1.00$71.0000000000000000000000003zU0000000007z0000000000Dy0000000000Tw000000000D07UTzk07zU0S0D0zzU0Dz00w0S1zz00Ty01s0w3zy00zw03zzs7U3kS1zVbzzkD07Uw3z3DzzUS0D1s7y6Tzz0w0S3kDwAw0S1s007zU0Ns0w3k00Dz00nk1s7U00Ty01bU3kD000zw03D07US001zs06S0D0w000Dz00w0S1s000Ty01s0w3k000zw03k1s7U001zs0000000000000000000000001"
  search_options := {x1: 312, y1: 229, x2: 469 , y2: 269}
  return IsImagePresent(areasWindow, search_options)
}
