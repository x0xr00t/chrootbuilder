#!/bin/bash
# This script can be used to create simple chroot environment
# Written by LinuxCareer.com <http://linuxcareer.com/>
# (c) 2013 LinuxCareer under GNU GPL v3.0+

#!/bin/bash

CHROOT='/var/chroot'
mkdir $CHROOT

for i in $( ldd $* | grep -v dynamic | cut -d " " -f 3 | sed 's/://' | sort | uniq )
  do
    cp --parents $i $CHROOT
  done

# ARCH amd64
if [ -f /lib64/ld-linux-x86-64.so.2 ]; then
   cp --parents /lib64/ld-linux-x86-64.so.2 /$CHROOT
fi

# ARCH i386
if [ -f  /lib/ld-linux.so.2 ]; then
   cp --parents /lib/ld-linux.so.2 /$CHROOT
fi

echo "Chroot jail is ready. To access it execute: chroot $CHROOT"
