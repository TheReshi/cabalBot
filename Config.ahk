#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Client
CoordMode, Pixel, Client


;Globals
;==================================================
global secureLoops := 3
global extraTime := 50


;Areas
;==================================================
global inventoryTitleArea := [[1570, 0], [1920, 45]]
global shopTitleArea := [[0, 85], [350, 125]]
global warehouseTitleArea := [[0, 0], [350, 45]]
global chatArea := [[0, 855], [555, 895]]
global notificationArea := [[1885, 300], [1920, 830]]
global popUpArea := [[1885, 300], [1920, 830]]
global massMoveArea := [[740, 400], [1175, 440]]
global moveButtonArea := [[895, 580], [1030, 650]]
global tempInventoryButtonArea := [[890, 710], [1200, 755]]


;Keys
;==================================================
global inventoryKey := "{i}"
global remoteShopKey := "{n}"
global closePaneKey := "{Escape}"


;Inventory
;==================================================
global inventoryTabsToUse := 3
global inventorySlotToFull := [1, 3]
global warehouseCard := [4, 1, 8]
global inventoryTabCoord := [1615, 465]
global inventoryTabGap := 78
global inventorySlotCoord := [1589, 488]
global inventorySlotSize := 39


;UI icons name
;==================================================
global popUpIcon := ["ui", "tick.png"]
global notificationIcon := ["ui", "dismiss.png"]
global chatIcon := ["ui", "chaticon.png"]
global warehouseIcon := ["ui", "warehouse.png"]
global shopIcon := ["ui", "shop.png"]
global inventoryIcon := ["ui", "inventory.png"]
global itemSaleIcon := ["ui", "itemsale.png"]
global massMoveButtonIcon := ["ui", "massmove_ok.png"]
global itemStoreIcon := ["ui", "storeitems.png"]
global receiveTempInventoryButtonIcon := ["ui", "receiveall.png"]
global closeTempInventoryButtonIcon := ["ui", "close.png"]


;Other icons
;==================================================
global whiteSockIcon := ["items\misc", "whitesock2.png"]


;Paths
;==================================================
global imgPath := % A_ScriptDir . "\resources\imgs\"

/*
;Multi-monitor support
;==================================================
xDiff := -1920
yDiff := 0

;Conversions
doubleCoordsToConvert := [inventoryTitleArea, shopTitleArea, warehouseTitleArea, chatArea, notificationArea, popUpArea, massMoveArea, moveButtonArea, tempInventoryButtonArea]
singleCoordsToConvert := [inventoryTabCoord, inventorySlotCoord]

For key, area in doubleCoordsToConvert {
    OutputDebug, % key . ". before: " . area[1][1] . ", " . area[1][2] . " - " . area[2][1] . ", " . area[2][2]
    area[1][1] += xDiff
    area[1][2] += yDiff
    area[2][1] += xDiff
    area[2][2] += yDiff
    OutputDebug, % key . ". after: " . area[1][1] . ", " . area[1][2] . " - " . area[2][1] . ", " . area[2][2]
}

For key, area in singleCoordsToConvert {
    OutputDebug, % key . ". before: " . area[1] . ", " . area[2]
    area[1] += xDiff
    area[2] += yDiff
    OutputDebug, % key . ". after: " . area[1] . ", " . area[2]
}
*/