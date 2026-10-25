# xtHyprKde 🌌

> **Hyprland aesthetic meets KDE Plasma 6 stability.**  
> A customized, modern, dark cyber-neon rice for KDE Plasma 6 on Wayland (Arch Linux).

[![KDE Plasma](https://img.shields.io/badge/KDE_Plasma-6.x-blue?logo=kde)](https://kde.org)
[![Wayland](https://img.shields.io/badge/Display_Server-Wayland-brightgreen)](https://wayland.freedesktop.org/)
[![Arch Linux](https://img.shields.io/badge/Distro-Arch_Linux-1793d1?logo=arch-linux)](https://archlinux.org)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## ✨ Overview

**xtHyprKde** transforms KDE Plasma 6 into a sleek, minimalist desktop inspired by modern Wayland tiling environments like **Hyprland**, eliminating clunky legacy skins and redundant bars while keeping 100% of KDE's daily stability.

---

## 🎨 Configuration & Architecture

### 1. Panel Layout (Top Bar + Minimal Auto-Hide Dock)
* **Top Bar (Floating Pill)**:
  * Sleek 32px floating top bar with rounded corners.
  * Left: Minimalist Arch Linux launcher icon (`Meta` key shortcut).
  * Center: Clean Digital Clock (`HH:mm · ddd, D MMM`).
  * Right: Discreet system tray (audio volume, network, notifications).
* **Bottom Dock (Auto-Hidden)**:
  * Compact 42px application dock that **completely disappears** when not in use (`autohide`).
  * Never interferes with active windows; only slides up when moving the cursor to the bottom screen edge.

### 2. Dual Launcher System
* **`Alt + Space`**: Centered floating **KRunner** with deep blur (Spotlight / Rofi mode) for instant search, math, translation, and file browsing.
* **`Meta` (Super)**: Triggers the clean top-left application launcher.

### 3. Window Aesthetics & Border-Only Look
* **Zero Bulky Titlebars**: Native KWin rule renders windows in clean **Border-Only** mode with rounded corners.
* **Glowing Active Borders**: The active window is subtly outlined with neon cyan (`#00f5d4`).
* **Dim Inactive Windows**: Inactive windows are automatically dimmed by 15% to visually focus your active workflow.
* **Wayland Drag Gesture**: Hold `Meta` + Left Click anywhere on a window to drag/move; hold `Meta` + Right Click to resize.

### 4. Typography & Styling
* **UI Font**: **Inter** (10pt) for clean, high-legibility menus and text.
* **Code / Monospace**: **JetBrains Mono Nerd Font** (10pt).
* **Cursors**: **Bibata Modern Ice** (rounded material aesthetic).
* **Icons**: **Papirus-Dark**.

### 5. Terminal & Shell
* **Konsole**: 85% opacity with Gaussian background blur, no scrollbar clutter.
* **Starship Prompt**: Minimalist prompt with directory path, git status, command duration, and cyan `❯` character.

---

## ⌨️ Shortcuts Reference

| Shortcut | Action |
| :--- | :--- |
| **`Meta + Q`** | Close active window (Hyprland / i3 style) |
| **`Alt + Space`** | Centered Launcher (Rofi / Spotlight search) |
| **`Meta`** | Open Application Menu |
| **`Meta + Left / Right`** | Tile window to Left / Right half |
| **`Meta + Up / Down`** | Maximize / Restore window |
| **`Meta + Shift + Arrows`** | Tile window to Screen Corners (quarters) |
| **`Meta + T`** | Interactive Tiling Layout Editor (Plasma 6) |
| **`Meta + Left Click Drag`** | Move window from anywhere |
| **`Meta + Right Click Drag`**| Resize window from anywhere |

---

## 🚀 Installation & Management

### Quick Apply
```bash
cd ~/workspace/xtHyprKde
./apply.sh
```

### Full Reinstall / Setup
```bash
./install.sh
```

### Safety Backup & Restore
Before applying changes, a full backup is automatically created in `~/.config/xtHyprKde-backups/`.  
To restore at any time:
```bash
./scripts/restore.sh
```

---

## 📄 License

Open-source under the [MIT License](LICENSE).
