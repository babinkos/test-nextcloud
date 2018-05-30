# adding bz2, gmp, imagick, imap PHP extension on-top of base image
# also disabling mcypt PHP extension as insecure
# since we use apk install several times - no-cache removed, we remove cache at the end with rm
# adding Fastly's CDN as repository
FROM nextcloud:fpm-alpine

RUN echo http://alpine.gliderlabs.com/alpine/v`cat /etc/alpine-release | cut -d"." -f1,2`/main > /etc/apk/repositories; \
apk add -U --virtual .build-deps \
    bzip2-dev \
    gmp-dev \
    imagemagick-dev \
    imap-dev \
    krb5-dev \
; \
docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
docker-php-ext-install \
    bz2 \
    gmp \
    imap \
; \
pecl install \
    imagick \
; \
docker-php-ext-enable \
    imagick \
; \
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
rm -rf /var/cache/apk/*; \
echo ";extension=mcrypt.so" > /usr/local/etc/php/conf.d/docker-php-ext-mcrypt.ini

#VOLUME /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
