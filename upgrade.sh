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

wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge.py
chmod 777 checkBridge.py
wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/checkBridge
chmod 777 checkBridge
cp checkBridge /etc/init.d/checkBridge
/etc/init.d/checkBridge enable

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

