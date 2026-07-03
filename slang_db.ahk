#Requires AutoHotkey v2.0
#SingleInstance Force

; -----------------------------------------------------------------------------
; SECTION: CONFIGURATION & LOCAL MEMORY LAYER
; -----------------------------------------------------------------------------
IniFilePath := A_ScriptDir "\slang_db.ini"

; Initialize persistent database arrays at script startup
LoadSavedSlangWords()

; Global shortcut combo to call up your management GUI: [ Ctrl + Shift + A ]
^+a::OpenSlangManagerGUI()

; -----------------------------------------------------------------------------
; SECTION: POPULAR DEFAULT SLANG BASES (Case-Sensitive, Space Triggered)
; -----------------------------------------------------------------------------
; Options Used:
; :C: = Case-sensitive (strictly ignores capital inputs)
; :*0: = Requires an ending key (like Spacebar) to fire, keeping text entry safe.
#Hotstring C *0

; Text Shortcuts Baseline
::luv::love
::btw::by the way
::idk::"I don't know"
::omw::on my way
::brb::be right back
::tbh::to be honest
::asap::as soon as possible
::fyi::for your information
::ttyl::talk to you later
::rn::right now
::fr::for real
::ngl::not gonna lie

; Numerical/Mixed Shortcuts Baseline Examples
::2b::to be
::4u::for you
::10q::thank you
::b4::before
::gr8::great
::l8r::later

; -----------------------------------------------------------------------------
; SECTION: INTERACTIVE MANAGEMENT DASHBOARD ENGINE
; -----------------------------------------------------------------------------
OpenSlangManagerGUI() {
    static SlangGui := ""
    
    if (SlangGui != "") {
        SlangGui.Show()
        return
    }

    SlangGui := Gui("+AlwaysOnTop -MaximizeBox", "Add Slang or Number Macro")
    SlangGui.SetFont("s10", "Segoe UI")
    
    SlangGui.Add("Text", "w280", "Short Shortcut (Lowercase letters / Numbers allowed):")
    EditShort := SlangGui.Add("Edit", "w280 r1 Lowercase") 
    
    SlangGui.Add("Text", "w280 y+10", "Full Target Expanded Word/Phrase:")
    EditFull := SlangGui.Add("Edit", "w280 r1")
    
    BtnSave := SlangGui.Add("Button", "w130 y+15 x15 Default", "Save Permanent")
    BtnCancel := SlangGui.Add("Button", "w130 yp x+10", "Close Panel")
    
    BtnCancel.OnEvent("Click", (*) => HideAndClear())
    SlangGui.OnEvent("Close", (*) => HideAndClear())
    BtnSave.OnEvent("Click", (*) => ProcessSaveAction())

    HideAndClear() {
        SlangGui.Hide()
        EditShort.Value := ""
        EditFull.Value := ""
    }

    ProcessSaveAction() {
        ShortVal := Trim(EditShort.Value)
        FullVal := Trim(EditFull.Value)

        if (ShortVal == "" || FullVal == "") {
            MsgBox("Error: Both text fields must contain characters before saving.", "Input Error", "Icon!")
            return
        }

        ; Case Guard check
        if (RegExMatch(ShortVal, "[A-Z]")) {
            MsgBox("Error: Capital letters detected. Please restrict shortcuts to small letters and numbers only.", "Case Lock Alert", "Icon!")
            return
        }

        ; AUTOMATIC QUOTATION ENFORCEMENT LAYER:
        ; If the text contains an apostrophe ('), we automatically wrap the entire output string 
        ; in literal double quotes ("") so the final expansion preserves your layout design.
        ProcessedFull := FullVal
        if (InStr(FullVal, "'")) {
            ; Check if it isn't already wrapped in quotes to prevent double-wrapping
            if (SubStr(FullVal, 1, 1) != '"' && SubStr(FullVal, -1) != '"') {
                ProcessedFull := '"' . FullVal . '"'
            }
        }

        ; Write directly to your local ini flat data file
        IniWrite(ProcessedFull, IniFilePath, "SlangList", ShortVal)
        
        ; Register macro directly into your running background keyboard engine
        Hotstring(":C *0::" ShortVal, ProcessedFull)
        
        MsgBox("Saved: '" ShortVal "' will now expand to '" ProcessedFull "'", "Success", "Iconi T1")
        HideAndClear()
    }

    SlangGui.Show("w310")
}

; -----------------------------------------------------------------------------
; SECTION: INITIALIZER SEED ROUTINE
; -----------------------------------------------------------------------------
LoadSavedSlangWords() {
    if !FileExist(IniFilePath)
        return

    try {
        PairsText := IniRead(IniFilePath, "SlangList")
        
        Loop Parse, PairsText, "`n", "`r" {
            if (A_LoopField == "")
                continue
                
            SplitPos := InStr(A_LoopField, "=")
            if (SplitPos > 0) {
                SavedShort := SubStr(A_LoopField, 1, SplitPos - 1)
                SavedFull := SubStr(A_LoopField, SplitPos + 1)
                
                ; Hydrate background hotstrings into active system memory safely
                Hotstring(":C *0::" SavedShort, SavedFull)
            }
        }
    } catch {
        ; Quietly bypass empty initialization layers without throwing errors
    }
}
