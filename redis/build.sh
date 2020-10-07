#!/usr/bin/env bash
set -e
HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
TAG=${HOST}/${NAME}
TAG_LATEST=${TAG}:latest

docker build .  -t "${TAG_LATEST}" -f ./Dockerfile
