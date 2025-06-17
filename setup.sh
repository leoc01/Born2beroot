#!/bin/bash
set -e

REPO="https://github.com/leoc01/Born2beroot"
TMP_DIR="$(mktemp -d)"
CLONE_DIR="$TMP_DIR/setup"

echo "[*] Clonando repositório..."
git clone "$REPO" "$CLONE_DIR"

cd "$CLONE_DIR"

echo "[*] Instalando dependências..."
bash install.sh

echo "[*] Copiando arquivos..."
find etc usr var -type f -o -type d -empty | while read path; do
    target="/$path"
    if [ -d "$path" ]; then
        mkdir -p "$target"
    else
        mkdir -p "$(dirname "$target")"
        cp -f "$path" "$target"
    fi
done

echo "[*] Aplicando configurações..."

chmod +x /usr/local/libexec/monitoring.sh
chmod +x /usr/local/libexec/monitoring_broadcast.sh
ufw enable
ufw allow 4242/tcp
ufw status
systemctl daemon-reload
systemctl enable monitoring_trigger.path

chage -M 30 -m 2 -W 7 lbuscaro

echo "[*] Limpando arquivos temporários..."
rm -rf "$TMP_DIR"

echo "[✓] Instalação completa com sucesso."

