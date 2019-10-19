; Multiboard
; Main entry point script
Multiboard := []
maxEntries := 5
maxStringLength := 120
stringOverflowText := " [...]"

RWin::
AppsKey::
	if WinExist("Multiboard") {
		Gui, Destroy
		Return
	}

	; We still need to Destroy the Gui to avoid re-using variables
	Gui, Destroy

	Gui, Font, s14, Verdana 

	GoSub addClipboardToMultiboard

	if (Multiboard.Length() = 0) {
		Msgbox, Multiboard is Empty
		Return
	}

	for index,storedText in Multiboard {
		displayText := storedText
		if (StrLen(displayText) > maxStringLength) {
			displayText := SubStr(displayText, 1, maxStringLength) 
			displayText = %displayText%%stringOverflowText%
		}

		Gui, Add, Button, v%index% gcopyFromMultiboard left, %displayText%
	}
	Gui, Show, , Multiboard
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


