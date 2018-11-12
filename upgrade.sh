#!/bin/bash

#var1=V180522
var1=external
echo '================================================================================'
echo                                 Fimware Version: $var1
echo '================================================================================'
echo
echo
echo
sleep 2
echo '================================================================================'
echo                        Iniciando Instalacion Seguridad Perimetral
echo '================================================================================'
sleep 4
echo
echo
echo
echo
echo
echo
echo
echo
opkg update
opkg install distribute
opkg install python-openssl
opkg install python-bzip2
opkg install sudo
opkg remove temboo
opkg install nano
opkg install watchcat
opkg install luci-app-watchcat
/etc/uci-defaults/50-watchcat

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/requests-2.9.1.tar.gz
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/postData.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/if_mail.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/status.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/publicIP.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/"$var1".hex
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/YunSerialTerminal.hex
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/service.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/bridgePrint.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/config.conf
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkInit.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/factoryReset.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/at_3.1.13-1_ar71xx.ipk
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/tree_1.7.0-1_ar71xx.ipk
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkInit.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/postData.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/unix.sh

opkg install at_3.1.13-1_ar71xx.ipk
opkg install tree_1.7.0-1_ar71xx.ipk

easy_install requests-2.9.1.tar.gz

chmod 777 YunSerialTerminal.hex
chmod 777 checkBridge.py
chmod 777 checkBridge
chmod 777 bridgePrint.py
chmod 777 config.conf
chmod 777 checkInit.py
chmod 777 factoryReset.sh
chmod 777 checkInit.sh
chmod 777 postData.sh
cp checkBridge /etc/init.d/checkBridge
/etc/init.d/checkBridge enable

chmod 777 postData.py
chmod 777 if_mail.py
chmod 777 status.sh
cp status.sh /usr/bin/status
chmod 777 publicIP.py
chmod 777 service.py
chmod 777 "$var1".hex
cp factoryReset.sh /usr/bin/factoryReset
cp checkInit.sh /usr/bin/checkInit
cp postData.sh /usr/bin/postData


echo '3 * * * * "reset-mcu"'>>/etc/crontabs/root
#echo '15 * * * * "python /root/checkBridge.py"'>>/etc/crontabs/root
echo '*/5 * * * * "checkInit"'>>/etc/crontabs/root
echo '* * 1 * * "> init.log"'>>/etc/crontabs/root
echo '00 6 * * * "unix.sh"'>>/etc/crontabs/root
#echo '00 12 * * * "reboot"'>>/etc/crontabs/root
#echo '00 00 * * * "reboot"'>>/etc/crontabs/root
###########################
echo '================================================================================'
echo                              Introduzca Clave de Ubicacion
echo '================================================================================'
read ubicacion
echo $ubicacion
sed -i 's/^codePDF.*/codePDF = '$ubicacion'/g' /root/config.conf
echo '================================================================================'
echo                              Introduzca Latitud
echo '================================================================================'
read lat
echo $lat
sed -i 's/^lat.*/lat = '$lat'/g' /root/config.conf
echo '================================================================================'
echo                              Introduzca Longitud
echo '================================================================================'
read lon
echo $lon
sed -i 's/^lon.*/lon = '$lon'/g' /root/config.conf
echo '================================================================================'
echo                             Introduzca Nombre de Ubicacion
echo '================================================================================'
read locationName
echo $locationName
sed -i 's/^locationName.*/locationName = '$locationName'/g' /root/config.conf
echo 
echo
echo
uci show system
uci set system.@system[0].hostname=$ubicacion
uci set system.vendor.hostname=$ubicacion
uci set system.@system[0].zonename="America/Mexico City"
uci set system.@system[0].timezone=CST6CDT,M4.1.0,M10.5.0
uci set system.vendor.zonename="America/Mexico City"
uci set system.vendor.timezone=CST6CDT,M4.1.0,M10.5.0
uci set system.@watchcat[0]=watchcat
uci set system.@watchcat[0].pinghost=8.8.8.8
uci set system.@watchcat[0].mode=ping
uci set system.@watchcat[0].pingperiod=15m
uci set system.@watchcat[0].period=30m
uci set system.@watchcat[0].forcedelay=600
uci commit system
luci-reload
sudo /etc/init.d/atd start
sudo /etc/init.d/atd enable


##########################
merge-sketch-with-bootloader.lua /root/"$var1".hex

run-avrdude /root/"$var1".hex
rm requests-2.9.1.tar.gz
rm at_3.1.13-1_ar71xx.ipk
rm tree_1.7.0-1_ar71xx.ipk 
rm /root/"$var1".hex
echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo '==========================================='
echo            Finalizando Instalacion
echo '==========================================='
sleep 2
echo
echo
echo
echo
echo
echo
echo '==========================================='
echo            Reiniciando el Sistema
echo '==========================================='
sleep 2
echo
echo
echo
echo
reboot