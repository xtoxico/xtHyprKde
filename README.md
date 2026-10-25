# xtHyprKde 🌌

> **Hyprland aesthetic meets KDE Plasma 6 stability.**  
> A clean, modern, dark cyber-neon rice for KDE Plasma 6 on Wayland (Arch Linux).

[![KDE Plasma](https://img.shields.io/badge/KDE_Plasma-6.x-blue?logo=kde)](https://kde.org)
[![Wayland](https://img.shields.io/badge/Display_Server-Wayland-brightgreen)](https://wayland.freedesktop.org/)
[![Arch Linux](https://img.shields.io/badge/Distro-Arch_Linux-1793d1?logo=arch-linux)](https://archlinux.org)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## ✨ Overview

Do you love the minimalist, glowing aesthetic of modern Wayland tiling window managers like **Hyprland** (thin glowing borders, deep frosted glass blur, floating pill bars, centered floating launchers, snappy animations), but prefer the day-to-day stability, multi-monitor handling, and full desktop features of **KDE Plasma 6**?

**xtHyprKde** bridges that gap. It replaces legacy, glitchy Aurorae themes with a native, hardware-accelerated configuration tailored specifically for **Plasma 6 Wayland**.

---

## 🎨 Features

* **`xtHyprDark` Color Scheme**: A carefully crafted dark palette inspired by *Catppuccin Mocha* and *Tokyo Night* with vibrant neon cyan (`#00f5d4`) and electric mauve accents.
* **Glitches-Free Window Decorations**:
  * Clean vector styling (no pixelated legacy Aurorae skins).
  * Rounded window corners and subtle borders.
  * Native Klassy support with colored active window outlines.
  * Borderless maximized windows.
* **Frosted Glass Terminal (`Konsole`)**:
  * 85% opacity with deep Gaussian blur.
  * JetBrains Mono Nerd Font support.
  * Hidden scrollbars for a clean Kitty/Alacritty look.
* **Rofi-Style Centered Launcher**:
  * KRunner configured as a centered, floating search bar with background blur.
* **Snappy Hyprland Animations**:
  * KWin animation duration tuned to `0.5x` for instantaneous transitions.
  * Deep blur filter (`BlurStrength=12`, `NoiseStrength=0`).
* **Minimalist 4K Neon Wallpaper**:
  * Included high-res dark neon wallpaper (`assets/wallpapers/xtHypr_neon.png`).
* **Safety First**:
  * Automatic backup of your existing configs before applying.
  * One-click restore script (`./scripts/restore.sh`).

---

## 🚀 Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/xtoxico/xtHyprKde.git ~/workspace/xtHyprKde
cd ~/workspace/xtHyprKde
```

### 2. Run the Installer

```bash
./install.sh
```

The installer will:
1. Verify essential packages (`papirus-icon-theme`, `ttf-jetbrains-mono-nerd`).
2. Offer to install `klassy-bin` from AUR for custom glowing outlines (optional).
3. Create a safety backup in `~/.config/xtHyprKde-backups/`.
4. Apply all color schemes, konsole profiles, KWin effects, and wallpapers.

---

## 🔄 Re-applying or Reverting

* **Quick re-apply** (without package checks):
  ```bash
  ./apply.sh
  ```

* **One-click restore** (reverts your desktop to the backup taken before install):
  ```bash
  ./scripts/restore.sh
  ```

---

## 🛠 Recommended Waybar-Style Floating Top Bar

To complete the Hyprland look with your Plasma panel:

1. Right-click your top panel → **Edit Panel...** (Modificar panel).
2. Set **Floating Panel** to **ON** (Panel flotante).
3. Set panel height to **32px - 36px**.
4. Widgets order:
   * **Left:** `Pager` (Paginador de escritorios) configured with numbers (`1`, `2`, `3`).
   * **Spacer:** (Expanding spacer / Separador expandible).
   * **Center:** Minimalist `Digital Clock` (formato: `HH:mm · ddd D`).
   * **Spacer:** (Expanding spacer).
   * **Right:** Minimal `System Tray` (Bandeja del sistema).

---

## ⌨️ Useful Shortcuts

| Action | Shortcut |
| :--- | :--- |
| **Centered Launcher (Rofi style)** | `Alt + Space` |
| **Workspaces / Windows Overview** | `Meta` (Super) |
| **Interactive Tiling Layout Editor** | `Meta + T` |
| **Snap window to tiling zones** | `Shift + Drag window` |

---

## 📄 License

This project is open-source under the [MIT License](LICENSE).
