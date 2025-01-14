FROM debian:12.9
USER root

ADD requirements.txt /data/app/python/requirements.txt

RUN echo "deb http://ftp.de.debian.org/debian sid main " >> /etc/apt/sources.list && apt-get update -y

# svn中文乱码
ENV LANG=zh_CN.UTF-8
RUN apt-get install -y locales && \
sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen && \
locale-gen zh_CN.UTF-8 && \
update-locale LANG=zh_CN.UTF-8

# 基础软件安装
RUN apt-get install -y zip unzip git curl subversion openjdk-8-jdk openjdk-11-jdk openjdk-21-jdk python3 python3-pip
# 设置 svn
RUN svn --version && \
sed -i 's/# store-passwords = no/store-passwords = yes/g' /root/.subversion/servers && \
sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /root/.subversion/servers && \
echo "[auth]\nstore-passwords = no\n[helpers]\n[tunnels]\n[miscellany]\n[auto-props]" > /root/.subversion/config

# 设置 java 环境
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"
RUN ln -s /usr/lib/jvm/java-8-openjdk-amd64/ /usr/lib/jvm/java
# 配置 maven
WORKDIR /data/app/maven/
ADD apache-maven-3.6.3-bin.zip /data/app/maven/
RUN unzip -d /data/app/maven/ apache-maven-3.6.3-bin.zip && ln -s /data/app/maven/apache-maven-3.6.3/ /data/app/maven/maven && chmod 755 /data/app/maven/maven/bin/mvn
ADD settings.xml /data/app/maven/apache-maven-3.6.3/conf/settings.xml
ENV PATH=/data/app/maven/apache-maven-3.6.3/bin:$PATH

# 安装 docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
chmod a+r /etc/apt/keyrings/docker.asc && \
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
bullseye stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 配置 node
WORKDIR /data/app/node/
ADD node-v10.24.1-linux-x64.tar.xz /data/app/node/
ADD node-v14.17.1-linux-x64.tar.xz /data/app/node/
ADD node-v16.20.0-linux-x64.tar.xz /data/app/node/
ADD node-v17.5.0-linux-x64.tar.xz /data/app/node/
ADD node-v18.20.4-linux-x64.tar.xz /data/app/node/
ADD node-v20.17.0-linux-x64.tar.xz /data/app/node/
RUN ln -s /data/app/node/node-v14.17.1-linux-x64/ /data/app/node/node
ENV NODE_PATH=/data/app/node/data/node_global/node_modules
ENV PATH=/data/app/node/node/bin:$PATH
ENV PATH=/data/app/node/data/node_global/bin:$PATH
RUN mkdir -p /data/app/node/data/node_global && \
mkdir -p /data/app/node/data/node_cache && \
npm config set prefix "/data/app/node/data/v14.17.1/node_global" && \
npm config set cache "/data/app/node/data/v14.17.1/node_cache" && \
npm config set registry https://registry.npmmirror.com

# 设置默认python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# 安装 golang
WORKDIR /data/app/golang/
ARG GOLANG_VERSION
COPY go${GOLANG_VERSION}.linux-amd64.tar.gz .
RUN tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# 配置 jenkins
ARG JENKINS_VERSION
WORKDIR /data/app/jenkins/
COPY jenkins-${JENKINS_VERSION}.war /data/app/jenkins/
ENV JENKINS_HOME /data/app/jenkins/data/
ENV JENKINS_SLAVE_AGENT_PORT 50000
COPY run.sh .
RUN chmod 755 run.sh
CMD ./run.sh