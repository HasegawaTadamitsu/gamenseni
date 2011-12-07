#!/bin/sh
DATA_PATH=~/work/zip_data

DATA=${DATA_PATH}/ken_all.csv
OUTPUT=./seed/addresses.csv
OUTPUT=/tmp/addresses.csv

#head -n 30000 $DATA |
#cat $DATA |
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
         printf("%s,%s,%s,%s,%s,%s,%s\n",
                   "ken_code","sikugun_code","machi_code",
                   "zip","ken_kanji","sikugun_kanji","machi_kanji")
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
     printf("%02d,%03d,%03d,%s,%s,%s,%s\n",
                                          ken_count,sikugun_count,machi_count,
                                          $1,$2,$3,$4)
     }
     '|   tr -d "\""  > $OUTPUT

