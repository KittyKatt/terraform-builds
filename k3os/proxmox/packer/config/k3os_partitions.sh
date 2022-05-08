#!/bin/bash

if [ ! -f /dev/vdb1 ] && [ -f /dev/vdb ]; then
  sudo parted mklabel gtp /dev/vdb
  sudo parted mkpart primary ext4 1049kB 100%
  sudo partprobe /dev/vdb
  echo '/dev/vdb1  /longhorn  ext4  defaults 0 0' | sudo tee -a /etc/fstab
fi