# Test to (un)set pin 12 and 13 on the Arduino Yun.
# H.Zimmerman, 09-12-2014.
# henszimmerman@gmail.com
 
import sys
import os


sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

os.system('reset-mcu')

status = 10

sleep(25)

value = bridgeclient()
try:
	status = value.get('statusBridge')
	status = int(status)
	print status
except:
	print("No se incio bridge")
print status
if status == 1:
	print ("Sistema iniciado correctamente")
else:	
	print("El sistema se reiniciara nuevamente")
	print "Bridge did't start"
	sleep(30)
    	os.system('reboot')