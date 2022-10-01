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
global bosses := Yaml("config\bosses.yaml")

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include bossCycle.ahk
#Include brewing.ahk
#Include artifact.ahk
#Include trading.ahk
#Include leafscends.ahk

global topMenuHotKeys = { gem:  "{F1}"
                        , cards: "{F5}" }

; Tower + Boss cycle
#IfWinActive Leaf Blower Revolution
Numpad0::
{
  Loop {
    DelayedSend(hotKeys.artifacts.blazingSkull)
    DelayedSend(hotKeys.artifacts.wind)
    BossCycle()
    ; GemTradeLoop()
  }
}

; Witch + Violin farm
Numpad1::
{
  Loop {
    ; Attempt to cycle bosses
    WitchCycleWithCount()
    BrewDE()
    ; Spawn fruit and use extra violins
    DelayedSend(hotKeys.artifacts.fruit)
    DelayedSend(hotKeys.artifacts.violin)
    ; Find and use violin
    FindViolin()
    DelayedSend(hotKeys.artifacts.violin)
  }
}

; Gem trade testing
Numpad2::
{
  Loop {
    DelayedSend(hotKeys.artifacts.blazingSkull)
    DelayedSend(hotKeys.artifacts.wind)
    DelayedSend(hotKeys.artifacts.seedBag)
    GemTradeLoop()
  }
}

; Leafscend testing
Numpad3::
{
  past := A_TickCount
  Delay(2500)
  now := A_TickCount
  MsgBox, % past
  MsgBox, % now
  MsgBox, % now - past
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
