#!/bin/bash

# This is a handy litle scrit (made by ChatGPT) to make my testing easier

echo "=== SWAKS Test Email Sender ==="

read -p "SMTP server hostname or IP: " SMTP_SERVER
read -p "SMTP port (default 587): " SMTP_PORT
SMTP_PORT=${SMTP_PORT:-587}

read -p "FROM email address: " FROM_EMAIL
read -p "TO email address: " TO_EMAIL

read -p "SMTP username: " SMTP_USER
read -s -p "SMTP password: " SMTP_PASS
echo ""

read -p "Use TLS? (yes/no) [yes]: " USE_TLS
USE_TLS=${USE_TLS:-yes}

read -p "Subject: " SUBJECT
read -p "Message body: " BODY

echo ""
echo "Sending test email..."

swaks --to "$TO_EMAIL" \
      --from "$FROM_EMAIL" \
      --server "$SMTP_SERVER" \
      --port "$SMTP_PORT" \
      --auth LOGIN \
      --auth-user "$SMTP_USER" \
      --auth-password "$SMTP_PASS" \
      $( [[ "$USE_TLS" == "yes" ]] && echo "--tls" ) \
      --header "Subject: $SUBJECT" \
      --body "$BODY"
