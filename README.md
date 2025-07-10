Author: Max Jacoby
Date: 09.07.25
Content: Profusion Media Interview Task: Create a Dockerised Mail Server

REQUIREMENTS:

Apart from docker and a user with correct privileges, OpenSSL is needed on the host to genereate self signed certs if necessary. Install it with:

sudo apt install openssl

HOW TO USE THIS IMAGE:

1. If you have valid certificates, copy them into the 'certs' directory. They should be in .pem format, and should be named 'cert.pem' and 'key.pem'. If you do not provide a certificate, a self signed one will be generated.
2. Edit '.env' to set environment variables like hostname, relay domain, allowed subnets.
3. Run 'start.sh'. This will generate certificates if necessary and execute 'docker-compose.yml'.



-----------------

Write a brand new docker container. This container should:

  * Not be based upon any existing container published to the internet
  * Start with a Linux distribution of your choice (We use Debian-based distros internally, but you should use what you prefer)
  * Install a mail server of your choice
  * Copy in an SSL certificate (it should accept a verified one, but can test with self signed certs)
  * The mail server should be configured only to allow relaying email from the subnet 192.168.213.0/24
  * The mail server should be configured to relay to an email domain specified in a parameter
  * The mail server should be configured to support TLS/SSL for sending and receiving
  * Expose port 25 (plaintext and STARTSSL), and port 587 (SSL only)
  * Present the script in a zip file

-----------------



  