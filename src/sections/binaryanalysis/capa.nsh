; capa v9.4.0 (https://github.com/mandiant/capa)

!insertmacro FT_TOOL_BEGIN "capa" SEC_BINARYANALYSIS_CAPA "binaryanalysis\capa" "Binary analysis" "1"
  !insertmacro FT_LinkCmd "capa" "capa.exe"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
