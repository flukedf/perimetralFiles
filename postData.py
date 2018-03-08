import sys
import requests
sys.path.insert(0, '/usr/lib/python2.7/bridge/')
from bridgeclient import BridgeClient as bridgeclient
value = bridgeclient()
#value.put("D12","Test")

#device = value.get('device')

#/////////////////////////////////////////////////////////////////////
device = "PDFtester"
#url = "http://monitorgeovallas.gpovallas.com/wp-json/int_sens/accesos"
url = "http://monitorgeovallaspruebas.gpovallas.com/wp-json/int_sens/accesos"
#////////////////////////////////////////////////////////////////////

A0 = value.get('A0')
A1 = value.get('A1')
A2 = value.get('A2')
A3 = value.get('A3')
A4 = value.get('A4')
A5 = value.get('A5')
A6 = value.get('A6')
A7 = value.get('A7')
PH0 = value.get('PH0')
PH1 = value.get('PH1')
PH2 = value.get('PH2')



r = requests.post(url, data={'device':(device),'A0':(A0),'A1':(A1),'A2':(A2),'A3':(A3),'A4':(A4),'A5':(A5),'A6':(A6),'A7':(A7),'PH0':(PH0),'PH1':(PH1),'PH2':(PH2)})
print(r.status_code, r.reason)
sys.exit()

#"http://70.35.207.145/ubicacion_vallas_pruebas/wp-json/int_sens/accesos"
#pruebas github