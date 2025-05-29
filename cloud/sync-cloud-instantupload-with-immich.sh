#!/bin/bash

# Service Script to sync the InstantUpload folder with the Immich library

WATCH_DIR="/mnt/md1/services/server/volumes/cloud/data/daniel.einars/files/InstantUpload/Camera"
DEST_DIR="/mnt/md1/services/server/volumes/immich/library/external/camera"

while true; do
  inotifywait -e close_write,create,delete,move -r "$WATCH_DIR"
  rsync --info=progress2 --info=name0 --stats --ignore-existing -v --dry-run "$WATCH_DIR"/* "$DEST_DIR"/
done