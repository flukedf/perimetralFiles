#!/bin/bash
#Ejemplo #2: Script que muestra como asignar valores a variables en forma interactiva por el
#            usuario, uso de la funcion read.
#Author: Gonzalo Silverio  -> gonzasilve@gmail.com
#Archivo: script2.sh
#pedir el dato al usuario
echo 'Introduzca Version de Firmware:\n'
#leer el dato del teclado y guardarlo en la variable de usuario var1
echo "Versiones Disponibles\n"
echo "screen.hex\n"
echo "PerimetralScreen.hex\n"
echo "V230218.hex\n"
read var1
#Mostrar el valor de la variable de usuario
echo $var1




wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/$var
chmod 777 $var
merge-sketch-with-bootloader.lua /root/$var

run-avrdude /root/$var

echo
#Avisar al usuario que se ha terminado de ejecutar el script 
echo ---------Fin del script.-------------