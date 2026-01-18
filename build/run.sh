#!/bin/bash

PORT="${PORT:-8080}"

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

/usr/lib/jvm/java-25-openjdk-amd64/bin/java -Duser.timezone=GMT+8 -Dfile.encoding=utf-8 -jar \
jenkins-${JENKINS_VERSION}.war --httpPort=${PORT}