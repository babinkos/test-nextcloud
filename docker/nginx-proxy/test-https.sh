#!/bin/sh
set -eu
curl -kf https://localhost/ping
#wget --quiet --no-check-certificate --tries=1 --spider https://localhost/ping
