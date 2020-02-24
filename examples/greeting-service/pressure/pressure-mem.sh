#!/bin/bash

if [ $# -lt 2 ]; then
    echo 'Usage: \$1: pid, \$2 output file'
    exit 1;
fi
rm -I $2
pid=$1
n=1;
while(($n>0));
do   
    ret=`ps_mem -p $pid  | awk -F  '[=java]'  '{print $2;}' | grep -vE "^[[:blank:]]*$"|awk '{print $1}'`
    if [ "$ret" == "" ];
    then
      exit 0
    else
      echo $ret  >> $2
    fi
    n=$((n + 1));
    sleep 1;
done

