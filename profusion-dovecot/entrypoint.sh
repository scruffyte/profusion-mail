#!/bin/bash

# Hash password, even though we're providing it in plaintext in .env -  LIKE I SAID, IT'S BAD!! 
HASHED_PASS=$(doveadm pw -s SHA512-CRYPT -p "$SMTP_PASS")

# Write to passwd file
echo "$SMTP_USER:$HASHED_PASS" >/etc/dovecot/passwd

# make an attempt at correct permissions
chown root:dovecot /etc/dovecot/passwd
chmod 640 /etc/dovecot/passwd

# Terminal validation
echo "Created SASL user $SMTP_USER"

# validate and print dovecot config for debugging
dovecot -n

# start dovecot
exec dovecot -F