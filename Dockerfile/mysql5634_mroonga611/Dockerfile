FROM centos:centos6.6
MAINTAINER groonga

RUN yum upgrade -y
RUN yum install -y which
RUN rpm -ihv http://packages.groonga.org/centos/groonga-release-1.2.0-1.noarch.rpm
RUN rpm -ihv http://dev.mysql.com/get/mysql57-community-release-el6-9.noarch.rpm
RUN yum install --enablerepo=mysql56-community --disablerepo=mysql57-community -y mysql-community-client-5.6.34 mysql-community-server-5.6.34 && yum clean all
RUN yum install -y mysql-community-mroonga-6.11 groonga-6.1.1 groonga-tokenizer-mecab-6.1.1 && yum clean all
COPY my.cnf /etc/my.cnf
RUN service mysqld start && mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
RUN rpm -q --scripts mysql-community-mroonga | sed -n '/^postinstall scriptlet/,/^[a-z][a-z]* scriptlet/p' | tail -n +2 | head -n -1 > /root/postinstall.sh
RUN rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
