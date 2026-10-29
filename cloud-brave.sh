#!/usr/bin/env bash
set -euo pipefail
# The desktop is a container, not a separate VM. Keep Docker's default
# seccomp policy and never grant privileged mode just to launch a browser.
# The Chromium process sandbox is disabled here for container compatibility.
args=(--no-sandbox --test-type --password-store=basic --disable-dev-shm-usage)
if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  args+=(--ozone-platform=wayland)
fi
exec /usr/bin/brave-browser "${args[@]}" "$@"

