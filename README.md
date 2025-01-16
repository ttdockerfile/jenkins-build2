# jenkins-build

当前仓库是对`jenkins`打进`docker`的仓库

我把各种需要用到的依赖打进去(有些依赖我只会在新分支更新)

- node
- java
- maven
- python3
- node(10、12、14、16)
- golang

在`docker hub`和阿里云的镜像站我都有上传我的自己用服务器打包的，直接下载即可(加上tag就可以下载到我对应的分支)

启动实例详见[setup.sh](setup.sh)和[setup-agent.sh](setup-agent.sh)

如果要覆盖启动脚本，可以详见

[run.sh](build/run.sh),覆盖方式`-v ./run.sh:/data/app/jenkins/run.sh \`

[run-agent.sh](build/run-agent.sh),覆盖方式`-v ./run-agent.sh:/data/app/jenkins/run-agent.sh \`

```shell
docker pull buyfakett/jenkins
```

```shell
docker pull registry.cn-hangzhou.aliyuncs.com/buyfakett/jenkins
```

### 支持

1. 【Star】他，让他看到你是爱他的；

2. 【Watching】他，时刻感知他的动态；

3. 【Fork】他，为他增加新功能，修Bug，让他更加卡哇伊；

4. 【Issue】他，告诉他有哪些小脾气，他会改的，手动小绵羊；

5. 【打赏】他，为他买jk；

### 贡献指南

在develop分支上修改或者新开一个分支

### 其他

觉得作者写的不错的话可以支持一下作者，请作者喝一杯咖啡哦~

| 微信                             | 支付宝                        |
| -------------------------------- | ----------------------------- |
| ![alipay](./pay_img/wechat.webp) | ![wechat](./pay_img/ali.webp) |