# Test to (un)set pin 12 and 13 on the Arduino Yun.
# H.Zimmerman, 09-12-2014.
# henszimmerman@gmail.com
 
import sys
import os


sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

os.system('date')

status = 0
carry = 0

value = bridgeclient()
try:
	for x in range(2):
 		status = value.get('statusBridge')
		status = int(status)
		#print("Valor Status",status)
		carry = carry + status
		sleep(7.5)
		#print ("Valor Carry",carry)	


except:
	print("No se incio MCU","Status",status)


if carry != 0:
	print ("MCU iniciado correctamente")
else:	
	print("MCU se reiniciara nuevamente","MCU didn't start")
	os.system('reset-mcu')
	try:
		sleep(15)
		status = value.get('statusBridge')
		status = int(status)
		#print("Valor Status 2",status)
		carry = carry + status
		#print ("Valor Carry 2",carry)	
		if carry != 0:
			print ("MCU iniciado correctamente")

	except:
		print("No se incio MCU 2","Valor Status 2",status,"Reboot")
		os.system('reboot')

		#sleep(30)
    	