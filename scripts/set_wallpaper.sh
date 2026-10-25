#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
WALLPAPER_FILE="${1:-$REPO_DIR/assets/wallpapers/xtHypr_neon.png}"

if [ ! -f "$WALLPAPER_FILE" ]; then
    echo "[-] Wallpaper file not found: $WALLPAPER_FILE"
    exit 1
fi

# Ensure destination directory exists
mkdir -p "$HOME/.local/share/wallpapers/xtHyprKde"
cp "$WALLPAPER_FILE" "$HOME/.local/share/wallpapers/xtHyprKde/wallpaper.png"
INSTALLED_WALLPAPER="$HOME/.local/share/wallpapers/xtHyprKde/wallpaper.png"

echo "==> Setting wallpaper across all Plasma desktops: $INSTALLED_WALLPAPER"

qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
var allDesktops = desktops();
for (var i = 0; i < allDesktops.length; i++) {
    var d = allDesktops[i];
    d.wallpaperPlugin = 'org.kde.image';
    d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
    d.writeConfig('Image', 'file://${INSTALLED_WALLPAPER}');
}
" || true

echo "  [+] Wallpaper applied."
