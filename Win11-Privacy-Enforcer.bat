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
echo                    !!! WARNING !!!
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
echo  !!! DANGER ZONE WARNING FOR LOCKDOWN MODE !!!
echo ----------------------------------------------------------
echo Lockdown Mode locks system policies, disables CMD/Regedit,
echo and aggressively reverts modifications in the background. 
echo DO NOT USE LOCKDOWN MODE IF YOU ARE NOT INTO THIS STUFF.
echo If you forget your Windows account password, you will be
echo permanently locked out of administrative system controls.
echo ==========================================================
echo.
set /p "agree=Do you want to proceed? (Y/N): "
if /i "%agree%" neq "Y" exit
goto MainMenu

:MainMenu
cls
color 0A
echo ==========================================================
echo       WINDOWS 11 MASTER DEBLOAT ^& PRIVACY SUITE
echo ==========================================================
echo [1] Remove COPILOT (App ^& Taskbar Integration)
echo [2] Disable TELEMETRY ^& ADS (Privacy Pack)
echo [3] Strip EDGE Bloat (Stop Background Processes)
echo [4] Disable METADATA ^& Activity Tracking
echo [5] Restore CLASSIC Right-Click Menu
echo [6] Nuke WIDGETS ^& NEWS FEED (Global Uninstall)
echo [7] Enable STEALTH MODE (Anti-Forensics / Zero External Footprint)
echo [8] Enable LOCKDOWN MODE (Secure Remote Support Containment - by callmetoto)
echo ----------------------------------------------------------
echo [P] PRESET: PANTHER (All of the above EXCEPT Metadata, Stealth, ^& Lockdown)
echo [T] PRESET: TIGER   (The Nuclear Option - EVERYTHING EXCEPT Lockdown)
echo ----------------------------------------------------------
echo [U] UNDO / LIFT LOCKDOWN (Restore Classic Menu ^& Open Containment)
echo [X] EXIT
echo ==========================================================
echo.
set /p "choice=Select an option: "

if /i "%choice%"=="1" goto Sub_Copilot
if /i "%choice%"=="2" goto Sub_Telemetry
if /i "%choice%"=="3" goto Sub_Edge
if /i "%choice%"=="4" goto Sub_Metadata
if /i "%choice%"=="5" goto Sub_ClassicMenu
if /i "%choice%"=="6" goto Sub_Widgets
if /i "%choice%"=="7" goto Sub_Stealth
if /i "%choice%"=="8" goto Sub_Lockdown
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
reg add "HKCU\Software\Software\Policies\Microsoft\Windows\Explorer" /v "DisableThumbsDBOnNetworkFolders" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableThumbnailCache" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Portable Devices" /v "EnablePortableDevices" /t REG_DWORD /d 0 /f >nul 2>&1
echo [>] Purging existing localized shell data blocks...
taskkill /f /im explorer.exe >nul 2>&1
del /f /q /s /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\AutomaticDestinations\*.*" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*" >nul 2>&1
del /f /q /s /a "%AppData%\Microsoft\Windows\Recent\*.*" >nul 2>&1
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
echo        AUTHENTICATION REQUIRED FOR LOCKDOWN MODE
echo ==========================================================
echo.
:: Secure local account validation loop via PowerShell API
powershell -Command "$p = read-host 'Enter local administrator password to confirm initialization' -AsSecureString; $b = New-Object System.Management.Automation.PSCredential($env:USERNAME,$p); try { Add-Type -AssemblyName System.DirectoryServices.AccountManagement; $pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine); if($pc.ValidateCredentials($env:USERNAME, [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p)))) { exit 0 } else { exit 1 } } catch { exit 1 }"
if %errorLevel% neq 0 (
    echo [ERROR] Invalid Account Password. Access Denied.
    pause
    goto MainMenu
)

color 0A
echo [>] Password verified. Activating Immutable Shield Mode...

:: 1. Force baseline registry snapshots for recovery
reg save HKLM\SOFTWARE %SystemRoot%\System32\config\SOFTWARE_SAFE.hiv /y >nul 2>&1
reg save HKCU %SystemRoot%\System32\config\USER_SAFE.hiv /y >nul 2>&1

:: 2. Set strict local policy rules blocking execution of command prompts and registry interfaces
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableCMD" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f >nul 2>&1

:: 3. Deploy the Real-Time Persistence Guard Engine [by callmetoto]
:: Writes a looped background keeper script that forces safe baseline overrides every 5 seconds
(
echo @echo off
echo :GuardLoop
echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "DisableCMD" /t REG_DWORD /d 1 /f ^>nul 2^\^>^&1
echo reg add "HKLM\SOFTWARE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableRegistryTools" /t REG_DWORD /d 1 /f ^>nul 2^\^>^&1
echo timeout /t 5 /nobreak ^>nul
echo goto GuardLoop
) > %SystemRoot%\System32\totoguard.bat

:: 4. Program the background task engine to ensure guard script survives system restarts
schtasks /create /tn "TotoLockdownGuard" /tr "%SystemRoot%\System32\totoguard.bat" /sc onstart /ru "SYSTEM" /f >nul 2>&1
start /b "" "%SystemRoot%\System32\totoguard.bat"

echo.
echo ==========================================================
echo SUCCESS: HARDENED LOCKDOWN ENGAGED!
echo.
echo System configuration changes are actively locked. CMD and 
