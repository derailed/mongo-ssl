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
  && git clone git://github.com/mongodb/mongo.git

WORKDIR /var/downloads/mongo
RUN git checkout r2.6.5
RUN scons core install --64 --ssl -j8 --no-glibc-check --prefix=/usr/local
RUN rm -rf /var/downloads

RUN mkdir -p /data/db
RUN mkdir -p /var/log/mongo.log

EXPOSE 27017
ENTRYPOINT ["/usr/local/bin/mongod", "--config", "/config/mongo.yaml"]

# Cleanup
RUN apt-get remove -y --purge wget git-core \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
