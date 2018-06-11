#!/bin/sh
set -eu
if [ ! -f '/usr/local/etc/nginx/nginx.conf' ]; then
#  cp -f /nginx.conf /usr/local/etc/nginx/nginx.conf
  /usr/local/bin/confd -onetime -backend env
fi
exec "$@"
