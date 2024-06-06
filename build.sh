#!/bin/bash

jenkins_version=2.403

if [ ! -f apache-maven-3.6.3-bin.zip ];then
    wget https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
fi
if [ ! -f node-v16.20.0-linux-x64.tar.xz ];then
    wget https://gitee.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v16.20.2-linux-x64.tar.xz
fi
if [ ! -f node-v14.17.1-linux-x64.tar.xz ];then
    wget https://gitee.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v14.17.1-linux-x64.tar.xz
fi
if [ ! -f node-v12.4.0-linux-x64.tar.xz ];then
    wget https://gitee.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v12.4.0-linux-x64.tar.xz
fi
if [ ! -f node-v10.23.0-linux-x64.tar.xz ];then
    wget https://gitee.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v10.23.0-linux-x64.tar.xz
fi
if [ ! -f Python-3.7.0.tgz ];then
    wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
fi
if [ ! -f jenkins-${jenkins_version}.war ];then
    wget jenkins-${jenkins_version}.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war/${jenkins_version}/jenkins.war
fi

docker build -t buyfakett/jenkins:${jenkins_version} .