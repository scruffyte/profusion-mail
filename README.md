Profusion Media Interview Task: Create a Dockerised Mail Server

Instructions:

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