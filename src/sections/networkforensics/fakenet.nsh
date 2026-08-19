; FakeNet 3.5 (https://github.com/mandiant/flare-fakenet-ng)

!insertmacro FT_TOOL_BEGIN "FakeNet" SEC_NETWORKFORENSICS_FAKENET "networkforensics\fakenet" "Network forensics" "1"
  !insertmacro FT_Link "FakeNet" "fakenet.exe"
  !insertmacro FT_Path
!insertmacro FT_TOOL_END
