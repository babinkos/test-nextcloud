#!/usr/bin/env bash
# expected to have repository cloned in subdir docker/13.0/fpm-alpine
cd docker/13.0/fpm-alpine
ls
docker build -t my_nextcloud:current .
ls
cd ../../..
docker build -t my_nextcloud:phpext .
echo "Job is done !!"
