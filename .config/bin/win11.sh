#!/bin/bash

# TPM state directory
mkdir -p /home/nabaraj/VMs/Windows11/tpmstate
pkill -f swtpm

# Start TPM emulator
swtpm socket \
  --tpm2 \
  --tpmstate dir=/home/nabaraj/VMs/Windows11/tpmstate \
  --ctrl type=unixio,path=/tmp/swtpm-sock \
  --daemon

# Launch QEMU Windows 11 VM
exec qemu-system-x86_64 \
  -name 'win11' \
  -enable-kvm \
  -m 8192 \
  -smp 4 \
  -cpu host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1fff \
  -machine q35,accel=kvm \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.4m.fd \
  -drive if=pflash,format=raw,file=/home/nabaraj/VMs/EFI/OVMF_VARS.fd \
  -drive file=/home/nabaraj/VMs/Windows11/win11.qcow2,format=qcow2 \
  -device virtio-net,netdev=net0 \
  -netdev user,id=net0 \
  -device virtio-vga-gl \
  -display gtk,gl=on,show-menubar=off \
  -audiodev pa,id=snd0,out.frequency=44100,in.frequency=44100 \
  -device ich9-intel-hda \
  -device hda-duplex,audiodev=snd0 \
  -usb -device usb-tablet \
  -chardev socket,id=chrtpm,path=/tmp/swtpm-sock \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  -boot order=c

# Wait for window to appear, then switch tag
sleep 1
xdotool key super+6
