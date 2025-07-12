#!/bin/bash
set -e

# Sub in environment variables to the template for main.cf and put it in the postfix config dir
envsubst < /opt/profusion-postfix/main.cf.template > /etc/postfix/main.cf

# It was DNS...
# Couldn't figure out why postfix couldn't connect to dovecot. I didn't realise that postfix daemon processes run with chroot, meaning that it didn't get the containers resolv.conf and therefore couldn't resolve service hostnames.
# I could have turned off chroot in master.cf, but that seems like a reduction in security, so I just copy resolv.conf to the chroot dir. This wasn't my idea btw - I read it online.
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

echo "Starting postfix..."

# Start postfix in foreground:
postfix start-fg
