#!/bin/bash
set -e

envsubst < /opt/profusion-postfix/main.cf.template > /etc/postfix/main.cf

echo "Starting postfix..."
# Start postfix in foreground:
postfix start-fg
