#! /usr/bin/env bash

set -euo pipefail

for n in {1..10}
do
  str=""
  if (( n % 3 == 0 ))
  then
    str="fizz"
  fi
  if [ $((n%5)) == 0 ]
  then
    str="buzz"
  fi
  if [[ ! $str ]]
  then
    str="$n"
  fi
  echo "$str"
done
