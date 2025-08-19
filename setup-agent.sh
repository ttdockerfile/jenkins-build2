#!/bin/bash
echo 'Asia/Shanghai' > /etc/timezone

jenkins_version=2.524
url=""
secret=""
name="test"
workdir="/data/app/jenkins/data/"

docker kill jenkins-agent
docker rm jenkins-agent
docker run -d --name jenkins-agent \
-m 4096m \
--restart=always \
--hostname $(hostname) \
--network=host \
-e LC_ALL="zh_CN.UTF-8" \
-e LANG="zh_CN.UTF-8" \
-e URL="${url}" \
-e SECRET="${secret}" \
-e NAME="${name}" \
-e WORKDIR="${workdir}" \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /etc/hosts:/etc/hosts:ro \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
-v ./maven/data:/data/app/maven/data \
-v ./node/data:/data/app/node/data \
-v ./tools:/data/app/tools \
-v ./golang:/data/app/golang \
-v ./data:/data/app/jenkins/data \
buyfakett/jenkins:${jenkins_version}-agent
