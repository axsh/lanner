#!/bin/bash

SRC_FILENAME="${1:?Source filename not provided.}"
DST_FILENAME="${2:?Destination filename not provided.}"

cat "${SRC_FILENAME}" | sed -e '/^[[:space:]]*append / s/ quiet//' -e '/^[[:space:]]*append / s/ splash//' -e '/^[[:space:]]*append / s/$/ console=tty0 console=ttyS0,115200n8/' > "${DST_FILENAME}"
