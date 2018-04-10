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
opkg install git
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
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/install_requests_iduino.sh

easy_install requests-2.9.1.tar.gz


chmod 777 checkBridge.py
chmod 777 checkBridge
cp checkBridge /etc/init.d/checkBridge
/etc/init.d/checkBridge enable

chmod 777 postData.py
chmod 777 if_mail.py
chmod 777 status.sh
chmod 777 install_requests_iduino.sh
cp status.sh /usr/bin/status
chmod 777 publicIP.py
#wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/requests-2.9.1

svn export https://github.com/flukedf/perimetralFiles/trunk/requests-2.9.1
cd requests-2.9.1
python setup.py build
python setup.py install
cd ..
rm -fr requests-2.9.1


wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/"$var1".hex
chmod 777 "$var1".hex
merge-sketch-with-bootloader.lua /root/"$var1".hex

run-avrdude /root/"$var1".hex

echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo ---------Fin del script.-------------
echo
echo
echo ---------Reiniciando el Sistema-------------
reboot

