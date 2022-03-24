#!/bin/bash

file="${1:-auto_mhddos_no_proxy}"

for (( i=1; i<=5; i++ ))
do
  cp auto_mhddos_no_proxy.ipynb auto_mhddos_no_proxy_$i.ipynb
done
