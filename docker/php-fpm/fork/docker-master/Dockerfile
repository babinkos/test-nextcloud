# adding bz2, gmp, imagick, imap PHP extension on-top of base image
FROM nextcloud:fpm-alpine

RUN
apk add --no-cache --virtual .build-deps \
    alpine-sdk \
    autoconf \
    bzip2-dev \
    freetype-dev \
    g++ \
    gmp \
    gmp-dev \
    icu-dev \
    imagemagick-dev \
    imap-dev \
    krb5-dev \
    libtool \
    libxml2-dev \
    make \
    openldap-dev \
    pcre-dev \
    postgresql-dev \
; \
\
docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
docker-php-ext-install \
    bz2 \
    gmp \
    imap \
    pdo_pgsql \
    zip \
; \
pecl install \
    imagick \
; \
docker-php-ext-enable \
    imagick \
; \
\
runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
        | tr ',' '\n' \
        | sort -u \
        | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
)"; \
echo $runDeps; \
apk add --virtual .nextcloud-phpext-rundeps $runDeps; \
apk del .build-deps; \
docker-php-source delete ; \
rm -rf /var/cache/apk/*

VOLUME /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
