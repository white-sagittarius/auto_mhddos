#!/bin/bash

# Install git, python3, pip if doesn't installed already
apt update -y
if [ ! -f /usr/bin/git ]; then
   sudo apt install git -y
fi
if [ ! -f /usr/bin/python3 ]; then
   sudo apt install python3 -y
fi
if [ ! -f /usr/bin/pip ]; then
   apt install python3-pip  -y
fi
if [ ! -f /usr/bin/wget ]; then
   apt install wget  -y
fi
if [ ! -f /usr/bin/curl ]; then
   apt install curl  -y
fi
pip install --upgrade pip > /dev/null #No output. Resolved some problems with pip on debian

#Install latest version of mhddos_proxy and MHDDoS
cd ~
rm -rf mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
cd mhddos_proxy
rm proxies_config.json
wget https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json
git clone https://github.com/MHProDev/MHDDoS.git
python3 -m pip install -r MHDDoS/requirements.txt
