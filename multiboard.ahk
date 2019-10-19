; Multiboard
; Main entry point script
Multiboard := []
maxEntries := 10

RWin::
AppsKey::
	Gui, Destroy

	GoSub addClipboardToMultiboard

	if (Multiboard.Length() = 0) {
		Msgbox, Multiboard is Empty
		Return
	}

	for index,storedText in Multiboard
		Gui, Add, Button, v%index% gcopyFromMultiboard, %storedText%

	Gui, Show
	Return

copyFromMultiboard:
	text := Multiboard[A_GuiControl]
	clipboard := text

	Gui, Destroy
	Return

; "Multiboard" should be a Set of Strings that we limit the size of
addClipboardToMultiboard:
	for index,storedText in Multiboard {
		if (storedText = clipboard)
			Return
	}

	Multiboard.Push(clipboard)
	if (Multiboard.Length() > maxEntries) 
		Multiboard.removeAt(1)

	Return


