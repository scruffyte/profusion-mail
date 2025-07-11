#!/bin/bash
set -e

envsubst < /opt/profusion-postfix/main.cf.template > /etc/postfix/main.cf

echo "Starting rsyslog..."
# Start rsyslog to capture Postfix logs and redirect them to stdout
rsyslogd

echo "Starting postfix..."
# Start postfix in foreground:
postfix start-fg
