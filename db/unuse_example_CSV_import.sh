#!/bin/sh

DATA_FILE="/mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv"
TMP_FILE="/tmp/tmp.$$"


#sqlite3 -separator , development.sqlite3 ".import /mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv addresses"


cat ${DATA_FILE} | grep -v ken_code  > $TMP_FILE

psql -h localhost -p 5431 development -c "truncate table addresses;COPY addresses FROM '${TMP_FILE}' WITH CSV;"
psql -h localhost -p 5431 development -c "update addresses set created_at = current_timestamp;"



rm -rf $TMP_FILE