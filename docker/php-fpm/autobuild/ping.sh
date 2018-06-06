#!/bin/sh
set -eu
SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET /usr/bin/cgi-fcgi -bind -connect 127.0.0.1:9000
