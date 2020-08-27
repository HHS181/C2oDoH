#!/bin/bash

# Start mitmproxy and its web interface
mitmweb --mode regular -p 8080 --web-port 8081 --web-iface 0.0.0.0 &

# Set up simple HTTP server for certificate downloads
python3 -m http.server &
