#!/bin/sh
set -eu
if [ "$(pidof php-fpm)" = "" ]; then
    echo "php-fpm start"
    php-fpm&
    sleep 2
  else
    echo "php-fpm already started";
fi
#env
SCRIPT_FILENAME=/var/www/html/status.php REQUEST_URI=/ QUERY_STRING= REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
cat /var/www/html/config/config.php
#sleep 5
SCRIPT_FILENAME=/var/www/html/index.php REQUEST_URI=/ QUERY_STRING= REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
#sudo -u www-data php /var/www/html/occ maintenance:install -n
sleep 1
cat /var/www/html/config/config.php
SCRIPT_FILENAME=/var/www/html/status.php REQUEST_URI=/ QUERY_STRING='' REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
