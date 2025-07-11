#!/bin/bash
set -e 

# Hash password, even though we're providing it in plaintext in .env lol. LIKE I SAID, IT'S BAD!! 
HASHED_PASS=$(doveadm pw -s SHA512-CRYPT -p "$SMTP_PASS")

# Write to sasl.passwd
echo "$SMTP_USER:$HASHED_PASS" >/etc/dovecot/passwd
chown root:dovecot /etc/dovecot/passwd
chmod 640 /etc/dovecot/passwd

echo "Created SASL user $SMTP_USER"

# validate dovecot config
dovecot -n

# start dovecot
exec dovecot -F