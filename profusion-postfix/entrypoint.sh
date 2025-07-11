#!/bin/bash
set -e

envsubst < /opt/profusion-postfix/main.cf.template > /etc/postfix/main.cf

# it was DNS...
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

echo "Starting postfix..."
# Start postfix in foreground:
postfix start-fg
