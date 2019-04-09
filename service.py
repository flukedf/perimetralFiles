#!/usr/bin/python
import os
import subprocess
import requests
import sys
#import os
sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

import ConfigParser

value = bridgeclient()

#url = "http://monitorgeovallas.gpovallas.com/wp-json/get_data/screen/"
#pdfCode = "PDF1018"

parser = ConfigParser.ConfigParser()
parser.read('/root/config.conf')


pdfCode = parser.get('device','codePDF')
url = parser.get('service','url')


print pdfCode
print url
print url+pdfCode

status = value.put('statusService',"1")

try:
		r = requests.get(url+pdfCode)



		if "1" in r.text or "404" in r.text:
			status = value.put('statusService',"1")
			status = int(status)
			print status
			print"ON"
			r = requests.post(url, data={'ID':(pdfCode),'resp':("1")})



		else:
			status = value.put('statusService',"0")
			status = int(status)
			print status
			print"OFF"
			r = requests.post(url, data={'ID':(pdfCode),'resp':("0")})

			print r.text
except:
		status = value.put('statusService',"1")


#print(r.status_code, r.reason)












