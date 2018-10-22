# Test to (un)set pin 12 and 13 on the Arduino Yun.
# H.Zimmerman, 09-12-2014.
# henszimmerman@gmail.com
 
import sys
import os


sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

status = 0
carry = 0

value = bridgeclient()
try:
	for x in range(2):
 		status = value.get('statusBridge')
		status = int(status)
		print("Valor Status")
		print status
		carry = carry + status
		sleep(7.5)
		print ("Valor Carry")	
		print carry


except:
	print("No se incio MCU")
	print ("Valor Status")
	print status






if carry != 0:
	print ("MCU iniciado correctamente")
else:	
	print("MCU se reiniciara nuevamente")
	print ("MCU didn't start")
	os.system('reset-mcu')
	try:
		sleep(15)
		status = value.get('statusBridge')
		status = int(status)
		print("Valor Status 2")
		print status
		carry = carry + status
		print ("Valor Carry 2")	
		print carry
		if carry != 0:
			print ("MCU iniciado correctamente")

	except:
		print("No se incio MCU 2")
		print ("Valor Status 2")
		print status
		print ("Reboot")
		os.system('reboot')

		#sleep(30)
    	