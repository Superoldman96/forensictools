; scdbg (https://sandsprite.com/blogs/index.php?uid=7&pid=152)

Section "scdbg" SEC_BINARYANALYSIS_SCDBG
  SectionIn 1
  SetOutPath "$INSTDIR\binaryanalysis\scdbg"
  File /r "${SRCDIR}\binaryanalysis\scdbg\*"
  CreateDirectory "${SM_GROUP}"
  SetOutPath "$INSTDIR\binaryanalysis\scdbg"
  CreateShortCut "${SM_GROUP}\scdbg.lnk" "$INSTDIR\binaryanalysis\scdbg\gui_launcher.exe" "" "$INSTDIR\binaryanalysis\scdbg\gui_launcher.exe" 0
  CreateDirectory "$INSTDIR\sendto+\sendto\Binary analysis"
  SetOutPath "$INSTDIR\binaryanalysis\scdbg"
  CreateShortCut "$INSTDIR\sendto+\sendto\Binary analysis\scdbg.lnk" "$INSTDIR\binaryanalysis\scdbg\gui_launcher.exe" "" "$INSTDIR\binaryanalysis\scdbg\gui_launcher.exe" 0
  !insertmacro FT_ToolPath "$INSTDIR\binaryanalysis\scdbg"
SectionEnd
