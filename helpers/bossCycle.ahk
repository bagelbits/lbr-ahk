#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

WitchCycle() {
  if (HasWitchSpawned()) {
    DelayedSend("v")
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(1781, 785)
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
  }
}

WitchCycleWithCount(witchCycleCount := 0, cycleMax := 4) {
  if (HasWitchSpawned()) {
    ; Put on WEM/WCM set
    DelayedSend("1")
    DelayedSend("v")
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(1781, 785)
    witchCycleCount++

    if (witchCycleCount >= cycleMax) {
      ScrollToBottom()
      DelayedClick(1742, 910)
      DelayedSend("{Esc}")
      DelayedClick(1491, 531)
      DelayedClick(914, 470)
      DelayedSend("v")
      witchCycleCount := 0
    }

    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
    ; Put on reroll set (Brew/MBrew)
    DelayedSend("3")
  }
  return witchCycleCount
}

BossCycle(bossCycleCount := 0, cycleMax := 2) {
  WitchCycle()
  if (HasCentaurSpawned()) {
    DelayedSend("v")
    ScrollToTop()
    ; Cycle other timer bosses
    Loop, 9 {
      DelayedSend("{WheelDown}")
    }
    ; Centaur
    ClickAndWaitForBoss(1761, 336)
    ; Vile Creature
    ClickAndWaitForBoss(1761, 476)
    ; Air Elemental
    ClickAndWaitForBoss(1761, 626)
    ; Spark Bubble v
    ClickAndWaitForBoss(1761, 766)
    ; Terror Blue
    ClickAndWaitForBoss(1761, 906)
    ; Terror Green
    ClickAndWaitForBoss(1761, 1046)
    ; Scroll again
    ScrollToBottom()
    ; Terror Red
    ClickAndWaitForBoss(1761, 346)
    ; Terror Purple
    ClickAndWaitForBoss(1761, 486)
    ; Super Terror
    DelayedSend("2")
    ClickAndWaitForBoss(1761, 636)
    ; Hit the counter
    DelayedClick(1742, 910)
    DelayedSend("{Esc}")
    DelayedClick(1491, 531)
    DelayedClick(914, 470)
    DelayedSend("{Esc}")
    DelayedSend("1")
    DelayedSend("v")
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("{Esc}")
    bossCycleCount++

    if (bossCycleCount >= cycleMax) {
      AttemptTranscendAll()
      bossCycleCount := 0
    }
  }
  return bossCycleCount
}

HasWitchSpawned() {
  searchQuery := "|<Witch Spawned>FFFFFF-000000$71.0000000000000000000000A00000000000M3z7CATs1w0zk7yCQMzk3s1zUDwQslzU7k3z0UMtlXUtlwM610lnX71nXskA21Xb6C3b7lUM437CAQ7Dk30k86CQMsCTU61UDwTz1kQ7k3z0Tszy3UsDU7y0zlzw71kT0Dw0000000000004"
  searchOptions := {x1: 2274, y1: 167, x2: 2450 , y2: 213}
  return IsImagePresent(searchQuery, searchOptions)
}

HasCentaurSpawned() {
  searchQuery := "|<Centaur Spawned>FFFFFF-000000$71.0000000000000000000000000000000000000000000000000000000000000000000001U000000000030000000000060zlnX7y0T0Dw1zXb6Dw0y0TsA37CAQ7CDX0kM6CQMsCQT61UkAQslkQsyA31UMtlXUty0M630lnX71nw0kA1zXzsC3Uy0Ts3z7zkQ71w0zk7yDzUsC3s1zU00000000000000000000000000000000000000000000000000000000000000000000000000000000001"
  searchOptions := {x1: 2274, y1: 234, x2: 2450 , y2: 273}
  return IsImagePresent(searchQuery, searchOptions)
}

ClickAndWaitForBoss(x, y) {
  DelayedClick(x, y)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
  Delay(900)
}

AttemptTranscendAll() {
  DelayedSend("{F5}")
  ; Hit Transcend tab
  DelayedClick(661, 1202)
  ; Attempt to transcend all
  DelayedClick(482, 399)
  DelayedClick(1253, 539)
  DelayedClick(952, 399)
  DelayedClick(1253, 539)
  DelayedSend("{F5}")
}
