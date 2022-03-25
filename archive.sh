#!/bin/bash

my_file="${1:-auto_mhddos}"
my_dir="${2:-upload-to-google-drive}"

rm -rf "${my_dir}" && mkdir -p "${my_dir}"

for (( i=1; i<=5; i++ ))
do
  cp "${my_file}.ipynb" "${my_dir}/${i}_${my_file}.ipynb"
done

rm "unzip-and-${my_dir}.zip" 2> /dev/null || true
zip -r "unzip-and-${my_dir}.zip" "${my_dir}"
rm -rf "${my_dir}"
