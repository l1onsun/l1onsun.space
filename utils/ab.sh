#!/usr/bin/env bash
set -euo pipefail

PROXY="socks5://localhost:3737"
DEBUG_PORT=9222

# 1. Check if Chromium is already listening on the debug port
if ! ss -tlnp 2>/dev/null | grep -q ":${DEBUG_PORT} "; then
  echo "Starting Chromium on :${DEBUG_PORT} via ${PROXY} ..."
  chromium \
    --proxy-server="$PROXY" \
    --remote-debugging-port="$DEBUG_PORT" \
    &>/dev/null &
  # Wait until the port is actually open (up to 10s)
  for i in {1..20}; do
    if ss -tlnp 2>/dev/null | grep -q ":${DEBUG_PORT} "; then
      break
    fi
    sleep 0.5
  done
  if ! ss -tlnp 2>/dev/null | grep -q ":${DEBUG_PORT} "; then
    echo "Error: Chromium failed to start on :${DEBUG_PORT}" >&2
    exit 1
  fi
  echo "Chromium started (PID $!)"
else
  echo "Chromium already running on :${DEBUG_PORT}"
fi

# 2. Connect agent-browser to the running instance
echo "Connecting agent-browser → :${DEBUG_PORT} ..."
agent-browser connect "$DEBUG_PORT"

# 3. Print the core skill guide
agent-browser skills get core
