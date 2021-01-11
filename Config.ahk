#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Globals
;==================================================
global secureLoops := 3
global extraTime := 50

;Multi-monitor support
;==================================================
xDiff := -1920
yDiff := 0

;Areas
;==================================================
global inventoryTitleArea := [[1570 - xDiff, 0 - yDiff], [1920 - xDiff, 45 - yDiff]]
global shopTitleArea := [[0 - xDiff, 85 - yDiff], [350 - xDiff, 125 - yDiff]]
global warehouseTitleArea := [[0 - xDiff, 0 - yDiff], [350 - xDiff, 45 - yDiff]]
global chatArea := [[0 - xDiff, 855 - yDiff], [555 - xDiff, 895 - yDiff]]
global notificationArea := [[1885 - xDiff, 300 - yDiff], [1920 - xDiff, 830 - yDiff]]
global popUpArea := [[1885 - xDiff, 300 - yDiff], [1920 - xDiff, 830 - yDiff]]
global massMoveArea := [[740 - xDiff, 400 - yDiff], [1175 - xDiff, 440 - yDiff]]
global moveButtonArea := [[895 - xDiff, 580 - yDiff], [1030 - xDiff, 650 - yDiff]]
global tempInventoryButtonArea := [[890 - xDiff, 710 - yDiff], [1200 - xDiff, 755 - yDiff]]

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
global inventoryTabCoord := [1615 - xDiff, 465 - yDiff]
global inventoryTabGap := 78
global inventorySlotCoord := [1589 - xDiff, 488 - yDiff]
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