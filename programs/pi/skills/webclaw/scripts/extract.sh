#!/usr/bin/env bash
# extract.sh — webclaw wrapper with timeout fallback
# Usage: extract.sh <url> [webclaw-flags...]
#
# Strategy: try direct (8s), then proxy (30s)

set -euo pipefail

PROXY="http://localhost:3738"
DIRECT_TIMEOUT=8
PROXY_TIMEOUT=30

if [[ $# -lt 1 ]]; then
  echo "Usage: extract.sh <url> [webclaw-flags...]" >&2
  exit 1
fi

URL="$1"
shift

# Step 1: Direct attempt
if webclaw "$URL" -t "$DIRECT_TIMEOUT" "$@" 2>/dev/null; then
  exit 0
fi

# Step 2: Proxy fallback
webclaw "$URL" -p "$PROXY" -t "$PROXY_TIMEOUT" "$@"
