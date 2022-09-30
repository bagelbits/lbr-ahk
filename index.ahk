#SingleInstance, Force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn UseUnsetLocal, Off
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

#Include %A_ScriptDir%\lib
#Include Yaml.ahk
global hotKeys := Yaml("config\hotkeys.yaml")

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include bossCycle.ahk
#Include brewing.ahk
#Include artifact.ahk
#Include trading.ahk

global topMenuHotKeys = { cards: "{F5}" }

; TODO: Memoize boss data
#IfWinActive Leaf Blower Revolution
Numpad0::
{
  Loop {
    DelayedSend(hotKeys.artifacts.blazingSkull)
    DelayedSend(hotKeys.artifacts.wind)
    ; Don't run this until we have leafscends
    ; GemTradeLoop()
    BossCycle()
  }
}

Numpad1::
{
  Loop {
    ; Attempt to cycle bosses
    WitchCycleWithCount()
    ; Don't run this until we have leafscends
    ; GemTradeLoop()
    BrewDE()
    ; Spawn fruit and use extra violins
    DelayedSend(hotKeys.artifacts.enchantedFruit)
    DelayedSend(hotKeys.artifacts.violin)
    ; ; Wait for violin to stop moving
    ; Delay(200)
    ; Find and use violin
    FindViolin()
    DelayedSend(hotKeys.artifacts.violin)
  }
}

Numpad2::
{
  GemTradeLoop()
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
