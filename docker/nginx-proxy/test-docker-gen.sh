#!/bin/bash
set -eu
echo "docker-gen version:" && \
/usr/local/bin/docker-gen -version && \
echo "Docker.Version from docker-gen" && \
/usr/local/bin/docker-gen <(echo '{{.Docker.Version}}') && \
echo "Docker.CurrentContainerID from docker-gen" && \
/usr/local/bin/docker-gen <(echo '{{.Docker.CurrentContainerID}}')
