#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "          xtHyprKde - Installer & Environment Setup       "
echo "=========================================================="

# 1. Package Dependencies
echo "==> [Step 1] Checking system dependencies..."

MISSING_PKGS=()
for pkg in papirus-icon-theme ttf-jetbrains-mono-nerd; do
    if ! pacman -Qq "$pkg" >/dev/null 2>&1; then
        MISSING_PKGS+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo "  [i] Installing missing packages: ${MISSING_PKGS[*]}..."
    sudo pacman -S --needed --noconfirm "${MISSING_PKGS[@]}"
else
    echo "  [+] Essential packages are already installed."
fi

# 2. Local Font (Inter)
echo "==> [Step 2] Ensuring Inter typeface is available..."
if [ ! -d "$HOME/.local/share/fonts/Inter" ]; then
    mkdir -p "$HOME/.local/share/fonts/Inter"
    curl -L -s "https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip" -o /tmp/inter.zip
    unzip -q -o /tmp/inter.zip -d /tmp/inter_extracted
    cp /tmp/inter_extracted/*.otf "$HOME/.local/share/fonts/Inter/" 2>/dev/null || cp /tmp/inter_extracted/extras/otf/*.otf "$HOME/.local/share/fonts/Inter/" 2>/dev/null || true
    fc-cache -f "$HOME/.local/share/fonts/Inter/"
    rm -rf /tmp/inter.zip /tmp/inter_extracted
fi

# 3. Local Cursor (Bibata Modern Ice)
echo "==> [Step 3] Ensuring Bibata Modern Ice cursor is available..."
if [ ! -d "$HOME/.local/share/icons/Bibata-Modern-Ice" ]; then
    mkdir -p "$HOME/.local/share/icons" "$HOME/.icons"
    curl -L -s "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Ice.tar.xz" -o /tmp/bibata.tar.xz
    tar -xf /tmp/bibata.tar.xz -C "$HOME/.local/share/icons/" 2>/dev/null || true
    ln -sf "$HOME/.local/share/icons/Bibata-Modern-Ice" "$HOME/.icons/Bibata-Modern-Ice" 2>/dev/null || true
    rm -f /tmp/bibata.tar.xz
fi

# 4. Safety Backup
echo "==> [Step 4] Creating configuration backup..."
bash "$REPO_DIR/scripts/backup.sh"

# 5. Apply Theme
echo "==> [Step 5] Applying xtHyprKde..."
bash "$REPO_DIR/apply.sh"

echo ""
echo "=========================================================="
echo "           xtHyprKde setup completed successfully!        "
echo "=========================================================="
