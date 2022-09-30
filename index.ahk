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
global artifactHotKeys := { blazingSkull: "4"
                          , wind: "5"
                          , enchantedFruit: "6"
                          , violin: "7"}
global loadoutHotKeys := { wemwcm: "1"
                          , damage: "2"
                          , brew: "3"}
global menuHotKeys := { areas: "v"
                      , brewing: "d"
                      , cards: "{F5}"
                      , trading: "a"}
global tradeHotKeys := { refresh: "``" }

; TODO: Memoize boss data
#IfWinActive Leaf Blower Revolution
Numpad0::
{
  Loop {
    DelayedSend(artifactHotKeys["blazingSkull"])
    DelayedSend(artifactHotKeys["wind"])
    BossCycle()
  }
}

Numpad1::
{
  Loop {
    ; Attempt to cycle bosses
    WitchCycleWithCount()
    BrewDE()
    ; Spawn fruit and use extra violins
    DelayedSend(artifactHotKeys["enchantedFruit"])
    DelayedSend(artifactHotKeys["violin"])
    ; ; Wait for violin to stop moving
    ; Delay(200)
    ; Find and use violin
    FindViolin()
    DelayedSend(artifactHotKeys["violin"])
  }
}

#IfWinActive
F11::
{
  Suspend
  Pause, Toggle, 1
}

F12::
{
  Suspend
  Reload
}
