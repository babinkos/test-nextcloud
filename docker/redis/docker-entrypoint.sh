#!/bin/sh
set -e
/usr/local/bin/confd -onetime -backend env
chmod +x /usr/local/bin/*
if [ ! -f "/data/redis.conf" ]; then
	touch "/data/redis.conf"
fi
# will prepare /etc/redis/redis.conf from env vars
# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
#if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
#	set -- redis-server "$@" # may be used of with config on volume i.e. : /data/redis.conf
#fi

# allow the container to be started with `--user`
#if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
#	chown -R redis .
#	exec su-exec redis "$0" "$@"
#fi

exec "$@"
