#!/bin/bash

# Check if a filename has been given
if [ -z "$1" ]
then
    echo "You must specify a capture file to analyze."
    exit 1
fi

# Create data sets
tshark -r $1 -T ek -e ip.dst | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > IP_dest.txt
tshark -r $1 -T ek -e dns.a | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > A_records.txt

# Output list of possible C2 over DoH IP addresses
comm -23 IP_dest.txt A_records.txt | grep -vE "(10.5.5.)[0-9]{1,3}" | grep -v 255.255.255.255

while true; do
    read -p "Would you like to create a wireshark filter? [y/n] " answ
    case $answ in
        [Yy]* ) comm -23 IP_dest.txt A_records.txt | grep -vE "(10.5.5.)[0-9]{1,3}" | grep -v 255.255.255.255 | sed -e 's/^/ip.addr == /' | sed -e 's/$/ || /' | tr -d "\n" | sed 's/....$//'; break;;
        [Nn]* ) break;;
        * ) echo "That is not a valid option. Try again.";;
    esac
done

while true; do
    read -p "Would you like to remove the created data sets? [y/n] " answ2
    case $answ2 in
        [Yy]* ) rm IP_dest.txt; rm A_records.txt; break;;
        [Nn]* ) break;;
        * ) echo "That is not a valid option. Try again.";;
    esac
done
