#!/bin/bash
function selectColumn()
{
  awk -v myCol="$1" \
   'BEGIN{
            FS=":"; i=1;pos=0;flag=1
          }
          {
              if(flag==1)
              {
                for(x=1; x<=NF; x++)
                {
                  if($x==myCol)
                  {
                    pos=x;
                    flag=0;
                  }
                }
              }
              if(NR>1)
              {
                  arr[i]=$pos; i++;
              }

          }
      END{
            for(x = 1; x<=i; x++)
                print arr[x]
          }' $2
}
# read -p "chose your table : "
# table=$REPLY;
# read -p "enter your column to select : "
# colmnName=$REPLY;
# selectColumn $colmnName $PWD/$table
