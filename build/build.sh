#!/bin/bash

jenkins_version=2.452.1
python3_version=3.12.3

if [ ! -f apache-maven-3.6.3-bin.zip ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/apache-maven-3.6.3-bin.zip
fi
if [ ! -f jdk-21.0.2_linux-x64_bin.rpm ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/jdk-21.0.2_linux-x64_bin.rpm
fi
if [ ! -f node-v16.20.2-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v16.20.2-linux-x64.tar.xz
fi
if [ ! -f node-v14.17.1-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v14.17.1-linux-x64.tar.xz
fi
if [ ! -f node-v12.4.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v12.4.0-linux-x64.tar.xz
fi
if [ ! -f node-v10.23.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v10.23.0-linux-x64.tar.xz
fi
if [ ! -f Python-${python3_version}.tgz ];then
    wget https://www.python.org/ftp/python/${python3_version}/Python-${python3_version}.tgz
fi
if [ ! -f jenkins-${jenkins_version}.war ];then
    # wget jenkins-${jenkins_version}.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war/${jenkins_version}/jenkins.war
    wget -O jenkins-${jenkins_version}.war https://get.jenkins.io/war-stable/${jenkins_version}/jenkins.war
fi

docker build -t buyfakett/jenkins:${jenkins_version} .
