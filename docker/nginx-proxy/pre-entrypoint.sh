#!/bin/bash
set -eu
/usr/local/bin/confd -onetime -backend env
/docker-entrypoint.sh "$*"
