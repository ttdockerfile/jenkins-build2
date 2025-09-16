FROM debian:13.1
USER root

# 接收架构和 Golang 版本参数
ARG GOLANG_VERSION
ENV GOLANG_VERSION=$GOLANG_VERSION

# 配置 node（动态路径）
WORKDIR /data/app/node/
ADD node-v10.24.1-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v14.17.1-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v16.20.0-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v17.5.0-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v18.20.4-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v20.17.0-linux-${TARGETARCH}.tar.xz /data/app/node/
ADD node-v22.14.0-linux-${TARGETARCH}.tar.xz /data/app/node/
RUN ln -s /data/app/node/node-v14.17.1-linux-${TARGETARCH}/ /data/app/node/node
ENV NODE_PATH=/data/app/node/data/node_global/node_modules
ENV PATH=/data/app/node/node/bin:$PATH
ENV PATH=/data/app/node/data/node_global/bin:$PATH
RUN mkdir -p /data/app/node/data/node_global && \
mkdir -p /data/app/node/data/node_cache && \
npm config set prefix "/data/app/node/data/v14.17.1/node_global" && \
npm config set cache "/data/app/node/data/v14.17.1/node_cache" && \
npm config set registry https://registry.npmmirror.com

# 安装 golang（动态版本和架构）
WORKDIR /data/app/golang/
COPY go${GOLANG_VERSION}.linux-${ARCH}.tar.gz /usr/local/go.tar.gz
RUN tar -xf /usr/local/go.tar.gz -C /usr/local --strip-components=1 && \
    rm /usr/local/go.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
RUN go env -w GOCACHE=/data/app/golang/.cache/go-build && \
go env -w GOPATH=/data/app/golang/go

# upx（动态架构）
# 修改为：直接使用重命名后的文件（无需版本号）
COPY upx-${UPX_ARCH}.tar.xz /tmp/upx.tar.xz
RUN tar -xJf /tmp/upx.tar.xz -C /usr/local/bin --strip-components=1 && \
    rm /tmp/upx.tar.xz
ENV PATH="/usr/local/bin:$PATH"

# svn中文乱码（不变）
ENV LANG=zh_CN.UTF-8
RUN echo "deb http://ftp.de.debian.org/debian sid main " >> /etc/apt/sources.list && \
apt-get update -y && \
apt-get install -y locales && \
sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen && \
locale-gen zh_CN.UTF-8 && \
update-locale LANG=zh_CN.UTF-8 && \
apt-get install -y zip unzip git curl subversion openjdk-8-jdk openjdk-11-jdk openjdk-21-jdk python3 python3-pip screen net-tools telnet vim wget eza && \
echo "alias ll='eza -al --color=always'" >> /root/.bashrc && \
install -m 0755 -d /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
chmod a+r /etc/apt/keyrings/docker.asc && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian trixie stable" \
    > /etc/apt/sources.list.d/docker.list && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
apt-get upgrade -y && \
rm -rf \
/tmp/* \
/usr/share/doc/* \
/var/cache/* \
/var/lib/apt/lists/* \
/var/tmp/* \
/var/log/* && \
svn --version && \
sed -i 's/# store-passwords = no/store-passwords = yes/g' /root/.subversion/servers && \
sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /root/.subversion/servers && \
echo "[auth]\nstore-passwords = no\n[helpers]\n[tunnels]\n[miscellany]\n[auto-props]" > /root/.subversion/config

# 设置 java 环境（动态架构）
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-${TARGETARCH}
ENV PATH="$JAVA_HOME/bin:$PATH"
RUN ln -s /usr/lib/jvm/java-8-openjdk-${TARGETARCH}/ /usr/lib/jvm/java

# 配置 maven
COPY maven /data/app/maven
RUN ln -s /data/app/maven/apache-maven-3.6.3/ /data/app/maven/maven && chmod 755 /data/app/maven/maven/bin/mvn
ADD settings.xml /data/app/maven/apache-maven-3.6.3/conf/settings.xml
ENV PATH=/data/app/maven/apache-maven-3.6.3/bin:$PATH

# 设置默认python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# 配置 jenkins
ARG JENKINS_VERSION
WORKDIR /data/app/jenkins/
COPY jenkins-${JENKINS_VERSION}.war /data/app/jenkins/
ENV JENKINS_HOME=/data/app/jenkins/data/
COPY run.sh .
RUN chmod 755 run.sh
CMD ["./run.sh"]