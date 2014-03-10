
FROM ubuntu:precise
MAINTAINER Hugh Saunder <hugh@wherenow.org>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install python-software-properties
RUN add-apt-repository -y cloud-archive:havana && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install keystone python-keystoneclient
