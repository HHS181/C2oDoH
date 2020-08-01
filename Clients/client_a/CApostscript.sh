#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/Clients"

# Download TLS Proxy certificate and install it
curl http://10.5.5.254:8000/.mitmproxy/mitmproxy-ca.pem -o mitmproxy-ca.pem
openssl x509 -in mitmproxy-ca.pem -inform PEM -out ca.crt
trust anchor ca.crt

# Clone git repositories
git clone https://github.com/realtho/PartyLoud.git /home/user

# Download additional scripts
curl $SERVER/proxyup.sh -o /home/user/proxyup.sh
curl $SERVER/proxydown.sh -o /home/user/proxydown.sh
chmod a+x /home/user/proxyup.sh
chmod a+x /home/user/proxydown.sh

# Download additional configs
curl $SERVER/client_a/partyloud.conf -o /home/user/PartyLoud/partyloud.conf

# Change ownership of all files in user home directory
chown -R user:user /home/user

# Cleanup 
rm -rf /root/temp
