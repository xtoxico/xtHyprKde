#!/usr/bin/env bash
set -e

BACKUP_ROOT="$HOME/.config/xtHyprKde-backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$BACKUP_ROOT/backup_$TIMESTAMP"

echo "==> Creating backup in $BACKUP_DIR..."
mkdir -p "$BACKUP_DIR"

CONFIG_FILES=(
    "kwinrc"
    "kdeglobals"
    "plasmarc"
    "krunnerrc"
    "plasma-org.kde.plasma.desktop-appletsrc"
    "breezerc"
    "klassyrc"
    "kglobalshortcutsrc"
)

for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$HOME/.config/$file" ]; then
        cp "$HOME/.config/$file" "$BACKUP_DIR/"
        echo "  [+] Backed up $file"
    fi
done

echo "$BACKUP_DIR" > "$BACKUP_ROOT/latest"
echo "==> Backup complete! Path saved to $BACKUP_ROOT/latest"
