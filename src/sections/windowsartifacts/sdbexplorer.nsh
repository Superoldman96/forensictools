; SDB Explorer 1.0.0.0 (https://ericzimmerman.github.io/#!index.md)

!insertmacro FT_TOOL_BEGIN "SDBExplorer" SEC_WINDOWSARTIFACTS_SDBEXPLORER "windowsartifacts\sdbexplorer" "Windows artifacts" "1"
  !insertmacro FT_LinkBoth "SDBExplorer" "$INSTDIR\windowsartifacts\SDBExplorer\SDBExplorer.exe" "" "$INSTDIR\windowsartifacts\SDBExplorer\SDBExplorer.exe"
!insertmacro FT_TOOL_END
