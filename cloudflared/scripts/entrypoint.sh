#!/usr/bin/env sh
set -e

exec sudo --preserve-env --set-home -u nonroot cloudflared --no-autoupdate tunnel run