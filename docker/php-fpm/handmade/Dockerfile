# origin was created by update.sh from Dockerfile-alpine.template
FROM php:7.2-fpm-alpine3.7

ENV NEXTCLOUD_VERSION 13.0.2

VOLUME /var/www/html

ADD "nextcloud-${NEXTCLOUD_VERSION}.tar.bz2" /usr/src/

# entrypoint.sh and cron.sh dependencies
RUN set -ex; \
    echo http://alpine.gliderlabs.com/alpine/v`cat /etc/alpine-release | cut -d"." -f1,2`/main > /etc/apk/repositories;\
    apk add -U \
        rsync \
    ; \
    \
    rm /var/spool/cron/crontabs/root; \
    echo '*/15 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data;\

# install the PHP extensions we need (+adding bz2, gmp, imagick, imap with bzip2-dev gmp-dev imagemagick-dev imap-dev krb5-dev )
# see https://docs.nextcloud.com/server/12/admin_manual/installation/source_installation.html
set -ex; \
    \
    apk add --virtual .build-deps \
        alpine-sdk \
        autoconf \
        bzip2-dev \
        freetype-dev \
        gmp-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        krb5-dev \
        libjpeg-turbo-dev \
#        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        libxml2-dev \
        openldap-dev \
        pcre-dev \
        postgresql-dev \
    ; \
    \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-configure ldap; \
    docker-php-ext-install -j$(nproc) \
        bz2 \
        exif \
        gd \
        gmp \
        intl \
        imap \
        ldap \
#        mcrypt \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        zip \
    ; echo "$PHP_AUTOCONF"; \
    pecl install \
        APCu-5.1.11 \
        imagick \
        memcached-3.0.4 \
        redis-3.1.6 \
    ; \
    docker-php-ext-enable \
        apcu \
        imagick \
        memcached \
        redis \
    ; \
    \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; echo "$runDeps"; \
    apk add --virtual .nextcloud-phpext-rundeps $runDeps; \
    apk del .build-deps; \
    docker-php-source delete; \
    rm -rf /var/cache/apk/*;\

# set recommended PHP.ini settings
# see https://docs.nextcloud.com/server/12/admin_manual/configuration_server/server_tuning.html#enable-php-opcache
 { \
        echo 'opcache.enable=1'; \
        echo 'opcache.enable_cli=1'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini; \
    \
    mkdir /var/www/data; \
    chown -R www-data:root /var/www; \
    chmod -R g=u /var/www; \

# adding source from build env directory, because gnupg servers is unstable and unaccessible sometimes
#RUN
  set -ex; \
#    apk add -U --virtual .fetch-deps \
#        bzip2 \
#        gnupg \
#    ; \
#    \
#    curl -fsSL -o nextcloud.tar.bz2 \
#        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2"; \
#    curl -fsSL -o nextcloud.tar.bz2.asc \
#        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2.asc"; \
#    export GNUPGHOME="$(mktemp -d)"; \
## gpg key from https://nextcloud.com/nextcloud.asc
#    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 28806A878AE423A28372792ED75899B9A724937A; \
#    gpg --batch --verify nextcloud.tar.bz2.asc nextcloud.tar.bz2; \
#    rm -r "$GNUPGHOME" nextcloud.tar.bz2.asc; \
#    tar -xjf nextcloud.tar.bz2 -C /usr/src/; \
#    rm nextcloud.tar.bz2; \
    rm -rf /usr/src/nextcloud/updater; \
    mkdir -p /usr/src/nextcloud/data; \
    mkdir -p /usr/src/nextcloud/custom_apps; \
    chmod +x /usr/src/nextcloud/occ; ls /usr/src/nextcloud \
#    apk del .fetch-deps; \
#    rm -rf /var/cache/apk/*;ls /usr/src/;ls /usr/src/nextcloud/
COPY *.sh /
COPY config/* /usr/src/nextcloud/config/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
