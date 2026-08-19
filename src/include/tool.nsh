; Tool-section vocabulary. FT_TOOL_BEGIN sets ${FT_P} (install dir) and ${FT_C} (SendTo category).

!ifndef TOOL_NSH_INCLUDED
!define TOOL_NSH_INCLUDED

!macro FT_TOOL_BEGIN DESC ID DIR CAT TYPES
  !define FT_P "$INSTDIR\${DIR}"
  !define FT_C "${CAT}"
  Section "${DESC}" ${ID}
    SectionIn ${TYPES}
    SetOutPath "${FT_P}"
    File /r "${SRCDIR}\${DIR}\*"
!macroend

!macro FT_TOOL_END
  SectionEnd
  !undef FT_P
  !undef FT_C
!macroend

; Payload only.
!macro FT_TOOL_FILES DESC ID DIR TYPES
  Section "${DESC}" ${ID}
    SectionIn ${TYPES}
    SetOutPath "$INSTDIR\${DIR}"
    File /r "${SRCDIR}\${DIR}\*"
  SectionEnd
!macroend

; Each FT_Link* creates the same entry in the Start Menu and in SendTo.

!macro FT_LinkAt WHERE NAME TARGET PARAMS ICON
  CreateDirectory "${WHERE}"
  CreateShortCut "${WHERE}\${NAME}.lnk" "${TARGET}" "${PARAMS}" "${ICON}" 0
!macroend

!macro FT_LinkBoth NAME TARGET PARAMS ICON
  !insertmacro FT_LinkAt "${SM_GROUP}" "${NAME}" "${TARGET}" "${PARAMS}" "${ICON}"
  !insertmacro FT_LinkAt "$INSTDIR\sendto+\sendto\${FT_C}" "${NAME}" "${TARGET}" "${PARAMS}" "${ICON}"
!macroend

!macro FT_Link NAME EXE
  !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${EXE}" "" "${FT_P}\${EXE}"
!macroend

; One shortcut, picking the binary by architecture.
!macro FT_LinkArch NAME EXE64 EXE32
  ${If} ${RunningX64}
    !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${EXE64}" "" "${FT_P}\${EXE64}"
  ${Else}
    !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${EXE32}" "" "${FT_P}\${EXE32}"
  ${EndIf}
!macroend

; Sets $0 to the installed Npcap version, or "" if absent.
Function FT_DetectNpcap
  SetRegView 32
  ReadRegStr $0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NpcapInst" "DisplayVersion"
  ${If} $0 == ""
    ReadRegStr $0 HKLM "Software\Npcap" ""
  ${EndIf}
  SetRegView lastused
FunctionEnd

; Installs the VC++ redistributable staged in the current tool's directory,
; unless a runtime is already registered. Exit codes: 0 ok, 1638 a newer
; version is already present, 3010 installed but wants a reboot.
!macro FT_VCRedistArch ARCH SETUP
  SetRegView 64
  ReadRegDWORD $1 HKLM "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\${ARCH}" "Installed"
  ${If} $1 != 1
    SetRegView 32
    ReadRegDWORD $1 HKLM "SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\${ARCH}" "Installed"
  ${EndIf}
  SetRegView lastused

  ${If} $1 == 1
    DetailPrint "Visual C++ ${ARCH} runtime already present; skipping."
  ${Else}
    DetailPrint "Installing the Visual C++ ${ARCH} runtime ..."
    ExecWait '"${FT_P}\${SETUP}" /install /quiet /norestart' $0
    ${If} $0 == 0
      DetailPrint "Visual C++ ${ARCH} runtime installed."
    ${ElseIf} $0 == 1638
      DetailPrint "A newer Visual C++ ${ARCH} runtime is already installed."
    ${ElseIf} $0 == 3010
      DetailPrint "Visual C++ ${ARCH} runtime installed; a reboot is required."
      SetRebootFlag true
    ${Else}
      DetailPrint "WARNING: Visual C++ ${ARCH} installer returned $0."
    ${EndIf}
  ${EndIf}
  Delete "${FT_P}\${SETUP}"
!macroend

!macro FT_VCRedist
  !insertmacro FT_VCRedistArch "x86" "${FT_VCREDIST_X86}"
  !insertmacro FT_VCRedistArch "x64" "${FT_VCREDIST_X64}"
!macroend

; Persistent environment variable for the current user
!macro FT_SetEnv NAME VALUE
  WriteRegExpandStr HKCU "Environment" "${NAME}" "${VALUE}"
!macroend

!macro FT_DelEnv NAME
  DeleteRegValue HKCU "Environment" "${NAME}"
!macroend

; Lets a vendor installer that registers itself be removed later without hardcoding an MSI product code.
Function FT_FindVendorUninstall
  Exch $R1          ; InstallLocation prefix
  Exch
  Exch $R6
  Push $R2
  Push $R3
  Push $R4
  Push $R5
  Push $R7

  StrCpy $R0 ""
  StrCpy $R2 0
  StrLen $R5 $R1
  SetRegView 64

fvu_loop:
  EnumRegKey $R3 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall" $R2
  StrCmp $R3 "" fvu_done
  IntOp $R2 $R2 + 1
  ReadRegStr $R4 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$R3" "InstallLocation"
  StrCpy $R4 $R4 $R5
  StrCmp $R4 $R1 fvu_hit
  StrCmp $R6 "" fvu_loop
  ReadRegStr $R4 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$R3" "DisplayName"
  StrLen $R7 $R6
  StrCpy $R4 $R4 $R7
  StrCmp $R4 $R6 0 fvu_loop
fvu_hit:
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$R3" "QuietUninstallString"
  StrCmp $R0 "" 0 fvu_done
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$R3" "UninstallString"
  StrCmp $R0 "" fvu_done
  StrCpy $R0 "$R0 /qn /norestart"

fvu_done:
  SetRegView lastused
  Pop $R7
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R6
  Pop $R1
FunctionEnd

Function FT_FindJavaHome
  Exch $R1
  Push $R2
  Push $R3

  StrCpy $R0 ""
  IfFileExists "$R1\bin\java.exe" 0 +3
    StrCpy $R0 "$R1"
    Goto fj_done

  FindFirst $R2 $R3 "$R1\jdk*"
fj_loop:
  StrCmp $R3 "" fj_close
  IfFileExists "$R1\$R3\bin\java.exe" 0 fj_next
    StrCpy $R0 "$R1\$R3"
    Goto fj_close
fj_next:
  FindNext $R2 $R3
  Goto fj_loop
fj_close:
  FindClose $R2

fj_done:
  Pop $R3
  Pop $R2
  Pop $R1
FunctionEnd

; Run a bundled .msi.
!macro FT_RunMsi MSI ARGS
  DetailPrint "Running ${MSI} ..."
  ${DisableX64FSRedirection}
  ExecWait '"$SYSDIR\msiexec.exe" /i "${FT_P}\${MSI}" ${ARGS}' $0
  ${EnableX64FSRedirection}
  ${If} $0 == 0
    DetailPrint "${MSI} installed."
  ${ElseIf} $0 == 3010
    DetailPrint "${MSI} installed; a reboot is required."
    SetRebootFlag true
  ${Else}
    DetailPrint "WARNING: ${MSI} returned $0"
  ${EndIf}
!macroend

; Run a bundled vendor installer and report a non-zero exit code.
!macro FT_RunSetup EXE ARGS
  DetailPrint "Running ${EXE} ..."
  ExecWait '"${FT_P}\${EXE}" ${ARGS}' $0
  ${If} $0 != 0
    DetailPrint "WARNING: ${EXE} returned $0"
  ${EndIf}
!macroend

; Resolves a wildcard at install time, so version-stamped filenames survive
; a tool upgrade without editing the section.
!macro FT_LinkGlob NAME PATTERN
  FindFirst $0 $1 "${FT_P}\${PATTERN}"
  FindClose $0
  ${If} $1 == ""
    DetailPrint "WARNING: ${NAME}: nothing matches ${PATTERN}"
  ${Else}
    !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\$1" "" "${FT_P}\$1"
  ${EndIf}
!macroend

; A document (.html, .pdf) opened with the shell's default handler.
!macro FT_LinkDoc NAME PATTERN ICON
  FindFirst $0 $1 "${FT_P}\${PATTERN}"
  FindClose $0
  ${If} $1 == ""
    DetailPrint "WARNING: ${NAME}: nothing matches ${PATTERN}"
  ${Else}
    !insertmacro FT_LinkBoth "${NAME}" "$WINDIR\explorer.exe" '$\"${FT_P}\$1$\"' "${ICON}"
  ${EndIf}
!macroend

; .bat with no icon of its own.
!macro FT_LinkBat NAME FILE
  !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${FILE}" "" ""
!macroend

; Same, but the icon is an absolute path rather than relative to ${FT_P}.
!macro FT_LinkIconAbs NAME FILE ICONPATH
  !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${FILE}" "" "${ICONPATH}"
!macroend

; File with a separate icon (.bat plus .ico).
!macro FT_LinkIcon NAME FILE ICON
  !insertmacro FT_LinkBoth "${NAME}" "${FT_P}\${FILE}" "" "${FT_P}\${ICON}"
!macroend

; CLI tool in a cmd window that stays up; icon is the tool, not cmd.exe.
!macro FT_LinkCmd NAME EXE
  !insertmacro FT_LinkBoth "${NAME}" "$SYSDIR\cmd.exe" '/K $\"${FT_P}\${EXE}$\"' "${FT_P}\${EXE}"
!macroend

!macro FT_LinkCmdIcon NAME EXE ICON
  !insertmacro FT_LinkBoth "${NAME}" "$SYSDIR\cmd.exe" '/K $\"${FT_P}\${EXE}$\"' "${FT_P}\${ICON}"
!macroend

!macro FT_LinkSendTo NAME TARGET PARAMS ICON
  !insertmacro FT_LinkAt "$INSTDIR\sendto+\sendto\${FT_C}" "${NAME}" "${TARGET}" "${PARAMS}" "${ICON}"
!macroend

!macro FT_Path
  !insertmacro FT_ToolPath "${FT_P}"
!macroend

!endif
