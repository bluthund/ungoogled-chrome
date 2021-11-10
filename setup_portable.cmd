@echo off
color 0e
title Ungoogled Chrome installer
cd /d "%~dp0bin"

set "CHRArgs=--silent-debugger-extension-api"
set "CHRExec_REG=%LOCALAPPDATA%\Chromium\Application"

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
echo   ------------------------------------------------------------------------------
echo/
echo   ARGUMENTS (change line 6 in ^<setup_portable.cmd^> to edit):
echo ^> %CHRArgs%
echo/
echo   ------------------------------------------------------------------------------
echo/
echo   INSTALLATION DIRECTORY (DO NOT edit):
echo ^> %CHRExec_REG%
echo/
echo   ------------------------------------------------------------------------------
echo/
echo   EXTRA INFO AND FEATURES:
echo ^> This is version 93.0.4577.82 of Chromium, built by Marmaduke with Widevine and
echo   all codecs available in the proprietary Chrome build.
echo/
echo ^> This package also includes some preconfigured extensions, like Nano Adblocker,
echo   Ruffle, Violentmonkey running userscripts like Anti-Adblock Killer list, etc.
echo/
echo ^> Furthermore, this program also has many search engines configured; example "wa
echo   ^<text^>" searches WolframAlpha, "gm ^<location^>" searches Google Maps, etc.
echo/
echo   ------------------------------------------------------------------------------
echo/
set /p proceed="> Press [ENTER] to start installation. "

:install
start /w "" wscript "bootstrap.vbs" "--uninstall"
7za x -o"%LOCALAPPDATA%\Chromium\Application" -y binary.001 >NUL 2>&1
7za x -o"%LOCALAPPDATA%\Chromium\User Data" -y userdata_defaultconfig >NUL 2>&1
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
echo   ------------------------------------------------------------------------------
echo/
echo   All done!
set /p proceed="> Press [ENTER] to exit. "
exit