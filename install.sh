#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=========================================================="
echo "          xtHyprKde - Installer & Environment Setup       "
echo "=========================================================="

# 1. Check & Install system dependencies
echo "==> [Step 1] Checking package dependencies..."

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

# Optional: Check if klassy-bin should be installed for exact Hyprland borders
if ! pacman -Qq klassy-bin >/dev/null 2>&1 && ! pacman -Qq klassy >/dev/null 2>&1; then
    if command -v yay >/dev/null 2>&1; then
        echo ""
        echo "  [?] Optional: 'klassy-bin' provides rounded corners and colored window outlines."
        read -r -p "      Do you want to install klassy-bin from AUR? [y/N]: " install_klassy
        if [[ "$install_klassy" =~ ^[Yy]$ ]]; then
            echo "  [+] Installing klassy-bin via yay..."
            yay -S --needed --noconfirm klassy-bin || echo "  [!] klassy-bin installation skipped or failed, falling back to Breeze."
        fi
    fi
fi

# 2. Run Backup
echo ""
echo "==> [Step 2] Backing up current desktop configuration..."
bash "$REPO_DIR/scripts/backup.sh"

# 3. Apply Theme
echo ""
echo "==> [Step 3] Applying xtHyprKde..."
bash "$REPO_DIR/apply.sh"

echo ""
echo "=========================================================="
echo "           xtHyprKde setup completed successfully!        "
echo "=========================================================="
