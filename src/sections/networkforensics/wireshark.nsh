; Wireshark 4.4.9 (https://www.wireshark.org)

!insertmacro FT_TOOL_BEGIN "Wireshark" SEC_NETWORKFORENSICS_WIRESHARK "networkforensics\wireshark" "Network forensics" "1"
  !ifdef FT_WIRESHARK_INTERACTIVE
    !insertmacro FT_RunSetup "${FT_WIRESHARK_SETUP}" '/desktopicon=no /D=${FT_P}\app'
  !else
    !insertmacro FT_RunSetup "${FT_WIRESHARK_SETUP}" '/S /desktopicon=no /D=${FT_P}\app'
  !endif

  Call FT_DetectNpcap
  ${If} $0 != ""
    DetailPrint "Npcap $0 already installed; skipping."
  ${Else}
    !ifdef FT_NPCAP_SILENT
      ; Only the OEM edition accepts /S.
      !insertmacro FT_RunSetup "${FT_NPCAP_SETUP}" '/S /loopback_support=yes /winpcap_mode=yes'
    !else
      DetailPrint "Launching the Npcap installer -- accept its prompts to enable live capture."
      !insertmacro FT_RunSetup "${FT_NPCAP_SETUP}" ''
      Call FT_DetectNpcap
      ${If} $0 == ""
        DetailPrint "WARNING: Npcap was not installed. Wireshark can open saved captures but not capture live traffic."
      ${EndIf}
    !endif
  ${EndIf}

  Delete "${FT_P}\${FT_WIRESHARK_SETUP}"
  Delete "${FT_P}\${FT_NPCAP_SETUP}"

  !insertmacro FT_LinkBoth "Wireshark" "${FT_P}\app\Wireshark.exe" "" "${FT_P}\app\Wireshark.exe"
!insertmacro FT_TOOL_END
