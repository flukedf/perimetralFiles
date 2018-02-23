  #!/bin/bash
 wget --no-check-certificate https://raw.githubusercontent.com/flukedf/perimetralFiles/master/V230218.hex
chmod 777 V230218.hex
merge-sketch-with-bootloader.lua /root/V230218.hex

run-avrdude /root/V230218.hex