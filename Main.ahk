#SingleInstance, Force
#Include, Actions.ahk
SetWorkingDir, %A_ScriptDir%
SendMode, Event
SetKeyDelay, 50, 30
SetMouseDelay, 50
SetDefaultMouseSpeed, 0

Home::
ActivateCabal()
CheckIfEmptyNeeded()
return

End::
ActivateCabal()
ClearInventory()
return

PgUp::
ActivateCabal()
CloseWarehouse()
OpenInventory()
CloseInventory()
OpenShop()
CloseShop()
CloseAllNotificatons()
CloseAllPopUps()
OpenInventory()
ClearInventory()
ExitApp
return


PgDn::
ExitApp
return

WaitSome() {
    Sleep, 500
}