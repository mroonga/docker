FROM centos:centos6.6
MAINTAINER groonga

RUN yum upgrade -y
RUN yum install -y which
RUN rpm -ivh http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm
RUN rpm -ivh http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
RUN yum install --enablerepo=mysql56-community --disablerepo=mysql57-community -y mysql-community-client-5.6.27 mysql-community-server-5.6.27 
RUN yum install -y mysql-community-mroonga-5.09 groonga-5.0.9 groonga-tokenizer-mecab-5.0.9
COPY my.cnf /etc/my.cnf
RUN service mysqld start && mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION"

EXPOSE 3306
ENTRYPOINT /usr/sbin/mysqld --user=mysql
