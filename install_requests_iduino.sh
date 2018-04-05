#!/bin/bash
opkg update
opkg install wget
opkg install subversion-client
svn export https://github.com/flukedf/perimetralFiles/trunk/requests-2.9.1

cd requests-2.9.1
python setup.py build
python setup.py install
cd ..
#rm -fr requests-2.9.1