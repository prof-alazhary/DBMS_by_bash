#!/bin/bash
function getMax()
{
 awk -v  myCol="$1" \
  'BEGIN{
          FS=":"; max=0;pos=0;flag=1
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
          if (NR>2 && $pos>max)
          {
            max=$pos;
          }
        }
    END{
          print max;
       }' $2
}
# colmnName=id;
# max=$(getMax $colmnName ./mydb1/table1);
# echo "max="$max;
function getMini()
{
max=$(getMax $1 $2);
awk -v  myCol="$1" \
  'BEGIN{
      FS=":"; mini='$max';pos=0;flag=1;
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
        if(NR>2 && $pos<mini)
        {
            mini=$pos;
        }
      }
  END{
        print mini;
     }' $2
}
# colmnName=id;
# mini=$(getMini $colmnName ./mydb1/table1);
# echo "mini="$mini;
function getCount()
{
awk 'BEGIN{FS=":"}{}END{print NR-2;}' $1
}
# count=$(getCount ./mydb1/table1);
# echo "count="$count;
function getSum()
{
awk -v myCol="$1" \
      'BEGIN{FS=":";sum=0;pos=0;flag=1}
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
         if(NR>2)
         {
           sum+=$pos
         }
      }
      END{print sum;}' $2
}
# colmnName=id;
# Sum=$(getSum $colmnName ./mydb1/table1);
# echo "Sum="$Sum;
function getAVG() {
  count=$(getCount $2);
  Sum=$(getSum $1 $2);
  awk -v sum="$Sum" 'BEGIN{print sum/'$count';}'
}
# colmnName=id;
# avg=$(getAVG $colmnName ./mydb1/table1);
# echo "avg="$avg;
