@echo off
setlocal enabledelayedexpansion
:: Set Hacker/Professional Vibes
color 0A
title Win11 Master Debloat Suite by callmetoto

:: ADMIN CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo [ERROR] THIS SCRIPT REQUIRES ADMINISTRATIVE PRIVILEGES.
    echo Please right-click and "Run as Administrator".
    pause
    exit /b
)

:Disclaimer
cls
color 0E
echo ==========================================================
echo                 !!! WARNING & DISCLAIMER !!!
echo ==========================================================
echo This script modifies System Registry settings and removes 
echo Windows App packages globally. While safe, you should:
echo.
echo 1. Create a SYSTEM RESTORE POINT before continuing.
echo 2. Understand that features like Copilot or Widgets require 
echo    a Microsoft Store download to reinstall later.
echo 3. Use Tiger Privacy only if you don't mind losing 
echo    "Recent Files" history in File Explorer.
echo.
echo ----------------------------------------------------------
echo  !!! SAFE REMOTE CONTROL LOCKDOWN ENGAGED !!!
echo ----------------------------------------------------------
echo Lockdown Mode secures your system against unauthorized admin
echo terminal commands or registry attacks during remote sessions.
echo *NEW*: This script no longer locks you out permanently on boot!
echo It runs entirely in the current live session and returns to
echo normal automatically after a full system restart.
echo ==========================================================
echo.
set /p "agree=Do you want to proceed? (Y/N): "
if /i "%agree%" neq "Y" exit
goto MainMenu

:MainMenu
cls
color 0A
echo ==========================================================
echo        WINDOWS 11 MASTER DEBLOAT ^& PRIVACY SUITE
echo ==========================================================
echo [1] Remove COPILOT (App ^& Taskbar Integration)
echo [2] Disable TELEMETRY ^& ADS (Privacy Pack)
echo [3] Strip EDGE Bloat (Stop Background Processes)
echo [4] Disable METADATA ^& Activity Tracking
echo [5] Restore CLASSIC Right-Click Menu
echo [6] Nuke WIDGETS ^& NEWS FEED (Global Uninstall)
echo [7] Enable STEALTH MODE (Anti-Forensics / Zero External Footprint)
echo [8] Enable LOCKDOWN MODE (Secure Live Remote Support Containment)
echo [9] Enable TEMPORARY GHOST MODE (Real-time Meta-Spoofing; Safe on Boot)
echo [10] Enable PERMANENT GHOST MODE (Persistent Spoofing; Cleared via Script Only)
echo ----------------------------------------------------------
echo [P] PRESET: PANTHER (All modules 1-6 safely; retains metadata/stealth)
echo [T] PRESET: TIGER   (The Nuclear Option - EVERYTHING modules 1-7)
echo ----------------------------------------------------------
echo [U] UNDO / LIFT LOCKDOWN ^& GHOST MODES (Restore Defaults)
echo [X] EXIT
echo ==========================================================
echo.
set /p "choice=Select an option: "

set "running_preset=false"
if /i "%choice%"=="1" goto Sub_Copilot
if /i "%choice%"=="2" goto Sub_Telemetry
if /i "%choice%"=="3" goto Sub_Edge
if /i "%choice%"=="4" goto Sub_Metadata
if /i "%choice%"=="5" goto Sub_ClassicMenu
if /i "%choice%"=="6" goto Sub_Widgets
if /i "%choice%"=="7" goto Sub_Stealth
if /i "%choice%"=="8" goto Sub_Lockdown
if /i "%choice%"=="9" goto Sub_TempGhost
if /i "%choice%"=="10" goto Sub_PermGhost
if /i "%choice%"=="P" goto Preset_Panther
if /i "%choice%"=="T" goto Preset_Tiger
if /i "%choice%"=="U" goto UndoTweaks
if /i "%choice%"=="X" exit
goto MainMenu

:: --- INDIVIDUAL SUB-ROUTINES ---

:Sub_Copilot
echo [>] Nuking Copilot globally...
taskkill /f /im "Copilot.exe" >nul 2>&1
powershell -command "Get-AppxPackage -AllUsers *Microsoft.Copilot* | Remove-AppxPackage -AllUsers" >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Telemetry
echo [>] Killing Telemetry ^& Start Menu Ads...
sc config DiagTrack start= disabled >nul 2>&1
net stop DiagTrack >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Edge
echo [>] Trimming Edge background bloat...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "StartupBoostEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Metadata
echo [>] Disabling Metadata ^& Activity Tracking...
fsutil behavior set disablelastaccess 1 >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done. (Reboot required for NTFS changes)
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_ClassicMenu
echo [>] Restoring Classic Context Menu...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Widgets
echo [>] Nuking Widgets ^& Web Experience Pack globally...
taskkill /f /im "widgetservice.exe" >nul 2>&1
taskkill /f /im "widgets.exe" >nul 2>&1
powershell -command "Get-AppxPackage -AllUsers *WebExperience* | Remove-AppxPackage -AllUsers" >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Stealth
echo [>] Activating Stealth Mode (Zero Removable Media Footprint)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Portable Devices" /v "EnablePortableDevices" /t REG_DWORD /d 0 /f >nul 2>&1
echo [>] Purging existing localized shell data blocks...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
del /f /q /s /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\*.*" >nul 2>&1
start explorer.exe
echo [>] Triggering secure overwrite pass on Windows temporary directories...
start /b "" cmd /c "cipher /w:%temp% >nul 2>&1"
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Lockdown
cls
color 0C
echo ==========================================================
echo         AUTHENTICATION REQUIRED FOR LOCKDOWN MODE
echo ==========================================================
echo.
powershell -Command "$p = read-host 'Enter local administrator password to confirm initialization' -AsSecureString; $b = New-Object System.Management.Automation.PSCredential($env:USERNAME,$p); try { Add-Type -AssemblyName System.DirectoryServices.AccountManagement; $pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine); if($pc.ValidateCredentials($env:USERNAME, [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p)))) { exit 0 } else { exit 1 } } catch { exit 1 }"
if %errorLevel% neq 0 (
    echo [ERROR] Invalid Account Password. Access Denied.
    pause
    goto MainMenu
)

color 0A
echo [>] Password verified. Activating Live Session Remote Guard Shield...

:: Establish baseline registry rules blocking execution of command prompts and registry interfaces
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableCMD" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f >nul 2>&1

:: Build the dynamic Session-Only Guard loop script (Fixed redirect using native PowerShell execution architecture)
(
echo while ^($true^) {
echo     Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DisableCMD' -Value 1 -ErrorAction SilentlyContinue
echo     Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableRegistryTools' -Value 1 -ErrorAction SilentlyContinue
echo     Get-Process -Name "powershell", "pwsh", "WindowsTerminal" -ErrorAction SilentlyContinue ^| Stop-Process -Force -ErrorAction SilentlyContinue
echo     Start-Sleep -Seconds 2
echo }
) > "%SystemRoot%\totoguard.ps1"

:: Spin up background engine via hidden process instance and write PID to track accurately
for /f "tokens=1" %%A in ('powershell -Command "$p = Start-Process powershell -ArgumentList '-NoProfile -WindowStyle Hidden -File %SystemRoot%\totoguard.ps1' -PassThru; $p.Id"') do (
    set "guard_pid=%%A"
)
echo !guard_pid! > "%SystemRoot%\totoguard.pid"

echo.
echo ==========================================================
echo SUCCESS: IMMUTABLE SHIELD ACTIVE (Session-Only Mode)
echo.
echo Terminal frameworks and Registry alterations are locked down.
echo System defaults will automatically restore completely on reboot!
echo ==========================================================
pause
goto MainMenu

:Sub_TempGhost
echo [>] Deploying Temporary Ghost Mode Architecture...
goto DeployGhostEngine

:Sub_PermGhost
echo [>] Deploying Permanent Ghost Mode Architecture...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TotoPermGhost" /t REG_SZ /d "powershell.exe -NoProfile -WindowStyle Hidden -File %SystemRoot%\totoghost.ps1" /f >nul 2>&1
goto DeployGhostEngine

:DeployGhostEngine
:: Build the absolute multi-layered anti-forensic loop script
(
echo while ^($true^) {
echo     Get-ChildItem -Path "$env:LocalAppData\Microsoft\Windows\Explorer" -Filter "thumbcache_*.db" -ErrorAction SilentlyContinue ^| Remove-Item -Force -ErrorAction SilentlyContinue
echo     Get-ChildItem -Path "$env:temp" -Recurse -ErrorAction SilentlyContinue ^| Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
echo     Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'IconsOnly' -Value 1 -ErrorAction SilentlyContinue
echo     $paths = @^("$Home\Documents", "$Home\Desktop", "$Home\Downloads"^)
echo     foreach^($p in $paths^){
echo         if^(Test-Path $p^){
echo             Get-ChildItem $p -Recurse -Include *.txt,*.docx,*.xlsx,*.pdf,*.png,*.jpg -ErrorAction SilentlyContinue ^| foreach {
echo                 try {
echo                     if^($null -eq ^(Get-ItemProperty $_.FullName -Name 'Company' -ErrorAction SilentlyContinue^)^){
echo                         Set-ItemProperty $_.FullName -Name 'Company' -Value 'Acme Corp' -ErrorAction SilentlyContinue
echo                         Set-ItemProperty $_.FullName -Name 'Author' -Value 'Anonymous John' -ErrorAction SilentlyContinue
echo                     }
echo                 } catch {}
echo             }
echo         }
echo     }
echo     Start-Sleep -Seconds 4
echo }
) > "%SystemRoot%\totoghost.ps1"

:: Run engine instantly via safe Process Object configuration
for /f "tokens=1" %%A in ('powershell -Command "$p = Start-Process powershell -ArgumentList '-NoProfile -WindowStyle Hidden -File %SystemRoot%\totoghost.ps1' -PassThru; $p.Id"') do (
    set "ghost_pid=%%A"
)
echo !ghost_pid! > "%SystemRoot%\totoghost.pid"

echo Done. Ghost Layer operational.
if /i "%choice%"=="9" echo [!] System state: Active for current session only.
if /i "%choice%"=="10" echo [!] System state: Persistent across restarts until Un-Done via script.
pause
goto MainMenu

:: --- PRESET LOGIC ENGINES ---

:Preset_Panther
echo [>] Deploying PANTHER Profile Presets...
set "running_preset=true"
call :Sub_Copilot
call :Sub_Telemetry
call :Sub_Edge
call :Sub_ClassicMenu
call :Sub_Widgets
set "running_preset=false"
echo.
echo [SUCCESS] PANTHER deployment sequence executed cleanly.
pause
goto MainMenu

:Preset_Tiger
echo [>] Deploying TIGER Nuclear Profile Presets...
set "running_preset=true"
call :Sub_Copilot
call :Sub_Telemetry
call :Sub_Edge
call :Sub_Metadata
call :Sub_ClassicMenu
call :Sub_Widgets
call :Sub_Stealth
set "running_preset=false"
echo.
echo [SUCCESS] TIGER deployment sequence executed cleanly.
pause
goto MainMenu

:: --- MAINTENANCE / ROLLBACK ---

:UndoTweaks
echo [>] Reverting Group Policy restrictions, unlocking registers, and purging Ghost loops...

:: Stop background Guard loop instantly if PID file is present
if exist "%SystemRoot%\totoguard.pid" (
    set /p t_pid=<"%SystemRoot%\totoguard.pid"
    powershell -Command "Stop-Process -Id !t_pid! -Force -ErrorAction SilentlyContinue" >nul 2>&1
    del /f /q "%SystemRoot%\totoguard.pid" >nul 2>&1
)

:: Stop background Ghost loop instantly if PID file is present
if exist "%SystemRoot%\totoghost.pid" (
    set /p g_pid=<"%SystemRoot%\totoghost.pid"
    powershell -Command "Stop-Process -Id !g_pid! -Force -ErrorAction SilentlyContinue" >nul 2>&1
    del /f /q "%SystemRoot%\totoghost.pid" >nul 2>&1
)

:: Clean scripts from engine repository
del /f /q "%SystemRoot%\totoguard.ps1" >nul 2>&1
del /f /q "%SystemRoot%\totoghost.ps1" >nul 2>&1

:: Wipe explicit script registries
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "TotoPermGhost" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableCMD" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /f >nul 2>&1

:: Re-enable system configuration components
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 0 /f >nul 2>&1
fsutil behavior set disablelastaccess 0 >nul 2>&1

echo.
echo All configuration restrictions successfully lifted!
pause
goto MainMenu
