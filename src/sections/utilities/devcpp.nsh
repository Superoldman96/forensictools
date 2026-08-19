; Dev-C++ 5.11 (https://sourceforge.net/projects/orwelldevcpp/)

!insertmacro FT_TOOL_BEGIN "Dev-C++" SEC_UTILITIES_DEVCPP "utilities\devcpp" "Utilities" "1"
  !insertmacro FT_Link "Dev-C++" "devcpp.exe"
  !insertmacro FT_Path
  ; gcc, g++, gdb, mingw32-make and the binutils
  !insertmacro FT_ToolPath "${FT_P}\MinGW64\bin"
!insertmacro FT_TOOL_END
