#!/bin/bash

# This is an example script which would be run as a cron job, designed to fetch fresh certs from an imagninary remote server and restart the containers.
# crontab entry, midnight every Monday. If LE autorenew is set up, it will renew them long before they get copied every week so there's no chance of them expiring.
# 0 0 * * MON /path/to/this/folder/refresh-certs.sh >> /path/to/this/folder/refresh-certs.log 2>&1

# This isn't particularly elegant, but it does work. Maybe not this exact script but the theory behind it is solid.

current_date_time=$(date)
echo "Starting at $current_date_time - Copying fullchain and privkey cert files"

# Assuming we have SSH keys for the remote user and correct permissions, copy the files.
scp -r user@192.168.5.5:/etc/letsencrypt/live/mail.profusion.com/fullchain.pem ../certs/cert.pem
scp -r user@192.168.5.5:/etc/letsencrypt/live/mail.profusion.com/privkey.pem ../certs/key.pem

# Restart containers
docker restart $(docker ps -qaf name=profusion-postfix)