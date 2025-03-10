#!/bin/bash
echo 'Asia/Shanghai' > /etc/timezone

port=8081
jenkins_version=2.500

docker kill jenkins-${port}
docker rm jenkins-${port}
docker run -d --name jenkins-${port} \
-m 4096m \
--network=host \
--restart=always \
--hostname $(hostname) \
-e LC_ALL="zh_CN.UTF-8" \
-e LANG="zh_CN.UTF-8" \
-e PORT="${port}" \
-e JENKINS_VERSION="${jenkins_version}" \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /etc/hosts:/etc/hosts:ro \
-v /etc/localtime:/etc/localtime:ro \
-v /etc/timezone:/etc/timezone:ro \
-v ./maven/data:/data/app/maven/data \
-v ./node/data:/data/app/node/data \
-v ./tools:/data/app/tools \
-v ./data-${port}:/data/app/jenkins/data \
registry.cn-hangzhou.aliyuncs.com/buyfakett/jenkins:${jenkins_version}