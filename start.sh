#!/bin/sh 
# 
# Script will:
# - read and parse "./browsers_config/browsers.json" for requested browser/vnc images
# - search for already existing browser/vnc images
# - pull missing browser/vnc images
# - start docker-compose with selenoid + selenoid-ui services

# Parsing listed in "browsers.json" file images
REQUESTED_IMAGES=($(grep -o 'selenoid/vnc:.\+[^",$]' ./browsers_config/browsers.json))
for i in "${REQUESTED_IMAGES[@]}"
do
  echo 'Requested image:' $i
done

echo ____

# Searching for already-existing selenoid images
ALREADY_DOWNLOADED_IMAGES=($(docker images --filter=reference='selenoid/vnc' --format "{{.Repository}}:{{.Tag}}"))
for i in "${ALREADY_DOWNLOADED_IMAGES[@]}"
do
  echo 'Already existing image:' $i
done

echo ____

# Pulling requested but not-already-existing images 
NEED_TO_DOWNLOAD_IMAGES=(`echo ${REQUESTED_IMAGES[@]} ${ALREADY_DOWNLOADED_IMAGES[@]} | tr ' ' '\n' | sort | uniq -u`)
for i in "${NEED_TO_DOWNLOAD_IMAGES[@]}"
do
  docker image pull $i
done

# Start 
docker-compose up -d
