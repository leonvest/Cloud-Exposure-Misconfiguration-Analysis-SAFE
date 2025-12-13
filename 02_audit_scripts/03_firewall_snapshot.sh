#!/usr/bin/env bash
set -euo pipefail

echo "=== Firewall Snapshot ==="
echo

if command -v ufw >/dev/null; then
  echo "[ufw status]"
  sudo ufw status verbose || true
  echo
fi

if command -v iptables >/dev/null; then
  echo "[iptables -S]"
  sudo iptables -S || true
  echo
  echo "[iptables -L -n]"
  sudo iptables -L -n || true
  echo
fi

if command -v nft >/dev/null; then
  echo "[nft ruleset]"
  sudo nft list ruleset || true
  echo
fi
