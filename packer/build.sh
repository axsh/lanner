#!/bin/bash

set -e

if ! type packer; then
  echo "packer command not found. Please install from https://packer.io/" >&2
  exit 1
fi

box_url="http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.Libvirt.box"
box_tmp="${2:-boxtemp/7}"

# ignore duplicating dir
mkdir -p $box_tmp  || :

(
  cd $box_tmp
  [ -f './t.box' ] || {
      curl --fail -L -o "t.box" "${box_url}"
  }
  tar -xzf t.box

  [ -f "vagrant.key" ] || {
    curl --fail -o vagrant.key -L "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant"
  }
)

# Tweak for skip errors from pre-checking of "file" provisioner.
mkdir -p packer_cache
(
  cd $(git rev-parse --show-toplevel)
  git archive --format=tar --prefix=lanner/ --output=packer/packer_cache/tree.tar HEAD
)

packer build -force centos7.json
