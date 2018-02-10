from json import load
from urllib2 import urlopen
my_ip = load(urlopen('https://api.ipify.org/?format=json'))['ip']
printf my_ip

