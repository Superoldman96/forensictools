; x64dbg 2026-05-27 (https://x64dbg.com)

Section "x64dbg" SEC_BINARYANALYSIS_X64DBG
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\x64dbg"
  File /r "${SRCDIR}\binaryanalysis\x64dbg\*"
  ${If} ${RunningX64}
    CreateDirectory "${SM_GROUP}"
    CreateShortCut "${SM_GROUP}\x64dbg.lnk" "$INSTDIR\binaryanalysis\x64dbg\release\x96dbg.exe" "" "$INSTDIR\binaryanalysis\x64dbg\release\x96dbg.exe" 0
  ${EndIf}
  ${If} ${RunningX64}
    CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
    CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\x64dbg.lnk" "$INSTDIR\binaryanalysis\x64dbg\release\x96dbg.exe" "" "$INSTDIR\binaryanalysis\x64dbg\release\x96dbg.exe" 0
  ${EndIf}
SectionEnd
