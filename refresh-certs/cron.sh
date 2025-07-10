#!/bin/bash

# This is an example script which would be run as a cron job, designed to fetch fresh certs from an imagninary remote server and restart the containers.
# crontab entry, midnight every Monday:
# 0 0 * * MON /path/to/this/file/refresh-certs.sh >> /path/to/this/file/refresh-certs.log 2>&1

# This isn't great but you get the picture.

workdir=$(pwd)
current_date_time=$(date)
echo "Starting at $current_date_time - Copying fullchain and privkey cert files to $workdir/certs"

# Assuming we have SSH keys for the remote user and correct permissions, copy the files.
scp -r user@10.0.0.55:/etc/letsencrypt/live/mail.profusion.com/fullchain.pem $workdir/certs/cert.pem
scp -r user@10.0.0.55:/etc/letsencrypt/live/mail.profusion.com/privkey.pem $workdir/certs/key.pem

# set permissions (these are probably wrong but will depend on environment)
chown root:root $workdir/certs/cert.pem
chown root:root $workdir/certs/key.pem
chmod 644 $workdir/certs/cert.pem
chmod 644 $workdir/certs/key.pem

# Restart containers
docker restart $(docker ps -qaf name=profusion-mta)