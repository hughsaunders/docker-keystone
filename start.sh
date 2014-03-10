#!/bin/bash

WDIR=/docker

#create mysql db
MYSQL_AUTH="-uadmin -p$MYSQL_PASS -h$DB_PORT_3306_TCP_ADDR -P$DB_PORT_3306_TCP_PORT"
mysql $MYSQL_AUTH -e "create database if not exists keystone;"
mysql $MYSQL_AUTH -e "create user 'keystone'@'%' identified by '$MYSQL_PASS'"
mysql $MYSQL_AUTH -e "grant all on keystone.* to 'keystone'@'%';"

#prepare keystone config
sub_config(){
  file="$1"
  marker="$2"
  value="$3"
  sed $file 's/%'${marker}'%/'${value}'/g' > $file.processed
}

map=(
  "MYSQL_USER,keystone",
  "MYSQL_PASS,secrete",
  "MYSQL_HOST,${DB_PORT_3306_TCP_ADDR}"
  "MYSQL_PORT,${DB_PORT_3306_TCP_PORT}"
  "MYSQL_DB_NAME,keystone"
)

for line in ${map[@]}
do
  marker=${line%,*}
  value=${line#*,}
  sub_config $WDIR/keystone.conf $maker $value
done

#Copy config file into place
cp $WDIR/keystone.conf.processed /etc/keystone/keystone.conf

# run keystone
pushd /var/lib/keystone
keystone-all
