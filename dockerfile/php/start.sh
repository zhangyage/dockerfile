service httpd start
service mysqld start

mysqladmin -uroot password $MYSQL_ROOT_PASSWORD
tail -f
