#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Client
CoordMode, Pixel, Client

;Globals
;==================================================
global secureLoops := 3
global waitForAction := 50

;Areas
;==================================================
global inventoryTitleArea := [[1570, 0], [1920, 45]]
global shopTitleArea := [[0, 85], [350, 125]]
global warehouseTitleArea := [[0, 0], [350, 45]]
global chatArea := [[0, 855], [555, 895]]
global notificationArea := [[1885, 300], [1920, 830]]
global popUpArea := [[1885, 300], [1920, 830]]

;Keys
;==================================================
global inventoryKey := "{i}"
global remoteShopKey := "{n}"
global closePaneKey := "{Escape}"

;Inventory
;==================================================
global warehouseCard := [4, 8, 1]
global inventoryTabCoord := [1615, 465]
global inventoryTabGap := 78
global inventorySlotCoord := [1589, 488]
global inventorySlotSize := 39

;UI icons name
;==================================================
global notificationIcon := ["tick", "dismiss"]