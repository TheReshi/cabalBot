#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Home::
WinGetActiveStats, Cabal, W, H, X, Y
MsgBox, 0, Asd, % W ", " H " and " X ", " Y
WinMove, Cabal,, 0, 0, 1936, 1066