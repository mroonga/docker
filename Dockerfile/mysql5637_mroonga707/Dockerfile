FROM centos:centos6.9
MAINTAINER groonga

RUN yum upgrade -y
RUN yum install -y which
RUN yum install -y http://packages.groonga.org/centos/groonga-release-1.3.0-1.noarch.rpm && yum clean all
RUN yum install -y http://dev.mysql.com/get/mysql57-community-release-el6-11.noarch.rpm && yum clean all
RUN yum install --enablerepo=mysql56-community --disablerepo=mysql57-community -y mysql-community-client-5.6.37 mysql-community-server-5.6.37 && yum clean all
RUN yum install -y mysql-community-mroonga-7.07 groonga-7.0.7 groonga-tokenizer-mecab-7.0.7 groonga-normalizer-mysql && yum clean all
COPY my.cnf /etc/my.cnf
RUN service mysqld start && mysql -e "GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION" && service mysqld stop
RUN rpm -q --scripts mysql-community-mroonga | sed -n '/^postinstall scriptlet/,/^[a-z][a-z]* scriptlet/p' | tail -n +2 | head -n -1 > /root/postinstall.sh
RUN rm /var/lib/mysql/auto.cnf /var/lib/mysql/groonga.log
COPY entrypoint.sh /root/entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
