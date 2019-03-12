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
![banner](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/cadvisor.png)

## 解压安装Prometheus
参考官网：
```
https://prometheus.io/
```
![prometheus](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/prometheus-jg.png)
安装步骤
```
# tar -zxvf prometheus-2.8.0-rc.0.linux-amd64.tar.gz
# cd prometheus-2.8.0-rc.0.linux-amd64
# cp -a prometheus /usr/bin/
# cp -a promtool /usr/bin/
```

修改配置文件：
```
[root@node3 prometheus]# cat prometheus.yml 
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  #设置每隔多少秒去拉取一下数据
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['192.168.32.138:9090']
  - job_name: 'docker'
    static_configs:
    - targets: ['192.168.32.138:8080']
```
##### 注意：- targets: ['192.168.32.138:8080']  当有多个docker宿主机的话，在宿主机中启动cadvisor后在这个配置中添加，如下：
```
- targets: ['192.168.32.138:8080','192.168.32.137:8080']
```
如上就可以监控两个docker主机了

### 启动prometheus
```
prometheus --config.file=/root/Prometheus+Grafana+cAdvisor/prometheus-2.8.0-rc.0.linux-amd64/prometheus.yml
```
制定对应的配置文件
访问测试
![prometheus](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/prometheus.png)

### grafana
```
# yum localinstall grafana-6.0.1-1.x86_64.rpm
# systemctl restart grafana-server
# netstat -anp | grep gra
```
浏览器访问：
http://ip:3000
![grafana2](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/grafana2.png)
![grafana2](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/grafana3.png)
![grafana2](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/Prometheus%2BGrafana%2BcAdvisor/image/grafana4.png)
总体步骤：登录--》修改密码--》链接数据库(prometheus)--》设置dashbosrd(导入模板)--》数据展示
