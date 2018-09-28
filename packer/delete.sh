#!/bin/bash

export ROOTDIR="$(cd "$(dirname $(readlink -f "$0"))" && pwd -P)"
. "${ROOTDIR}"/vmspec.conf
. "${ROOTDIR}"/common.source

destroy-vm

