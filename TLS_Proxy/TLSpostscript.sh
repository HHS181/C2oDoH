#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/TLS_Proxy"

# Change hostname
sed -i 's/debian/TLSProxy/g' /etc/hostname
sed -i 's/debian/TLSProxy/g' /etc/hosts

# Install mitmproxy
apt-get update
apt-get -y install mitmproxy

# Setup simple HTTP server for certificate downloads
(echo "@reboot sleep 30 && python3 -m http.server") | crontab -

# Cleanup
rm -rf /root/temp
