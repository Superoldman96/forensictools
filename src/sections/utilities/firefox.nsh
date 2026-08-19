; Mozilla Firefox (https://www.mozilla.org/firefox/)

!insertmacro FT_TOOL_BEGIN "Firefox" SEC_UTILITIES_FIREFOX "utilities\firefox" "Utilities" "1"
  InitPluginsDir
  FileOpen $1 "$PLUGINSDIR\firefox.ini" w
  FileWrite $1 "[Install]$\r$\n"
  FileWrite $1 "InstallDirectoryPath=${FT_P}\app$\r$\n"
  FileWrite $1 "DesktopShortcut=false$\r$\n"
  FileWrite $1 "StartMenuShortcut=false$\r$\n"
  FileWrite $1 "StartMenuShortcuts=false$\r$\n"
  FileWrite $1 "TaskbarShortcut=false$\r$\n"
  FileWrite $1 "PrivateBrowsingShortcut=false$\r$\n"
  FileWrite $1 "MaintenanceService=false$\r$\n"
  FileWrite $1 "RegisterDefaultAgent=false$\r$\n"
  FileClose $1
  !insertmacro FT_RunSetup "${FT_FIREFOX_SETUP}" '/INI=$PLUGINSDIR\firefox.ini'
  Delete "${FT_P}\${FT_FIREFOX_SETUP}"

  !insertmacro FT_LinkBoth "Firefox" "${FT_P}\app\firefox.exe" "" "${FT_P}\app\firefox.exe"

  SetOutPath "${FT_P}\app"
  CreateShortCut "$DESKTOP\Firefox.lnk" "${FT_P}\app\firefox.exe" "" "${FT_P}\app\firefox.exe" 0
!insertmacro FT_TOOL_END
