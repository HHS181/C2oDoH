# C2oDoH

This repository contains the files and scripts used for the execution of the pratical research segment of the Master's Thesis titled "*Detecting C2 over DoH traffic*". The thesis examines the possibilities of detecting Command and Control (C2) channels that utilize DNS over HTTPS (DoH) (or: C2 over DoH (C2oDoH)) instead of regular DNS for communications. 

It contains two types of files:
- **Installation scripts and Configuration files**: These are files that have been used for the setup and configuration of the lab machines used in the thesis. They are divided into subfolders per machine type, and can be used for a repeatable lab setup, so that results can be reproduced in a lab environment that is equivalent to the one where results were obtained.
- **Packet Capture files**: There are the packet captures files (PCAPs) used for distilling the results that are presented in the thesis. They are present in the PCAPs folder, and are further subdivided into folders per Client machine whose traffic is contained in the PCAP. PCAPs containing traffic from all machines is placed under the main folder. One script is alsho hosted under the PCAPs folder which can be used for analysis of PCAPs. More information on this script can be found in Appendix B of the thesis.

The files are placed here for examination by thesis supervisors, as well as use by persons wishing to replicate or present the executed research.

When using these files to replicate results or present, please provide credit and references appropriately. Not all scripts placed in this repository were created by the the thesis author, and are credited as such.


### What is C2oDoH
In short, the principle of C2oDoH relies on the way that DNS can be used for C2 activities:

```seq
C2 client->C2 DNS server: Command requests (DNS queries)
C2 DNS server->C2 client: Commands (DNS answers)
C2 client->C2 DNS server: Command feedback (DNS queries)
C2 DNS server->C2 client: More commands (DNS answers)
```
In this situation, where DNS is used, the channel's communication is in plaintext (readily readable) and makes use of port 53/udp (easily blocked). 

DoH changes this behavior by adding a layer of TLS encryption to the C2 channel:

```seq
C2 client->C2 DNS server: TLS handshake
C2 DNS server->C2 client: TLS handshake
C2 client->C2 DNS server: Command requests (DoH queries)
C2 DNS server->C2 client: Commands (DoH answers)
C2 client->C2 DNS server: Command feedback (DoH queries)
C2 DNS server->C2 client: More commands (DoH answers)
```
Communication now takes place inside TLS encrypted packets and uses port 443/tcp. This presents network defenders with two problems:
1. **Finding malicious C2 channels**: As communication is now encrypted, it cannot be decyphered without implementing solutions such as TLS inspection, decrypting all TLS encrypted network traffic. This potentially introduces new security risks to the network, and presents logistical problems with regards to inspecting all decrypted traffic.
2. **Blocking malicious C2 channels**: Blocking malicious channels is no longer easily achieved as they make use of port 443/tcp, which is also used for legitimate HTTPS traffic to the internet.

The goal of the thesis is to present alternatives for detecting C2oDoH channels without implementing TLS inspection. This is done by examining data and metadata attributes of such channels created in a lab environment.
