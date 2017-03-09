#!/bin/bash

insertData() {
   awk 'BEGIN{FS=":"; max=0} {if ($1>max) max=$1} END{id=$max+1; print ""id":'$1'" >>"'$2'"}' $2
}
# read -p "Enter your data ti insert like this name:age "
# echo $REPLY
# insertData $REPLY ./mydb1/table1
