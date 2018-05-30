#!/usr/bin/env bash
# expected to have repository cloned in subdir docker/13.0/fpm-alpine
cd docker/13.0/fpm-alpine
echo docker build -t my_nextcloud:current .
ls
cd ../../..
echo docker build -t my_nextcloud:phpext .
ls
