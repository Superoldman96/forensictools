; chainsaw v2.16.3 (https://github.com/WithSecureLabs/chainsaw)

!insertmacro FT_TOOL_BEGIN "Chainsaw" SEC_WINDOWSARTIFACTS_CHAINSAW "windowsartifacts\chainsaw" "Windows artifacts" "1"
  !insertmacro FT_LinkIconAbs "Chainsaw" "runChainsaw.bat" "$INSTDIR\sendto+\forensictools.ico"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
