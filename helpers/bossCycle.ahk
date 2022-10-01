global teleportX := 1761

WitchCycle() {
  if (HasWitchSpawned()) {
    DelayedSend(hotKeys.loadout.wemwcm)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(teleportX, bosses.witch.teleportY)
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
  }
}

WitchCycleWithCount(cycleMax := 5) {
  static witchCycleCount := 0
  if (HasWitchSpawned()) {
    ; Put on WEM/WCM set
    DelayedSend(hotKeys.loadout.wemwcm)
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(teleportX, bosses.witch.teleportY)
    witchCycleCount++

    if (witchCycleCount >= cycleMax) {
      ScrollToBottom()
      DelayedClick(teleportX, bosses.counter.teleportY)
      DelayedSend("{Esc}")
      DelayedClick(1491, 531)
      DelayedClick(914, 470)
      DelayedSend(hotKeys.menu.areas)
      witchCycleCount := 0
    }

    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
    ; Put on reroll set (Brew/MBrew)
    DelayedSend(hotKeys.loadout.brew)
  }
}

BossCycle(cycleMax := 2) {
  static bossCycleCount := 0
  WitchCycle()
  if (HasCentaurSpawned()) {
    DelayedSend(hotKeys.menu.areas)
    ScrollToTop()
    ; Cycle other timer bosses
    Loop, 9 {
      DelayedSend("{WheelDown}")
    }
    ; Centaur
    ClickAndWaitForBoss(teleportX, bosses.centaur.teleportY)
    ; Vile Creature
    ClickAndWaitForBoss(teleportX, bosses.vileCreatrue.teleportY)
    ; Air Elemental
    ClickAndWaitForBoss(teleportX, bosses.airElemental.teleportY)
    ; Spark Bubble
    ClickAndWaitForBoss(teleportX, bosses.sparkBubble.teleportY)
    ; Terror Blue
    ClickAndWaitForBoss(teleportX, bosses.terrorBlue.teleportY)
    ; Terror Green
    ClickAndWaitForBoss(teleportX, bosses.terrorGreen.teleportY)
    ; Scroll again
    ScrollToBottom()
    ; Terror Red
    ClickAndWaitForBoss(teleportX, bosses.terrorRed.teleportY)
    ; Terror Purple
    ClickAndWaitForBoss(teleportX, bosses.terrorPurple.teleportY)
    ; Super Terror
    DelayedSend(hotKeys.loadout[bosses.superTerror.loadout])
    ClickAndWaitForBoss(teleportX, bosses.superTerror.teleportY)
    ; Hit the counter
    DelayedClick(teleportX, bosses.counter.teleportY)
    DelayedSend("{Esc}")
    DelayedClick(1491, 531)
    DelayedClick(914, 470)
    DelayedSend("{Esc}")
    DelayedSend(hotKeys.loadout.wemwcm)
    DelayedSend(hotKeys.menu.areas)
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
  ; searchQuery := "|<Witch Spawned>FFFFFF-000000$71.0000000000000000000000A00000000000M3z7CATs1w0zk7yCQMzk3s1zUDwQslzU7k3z0UMtlXUtlwM610lnX71nXskA21Xb6C3b7lUM437CAQ7Dk30k86CQMsCTU61UDwTz1kQ7k3z0Tszy3UsDU7y0zlzw71kT0Dw0000000000004"
  ; searchOptions := {x1: 2274, y1: 167, x2: 2450 , y2: 213}
  ; return IsImagePresent(searchQuery, searchOptions)
  return IsImagePresent(bosses.witch.search.query, bosses.witch.search.options)
}

HasCentaurSpawned() {
  ; searchQuery := "|<Centaur Spawned>FFFFFF-000000$71.0000000000000000000000000000000000000000000000000000000000000000000001U000000000030000000000060zlnX7y0T0Dw1zXb6Dw0y0TsA37CAQ7CDX0kM6CQMsCQT61UkAQslkQsyA31UMtlXUty0M630lnX71nw0kA1zXzsC3Uy0Ts3z7zkQ71w0zk7yDzUsC3s1zU00000000000000000000000000000000000000000000000000000000000000000000000000000000001"
  ; searchOptions := {x1: 2274, y1: 234, x2: 2450 , y2: 273}
  ; return IsImagePresent(searchQuery, searchOptions)
  return IsImagePresent(bosses.centaur.search.query, bosses.centaur.search.options)
}

ClickAndWaitForBoss(x, y) {
  DelayedClick(x, y)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
  Delay(900)
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
