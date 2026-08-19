; forensictools installer.

Unicode true

!include "MUI2.nsh"
!include "LogicLib.nsh"
!include "Sections.nsh"
!include "x64.nsh"
!include "FileFunc.nsh"
!include "WinMessages.nsh"

!include "include\config.nsh"
!include "include\env.nsh"
!include "include\tool.nsh"

; Setup
Name                    "${APP_NAME} ${APP_VERSION}"
OutFile                 "..\dist\${APP_NAME}_${APP_VERSION}_setup.exe"
InstallDir              "$LOCALAPPDATA\Programs\${APP_NAME}"
InstallDirRegKey        HKCU "${UNINST_KEY}" "InstallLocation"
RequestExecutionLevel   admin
SetCompressor           lzma

!ifdef FT_OUTFILEMODE
  OutFileMode ${FT_OUTFILEMODE}
!endif

ShowInstDetails         show
ShowUninstDetails       show

VIProductVersion        "${APP_VERSION_4}"
VIAddVersionKey "ProductName"     "${APP_NAME}"
VIAddVersionKey "ProductVersion"  "${APP_VERSION}"
VIAddVersionKey "FileVersion"     "${APP_VERSION_4}"
VIAddVersionKey "CompanyName"     "${APP_PUBLISHER}"
VIAddVersionKey "LegalCopyright"  "${APP_PUBLISHER}"
VIAddVersionKey "FileDescription" "${APP_NAME} setup"

InstType "Full"

; UI
!define MUI_ABORTWARNING
!define MUI_ICON   "imgs\forensictools.ico"
!define MUI_UNICON "imgs\forensictools.ico"

!define MUI_WELCOMEPAGE_TITLE "${APP_NAME} ${APP_VERSION}"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE   "..\LICENSE"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; Core payload.
Section "-core" SEC_CORE
  !insertmacro FT_ENV_INIT

  SetOutPath "$INSTDIR\sendto+"
  ${If} ${RunningX64}
    File "${SRCDIR}\sendto+\sendto+_x64.exe"
  ${Else}
    File "${SRCDIR}\sendto+\sendto+_x86.exe"
  ${EndIf}
  File "${SRCDIR}\sendto+\LICENSE"
  File "${SRCDIR}\sendto+\readme.md"
  File "${SRCDIR}\imgs\forensictools.ico"

  SetOutPath "$INSTDIR\help"
  File "${SRCDIR}\help\help.html"
  File "${SRCDIR}\imgs\forensictools_full.png"

  CreateDirectory "${SM_GROUP}"

  ; desktop shortcuts
  SetOutPath "$INSTDIR\sendto+"
  ${If} ${RunningX64}
    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\sendto+\sendto+_x64.exe" "" \
        "$INSTDIR\sendto+\forensictools.ico" 0 "" "${FT_HOTKEY}"
  ${Else}
    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\sendto+\sendto+_x86.exe" "" \
        "$INSTDIR\sendto+\forensictools.ico" 0 "" "${FT_HOTKEY}"
  ${EndIf}

  ; spelling kept from the original so upgrades replace rather than duplicate
  CreateShortCut "$DESKTOP\forensicstool help.lnk" "$INSTDIR\help\help.html" "" \
      "$INSTDIR\sendto+\forensictools.ico" 0
SectionEnd

; Tool sections.
!include "include\sections.nsh"

; Tasks
SectionGroup /e "Options" SECGRP_OPTIONS

  Section "Add tools to PATH" SEC_OPT_ADDTOPATH
    SectionIn 1
    ; work happens in -post, once every tool section state is known
  SectionEnd

  Section "Create a cmd.exe shortcut on desktop" SEC_OPT_CMDDESKTOP
    SectionIn 1
    SetOutPath "${FT_CMD_WORKDIR}"
    CreateShortCut "$DESKTOP\cmd.lnk" "$SYSDIR\cmd.exe"
  SectionEnd

  Section "Set Firefox as default browser" SEC_OPT_FFDEFAULT
    SectionIn 1
  SectionEnd

  Section "Delete default python.exe from Microsoft Store" SEC_OPT_DELMSSTOREPYTHON
    SectionIn 1
    Delete "$LOCALAPPDATA\Microsoft\WindowsApps\python.exe"
    Delete "$LOCALAPPDATA\Microsoft\WindowsApps\python3*.exe"
  SectionEnd

SectionGroupEnd

!include "include\associations.nsh"

; Post-install: PATH, registry, uninstaller.
Section "-post" SEC_POST
  ; PATH
  ${If} ${SectionIsSelected} ${SEC_OPT_ADDTOPATH}
    !insertmacro FT_EnvAddPath "$INSTDIR\bin"
  ${EndIf}
  !insertmacro FT_ENV_BROADCAST

  ; file associations + shell context menu
  !insertmacro FT_WRITE_ASSOCIATIONS

  ; Add/Remove Programs entry
  SetOutPath "$INSTDIR"
  WriteUninstaller "$INSTDIR\uninstall.exe"

  WriteRegStr HKCU "${UNINST_KEY}" "DisplayName"     "${APP_NAME} ${APP_VERSION}"
  WriteRegStr HKCU "${UNINST_KEY}" "DisplayVersion"  "${APP_VERSION}"
  WriteRegStr HKCU "${UNINST_KEY}" "DisplayIcon"     "$INSTDIR\sendto+\forensictools.ico"
  WriteRegStr HKCU "${UNINST_KEY}" "Publisher"       "${APP_PUBLISHER}"
  WriteRegStr HKCU "${UNINST_KEY}" "URLInfoAbout"    "${APP_URL}"
  WriteRegStr HKCU "${UNINST_KEY}" "HelpLink"        "${APP_URL}"
  WriteRegStr HKCU "${UNINST_KEY}" "URLUpdateInfo"   "${APP_URL}"
  WriteRegStr HKCU "${UNINST_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "${UNINST_KEY}" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKCU "${UNINST_KEY}" "QuietUninstallString" '"$INSTDIR\uninstall.exe" /S'
  WriteRegDWORD HKCU "${UNINST_KEY}" "NoModify" 1
  WriteRegDWORD HKCU "${UNINST_KEY}" "NoRepair" 1

  ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
  IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKCU "${UNINST_KEY}" "EstimatedSize" "$0"

  ; AlwaysRestart=yes
  SetRebootFlag true

  ${If} ${SectionIsSelected} ${SEC_OPT_FFDEFAULT}
  ${AndIf} ${SectionIsSelected} ${SEC_UTILITIES_FIREFOX}
    ${If} ${FileExists} "$INSTDIR\utilities\firefox\app\firefox.exe"
      DetailPrint "Opening Windows default-apps settings for Firefox ..."
      Exec '"$INSTDIR\utilities\firefox\app\firefox.exe" -setDefaultBrowser'
    ${EndIf}
  ${EndIf}
SectionEnd

; Detect a previous install.
Function .onInit
  ; a previous NSIS install
  ReadRegStr $R0 HKCU "${UNINST_KEY}" "UninstallString"
  ${If} $R0 != ""
    MessageBox MB_YESNO|MB_ICONQUESTION \
      "${APP_NAME} is already installed.$\n$\nUninstall the existing version first?" \
      /SD IDNO IDNO ft_init_done
    ExecWait '$R0 _?=$INSTDIR'
    Goto ft_init_done
  ${EndIf}

ft_init_done:
FunctionEnd

; Uninstaller
Section "Uninstall"
  ReadRegStr $0 HKCU "${UNINST_KEY}" "JavaUninstall"
  ${If} $0 != ""
    ExecWait '$0'
  ${EndIf}

  !insertmacro FT_EnvRemovePath "$INSTDIR\bin"
  !insertmacro FT_DelEnv "JAVA_HOME"
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ; registry
  !insertmacro FT_REMOVE_ASSOCIATIONS
  DeleteRegKey HKCU "${UNINST_KEY}"

  ; shortcuts
  Delete "$DESKTOP\${APP_NAME}.lnk"
  Delete "$DESKTOP\forensicstool help.lnk"
  Delete "$DESKTOP\cmd.lnk"
  Delete "$DESKTOP\Firefox.lnk"
  RMDir /r "${SM_GROUP}"
  ; SM_GROUP is nested; drop the parent too if it is now empty
  RMDir "$SMPROGRAMS\${APP_NAME}"

  IfFileExists "$INSTDIR\utilities\7zip\Uninstall.exe" 0 +2
    ExecWait '"$INSTDIR\utilities\7zip\Uninstall.exe" /S'

  IfFileExists "$INSTDIR\networkforensics\wireshark\app\uninstall.exe" 0 +2
    ExecWait '"$INSTDIR\networkforensics\wireshark\app\uninstall.exe" /S'

  IfFileExists "$INSTDIR\utilities\firefox\app\uninstall\helper.exe" 0 +2
    ExecWait '"$INSTDIR\utilities\firefox\app\uninstall\helper.exe" /S'

  RMDir /r "$INSTDIR"
SectionEnd
