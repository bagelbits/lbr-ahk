#SingleInstance, Force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

; #Include %A_ScriptDir%\lib
; #Include Yaml.ahk

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include bossCycle.ahk
#Include brewing.ahk
#Include artifact.ahk

; global hotKeys := Yaml(%A_ScriptDir%\config\hotkeys.yaml)

; TODO: Memoize boss data
#IfWinActive Leaf Blower Revolution
Numpad0::{
  Loop {
    DelayedSend("4")
    DelayedSend("5")
    BossCycle()
  }
}

Numpad1::{
  Loop {
    ; Attempt to cycle bosses
    WitchCycleWithCount()
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
}

#IfWinActive
F11::{
  Suspend
  Pause, Toggle, 1
}

F12::{
  Suspend
  Reload
}
