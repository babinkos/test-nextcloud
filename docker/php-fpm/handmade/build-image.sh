#!/usr/bin/env bash
# expected to have repository cloned in subdir docker/13.0/fpm-alpine
NEXTCLOUD_VERSION=13.0.2


if [[ ! -f "nextcloud-$NEXTCLOUD_VERSION.tar.bz2" ]]; then
  echo "nextcloud-$NEXTCLOUD_VERSION.tar.bz2 doesn't exist in build context directory, downloading..."
  wget -q "https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.tar.bz2"
else
  ls -l "nextcloud-$NEXTCLOUD_VERSION.tar.bz2"
  echo "nextcloud-$NEXTCLOUD_VERSION.tar.bz2 exist in build context directory"
fi

wget -q "https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.tar.bz2.asc"
wget -q "https://download.nextcloud.com/server/releases/nextcloud-$NEXTCLOUD_VERSION.tar.bz2.sha256"

cat <<EOF >nextcloud.asc
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
M704NM/xbc23
=ykUA
-----END PGP PUBLIC KEY BLOCK-----
EOF

gpg --import nextcloud.asc
gpg --verify nextcloud-$NEXTCLOUD_VERSION.tar.bz2.asc && \
sha256sum -c nextcloud-$NEXTCLOUD_VERSION.tar.bz2.sha256 && \
echo "source archieve nextcloud-$NEXTCLOUD_VERSION.tar.bz2 SHA256 and GPG are Good!" && \
rm *.asc *.sha256 && \
#cd ../../.. ; exit 1
time docker build -t my_nextcloud:phpext . | tee buildlog.txt
echo "Job is done !!"
