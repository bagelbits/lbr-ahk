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
global menuConfig := Yaml("config\menu.yaml")

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include bossCycle.ahk
#Include brewing.ahk
#Include artifact.ahk
#Include trading.ahk
#Include leafscend.ahk

global topMenuHotKeys = { gem:  "{F1}"
                        , cards: "{F5}" }

; Tower + Boss cycle
#IfWinActive Leaf Blower Revolution
Numpad0::
{
  artifactsToSpam = ["blazingSkull", "wind"]
  Loop {
    SpamArtifacts(artifactsToSpam)
    BossCycle()
    ; GemTradeLoop(artifactsToSpam)
  }
}

; Witch + Violin farm
Numpad1::
{
  DelayedSend(hotKeys.loadout.reroll)
  artifactsToSpam = ["fruit", "violin"]
  Loop {
    ; Attempt to cycle bosses
    WitchCycle(5)
    BrewDE()
    SpamArtifacts(artifactsToSpam)
    FindAndUseViolin()
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
  HitTheCounter()
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
