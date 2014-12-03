# mongo-ssl

## Overview

 MongoDb+SSL docker container.

## Description

 The good folks at 10gen, in their infinite wisdom, decided to charge $
 for an SSL enabled mongodb instance vs offering it as a package...
 Hence we are left with building our own. This Docker image is a representation
 of building a ubuntu based mongodb+ssl image.

## Usage

### Fetch the container from teh 'hub'
```
docker pull derailed/mongo-ssl
```

### Launch mongo

This container will fire up an instance of mongodb using a mongodb yaml config
file named mongo.yaml. You will need to specify a volume on where to find the
configuration file as well as other dependent files such as .pem file or others.
Assuming you have a directory mongo_config in your current dir containing a yaml
configuration.

```
docker run --rm -p 27017:27017 -v `pwd`/mongo_config:/config derailed/mongo-ssl
```

### Release

* 0.0.2 - Trim down image size - only includes bin/mongod
* 0.0.1 - Initial container drop. MongoDB Version 2.6.5
