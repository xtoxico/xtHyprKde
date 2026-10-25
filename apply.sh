#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "          xtHyprKde - Applying Hyprland Aesthetic        "
echo "=========================================================="

# 1. Colorscheme
echo "==> [1/7] Installing and applying color scheme (xtHyprDark)..."
mkdir -p "$HOME/.local/share/color-schemes"
cp "$REPO_DIR/configs/color-schemes/xtHyprDark.colors" "$HOME/.local/share/color-schemes/"
plasma-apply-colorscheme xtHyprDark || true

# 2. Icons & Cursors
echo "==> [2/7] Configuring icons and cursors..."
kwriteconfig6 --file kdeglobals --group Icons --key Theme "Papirus-Dark"
plasma-apply-cursortheme breeze_cursors 2>/dev/null || true

# 3. Konsole
echo "==> [3/7] Setting up Konsole (frosted blur & transparent)..."
mkdir -p "$HOME/.local/share/konsole"
cp "$REPO_DIR/configs/konsole/xtHypr.colorscheme" "$HOME/.local/share/konsole/"
cp "$REPO_DIR/configs/konsole/xtHypr.profile" "$HOME/.local/share/konsole/"
kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile "xtHypr.profile"

# 4. KRunner (Rofi / Spotlight centered floating launcher)
echo "==> [4/7] Configuring KRunner (centered floating launcher)..."
kwriteconfig6 --file krunnerrc --group General --key FreeFloating true
kwriteconfig6 --file krunnerrc --group General --key historyEnabled true
kwriteconfig6 --file krunnerrc --group General --key retainPriorSearch false

# 5. KWin compositor & effects (Blur, Speed, Borders)
echo "==> [5/7] Tuning KWin compositor (Hypr-speed animations & deep blur)..."
kwriteconfig6 --file kwinrc --group Plugins --key blurEnabled true
kwriteconfig6 --file kwinrc --group Plugins --key contrastEnabled true
kwriteconfig6 --file kwinrc --group Effect-blur --key BlurStrength 12
kwriteconfig6 --file kwinrc --group Effect-blur --key NoiseStrength 0
kwriteconfig6 --file kwinrc --group KDE --key AnimationDurationFactor 0.5
kwriteconfig6 --file kwinrc --group Windows --key BorderlessMaximizedWindows true

# Window decorations (Check for Klassy, fallback to clean Breeze)
if pacman -Qq klassy-bin >/dev/null 2>&1 || pacman -Qq klassy >/dev/null 2>&1; then
    echo "  [+] Klassy detected: applying Klassy window decoration..."
    kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key library "org.kde.klassy"
    kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key theme "klassy"
    if [ -f "$REPO_DIR/configs/klassy/klassyrc" ]; then
        cp "$REPO_DIR/configs/klassy/klassyrc" "$HOME/.config/"
    fi
else
    echo "  [+] Setting up clean Breeze (border-focused, no legacy Aurorae glitches)..."
    kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key library "org.kde.breeze"
    kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key theme "Breeze"
    kwriteconfig6 --file breezerc --group Windeco --key ButtonSize "ButtonSmall"
    kwriteconfig6 --file breezerc --group Windeco --key DrawBackgroundGradient false
    kwriteconfig6 --file breezerc --group Windeco --key DrawSeparator false
    kwriteconfig6 --file breezerc --group Common --key OutlineCloseButton false
    kwriteconfig6 --file breezerc --group Common --key ShadowStrength 180
fi

# 6. Wallpaper
echo "==> [6/7] Applying high-res dark neon wallpaper..."
bash "$REPO_DIR/scripts/set_wallpaper.sh" "$REPO_DIR/assets/wallpapers/xtHypr_neon.png"

# 7. Reload KWin
echo "==> [7/7] Reloading KWin window manager..."
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true

echo ""
echo "=========================================================="
echo "          ✓ xtHyprKde theme applied successfully!        "
echo "=========================================================="
echo "Tip: Press Alt + Space to launch KRunner (centered Rofi style)."
echo "Tip: Open Konsole to enjoy the frosted glass transparent terminal."
echo "Tip: Run ./scripts/restore.sh if you ever want to revert."
