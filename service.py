import requests
import sys
#import os
sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

value = bridgeclient()


url = "http://monitorgeovallas.gpovallas.com/wp-json/get_data/screen/"
pdfCode = "PDF1018"

r = requests.get(url+pdfCode)
print r.text
if "1" in r.text:
	status = value.put('statusBridge',"1")
	status = int(status)
	print status
	print"ON"
	r = requests.post(url, data={'ID':(pdfCode),'resp':("1")})

else:
	status = value.put('statusBridge',"0")
	status = int(status)
	print status
	print"OFF"
	r = requests.post(url, data={'ID':(pdfCode),'resp':("0")})



#print(r.status_code, r.reason)









