FROM alpine:3.7
RUN echo "http://alpine.gliderlabs.com/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main" > /etc/apk/repositories;\
apk fetch -U \
    rsync \
    fcgi \
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
    libpng-dev \
    libmemcached-dev \
    libxml2-dev \
    openldap-dev \
    pcre-dev \
    postgresql-dev \
    bzip2 \
    gnupg
RUN apk fetch \
  abuild acct alpine-baselayout alpine-keys alpine-sdk apk-tools attr autoconf binutils binutils-libs build-base busybox bzip2 bzip2-dev c-client ca-certificates cryptsetup-libs curl cyrus-sasl-dev db device-mapper-libs e2fsprogs-dev e2fsprogs-libs expat fakeroot fcgi fontconfig fortify-headers freetype freetype-dev g++ gcc git gmp gmp-dev gnupg gnutls icu-dev icu-libs imagemagick-c++ imagemagick-dev imagemagick-libs imap-dev isl keyutils-libs kmod krb5-conf krb5-dev krb5-libs krb5-server-ldap lcms2 lddtree libacl libassuan libatomic libattr libblkid libburn libbz2 libc-dev libc-utils libcap libcom_err libcurl libedit libfdisk libffi libgcc libgcrypt libgmpxx libgomp libgpg-error libisoburn libisofs libjpeg-turbo libjpeg-turbo-dev libksba libldap libltdl libmemcached-dev libmemcached-libs libmount libpcre16 libpcre32 libpcrecpp libpng libpng-dev libpq libressl libressl-dev libressl2.6-libcrypto libressl2.6-libssl libressl2.6-libtls libsasl libsmartcols libssh2 libstdc++ libtasn1 libunistring libuuid libverto libxml2 libxml2-dev lz4-libs lzip lzo m4 make mkinitfs mpc1 mpfr3 mtools musl musl-dev musl-utils ncurses-libs ncurses-terminfo ncurses-terminfo-base nettle npth openldap-dev p11-kit patch pax-utils pcre pcre-dev pcre2 perl pinentry pkgconf popt postgresql-dev postgresql-libs rsync scanelf squashfs-tools sudo tar util-linux-dev xorriso xz-libs zlib zlib-dev

# next use:
# COPY --from=myapk-cache:latest /*.apk /
# COPY --from=myapk-cache:latest /var/cache/ /var/cache/
