#!/bin/bash

install_packages(){
  DEBIAN_FRONTEND=noninteractive apt-get -y install $@
}

apt-get update
install_packages python-software-properties
add-apt-repository -y cloud-archive:havana
apt-get update
install_packages keystone python-keystoneclient


