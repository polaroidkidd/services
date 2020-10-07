#!/usr/bin/env bash
set -e
HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
VERSION=$(npx -c 'echo "$npm_package_version"')

TAG=${HOST}/${NAME}
TAG_VERSION=${TAG}:${VERSION}

docker build . --no-cache -t "${TAG_VERSION}" -f ./Dockerfile
docker push "${TAG_VERSION}"

echo "Published: ${TAG_VERSION}"
