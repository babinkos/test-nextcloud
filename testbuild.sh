#!/bin/sh
# testing docker\php-fpm\autobuild\Dockerfile
mkdir testbuild
cd testbuild
git init
git remote add -f origin https://github.com/babinkos/test-nextcloud.git
git config core.sparseCheckout true
echo "docker/php-fpm/autobuild/*" >> .git/info/sparse-checkout
git pull origin dev
cd docker\php-fpm\autobuild
docker run --rm -i hadolint/hadolint < Dockerfile
time docker build -t testbuild . | tee buildlog.txt
