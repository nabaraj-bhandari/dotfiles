#!/bin/bash

PHONE_IP="192.168.18.247"
#adb connect $PHONE_IP:5555

# Launch scrcpy in view-only mode, smaller resolution
scrcpy --video-bit-rate=4M --max-size=1024 &

