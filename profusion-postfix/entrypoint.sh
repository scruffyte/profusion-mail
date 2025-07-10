#!/bin/bash
set -e

# Substitute environment variables into the postfix config and put the final version in the postfix directory:
envsubst < /opt/profusion-postfix/main.cf.template > /etc/postfix/main.cf

# Start postfix in foreground:
exec postfix start-fg
