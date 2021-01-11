#SingleInstance, Force
#Include, Config.ahk
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Client
CoordMode, Pixel, Client

GetInventorySlotNum(xSlot, ySlot) {
    return xSlot + (ySlot - 1) * 8
}

CheckIfEmptyNeeded() {
    ;[1, 3]
    emptyNeeded := False
    slotX := inventorySlotToFull[1]
    slotY := inventorySlotToFull[2]
    Loop, % 9 - slotX {
        Loop, % 9 - slotY {
            slotNum := GetInventorySlotNum(slotX, slotY)
            emptyNeeded := emptyNeeded Or !ObjectExists([GetInventorySlotCoord(slotX, slotY, 0), GetInventorySlotCoord(slotX, slotY, 2)], ImgPathToString("inventory", slotNum . ".png"), 50)
            OutputDebug, % slotX ", " slotY
            if emptyNeeded {
                return True
            }
            slotY++
        }
        slotX++
        slotY := inventorySlotToFull[2]
    }
    return False
}

CloseTempInventory() {
    if TempInventoryCloseExists() {
        closeButtonCoords := GetImgCoords(tempInventoryButtonArea, 50, ImgPathToString(closeTempInventoryButtonIcon[1], closeTempInventoryButtonIcon[2]), 0)
        MouseClick, Left, closeButtonCoords[1], closeButtonCoords[2], 1, 0
    }
}

ReceiveTempInventory() {
    if TempInventoryReceiveAllExists() {
        receiveAllButtonCoords := GetImgCoords(tempInventoryButtonArea, 50, ImgPathToString(receiveTempInventoryButtonIcon[1], receiveTempInventoryButtonIcon[2]), 0)
        MouseClick, Left, receiveAllButtonCoords[1], receiveAllButtonCoords[2], 1, 0
    }
}

TempInventoryCloseExists() {
    return ObjectExists(tempInventoryButtonArea, ImgPathToString(closeTempInventoryButtonIcon[1], closeTempInventoryButtonIcon[2]))
}

TempInventoryReceiveAllExists() {
    return ObjectExists(tempInventoryButtonArea, ImgPathToString(receiveTempInventoryButtonIcon[1], receiveTempInventoryButtonIcon[2]))
}

OpenWhiteSocks() {
    inventoryStartCoord := GetInventorySlotCoord(1, 1, 0)
    inventoryEndCoord := GetInventorySlotCoord(8, 8, 2)
    currentInventoryTab := 1
    Loop, % inventoryTabsToUse {
        SelectInventoryTab(currentInventoryTab)
        Sleep, 1000
        OutputDebug, % ImgExists([inventoryStartCoord, inventoryEndCoord], 70, ImgPathToString(whiteSockIcon[1], whiteSockIcon[2]))
        OutputDebug, % inventoryStartCoord[1] ", " inventoryStartCoord[2] " | " inventoryEndCoord[1] ", " inventoryEndCoord[2]
        OutputDebug, % ImgPathToString(whiteSockIcon[1], whiteSockIcon[2])
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

StoreItems(inventoryTab, slotCoord) {
    OpenInventory()
    OpenWarehouse()
    SelectInventoryTab(inventoryTab)
    Send, {Alt down}
    MouseClick, Left, slotCoord[1], slotCoord[2], 1, 0
    Send, {Alt up}
    itemStoreState := ItemStoreExists()
    While !itemStoreState {
        StoreItems(inventoryTab, slotCoord)
        itemStoreState := ItemStoreExists()
    }
    MultipleStore()
}

ClearItem(inventoryTab, slotCoord) {
    LinkItemToChat(slotCoord)
    itemForKeep := DecideChatItem()
    if !itemForKeep {
        SellItems(slotCoord)
    } else {
        StoreItems(inventoryTab, slotCoord)
    }
}

ItemStoreExists() {
    return ObjectExists(massMoveArea, ImgPathToString(itemStoreIcon[1], itemStoreIcon[2]))
}

ItemSaleExists() {
    return ObjectExists(massMoveArea, ImgPathToString(itemSaleIcon[1], itemSaleIcon[2]))
}

MultipleStore() {
    moveButton := GetImgCoords(moveButtonArea, 50, ImgPathToString(massMoveButtonIcon[1], massMoveButtonIcon[2]), 0)
    MouseClick, Left, moveButton[1], moveButton[2], 1, 0
    WaitExtra()
}

SellItems(slotCoord) {
    OpenInventory()
    OpenShop()
    Send, {Alt down}
    MouseClick, Left, slotCoord[1], slotCoord[2], 1, 0
    Send, {Alt up}
    itemSaleState := ItemSaleExists()
    While !itemSaleState {
        SellItems(slotCoord)
        itemSaleState := ItemSaleExists()
    }
    MultipleStore()
}

DecideChatItem() {
    itemIsGood := False
    itemsPath := % imgPath . "items\keep\*.*"
    Loop, Files, % itemsPath
    {
        Loop, % secureLoops {
            itemIsGood := itemIsGood Or ImgExists(chatArea, 50, ImgPathToString("items\keep", A_LoopFileName))
        }
    }
    CloseChat()
    if itemIsGood {
        OutputDebug, % "Good, keep! (" . A_LoopFileName . ")"
        return True
    }
    OutputDebug, % "Nope, sell. (" . A_LoopFileName . ")"
    return False
}

LinkItemToChat(slotCoord) {
    Send, {Control down}
    MouseClick, Right, slotCoord[1], slotCoord[2], 1, 0
    Send, {Control up}
}

SelectInventoryTab(inventoryTab) {
    OpenInventory()
    tabCoords := GetInventoryTabCoord(inventoryTab)
    MouseClick, Left, tabCoords[1], tabCoords[2], 1, 0
}

GetInventorySlotCoord(xSlot, ySlot, position) {
    treshold := 5
    slotStartPosition := [inventorySlotCoord[1] + inventorySlotSize * (xSlot - 1) - treshold, inventorySlotCoord[2] + inventorySlotSize * (ySlot - 1) - treshold]
    if (position = 0) {
        return slotStartPosition
    } else if (position = 1) {
        return [Round(slotStartPosition[1] + inventorySlotSize / 2) + treshold, Round(slotStartPosition[2] + inventorySlotSize / 2) + treshold]
    } else {
        return [slotStartPosition[1] + inventorySlotSize + 2 * treshold, slotStartPosition[2] + inventorySlotSize + 2 * treshold]
    }
}

CloseAllPopUps() {
    popUpState := PopUpsExists()
    While popUpState {
        imgCoords := GetImgCoords(popUpArea, 50, ImgPathToString(popUpIcon[1], popUpIcon[2]), 0)
        MouseClick, Left, imgCoords[1], imgCoords[2], 1, 0
        popUpState := PopUpsExists()
    }
}

CloseAllNotificatons() {
    notificationState := NotificationsExist()
    While notificationState {
        imgCoords := GetImgCoords(notificationArea, 50, ImgPathToString(notificationIcon[1], notificationIcon[2]), 0)
        MouseClick, Left, imgCoords[1], imgCoords[2], 1, 0
        notificationState := NotificationsExist()
    }
}

GetInventoryTabCoord(inventoryTab) {
    return [inventoryTabCoord[1] + inventoryTabGap * (inventoryTab - 1), inventoryTabCoord[2]]
}

CloseChat() {
    chatState := ChatExists()
    While chatState {
        Send, {Escape}
        chatState := ChatExists()
    }
}

CloseWarehouse() {
    warehouseState := ShopExists()
    While warehouseState {
        Send, % closePaneKey
        warehouseState := ShopExists()
    }
}

OpenWarehouse() {
    warehouseState := WarehouseExists()
    While !warehouseState {
        SelectInventoryTab(warehouseCard[1])
        warehouseCardCoords := GetInventorySlotCoord(warehouseCard[2], warehouseCard[3], 1)
        MouseClick, Right, warehouseCardCoords[1], warehouseCardCoords[2], 1, 0
        warehouseState := WarehouseExists()
    }
    OpenInventory()
}

CloseShop() {
    shopState := ShopExists()
    While shopState {
        Send, % closePaneKey
        shopState := ShopExists()
    }
}

OpenShop() {
    shopState := ShopExists()
    While !shopState {
        Send, % remoteShopKey
        shopState := ShopExists()
    }
    OpenInventory()
}

CloseInventory() {
    inventoryState := InventoryExists()
    While inventoryState {
        Send, % closePaneKey
        inventoryState := InventoryExists()
    }
}

OpenInventory() {
    inventoryState := InventoryExists()
    While !inventoryState {
        Send, % inventoryKey
        inventoryState := InventoryExists()
    }
}

PopUpsExists() {
    return ObjectExists(popUpArea, ImgPathToString(popUpIcon[1], popUpIcon[2]))
}

NotificationsExist() {
    return ObjectExists(notificationArea, ImgPathToString(notificationIcon[1], notificationIcon[2]))
}

ChatExists() {
    return ObjectExists(chatArea, ImgPathToString(chatIcon[1], chatIcon[2]))
}

WarehouseExists() {
    return ObjectExists(warehouseTitleArea, ImgPathToString(warehouseIcon[1], warehouseIcon[2]))
}

ShopExists() {
    return ObjectExists(shopTitleArea, ImgPathToString(shopIcon[1], shopIcon[2]))
}

InventoryExists() {
    return ObjectExists(inventoryTitleArea, ImgPathToString(inventoryIcon[1], inventoryIcon[2]))
}

ObjectExists(area, imgName, variation := 50) {
    result := False
    Loop, % secureLoops {
        result := result Or ImgExists(area, 50, imgName)
    }
    return result
}

GetImgCoords(coordArray, variation, imgName, position) {
    ImageSearch, FoundX, FoundY, coordArray[1][1], coordArray[1][2], coordArray[2][1], coordArray[2][2], % " *" . variation . " " . imgName
    if (position = 0) {
        CenterImgSrchCoords(imgName, ByRef FoundX, ByRef FoundY)
    }
    return [FoundX, FoundY]
}

ImgExists(coordArray, variation, imgName) {
    ImageSearch, FoundX, FoundY, coordArray[1][1], coordArray[1][2], coordArray[2][1], coordArray[2][2], % " *" . variation . " " . imgName
    if (ErrorLevel = 0) {
        return True
    }
    return False
}

CenterImgSrchCoords(imgFile, ByRef FoundX, ByRef FoundY)
{
    static myPic
    Gui, imageDim: New
    Gui, imageDim:add, picture, vmyPic, %imgFile%
    GuiControlGet, myPic, imageDim:Pos
    gui, imageDim:destroy
    
    FoundX += Floor(myPicW/2)
    FoundY += Floor(myPicH/2)
    return True
}

ActivateCabal() {
    if !WinActive("Cabal") {
        WinActivate, Cabal
        WinActivate, Cabal
    }
}

WaitExtra(extraWait := 0) {
    if (extraWait = 0) {
        Sleep, % extraTime
    } else {
        Sleep, % extraWait
    }
}

ImgPathToString(folder, imgName) {
    return imgPath . folder . "\" . imgName
}