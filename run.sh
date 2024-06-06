#!/bin/bash

JENKINS_VERSION=2.403

npm i -g node-sass --sass_binary_site=https://registry.npmmirror.com/mirrors/node-sass/
npm i -g miniprogram-ci --registry=https://registry.npmmirror.com

pip3 install -r /data/app/python/requirements.txt

export JAVA_HOME=/usr/lib/jvm/java-11

/usr/lib/jvm/java-11/bin/java -Duser.timezone=GMT+8 -Dfile.encoding=utf-8 -jar \
-server -Xmx512m -Xms512m -Xss256K \
jenkins-${JENKINS_VERSION}.war --httpPort=8080