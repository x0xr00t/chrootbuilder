#!/bin/bash
#
# Author: P.Hoogeveen
# Aka   : x0xr00t
# Build : 12122020
# Name  : Chrootbuild.sh

# Lib installs
apt update && apt install ldd -y 

# Root check 
if [ "$EUID" -ne 0 ]
  then echo "To make this chroot build work Please take root"
  exit
fi

# Add User Group
read -p "Please enter the desired user group: " ugroup
groupadd $ugroup

# Add user to group 
read -p "Please enter the desired user name: " uname
usermod -G $ugroup $uname

# Main code 
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
