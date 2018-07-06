#!/bin/sh
set -eu
if [ "$(pidof php-fpm)" == "" ]; then
    echo "php-fpm start"
    php-fpm&
    sleep 2
  else
    echo "php-fpm already started";
fi
SCRIPT_FILENAME=/var/www/html/status.php REQUEST_URI=/ QUERY_STRING= REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
