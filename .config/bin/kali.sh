#!/bin/bash

VM_NAME="remote-viewer"
TAG="5"

# Check if VM is already running
if pgrep -x "$VM_NAME" > /dev/null; then
    pkill -x "$VM_NAME"
    exit 0
fi

# Create shared folder if missing
mkdir -p "$HOME/shared/kali"

# Launch VM
qemu-system-x86_64 \
  -name "kali" \
  -enable-kvm \
  -m 2048 \
  -smp 4 \
  -cpu host \
  -drive file="$HOME/VMs/Kali/kali-linux-2025.2-qemu-amd64.qcow2",format=qcow2 \
  -device virtio-vga-gl \
  -display gtk,gl=on,show-menubar=off \
  -virtfs local,path=$HOME/shared/kali,mount_tag=hostshare,security_model=passthrough,id=hostshare \
  &

# Wait for window to appear, then switch tag
sleep 1
xdotool key super+5

