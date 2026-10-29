# Verification scope — mobile update

Prepared: 2026-10-29.

## Local checks

- 33 Python tests pass: startup validation, secret-free errors, port conflicts, the Nginx route patch, real loopback HTTP requests to the control service, cross-origin/form request rejection, payload bounds, invalid commands, resource-limit detection, OOM counters, and safe URL/search handling.
- The JavaScript layout check passes on six portrait/landscape viewport sizes. At fit zoom the full desktop stays within the viewport; zoom preserves the desktop resolution and gives all enlarged content reachable scroll bounds.
- JavaScript syntax, Python parsing and Bash syntax are checked.
- Docker COPY inputs and the flat ZIP layout are checked; no passwords, personal screenshots, cached bytecode or nested upload folders are included.

## Runtime changes

The root page is now a mobile control shell. The upstream Selkies desktop stays at /desktop/. Controls are a dedicated, allowlisted Python service on loopback port 7801, behind the same Nginx login. A custom request header, JSON-only writes, origin checks, and fixed argument arrays protect the control endpoint. It provides no arbitrary shell execution API.

The browser opens on demand by default, with CPU rendering and shared-memory compatibility flags. Existing user files and browser profiles remain in /config. The project's old autostart entry is updated; BROWSER_AUTO_START=true can opt back into automatic browser startup.

## What has not been verified here

Docker, X11 desktop tools and a browser executable are unavailable in this preparation environment. No Docker build, real wmctrl/xdotool/xclip operation, Brave renderer, touchscreen session, visual browser rendering or Railway deployment was run. The automated HTTP tests simulate desktop actions after checking request handling. The layout tests are calculations, not screenshots of a real browser.

The screenshot's renderer error can be consistent with memory pressure, but no live OOM counter or browser crash dump from the user's deployment was available. The runtime UI now reports actual cgroup usage and OOM-kill counters when exposed by the host. It does not identify which process was killed, and the update cannot increase a hosting plan's resources or remove its network restrictions.

## After deployment

1. Confirm /healthz returns 200 and root, /desktop/ and /mobile-control/status require login.
2. Open the main HTTPS URL on the phone and confirm the toolbar is visible, with the desktop fitting its viewport.
3. Press Google, navigate using the top address bar, maximize the browser and close one tab/window from the toolbar.
4. Try visual zoom, scrolling enlarged content, fit, rotation and full screen where the browser supports it.
5. Select a remote text field, open the local text panel, paste Arabic text and press Enter.
6. Check the resource badge, confirm the browser remains stable with the actual memory limit, and inspect Deploy Logs if it still crashes.
7. Disconnect/reconnect, then recreate the container with the same /config volume and confirm saved files and the browser profile remain. Open windows close during recreation.

Railway's published policy prohibits virtual desktops. Technical compatibility and offline checks do not imply provider permission or guaranteed uptime.
