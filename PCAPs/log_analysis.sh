#!/bin/bash

## Functions
sCleanup () {
    while true; do
        read -p "Would you like to remove the created data sets? [y/n] " answ2
        case $answ2 in
            [Yy]* ) rm $file1; rm $file2; break;;
            [Nn]* ) break;;
            * ) echo "That is not a valid option. Try again.";;
        esac
    done
}

ipAnalysis () {
    file1=IP_dest.txt
    file2=A_records.txt

    echo $file1
    echo $file2

    # Create data sets
    tshark -r $pcap -T ek -e ip.dst | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > $file1
    tshark -r $pcap -T ek -e dns.a | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > $file2

    # Output list of possible C2 over DoH IP addresses
    comm -23 $file1 $file2 | grep -vE "(10.5.5.)[0-9]{1,3}" | grep -v 255.255.255.255

    # Output Wireshark filter of possible C2 over DoH IP addresses
    while true; do
        read -p "Would you like to create a wireshark filter? [y/n] " answ
        case $answ in
            [Yy]* ) comm -23 $file1 $file2 | grep -vE "(10.5.5.)[0-9]{1,3}" | grep -v 255.255.255.255 | sed -e 's/^/ip.addr == /' | sed -e 's/$/ || /' | tr -d "\n" | sed 's/....$//'; break;;
            [Nn]* ) break;;
            * ) echo "That is not a valid option. Try again.";;
        esac
    done

    # Execute cleanup function
    sCleanup
}

sniAnalysis () {
    file1=CH_domains.txt
    file2=DNS_domains.txt

    # Create data sets
    tshark -r $pcap -T ek -e tls.handshake.extensions_server_name | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > $file1
    tshark -r $pcap -T ek -e dns.qry.name | awk -F '[][]' '{print $2}' | tr -d '"' | tr "," "\n" | awk 'NF' | sort -u > $file2

    # Output list of possible C2 over DoH domains
    comm -23 $file1 $file2

    # Execute cleanup function
    sCleanup
}


## Script starts here
# Check if a filename has been given
if [ -z "$1" ]
then
    echo "You must specify a capture file to analyze."
    exit 1
else
    pcap=$1
fi

while true; do
    read -p "Would you like to analyze [I]P addresses or [S]NI? " answ
    case $answ in
        [Ii]* ) ipAnalysis; break;;
        [Ss]* ) sniAnalysis; break;;
        * ) echo "That is not a valid option. Try again.";;
    esac
done
