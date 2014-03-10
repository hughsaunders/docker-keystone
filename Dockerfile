
FROM ubuntu:precise
MAINTAINER Hugh Saunder <hugh@wherenow.org>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN sudo add-apt-repository cloud-archive:havana && apt-get upate && DEBIAN_FRONTEND=noninteractive apt-get install keystone
