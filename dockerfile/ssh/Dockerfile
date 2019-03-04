FROM centos:6
MAINTAINER zhangyage

ENV ROOT_PASSWORD 123456

RUN yum -y install openssh-server
RUN echo $ROOT_PASSWORD |passwd --stdin root

RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

CMD ["/usr/sbin/sshd","-D"]

EXPOSE 22
