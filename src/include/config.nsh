; Setup

!define APP_NAME        "forensictools"
!define APP_VERSION     "1.4"
!define APP_VERSION_4   "1.4.0.0"
!define APP_PUBLISHER   "Cristian Souza"
!define APP_URL         "https://github.com/cristianzsh/forensictools"

; Staged payload. Override with /DSRCDIR=...
!ifndef SRCDIR
  !define SRCDIR "c:\ftools"
!endif

!define UNINST_KEY  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
!define SM_GROUP    "$SMPROGRAMS\${APP_NAME}\${APP_NAME}"
!define PROGID      "${APP_NAME}"
!define CLASSES     "Software\Classes"
!define FT_HOTKEY   ""

; Vendor installer filenames.
!define FT_WIRESHARK_SETUP  "Wireshark-4.6.7-x64.exe"
!define FT_FIREFOX_SETUP    "firefox_setup.exe"
!define FT_NPCAP_SETUP      "npcap-1.88.exe"
!define FT_VCREDIST_X64     "VC_redist.x64.exe"
!define FT_VCREDIST_X86     "VC_redist.x86.exe"

; Working directory for the desktop cmd.exe shortcut.
!define FT_CMD_WORKDIR      "$PROFILE"
!define FT_JDK_MSI          "openjdk21.msi"
