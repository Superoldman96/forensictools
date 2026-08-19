; Eclipse Temurin JDK 21 (https://adoptium.net/)
; Needed by the Java tools (JD-GUI, JADX, ApkStudio).

!insertmacro FT_TOOL_BEGIN "Java (Temurin JDK 21)" SEC_UTILITIES_JAVA "utilities\java" "Utilities" "1"
  !insertmacro FT_RunMsi "${FT_JDK_MSI}" 'ADDLOCAL=FeatureMain,FeatureJavaHome,FeatureJarFileRunWith INSTALLDIR="${FT_P}" /quiet /norestart'

  Push "${FT_P}"
  Call FT_FindJavaHome
  ${If} $R0 == ""
    DetailPrint "WARNING: no JDK found under ${FT_P}; JAVA_HOME not set."
  ${Else}
    DetailPrint "JAVA_HOME: $R0"
    !insertmacro FT_SetEnv "JAVA_HOME" "$R0"
    CreateDirectory "$INSTDIR\bin"
    Push "$R0\bin"
    Call FT_MakeShims

    Push "Eclipse Temurin"
    Push "${FT_P}"
    Call FT_FindVendorUninstall
    ${If} $R0 != ""
      WriteRegStr HKCU "${UNINST_KEY}" "JavaUninstall" "$R0"
    ${EndIf}
  ${EndIf}

  Delete "${FT_P}\${FT_JDK_MSI}"
!insertmacro FT_TOOL_END
