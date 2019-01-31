#!/bin/ash
cd ~
mv -i unix.sh unix.shh
sleep 5
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh
chmod 777 unix.sh
cp unix.sh /usr/bin/unix
if [ -f /root/unix.sh ];
then
echo "delete unix.shh"
rm unix.shh
else
echo "No, no existe"
fi



#reboot
#sudo mv checkInit.py checkInit.pyy

#rm postData.py

#wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/postData.py
#chmod 777 postData.py


#echo '30 12 * * * "reboot"'>>/etc/crontabs/root.

#echo '00 18 * * * "unix.sh"'>>/etc/crontabs/root
> /etc/crontabs/root

echo '10 * * * * "reset-mcu"'>>/etc/crontabs/root
echo '15 * * * * "checkInit"'>>/etc/crontabs/root
echo '* * 1 * * "> init.log"'>>/etc/crontabs/root
echo '00 00 * * * "unix"'>>/etc/crontabs/root
echo '00 12 * * * "unix"'>>/etc/crontabs/root

/etc/init.d/cron start
/etc/init.d/cron enable
/etc/init.d/cron reload

#######################################

mv -i service.py service.pyy
sleep 5
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/service.py
chmod 777 service.py
rm service.pyy



#######################################
reboot
