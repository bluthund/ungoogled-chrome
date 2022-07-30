@echo off
color 0e
set /a gostep=0
cd /d "%~dp0bin"
setlocal enabledelayedexpansion
title Ungoogled Chrome: Installer

:installcfg
set "CHRVer=103.0.5060.114"
set "CHRArgs=--silent-debugger-extension-api"
set "CHRExec_REG=%LOCALAPPDATA%\Chromium\Application"

:start
set "gostep_opt0= "
set "gostep_opt1= "
set "dash=  ------------------------------------------------------------------------------"

:banner
cls
echo/
echo                           ------------------------------
echo                           ^| UNGOOGLED CHROME INSTALLER ^|
echo                           ------------------------------
echo/
echo   This script will install Ungoogled Chrome, a purely cosmetic modification of 
echo   the ungoogled-chromium project by Eloston, made to look identical to the orig-
echo   inal Google Chrome in all but function, using its .PAK graphics resource files
echo/
echo   [NOTE] You don't need administrator access to install this program
echo/
echo %dash%
echo/
echo   ARGUMENTS (change line 6 in ^<setup_portable.cmd^> to edit):
echo ^> %CHRArgs%
echo/
echo %dash%
echo/
echo   INSTALLATION DIRECTORY (DO NOT edit):
echo ^> %CHRExec_REG%
echo/
echo %dash%
echo/
echo   EXTRA INFO AND FEATURES:
echo ^> This is version %CHRVer% of Chromium Stable, an ungoogled-chromium build
echo    from Marmaduke with Widevine and other proprietary codecs available, making it
echo    largely functionally identical to Google's closed-source build.
echo/
echo ^> This package also includes some preconfigured extensions, like Nano Adblocker,
echo   Ruffle, Violentmonkey running userscripts like Anti-Adblock Killer list, etc; a
echo   few flags set to streamline and enhance browser behavior; and minimal settings.
echo/
echo ^> Furthermore, this program also has many search engines configured; example "wa
echo   ^<text^>" searches WolframAlpha, "gm ^<location^>" searches Google Maps, etc.
echo/
echo %dash% && echo/
goto %gostep%

:0
set "gostep_opt0= "
set "gostep_txt0=> Press [ENTER] to start installation, or [Q] and then [ENTER] to quit: "
set /p "gostep_opt0=%gostep_txt0%"
if /i "%gostep_opt0%" EQU "Q" (exit) else if "%gostep_opt0%" EQU " " (goto 1) else (goto start)

:1
color 0a
if %gostep% NEQ 1 (set /a gostep=1 && goto start)
for /l %%x in (0,1,%gostep%-1) do (echo !gostep_txt%%x!!gostep_opt%%x! > NUL 2)

set "gostep_opt1= "
set "gostep_txt1=> Press [ENTER] to clean current data, or [K] and then [ENTER] to keep them: "
set /p "gostep_opt1=%gostep_txt1%"
if /i "%gostep_opt1%" EQU "K" (goto install) else if "%gostep_opt1%" EQU " " (goto cleanup) else (goto start)

:cleanup
del /f /q "%LOCALAPPDATA%\Chromium\Application\chrome.exe" >NUL 2>&1
rmdir /s /q "%LOCALAPPDATA%\Chromium\Application\%CHRVer%" >NUL 2>&1
rmdir /s /q "%LOCALAPPDATA%\Chromium\Application\User Data" >NUL 2>&1

:install
start /w "" wscript "bootstrap.vbs" "--uninstall"
7za x -o"%LOCALAPPDATA%\Chromium\Application" -y binary >NUL 2>&1
7za x -o"%LOCALAPPDATA%\Chromium\User Data" -y userdata >NUL 2>&1
wscript "bootstrap.vbs" "%CHRArgs%"

:defaultapp_registryconfig
reg add "HKCU\SOFTWARE\RegisteredApplications" /v "Chrome" /t REG_SZ /d "Software\Clients\StartMenuInternet\Chrome\Capabilities" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome" /v "LocalizedString" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome" /ve /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities" /v "ApplicationName" /t REG_SZ /d "Ungoogled Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities" /v "ApplicationDescription" /t REG_SZ /d "Web browser built upon the Blink engine" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities" /v "ApplicationIcon" /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities" /v "Hidden" /t REG_DWORD /d "0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\StartMenu" /v "StartMenuInternet" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\shell\properties\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% -preferences" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\URLAssociations" /v "http" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\URLAssociations" /v "https" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\URLAssociations" /v "ftp" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\FTP\UserChoice" /v "ProgID" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v "ProgID" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v "ProgID" /t REG_SZ /d "Chrome" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome" /v "URL Protocol" /t REG_SZ /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".htm" /t REG_SZ /d "Chrome.HTML" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".html" /t REG_SZ /d "Chrome.HTML" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.HTML" /ve /t REG_SZ /d "HTML Document" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.HTML\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.HTML\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".xht" /t REG_SZ /d "Chrome.XHTML" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".xhtml" /t REG_SZ /d "Chrome.XHTML" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.XHTML" /ve /t REG_SZ /d "eXtensible HTML Document" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.XHTML\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.XHTML\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".shtml" /t REG_SZ /d "Chrome.HTML" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SHTML" /ve /t REG_SZ /d "Server-parsed HTML Document" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SHTML\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SHTML\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".pdf" /t REG_SZ /d "Chrome.PDF" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.PDF" /ve /t REG_SZ /d "PDF Document" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.PDF\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.PDF\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".svg" /t REG_SZ /d "Chrome.SVG" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SVG" /ve /t REG_SZ /d "Scalable Vector Graphic Image" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SVG\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.SVG\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

reg add "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome\Capabilities\FileAssociations" /v ".webp" /t REG_SZ /d "Chrome.WEBP" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.WEBP" /ve /t REG_SZ /d "WebP Image" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.WEBP\DefaultIcon" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs%,0" /f >NUL 2>&1
reg add "HKCU\SOFTWARE\Classes\Chrome.WEBP\shell\open\command" /ve /t REG_SZ /d "\"%CHRExec_REG%\chrome.exe\" %CHRArgs% \"%%1\"" /f >NUL 2>&1

:final
color 0a
echo/
echo %dash%
echo/
echo   All done!
set /p proceed="> Press [ENTER] to exit. "
exit
