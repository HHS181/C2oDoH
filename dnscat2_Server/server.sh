#!/bin/bash

# Start a dnscat2 server
cd dnscat2/server/
sudo ruby ./dnscat2.rb --dns domain=$1 --security=open
