# Win11 Master Debloat Suite by callmetoto

A professional, lightweight, open-source batch script built to aggressively strip away telemetry, injected ads, background resource hogs, and modern UI clutter from Windows 11. Built with system stability and transparency in mind, this tool utilizes native system policy modifications and global package uninstallation to ensure deleted features remain gone across cumulative system updates.

## ⚡ Key Features

* **🚫 Nuke Windows Copilot:** Deep uninstallation targeting both the modern standalone Store package and legacy Taskbar UI integration globally (`-AllUsers`).
* **📰 Purge Widgets & News Feed:** Completely unhooks the intrusive Windows Web Experience Pack powering the Taskbar Widgets board, killing web-based ads and background RAM usage.
* **🕵️ Kill Telemetry & Search Ads:** Shuts down `DiagTrack`, disables active file collection, and blocks Bing suggestions inside the native Start Menu search bar.
* **🚀 Tame Edge Bloat:** Sets enterprise policies to stop Edge from using Startup Boost and lingering in background system processes.
* **🖱️ Classic Context Menu:** One-click restoration of the highly requested Windows 10 legacy right-click context menu.
* **📦 Prevent Silent Installs:** Tells Windows Content Delivery Manager to stop silently injecting unwanted third-party sponsored apps into your user profile.
* **🛡️ Multi-Tiered Presets:** Run individual modules, pick the stable **Panther** preset, or go nuclear with the **Tiger** preset to also wipe NTFS file metadata tracking.

## 🛠️ Installation & Usage

1. **Download:** Save `Win11-Privacy.Enforcer.bat` to your desktop.
2. **Verify (Optional):** Right-click -> Edit to audit the open-source code.
3. **Run:** Right-click and select **Run as Administrator**.
4. **Select Option:** Enter the number or preset letter of your choice. The script automatically reloads Windows Explorer to apply UI tweaks instantly.

## 🛡️ Safety & Transparency

This script is 100% transparent. It uses native `reg add`, `sc config`, and safe `powershell` Appx removal commands. No hidden executables, no third-party telemetry, no bloatware to remove bloatware. 

> **Pro Tip:** Always create a System Restore Point before running system-level modification scripts.
