#!/usr/bin/env bash
set -euo pipefail

export PORT="${PORT:-8080}"
export CUSTOM_USER="${CUSTOM_USER:-admin}"
export CUSTOM_WS_PORT=8082
export CUSTOM_HTTPS_PORT=3001
export SUBFOLDER=/
export START_DOCKER=false

if [[ ! "$PORT" =~ ^[0-9]{4,5}$ ]] || (( 10#$PORT < 1024 || 10#$PORT > 65535 )); then
  echo 'ERROR: PORT must be a number between 1024 and 65535. Use 8080.' >&2
  exit 1
fi
PORT="$((10#$PORT))"
export PORT
export CUSTOM_PORT="$PORT"
case "$PORT" in
  3001|5000|5100|5173|8082)
    echo 'ERROR: PORT conflicts with an internal service. Use 8080.' >&2
    exit 1
    ;;
esac
if [[ ! "$CUSTOM_USER" =~ ^[A-Za-z0-9_-]{1,32}$ ]]; then
  echo 'ERROR: CUSTOM_USER must contain letters, numbers, underscores or hyphens.' >&2
  exit 1
fi
if [[ ! "${PASSWORD:-}" =~ ^[A-Za-z0-9_-]{20,128}$ ]]; then
  echo 'ERROR: Set PASSWORD in service Variables to 20–128 letters, numbers, underscores or hyphens.' >&2
  echo 'Do not put the password in your GitHub files.' >&2
  exit 1
fi
export PASSWORD
if [[ "${1:-}" == "--check-config" ]]; then
  echo "Configuration valid; HTTP port: $PORT; user: $CUSTOM_USER."
  exit 0
fi
if (( EUID != 0 )); then
  echo 'ERROR: This image needs to start as root. Set RAILWAY_RUN_UID=0 if the platform overrides it.' >&2
  exit 1
fi
echo "Starting Cloud PC on 0.0.0.0:$PORT with login required."
echo 'Mount persistent storage at /config to keep your files across deployments.'
exec /init "$@"

