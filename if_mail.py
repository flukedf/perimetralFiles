
#!/usr/bin/python
# YunBridge importieren:
import smtplib
import email.utils
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
import sys
import requests
sys.path.insert(0, '/usr/lib/python2.7/bridge')
from time import sleep
# Ueber value erfolgt der Zugriff auf die Kommunikation:
from bridgeclient import BridgeClient as bridgeclient
value = bridgeclient()
# Endlosschleife:
#  # Wert fuer A0 holen:
ms = value.get('deviceEmail')
phaseElec = value.get('t')
  # und ausgeben:
count = int(ms)
ph = phaseElec
  # und nach einer Pause weiter
val = count
phase = int(ph)
print (val)
print (phase)

#////////////
  #val = 1
#//////////////////////////////////////////////////////////
location_mx = "COV"
geo_location = "google.com.mx/maps/@19.464187,-99.2274472,19z"
      

#////////////////////////////////////////////////////////


#me = "cuentaexperimentalvallas@gmail.com"
me = "seguridad.pantallas@gpovallas.com"
to = "fluke.df@gmail.com"#"gonzalez.luis@gpovallas.com,rojas.luis@gpovallas.com,sanchez.ernesto@gpovallas.com,vazquez.adrian@gpovallas.com,ramirez.marcela@gpovallas.com,castilla.jorge@gpovallas.com,barrera.luis@gpovallas.com,ponce.cesar@gpovallas.com,cunzo.hernan@gpovallas.com,mendoza.barbara@gpovallas.com,coca.ariadne@gpovallas.com,trejo.gerardo@gpovallas.com,vazquez.francisco@gpovallas.com,flores.erick@gpovallas.com"
cc = ""#"salas.gustavo@gpovallas.com,mora.enrique@gpovallas.com,castaneda.jose@gpovallas.com,soporte.pantallas@gpovallas.com"
bcc = "cevallos.gonzalo@gpovallas.com,hernandez.eduardo@gpovallas.com"


#//////////////////////////////////////////////////////////////


rcpt = cc.split(",") + bcc.split(",") + [to]
msg = MIMEMultipart()

msg['To'] = to
msg['Cc'] = cc
msg['Bcc'] = bcc

html = """\
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<h1>Alerta Pantalla Digital</h1>
<p>Tomar Acciones Necesarias</p>
<div>
<img src="http://attach.en.miui.com/forum/201609/27/222447qww5zjtnxk1cyg2w.gif" alt="Siren Alarm" height="42" width="42">
</div>
</body>
</html>
"""


if val == 0:
	print "Funcionamiento Correcto"
	sys.exit()
if val == 1:
   print "Alerta Valla Digital -Acceso a Instalaciones"
   msg['Subject'] = location_mx+ " -Acceso a Instalaciones"
   html
   body = "Acceso a las instalaciones de Pantalla Digital \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."
if val == 2:
   print "Alerta Valla Digital - Desinstalacion"
   msg['Subject'] = location_mx+ " - Desinstalacion"
   html
   body = "Desinstalacion de Valla Digital \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."


if val == 3:

    if phase == 0:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+ " - Problema Suministro Electrico Fase 1"
      html
      body = "Falla en Sistema Electrico \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."
    if phase == 1:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+ " - Problema Suministro Electrico Fase 2"
      html
      body = "Falla en Sistema Electrico \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."
    if phase == 2:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+ " - Problema Suministro Electrico Fase 3"
      html
      body = "Falla en Sistema Electrico \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."


if val == 4:
   print "Alerta Valla Digital - Luminosidad"
   msg['Subject'] = location_mx+ " - Luminosidad"
   html
   body = "Falla de Luminosidad \n\n "+geo_location+" \n\n Tomar acciones inmediatamente \n\n Comunicarse con el encargado del area."
if val == 5:
   print "Tester Valla Digital"
   msg['Subject'] = location_mx+" - Tester Valla Digital"
   html
   body = "Mail de Pruebas Valla Digital \n\n "+geo_location+" \n\n No Tomar acciones \n\n Acceso solo encargado de Area"

#msg.attach(MIMEText(body, 'plain'))

part1 = MIMEText(body, 'plain')
part2 = MIMEText(html, 'html')

msg.attach(part1)
msg.attach(part2)
server = smtplib.SMTP('smtp.gmail.com', 587)
server.ehlo()
server.starttls()
server.ehlo()
#server.login(me, "CHEYENNES18")
server.login(me, "popocatepetl123")
text = msg.as_string()
server.sendmail(me, rcpt, text)
server.quit()
#sleep(10)