#SingleInstance, Force
#Include, Actions.ahk
SetWorkingDir, %A_ScriptDir%
SendMode, Event
SetKeyDelay, 25, 25
SetMouseDelay, 50
SetDefaultMouseSpeed, 0

Home::
ActivateCabal()
CheckInventorySlots()
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
CheckInventorySlots()


PgDn::
ExitApp
return

WaitSome() {
    Sleep, 500
}