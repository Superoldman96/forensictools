; PE-bear v0.7.2 (https://github.com/hasherezade/pe-bear)

Section "PE-bear" SEC_BINARYANALYSIS_PEBEAR
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\pebear"
  File /r "${SRCDIR}\binaryanalysis\pebear\*"
  CreateDirectory "${SM_GROUP}"
  SetOutPath "$INSTDIR\binaryanalysis\pebear"
  CreateShortCut "${SM_GROUP}\PE-bear.lnk" "$INSTDIR\binaryanalysis\pebear\PE-bear.exe" "" "$INSTDIR\binaryanalysis\pebear\PE-bear.exe" 0
  CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
  SetOutPath "$INSTDIR\binaryanalysis\pebear"
  CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\PE-bear.lnk" "$INSTDIR\binaryanalysis\pebear\PE-bear.exe" "" "$INSTDIR\binaryanalysis\pebear\PE-bear.exe" 0
SectionEnd
