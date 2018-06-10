#!/bin/sh
if [ ! -d /var/www/html/config/ ]; then
  echo "something gone wrong - /var/www/html/config/config.php missing after entrypoint"
  echo "need to bootstrap volume again"
#  if [ "$(id -u)" = 0 ]; then
#        rsync_options="-rlDog --chown www-data:root"
#    else
#        rsync_options="-rlD"
#  fi
#  rsync -v $rsync_options --delete --exclude /config/ --exclude /data/ --exclude /custom_apps/ --exclude /themes/ /usr/src/nextcloud/ /var/www/html/
#  for dir in config data custom_apps themes; do
#    if [ ! -d "/var/www/html/$dir" ] || directory_empty "/var/www/html/$dir"; then
#      rsync -v $rsync_options --include "/$dir/" --exclude '/*' /usr/src/nextcloud/ /var/www/html/
#    fi
#  done
fi
