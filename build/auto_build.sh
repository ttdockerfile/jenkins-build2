#!/bin/bash

# 仅接收两个参数：Jenkins 版本、架构（默认 amd64）
arch=${1:-amd64}
jenkins_version=$2
GOLANG_VERSION=￥3

# 下载 Maven（不变）
if [ ! -f apache-maven-3.6.3-bin.zip ]; then
    wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/apache-maven-3.6.3-bin.zip
fi

# 下载多版本 Node.js（动态架构）
NODE_VERSIONS=("10.24.1" "14.17.1" "16.20.0" "17.5.0" "18.20.4" "20.17.0" "22.14.0")
for version in "${NODE_VERSIONS[@]}"; do
    NODE_FILE="node-v${version}-linux-${arch}.tar.xz"
    if [ ! -f "$NODE_FILE" ]; then
        wget https://github.com/buyfakett/centos7_initialization/releases/download/v1.2.3/"$NODE_FILE"
    fi
done

# 下载 Golang（动态版本和架构）
GOLANG_FILE="go${GOLANG_VERSION}.linux-${arch}.tar.gz"
if [ ! -f "$GOLANG_FILE" ]; then
    wget https://go.dev/dl/"$GOLANG_FILE"
fi

# 下载 Jenkins（不变）
if [ ! -f "jenkins-${jenkins_version}.war" ]; then
    wget -O "jenkins-${jenkins_version}.war" "https://get.jenkins.io/war/${jenkins_version}/jenkins.war"
fi

# 下载 UPX（动态架构）
UPX_VERSION=$(curl -s https://api.github.com/repos/upx/upx/releases/latest | grep tag_name | cut -d '"' -f 4)
UPX_FILE="upx-${UPX_VERSION:1}-${arch}_linux.tar.xz"
if [ ! -f "$UPX_FILE" ]; then
    curl -LO "https://github.com/upx/upx/releases/download/${UPX_VERSION}/${UPX_FILE}"
fi

# 清理并解压（不变）
rm -rf go/ maven/
tar -xzf go${GOLANG_VERSION}.linux-${arch}.tar.gz
mkdir maven && unzip -d maven/ apache-maven-3.6.3-bin.zip

rm -rf upx*
tar -xJf "$UPX_FILE"
mv upx-"${UPX_VERSION:1}"-"${arch}"_linux/upx upx
rm -rf upx-"${UPX_VERSION:1}"-"${arch}"_linux*