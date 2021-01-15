#SingleInstance, Force
#Include, GUI.ahk
#Include, Actions.ahk
SetWorkingDir, %A_ScriptDir%
SendMode, Event
SetKeyDelay, %keyDelay%, %pressDuration%
SetMouseDelay, %mouseDelay%
SetDefaultMouseSpeed, 0

PgDn::
Reload
return

Home::
ActivateCabal()
WinMove, Cabal,, 200, 0, 1920, 1050
return

End::
ActivateCabal()
FightBaldus()
return

PgUp::
CloseAllNotificatons()
CloseAllPopUps()
ActivateCabal()
OpenWarehouse()
CloseWarehouse()
OpenInventory()
CloseInventory()
OpenShop()
CloseShop()
OpenInventory()
if CheckIfEmptyNeeded() {
    OpenWhiteSocks()
    ClearInventory()
}
ExitApp
return

WaitSome() {
    Sleep, 500
}
