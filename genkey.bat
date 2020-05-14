@echo off

set ROOT=%~dp0
set USERDATA=%ROOT%userdata\
if not exist "%USERDATA%" (
  mkdir "%USERDATA%"
  if "%errorlevel%" NEQ "0" (
    echo Error while creating userdata folder %USERDATA%
    goto :eof
  )
)

keytool -genkeypair -keyalg EC -keysize 256 -sigalg SHA256withECDSA -alias drftpd -dname CN=drftpd -keypass drftpd -keystore "%USERDATA%drftpd.key" -storetype pkcs12 -storepass drftpd

set SLAVEUSERDATA=%ROOT%src\slave\resources\userdata\
if not exist "%SLAVEUSERDATA%" (
  mkdir "%SLAVEUSERDATA%"
  if "%errorlevel%" NEQ "0" (
    echo Error while creating userdata folder %SLAVEUSERDATA% for slave.zip
    goto :eof
  )
)

xcopy %USERDATA%* %SLAVEUSERDATA%*