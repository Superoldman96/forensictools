; PPEE (puppy) v1.14 (https://www.mzrst.com/)

Section "PPEE (puppy)" SEC_BINARYANALYSIS_PPEE
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\ppee"
  File /r "${SRCDIR}\binaryanalysis\ppee\*"
  CreateDirectory "${SM_GROUP}"
  SetOutPath "$INSTDIR\binaryanalysis\ppee"
  CreateShortCut "${SM_GROUP}\PPEE (puppy).lnk" "$INSTDIR\binaryanalysis\ppee\PPEE.exe" "" "$INSTDIR\binaryanalysis\ppee\PPEE.exe" 0
  CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
  SetOutPath "$INSTDIR\binaryanalysis\ppee"
  CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\PPEE (puppy).lnk" "$INSTDIR\binaryanalysis\ppee\PPEE.exe" "" "$INSTDIR\binaryanalysis\ppee\PPEE.exe" 0
  !insertmacro FT_ToolPath "$INSTDIR\binaryanalysis\ppee"
SectionEnd
