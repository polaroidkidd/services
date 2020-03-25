#!/usr/bin/env bash
set -e

HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
VERSION=$(npx -c 'echo "$npm_package_version"')
TAG=${HOST}/${NAME}
TAG_LATEST=${TAG}:latest
TAG_VERSION=${TAG}:${VERSION}

if [ -d "/.conf" ]; then
  rm -rf ./conf
fi

mkdir ./conf
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > ./conf/ssl-dhparams.pem
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > ./conf/options-ssl-nginx.conf

docker build . --no-cache -t "${TAG_LATEST}" --build-arg DIGITAL_OCEAN_TOKEN="$DIGITALOCEAN_ACCESS_TOKEN"= -f ./Dockerfile
docker tag "${TAG_LATEST}" "${TAG_VERSION}"

echo "${TAG_LATEST}"
echo "${TAG_VERSION}"