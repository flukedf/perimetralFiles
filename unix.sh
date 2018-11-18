#!/bin/bash
cd ~
rm unix.sh
sleep 5
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 unix.sh
#reboot
sudo mv checkInit.py checkInit.pyy

rm postData.py

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/postData.py
chmod 777 postData.py

rm unix.sh.1

echo '30 12 * * * "reboot"'>>/etc/crontabs/root