#!/usr/bin/env bash
set -e

HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
TAG=${HOST}/${NAME}
TAG_LATEST=${TAG}:latest
VERSION=$(npx -c 'echo "$npm_package_version"')
TAG_VERSION=${TAG}:${VERSION}

if [[ $(git rev-parse --abbrev-ref HEAD) == master ]]; then
    docker build . --no-cache -t "${TAG_VERSION}" -f ./Dockerfile
    echo "VERSION: ${TAG_VERSION}"
    docker push "${TAG_VERSION}"
    echo "Published: ${TAG_VERSION}"
else
    echo "VERSION: LATEST"
    docker build . -t "${TAG_LATEST}" -f ./Dockerfile
    docker push "${TAG_LATEST}"
    echo "Published: ${TAG_LATEST}"
fi


