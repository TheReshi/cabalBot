#SingleInstance, Force
#Include, Actions.ahk
SetWorkingDir, %A_ScriptDir%
SendMode, Event
SetKeyDelay, %keyDelay%, %pressDuration%
SetMouseDelay, %mouseDelay%
SetDefaultMouseSpeed, 0

PgDn::
Pause
return

Home::
ActivateCabal()
AFKFight()
return

End::
ActivateCabal()
Fight()
return

PgUp::
CloseAllNotificatons()
CloseAllPopUps()
ActivateCabal()
OpenWarehouse()
CloseWarehouse()
OpenInventory()
CloseInventory()
OpenShop(),
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