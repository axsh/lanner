#!/bin/bash

export ROOTDIR="$(cd "$(dirname $(readlink -f "$0"))" && pwd -P)"
. "${ROOTDIR}"/vmspec.conf

# When creating custom pci bus.
# Maximum creation limit for pci-bridge is 8.
# addr parameter unsupported PCI slot 0 for standard hotplug controller. Valid slots are between 1 and 31.
#
# -device pci-bridge,id=${pci-bridge-name},bus=pci.0,chassis_nr=1
# -netdev tap,ifname=${interface-name},script=,downscript,id=${interface-id}
# -device virtio-net-pci,netdev=${interface-id},mac=${macaddress},bus=${pci-bridge-name},addr=1
#
# When you want to use a function.
# The maximum number of functions created for one slot number is 8.
#
# -device virtio-net-pci,netdev=${interface-id},mac=${macaddress},bus=${pci-bridge-name},multifunction=onaddr=1.0
#
# 

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
    echo -device pci-bridge,id=pbr1,bus=pci.0,chassis_nr=1
    for (( i=0 ; i < ${#nics[@]} ; i++ )); do
        nic=(${nics[$i]})
        if [ "$i" = "0" ]; then
            echo -netdev user,id=${nic[0]#*=},hostfwd=tcp::${forward_port}-:22,net=10.0.2.0/24
        else
            echo -netdev tap,ifname=${nic[0]#*=},script=,downscript=,id=${nic[0]#*=}
        fi
        echo -device virtio-net-pci,netdev=${nic[0]#*=},mac=${nic[1]#*=},multifunction=on,bus=pbr1,addr=${nic[2]#*=}.${nic[3]#*=}
    done
  )
  -pidfile ${vm_name}.pid
  -daemonize
)
sudo "${kvmcmdline[@]}" >kvm.stdout 2>kvm.stderr

