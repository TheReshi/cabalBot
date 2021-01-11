#SingleInstance, Force
#Include, Resources.ahk
SendMode Input
SetWorkingDir, %A_ScriptDir%


ClearInventory() {
    OpenInventory()
    Loop, % inventoryTabsToUse {
        xSlot := 1
        ySlot := 8
        currentInventoryTab := A_Index
        SelectInventoryTab(currentInventoryTab)
        Loop, 8 {
            Loop, 8 {
                inventorySlotCenter := GetInventorySlotCoord(xSlot, ySlot, 1)
                slotState := ObjectExists([GetInventorySlotCoord(xSlot, ySlot, 0), GetInventorySlotCoord(xSlot, ySlot, 2)], ImgPathToString("inventory", xSlot + (ySlot - 1) * 8 . ".png"), 50)
                if slotState {
                    ;OutputDebug, % "Slot " xSlot ", " ySlot " (" xSlot + (ySlot - 1) * 8 ") is: empty."
                } else {
                    ;OutputDebug, % "Slot " xSlot ", " ySlot " (" xSlot + (ySlot - 1) * 8 ") is: filled."
                    ClearItem(currentInventoryTab, inventorySlotCenter)
                }
                ySlot--
            }
            xSlot++
            ySlot := 8
        }
    }
}