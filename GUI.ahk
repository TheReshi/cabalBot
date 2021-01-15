#SingleInstance, Force
#Include, Resources.ahk

;Menu, Tray, Icon, Shell32.dll, 3 ; Custom Icon pulled from Shell32
Menu, tray, tip, %A_ScriptName% ; Custom traytip

timerCount := 10 ; Change me
Gosub, GetCabalPos
Gosub, Sub_ShowOverlay
return

GetCabalPos:
WinGetPos, X, Y, W, H, Cabal
return

; Creates and shows the GUI
Sub_ShowOverlay:

Gui, GUI_Overlay:New, +ToolWindow +LastFound +AlwaysOnTop -Caption +hwndGUI_Overlay_hwnd +Disabled
Gui, Margin, 1, 1
Gui, Font, s10 q4, Segoe UI Bold
Gui, Add, Text, w135 h0 cWhite,
Gui, Add, Text, w135 Center vnextLoot cWhite,
Gui, Add, Text, w135 Center vnextBM cWhite,
Gui, Add, Text, w135 h27 Center vnextAura cWhite,
Gui, Color, 000000
WinSet, Transparent, 150
Gui, Show, Hide, Overlay

Gui, GUI_Overlay:Show

WinMove, X + W - 719, Y + H - 180 ; Change these values to move the window

SetTimer, Timer_Countdown, 1000
Gosub, Timer_Countdown
return

ShowOverlay:
return

; Does the countdown and updating of the timer
Timer_Countdown:
nextLoot := GetTimer(lootTimer)
nextBM := GetTimer(bm3Timer)
nextAura := GetTimer(auraTimer)

timerCount--
GuiControl, GUI_Overlay:, nextLoot, % " Loot: " nextLoot
GuiControl, GUI_Overlay:, nextBM, % " BM: " nextBM
GuiControl, GUI_Overlay:, nextAura, % " Aura: " nextAura
return