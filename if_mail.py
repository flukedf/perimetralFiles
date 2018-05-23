
#!/usr/bin/python
# -*- coding: utf-8 -*-
from email import encoders
import smtplib
import email.utils
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import sys
import requests
sys.path.insert(0, '/usr/lib/python2.7/bridge')
from time import sleep

from bridgeclient import BridgeClient as bridgeclient
import ConfigParser
import webbrowser

value = bridgeclient()

parser = ConfigParser.ConfigParser()
parser.read('/root/config.conf')

emailUser = parser.get('email_account','emailUser')
emailPass = parser.get('email_account','emailPass')
locationName = parser.get('device','locationName')
geolocation = parser.get('device','geolocation')
lat = parser.get('device','lat')
lon = parser.get('device','lon')

to = parser.get('email_parameters','to')
cc = parser.get('email_parameters','cc')
bcc = parser.get('email_parameters','bcc')

action_01 = parser.get('email_body','action_01')
action_02 = parser.get('email_body','action_02')
action_03 = parser.get('email_body','action_03')
action_04 = parser.get('email_body','action_04')
action_05 = parser.get('email_body','action_05')

action_03_01 = parser.get('email_body','action_03_01')
action_03_02 = parser.get('email_body','action_03_02')
action_03_03 = parser.get('email_body','action_03_03')

gralMsg01 = parser.get('email_body','gralMsg01')
gralMsg02 = parser.get('email_body','gralMsg02')

subject_01 = parser.get('email_subject','subject_01')
subject_02 = parser.get('email_subject','subject_02')
subject_03 = parser.get('email_subject','subject_03')
subject_04 = parser.get('email_subject','subject_04')
subject_05 = parser.get('email_subject','subject_05')

alert00 = parser.get('email_subject','alert00')
alert01 = parser.get('email_subject','alert01')
alert02 = parser.get('email_subject','alert02')
alert03 = parser.get('email_subject','alert03')
alert04 = parser.get('email_subject','alert04')
alert05 = parser.get('email_subject','alert05')
alert06 = parser.get('email_subject','alert06')



ms = value.get('deviceEmail')
phaseElec = value.get('t')

count = int(ms)
ph = phaseElec

val = count
phase = int(ph)
print (val)
print (phase)

#////////////
  #val = 1
#//////////////////////////////////////////////////////////
location_mx = locationName
geo_location = geolocation+lat+","+lon+",21z"      

#////////////////////////////////////////////////////////
me = emailUser
#//////////////////////////////////////////////////////////////


rcpt = to.split(",")+cc.split(",") + bcc.split(",")
msg = MIMEMultipart()

msg['To'] = to
msg['Cc'] = cc
msg['Bcc'] = bcc

if val == 0:
	print "Funcionamiento Correcto"
	sys.exit()
if val == 1:
   print "Alerta Valla Digital -Acceso a Instalaciones"
   msg['Subject'] = location_mx+subject_01
   action = action_01
   msg_share = gralMsg01+"\n\n"+gralMsg02

if val == 2:
   print "Alerta Valla Digital - Desinstalacion"
   msg['Subject'] = location_mx+subject_02
   action = action_02
   msg_share = gralMsg01+"\n\n"+gralMsg02

if val == 3:

    if phase == 0:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+subject_03+action_03_01
      act03 = action_03+action_03_01
      action = act03
      msg_share = gralMsg01+"\n\n"+gralMsg02
    if phase == 1:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+subject_03+action_03_02
      act03 = action_03+action_03_02
      action = act03
      msg_share = gralMsg01+"\n\n"+gralMsg02

    if phase == 2:
      print "Alerta Valla Digital - Suministro Electrico"
      msg['Subject'] = location_mx+subject_03+action_03_03
      act03 = action_03+action_03_03
      action = act03
      msg_share = gralMsg01+"\n\n"+gralMsg02
if val == 4:
   print "Alerta Valla Digital - Luminosidad"
   msg['Subject'] = location_mx+subject_04
   action = action_04
   msg_share = gralMsg01+"\n\n"+gralMsg02
if val == 5:
   print "Tester Valla Digital"
   msg['Subject'] = location_mx+subject_05
   action = action_05
   msg_share = ""
#msg.attach(MIMEText(body, 'plain'))
html ="""\
<!DOCTYPE html>
<html>
<head>
</head>
<body><font face="verdana" color="#DD3E1C">
<marquee><h1>Alerta Pantalla Digital</h1></marquee>
<h3>{action}</h3>
<img src="http://attach.en.miui.com/forum/201609/27/222447qww5zjtnxk1cyg2w.gif" alt="Siren Alarm" height="42" width="42">
<h3>{location_mx}</h3>
<h3>{msg_share}</h3></FONT>
</font>
</body>
</html>
""".format(location_mx=location_mx,action=action,msg_share=msg_share)
body = "<h3>%s</h3>"%geo_location

textComplete = html+body
#part1 = MIMEText(body, 'plain')
#msg.attach(part1)
part2 = MIMEText(textComplete, 'html')
msg.attach(part2)
server = smtplib.SMTP('smtp.gmail.com', 587)
#server.ehlo()
server.starttls()
#server.ehlo()
server.login(me, emailPass)
text = msg.as_string()
server.sendmail(me, rcpt, text)
server.quit()
