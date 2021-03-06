#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/Clients"
scDir="/home/user/.scripts"

# Download TLS Proxy certificate and install it
curl http://10.5.5.254:8000/.mitmproxy/mitmproxy-ca.pem -o mitmproxy-ca.pem
openssl x509 -in mitmproxy-ca.pem -inform PEM -out ca.crt
trust anchor ca.crt

# Enable services at reboot
systemctl enable dnscrypt-proxy
systemctl enable dnsmasq

# Clone git repositories
mkdir /home/user/PartyLoud
git clone https://github.com/realtho/PartyLoud.git /home/user/PartyLoud
mkdir /home/user/dnscat2
git clone https://github.com/iagox86/dnscat2.git /home/user/dnscat2

# Download additional scripts
mkdir $scDir
curl $SERVER/proxyup.sh -o $scDir/proxyup.sh
curl $SERVER/proxydown.sh -o $scDir/proxydown.sh
curl $SERVER/noise.sh -o $scDir/noise.sh
chmod a+x $scDir/proxyup.sh
chmod a+x $scDir/proxydown.sh
chmod a+x $scDir/noise.sh

# Set additional configs
curl $SERVER/20-connectivity.conf -o /etc/NetworkManager/conf.d/20-connectivity.conf
curl $SERVER/client_c/dns.conf -o /etc/NetworkManager/conf.d/dns.conf
systemctl restart NetworkManager
curl $SERVER/client_c/resolv.conf -o /etc/resolv.conf
curl $SERVER/client_c/dnsmasq.conf -o /etc/dnsmasq.conf
curl $SERVER/client_c/dnscrypt-proxy.toml -o /etc/dnscrypt-proxy/dnscrypt-proxy.toml
curl $SERVER/client_c/partyloud.conf -o /home/user/PartyLoud/partyloud.conf
echo "alias proxyup='. $scDir/proxyup.sh'" >> /home/user/.bashrc
echo "alias proxydown='. $scDir/proxydown.sh'" >> /home/user/.bashrc
echo "alias dnscat2='/home/user/dnscat2/client/dnscat'" >> /home/user/.bashrc
echo "alias noise='. $scDir/noise.sh'" >> /home/user/.bashrc

# Change ownership of all files in user home directory
chown -R user:user /home/user

# Cleanup 
rm -rf /root/temp
