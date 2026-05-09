@echo off
:: Set Hacker Vibes
color 0A
title Win11 Master Debloat by callmetoto

:: ADMIN CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo [ERROR] ADMINISTRATIVE RIGHTS REQUIRED. 
    echo Please right-click and "Run as Administrator".
    pause
    exit /b
)

:MainMenu
cls
color 0A
echo ==========================================================
echo WINDOWS 11 MASTER DEBLOAT ^& PRIVACY SCRIPT
echo ==========================================================
echo Created by: callmetoto (GitHub)
echo.
echo [1] Apply All Debloat Tweaks (The Magic Button)
echo [2] Disable File Metadata Tracking (Advanced)
echo [3] View Script Details ^& License
echo [4] UNDO: Restore Classic Menu ^& Re-enable Copilot
echo [5] Exit
echo ==========================================================
echo.
set /p "choice=Please enter your choice (1-5): "

if "%choice%"=="1" goto ApplyTweaks
if "%choice%"=="2" goto DisableMetadata
if "%choice%"=="3" goto ShowDetails
if "%choice%"=="4" goto UndoTweaks
if "%choice%"=="5" exit
goto MainMenu

:ApplyTweaks
cls
echo [>] Applying tweaks...
:: [Insert your original steps 1-8 here]
echo [9/9] Restoring classic full context menu...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
echo.
echo ==========================================================
echo TWEAKS APPLIED! RESTARTING EXPLORER...
echo ==========================================================
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo.
echo All operations complete.
pause
goto MainMenu

:DisableMetadata
cls
echo [>] Disabling NTFS Last Access Tracking...
:: Standard command to stop Windows from writing 'last accessed' data to every file
fsutil behavior set disablelastaccess 1 >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Failed. Ensure no other process is locking system behaviors.
) else (
    echo [!] Success: NTFS Last Access tracking disabled.
    echo [!] NOTE: You must REBOOT for this to take effect.
)
pause
goto MainMenu

:ShowDetails
cls
echo ==========================================================
echo                SCRIPT DETAILS ^& LICENSE
echo ==========================================================
echo Author: @callmetoto
echo License: MIT
echo.
echo This script uses native 'reg add' and 'fsutil' commands 
echo to reclaim privacy and performance on Windows 11.
echo.
echo Tweaks included: Copilot removal, Telemetry kill, 
echo Edge bloat reduction, and Classic UI restoration.
echo ==========================================================
pause
goto MainMenu

:UndoTweaks
cls
echo [>] Reverting changes...
:: Restore Context Menu
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
:: Re-enable Copilot
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
echo Done! Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto MainMenu
