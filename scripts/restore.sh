#!/usr/bin/env bash
set -e

BACKUP_ROOT="$HOME/.config/xtHyprKde-backups"

if [ ! -f "$BACKUP_ROOT/latest" ]; then
    echo "[-] No backup found in $BACKUP_ROOT"
    exit 1
fi

LATEST_DIR=$(cat "$BACKUP_ROOT/latest")

if [ ! -d "$LATEST_DIR" ]; then
    echo "[-] Backup directory $LATEST_DIR does not exist"
    exit 1
fi

echo "==> Restoring configuration from $LATEST_DIR..."

for file in "$LATEST_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$HOME/.config/$filename"
        echo "  [+] Restored $filename"
    fi
done

echo "==> Reloading KWin and Plasma..."
qdbus6 org.kde.KWin /KWin reconfigure 2>/dev/null || true
echo "==> Restoration complete!"
