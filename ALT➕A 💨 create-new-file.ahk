; 💙 version 1: https://gist.github.com/aubricus/1148174

; create new file

; installation:
; 1. you must be running autohotkey: http://www.autohotkey.com
; 2. double click on script to run
; [pro-tip] add this script to your startup folder to run when windows start
; [pro-top] you can add this script to another .ahk script file.

; hotkey is set to control + alt + n
; more on hotkeys: http://www.autohotkey.com/docs/Hotkeys.htm
; ^!n::

; script will automatically use its current directory as its "working directory"
; to get the file to appear in the active directory we have to extract
; the full path from the window.

; 💙 version 3: https://github.com/syon/ahk/blob/master/NewFile/NewFile.ahk
; 💚 !n = Alt+N

; 💙 version 4: https://github.com/syon/ahk/blob/master/.github.com/diastremskii/4bc8c8f4965a9f53318aca9b9d26fe53
; This is part of my AutoHotKey [1] script. When you are in Windows Explorer it
; allows you to press Alt+N and type a filename, and that file is created
; in the current directory and opened in the appropriate editor (usually
; [gVim](http://www.vim.org/) in my case, but it will use whatever program is
; associated with the file in Windows Explorer).

; This is much easier than the alternative that I have been using until now:
; Right click > New > Text file, delete default filename and extension (which
; isn't highlighted in Windows 7), type the filename, press enter twice.
; (Particularly for creating dot files like ".htaccess".)

; Credit goes to aubricus [2] who wrote most of this and davejamesmiller [3] who
; added the 'IfWinActive' check and 'Run %UserInput%' at the end. Also to
; syon [4] who changed regexp to make script work on non-english versions
; of Windows.

; @diastremskii: "And I changed the way how script gets full path to make it
: compatible with Windows 10"
; me: what ??? there is not a single line related to this mention.

; @diastremskii: and also changed hotkey to Alt+N
; me: this was the only change -> !SC031::

; [1]: http://www.autohotkey.com/
; [2]: https://gist.github.com/1148174
; [3]: https://gist.github.com/1965432
; [4]: https://github.com/syon/ahk/blob/master/NewFile/NewFile.ahk

; Only run when Windows Explorer or Desktop is active
; Alt+N
#IfWinActive ahk_class CabinetWClass
!SC031::
#IfWinActive ahk_class ExploreWClass
!SC031::
#IfWinActive ahk_class Progman
!SC031::
#IfWinActive ahk_class WorkerW
!SC031::

    ; get full path from open explorer window
    WinGetText, FullPath, A

    ; split up result (returns paths seperated by newlines)
    StringSplit, PathArray, FullPath, `n

	; Find line with backslash which is the path
	Loop, %PathArray0%
    {
        StringGetPos, pos, PathArray%a_index%, \
        if (pos > 0) {
            FullPath:= PathArray%a_index%
            break
        }
    }

    ; clean up result
    FullPath := RegExReplace(FullPath, "(^.+?: )", "")
	StringReplace, FullPath, FullPath, `r, , all

    ; change working directory
    SetWorkingDir, %FullPath%

    ; an error occurred with the SetWorkingDir directive
    If ErrorLevel
        Return

    ; Display input box for filename
    InputBox, UserInput, New File, , , 400, 100, , , , ,

    ; User pressed cancel
    If ErrorLevel
        Return

    ; Create file
    FileAppend, , %UserInput%

    ; Open the file in the appropriate editor
    ;Run %UserInput%

    Return

#IfWinActive
