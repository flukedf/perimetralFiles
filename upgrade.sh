#!/bin/bash
#Ejemplo #2: Script que muestra como asignar valores a variables en forma interactiva por el
#            usuario, uso de la funcion read.
#Author: Gonzalo Silverio  -> gonzasilve@gmail.com
#Archivo: script2.sh
#pedir el dato al usuario
echo '----------------------Introduzca Version de Firmware:-----------------------------'
#leer el dato del teclado y guardarlo en la variable de usuario var1
echo "----------------------Versiones Disponibles----------------------"
echo ------------------------------------
echo "screen"
echo "PerimetralScreen"
echo "V230218"
echo "V180301"
echo "V180306"
echo "V180309"
echo "V180427"
echo "V180518"
echo "V180522"
echo ------------------------------------
echo
echo
echo
echo
read var1
#Mostrar el valor de la variable de usuario
echo Version Seleccionada:
echo
echo $var1
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
#opkg install subversion-client


#svn export https://github.com/flukedf/perimetralFiles/trunk/requests-2.9.1
#sleep 2
#rm ~/.subversion/auth/svn.ssl.server/*
#sleep 2
#cd requests-2.9.1
#sleep 2
#python setup.py build
#sleep 2
#python setup.py install
#sleep 2
#cd ..
#sleep 2
#rm -fr requests-2.9.1
#sleep 2
#ls

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/requests-2.9.1.tar.gz
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/postData.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/if_mail.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/status.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/publicIP.py
#wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/install_requests_iduino.sh
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/"$var1".hex

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/YunSerialTerminal.hex
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/service.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/bridgePrint.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/config.conf

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
#chmod 777 install_requests_iduino.sh
cp status.sh /usr/bin/status
chmod 777 publicIP.py
chmod 777 service.py
chmod 777 "$var1".hex
#wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/requests-2.9.1

###########################
echo '----------------------Introduzca Clave de Ubicación-----------------------------'
read ubicacion
echo $ubicacion
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

echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo ---------Fin del script.-------------
echo
echo
echo ---------Reiniciando el Sistema-------------
reboot


