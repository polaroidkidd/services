#!/usr/bin/env bash
set -e

while getopts p option; do
  case "${option}" in
    p) PUSH=${OPTARG};;
    *) INVALID=${OPTARG};;
  esac
done

if  [[ -v INVALID ]]; then
  printf "Invalid options have been used"
  exit 1
fi


HOST="eu.gcr.io/dle-dev"
NAME=$(npx -c 'echo "$npm_package_name"')
VERSION=$(npx -c 'echo "$npm_package_version"')

TAG=${HOST}/${NAME}
TAG_VERSION=${TAG}:${VERSION}
TAG_LATEST=${TAG}:latest


if [ -d "./conf" ]; then
  rm -rf ./conf
fi

mkdir ./conf
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > ./conf/ssl-dhparams.pem
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > ./conf/options-ssl-nginx.conf

docker tag "${TAG_LATEST}" "${TAG_VERSION}"


if [[ $(git rev-parse --abbrev-ref HEAD) == master ]]; then
  #  We are on master, only prod releases are possible here. Only the -p flag will be respected here.

  echo "$TAG_LATEST"
  echo "$TAG_VERSION"

  echo "***************************************************"
  echo "******* BUILDING PRODUCTION DOCKER CONTAINER ******"
  echo "***************************************************"
  docker build . --no-cache -t "${TAG_LATEST}" --build-arg DIGITALOCEAN_ACCESS_TOKEN="$DIGITALOCEAN_ACCESS_TOKEN"= -f ./Dockerfile
  docker tag "${TAG_LATEST}" "${TAG_VERSION}"

  echo "***************************************************"
  echo "************* PUSHING TO REPOSITORY ***************"
  echo "***************************************************"
  docker push "${TAG_LATEST}"
  docker push "${TAG_VERSION}"

else
  #  We are on on a development branch. Commandline options -e and -r will be respected.
  echo "$TAG_LATEST"


  echo "***************************************************"
  echo "****** BUILDING DEVELOPMENT DOCKER CONTAINER ******"
  echo "***************************************************"
  docker build . --no-cache -t "${TAG_LATEST}" --build-arg DIGITALOCEAN_ACCESS_TOKEN="$DIGITALOCEAN_ACCESS_TOKEN"= -f ./Dockerfile




  if [[ -v PUSH ]]; then
    echo "***************************************************"
    echo "************* PUSHING TO REPOSITORY ***************"
    echo "***************************************************"
    docker push "${TAG_LATEST}"
  fi
fi
