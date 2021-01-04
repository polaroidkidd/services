#!/usr/bin/env sh
set -e
# Helper function to output error messages to STDERR, with red text
error() {
  (
    set +x
    tput -Tscreen bold
    tput -Tscreen setaf 1
    printf $*
    tput -Tscreen sgr0
  ) >&2
}

# Deactivate http redirect in dev environment
if [ "$VPS_REDICRECT_HTTPS" = "False" ]; then
  cp /etc/nginx/nginx.dev.conf /etc/nginx/nginx.conf
  printf "\n\n############################################################\n\n"
  echo "Using nginx.dev.conf"
  echo "HTTP Traffic will be NOT redirected to HTTPS"
  printf "\n############################################################\n"
else
  cp /etc/nginx/nginx.prod.conf /etc/nginx/nginx.conf
  printf "\n\n############################################################\n\n"
  echo "Using nginx.prod.conf"
  echo "HTTP Traffic will be redirected to HTTPS"
  printf "\n############################################################\n"
fi




inotifywait -r -m -e modify /etc/letsencrypt |
   while read path _ file; do
    echo "Change in /etc/letsencrypt detected. Reloading config in 10 minutes."
    sleep 10m
    echo "Reloading Nginx"
    nginx -s reload
    wait ${!}
    echo "Nginx has reloaded"
   done &
nginx -g "daemon off;"

