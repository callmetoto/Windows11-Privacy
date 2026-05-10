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
echo                     !!! WARNING !!!
echo ==========================================================
echo This script modifies System Registry settings and removes 
echo Windows App packages. While safe for most, you should:
echo.
echo 1. Create a SYSTEM RESTORE POINT before continuing.
echo 2. Understand that some features (like Copilot) require 
echo    a Store download to reinstall.
echo 3. Use Tiger Privacy only if you don't mind losing 
echo    "Recent Files" history in File Explorer.
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
echo [1] Remove COPILOT (App ^& Taskbar)
echo [2] Disable TELEMETRY ^& ADS (Privacy Pack)
echo [3] Strip EDGE Bloat (Stop Background Processes)
echo [4] Disable METADATA ^& Activity Tracking
echo [5] Restore CLASSIC Right-Click Menu
echo ----------------------------------------------------------
echo [P] PRESET: PANTHER (All of the above EXCEPT Metadata)
echo [T] PRESET: TIGER   (The Nuclear Option - Everything)
echo ----------------------------------------------------------
echo [U] UNDO (Restore Copilot ^& Modern Menu)
echo [X] EXIT
echo ==========================================================
echo.
set /p "choice=Select an option: "

if /i "%choice%"=="1" goto Sub_Copilot
if /i "%choice%"=="2" goto Sub_Telemetry
if /i "%choice%"=="3" goto Sub_Edge
if /i "%choice%"=="4" goto Sub_Metadata
if /i "%choice%"=="5" goto Sub_ClassicMenu
if /i "%choice%"=="P" goto Preset_Panther
if /i "%choice%"=="T" goto Preset_Tiger
if /i "%choice%"=="U" goto UndoTweaks
if /i "%choice%"=="X" exit
goto MainMenu

:: --- INDIVIDUAL SUB-ROUTINES ---

:Sub_Copilot
echo [>] Nuking Copilot...
taskkill /f /im "Copilot.exe" >nul 2>&1
powershell -command "Get-AppxPackage *Microsoft.Copilot* | Remove-AppxPackage" >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
echo Done.
if /i "%running_preset%"=="true" goto :EOF
pause
goto MainMenu

:Sub_Telemetry
echo [>] Killing Telemetry ^& Ads...
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

:: --- PRESETS ---

:Preset_Panther
cls
set "running_preset=true"
echo [RUNNING PANTHER PRESET]
call :Sub_Copilot
call :Sub_Telemetry
call :Sub_Edge
call :Sub_ClassicMenu
set "running_preset=false"
goto RestartExplorer

:Preset_Tiger
cls
set "running_preset=true"
echo [RUNNING TIGER PRESET - TOTAL CLEAN]
call :Sub_Copilot
call :Sub_Telemetry
call :Sub_Edge
call :Sub_Metadata
call :Sub_ClassicMenu
set "running_preset=false"
goto RestartExplorer

:: --- UTILS ---

:RestartExplorer
echo.
echo ==========================================================
echo RELOADING EXPLORER TO APPLY CHANGES...
echo ==========================================================
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto MainMenu

:UndoTweaks
cls
echo [>] Restoring Defaults...
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
goto RestartExplorer
