#!/bin/bash

WATCH_DIR="/mnt/md1/services/server/volumes/cloud/data/daniel.einars/files/InstantUpload/Camera"
DEST_DIR="/mnt/md1/services/server/volumes/immich/library/external/camera"

while true; do
  inotifywait -e close_write,create,delete,move -r "$WATCH_DIR"
  rsync \
    --recursive \
    --info=progress2 \
    --info=name0 \
    --stats \
    --ignore-existing \
    --verbose \
    "$WATCH_DIR"/ "$DEST_DIR"/
done