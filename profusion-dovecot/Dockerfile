# Dovecot image to enable SASL authentication for Postfix. All mail protocols are disabled and this is a purely for authenticaiton.
# Cyrus SASL is more lightweight, but Dovecot is simpler and I don't need a whole authentication backend - this is just for demo.
# Setting postfix up with something like LDAP would be ideal.

# Base image:
FROM debian:12.11-slim

# So people can complain to me when it breaks
LABEL maintainer="max.jacoby@profusion.com"
LABEL description="Profusion MTA container based on Postfix"

# Set noninteractive mode to make sure unattended installations go smoothy
ENV DEBIAN_FRONTEND=noninteractive

# Install Dovecot, netcat for healthcheck and clean up
RUN apt-get update && \
    apt-get install -y --no-install-recommends dovecot-core netcat-traditional && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /opt/profusion-dovecot

# Copy entrypoint and config
COPY entrypoint.sh .
COPY conf/dovecot.conf /etc/dovecot/dovecot.conf

# Make entrypoint executable
RUN chmod +x /opt/profusion-dovecot/entrypoint.sh

# Create vmail user
RUN addgroup --system vmail && \
    adduser --system --ingroup vmail --home /home/vmail --shell /usr/sbin/nologin vmail
RUN mkdir -p /home/vmail && chown -R vmail:vmail /home/vmail

# Expose port for SASL (this will not be exposed publically - ONLY EVER on internal network. dovecot TCP socket is not currently encrypted).
EXPOSE 12345

# add a healthcheck! This casues connection logs from localhost, which confused me for a bit. Couldn't figure out what was connecting to it. Duh.
HEALTHCHECK CMD bash -c "timeout 2 nc -w 2 localhost 12345 | grep -q 'MECH[[:space:]]*PLAIN'"

# Entrypoint for container startup
ENTRYPOINT [ "/opt/profusion-dovecot/entrypoint.sh" ]