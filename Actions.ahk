#SingleInstance, Force
#Include, Resources.ahk
SendMode Input
SetWorkingDir, %A_ScriptDir%

SelectInventoryTab(inventoryTab) {
    OpenInventory()
    tabCoords := GetInventoryTabCoord(inventoryTab)
    MouseClick, Left, tabCoords[1], tabCoords[2], 1, 0
    WaitForAction()
}

CheckInventorySlots() {
    xSlot := 1
    ySlot := 8
    Loop, 8 {
        Loop, 8 {
            slotState := ObjectExists([GetInventorySlotCoord(xSlot, ySlot, 0), GetInventorySlotCoord(xSlot, ySlot, 2)], ImgPathToString("inventory", xSlot + (ySlot - 1) * 8), 50)
            if slotState {
                OutputDebug, % "Slot " xSlot ", " ySlot " (" xSlot + (ySlot - 1) * 8 ") is: empty."
            } else {
                OutputDebug, % "Slot " xSlot ", " ySlot " (" xSlot + (ySlot - 1) * 8 ") is: filled."
            }
            ySlot--
        }
        xSlot++
        ySlot := 8
    }
}