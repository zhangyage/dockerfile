## 小张的基地
![banner](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/lab-load-balance/docs/images/banner.png)
## Prometheus+Grafana+cAdvisor
链接：https://pan.baidu.com/s/1E3xgY-kxvvH0ADfaGo1kew 
提取码：hkov 

## cAdvisor
cAdvisor 是 google 开发的容器监控工具,cAdvisor 会显示当前 host 的资源使用情况，包括 CPU、内存、网络、文件系统等。
```
# docker run --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8080:8080 --detach=true --name=cadvisor google/cadvisor:latest
```
浏览器验证测试：
![banner](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/lab-load-balance/docs/images/banner.png)

## 解压安装Prometheus
参考官网：
```
https://prometheus.io/
```
安装步骤
```
# tar -zxvf prometheus-2.8.0-rc.0.linux-amd64.tar.gz
# cd prometheus-2.8.0-rc.0.linux-amd64
# cp -a prometheus /usr/bin/
# cp -a promtool /usr/bin/
```
####grafana
```
# yum localinstall grafana-6.0.1-1.x86_64.rpm
# systemctl restart grafana-server
# netstat -anp | grep gra
```
