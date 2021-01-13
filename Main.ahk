#SingleInstance, Force
#Include, Actions.ahk
SetWorkingDir, %A_ScriptDir%
SendMode, Event
SetKeyDelay, %keyDelay%, %pressDuration%
SetMouseDelay, %mouseDelay%
SetDefaultMouseSpeed, 0


CustomColor := "000000"  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s12  ; Set a large font size (32-point).
Gui, Add, Text, vMyText cFFFFFF, XXXXXXXXXXXXXXXXX YYYYYYYYYYYYYYYYYYYYYYYYY  ; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %CustomColor% 200
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
Gui, Show, x0 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.
return

UpdateOSD:
nextLoot := GetLootTimer()
;GuiControl,, MyText, % lootTimer + lootDelay - A_TickCount
GuiControl, Text, MyText, % nextLoot
return

PgDn::
Reload
return

Home::
ActivateCabal()
GetLootTimer()
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
