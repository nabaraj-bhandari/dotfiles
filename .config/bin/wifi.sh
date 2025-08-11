#!/bin/bash

# Device name
iface="wlo1"

# Check if connected
ssid=$(iw dev "$iface" link | grep 'SSID' | cut -d' ' -f2-)
signal=$(iw dev "$iface" link | grep 'signal' | awk '{print $2}')

if [ -z "$ssid" ] || [ "$ssid" = "--" ]; then
    echo "󰖪 disconnected"  # \uf1ea
    exit 0
fi

# Map dBm signal to icons (lower dBm = weaker)
if [ "$signal" -lt -80 ]; then
    bars="󰤯"  # \uf827 – very weak
elif [ "$signal" -lt -70 ]; then
    bars="󰤟"  # \uf81f – weak
elif [ "$signal" -lt -60 ]; then
    bars="󰤢"  # \uf822 – medium
else
    bars="󰤥"  # \uf825 – strong
fi

echo "$bars $ssid"

