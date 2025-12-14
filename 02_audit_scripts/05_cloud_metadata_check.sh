#!/usr/bin/env bash
set -euo pipefail

echo "=== Cloud Metadata Endpoint Check (SAFE) ==="
echo "This only checks whether a metadata endpoint is reachable from the host."
echo "It does NOT request tokens, credentials, or sensitive paths."
echo

# Common metadata IP (used by multiple clouds in different ways)
META_IP="169.254.169.254"

# We only test connectivity to the root with a short timeout.
# No headers, no token fetching, no credential paths.
if command -v curl >/dev/null; then
  code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 1 "http://${META_IP}/" || true)
  echo "HTTP status from ${META_IP}/ : ${code}"
  if [[ "$code" != "000" ]]; then
    echo "Note: metadata appears reachable. Ensure proper hardening (IMDSv2 / firewall / hop limits)."
  else
    echo "Metadata not reachable (or blocked)."
  fi
else
  echo "curl not available."
fi
