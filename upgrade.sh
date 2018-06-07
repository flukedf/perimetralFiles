#!/bin/bash

var1=V180522
echo '==========================================='
echo Version: $var1
echo '==========================================='
echo '==========================================='
echo Iniciando Instalacion Seguridad Perimetral
echo '==========================================='
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
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/at_3.1.13-1_ar71xx.ipk

opkg install at_3.1.13-1_ar71xx.ipk

easy_install requests-2.9.1.tar.gz

chmod 777 YunSerialTerminal.hex
chmod 777 checkBridge.py
chmod 777 checkBridge
chmod 777 bridgePrint.py
cp checkBridge /etc/init.d/checkBridge
/etc/init.d/checkBridge enable

chmod 777 postData.py
chmod 777 if_mail.py
chmod 777 status.sh
cp status.sh /usr/bin/status
chmod 777 publicIP.py
chmod 777 service.py
chmod 777 "$var1".hex

echo '10 * * * * "reset-mcu"'>>/etc/crontabs/root
echo '00 12 * * * "reboot"'>>/etc/crontabs/root
echo '00 00 * * * "reboot"'>>/etc/crontabs/root
###########################
echo '----------------------Introduzca Clave de Ubicación-----------------------------'
read ubicacion
echo $ubicacion
sed -i 's/^codePDF.*/codePDF = '$ubicacion'/g' /root/config.conf
echo '----------------------Introduzca Latitud-----------------------------'
read lat
echo $lat
sed -i 's/^lat.*/lat = '$lat'/g' /root/config.conf
echo '----------------------Introduzca Longitud-----------------------------'
read lon
echo $lon
sed -i 's/^lon.*/lon = '$lon'/g' /root/config.conf
echo '----------------------Introduzca Nombre de la ubicacion-------------------------'
read locationName
echo $locationName
sed -i 's/^lon.*/lon = '$locationName'/g' /root/config.conf
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
uci commit system
luci-reload

##########################
merge-sketch-with-bootloader.lua /root/"$var1".hex

run-avrdude /root/"$var1".hex
rm requests-2.9.1.tar.gz
rm at_3.1.13-1_ar71xx.ipk
rm /root/"$var1".hex
echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo '==========================================='
echo            Finalizando Instalacion
echo '==========================================='
echo
echo
echo
echo
echo
echo
echo '==========================================='
echo            Reiniciando el Sistema
echo '==========================================='
echo
echo
echo
echo
reboot


