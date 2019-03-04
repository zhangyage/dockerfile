FROM centos:6
MAINTAINER zhangyage

RUN yum -y install httpd php php-gd php-mysql mysql mysql-server

ENV MYSQL_ROOT_PASSWORD 123456

RUN echo "<?php phpinfo()?>" /var/www/html/index.php

ADD start.sh /start.sh
RUN chmod +x /start.sh

ADD https://cn.wordpress.org/wordpress-4.7.4-zh_CN.tar.gz /var/www/html
#COPY wp-config.php /var/www/html/wordpress

VOLUME ["/var/lib/mysql"]

CMD /start.sh

EXPOSE 80 3306
