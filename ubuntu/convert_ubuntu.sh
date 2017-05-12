#!/bin/bash

SCRIPT_DIR=`dirname ${BASH_SOURCE[0]}`

BASE_PATH="${1:?Root directory for Ubuntu USB not provided.}"

BOOT_FILES="
        syslinux.cfg
        boot/grub/grub.cfg
        isolinux/rqtxt.cfg
        isolinux/txt.cfg
        install/hwe-netboot/ubuntu-installer/amd64/boot-screens/rqtxt.cfg
        install/hwe-netboot/ubuntu-installer/amd64/boot-screens/txt.cfg
        install/netboot/ubuntu-installer/amd64/boot-screens/rqtxt.cfg"

function error_exit () {
    echo "$1" >&2
    exit "${2:-1}"
}

echo "Verifying boot menu files."

for i in ${BOOT_FILES}; do
    [ -f "${BASE_PATH}/${i}" ] || error_exit "Could not find boot menu file '${BASE_PATH}/${i}'."
done

echo "Converting boot menu files."

for i in ${BOOT_FILES}; do
    FILENAME="${BASE_PATH}/${i}"

    echo "... ${FILENAME}"

    mv "${FILENAME}" "${FILENAME}.orig"
    ${SCRIPT_DIR}/prepare_cfg.sh "${FILENAME}.orig" "${FILENAME}"
done

echo "Done."
