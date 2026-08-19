; RBCmd 2026.5.0 (https://ericzimmerman.github.io/#!index.md)

!insertmacro FT_TOOL_BEGIN "Recycle Bin artifact parser" SEC_WINDOWSARTIFACTS_RBCMD "windowsartifacts\rbcmd" "Windows artifacts" "1"
  !insertmacro FT_LinkAt "${SM_GROUP}" "RBCmd" "$INSTDIR\windowsartifacts\jbcmd\runRBCmd.bat" "" "$INSTDIR\windowsartifacts\rbcmd\RBCmd.ico"
  !insertmacro FT_LinkSendTo "RBCmd" "$INSTDIR\windowsartifacts\rbcmd\runRBCmd.bat" "" "$INSTDIR\windowsartifacts\rbcmd\RBCmd.ico"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
