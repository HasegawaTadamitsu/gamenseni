#!/bin/sh

echo development
sqlite3 -separator , development.sqlite3 ".import /mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv addresses"

echo test
sqlite3 -separator , test.sqlite3 ".import /mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv addresses"
