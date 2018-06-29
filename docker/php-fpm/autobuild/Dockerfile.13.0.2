# based on nextcloud:fpm-alpine sources
ARG PHP_VER=7.2
ARG ALPINE_VER=3.7
ARG NEXTCLOUD_VERSION=13.0.2
FROM php:${PHP_VER}-fpm-alpine${ALPINE_VER}
ARG PHP_VER
ARG ALPINE_VER
ARG NEXTCLOUD_VERSION
ENV NC_URL="https://download.nextcloud.com/server/releases/nextcloud"
COPY *.sh /
COPY nextcloud.asc /tmp/nextcloud.asc
COPY --from=docker.io/k0s2018/test-nextcloud:docker-gen.builder /artifacts/confd /usr/local/bin/
COPY files/confd /etc/confd/
COPY config/* /tmp/config/
VOLUME /var/www/html
RUN set -ex; \
    chmod +x /*.sh; \
    chmod +x /usr/local/bin/confd; \
    sync; \
    /usr/local/bin/confd -version; \
    apk -q add -U \
        bzip2 \
        fcgi \
        rsync \
        zip; \
    rm /var/spool/cron/crontabs/root; \
    echo '*/15 * * * * php -f /var/www/html/cron.php' > /var/spool/cron/crontabs/www-data;\
# install the PHP extensions we need (+adding bz2, gmp, imagick, imap with bzip2-dev gmp-dev imagemagick-dev imap-dev krb5-dev )
# see https://docs.nextcloud.com/server/12/admin_manual/installation/source_installation.html
    apk -q add --virtual .build-deps \
        alpine-sdk \
        autoconf \
        bzip2-dev \
        freetype-dev \
        gmp-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        krb5-dev \
        libbz2 \
        libzip-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libmemcached-dev \
        libxml2-dev \
        openldap-dev \
        pcre-dev \
        postgresql-dev \
    ; \
    docker-php-ext-configure gd --with-freetype-dir=/usr --with-png-dir=/usr --with-jpeg-dir=/usr > /dev/null; \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl > /dev/null; \
    docker-php-ext-configure ldap > /dev/null; \
    docker-php-ext-configure zip --with-libzip > /dev/null; \
    docker-php-ext-install -j$(nproc) \
        bz2 \
        exif \
        gd \
        gmp \
        intl \
        imap \
        ldap \
        opcache \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        zip \
    > /dev/null; \
    pecl install \
        APCu-5.1.11 \
        imagick \
        memcached-3.0.4 \
        redis-3.1.6 \
    > /dev/null; \
    docker-php-ext-enable \
        apcu \
        imagick \
        memcached \
        redis \
    ; \
    runDeps="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )"; \
    apk -q add --virtual .nextcloud-phpext-rundeps $runDeps; \
    apk -q del .build-deps; \
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
    { \
      echo 'ping.path = /ping'; \
      echo 'ping.response = pong'; \
      echo 'access.log = /dev/null'; \
      } >> /usr/local/etc/php-fpm.conf ; \
      echo 'pm.max_children = 10' >> /usr/local/etc/php-fpm.d/www.conf.default ; \
    echo 'pm.status_path = /status' >> /usr/local/etc/php-fpm.d/www.conf
RUN \
    set -ex; \
    apk add --virtual .fetch-deps \
        gnupg; \
    echo "nextcloud version=${NEXTCLOUD_VERSION}"; \
    ls -l; \
    curl -fsSL -o nextcloud.tar.bz2 "${NC_URL}-${NEXTCLOUD_VERSION}.tar.bz2"; \
    curl -fsSL -o nextcloud.tar.bz2.asc "${NC_URL}-${NEXTCLOUD_VERSION}.tar.bz2.asc"; \
    curl -fsSL -o nextcloud.tar.bz2.sha256 "${NC_URL}-${NEXTCLOUD_VERSION}.tar.bz2.sha256"; \
    ls -l; gpg --import /tmp/nextcloud.asc;\
    gpg --verify nextcloud.tar.bz2.asc && \
    echo "s/-$NEXTCLOUD_VERSION//g"; sed -i "s/-$NEXTCLOUD_VERSION//g" nextcloud.tar.bz2.sha256; \
    sha256sum -c nextcloud.tar.bz2.sha256 && \
    echo "source archieve nextcloud-$NEXTCLOUD_VERSION.tar.bz2 SHA256 and GPG are Good!";\
    tar -xjf nextcloud.tar.bz2 -C /usr/src/;\
    rm -f nextcloud.tar.bz2 ./*.asc ./*.sha256 /tmp/nextcloud.asc; \
    rm -f /*.apk; \
    rm -rf /usr/src/nextcloud/updater; \
    mkdir -p /usr/src/nextcloud/data; \
    mkdir -p /usr/src/nextcloud/custom_apps; \
    find /usr/src/nextcloud/ -type d -exec chmod 750 {} \; ; \
    find /usr/src/nextcloud/ -type f -exec chmod 640 {} \; ; \
    chmod +x /usr/src/nextcloud/occ;\
    apk del .fetch-deps ; \
    rm -rf /var/cache/apk/* ; \
    ls /usr/src/ ; \
    ls /usr/src/nextcloud/ ; \
    cp /tmp/config/* /usr/src/nextcloud/config/ ; \
  chown -R www-data:root /usr/src/nextcloud/ ; \
  php -m ; \
  rm "/usr/src/nextcloud/config/config.sample.php" ; \
  /test-fcgi.sh || exit 1 ; \
  echo "Nextcloud version from version.php $(php -r 'require "/usr/src/nextcloud/version.php"; echo implode(".", $OC_Version);') is packaged into image."
HEALTHCHECK --interval=10s --timeout=3s --start-period=30s \
        CMD \
        /ping.sh || exit 1
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/confd-start.sh"]
