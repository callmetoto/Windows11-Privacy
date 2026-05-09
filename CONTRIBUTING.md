# Contributing to Win11 Master Debloat 🚀

First off, thank you for considering contributing! It’s people like you who make this tool better for everyone.

### 🛠️ How Can I Contribute?

#### 1. Reporting Bugs
* Check the **Issues** tab to see if the bug has already been reported.
* If not, open a new issue. Please include:
    * Your Windows 11 Build version (e.g., 23H2).
    * Exactly which menu option you ran.
    * What happened (e.g., "The taskbar disappeared").

#### 2. Suggesting New Tweaks
Have a registry hack or a service to disable that I missed? 
* Open an issue with the tag `enhancement`.
* Please provide the **Registry Path** and a brief explanation of what it does.

#### 3. Pull Requests (Code Changes)
1. Fork the repo and create your branch from `main`.
2. If you are adding a new feature to the `.bat` file, ensure you follow the **"Hacker Green"** UI style.
3. Test your changes on a VM or a spare machine first!
4. Submit your PR with a clear description of the changes.

### 📜 Script Standards
* **Transparency:** We do not use compiled `.exe` files. All changes must be visible in the `.bat` source code.
* **Safety:** Every "destructive" tweak (like removing system apps) should ideally have a corresponding "Undo" logic in the Revert section.

### ⚖️ Code of Conduct
By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

---
**Questions?** Reach out via GitHub Issues or contact [@callmetoto](https://github.com).
