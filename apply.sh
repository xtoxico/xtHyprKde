#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "          xtHyprKde - Applying Hyprland Aesthetic        "
echo "=========================================================="

# 1. Colorscheme
echo "==> [1/10] Applying color scheme (xtHyprDark)..."
mkdir -p "$HOME/.local/share/color-schemes"
cp "$REPO_DIR/configs/color-schemes/xtHyprDark.colors" "$HOME/.local/share/color-schemes/"
plasma-apply-colorscheme xtHyprDark || true

# 2. Fonts (Inter + JetBrains Mono Nerd Font)
echo "==> [2/10] Applying typography (Inter + JetBrains Mono)..."
if [ -d "$HOME/.local/share/fonts/Inter" ]; then
    kwriteconfig6 --file kdeglobals --group General --key font "Inter,10,-1,5,50,0,0,0,0,0"
    kwriteconfig6 --file kdeglobals --group General --key fixed "JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0"
    kwriteconfig6 --file kdeglobals --group General --key smallestReadableFont "Inter,8,-1,5,50,0,0,0,0,0"
    kwriteconfig6 --file kdeglobals --group General --key toolBarFont "Inter,10,-1,5,50,0,0,0,0,0"
    kwriteconfig6 --file kdeglobals --group General --key menuFont "Inter,10,-1,5,50,0,0,0,0,0"
    kwriteconfig6 --file kdeglobals --group WM --key activeFont "Inter,9,-1,5,50,0,0,0,0,0"
fi

# 3. Icons & Cursors
echo "==> [3/10] Configuring Papirus-Dark and Bibata cursor..."
kwriteconfig6 --file kdeglobals --group Icons --key Theme "Papirus-Dark"
if [ -d "$HOME/.local/share/icons/Bibata-Modern-Ice" ] || [ -d "$HOME/.icons/Bibata-Modern-Ice" ]; then
    plasma-apply-cursortheme Bibata-Modern-Ice 2>/dev/null || true
fi

# 4. Konsole & Starship
echo "==> [4/10] Setting up Konsole (frosted blur) & Starship prompt..."
mkdir -p "$HOME/.local/share/konsole"
cp "$REPO_DIR/configs/konsole/xtHypr.colorscheme" "$HOME/.local/share/konsole/"
cp "$REPO_DIR/configs/konsole/xtHypr.profile" "$HOME/.local/share/konsole/"
kwriteconfig6 --file konsolerc --group "Desktop Entry" --key DefaultProfile "xtHypr.profile"
if [ -f "$REPO_DIR/configs/starship/starship.toml" ]; then
    cp "$REPO_DIR/configs/starship/starship.toml" "$HOME/.config/"
fi

# 5. KRunner (Spotlight centered mode on Alt+Space) & Launcher on Meta
echo "==> [5/10] Configuring dual launchers (KRunner centered + Meta key)..."
kwriteconfig6 --file krunnerrc --group General --key FreeFloating true
kwriteconfig6 --file krunnerrc --group General --key historyEnabled true
kwriteconfig6 --file krunnerrc --group General --key retainPriorSearch false
kwriteconfig6 --file kwinrc --group ModifierOnlyShortcuts --key Meta "org.kde.plasmashell,/PlasmaShell,org.kde.PlasmaShell,activateLauncherMenu"

# 6. Window Decoration: Slim Compact Titlebar with small buttons
echo "==> [6/10] Setting up slim compact titlebars (easy dragging & small buttons)..."
if [ -f "$REPO_DIR/configs/kwin/breezerc" ]; then
    cp "$REPO_DIR/configs/kwin/breezerc" "$HOME/.config/breezerc"
fi
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key library "org.kde.breeze"
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key theme "Breeze"
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key BorderSize "Normal"
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key BorderSizeAuto false
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key ButtonsOnRight "IAX"
kwriteconfig6 --file kwinrc --group "org.kde.kdecoration2" --key ButtonsOnLeft ""
kwriteconfig6 --file kwinrc --group Windows --key BorderlessMaximizedWindows true

# 7. KWin Compositor & Effects (Dim inactive, fast speed, blur)
echo "==> [7/10] Tuning KWin compositor (dim inactive, fast animations, blur)..."
kwriteconfig6 --file kwinrc --group Plugins --key blurEnabled true
kwriteconfig6 --file kwinrc --group Plugins --key contrastEnabled true
kwriteconfig6 --file kwinrc --group Plugins --key diminactiveEnabled true
kwriteconfig6 --file kwinrc --group Effect-blur --key BlurStrength 12
kwriteconfig6 --file kwinrc --group Effect-blur --key NoiseStrength 0
kwriteconfig6 --file kwinrc --group Effect-diminactive --key DimBy 15
kwriteconfig6 --file kwinrc --group KDE --key AnimationDurationFactor 0.5

# 8. Shortcuts: Meta+Q to close window & quick tile corner keys
echo "==> [8/10] Configuring shortcuts (Meta+Q to close, Meta+Arrows to tile)..."
sed -i 's/Window Close=.*/Window Close=Alt+F4\tMeta+Q,Alt+F4,Cerrar la ventana/' "$HOME/.config/kglobalshortcutsrc" 2>/dev/null || true

# 9. Panels: Floating Top Bar + Minimal Auto-Hide Bottom Dock
echo "==> [9/10] Applying clean panel layout (Top bar + Auto-hide minimal bottom dock)..."
qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var p = panels();
for (var i = 0; i < p.length; i++) {
    if (p[i].location === 'bottom') {
        p[i].hiding = 'autohide';
        p[i].height = 42;
    } else if (p[i].location === 'top') {
        p[i].height = 32;
        p[i].floating = true;
    }
}
" 2>/dev/null || true

# Set Arch logo on launcher
kwriteconfig6 --file plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 212 --group Applets --group 213 --group Configuration --group General --key icon "distributor-logo-archlinux" 2>/dev/null || true

# 10. Wallpaper
echo "==> [10/10] Applying 4K dark neon wallpaper..."
bash "$REPO_DIR/scripts/set_wallpaper.sh" "$REPO_DIR/assets/wallpapers/xtHypr_neon.png"

# Reload KWin
echo "==> Reloading KWin window manager..."
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true

echo ""
echo "=========================================================="
echo "          ✓ xtHyprKde customized and applied!             "
echo "=========================================================="
