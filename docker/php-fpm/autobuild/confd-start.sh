#!/bin/sh
set -e
/bootstrap.sh
/usr/local/bin/confd -onetime -backend env
php-fpm
