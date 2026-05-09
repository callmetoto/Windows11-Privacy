@echo off
:: Set Hacker Vibes
color 0A
title Win11 Master Debloat by callmetoto

:: ADMIN CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo [ERROR] ADMINISTRATIVE RIGHTS REQUIRED
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

:UndoTweaks
cls
echo Reverting changes...
:: Restore Context Menu
reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f >nul 2>&1
:: Re-enable Copilot
reg delete "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /f >nul 2>&1
echo Done! Restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
pause
goto MainMenu

:ApplyTweaks
cls
echo Applying tweaks...
:: ... (Keep your original code for 1/9 through 8/9) ...

:: Updated Step 9/9 for total reliability
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

:: ... (Keep the rest of your Metadata and ShowDetails sections) ...
