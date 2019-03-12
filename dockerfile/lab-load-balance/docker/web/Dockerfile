FROM centos

LABEL maintainer="zhangyage2015@163.com"

COPY ./conf ./docker/web/entrypoint.sh /tmp/
ADD ./source/nginx.1.8.0.tar.gz /tmp
ADD ./source/nginx_fair.tar.gz /tmp
ADD ./source/ngx_cache.tar.gz /tmp
#ADD ./docker/web/entrypoint.sh /tmp

RUN \
# install packages
    #yum update && \
    yum -y install gcc pcre-devel pcre openssl openssl-devel vim 
#install nginx
RUN useradd -s /sbin/nologin www
WORKDIR /tmp/nginx-1.8.0
RUN ./configure --prefix=/usr/local/nginx  --user=www --group=www --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module  --add-module=../ngx_cache_purge-2.3/  --add-module=../nginx-upstream-fair/  --with-http_realip_module
RUN make
RUN make install
# cp stuff
RUN    cp /tmp/entrypoint.sh / && \
      rm -rf /usr/local/nginx/conf/nginx.conf && \
      mkdir /usr/local/nginx/conf/csr 
RUN      mkdir -p /opt/nginx-cache/proxy_cache_dir && \
      mkdir /usr/local/nginx/conf/vhost
RUN    cp -r /tmp/samples/nginx/default.conf /usr/local/nginx/conf/vhost/ && \
       cp -r /tmp/samples/nginx/nginx.conf /usr/local/nginx/conf/ && \
    cp -r /tmp/ssl/*  /usr/local/nginx/conf/csr/
# chmod
RUN    chmod +x /entrypoint.sh 
RUN /usr/local/nginx/sbin/nginx -t
RUN /usr/local/nginx/sbin/nginx 
# clean up
#    rm -rf /tmp/*


ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 443

CMD ["/bin/bash"]
