#!/bin/sh
set -eu
curl -kf http://127.0.0.1/ping
#wget --quiet --no-check-certificate --tries=1 --spider https://localhost/ping
