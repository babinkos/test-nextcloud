#!/bin/bash

docker run -a stdin -a stdout -i -t php:7.2-fpm-alpine3.7 php -i > php7_2-fpm-alpine3_7-phpinfo.txt
docker run -a stdin -a stdout -i -t php:7.2-fpm-alpine3.7 php -m > php7_2-fpm-alpine3_7-php-modules.txt

cut -d " " -f1 php-modules-clean.txt
dos2unix -n nc-php-modules-clean-list.txt nc-modules.txt
paste -s -d '|' nc-modules.txt > nc-php-modules.txt
paste -s -d '|' nc-needed.txt > nc-needed-mods.txt
egrep -iw 'apcu|avconv|bz2|ctype|curl|dom|exif|ffmpeg|fileinfo|ftp|GD|gmp|iconv|imagick|imap|intl|JSON|ldap|libxml|mbstring|mcrypt|memcached|openssl|pdo_pgsql|posix|Recommended|redis|SimpleXML|smbclient|XMLReader|XMLWriter|zip|zlib' image-modules.txt

egrep -iw 'apcu|avconv|bz2|ctype|curl|dom|exif|ffmpeg|fileinfo|ftp|GD|gmp|iconv|imagick|imap|intl|JSON|ldap|libxml|mbstring|mcrypt|memcached|openssl|pdo_pgsql|posix|Recommended|redis|SimpleXML|smbclient|XMLReader|XMLWriter|zip|zlib' image-modules.txt
egrep -iw 'Core|ctype|curl|date|dom|fileinfo|filter|ftp|hash|iconv|json|libxml|mbstring|mysqlnd|openssl|pcre|PDO|pdo_sqlite|Phar|posix|readline|Reflection|session|SimpleXML|sodium|SPL|sqlite3|standard|tokenizer|xml|xmlreader|xmlwriter|zlib' nc-needed-mods-list.txt


egrep -viw 'Core|ctype|curl|date|dom|fileinfo|filter|ftp|hash|iconv|json|libxml|mbstring|mysqlnd|openssl|pcre|PDO|pdo_sqlite|Phar|posix|readline|Reflection|session|SimpleXML|sodium|SPL|sqlite3|standard|tokenizer|xml|xmlreader|xmlwriter|zlib' nc-needed.txt| sort > mods-add.txt
./search-apk-php-modules.sh | xargs | tr '[:upper:]' '[:lower:]'


docker run --rm -a stdin -a stdout -i -t php:7.2-fpm-alpine3.7 ash -c "apk update && apk search php7-apcu php7-avconv php7-bz2 php7-exif php7-ffmpeg php7-gd php7-gmp php7-imagick php7-imap php7-intl php7-ldap php7-mcrypt php7-memcached php7-pdo_pgsql php7-recommended php7-redis php7-smbclient php7-zip"
docker run --rm -a stdin -a stdout -v /tmp/artifacts/:/mnt/artifacts -i -t php:7.2-fpm-alpine3.7 ash -c "apk update && apk search php7-apcu php7-avconv php7-bz2 php7-exif php7-ffmpeg php7-gd php7-gmp php7-imagick php7-imap php7-intl php7-ldap php7-mcrypt php7-memcached php7-pdo_pgsql php7-recommended php7-redis php7-smbclient php7-zip | sort > /mnt/artifacts/phpmods.txt"
cut -d"-" -f1,2 /tmp/artifacts/phpmods.txt
cut -d"-" -f1,2 /tmp/artifacts/phpmods.txt > php-mods-apk-names-2add.txt

# apcu bz2 exif gd gmp imagick imap intl ldap mcrypt memcached pdo_pgsql redis smbclient zip


#docker run -a stdin -a stdout -i -t php:7.2-fpm-alpine3.7 apk search php7-Core php7-date php7-filter php7-hash php7-mysqlnd php7-pcre php7-PDO php7-pdo_sqlite php7-Phar php7-readline php7-Reflection php7-session php7-sodium php7-SPL php7-sqlite3 php7-standard php7-tokenizer php7-xml
nmcli dev show | grep DNS
#/etc/docker/daemon.json
# {
#    "dns": ["10.0.2.3"]
# }
#
docker run --rm -a stdin -a stdout -v /tmp/artifacts/:/mnt/artifacts -i -t php:7.2-fpm-alpine3.7 ash -c "apk update && apk search php7-date php7-filter php7-hash php7-mysqlnd php7-pcre php7-pdo php7-pdo_sqlite php7-phar php7-readline php7-reflection php7-session php7-sodium php7-spl php7-sqlite3 php7-standard php7-tokenizer php7-xml | sort > /mnt/artifacts/phpmods.txt"
cut -d"-" -f1,2 /tmp/artifacts/phpmods.txt
