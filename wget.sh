#!/bin/bash
#Ejemplo #2: Script que muestra como asignar valores a variables en forma interactiva por el
#            usuario, uso de la funcion read.
#Author: Gonzalo Silverio  -> gonzasilve@gmail.com
#Archivo: script2.sh
#pedir el dato al usuario
echo 'Introduzca Version de Firmware:'
#leer el dato del teclado y guardarlo en la variable de usuario var1
echo "Versiones Disponibles"
echo "screen.hex"
echo "PerimetralScreen.hex"
echo "V230218.hex"
read var1
#Mostrar el valor de la variable de usuario
echo $var1




wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/"$var".hex
chmod 777 "$var".hex
merge-sketch-with-bootloader.lua /root/"$var".hex

run-avrdude /root/"$var".hex

echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo ---------Fin del script.-------------