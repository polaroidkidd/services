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


nginx -g "daemon off;"

