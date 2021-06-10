#!/usr/bin/env sh
set -e
# Helper function to ask certbot for the given domain(s).  Must have defined the
# EMAIL environment variable, to register the proper support email address.
get_certificate() {
  if [ "$VPS_REDICRECT_HTTPS" = "True" ]; then
    echo "PROD ENV: Getting wildcard certificate for domain *.dle.dev on behalf of user certbot@dle.dev"
    certbot certonly \
      --dns-digitalocean \
      --dns-digitalocean-credentials /scripts/digitalocean.ini \
      --dns-digitalocean-propagation-seconds 60 \
      --non-interactive \
      --agree-tos \
      --keep \
      -n \
      --text \
      --email certbot@dle.dev \
      --preferred-challenges dns-01 \
      --server https://acme-v02.api.letsencrypt.org/directory \
      --http-01-port 12079 \
      --expand \
      -d "*.dle.dev" -d dle.dev
  else
    echo "DEV ENV: Not getting certificates"
  fi
}

if [ "$VPS_REDICRECT_HTTPS" = "True" ]; then
  echo "PROD ENV: Forwarding to HTTPS."
  if ! get_certificate; then
    echo "Cerbot failed. Check the logs for details."
    exit 1
  fi
else
  echo "DEV ENV: NOT forwarding to HTTPS."
fi
