FROM centos:6.8

LABEL maintainer="zhangyage2015@163.com"

COPY ./conf ./docker/lb/entrypoint.sh ./docker/lb/WELCOME /tmp/
RUN rm -f  /etc/yum.repos.d/* 
ADD ./docker/lb/Centos-6.repo  /etc/yum.repos.d/
RUN yum clean all 
RUN rm -f /etc/haproxy/*
RUN \

# install packages
    yum install  -y \
    vim inetutils-ping iproute2 curl rsyslog haproxy keepalived 
# syslog settings
#    sed -i 's/^\(module.*imklog.*\)/# \1/g' /etc/rsyslog.conf && \
RUN \
# cp stuff
    cp /tmp/entrypoint.sh / && \
    cp /tmp/WELCOME / && \
    mkdir /opt/ssl && cp -r /tmp/ssl/* /opt/ssl && \
    cp -r /tmp/samples/haproxy/* /etc/haproxy && \
    cp -r /tmp/samples/keepalived/* /etc/keepalived && \
# chmod
    chmod +x /entrypoint.sh 
# clean up
#    rm -r /tmp/*
#haproxy log
RUN echo "local3.*    /var/log/haproxy.log" >> /etc/rsyslog.conf
RUN echo "SYSLOGD_OPTIONS=\"-r -m 0\"" > /etc/sysconfig/rsyslog

EXPOSE 8080 8443 8090

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
