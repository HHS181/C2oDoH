#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/TLS_Proxy"

# Change hostname
sed -i 's/debian/TLSProxy/g' /etc/hostname
sed -i 's/debian/TLSProxy/g' /etc/hosts

# Install mitmproxy
apt-get update
apt-get -y install mitmproxy

# Run mitmproxy for certificate generation
timeout 60s mitmproxy

# Network configuration for mitmproxy
curl $SERVER/sysctl.conf -o /etc/sysctl.conf
mkdir /etc/iptables
curl $SERVER/rules.v4 -o /etc/iptables/rules.v4
(echo "@reboot sleep 10 && iptables-restore < /etc/iptables/rules.v4") | crontab -

# Setup simple HTTP server for certificate downloads
(echo "@reboot sleep 10 && python3 -m http.server") | crontab -

# Cleanup
rm -rf /root/temp
