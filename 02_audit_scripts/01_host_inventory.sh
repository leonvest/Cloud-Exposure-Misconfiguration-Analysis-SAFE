#!/usr/bin/env bash
set -euo pipefail

echo "=== Host Inventory ==="
date
echo

echo "[OS]"
uname -a || true
cat /etc/os-release 2>/dev/null || true
echo

echo "[CPU/RAM]"
command -v lscpu >/dev/null && lscpu | sed -n '1,20p' || true
free -h || true
echo

echo "[Disk]"
df -hT || true
echo

echo "[Users]"
cut -d: -f1,3,4 /etc/passwd | head -n 30 || true
echo

echo "[Groups of current user]"
id || true
