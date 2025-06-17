#!/bin/bash
set -e

REPO="https://github.com/leoc01/Born2beroot"
TMP_DIR="$(mktemp -d)"
CLONE_DIR="$TMP_DIR/setup"

echo "[*] Cloning repo..."
git clone "$REPO" "$CLONE_DIR"

cd "$CLONE_DIR"

echo "[*] Installing dependencies..."
apt update
apt install -y ufw libpam-pwquality sudo

echo "[*] Copying files..."
find etc usr var -type f -o -type d -empty | while read path; do
    target="/$path"
    if [ -d "$path" ]; then
        mkdir -p "$target"
    else
        mkdir -p "$(dirname "$target")"
        cp -f "$path" "$target"
    fi
done

echo "[*] Aplying configurations..."

chmod +x /usr/local/libexec/monitoring.sh
chmod +x /usr/local/libexec/monitoring_broadcast.sh
ufw --force enable
ufw allow 4242/tcp
ufw status
systemctl daemon-reload
systemctl enable monitoring_trigger.path

chage -M 30 -m 2 -W 7 lbuscaro

echo "[*] Cleaning temp..."
rm -rf "$TMP_DIR"

echo "[✓] Finish with success."
