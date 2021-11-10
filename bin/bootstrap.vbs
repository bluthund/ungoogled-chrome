Set pathObj = CreateObject("WScript.Shell")

If (Wscript.Arguments.Item(0) = "--uninstall") Then
    pathObj.CurrentDirectory = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
    RunApp = pathObj.Run("..\setup_uninstall.cmd",0,true)
Else
    shortcutFile = pathObj.ExpandEnvironmentStrings("%UserProfile%") + "\Desktop\Google Chrome.lnk"
    Set shortcutProps = pathObj.CreateShortcut(shortcutFile)
        shortcutProps.TargetPath = "%LOCALAPPDATA%\Chromium\Application\chrome.exe"
        shortcutProps.WorkingDirectory = "%LOCALAPPDATA%\Chromium\Application\93.0.4577.82"
        shortcutProps.Description = "Web browser built upon the Blink engine, sans Google services and tracking components"
        shortcutProps.IconLocation = "%LOCALAPPDATA%\Chromium\Application\chrome.exe,0"
        shortcutProps.Arguments = Wscript.Arguments.Item(0)
    shortcutProps.Save
End If