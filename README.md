# 🚀 Windows Study & Productivity Automation Suite

A collection of high-efficiency, native **AutoHotkey v2** automation utilities designed to eliminate friction from digital study workflows, textbook research, and operating system clutter. 

These scripts require zero external dependencies, run silently in the background, and hook directly into native Windows subsystem actions to transform how you extract text logs, expand typing shortcuts, and manage files.

---

## 🛠️ Feature Matrix & Shortcut Registry

| Feature Module | Shortcut Trigger | System Action | Target Applications |
| :--- | :--- | :--- | :--- |
| **Quick Slang Manager** | `Ctrl` + `Shift` + `A` | Opens an interactive dashboard to instantly save text expansions, contractions, or numeric macros permanently into your typing library. | Universal (Any Text Input) |
| **Folder Alchemist Cleaner** | `Ctrl` + `Shift` + `O` | Scans the active File Explorer window and groups loose files into IDM-styled folders while silently deleting redundant duplicate downloads. | Windows File Explorer |
| **Dynamic CSV Extraction Wizard** | `Alt` + `Z` | Intercepts highlighted text, automatically runs regular expression pattern checking, and opens a dialog to route snippets into custom-structured spreadsheets. | Okular, Adobe Reader, Web Browsers, Word |

---

## 💎 Workflow Deep Dives

### 📂 1. Folder Alchemist Cleaner
Tired of a messy `Downloads` folder? This engine handles file triage instantly based on smart file structural rules:
* **Documents & E-Books:** Intelligently groups standard documents (`.pdf`, `.docx`, `.txt`) alongside database, data-matrix, and book extensions (`.epub`, `.mobi`, `.db`, `.json`, `.sql`).
* **Smart Duplication Purge:** Runs a physical byte-size matching check. If a file is a naming duplicate *and* matches sizes exactly, the duplicate is dropped automatically to reclaim storage space. If the name matches but sizes differ, it appends a chronological timestamp to preserve both files.

### 📊 2. Dynamic CSV Extraction Wizard
A specialized data pipeline built to capture facts, study notes, or questions directly out of textbook layouts straight into tracking sheets:
* **Custom Separators:** Configurable setup interface allowing you to choose between standard Commas ( `,` ), Semicolons ( `;` ), or physical Tabs ( `\t` ).
* **Hybrid Regex Automation:** Automatically detects target data patterns (like emails, phone numbers, or key indices) out of your highlighted blocks and maps them into pre-configured columns before you hit commit.

---

## 🚀 Getting Started

### Prerequisites
* **Windows OS** (10 or 11)
* **AutoHotkey v2.0+** installed on your system. You can get the official engine from [autohotkey.com](https://www.autohotkey.com/).

### Installation & Deployment
1. Clone or download the script files (`.ahk`) from this repository to a secure location on your local machine.
2. Double-click your preferred script file to launch it.
3. A small green **H** icon will appear in your Windows system tray near the clock, showing that the tools are active and listening.
4. **Pro-Tip (Auto-Start):** Press `Win + R`, type `shell:startup`, and hit Enter. Move a shortcut of your `.ahk` script into this folder to ensure your workflow engine boots up automatically every time you start your computer.

### ⚠️ System Compatibility Notes
* **CSV Locking:** Always ensure your target `.csv` file is closed in Excel or LibreOffice while using the extraction tools. Spreadsheet engines lock files globally, which will prevent the background script from appending data rows.
* **Text Selection:** The extraction scraper relies on native text reading controls. Scanned PDFs containing flat graphics must be processed through an Optical Character Recognition (OCR) layer before text blocks can be captured.

---
License: MIT - Free to use, modify, and distribute for personal or academic workflows.
