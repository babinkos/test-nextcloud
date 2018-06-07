#!/bin/sh
set -eu
/usr/local/bin/generate-certs
exec "$@"
