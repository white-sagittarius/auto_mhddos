#!/bin/bash

sudo apt update -y
sudo apt upgrade -y
# Install git, python3
sudo apt install git gcc libc-dev libffi-dev libssl-dev python3-dev rustc -y
sudo apt install git -y
sudo apt upgrade git -y
sudo apt install wget -y
sudo apt upgrade wget -y
sudo apt install python3 -y
sudo apt upgrade python3 -y
sudo apt install python3-pip -y
sudo apt upgrade python3-pip -y
sudo apt install screen -y
sudo apt upgrade screen -y
sudo apt install curl -y
sudo apt upgrade curl -y



#Install latest version of mhddos_proxy and MHDDoS
cd ~
sudo rm -r mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
cd mhddos_proxy
sudo rm proxies_config.json
sudo wget https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json
sudo git clone https://github.com/MHProDev/MHDDoS.git
sudo python3 -m pip install -r MHDDoS/requirements.txt
cd ~
