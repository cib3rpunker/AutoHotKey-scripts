; 💙 https://gist.github.com/aubricus/1148174

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

; 💙 https://github.com/syon/ahk/blob/master/NewFile/NewFile.ahk
; 💚 !n = Alt+N

; Only run when Windows Explorer or Desktop is active
#IfWinActive ahk_class CabinetWClass
!n::
#IfWinActive ahk_class ExploreWClass
!n::
#IfWinActive ahk_class Progman
!n::
#IfWinActive ahk_class WorkerW
!n::

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
