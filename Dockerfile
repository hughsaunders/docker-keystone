
FROM ubuntu:precise
MAINTAINER Hugh Saunder <hugh@wherenow.org>

RUN sudo add-apt-repository cloud-archive:havana
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install keystone
