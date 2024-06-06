FROM centos:7
USER root

WORKDIR /data/app/

COPY ./docker-ce.repo /etc/yum.repos.d/docker-ce-edge.repo
COPY ./daemon.json /etc/docker/daemon.json

# 安装docker
RUN yum install -y zip unzip && yum install -y docker-ce

# 配置svn
RUN yum install -y java-1.8.0-openjdk-devel.x86_64 && \
yum install -y git && \
yum install -y subversion && \
svn --version && \
sed -i 's/# store-passwords = no/store-passwords = yes/g' /root/.subversion/servers && \
sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /root/.subversion/servers && \
cp ~/.subversion/config ~/.subversion/config.bak && \
echo -e "[auth]\nstore-passwords = no\n[helpers]\n[tunnels]\n[miscellany]\n[auto-props]\n" > ~/.subversion/config

ENV JAVA_HOME=/usr/lib/jvm/java


# 指定node版本
ENV NODE_ENV=v14.17.1

# 配置MAVEN和node
ADD apache-maven-3.6.3-bin.zip /data/app/
ADD node-v12.4.0-linux-x64.tar.xz /data/app/
ADD node-v10.23.0-linux-x64.tar.xz /data/app/
ADD node-v14.17.1-linux-x64.tar.xz /data/app/
RUN jar xvf apache-maven-3.6.3-bin.zip && \
ln -s apache-maven-3.6.3/ /data/app/maven && \
chmod 755 /data/app/maven/bin/mvn && \
ln -s /data/app/node-${NODE_ENV}-linux-x64/ /data/app/node && \
rm -f apache-maven-3.6.3-bin.zip
ADD settings.xml /data/app/maven/conf/settings.xml
ENV PATH=/data/app/maven/bin:$PATH
ENV PATH=/data/app/node/bin:$PATH
ENV NODE_PATH=/data/app/node/node_global/node_modules

RUN mkdir -p /data/app/node/node_global && mkdir -p /data/app/node/node_cache
ENV PATH=/data/app/node/node_global/bin:$PATH

RUN npm config set prefix "/data/app/node/node_global" && \
npm config set cache "/data/app/node/node_cache" && \
npm config set registry https://registry.npm.taobao.org && \
npm i node-sass --sass_binary_site=https://npm.taobao.org/mirrors/node-sass/ -D && \
npm install -g cnpm --registry=https://registry.npm.taobao.org && \
cnpm config set prefix "/data/app/node/node_global" \
&& cnpm config set cache "/data/app/node/node_cache"

# 安装python3
COPY ./Python-3.7.0.tgz /tmp/
RUN yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make libffi-devel && \
cd /tmp/ && \
tar -zxvf Python-3.7.0.tgz && \
cd Python-3.7.0 && ./configure prefix=/usr/local/python3 && make && make install && \
rm -rf /usr/bin/python && \
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python && \
ln -s /usr/local/python3/bin/python3.7 /usr/bin/python3.7 && \
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3.7 && \
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip3 && \
rm -rf /usr/bin/pip && \
ln -s /usr/local/python3/bin/pip3.7 /usr/bin/pip && \
python -V && \
sed -i 's$/usr/bin/python$/usr/bin/python2$g' /usr/bin/yum && \
sed -i 's$/usr/bin/python$/usr/bin/python2$g' /usr/libexec/urlgrabber-ext-down

WORKDIR /data/app/jenkins/
COPY jenkins.war /data/app/jenkins/

# svn中文乱码
# localedef -v -c -f UTF-8 -i zh_CN C.utf8 && echo "LANG=C.UTF-8" >> /etc/locale.conf
RUN yum install kde-l10n-Chinese -y && \
yum install glibc-common -y && \
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
export LANG=zh_CN.UTF-8 && \
echo "LANG=C.UTF-8" >> /etc/locale.conf


# 配置jenkins
ENV JENKINS_HOME=/data/app/jenkins/data/
ENV JENKINS_SLAVE_AGENT_PORT=50000

CMD java -Duser.timezone=GMT+8 -Dfile.encoding=utf-8 -jar \
-server -Xmx256m -Xms256m -Xss256K \
jenkins.war --httpPort=8080
