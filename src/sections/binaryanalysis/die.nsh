; Detect it Easy 3.21 (https://github.com/horsicq/Detect-It-Easy)

Section "Detect It Easy" SEC_BINARYANALYSIS_DIE
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\die"
  File /r "${SRCDIR}\binaryanalysis\die\*"
  CreateDirectory "${SM_GROUP}"
  SetOutPath "$INSTDIR\binaryanalysis\die"
  CreateShortCut "${SM_GROUP}\Detect It Easy.lnk" "$INSTDIR\binaryanalysis\die\die.exe" "" "$INSTDIR\binaryanalysis\die\die.exe" 0
  CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
  SetOutPath "$INSTDIR\binaryanalysis\die"
  CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\Detect It Easy.lnk" "$INSTDIR\binaryanalysis\die\die.exe" "" "$INSTDIR\binaryanalysis\die\die.exe" 0
  !insertmacro FT_ToolPath "$INSTDIR\binaryanalysis\die"
SectionEnd
