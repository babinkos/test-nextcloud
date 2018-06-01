# based on nextcloud:fpm-alpine sources
FROM php:7.2-fpm-alpine3.7
COPY nextcloud.asc /tmp/nextcloud.asc
ENV NEXTCLOUD_VERSION 13.0.2

VOLUME /var/www/html

#ADD "nextcloud-${NEXTCLOUD_VERSION}.tar.bz2" /usr/src/

# entrypoint.sh and cron.sh dependencies
RUN set -ex; \
    echo http://alpine.gliderlabs.com/alpine/v$(cut -d"." -f1,2 /etc/alpine-release)/main > /etc/apk/repositories;\
    apk add -U \
        rsync \
        fcgi \
    ; \
    \
    rm /var/spool/cron/crontabs/root; \
    echo '*/15 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data;\
# install the PHP extensions we need (+adding bz2, gmp, imagick, imap with bzip2-dev gmp-dev imagemagick-dev imap-dev krb5-dev )
# see https://docs.nextcloud.com/server/12/admin_manual/installation/source_installation.html
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
    ; \
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
    )"; \
    apk add --virtual .nextcloud-phpext-rundeps $runDeps; \
    apk del .build-deps; \
    docker-php-source delete; \
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
    set -ex; \
    apk add --virtual .fetch-deps \
        bzip2 \
        gnupg \
    ; echo "nextcloud version=${NEXTCLOUD_VERSION}"; ls -l; \
    \
    curl -fsSL -o nextcloud.tar.bz2 \
        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2"; \
    curl -fsSL -o nextcloud.tar.bz2.asc \
        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2.asc"; \
    curl -fsSL -o nextcloud.tar.bz2.sha256 \
        "https://download.nextcloud.com/server/releases/nextcloud-${NEXTCLOUD_VERSION}.tar.bz2.sha256"; \
    ls -l; gpg --import /tmp/nextcloud.asc;\
    gpg --verify nextcloud.tar.bz2.asc && \
    sha256sum -c nextcloud.tar.bz2.sha256 && \
    echo "source archieve nextcloud-$NEXTCLOUD_VERSION.tar.bz2 SHA256 and GPG are Good!";\
    tar -xjf nextcloud.tar.bz2 -C /usr/src/;\
    rm nextcloud.tar.bz2 *.asc *.sha256 /tmp/nextcloud.asc;\
    rm -rf /usr/src/nextcloud/updater; \
    mkdir -p /usr/src/nextcloud/data; \
    mkdir -p /usr/src/nextcloud/custom_apps; \
    chmod +x /usr/src/nextcloud/occ;\
    apk del .fetch-deps; \
    rm -rf /var/cache/apk/*;ls /usr/src/;ls /usr/src/nextcloud/; \
    echo "ping.path = /ping" >> /usr/local/etc/php-fpm.conf; \
    echo "ping.response = pong" >> /usr/local/etc/php-fpm.conf; \
    echo "access.log = /dev/null" >> /usr/local/etc/php-fpm.conf; \
    echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/www.conf \
# to get fpm status use command ping or status like this: SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000
HEALTHCHECK --interval=10s --timeout=3s --start-period=30s \
        CMD \
        SCRIPT_NAME=/ping \
        SCRIPT_FILENAME=/ping \
        REQUEST_METHOD=GET \
        cgi-fcgi -bind -connect 127.0.0.1:9000 || exit 1

COPY *.sh /
COPY config/* /usr/src/nextcloud/config/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
