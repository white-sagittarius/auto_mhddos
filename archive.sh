#!/bin/bash

P1=(wall son trucks page tail jar box wave straw wrench thread eye suit rings mine chess grandmother downtown touch question queen toes ants canvas boundary coil jail sea veil shelf table bag yak slope fire mountain loaf part toothpaste health business doctor note amount tray shake smile butter hobbies team mom dinner mind advice mice passenger dogs hydrant hall umbrella flavor lettuce battle cap breath side square cactus cracker lace protest sign science grip front things current brake rub show existence recess curve skirt yoke bikes actor scale oranges impulse milk flock shoe design beef payment collar orange thrill caption juice rod clover pen pig bait industry oven donkey land position committee deer channel wax scissors rifle flight fang title birds friend wealth desk waste rose office vegetable join farm clam zinc humor knife selection car girl sun desire morning property beds powder pancake grape change grandfather coast cellar income egg brother class wash flame shop camera size pocket tub liquid hat feeling lip grain smoke mailbox cup wish peace noise quarter sticks point pickle eyes soap pie idea pin boot mass rainstorm toothbrush man language rice skin soda heat weight competition bath agreement lock bird snail squirrel food ladybug)
P2=(cows bells laugh chance verse servant history wax hammer sail screw tree group tree door fly quill competition sticks jam badge acoustics support plant box art potato lock muscle cream)
P3=(drum lunch guide play yoke substance watch road existence girl camp car locket advice snow sisters steam sign calculator zebra tank paper stretch line iron key glove pie arm cannon)

input_file="main.ipynb"
output_dir="${2:-upload-to-google-drive}"

rm -rf "${output_dir}" && mkdir -p "${output_dir}"

for (( i=1; i<=5; i++ ))
do
  if (( RANDOM % 2 )); then name2_separator="_"; else name2_separator=""; fi
  if (( RANDOM % 2 )); then name2="$name2_separator${P2[RANDOM%30]}"; else name2=""; fi
  if (( RANDOM % 2 )); then name3_separator="_"; else name3_separator=""; fi
  if (( RANDOM % 2 )); then name3="$name3_separator${P3[RANDOM%30]}"; else name3=""; fi
  file_name="${P1[RANDOM%100]}${name2}${name3}.ipynb"
  resulting_file="${output_dir}/${file_name}"
  cp "${input_file}" ${resulting_file}
  sed -i "" 's/looooot/nice/g' ${resulting_file}
done

rm "unzip-and-${output_dir}.zip" 2> /dev/null || true
zip -r "unzip-and-${output_dir}.zip" "${output_dir}"
