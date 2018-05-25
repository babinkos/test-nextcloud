#!/usr/bin/env bash
sudo apt install docker.io aufs-tools btrfs-tools debootstrap docker-doc rinse zfs-fuse duperemove ubuntu-keyring rpm-i18n alien elfutils rpmlint rpm2cpio kpartx
sudo usermod -aG docker $USER
#nginx:alpine redis:alpine php:7.2-fpm-alpine3.7
