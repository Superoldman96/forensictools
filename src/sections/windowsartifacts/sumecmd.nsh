; SumECmd 2026.5.0 (https://ericzimmerman.github.io/#!index.md)

!insertmacro FT_TOOL_BEGIN "Process Microsoft User Access Logs" SEC_WINDOWSARTIFACTS_SUMECMD "windowsartifacts\sumecmd" "Windows artifacts" "1"
  !insertmacro FT_LinkIcon "SumECmd" "runSumECmd.bat" "SumECmd.ico"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
