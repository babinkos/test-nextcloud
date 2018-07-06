#!/bin/sh
set -eu
curl -skf http://127.0.0.1:88/ping
#wget --quiet --no-check-certificate --tries=1 --spider https://localhost/ping
