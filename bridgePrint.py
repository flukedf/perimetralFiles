import sys
import os


sys.path.insert(0, '/usr/lib/python2.7/bridge')
 
from time import sleep
 
from bridgeclient import BridgeClient as bridgeclient

status = 0


value = bridgeclient()

status = value.get('statusBridge')
status = int(status)
print status
