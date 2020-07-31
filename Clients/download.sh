#!/usr/bin/env bash
set -e

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2018 picodotdev

# These scripts have been adapted from the originals for use in this project.
# The original scripts are hosted at https://github.com/picodotdev/alis. 

while true; do
    read -p "Enter the letter of the client you would like to install: " answ
    case $answ in
        [Aa]* ) CLIENT="client_a/ALIS"; break;;
        [Bb]* ) CLIENT="client_b/ALIS"; break;;
        [Cc]* ) CLIENT="client_c/ALIS"; break;;
        * ) echo "That is not a valid client. Try again.";;
    esac
done

SERVER="https://raw.githubusercontent.com/HHS181/C2oDoH/master/Clients"

rm -f alis.conf
rm -f alis.sh

curl -O $SERVER/$CLIENT/alis.conf
curl -O $SERVER/$CLIENT/alis.sh

chmod +x alis.sh
