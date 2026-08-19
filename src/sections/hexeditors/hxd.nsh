; HxD 2.5.0.0 (https://mh-nexus.de/en/hxd/)

Section "HxD" SEC_HEXEDITORS_HXD
  SectionIn 1
  SetOutPath "$INSTDIR\hexeditors\HxD"
  File /r "${SRCDIR}\hexeditors\HxD\*"
  ${If} ${RunningX64}
    CreateDirectory "${SM_GROUP}"
    CreateShortCut "${SM_GROUP}\HxD.lnk" "$INSTDIR\hexeditors\HxD\HxD64.exe" "" "$INSTDIR\hexeditors\HxD\HxD64.exe" 0
  ${EndIf}
  ${If} ${RunningX64}
    CreateDirectory "$INSTDIR\sendto+\sendto\Hex editors"
    CreateShortCut "$INSTDIR\sendto+\sendto\Hex editors\HxD.lnk" "$INSTDIR\hexeditors\HxD\HxD64.exe" "" "$INSTDIR\hexeditors\HxD\HxD64.exe" 0
  ${EndIf}
  ${IfNot} ${RunningX64}
    CreateDirectory "${SM_GROUP}"
    CreateShortCut "${SM_GROUP}\HxD.lnk" "$INSTDIR\hexeditors\HxD\HxD32.exe" "" "$INSTDIR\hexeditors\HxD\HxD32.exe" 0
  ${EndIf}
  ${IfNot} ${RunningX64}
    CreateDirectory "$INSTDIR\sendto+\sendto\Hex editors"
    CreateShortCut "$INSTDIR\sendto+\sendto\Hex editors\HxD.lnk" "$INSTDIR\hexeditors\HxD\HxD32.exe" "" "$INSTDIR\hexeditors\HxD\HxD32.exe" 0
  ${EndIf}
SectionEnd
