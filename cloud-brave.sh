#!/usr/bin/env bash
set -euo pipefail
# The desktop is a container, not a separate VM. Keep Docker's default
# seccomp policy and never grant privileged mode just to launch a browser.
# The Chromium process sandbox is disabled here for container compatibility.
args=(--no-sandbox --test-type --password-store=basic --disable-dev-shm-usage)
args+=(--disable-gpu --no-first-run --no-default-browser-check --disable-session-crashed-bubble)
args+=(--disable-background-mode --renderer-process-limit=2 --window-size=1000,760 --start-maximized)
if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  args+=(--ozone-platform=wayland)
fi
exec /usr/bin/brave-browser "${args[@]}" "$@"

