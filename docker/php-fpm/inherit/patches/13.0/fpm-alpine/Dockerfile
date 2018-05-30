# DO NOT EDIT: created by update.sh from Dockerfile-alpine.template
FROM php:7.1-fpm-alpine3.7

# entrypoint.sh and cron.sh dependencies
RUN set -ex; \
    echo http://alpine.gliderlabs.com/alpine/v`cat /etc/alpine-release | cut -d"." -f1,2`/main > /etc/apk/repositories;\
    apk add -U \
        rsync \
    ; \
    \
    rm /var/spool/cron/crontabs/root; \
    echo '*/15 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data;\

# install the PHP extensions we need
# see https://docs.nextcloud.com/server/12/admin_manual/installation/source_installation.html
set -ex; \
    \
    apk add --virtual .build-deps \
        alpine-sdk \
        autoconf \
        freetype-dev \
        icu-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev \
        libxml2-dev \
        openldap-dev \
        pcre-dev \
        postgresql-dev \
    ; \
    \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-configure ldap; \
    docker-php-ext-install -j$(nproc) \
        exif \
        gd \
        intl \
        ldap \
        mcrypt \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        zip \
    ; echo "$PHP_AUTOCONF"; \
    pecl install \
        APCu-5.1.11 \
        memcached-3.0.4 \
        redis-3.1.6 \
    ; \
    docker-php-ext-enable \
        apcu \
        memcached \
        redis \
    ; \
    \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk add --virtual .nextcloud-phpext-rundeps $runDeps; \
    apk del .build-deps;rm -rf /var/cache/apk/*;\

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
    chmod -R g=u /var/www

VOLUME /var/www/html


ENV NEXTCLOUD_VERSION 13.0.2

RUN set -ex; \
    apk add -U --virtual .fetch-deps \
        bzip2 \
        gnupg \
    ; \
    \
    curl -fsSL -o nextcloud.tar.bz2 \
        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2"; \
    curl -fsSL -o nextcloud.tar.bz2.asc \
        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
# gpg key from https://nextcloud.com/nextcloud.asc
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 28806A878AE423A28372792ED75899B9A724937A; \
    gpg --batch --verify nextcloud.tar.bz2.asc nextcloud.tar.bz2; \
    rm -r "$GNUPGHOME" nextcloud.tar.bz2.asc; \
    tar -xjf nextcloud.tar.bz2 -C /usr/src/; \
    rm nextcloud.tar.bz2; \
    rm -rf /usr/src/nextcloud/updater; \
    mkdir -p /usr/src/nextcloud/data; \
    mkdir -p /usr/src/nextcloud/custom_apps; \
    chmod +x /usr/src/nextcloud/occ; \
    apk del .fetch-deps;rm -rf /var/cache/apk/*;

COPY *.sh /
COPY config/* /usr/src/nextcloud/config/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
