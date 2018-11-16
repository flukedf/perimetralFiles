#!/bin/bash
cd ~
rm unix.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 unix.sh
#reboot
mv checkInit.py checkInit.pyy


