#!/bin/bash

jenkins_version=2.474
golang_version=1.22.5

if [ ! -f apache-maven-3.6.3-bin.zip ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/apache-maven-3.6.3-bin.zip
fi
if [ ! -f node-v20.17.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v20.17.0-linux-x64.tar.xz
fi
if [ ! -f node-v18.20.4-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v18.20.4-linux-x64.tar.xz
fi
if [ ! -f node-v17.5.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v17.5.0-linux-x64.tar.xz
fi
if [ ! -f node-v16.20.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v16.20.0-linux-x64.tar.xz
fi
if [ ! -f node-v14.17.1-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v14.17.1-linux-x64.tar.xz
fi
if [ ! -f node-v10.24.1-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v10.24.1-linux-x64.tar.xz
fi
if [ ! -f go${golang_version}.linux-amd64.tar.gz ];then
    wget https://go.dev/dl/go${golang_version}.linux-amd64.tar.gz
fi
if [ ! -f jenkins-${jenkins_version}.war ];then
    # wget jenkins-${jenkins_version}.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war/${jenkins_version}/jenkins.war
    # wget -O jenkins-${jenkins_version}.war https://get.jenkins.io/war-stable/${jenkins_version}/jenkins.war
    wget -O jenkins-${jenkins_version}.war https://get.jenkins.io/war/${jenkins_version}/jenkins.war
fi

docker build --build-arg JENKINS_VERSION=${jenkins_version} --build-arg --build-arg GOLANG_VERSION=${golang_version} -t buyfakett/jenkins:${jenkins_version} .