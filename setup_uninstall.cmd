@echo off
color 0e
title Ungoogled Chrome: Uninstaller

:uninstallcfg
set "CHRVer=103.0.5060.114"
set "CHRExec_REG=%LOCALAPPDATA%\Chromium\Application"

taskkill /f /im "chrome.exe"

:keepdata
cls && echo/
set "proceed= " && set /p "proceed=> Press [ENTER] to remove all userdata files, or [K] and then [ENTER] to keep them: "
if /i "%proceed%" EQU "K" (goto uninstall) else if "%proceed%" EQU " " (goto fullclean) else (goto keepdata)

:fullclean
rmdir /s /q "%CHRExec_REG%\..\User Data" > NUL 2>&1

:uninstall
del /f /q "%CHRExec_REG%\chrome.exe" > NUL 2>&1
del /f /q "%USERPROFILE%\Desktop\Google Chrome.lnk" > NUL 2>&1
del /f /s /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk" > NUL 2>&1

rmdir /s /q "%CHRExec_REG%\%CHRVer%" > NUL 2>&1
ren "%CHRExec_REG%\..\User Data_OLD" "User Data" > NUL 2>&1
rmdir /q "%CHRExec_REG%" > NUL 2>&1
rmdir /q "%CHRExec_REG%\.." > NUL 2>&1

for /f "tokens=2* skip=2" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites"') do set "TBPin=%%b" > NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d %TBPin:474F4F474C457E312E4C4E4B=% /f > NUL 2>&1

reg delete "HKCU\SOFTWARE\RegisteredApplications" /v "Google Chrome" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.HTML" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.XHTML" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.SHTML" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.PDF" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.SVG" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.WEBP" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\FTP\UserChoice" /v "ProgID" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v "ProgID" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v "ProgID" /f > NUL 2>&1

reg delete "HKCU\SOFTWARE\Chrome" /f > NUL 2>&1
reg delete "HKCU\SOFTWARE\Chromium" /f > NUL 2>&1

taskkill /f /im "explorer.exe" > NUL 2>&1
start "" "explorer.exe" > NUL 2>&1
explorer "%~dp0" > NUL 2>&1
exit
