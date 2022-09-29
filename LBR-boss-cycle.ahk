#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk
#Include %A_ScriptDir%\utils.ahk


; TODO: Memoize boss data
#IfWinActive Leaf Blower Revolution
Numpad0::
  bossCycleCount := 0
  Loop {
    DelayedSend("4")
    DelayedSend("5")
    bossCycleCount := BossCycle(bossCycleCount)
  }
  return

Numpad1::
  witchCycleCount := 0
  cycleMax := 5
  Loop {
    ; Attempt to cycle bosses
    witchCycleCount := WitchCycleWithCount(witchCycleCount, cycleMax)
    BrewDE()
    ; Spawn fruit and use extra violins
    DelayedSend("6")
    DelayedSend("7")
    ; ; Wait for violin to stop moving
    ; Delay(200)
    ; Find and use violin
    FindViolin()
    DelayedSend("7")
  }
  return

WitchCycle() {
  if (HasWitchSpawned()) {
    DelayedSend("v")
    ScrollToTop()
    ; Cycle Witch
    ClickAndWaitForBoss(1781, 785)
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("v")
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
      DelayedSend("v")
      DelayedClick(1491, 531)
      DelayedClick(914, 470)
      DelayedSend("v")
      witchCycleCount := 0
    }

    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("v")
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
    DelayedSend("v")
    DelayedClick(1491, 531)
    DelayedClick(914, 470)
    DelayedSend("1")
    DelayedSend("v")
    ; Teleport home
    DelayedSend("{Space}")
    DelayedSend("v")
    bossCycleCount++

    if (bossCycleCount >= cycleMax) {
      AttemptTranscendAll()
      bossCycleCount := 0
    }
  }
  return bossCycleCount
}

HasWitchSpawned() {
  withMenuQuery := "|<Menu Witch Spawned>838383-000000$68.0000000000000000000000M000000000067yCQMzk3s1zVzXb6Dw0y0TsTstlXz0DU7yM6CQMsCQT61a1Xb6C3b7lUNUMtlXUtlwM6M6CQMsCTU61a1Xb6C3bs1UMTszy3UsDU7y7yDzUsC3s1zVzXzsC3Uy0Ts00000000000U"
  withoutMenuQuery := "|<Witch Spawned>FFFFFF-000000$71.0000000000000000000000A00000000000M3z7CATs1w0zk7yCQMzk3s1zUDwQslzU7k3z0UMtlXUtlwM610lnX71nXskA21Xb6C3b7lUM437CAQ7Dk30k86CQMsCTU61UDwTz1kQ7k3z0Tszy3UsDU7y0zlzw71kT0Dw0000000000004"
  search_options := {x1: 2274, y1: 167, x2: 2450 , y2: 213}
  return IsImagePresent(withMenuQuery, search_options) or IsImagePresent(withoutMenuQuery, search_options)
}

HasCentaurSpawned() {
  withMenuQuery := "|<Menu Centaur Spawned>838383-000000$68.0000000000000000000000M0000000000600000000001VzXb6Dw0y0TsTstlXz0DU7yM6CQMsCQT61a1Xb6C3b7lUNUMtlXUtlwM6M6CQMsCTU61a1Xb6C3bs1UMTszy3UsDU7y7yDzUsC3s1zVzXzsC3Uy0Ts00000000000U"
  withoutMenuQuery := "|<Centaur Spawned>FFFFFF-000000$71.0000000000000000000000000000000000000000000000000000000000000000000001U000000000030000000000060zlnX7y0T0Dw1zXb6Dw0y0TsA37CAQ7CDX0kM6CQMsCQT61UkAQslkQsyA31UMtlXUty0M630lnX71nw0kA1zXzsC3Uy0Ts3z7zkQ71w0zk7yDzUsC3s1zU00000000000000000000000000000000000000000000000000000000000000000000000000000000001"
  search_options := {x1: 2274, y1: 234, x2: 2450 , y2: 273}
  return IsImagePresent(withMenuQuery, search_options) or IsImagePresent(withoutMenuQuery, search_options)
}

ClickAndWaitForBoss(x, y) {
  DelayedClick(x, y)
  DelayedClick(A_ScreenWidth / 2, A_ScreenHeight / 2, 0)
  Delay(900)
}

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

FindViolin() {
  graphicsearch_query := "|<Violin>0xC68862@1.00$2.y"
  resultObj := graphicsearch.search(graphicsearch_query)
  if (resultObj) {
    X := resultObj.1.x, Y := resultObj.1.y
    DelayedClick(X, Y, 0)
    resultObj := ""
  }
  return
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

#IfWinActive
Esc::ExitApp ;Escape key will exit... place this at the bottom of the script
