#!/usr/bin/env bash


docker compose exec --user www-data cloud  php occ maintenance:mode --on
wait
docker compose restart cloud
wait
docker exec -t dle-cloud-db pg_dumpall -c -U cloud  > /mnt/md1/services/server/cloud-db-dumps/$(date +%Y-%m-%d_%H_%M_%S).sql
wait
docker compose exec --user www-data cloud  php occ maintenance:mode --off
wait
docker compose restart cloud
