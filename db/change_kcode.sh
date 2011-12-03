#!/bin/sh
DATA_PATH=~/work/zip_data

DATA=${DATA_PATH}/ken_all.csv
OUTPUT=${DATA_PATH}/ken_all_utf8.csv

#head -n 10000 $DATA |
cat $DATA |
     nkf -S -w  |cut -f3,7-9 -d"," |
     awk '
      BEGIN {
         FS = ","
         ken = ""
         sikugun = ""
         machi = ""
         count = 0
         ken_count = 0
         sikugun_count = 0
         machi_count = 0
     }
     ken != $2  {
       ken_count ++
       ken = $2
       sikugun_count = 0
       sikugun = ""
       machi_count = 0
       machi = ""
     }
     sikugun != $3  {
       sikugun_count ++
       sikugun = $3
       machi_count = 0
       machi = ""
     }
     machi != $4  {
       machi_count ++
       machi  = $4
     }
     {
     count ++
     printf("%d,%d,%d,%d,%s,%s,%s,%s,,\n",count,
                                          ken_count,sikugun_count,machi_count,
                                          $1,$2,$3,$4)
     }
     '|   tr -d "\""  > $OUTPUT

