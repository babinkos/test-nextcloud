############################################################
# Dockerfile to build php-fpm container images for Nextcloud 13
# Based on alpine3_7
############################################################
#MAINTAINER babinkos
FROM php:7.2-fpm-alpine3.7
RUN apk update && \
    apk upgrade && \
    apk -v search \
      php7-apcu \
      php7-bz2 \
      php7-common \
      php7-exif \
      php7-gd \
      php7-gmp \
      php7-imap \
      php7-intl \
      php7-imagick \
      php7-ldap \
      php7-mcrypt \
      php7-memcached \
      php7-pdo_pgsql \
      php7-redis \
      php7-zip && \
    apk -v add \
      libxml2-dev icu-dev libmemcached-dev libpng libjpeg-turbo \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
      libmcrypt-dev \
      php7-apcu \
      php7-bz2 \
      php7-common \
      php7-exif \
      php7-gd \
      php7-gmp \
      php7-imap \
      php7-intl \
      php7-imagick \
      php7-ldap \
      php7-mcrypt \
      php7-memcached \
      php7-pdo_pgsql \
      php7-redis \
      php7-zip 
#RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
#    docker-php-ext-install -j$(nproc) bz2 exif gd gmp imap intl ldap pdo_pgsql zip && \
#    docker-php-ext-enable bz2 exif gd gmp imap intl ldap pdo_pgsql zip
#RUN apk cache clean
RUN rm -rf /var/cache/apk/*
#RUN sed -i 's/pm\ \=\ dynamic/pm\ \=\ ondemand/g' /usr/local/etc/php-fpm.d/www.conf
EXPOSE 9000
CMD ["php-fpm"]
