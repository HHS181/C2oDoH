#!/bin/bash

# Terminate all script processes on CTRL+C
stopScripts() {
    pkill youtube-dl
    pkill partyloud
    cd -
    rm 10\ Hours*
}

trap 'stopScripts' SIGINT

# Simulate YouTube streaming
youtube-dl -q -r 48K https://www.youtube.com/watch?v=Tpk4q_Zo2ws &

# Simulate web browsing
cd /home/user/PartyLoud
./partyloud.sh
