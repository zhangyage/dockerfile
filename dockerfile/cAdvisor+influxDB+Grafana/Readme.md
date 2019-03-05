#下载镜像

[root@node3 ~]# docker pull tutum/influxdb
Using default tag: latest
Trying to pull repository docker.io/tutum/influxdb ...
latest: Pulling from docker.io/tutum/influxdb
a3ed95caeb02: Pull complete
23efb549476f: Pull complete
aa2f8df21433: Pull complete
ef072d3c9b41: Pull complete
c9f371853f28: Pull complete
a248b0871c3c: Pull complete
749db6d368d0: Pull complete
db2492acfcc3: Pull complete
b7e7d2e12d53: Pull complete
4272a53eef10: Pull complete
9b2fefdb5321: Pull complete
Digest: sha256:5b7c5e318303ad059f3d1a73d084c12cb39ae4f35f7391b79b0ff2c0ba45304b
Status: Downloaded newer image for docker.io/tutum/influxdb:latest

#运行influxdb容器

[root@node3 ~]# docker run -d -p 8083:8083 -p 8086:8086 --name influxdb tutum/influxdb
362440d2a102710b5ccbe1cf30433e4467066ab31422de092ce4c764e44c2114

![influxdb数据配置](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/cAdvisor%2BinfluxDB%2BGrafana/influxDB.png)

#创建用户名和密码，数据库都是cAdvisor

#获取容器镜像

[root@node3 cAdvisor+influxDB+Grafana]# docker pull google/cadvisor
Using default tag: latest
Trying to pull repository docker.io/google/cadvisor ... 
latest: Pulling from docker.io/google/cadvisor
ff3a5c916c92: Pull complete 
44a45bb65cdf: Pull complete 
0bbe1a2fe2a6: Pull complete 
Digest: sha256:815386ebbe9a3490f38785ab11bda34ec8dacf4634af77b8912832d4f85dca04
Status: Downloaded newer image for docker.io/google/cadvisor:latest
#运行

[root@node3 cAdvisor+influxDB+Grafana]# docker run -d \
> --volume=/:/rootfs:ro \
> --volume=/var/run:/var/run:rw \
> --volume=/sys:/sys:ro \
> --volume=/var/lib/docker/:/var/lib/docker:ro \
> --link influxdb:influxdb \
>  -p 8081:8080 \
> --name=cadvisor \
> google/cadvisor \
> --storage_driver=influxdb \
> --storage_driver_db=cAdvisor \
> --storage_driver_host=influxdb:8086
992958c1035eda7ffa65147ca07b8a569d73f78335340a410ca1702f379adb53

[root@node3 ]# docker run -d --volume=/:/rootfs:ro --volume=/var/run:/var/run:rw --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --link influxdb:influxdb  -p 8081:8080 --name=cadvisor google/cadvisor --storage_driver=influxdb --storage_driver_db=cAdvisor --storage_driver_host=influxdb:8086

#启动报错：

W0305 13:48:21.200292       1 manager.go:349] Could not configure a source for OOM detection, disabling OOM events: open /dev/kmsg: no such file or directory

F0305 13:48:21.254704       1 cadvisor.go:172] Failed to start container manager: inotify_add_watch /sys/fs/cgroup/cpuacct,cpu: no such file or directory

#解决方法

[root@node3 ]# mount -o remount,rw '/sys/fs/cgroup'
[root@node3 ]# ln -s /sys/fs/cgroup/cpu,cpuacct /sys/fs/cgroup/cpuacct,cpu

#再次启动容器：

![cAdvisor图表](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/cAdvisor%2BinfluxDB%2BGrafana/cAdvisor.png)
#访问测试

#下载容器

[root@node3 cAdvisor+influxDB+Grafana]# docker pull grafana/grafana
Using default tag: latest
Trying to pull repository docker.io/grafana/grafana ... 
latest: Pulling from docker.io/grafana/grafana
6ae821421a7d: Already exists 
6f1f7859419b: Pull complete 
f468bc355c1c: Pull complete 
9f5203ca6afb: Pull complete 
1ae79fd57b87: Pull complete 
d0bc3461ab2a: Pull complete 
Digest: sha256:87dc722ba3f898b4c390a1af3139f061e813c2b11f303a6bd96690f667e48a88
Status: Downloaded newer image for docker.io/grafana/grafana:latest

#启动容器：

[root@node3 cAdvisor+influxDB+Grafana]# docker run -d -p 3000:3000 -e INFLUXDB_HOST=localhost -e INFLUXDB_PORT=8086 -e INFLUXDB_NAME=cAdvisor -e INFLUXDB_USER=cAdvisor -e INFLUXDB_PASS=cAdvisor --link influxdb:influxdb --name grafana grafana/grafana:latest
33f8d5f7ce3686620ad07472629a464e8633febb5695dd411725d61995e1d632

#配置数据源和图表

![配置数据源和图表](https://github.com/zhangyage/dockerfile/blob/master/dockerfile/cAdvisor%2BinfluxDB%2BGrafana/Grafana.png)

