#!/bin/sh
set -e

cat WELCOME
service  rsyslog  start
service  haproxy start

exec "$@"
