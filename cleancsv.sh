#!/bin/bash

rm hosts.csv

while read line
do
  #echo "Record is: $line"
  IFS=',' read -r -a elemente <<< "$line"
  # ${elemente[0]} Domäne
  # ${elemente[1]} Domäne Pfad
  # ${elemente[2]} Mac
  # ${elemente[3]} NodeID
  # ${elemente[4]} Standort
  # ${elemente[5]} IPv6 Adresse
  # echo "${elemente[1]}";
  # echo "${elemente[3]}";
  # echo "${elemente[5]}";

  # [[ -z "$var" ]] && continue

  if [ -z "${elemente[1]}" ] || [ -z "${elemente[3]}" ] || [ -z "${elemente[5]}" ]; then
    continue
  fi
  if [[ "${elemente[1]}" =~ "_" ]]; then
    pfad=${elemente[1]}
  else
    pfad=$(echo ${elemente[1]}| sed "s/[0-9]\{2\}/&_/")
  fi
  echo "$pfad,${elemente[3]},${elemente[5]}" | tee -a hosts.csv
done < <(tail -n +2 hostsraw.csv)
