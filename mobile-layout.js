(function (root) {
  "use strict";
  const clamp = (n, a, b) => Math.max(a, Math.min(b, n));
  function geometry(viewWidth, viewHeight) {
    const vw = Math.max(1, viewWidth), vh = Math.max(1, viewHeight);
    const width = Math.round(vw < 700 ? 640 : clamp(vw, 640, 1600));
    const height = Math.round(clamp(vh * width / vw, 480, 1280));
    return { width, height };
  }
  function layout(viewWidth, viewHeight, size, zoom) {
    const factor = Math.min(viewWidth / size.width, viewHeight / size.height) * clamp(zoom, 1, 2.5);
    const width = size.width * factor, height = size.height * factor;
    return { factor, width, height, left: Math.max(0, (viewWidth - width) / 2), top: Math.max(0, (viewHeight - height) / 2), canvasWidth: Math.max(width, viewWidth), canvasHeight: Math.max(height, viewHeight) };
  }
  const api = { geometry, layout, clamp };
  if (typeof module !== "undefined" && module.exports) module.exports = api;
  else root.MobileLayout = api;
})(typeof globalThis !== "undefined" ? globalThis : this);
