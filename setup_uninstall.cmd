@echo off

taskkill /f /im "chrome.exe" >NUL 2>&1

rmdir /s /q "%LOCALAPPDATA%\Chromium\Application\93.0.4577.82" >NUL 2>&1
ren "%LOCALAPPDATA%\Chromium\User Data" "User Data_OLD" >NUL 2>&1

del /f /s /q "%USERPROFILE%\Desktop\Google Chrome.lnk" >NUL 2>&1
del /f /s /q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Google Chrome.lnk" >NUL 2>&1

for /f "tokens=2* skip=2" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites"') do set "TBPin=%%b" >NUL 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /v "Favorites" /t REG_BINARY /d %TBPin:474F4F474C457E312E4C4E4B=% /f >NUL 2>&1

reg delete "HKCU\SOFTWARE\RegisteredApplications" /v "Google Chrome" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Clients\StartMenuInternet\Chrome" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.HTML" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.XHTML" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.SHTML" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.PDF" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.SVG" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Classes\Chrome.WEBP" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\FTP\UserChoice" /v "ProgID" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v "ProgID" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v "ProgID" /f >NUL 2>&1

reg delete "HKCU\SOFTWARE\Chrome" /f >NUL 2>&1
reg delete "HKCU\SOFTWARE\Chromium" /f >NUL 2>&1

taskkill /f /im "explorer.exe" >NUL 2>&1
start "" "explorer.exe" >NUL 2>&1
explorer "%~dp0" >NUL 2>&1
exit