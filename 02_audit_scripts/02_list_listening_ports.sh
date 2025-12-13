#!/usr/bin/env bash
set -euo pipefail

echo "=== Listening Ports Snapshot (Local) ==="
echo "Tip: anything bound to 0.0.0.0 / :: is reachable depending on firewall."
echo

if command -v ss >/dev/null; then
  ss -lntup
elif command -v netstat >/dev/null; then
  netstat -lntup
else
  echo "Neither ss nor netstat found."
  exit 1
fi
