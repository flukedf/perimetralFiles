#!/bin/bash
cd ~
rm unix.sh
pause 5
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 unix.sh
#reboot
sudo mv checkInit.py checkInit.pyy

rm postData.py

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 postData.sh