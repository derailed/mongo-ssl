FROM ubuntu
MAINTAINER fernand.galiana@gmail.com

RUN apt-get update && apt-get -y install \
  build-essential \
  git-core \
  scons \
  libssl-dev \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-thread-dev

RUN mkdir -p /var/downloads \
  && cd /var/downloads \
  && git clone git://github.com/mongodb/mongo.git \
  && cd /var/downloads/mongo \
  && git checkout r2.6.5

WORKDIR /var/downloads/mongo
RUN scons core install --64 --ssl -j8 --no-glibc-check --prefix=/usr/local \
 && find /usr/local/bin -type f -not -name 'mongod' -delete \
 && rm -rf /var/downloads

RUN mkdir -p /data/db
RUN mkdir -p /var/log/mongo.log

WORKDIR /
EXPOSE 27017
ENTRYPOINT ["/usr/local/bin/mongod", "--config", "/config/mongo.yaml"]

# Cleanup
RUN apt-get remove -y --purge git-core scons \
    && apt-get autoremove -y --purge \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,lists} /tmp/* /var/tmp/*
