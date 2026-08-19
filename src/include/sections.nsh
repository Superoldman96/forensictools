SectionGroup /e "Binary analysis" SECGRP_BINARYANALYSIS
  !include "sections\binaryanalysis\apimonitor.nsh"
  !include "sections\binaryanalysis\capa.nsh"
  !include "sections\binaryanalysis\die.nsh"
  !include "sections\binaryanalysis\floss.nsh"
  !include "sections\binaryanalysis\ilspy.nsh"
  !include "sections\binaryanalysis\malunpack.nsh"
  !include "sections\binaryanalysis\pebear.nsh"
  !include "sections\binaryanalysis\pestudio.nsh"
  !include "sections\binaryanalysis\ppee.nsh"
  !include "sections\binaryanalysis\radare2.nsh"
  !include "sections\binaryanalysis\scdbg.nsh"
  !include "sections\binaryanalysis\upx.nsh"
  !include "sections\binaryanalysis\x64dbg.nsh"
  !include "sections\binaryanalysis\xvolkolak.nsh"
  !include "sections\binaryanalysis\cssc.nsh"
  !include "sections\binaryanalysis\loki.nsh"
  !include "sections\binaryanalysis\pyinstxtractor.nsh"
  !include "sections\binaryanalysis\vt.nsh"
  !include "sections\binaryanalysis\ghidra.nsh"
  !include "sections\binaryanalysis\jdgui.nsh"
SectionGroupEnd

SectionGroup /e "Browser utilities" SECGRP_BROWSERUTILITIES
  !include "sections\browserutilities\browsinghistoryview.nsh"
  !include "sections\browserutilities\chromecacheview.nsh"
  !include "sections\browserutilities\chromecookiesview.nsh"
  !include "sections\browserutilities\mzcacheview.nsh"
  !include "sections\browserutilities\safaricacheview.nsh"
  !include "sections\browserutilities\hindsight.nsh"
SectionGroupEnd

SectionGroup /e "Disk forensics" SECGRP_DISKFORENSICS
  !include "sections\diskforensics\bulkextractor.nsh"
  !include "sections\diskforensics\foremostng.nsh"
  !include "sections\diskforensics\osfmount.nsh"
  !include "sections\diskforensics\photorec.nsh"
  !include "sections\diskforensics\sleuthkit.nsh"
SectionGroupEnd

SectionGroup /e "Windows artifacts" SECGRP_WINDOWSARTIFACTS
  !include "sections\windowsartifacts\amcacheevilhunter.nsh"
  !include "sections\windowsartifacts\amcacheparser.nsh"
  !include "sections\windowsartifacts\appcompatcacheparser.nsh"
  !include "sections\windowsartifacts\apthunter.nsh"
  !include "sections\windowsartifacts\chainsaw.nsh"
  !include "sections\windowsartifacts\evtxecmd.nsh"
  !include "sections\windowsartifacts\hayabusa.nsh"
  !include "sections\windowsartifacts\iparse.nsh"
  !include "sections\windowsartifacts\jlecmd.nsh"
  !include "sections\windowsartifacts\jumplistexplorer.nsh"
  !include "sections\windowsartifacts\lastactivityview.nsh"
  !include "sections\windowsartifacts\lecmd.nsh"
  !include "sections\windowsartifacts\logfileparser.nsh"
  !include "sections\windowsartifacts\mftecmd.nsh"
  !include "sections\windowsartifacts\mftexplorer.nsh"
  !include "sections\windowsartifacts\pecmd.nsh"
  !include "sections\windowsartifacts\rbcmd.nsh"
  !include "sections\windowsartifacts\recentfilecacheparser.nsh"
  !include "sections\windowsartifacts\recmd.nsh"
  !include "sections\windowsartifacts\regshot.nsh"
  !include "sections\windowsartifacts\registryexplorer.nsh"
  !include "sections\windowsartifacts\sbecmd.nsh"
  !include "sections\windowsartifacts\sdbexplorer.nsh"
  !include "sections\windowsartifacts\shellbagsexplorer.nsh"
  !include "sections\windowsartifacts\srumdump.nsh"
  !include "sections\windowsartifacts\srumecmd.nsh"
  !include "sections\windowsartifacts\sumecmd.nsh"
  !include "sections\windowsartifacts\thumbcacheviewer.nsh"
  !include "sections\windowsartifacts\wfa.nsh"
  !include "sections\windowsartifacts\winprefetchview.nsh"
  !include "sections\windowsartifacts\wxtcmd.nsh"
  !include "sections\windowsartifacts\triager.nsh"
  !include "sections\windowsartifacts\uareport.nsh"
  !include "sections\windowsartifacts\bmctools.nsh"
  !include "sections\windowsartifacts\pywmipersistencefinder.nsh"
  !include "sections\windowsartifacts\regreport.nsh"
  !include "sections\windowsartifacts\rdpcachestitcher.nsh"
SectionGroupEnd

SectionGroup /e "macOS artifacts" SECGRP_MACOSARTIFACTS
  !include "sections\macosartifacts\macapt.nsh"
  !include "sections\macosartifacts\unifiedlogs_iterator.nsh"
  !include "sections\macosartifacts\spotlight_parser.nsh"
  !include "sections\macosartifacts\dsstoreparser.nsh"
  !include "sections\macosartifacts\fseparserv4.nsh"
SectionGroupEnd

SectionGroup /e "Mobile forensics" SECGRP_MOBILEFORENSICS
  !include "sections\mobileforensics\adb.nsh"
  !include "sections\mobileforensics\aleappgui.nsh"
  !include "sections\mobileforensics\apkstudio.nsh"
  !include "sections\mobileforensics\ileappgui.nsh"
  !include "sections\mobileforensics\jadx.nsh"
  !include "sections\mobileforensics\scrcpy.nsh"
SectionGroupEnd

SectionGroup /e "Hashing" SECGRP_HASHING
  !include "sections\hashing\gethashes.nsh"
  !include "sections\hashing\hashcalc.nsh"
  !include "sections\hashing\hasher.nsh"
SectionGroupEnd

SectionGroup /e "Hex editors" SECGRP_HEXEDITORS
  !include "sections\hexeditors\hxd.nsh"
  !include "sections\hexeditors\imhex.nsh"
SectionGroupEnd

SectionGroup /e "E-mail forensics" SECGRP_MAILFORENSICS
  !include "sections\mailforensics\mailview.nsh"
  !include "sections\mailforensics\mxray.nsh"
SectionGroupEnd

SectionGroup /e "Memory analysis" SECGRP_MEMORYANALYSIS
  !include "sections\memoryanalysis\cobaltstrikescan.nsh"
  !include "sections\memoryanalysis\memprocfs.nsh"
  !include "sections\memoryanalysis\volatility.nsh"
  !include "sections\memoryanalysis\vol3.nsh"
SectionGroupEnd

SectionGroup /e "Network forensics" SECGRP_NETWORKFORENSICS
  !include "sections\networkforensics\nc.nsh"
  !include "sections\networkforensics\networkminer.nsh"
  !include "sections\networkforensics\wireshark.nsh"
  !include "sections\networkforensics\fakenet.nsh"
SectionGroupEnd

!include "sections\onlinesearch\onlinesearch.nsh"

SectionGroup /e "Password cracking" SECGRP_PASSWORDCRACKING
  !include "sections\passwordcracking\hashcat.nsh"
  !include "sections\passwordcracking\hashsuite.nsh"
  !include "sections\passwordcracking\ophcrack.nsh"
SectionGroupEnd

SectionGroup /e "Utilities" SECGRP_UTILITIES
  !include "sections\utilities\7zip.nsh"
  !include "sections\utilities\bstrings.nsh"
  !include "sections\utilities\busybox.nsh"
  !include "sections\utilities\cyberchef.nsh"
  !include "sections\utilities\dbbrowser.nsh"
  !include "sections\utilities\dd.nsh"
  !include "sections\utilities\exiftool.nsh"
  !include "sections\utilities\npp.nsh"
  !include "sections\utilities\officemalscanner.nsh"
  !include "sections\utilities\python.nsh"
  !include "sections\utilities\sqlecmd.nsh"
  !include "sections\utilities\sqlite.nsh"
  !include "sections\utilities\steghide.nsh"
  !include "sections\utilities\timelineexplorer.nsh"
  !include "sections\utilities\trid.nsh"
  !include "sections\utilities\velociraptor.nsh"
  !include "sections\utilities\yara.nsh"
  !include "sections\utilities\firefox.nsh"
  !include "sections\utilities\processhacker.nsh"
  !include "sections\utilities\nasm.nsh"
  !include "sections\utilities\devcpp.nsh"
  !include "sections\utilities\java.nsh"
SectionGroupEnd
