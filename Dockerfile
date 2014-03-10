
FROM ubuntu:precise
MAINTAINER Hugh Saunder <hugh@wherenow.org>

ADD build.sh /docker/build.sh
ADD start.sh /docker/start.sh
RUN /docker/build.sh
CMD /docker/start.sh
EXPOSE 35357 5000

