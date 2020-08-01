#!/bin/bash

export http_proxy=http://10.5.5.254:8080
export https_proxy=$http_proxy

echo "HTTPS traffic is now redirected to a TLS Proxy"
