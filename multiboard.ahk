; Multiboard
; Main entry point script
Multiboard := []

AppsKey::
	Gui, Destroy
	Multiboard.Push(clipboard)
	; TODO: Resize if necessary, n = 5?

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


