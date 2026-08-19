; PATH handling. One entry, $INSTDIR\bin, holding a .cmd shim per executable.

!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "FileFunc.nsh"

!ifndef ENV_NSH_INCLUDED
!define ENV_NSH_INCLUDED

Var FT_PathUnsafe

!macro FT_ENV_FUNCTIONS un
Function ${un}FT_PathFilter
  Exch $R0
  Push $R1
  Push $R2
  Push $R3
  Push $R4
  Push $R5
  Push $R6
  Push $R7

  ReadRegStr $R1 HKCU "Environment" "Path"
  StrCmp $R1 "" filter_done

  StrLen $R7 $R1
  IntOp $R6 ${NSIS_MAX_STRLEN} - 2
  ${If} $R7 >= $R6
    StrCpy $FT_PathUnsafe 1
    DetailPrint "PATH is too long to modify safely; leaving it untouched."
    Goto filter_done
  ${EndIf}

  StrCpy $R2 ""
  StrCpy $R3 ""
  StrCpy $R5 0
  StrCpy $R6 0

filter_loop:
  StrCpy $R4 $R1 1 $R5
  StrCmp $R4 "" 0 filter_notend
    StrCpy $R6 1
    Goto filter_flush
filter_notend:
  IntOp $R5 $R5 + 1
  StrCmp $R4 ";" 0 filter_accum
    Goto filter_flush
filter_accum:
  StrCpy $R3 "$R3$R4"
  Goto filter_loop

filter_flush:
  StrCmp $R3 "" filter_after
  StrCmp $R3 $R0 filter_after
  StrCmp $R2 "" 0 filter_append
    StrCpy $R2 $R3
    Goto filter_after
filter_append:
  StrCpy $R2 "$R2;$R3"
filter_after:
  StrCpy $R3 ""
  StrCmp $R6 1 0 filter_loop

  WriteRegExpandStr HKCU "Environment" "Path" $R2

filter_done:
  Pop $R7
  Pop $R6
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Pop $R1
  Pop $R0
FunctionEnd
!macroend

!insertmacro FT_ENV_FUNCTIONS ""
!insertmacro FT_ENV_FUNCTIONS "un."

; Append the pushed dir.
Function FT_PathAppend
  Exch $R0
  Push $R1
  Push $R2
  Push $R3

  ${If} $FT_PathUnsafe == 1
    Goto append_done
  ${EndIf}

  Push $R0
  Call FT_PathFilter

  ${If} $FT_PathUnsafe == 1
    Goto append_done
  ${EndIf}

  ReadRegStr $R1 HKCU "Environment" "Path"
  StrLen $R2 $R1
  StrLen $R3 $R0
  IntOp $R2 $R2 + $R3
  IntOp $R2 $R2 + 2
  ${If} $R2 >= ${NSIS_MAX_STRLEN}
    StrCpy $FT_PathUnsafe 1
    DetailPrint "PATH would grow past what this build can handle; leaving it untouched."
    Goto append_done
  ${EndIf}

  ${If} $R1 == ""
    StrCpy $R1 "$R0"
  ${Else}
    StrCpy $R1 "$R1;$R0"
  ${EndIf}
  WriteRegExpandStr HKCU "Environment" "Path" $R1

append_done:
  Pop $R3
  Pop $R2
  Pop $R1
  Pop $R0
FunctionEnd

; Write $INSTDIR\bin\<name>.cmd for every .exe/.bat in the pushed dir.
Function FT_MakeShims
  Exch $9
  Push $8
  Push $7
  Push $6
  Push $5
  Push $4

  StrCpy $4 0

shim_pattern:
  ${If} $4 == 0
    FindFirst $8 $7 "$9\*.exe"
  ${Else}
    FindFirst $8 $7 "$9\*.bat"
  ${EndIf}

shim_loop:
  StrCmp $7 "" shim_pattern_done
  ${GetBaseName} "$7" $5
  ClearErrors
  FileOpen $6 "$INSTDIR\bin\$5.cmd" w
  ${IfNot} ${Errors}
    FileWrite $6 "@echo off$\r$\n"
    FileWrite $6 "setlocal$\r$\n"
    FileWrite $6 'set "PATH=$9;%PATH%"$\r$\n'
    FileWrite $6 'call "$9\$7" %*$\r$\n'
    FileClose $6
  ${EndIf}
  FindNext $8 $7
  Goto shim_loop

shim_pattern_done:
  FindClose $8
  IntOp $4 $4 + 1
  ${If} $4 < 2
    Goto shim_pattern
  ${EndIf}

  Pop $4
  Pop $5
  Pop $6
  Pop $7
  Pop $8
  Pop $9
FunctionEnd

Function FT_FindPython
  Exch $R1
  Push $R2
  Push $R3

  StrCpy $R0 ""
  IfFileExists "$R1\python.exe" 0 +3
    StrCpy $R0 "$R1\python.exe"
    Goto fp_done

  FindFirst $R2 $R3 "$R1\python*"
fp_loop:
  StrCmp $R3 "" fp_close
  IfFileExists "$R1\$R3\python.exe" 0 fp_next
    StrCpy $R0 "$R1\$R3\python.exe"
    Goto fp_close
fp_next:
  FindNext $R2 $R3
  Goto fp_loop
fp_close:
  FindClose $R2

fp_done:
  Pop $R3
  Pop $R2
  Pop $R1
FunctionEnd

; Writes $INSTDIR\bin\<name>.cmd for every .py in the pushed directory
Function FT_MakePyShims
  Exch $9
  Push $8
  Push $7
  Push $6
  Push $5
  Push $4

  ${GetParent} "$R0" $4

  FindFirst $8 $7 "$9\*.py"
py_loop:
  StrCmp $7 "" py_done
  ${GetBaseName} "$7" $5
  ClearErrors
  FileOpen $6 "$INSTDIR\bin\$5.cmd" w
  ${IfNot} ${Errors}
    FileWrite $6 "@echo off$\r$\n"
    FileWrite $6 "setlocal$\r$\n"
    FileWrite $6 'set "PATH=$4;$9;%PATH%"$\r$\n'
    FileWrite $6 '"$R0" "$9\$7" %*$\r$\n'
    FileClose $6
  ${EndIf}
  FindNext $8 $7
  Goto py_loop

py_done:
  FindClose $8
  Pop $4
  Pop $5
  Pop $6
  Pop $7
  Pop $8
  Pop $9
FunctionEnd

; Make every .py in DIR runnable by name. PYROOT is the WinPython root.
!macro FT_PyShims PYROOT DIR
  CreateDirectory "$INSTDIR\bin"
  Push "${PYROOT}"
  Call FT_FindPython
  ${If} $R0 == ""
    DetailPrint "WARNING: no python.exe under ${PYROOT}; script shims skipped."
  ${Else}
    DetailPrint "Building script shims using $R0"
    Push "${DIR}"
    Call FT_MakePyShims
  ${EndIf}
!macroend

!macro FT_EnvAddPath DIR
  Push "${DIR}"
  Call FT_PathAppend
!macroend

!macro FT_EnvRemovePath DIR
  Push "${DIR}"
  Call un.FT_PathFilter
!macroend

!macro FT_ToolPath DIR
  CreateDirectory "$INSTDIR\bin"
  Push "${DIR}"
  Call FT_MakeShims
!macroend

!macro FT_ENV_INIT
  StrCpy $FT_PathUnsafe 0
!macroend

!macro FT_ENV_BROADCAST
  ${If} $FT_PathUnsafe == 1
    DetailPrint "PATH was not modified. Add the forensictools directories manually if needed."
  ${EndIf}
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
!macroend

!endif
