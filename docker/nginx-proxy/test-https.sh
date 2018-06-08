#!/bin/sh
set -eu
#curl -f https://localhost/ping
wget --quiet --tries=1 --spider https://localhost/ping
