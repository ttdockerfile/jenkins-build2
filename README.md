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

```shell
docker pull buyfakett/jenkins
```

```shell
docker pull registry.cn-hangzhou.aliyuncs.com/buyfakett/jenkins
```

