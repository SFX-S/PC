#!/usr/bin/env bash
set -euo pipefail
if [[ "${BROWSER_AUTO_START:-false}" == true ]]; then
  exec /usr/local/bin/cloud-brave https://www.google.com/
fi

