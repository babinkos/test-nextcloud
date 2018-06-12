#!/bin/sh
set -eu
/usr/local/bin/confd -onetime -backend env
call /docker-entrypoint.sh "$*"
