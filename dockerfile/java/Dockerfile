FROM centos:6
MAINTAINER zhangyage

ADD jdk1.8.0_111.tar.gz /usr/local

ENV JAVA_HOME /usr/local/jdk1.8.0_111

ADD apache-tomcat-8.5.33.tar.gz /usr/local

WORKDIR /usr/local/apache-tomcat-8.5.33
ENTRYPOINT ["bin/catalina.sh","run"]

EXPOSE 8080
