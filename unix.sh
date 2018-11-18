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


#echo '30 12 * * * "reboot"'>>/etc/crontabs/root.

#echo '00 18 * * * "unix.sh"'>>/etc/crontabs/root
> /etc/crontabs/root

echo '3 * * * * "reset-mcu"'>>/etc/crontabs/root
echo '*/5 * * * * "checkInit"'>>/etc/crontabs/root
echo '* * 1 * * "> init.log"'>>/etc/crontabs/root
echo '00 6 * * * "unix"'>>/etc/crontabs/root
echo '10 9 * * * "unix"'>>/etc/crontabs/root
reboot