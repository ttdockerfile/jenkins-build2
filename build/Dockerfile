FROM centos:7.9.2009
USER root

# svn中文乱码
RUN yum install -y kde-l10n-Chinese glibc-common && \
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
export LANG=zh_CN.UTF-8

# 基础软件安装
RUN yum install -y zip unzip git subversion java-1.8.0-openjdk-devel.x86_64 java-11-openjdk-devel.x86_64
# 设置 svn
RUN svn --version && \
sed -i 's/# store-passwords = no/store-passwords = yes/g' /root/.subversion/servers && \
sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /root/.subversion/servers && \
echo -e "[auth]\nstore-passwords = no\n[helpers]\n[tunnels]\n[miscellany]\n[auto-props]\n" > ~/.subversion/config

# 设置 java 环境
ENV JAVA_HOME=/usr/lib/jvm/java
# 配置 maven
WORKDIR /data/app/maven/
ADD apache-maven-3.6.3-bin.zip /data/app/maven/
RUN unzip -d /data/app/maven/ apache-maven-3.6.3-bin.zip && ln -s /data/app/maven/apache-maven-3.6.3/ /data/app/maven/maven && chmod 755 /data/app/maven/maven/bin/mvn
ADD settings.xml /data/app/maven/apache-maven-3.6.3/conf/settings.xml
ENV PATH=/data/app/maven/apache-maven-3.6.3/bin:$PATH

# 安装 python3
WORKDIR /data/app/python/
RUN yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc gcc-c++ make libffi-devel
ADD Python-3.7.0.tgz /data/app/python/
RUN cd Python-3.7.0 && ./configure prefix=/usr/local/python3 && make -j 16 && make install && \
rm -rf /usr/bin/python && \
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python && \
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3.7 && \
rm -rf /usr/bin/pip && rm -rf /usr/bin/pip3 && \
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip && \
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3 && \
python -V && \
sed -i 's$/usr/bin/python$/usr/bin/python2$g' /usr/bin/yum && \
sed -i 's$/usr/bin/python$/usr/bin/python2$g' /usr/libexec/urlgrabber-ext-down
ADD requirements.txt /data/app/python/requirements.txt

# 配置 node
WORKDIR /data/app/node/
ADD node-v16.20.0-linux-x64.tar.xz /data/app/node/
ADD node-v14.17.1-linux-x64.tar.xz /data/app/node/
ADD node-v12.4.0-linux-x64.tar.xz /data/app/node/
ADD node-v10.23.0-linux-x64.tar.xz /data/app/node/
RUN ln -s /data/app/node/node-v14.17.1-linux-x64/ /data/app/node/node
ENV NODE_PATH=/data/app/node/data/node_global/node_modules
ENV PATH=/data/app/node/node/bin:$PATH
ENV PATH=/data/app/node/data/node_global/bin:$PATH
RUN mkdir -p /data/app/node/data/node_global && \
mkdir -p /data/app/node/data/node_cache && \
npm config set prefix "/data/app/node/data/node_global" && \
npm config set cache "/data/app/node/data/node_cache" && \
npm config set registry https://registry.npmmirror.com

# 安装docker-ce
ADD docker-ce.repo /etc/yum.repos.d/
RUN yum install docker-ce -y

# 配置 jenkins
ENV JENKINS_VERSION 2.403
WORKDIR /data/app/jenkins/
COPY jenkins-${JENKINS_VERSION}.war /data/app/jenkins/
ENV JENKINS_HOME /data/app/jenkins/data/
ENV JENKINS_SLAVE_AGENT_PORT 50000
COPY run.sh .
RUN chmod 755 run.sh
CMD ./run.sh
