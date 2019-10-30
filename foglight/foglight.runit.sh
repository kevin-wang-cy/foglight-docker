#!/bin/sh
set -e

FMS_DIR=/home/foglight/fms

if [ ! -d "$FMS_DIR" ]; then
    mkdir -p "$FMS_DIR"
    echo "$FMS_DIR created."
fi

chown -R foglight:foglight $FMS_DIR

exec chpst -u foglight $FMS_DIR/bin/fms -s -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=65000 -Dquest.debug=2
