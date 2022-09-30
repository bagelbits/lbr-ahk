#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

#Include %A_ScriptDir%\helpers
#Include utils.ahk
#Include trading.ahk

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
