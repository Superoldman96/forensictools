; WinPython 3.15.0.2 (https://winpython.github.io/)

!insertmacro FT_TOOL_BEGIN "WinPython" SEC_UTILITIES_PYTHON "utilities\python" "Utilities" "1"
  !insertmacro FT_Link "Python" "WinPython Interpreter.exe"
  !insertmacro FT_ToolPath "$INSTDIR\utilities\python\scripts"
  !insertmacro FT_PyShims "${FT_P}" "${FT_P}\extras_forensictools"
!insertmacro FT_TOOL_END
