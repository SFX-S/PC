#!/usr/bin/env python3
"""Add a public web readiness check without changing desktop authentication."""
from pathlib import Path
import sys


def add_health_location(text: str) -> str:
    marker = "  listen 3000 default_server;"
    if text.count(marker) != 1:
        raise ValueError("Upstream Nginx template changed; inspect it before building.")
    block = '''  location = /healthz {
    auth_basic off;
    default_type application/json;
    add_header Cache-Control no-store;
    return 200 '{"status":"web-ready"}';
  }
'''
    return text.replace(marker, block + marker, 1)


if __name__ == "__main__":
    path = Path(sys.argv[1])
    path.write_text(add_health_location(path.read_text()))

