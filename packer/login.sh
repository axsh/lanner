#!/bin/bash

export ROOTDIR="$(cd "$(dirname $(readlink -f "$0"))" && pwd -P)"
. "${ROOTDIR}"/vmspec.conf

telnet_host="${serial%%,*}"
telnet_host=${telnet_host#*:}
telnet "${telnet_host%:*}" "${telnet_host#*:}"
