# Verification scope

Prepared: 2026-10-29.

## Upload layout update

All project sources now sit at the archive root. Dockerfile COPY paths and the offline test paths were updated together. No subfolders need to be uploaded from a mobile file picker. Runtime destinations inside the image are unchanged.

## Checked locally

- All 14 offline tests passed. Startup checks cover required credentials, invalid ports, internal port conflicts, custom ports, leading zeros, secret-free output and shell injection rejection.
- Nginx template tests check that adding /healthz preserves authentication and fails explicitly if the upstream template changes.
- Bash syntax checks cover the entrypoint, browser launcher, desktop initialization and optional smoke script.
- Packaging checks verify the archive contents and exclude private credentials and generated caches.

## Not checked in this environment

Docker is not installed in the preparation environment. No image build, GUI boot, WebSocket session, TLS domain, persistent-volume restart or Railway deployment was run. The package is source code prepared for the documented flow; a successful live deployment is not claimed.

## Verify on the actual host

1. Build the image and confirm the /init process runs as PID 1.
2. Check /healthz returns 200 and / returns 401 without credentials.
3. Log in over HTTPS and confirm XFCE, Brave, keyboard, pointer and clipboard.
4. Open a website and create a file in /config/Downloads.
5. Disconnect and reconnect while the container keeps running; confirm the session remains open.
6. Recreate the container with the same /config volume; confirm files and browser profile remain. Open windows are expected to close during recreation.

`smoke.sh` automates a subset of these checks for a running local Docker container. It does not replace opening the actual desktop.

## Compatibility and policy

The Dockerfile relies on LinuxServer Webtop's ubuntu-xfce image and Brave's official apt repository. Upstream tags can change. The build intentionally stops if the expected Nginx template marker has changed.

Railway's published workload policy prohibits virtual desktops. Docker/PORT compatibility does not imply permission, service availability or guaranteed uptime there.
