#SingleInstance, Force
#Include, Resources.ahk
SendMode Input
SetWorkingDir, %A_ScriptDir%

AFKFight() {
    Loop {
            if (A_TickCount > lastNormalAttack + normalAttackCooldown) {
                WinGet, lastActive,, A
                OutputDebug, % lastActive
                WinActivate, Cabal
                WinActivate, Cabal
                lastNormalAttack := A_TickCount
                ChangeTarget()
                Send, % normalAttackKey
                WinActivate ahk_id %lastActive%
                WinActivate ahk_id %lastActive%
        }
    }
}

Fight() {
    Loop {
        if TimeToLoot() {
            lootTimer := A_TickCount + lootTimer
            ClearTarget()
            WaitExtra(5000)
            LootAround()
            if CheckIfEmptyNeeded() {
                CloseAllNotificatons()
                CloseAllPopUps()
                OpenWhiteSocks()
                ClearInventory()
            }
        }
        FocusTarget()
        DoNormalAttack()
        Loot()
    }
}

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

OpenWhiteSocks() {
    inventoryStartCoord := GetInventorySlotCoord(1, 1, 0)
    inventoryEndCoord := GetInventorySlotCoord(8, 8, 2)
    currentInventoryTab := 1
    Loop, % inventoryTabsToUse {
        SelectInventoryTab(currentInventoryTab)
        Sleep, 1000
        ;OutputDebug, % ImgExists([inventoryStartCoord, inventoryEndCoord], 70, ImgPathToString(whiteSockIcon[1], whiteSockIcon[2]))
        ;OutputDebug, % inventoryStartCoord[1] ", " inventoryStartCoord[2] " | " inventoryEndCoord[1] ", " inventoryEndCoord[2]
        ;OutputDebug, % ImgPathToString(whiteSockIcon[1], whiteSockIcon[2])
        While ImgExists([inventoryStartCoord, inventoryEndCoord], 70, ImgPathToString(whiteSockIcon[1], whiteSockIcon[2])) {
            socksCoords := GetImgCoords([inventoryStartCoord, inventoryEndCoord], 70, ImgPathToString(whiteSockIcon[1], whiteSockIcon[2]), 0)
            MouseClick, Right, socksCoords[1], socksCoords[2], 1, 0
            WaitExtra()
            SelectInventoryTab(currentInventoryTab)
        }
        currentInventoryTab++
    }
    ReceiveTempInventory()
    CloseTempInventory()
}