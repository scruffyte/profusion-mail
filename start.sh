#!/bin/bash

# Check for user provided certs, if not, use self signed certs by default for some layer of security.

CRT="certs/cert.pem"
KEY="certs/key.pem"

if [[ -f certs/cert.pem && -f certs/key.pem ]]; then
    echo "[SSL] Using provided SSL certs."
else
    echo "[SSL] No certs found. Generating snake oil certs..."
    openssl req -x509 -newkey rsa:4096 -keyout "$KEY" -out "$CRT" -days 365 -subj "/C=GB/ST=London/L=London/O=Profusion/OU=Infrastrucutre/CN=${HOSTNAME}" -sha256 -nodes
fi

chmod 600 "$KEY"
chmod 644 "$CRT"

echo -e "

 █████   █████  ███     ███████████                        ██████                      ███                      ███
░░███   ░░███  ░░░     ░░███░░░░░███                      ███░░███                    ░░░                      ░███
 ░███    ░███  ████     ░███    ░███ ████████   ██████   ░███ ░░░  █████ ████  █████  ████   ██████  ████████  ░███
 ░███████████ ░░███     ░██████████ ░░███░░███ ███░░███ ███████   ░░███ ░███  ███░░  ░░███  ███░░███░░███░░███ ░███
 ░███░░░░░███  ░███     ░███░░░░░░   ░███ ░░░ ░███ ░███░░░███░     ░███ ░███ ░░█████  ░███ ░███ ░███ ░███ ░███ ░███
 ░███    ░███  ░███     ░███         ░███     ░███ ░███  ░███      ░███ ░███  ░░░░███ ░███ ░███ ░███ ░███ ░███ ░░░ 
 █████   █████ █████    █████        █████    ░░██████   █████     ░░████████ ██████  █████░░██████  ████ █████ ███
░░░░░   ░░░░░ ░░░░░    ░░░░░        ░░░░░      ░░░░░░   ░░░░░       ░░░░░░░░ ░░░░░░  ░░░░░  ░░░░░░  ░░░░ ░░░░░ ░░░ 
                                                                                                                   
                                                                                                                   
                                                                                                                   
 █████   █████  ███                        ██████   ██████          ███                                            
░░███   ░░███  ░░░                        ░░██████ ██████          ░███                                            
 ░███    ░███  ████  ████████   ██████     ░███░█████░███   ██████ ░███                                            
 ░███████████ ░░███ ░░███░░███ ███░░███    ░███░░███ ░███  ███░░███░███                                            
 ░███░░░░░███  ░███  ░███ ░░░ ░███████     ░███ ░░░  ░███ ░███████ ░███                                            
 ░███    ░███  ░███  ░███     ░███░░░      ░███      ░███ ░███░░░  ░░░                                             
 █████   █████ █████ █████    ░░██████     █████     █████░░██████  ███                                            
░░░░░   ░░░░░ ░░░░░ ░░░░░      ░░░░░░     ░░░░░     ░░░░░  ░░░░░░  ░░░                                             
                                                                                                                   

"

DETACHED=""

while getopts "d" opt; do
  case $opt in
    d)
      DETACHED="-d"
      ;;
    *)
      echo "Usage: $0 [-d]"
      exit 1
      ;;
  esac
done

docker compose build
docker compose up $DETACHED