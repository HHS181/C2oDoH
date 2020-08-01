#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/Clients"
scDir="/home/user/.scripts"

# Download TLS Proxy certificate and install it
curl http://10.5.5.254:8000/.mitmproxy/mitmproxy-ca.pem -o mitmproxy-ca.pem
openssl x509 -in mitmproxy-ca.pem -inform PEM -out ca.crt
trust anchor ca.crt

# Clone git repositories
mkdir /home/user/PartyLoud
git clone https://github.com/realtho/PartyLoud.git /home/user/PartyLoud

# Download additional scripts
mkdir $scDir
curl $SERVER/proxyup.sh -o $scDir/proxyup.sh
curl $SERVER/proxydown.sh -o $scDir/proxydown.sh
chmod a+x $scDir/proxyup.sh
chmod a+x $scDir/proxydown.sh

# Set additional configs
curl $SERVER/client_a/partyloud.conf -o /home/user/PartyLoud/partyloud.conf
echo "alias proxyup='. $scDir/proxyup.sh'" >> /home/user/.bashrc
echo "alias proxydown='. $scDir/proxydown.sh'" >> /home/user/.bashrc

# Change ownership of all files in user home directory
chown -R user:user /home/user

# Cleanup 
rm -rf /root/temp
