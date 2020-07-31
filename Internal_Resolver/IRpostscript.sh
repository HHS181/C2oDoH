#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/Internal_Resolver"

# Install BIND
apt-get update
apt-get install bind9 bind9utils bind9-doc bind9-host

# Download BIND configs
curl $SERVER/named.conf.options -o /etc/bind/named.conf.options

# Start the BIND service on boot
systemctl enable bind9

# Cleanup
rm -rf /root/temp