#!/bin/sh
set -e

echo "<h1>Greeting from $HOSTNAME</h1>" > /usr/local/nginx/html/healthz.html
/usr/local/nginx/sbin/nginx

exec "$@"
