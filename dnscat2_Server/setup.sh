#!/bin/bash

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/dnscat2_Server

# Download necessary packages
sudo apt-get update
sudo apt-get install -y git ruby-dev make gcc

# Clone dnscat2 repository
git clone https://github.com/iagox86/dnscat2.git

# Compile the dnscat2 server
cd dnscat2/server/
gem install bundler
bundle install
cd -

# Download the server script
curl $SERVER/server.sh -o /home/admin/server.sh
chmod +x /home/admin/server.sh
chown admin:admin /home/admin/server.sh
