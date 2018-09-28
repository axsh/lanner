#!/bin/bash

export ROOTDIR="$(cd "$(dirname $(readlink -f "$0"))" && pwd -P)"
. "${ROOTDIR}"/vmspec.conf

kvmcmdline=(
  qemu-system-x86_64
  -machine accel=kvm
  -cpu ${cpu_type}
  -m ${mem_size}
  -smp ${cpu_num}
  -vnc ${vnc_addr}:${vnc_port}
  -serial ${serial}
  -serial pty
  -drive file=output-qemu/${vm_name},media=disk,if=virtio,format=${format}
  $(
    for (( i=0 ; i < ${#nics[@]} ; i++ )); do
        nic=(${nics[$i]})
        echo -netdev tap,ifname=${nic[0]#*=},script=,downscript=,id=${vm_name}${i}
        echo -device virtio-net-pci,netdev=${vm_name}${i},mac=${nic[1]#*=},bus=pci.0,addr=0x$((3 + ${i}))
    done
  )
  -pidfile ${vm_name}.pid
  -daemonize
)
sudo "${kvmcmdline[@]}" >kvm.stdout 2>kvm.stderr

