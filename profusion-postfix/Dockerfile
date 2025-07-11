# Hi Profusion! Thank you for taking my application forward. I've recently done battle with my own mail system, and was excted to get going on this task. -Max Jacoby

# Base image: I opted for debian as that's what I'm most familiar with, and the slim version to keep things small. 
# I would use Alpine, although I'm aware it has some quirks with SSL (and in general with minimal binaries). Especially painfull for development. Debain slim is a good trade off between size, stability and practicality.
FROM debian:12.11-slim

# So people can complain to me when it breaks
LABEL maintainer="max.jacoby@profusion.com"
LABEL description="Profusion MTA container based on Postfix"

# Set noninteractive mode to make sure unattended installations go smoothy
ENV DEBIAN_FRONTEND=noninteractive

# MTA choice: Postfix. Not exciting, but just plain works. Does everything we need, not much else and is performant.
# Runner up: Exim. Native debian support, but everyone knows Postfix. Premade FOSS bundles like Postal are great but add bloat and more attack surface (also cheating in this instance).
# Install dependencies and clean up to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends postfix gettext-base netcat-traditional && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /opt/profusion-postfix

# Copy entrypoint and template postfix config which will be added to by environment variables.
COPY entrypoint.sh .
COPY conf/main.cf.template .
COPY conf/master.cf /etc/postfix/master.cf

# Here, I'd copy the contents of the 'certs' directory with:
# COPY certs/ /etc/ssl/mail/

# However, this gives me the heebie jeebies two reasons: 
    # 1. Baking certificates into the image is a security risk. The validity of the certs then rely on nobody doing anything silly with the image, like pushing it to docker hub by accident or hosting it on a publically acessible registry.
    # 2. The image has to be rebuilt and redeployed every time the certificate needs renewing. 

# Instead, I'm going to mount a volume at runtime containing the certs
# This means if multiple instances were deployed behind a load balancer, for example, they can all can mount the same cert, simplifying deployment and lifecycle management when the certs need renewing. 
# See 'refresh-certs/cron.sh' for an example cron job which could do this automatically on the host.

RUN chmod +x /opt/profusion-postfix/entrypoint.sh

# Expose SMTP/STARTTLS & SMTPS ports
EXPOSE 25 587

# add a healthcheck!
HEALTHCHECK CMD bash -c "timeout 2 nc -w 2 localhost 587 | grep -q '^220'"

# Entrypoint for container startup
ENTRYPOINT [ "/opt/profusion-postfix/entrypoint.sh" ]