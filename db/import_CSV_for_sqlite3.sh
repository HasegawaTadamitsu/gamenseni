#!/bin/sh

sqlite3 -separator , development.sqlite3 ".import /mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv addresses"
sqlite3 -separator , test.sqlite3 ".import /mnt/home/hasegawa/work/zip_data/ken_all_utf8.csv addresses"
