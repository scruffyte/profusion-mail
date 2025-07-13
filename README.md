**Author:** Max Jacoby

**Date:** 09.07.25

**Content:** Profusion Media Interview Task: Create a Dockerized Mail Server

You may clone this repository with `git clone https://github.com/scruffyte/profusion-mail.git`

This repository will be made private upon conclusion of the interview.

**REQUIREMENTS**:

*   Docker & Docker Compose
    
*   OpenSSL
    

**HOW TO USE THIS REPO:**

1.  If you have valid certificates, put them into the 'certs' directory. They should be named 'cert.pem' and 'key.pem'. If you do not provide certificates, a self signed one will be generated.
    
2.  Edit '.env' to your liking.
    
3.  `chmod +x start.sh`
    
4.  `./start.sh -d` This will generate certificates if necessary, build and run the containers. If you would like stdout of the containers, omit ‘-d’.
    

**NOTES:**

*   Submission on port 587 require TLS and authentication. Default username and password are 'profusion' and 'OL3GhU0k1v2' - but can be changed by editing .env. (If this were a production environment, I would not put the default credentials in the readme of a public repo (or in compose.yml, for that matter). There are various security problems with the way I've done credentials, and since this is a demo, it's not such a big deal.)
    
*   I wasn't 100% on the routing instructions, so I made a best guess; ONLY mail from $ALLOW\_FROM will be accepted. Everything else will be rejected. Allowed mail will be routed to $RELAY\_TO\_HOST. $HOST\_TO\_RELAY defaults to '\*' and will route everything to $RELAY\_TO\_HOST unless otherwise specified. Nothing is delivered locally.
    
*   This setup does not currently include DKIM. Without DKIM and DNS entries like SPF and DMARC the deliveribility of emails sent from this server will be very low.
    

**ORIGINAL INSTRUCTIONS:**

Write a brand new docker container. This container should:

  \* Not be based upon any existing container published to the internet

  \* Start with a Linux distribution of your choice (We use Debian-based distros internally, but you should use what you prefer)

  \* Install a mail server of your choice

  \* Copy in an SSL certificate (it should accept a verified one, but can test with self signed certs)

  \* The mail server should be configured only to allow relaying email from the subnet 192.168.213.0/24

  \* The mail server should be configured to relay to an email domain specified in a parameter

  \* The mail server should be configured to support TLS/SSL for sending and receiving

  \* Expose port 25 (plaintext and STARTSSL), and port 587 (SSL only)

  \* Present the script in a zip file