; API Monitor Version 2.0 Alpha-r13 (http://www.rohitab.com/apimonitor)

Section "API Monitor" SEC_BINARYANALYSIS_APIMONITOR
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\apimonitor"
  File /r "${SRCDIR}\binaryanalysis\apimonitor\*"
  ${If} ${RunningX64}
    CreateDirectory "${SM_GROUP}"
    SetOutPath "$INSTDIR\binaryanalysis\apimonitor"
    CreateShortCut "${SM_GROUP}\API Monitor (x64).lnk" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x64.exe" "" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x64.exe" 0
  ${EndIf}
  ${If} ${RunningX64}
    CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
    SetOutPath "$INSTDIR\binaryanalysis\apimonitor"
    CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\API Monitor (x64).lnk" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x64.exe" "" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x64.exe" 0
  ${EndIf}
  CreateDirectory "${SM_GROUP}"
  SetOutPath "$INSTDIR\binaryanalysis\apimonitor"
  CreateShortCut "${SM_GROUP}\API Monitor (x86).lnk" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x86.exe" "" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x86.exe" 0
  CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
  SetOutPath "$INSTDIR\binaryanalysis\apimonitor"
  CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\API Monitor (x86).lnk" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x86.exe" "" "$INSTDIR\binaryanalysis\apimonitor\apimonitor-x86.exe" 0
SectionEnd
