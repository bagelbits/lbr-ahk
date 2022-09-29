#SingleInstance, Force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include bossCycle.ahk
#Include brewing.ahk
#Include artifact.ahk

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

#IfWinActive
F11::
  Suspend
  Pause, Toggle, 1
  Return

F12::
  Suspend
  Reload
  Return
