#!/bin/bash

if which ldd >/dev/null; then
    echo "exists"
else
    echo " ldd does not exist"
    echo " We will be installing it for you :D"
    apt install ldd -y
fi


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
