#!/usr/bin/env sh
set -e

if [ "$VPS_REDICRECT_HTTPS" = "True" ]; then
  echo "PROD ENV: Renewing Certificates."
  certbot renew -n
else
  echo "DEV ENV: Not renewing certificates."
fi
