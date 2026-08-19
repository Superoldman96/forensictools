; Registry. HKCR -> HKCU\Software\Classes.

!ifndef ASSOC_NSH_INCLUDED
!define ASSOC_NSH_INCLUDED

!macro FT_ASSOC EXT ID DESC EXE
  WriteRegStr HKCU "${CLASSES}\${EXT}" "" "${PROGID}.${ID}"
  WriteRegStr HKCU "${CLASSES}\${PROGID}.${ID}" "" "${DESC}"
  WriteRegStr HKCU "${CLASSES}\${PROGID}.${ID}\DefaultIcon" "" "${EXE},0"
  WriteRegStr HKCU "${CLASSES}\${PROGID}.${ID}\shell\open\command" "" '"${EXE}" "%1"'
!macroend

!macro FT_UNASSOC EXT ID
  DeleteRegValue HKCU "${CLASSES}\${EXT}" ""
  DeleteRegKey /ifempty HKCU "${CLASSES}\${EXT}"
  DeleteRegKey HKCU "${CLASSES}\${PROGID}.${ID}"
!macroend

!macro FT_WRITE_ASSOCIATIONS
  ${If} ${RunningX64}
    StrCpy $R9 "$INSTDIR\sendto+\sendto+_x64.exe"
  ${Else}
    StrCpy $R9 "$INSTDIR\sendto+\sendto+_x86.exe"
  ${EndIf}

  WriteRegStr HKCU "${CLASSES}\*\shell\${APP_NAME}" "Icon" "$INSTDIR\sendto+\forensictools.ico"
  WriteRegStr HKCU "${CLASSES}\*\shell\${APP_NAME}" "Position" "top"
!ifdef FT_CTXMENU_SPACESAFE
  WriteRegStr HKCU "${CLASSES}\*\shell\${APP_NAME}\command" "" \
      'cmd /c "start "" /d "$INSTDIR\sendto+" "$R9" "%1""'
!else
  WriteRegStr HKCU "${CLASSES}\*\shell\${APP_NAME}\command" "" \
      'cmd /c "start /d $INSTDIR\sendto+ $R9 "%1""'
!endif

  ; CSV -> Timeline Explorer
  !insertmacro FT_ASSOC ".csv" "CSV" "CSV file" "$INSTDIR\utilities\timelineexplorer\TimelineExplorer.exe"

  ; Source code formats -> Notepad++
  !insertmacro FT_ASSOC ".json" "JSON" "JSON file"          "$INSTDIR\utilities\npp\notepad++.exe"
  !insertmacro FT_ASSOC ".py"   "PY"   "Python source code" "$INSTDIR\utilities\npp\notepad++.exe"
  !insertmacro FT_ASSOC ".c"    "C"    "C source code"      "$INSTDIR\utilities\npp\notepad++.exe"
  !insertmacro FT_ASSOC ".cpp"  "CPP"  "C++ source code"    "$INSTDIR\utilities\npp\notepad++.exe"
  !insertmacro FT_ASSOC ".cs"   "CS"   "C# source code"     "$INSTDIR\utilities\npp\notepad++.exe"
  !insertmacro FT_ASSOC ".sh"   "SH"   "Shell script"       "$INSTDIR\utilities\npp\notepad++.exe"

  System::Call 'shell32::SHChangeNotify(i 0x08000000, i 0, i 0, i 0)'
!macroend

!macro FT_REMOVE_ASSOCIATIONS
  DeleteRegKey HKCU "${CLASSES}\*\shell\${APP_NAME}"
  !insertmacro FT_UNASSOC ".csv"  "CSV"
  !insertmacro FT_UNASSOC ".json" "JSON"
  !insertmacro FT_UNASSOC ".py"   "PY"
  !insertmacro FT_UNASSOC ".c"    "C"
  !insertmacro FT_UNASSOC ".cpp"  "CPP"
  !insertmacro FT_UNASSOC ".cs"   "CS"
  !insertmacro FT_UNASSOC ".sh"   "SH"
  System::Call 'shell32::SHChangeNotify(i 0x08000000, i 0, i 0, i 0)'
!macroend

!endif ; ASSOC_NSH_INCLUDED
