#!/bin/bash
cd ~
sudo rm unix.sh
sleep 10
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 unix.sh
#reboot
sudo mv checkInit.py checkInit.pyy

rm postData.py

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 postData.py