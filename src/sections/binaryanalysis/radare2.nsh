; radare2 6.2.0 (https://github.com/radareorg/radare2)

!insertmacro FT_TOOL_BEGIN "radare2" SEC_BINARYANALYSIS_RADARE2 "binaryanalysis\radare2" "Binary analysis" "1"
  !insertmacro FT_LinkCmd "radare2" "bin\radare2.exe"
  !insertmacro FT_ToolPath "$INSTDIR\binaryanalysis\radare2\bin"
!insertmacro FT_TOOL_END
