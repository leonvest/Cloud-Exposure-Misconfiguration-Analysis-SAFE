#!/usr/bin/env bash
set -euo pipefail

echo "=== Lightweight Log Triage (Local) ==="
echo

echo "[Auth-related]"
for f in /var/log/auth.log /var/log/secure; do
  if [[ -f "$f" ]]; then
    echo "--- $f ---"
    sudo tail -n 120 "$f" | egrep -i "failed|invalid|accepted|sudo|session|authentication" || true
    echo
  fi
done

echo "[Systemd journal (last 2h, warnings+)]"
if command -v journalctl >/dev/null; then
  sudo journalctl --since "2 hours ago" -p warning --no-pager | tail -n 120 || true
fi
