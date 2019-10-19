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
	; First, check to make sure that the contents of the clipboard aren't already in Multiboard.
	; This means we iterate through the Array twice, once here and once to construct the GUI.
	; This is done intentionally since typically maxEntries will be small, and therefore the
	; time complexity added isn't significant. The alternative here is to use either an 
	; Associative Array or construct the GUI simulatneously. Neither of these makes for an easy
	; to understand or maintainable solution, so we prefer the inefficient one.
	for index,storedText in Multiboard {
		if (storedText = clipboard)
			Return
	}

	Multiboard.Push(clipboard)
	if (Multiboard.Length() > maxEntries) 
		Multiboard.removeAt(1)

	Return


