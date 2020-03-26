#!/usr/bin/env bash
set -e

HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
VERSION=$(npx -c 'echo "$npm_package_version"')
TAG=${HOST}/${NAME}
TAG_VERSION=${TAG}:${VERSION}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -d "$DIR/conf" ]; then
  rm -rf "$DIR/conf"
fi

mkdir "$DIR/conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > ./conf/ssl-dhparams.pem
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf> ./conf/options-ssl-nginx.conf


docker build . --no-cache -t "${TAG_VERSION}" --build-arg DIGITAL_OCEAN_TOKEN="$DIGITALOCEAN_ACCESS_TOKEN"= -f ./Dockerfile

docker push "${TAG_VERSION}"

echo "Published: ${TAG_VERSION}"