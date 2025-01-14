#!/bin/bash
echo 'Asia/Shanghai' > /etc/timezone

port=8081
jenkins_version=2.475

docker kill jenkins-${port}
docker rm jenkins-${port}
docker run -d --name jenkins-${port} \
-m 4096m \
-p ${port}:8080 \
--restart=always \
--hostname $(hostname) \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /etc/hosts:/etc/hosts:ro \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
-e LC_ALL="zh_CN.UTF-8" \
-e LANG="zh_CN.UTF-8" \
-v ./maven/data:/data/app/maven/data \
-v ./node/data:/data/app/node/data \
-v ./tools:/data/app/tools \
-v ./run.sh:/data/app/jenkins/run.sh \
-v ./data-${port}:/data/app/jenkins/data \
registry.cn-hangzhou.aliyuncs.com/buyfakett/jenkins:${jenkins_version}

