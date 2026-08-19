; pestudio 9.61 (https://www.winitor.com/download)

Section "PEStudio" SEC_BINARYANALYSIS_PESTUDIO
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\pestudio"
  File /r "${SRCDIR}\binaryanalysis\pestudio\*"
  ${If} ${RunningX64}
    CreateDirectory "${SM_GROUP}"
    CreateShortCut "${SM_GROUP}\pestudio.lnk" "$INSTDIR\binaryanalysis\pestudio\pestudio.exe" "" "$INSTDIR\binaryanalysis\pestudio\pestudio.exe" 0
  ${EndIf}
  ${If} ${RunningX64}
    CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
    CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\pestudio.lnk" "$INSTDIR\binaryanalysis\pestudio\pestudio.exe" "" "$INSTDIR\binaryanalysis\pestudio\pestudio.exe" 0
  ${EndIf}
SectionEnd
