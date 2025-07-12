Author: Max Jacoby
Date: 09.07.25
Content: Profusion Media Interview Task: Create a Dockerised Mail Server

You may clone this repository with 'git clone 

REQUIREMENTS:

1. Docker & Docker Compose
2. OpenSSL

HOW TO USE THIS IMAGE:

1. If you have valid certificates, copy them into the 'certs' directory. They should be named 'cert.pem' and 'key.pem'. If you do not provide a certificates, a self signed one will be generated.
2. Edit '.env' to your liking.
3. chmod +x start.sh
3. Run 'start.sh -d'. This will generate certificates if necessary, build and run the setup. If you would like stdout of the containers, omit '-d'.



-----------------

Original Instructions:

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



  