#!/bin/sh
set -e
/usr/local/bin/confd -onetime -backend env
php-fpm
