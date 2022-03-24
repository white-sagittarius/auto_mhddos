#!/bin/bash

file="${1:-auto_mhddos_no_proxy}"

for (( i=1; i<=5; i++ ))
do
  cp "auto_mhddos_no_proxy.ipynb" "${i}_auto_mhddos_no_proxy.ipynb"
done
