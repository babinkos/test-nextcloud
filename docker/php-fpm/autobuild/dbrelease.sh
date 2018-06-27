#!/bin/sh
set -eu
echo "$NEXTCLOUD_VERSION"
echo "$POSTGRES_DB"
#13.0.2
PGHOST=$POSTGRES_HOST
pg_dump -O $POSTGRES_DB /tmp/$POSTGRES_DB.sql
PGDATABASE="ncdb_$(echo "$NEXTCLOUD_VERSION" | tr . _)"
