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
#Include trading.ahk

#IfWinActive Leaf Blower Revolution
Numpad2::
{
  GemTradeLoop()
  tradesCollected := 0
  Loop {
    if (TradesReady()) {
      tradesCollected := GemTradeLoop(tradesCollected)
    }
    if (tradesCollected >= 13) {
      ; Leafscend()
      ; RestockLeaves()
      tradesCollected := tradesCollected - 13
    }
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

Esc::
{
  Suspend
  ExitApp ;Escape key will exit... place this at the bottom of the script
}
