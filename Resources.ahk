#SingleInstance, Force
#Include, Config.ahk
SetWorkingDir, %A_ScriptDir%
SetMouseDelay, 50
SetDefaultMouseSpeed, 0
SetKeyDelay, 10000, 25
CoordMode, Mouse, Client
CoordMode, Pixel, Client

GetInventorySlotCoord(xSlot, ySlot, position) {
    treshold := 10
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
        imgCoords := GetImgCoords(popUpArea, 50, ImgPathToString("ui", "tick"), 0)
        MouseClick, Left, imgCoords[1], imgCoords[2], 1, 0
        popUpState := PopUpsExists()
    }
}

CloseAllNotificatons() {
    notificationState := NotificationsExist()
    While notificationState {
        imgCoords := GetImgCoords(notificationArea, 50, ImgPathToString("ui", "dismiss"), 0)
        MouseClick, Left, imgCoords[1], imgCoords[2], 1, 0
        notificationState := NotificationsExist()
    }
}

GetInventoryTabCoord(inventoryTab) {
    return [inventoryTabCoord[1] + inventoryTabGap * (inventoryTab - 1), inventoryTabCoord[2]]
}

CloseWarehouse() {
    warehouseState := ShopExists()
    While warehouseState {
        Send, % closePaneKey
        warehouseState := ShopExists()
    }
}

OpenWarehouse() {
    warehouseState := ShopExists()
    While !warehouseState {
        Send, % remoteShopKey
        warehouseState := ShopExists()
    }
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
    return ObjectExists(popUpArea, ImgPathToString("ui", "tick"))
}

NotificationsExist() {
    return ObjectExists(notificationArea, ImgPathToString("ui", "dismiss"))
}

ChatExists() {
    return ObjectExists(chatArea, ImgPathToString("ui", "chaticon"))
}

WarehouseExists() {
    return ObjectExists(warehouseTitleArea, ImgPathToString("ui", "warehouse"))
}

ShopExists() {
    return ObjectExists(shopTitleArea, ImgPathToString("ui", "shop"))
}

InventoryExists() {
    return ObjectExists(inventoryTitleArea, ImgPathToString("ui", "inventory"))
}

ObjectExists(area, imgName, variation := 50) {
    result := False
    Loop, % secureLoops {
        ErrorLevel := ImgExists(area, 50, imgName)
        if (ErrorLevel = 0) {
            result := True
        }
    }
    return result
}

GetImgCoords(coordArray, variation, imgName, position) {
    ImageSearch, FoundX, FoundY, coordArray[1][1], coordArray[1][2], coordArray[2][1], coordArray[2][2], % " *" . variation . " " . imgName
    if (position = 0) {
        CenterImgSrchCoords(ImgPathToString("ui", imgName), ByRef FoundX, ByRef FoundY)
    }
    return [FoundX, FoundY]
}

ImgExists(coordArray, variation, imgName) {
    ImageSearch, FoundX, FoundY, coordArray[1][1], coordArray[1][2], coordArray[2][1], coordArray[2][2], % " *" . variation . " " . imgName
    return ErrorLevel
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

WaitForAction() {
    Sleep, % waitForAction
}

ImgPathToString(folder, imgName) {
    return "E:\Scripts\Cabal\cabalBot\resources\imgs\" . folder . "\" . imgName . ".png"
}