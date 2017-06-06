Lanner Setup
============

Serial (minicom)
----------------

Use _^A O_ to enter "Serial port setup".

Set "Serial Device".

Set "Hardware Flow Control: to no."
Set "Software Flow Control: to no."


BIOS
----

Use *DEL* or *TAB* after the beep to enter the *BIOS*.

Set to boot from the USB drive using *EFI*, unless non-grub boot menu
config files have been changes.


GRUB Changes (automated by scripts)
-----------------------------------

Press F9 to customize boot parameters. Remove 'silent' and 'splash', add:

```
console=tty0 console=ttyS0,115200n8
```

After install, but before edit '/etc/default/grub':

```
GRUB_CMDLINE_LINUX_DEFAULT=""
GRUB_CMDLINE_LINUX="console=tty0 console=ttyS0,115200n8"
```

Update grub.
