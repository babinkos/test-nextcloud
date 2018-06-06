#!/bin/sh
set -eu
cp -f /usr/local/etc/nginx/nginx.conf /etc/nginx/nginx.conf
sed -i 's/www\-data/nginx/g' /etc/nginx/nginx.conf
exec "$@"
