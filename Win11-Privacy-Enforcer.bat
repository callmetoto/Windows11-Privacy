@echo off
:: Set Hacker Vibes: Black background (0) with Light Green text (A)
color 0A
title Win11 Master Debloat by callmetoto

:: ---------------------------------------------------
:: ADMIN CHECK
:: ---------------------------------------------------
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo.
    echo ======================================================
    echo     [ERROR] ADMINISTRATIVE RIGHTS REQUIRED
    echo ======================================================
    echo.
    echo This script must be run as an Administrator to modify 
    echo system registry keys and services.
    echo.
    echo Please right-click the .bat file and select:
    echo "Run as administrator"
    echo.
    pause
    exit /b
)

:: ---------------------------------------------------
:: MAIN MENU
:: ---------------------------------------------------
:MainMenu
cls
color 0A
echo ==========================================================
echo       WINDOWS 11 MASTER DEBLOAT ^& PRIVACY SCRIPT
echo ==========================================================
echo                 Created by: callmetoto (GitHub)
echo.
echo  [1] Apply All Debloat Tweaks (The Magic Button)
echo  [2] Disable File Metadata Tracking (USE AT OWN RISK)
echo  [3] View Script Details ^& License
echo  [4] Exit
echo ==========================================================
echo.
set /p "choice=Please enter your choice (1-4): "

if "%choice%"=="1" goto ApplyTweaks
if "%choice%"=="2" goto DisableMetadata
if "%choice%"=="3" goto ShowDetails
if "%choice%"=="4" exit

:: If invalid input, reload menu
goto MainMenu


:: ---------------------------------------------------
:: OPTION 2: METADATA DISABLE (USE AT OWN RISK)
:: ---------------------------------------------------
:DisableMetadata
cls
color 0C
echo ==========================================================
echo       WARNING: DISABLING NTFS LAST ACCESS TIMESTAMP
echo ==========================================================
echo.
echo You are about to disable NTFS Last Access Time updates.
echo This stops Windows from writing metadata to your files 
echo tracking the exact time they are opened/read.
echo.
echo [!] USE AT OWN RISK: Some third-party backup or 
echo synchronization software may rely on this metadata.
echo ==========================================================
echo.
set /p "proceed=Are you sure you want to proceed? (Y/N): "
if /I "%proceed%" neq "Y" (
    color 0A
    goto MainMenu
)

color 0A
echo.
echo Disabling File Access Metadata...
:: Setting disablelastaccess to 1 turns OFF the tracking
fsutil behavior set disablelastaccess 1 >nul 2>&1
echo Done! Metadata tracking on file open is now disabled.
echo.
pause
goto MainMenu


:: ---------------------------------------------------
:: OPTION 3: METADATA & LICENSE SCREEN
:: ---------------------------------------------------
:ShowDetails
cls
echo ==========================================================
echo               SCRIPT METADATA ^& DETAILS
echo ==========================================================
echo  AUTHOR: callmetoto (GitHub)
echo.
echo  WHAT THIS SCRIPT DOES:
echo  * Eradicates Windows Copilot globally
echo  * Stops File History ^& Telemetry Services
echo  * Disables Edge background bloat ^& sidebars
echo  * Clears Recent Items ^& Start Menu tracking
echo  * Hides "Recently Added" apps from the Start Menu
echo  * Removes Taskbar News ^& Widgets
echo  * Stops silent automatic app installs
echo  * Restores the Classic Windows 10 Right-Click Menu
echo  * (Optional) Disables File Open Metadata tracking
echo.
echo  LICENSE: MIT License
echo  Copyright (c) 2026 callmetoto
echo  Permission is hereby granted, free of charge, to any person
echo  obtaining a copy of this software and associated documentation
echo  files (the "Software"), to deal in the Software without
echo  restriction, including without limitation the rights to use,
echo  copy, modify, merge, publish, distribute, sublicense, and/or
echo  sell copies of the Software.
echo ==========================================================
echo.
pause
goto MainMenu


:: ---------------------------------------------------
:: OPTION 1: THE TWEAKS
:: ---------------------------------------------------
:ApplyTweaks
cls
echo ==========================================================
echo               APPLYING TWEAKS... PLEASE WAIT
echo ==========================================================
echo.

echo [1/9] Nuking Windows Copilot globally...
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1

echo [2/9] Stopping and Disabling File History...
sc stop fhsvc >nul 2>&1
sc config fhsvc start= disabled >nul 2>&1

echo [3/9] Disabling Edge Background processes and Sidebar...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HubsSidebarEnabled /t REG_DWORD /d 0 /f >nul 2>&1

echo [4/9] Wiping Recent Items ^& Start Menu history...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f >nul 2>&1
del /f /q /s "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1

echo [5/9] Removing "Recently Added Apps" from Start Menu...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HideRecentlyAddedApps /t REG_DWORD /d 1 /f >nul 2>&1

echo [6/9] Disabling Telemetry (Spyware)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1

echo [7/9] Removing Widgets and Taskbar News feed...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1

echo [8/9] Disabling silent installation of sponsored apps...
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1

echo [9/9] Restoring classic full context menu (Right-Click)...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /f >nul 2>&1

echo.
echo ==========================================================
echo   TWEAKS APPLIED SUCCESSFULLY! RESTARTING EXPLORER...
echo ==========================================================
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo All operations complete. A full PC restart is recommended.
echo Press any key to return to the Main Menu...
pause >nul
goto MainMenu
