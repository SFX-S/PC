# Cloud PC + Brave — GitHub → Docker → Browser

سطح مكتب Ubuntu XFCE مع Brave، يُبنى بواسطة Dockerfile ويفتح من رابط HTTPS كأنه موقع.

**نسخة الرفع من الجوال: جميع الملفات جنب بعضها، بدون مجلدات فرعية.**

فك الضغط، حدد كل الملفات وارفعها على GitHub. إذا كنت رفعت جزءًا من النسخة السابقة، حدّث Dockerfile وبقية الملفات المكررة بهذه النسخة.

**[ابدأ من الشرح العربي: RAILWAY_AR.md](RAILWAY_AR.md)**

**حالة الدعم:** Railway تحظر virtual desktops ضمن [تعليماتها الحالية](https://docs.railway.com/platform/trust-and-safety). هذه حزمة توافق تقني، وليست نشرًا معتمدًا أو ضمانًا لاستمرار الخدمة. لا تحتوي على وسائل إخفاء الاستخدام أو تجاوز القيود. يمكن استخدام صورة Docker نفسها لدى استضافة تسمح بهذا الاستخدام.

## Runtime settings

| Setting | Value |
| --- | --- |
| Build | Dockerfile in repository root |
| Start command | Leave blank; use image ENTRYPOINT |
| Public target port | 8080 |
| Login user | CUSTOM_USER, default admin |
| Login password | PASSWORD, required; 20–128 A–Z/a–z/0–9/underscore/hyphen characters |
| Persistent storage | Mount at /config |
| Web readiness path | /healthz |

`/healthz` reports that the web gateway is ready; it does not assert that a desktop has finished booting. All desktop pages and WebSocket endpoints retain the upstream login requirement.

The project does not include legacy railway.json/railway.toml configuration. Dockerfile detection supplies the build; configure networking, volume, resource limits and restart/sleep settings in the platform dashboard.

## Included

- Ubuntu XFCE desktop streamed through LinuxServer Webtop/Selkies.
- Brave installed from the official Brave apt repository.
- PORT support, required credentials, web readiness check and a persistent home mount.
- Desktop shortcut, Arabic welcome page and additional packages list.
- Offline startup tests and an optional runtime smoke check.

## Validate

```bash
python3 -m unittest -v test_startup.py
```

The package was prepared without an available Docker daemon. Offline tests cannot prove a successful image build, GUI boot or Railway deployment; see VALIDATION.md.

## Sources and licenses

- [Webtop](https://docs.linuxserver.io/images/docker-webtop/)
- [Selkies port configuration](https://docs.linuxserver.io/selkies/user-guide/configuration/)
- [Brave official installation](https://brave.com/linux/)
- [Railway Dockerfiles](https://docs.railway.com/builds/dockerfiles)
- [Railway persistent volumes](https://docs.railway.com/volumes/reference)

Project files use the MIT license in LICENSE; bundled upstream software retains its own licenses.

