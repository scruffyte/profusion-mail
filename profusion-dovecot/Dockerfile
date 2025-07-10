# Dovecot image to enable SASL authentication for Postfix. All mail protocols are disabled and this is a purely for authenticaiton.
# Cyrus SASL is more lightweight, but Dovecot is simpler to setup and use with postfix. Can also easily intergrate with a database or LDAP server.

# Base image:
FROM debian:12.11-slim

# So people can complain to me when it breaks
LABEL maintainer="max.jacoby@profusion.com"
LABEL description="Profusion MTA container based on Postfix"

# Set noninteractive mode to make sure unattended installations go smoothy
ENV DEBIAN_FRONTEND=noninteractive

# Install Dovecot
RUN apt-get update && \
    apt-get install -y --no-install-recommends dovecot-core dovecot-sasl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /opt/profusion-dovecot

# Copy entrypoint
COPY entrypoint.sh .
COPY conf/dovecot.conf /etc/dovecot/

RUN chmod +x /opt/profusion-dovecot/entrypoint.sh

# Expose port for SASL
EXPOSE 12345

# Entrypoint for container startup
ENTRYPOINT [ "/opt/profusion-dovecot/entrypoint.sh" ]