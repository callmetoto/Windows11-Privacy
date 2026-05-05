# Windows11
A powerful, interactive Windows 11 debloat and privacy batch script. Eradicates Copilot, disables telemetry, removes Edge/Start Menu bloat, blocks silent app installs, and restores the classic right-click menu. Transform your bloated OS into a fast, private powerhouse. Run as Admin

# Win11 Master Debloat & Privacy Script 🚀

A powerful, interactive, terminal-based batch script designed to clean up Windows 11, protect your privacy, and restore system performance. Strip away the bloatware, disable invasive telemetry, and get back to a clean, fast Windows experience—all with a classic green-on-black hacker terminal interface.

**Created by:** [@callmetoto](https://github.com/callmetoto)

---

## ⚡ Features

This script safely modifies system registry keys and services to perform the following:

*   **Nuke Windows Copilot:** Completely disables Copilot system-wide, removes it from the Taskbar, and stops it from integrating with apps.
*   **Kill Telemetry & Tracking:** Disables Windows telemetry (DiagTrack), WAP push services, and data collection policies.
*   **Tame Edge Bloat:** Stops Microsoft Edge from running in the background, disables Startup Boost, and turns off the annoying Hub/Copilot sidebar.
*   **Restore Classic Context Menu:** Bypasses the Windows 11 "Show more options" menu and restores the classic, full right-click menu.
*   **Remove UI Clutter:** 
    *   Removes Widgets and the Taskbar News feed.
    *   Hides "Recently Added" apps in the Start Menu.
    *   Clears Start Menu tracking and recent items history.
*   **Stop Silent Installs:** Prevents Windows from automatically downloading sponsored "Consumer Features" (like TikTok, Candy Crush, etc.) in the background.
*   **Disable File Metadata Tracking (Optional):** An advanced option to disable NTFS Last Access Time updates, preventing Windows from logging exactly when you open files.

---

## 🛠️ How to Use

**⚠️ Important:** Always create a System Restore point before running scripts that modify the Windows Registry.

1. **Download** the `CallmetotoDebloat.bat` file from this repository.
2. **Right-click** the file and select **Run as Administrator** (The script will not run without admin privileges).
3. Follow the on-screen interactive menu:
   * Press `1` to apply all main debloat and privacy tweaks.
   * Press `2` to disable file metadata tracking (read the warning!).
   * Press `3` to view script metadata and license info.
   * Press `4` to exit.
4. **Restart your PC** for all registry and system changes to take full effect.

---

## ⚠️ Disclaimer & "Use at Own Risk"

*   **Option 2 (Metadata Disable):** Disabling the NTFS Last Access Timestamp is great for privacy and slight drive speedups, but some third-party synchronization or backup software may rely on these timestamps. Use this specific feature at your own risk.
*   This script is provided "as-is". While it uses standard Windows commands and policies, the author is not responsible for any broken system features or data loss. 

---

## 📄 License

This project is licensed under the **MIT License**.

Copyright (c) 2024 callmetoto

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.
