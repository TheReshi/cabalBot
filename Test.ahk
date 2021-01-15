#NoEnv
Gui, +AlwaysOnTop +Border -Caption +HwndhGui +ToolWindow +E0x08000000
Gui, Margin, 20, 20
Gui, Add, Button,          w150 gSendChr, a
Gui, Add, Button,       ym wp   gSendChr, h
Gui, Add, Button,       ym wp   gSendChr, k
Gui, Add, Button, xm       wp   vMove, Move
Gui, Add, Button, x+190 yp wp   gGuiClose, Exit
Gui, Show, NA, On Screen Keyboard Demo
OnMessage(0x0201, "WM_LBUTTONDOWN")
Return