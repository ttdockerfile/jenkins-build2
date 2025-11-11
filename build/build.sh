#!/bin/bash

jenkins_version=2.527
golang_version=1.25.1

if [ ! -f apache-maven-3.6.3-bin.zip ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/apache-maven-3.6.3-bin.zip
fi
if [ ! -f node-v24.11.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v24.11.0-linux-x64.tar.xz
fi
if [ ! -f node-v22.14.0-linux-x64.tar.xz ];then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/node-v22.14.0-linux-x64.tar.xz
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

rm -rf go/ maven/
tar -xzf go${golang_version}.linux-amd64.tar.gz
mkdir maven && unzip -d maven/ apache-maven-3.6.3-bin.zip

rm -rf upx*
upx_version=$(curl -s https://api.github.com/repos/upx/upx/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -LO https://github.com/upx/upx/releases/download/${upx_version}/upx-${upx_version:1}-amd64_linux.tar.xz
tar -xJf upx-${upx_version:1}-amd64_linux.tar.xz
mv upx-${upx_version:1}-amd64_linux/upx upx
rm -rf upx-${upx_version:1}-amd64_linux*

if [ "$1"x == "agent"x ];then
    if [ -f agent.jar ];then
        docker build -f Dockerfile-agent --build-arg GOLANG_VERSION=${golang_version} -t buyfakett/jenkins:${jenkins_version}-agent .
    else
        echo "请先准备agent.jar"
        exit 1
    fi
else
    docker build --build-arg JENKINS_VERSION=${jenkins_version} --build-arg GOLANG_VERSION=${golang_version} -t buyfakett/jenkins:${jenkins_version} .
fi
