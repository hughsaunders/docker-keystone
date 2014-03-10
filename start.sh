#!/bin/bash

WDIR=/docker

#create mysql db
MYSQL_AUTH="-uadmin -p$MYSQL_PASS -h$DB_PORT_3306_TCP_ADDR -P$DB_PORT_3306_TCP_PORT"
while ! mysql $MYSQL_AUTH -e 'status'; do sleep 1; done
mysql $MYSQL_AUTH -e "create database if not exists keystone;"
mysql $MYSQL_AUTH -e "delete from mysql.user where user = 'keystone'"
mysql $MYSQL_AUTH -e "flush privileges"
mysql $MYSQL_AUTH -e "create user 'keystone'@'%' identified by '$MYSQL_PASS'"
mysql $MYSQL_AUTH -e "grant all on keystone.* to 'keystone'@'%';"

#prepare keystone config
sub_config(){
  file="$1"
  marker="$2"
  value="$3"
  sed -i -e 's/%'${marker}'%/'${value}'/g' $file
}

map=(
  "MYSQL_USER,keystone"
  "MYSQL_PASSWORD,secrete"
  "MYSQL_HOST,${DB_PORT_3306_TCP_ADDR}"
  "MYSQL_PORT,${DB_PORT_3306_TCP_PORT}"
  "MYSQL_DB_NAME,keystone"
)

cp $WDIR/keystone.conf.tmpl $WDIR/keystone.conf
for line in ${map[@]}
do
  marker=${line%,*}
  value=${line#*,}
  echo "Marker: $marker, value: $value"
  sub_config $WDIR/keystone.conf $marker $value
done

#Copy config file into place
cp $WDIR/keystone.conf /etc/keystone/keystone.conf

# run keystone
pushd /var/lib/keystone
keystone-all
