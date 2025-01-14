#!/bin/bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

/usr/lib/jvm/java-21-openjdk-amd64/bin/java -Duser.timezone=GMT+8 -Dfile.encoding=utf-8 -jar \
agent.jar -url ${URL} -secret ${SECRET} -name ${NAME} -webSocket -workDir ${WORKDIR}