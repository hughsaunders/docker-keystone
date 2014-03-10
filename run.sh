#!/bin/bash

MYSQL_PASS=secrete
MYSQL_CONTAINER_NAME=db
KEYSTONE_CONTAINER_NAME=keystone

# start mysql container
docker run -d -P -name $MYSQL_CONTAINER_NAME -e MYSQL_PASS="$MYSQL_PASS" tutum/mysql

# start keystone container
docker run -d -P -name $KEYSTONE_CONTAINER_NAME -e MYSQL_PASS="$MYSQL_PASS" -link $MYSQL_CONTAINER_NAME:db hughsaunders/keystone
