#!/usr/bin/env bash
set -e

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2018 picodotdev

while true; do
    read -p "Enter the letter of the client you would like to install:" answ
    case $answ in
        [Aa]* ) CLIENT="client_a/ALIS";;
        [Bb]* ) CLIENT="client_b/ALIS";;
        [Cc]* ) CLIENT="client_c/ALIS";;
        * ) echo "That is not a valid client. Try again.";;
    esac
done

SERVER="https://github.com/HHS181/C2oDoH/blob/master"

rm -f alis.conf
rm -f alis.sh
rm -f alis-asciinema.sh
rm -f alis-reboot.sh

rm -f alis-recovery.conf
rm -f alis-recovery.sh
rm -f alis-recovery-asciinema.sh
rm -f alis-recovery-reboot.sh

curl -O $SERVER/$CLIENT/alis.conf
curl -O $SERVER/$CLIENT/alis.sh
curl -O $SERVER/$CLIENT/alis-asciinema.sh
curl -O $SERVER/$CLIENT/alis-reboot.sh

curl -O $SERVER/$CLIENT/alis-recovery.conf
curl -O $SERVER/$CLIENT/alis-recovery.sh
curl -O $SERVER/$CLIENT/alis-recovery-asciinema.sh
curl -O $SERVER/$CLIENT/alis-recovery-reboot.sh

chmod +x alis.sh
chmod +x alis-asciinema.sh
chmod +x alis-reboot.sh

chmod +x alis-recovery.sh
chmod +x alis-recovery-asciinema.sh
chmod +x alis-recovery-reboot.sh
