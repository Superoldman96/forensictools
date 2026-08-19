; 7-Zip 26.02 (https://www.7-zip.org)

Section "7-Zip" SEC_UTILITIES_7ZIP
  SectionIn 1
  SetOutPath "$INSTDIR\utilities\7zip"
  File /r "${SRCDIR}\utilities\7zip\*.exe"
  ${If} ${RunningX64}
    ExecWait '"$INSTDIR\utilities\7zip\7z2602-x64.exe" /S /D=$INSTDIR\utilities\7zip' $0
    ${If} $0 != 0
      DetailPrint "child installer returned $0: $INSTDIR\utilities\7zip\7z2602-x64.exe"
    ${EndIf}
  ${EndIf}
  ${IfNot} ${RunningX64}
    ExecWait '"$INSTDIR\utilities\7zip\7z2602.exe" /S /D=$INSTDIR\utilities\7zip' $0
    ${If} $0 != 0
      DetailPrint "child installer returned $0: $INSTDIR\utilities\7zip\7z2602.exe"
    ${EndIf}
  ${EndIf}
  CreateDirectory "$INSTDIR\sendto+\sendto\Utilities"
  SetOutPath "$INSTDIR\utilities\7zip"
  CreateShortCut "$INSTDIR\sendto+\sendto\Utilities\7-Zip.lnk" "$INSTDIR\utilities\7zip\7zFM.exe" "" "$INSTDIR\utilities\7zip\7zFM.exe" 0
  !insertmacro FT_ToolPath "$INSTDIR\utilities\7zip"
SectionEnd
