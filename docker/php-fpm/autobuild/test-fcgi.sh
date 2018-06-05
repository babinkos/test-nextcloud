#!/bin/sh
set -eu
php-fpm&
sleep 3s
SCRIPT_NAME=/status SCRIPT_FILENAME=/status REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
