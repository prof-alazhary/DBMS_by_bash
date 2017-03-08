#!/bin/bash

function getMaxID()
{
  #awk 'BEGIN{FS=":"; max=0 ;i=0} {if ($3>max) max=$3; arr[i]=$3; i++} END{ print max; for(x = 1; x<=NR; x++)print arr[x]}' /etc/passwd
awk 'BEGIN{FS=":"; max=0} {if ($1>max) max=$1;} END{ print max;}' $1

}
# max=$(getMaxID /etc/passwd);
# echo $max;
insertData() {
   awk 'BEGIN{FS=":"; max=0} {if ($1>max) max=$1} END{id=$max+1; print ""id":'$1'" >>"'$2'"}' $2
}
# read -p "Enter your data ti insert like this name:age "
# echo $REPLY
# insertData $REPLY ./mydb1/table1
