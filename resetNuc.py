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

r = requests.get(url+pdfCode)

print r.text
if "1" in r.text:
	reset = value.put('resetNuc',"1")
	reset = int(reset)
	print reset
	print"ON"
	r = requests.post(url, data={'ID':(pdfCode),'resp':("1")})

else:
	reset = value.put('resetNuc',"0")
	reset = int(reset)
	print reset
	print"OFF"
	r = requests.post(url, data={'ID':(pdfCode),'resp':("0")})
	device = parser.get('device','codePDF')
	url = parser.get('post','url')

	PTO07 = value.get('PTO07')




#r = requests.post(url, data={'device':(device),'A0':(A0),'A1':(A1),'A2':(A2),'A3':(A3),'A4':(A4),'A5':(A5),'A6':(A6),'A7':(A7),'PH0':(PH0),'PH1':(PH1),'PH2':(PH2)})
#print(r.status_code, r.reason)
sys.exit()