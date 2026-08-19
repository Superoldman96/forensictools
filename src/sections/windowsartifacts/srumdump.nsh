; SRUM-DUMP 3.2 (https://github.com/MarkBaggett/srum-dump)

!insertmacro FT_TOOL_BEGIN "SRUM-DUMP" SEC_WINDOWSARTIFACTS_SRUMDUMP "windowsartifacts\srumdump" "Windows artifacts" "1"
  !insertmacro FT_LinkAt "${SM_GROUP}" "srumdump" "$INSTDIR\windowsartifacts\srumdump\srum_dump.exe" "" "$INSTDIR\windowsartifacts\srumdump\srum_dump.exe"
  !insertmacro FT_LinkSendTo "SRUM-DUMP" "$INSTDIR\windowsartifacts\srumdump\srum_dump.exe" "" "$INSTDIR\windowsartifacts\srumdump\srum_dump.exe"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
